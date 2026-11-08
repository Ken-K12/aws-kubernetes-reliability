resource "aws_eks_cluster" "main" {
  name     = local.project_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  vpc_config {
    subnet_ids = aws_subnet.public[*].id
  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  depends_on = [aws_iam_role_policy_attachment.eks_cluster_role_attachment]

  tags = {
    Name = local.project_name
  }
}

# Self-managed Worker Node authentication
resource "aws_eks_access_entry" "eks_node" {
  cluster_name  = aws_eks_cluster.main.name
  principal_arn = aws_iam_role.eks_node_role.arn
  type          = "EC2_LINUX"
}


