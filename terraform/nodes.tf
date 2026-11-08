# EKS 1.37用 Amazon Linux 2023 AMI
data "aws_ssm_parameter" "eks_ami" {
  name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.main.version}/amazon-linux-2023/x86_64/standard/recommended/image_id"
}

resource "aws_iam_instance_profile" "eks_node" {
  name = "AmazonEKSNodeRole"
  role = aws_iam_role.eks_node_role.name
}

locals {
  node_user_data = <<-EOT
    MIME-Version: 1.0
    Content-Type: multipart/mixed; boundary="//"

    --//
    Content-Type: application/node.eks.aws

    ---
    apiVersion: node.eks.aws/v1alpha1
    kind: NodeConfig
    spec:
      cluster:
        name: ${aws_eks_cluster.main.name}
        apiServerEndpoint: ${aws_eks_cluster.main.endpoint}
        certificateAuthority: ${aws_eks_cluster.main.certificate_authority[0].data}
        cidr: ${aws_eks_cluster.main.kubernetes_network_config[0].service_ipv4_cidr}

    --//--
  EOT
}

resource "aws_instance" "eks_node" {
  count = 2

  ami                  = data.aws_ssm_parameter.eks_ami.value
  instance_type        = "t3.small"
  subnet_id            = aws_subnet.public[count.index].id
  iam_instance_profile = aws_iam_instance_profile.eks_node.name

  vpc_security_group_ids = [
    aws_eks_cluster.main.vpc_config[0].cluster_security_group_id
  ]

  user_data = local.node_user_data

  # KodeKloudのルール：T系はStandardモード必須
  credit_specification {
    cpu_credits = "standard"
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 20
  }

  depends_on = [
    aws_eks_access_entry.eks_node
  ]

  tags = {
    Name = "${local.project_name}-node-${count.index + 1}"

    "kubernetes.io/cluster/${local.project_name}" = "owned"
  }
}