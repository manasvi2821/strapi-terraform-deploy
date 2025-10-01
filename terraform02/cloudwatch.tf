# Logs
resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.service_name}"
  retention_in_days = 7
}


resource "aws_cloudwatch_dashboard" "ecs_strapi_dashboard" {
  dashboard_name = "manasvi-ecs-strapi-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type = "metric"
        x    = 0
        y    = 0
        width = 12
        height = 6
        properties = {
          metrics = [
            ["ECS/ContainerInsights", "CpuUtilized", "ClusterName", aws_ecs_cluster.cluster.name, "ServiceName", aws_ecs_service.service.name],
            ["ECS/ContainerInsights", "MemoryUtilized", "ClusterName", aws_ecs_cluster.cluster.name, "ServiceName", aws_ecs_service.service.name],
            ["ECS/ContainerInsights", "NetworkRxBytes", "ClusterName", aws_ecs_cluster.cluster.name, "ServiceName", aws_ecs_service.service.name],
            ["ECS/ContainerInsights", "NetworkTxBytes", "ClusterName", aws_ecs_cluster.cluster.name, "ServiceName", aws_ecs_service.service.name]
          ]
          view = "timeSeries"
          stacked = false
          region = var.aws_region
          title  = "ECS Strapi Metrics"
        }
      }
    ]
  })
}

resource "aws_cloudwatch_metric_alarm" "ecs_high_cpu" {
  alarm_name          = "manasvi-ecs-strapi-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = 60
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Alarm when ECS service CPU usage is high"
  dimensions = {
    ClusterName = aws_ecs_cluster.cluster.name
    ServiceName = aws_ecs_service.service.name
  }
}
