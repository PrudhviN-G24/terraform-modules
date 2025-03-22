# IAM Role for EKS Cluster
resource "aws_iam_role" "cluster" {
  name = "${var.cluster_name}-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# IAM Role for Node Group
resource "aws_iam_role" "nodegroup" {
  count = var.enable_node_group ? 1 : 0
  name  = "${var.cluster_name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "node_AmazonEKSWorkerNodePolicy" {
  count      = var.enable_node_group ? 1 : 0
  role       = aws_iam_role.nodegroup[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "node_CNI" {
  count      = var.enable_node_group ? 1 : 0
  role       = aws_iam_role.nodegroup[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "node_ContainerRegistry" {
  count      = var.enable_node_group ? 1 : 0
  role       = aws_iam_role.nodegroup[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Optional: Fargate Pod Execution Role
resource "aws_iam_role" "fargate" {
  count = var.enable_fargate ? 1 : 0
  name  = "${var.cluster_name}-fargate-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "fargate_exec" {
  count      = var.enable_fargate ? 1 : 0
  role       = aws_iam_role.fargate[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
}

resource "aws_ec2_tag" "vpc_tag" {
  resource_id = var.vpc_id
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "shared"
}

resource "aws_ec2_tag" "subnet_tags" {
  for_each = toset(var.subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "shared"
}


# EKS Cluster
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  tags = var.tags

  depends_on = [
    aws_iam_role.cluster,
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
    aws_ec2_tag.vpc_tag,
    aws_ec2_tag.subnet_tags
  ]
}

# Optional EC2 Node Group
resource "aws_eks_node_group" "this" {
  count             = var.enable_node_group ? 1 : 0
  cluster_name      = aws_eks_cluster.this.name
  node_group_name   = var.node_group_name
  node_role_arn     = aws_iam_role.nodegroup[0].arn
  subnet_ids        = var.subnet_ids
  instance_types    = var.instance_types
  disk_size         = 20

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }


  tags = merge(var.tags, {
    "eks/nodegroup" = var.node_group_name
  })
  
  depends_on = [aws_eks_cluster.this]


}



# Optional Fargate Profile
resource "aws_eks_fargate_profile" "this" {
  count                   = var.enable_fargate ? 1 : 0
  cluster_name            = aws_eks_cluster.this.name
  fargate_profile_name    = "${var.cluster_name}-fargate"
  pod_execution_role_arn  = aws_iam_role.fargate[0].arn
  subnet_ids              = var.subnet_ids

  dynamic "selector" {
    for_each = var.fargate_selectors
    content {
      namespace = selector.value.namespace
      labels    = lookup(selector.value, "labels", null)
    }
  }

  tags = var.tags


  depends_on = [aws_eks_cluster.this]


}

# EKS Add-ons (vpc-cni, coredns, kube-proxy, etc.)
resource "aws_eks_addon" "addons" {
  for_each                    = var.addons
  cluster_name                = aws_eks_cluster.this.name
  addon_name                  = each.key
  addon_version               = lookup(each.value, "addon_version", null)
  resolve_conflicts_on_create = each.value.resolve_conflicts_on_create
  resolve_conflicts_on_update = each.value.resolve_conflicts_on_update
  service_account_role_arn    = lookup(each.value, "service_account_role_arn", null)
}
