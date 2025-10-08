# ===========================
# CodeDeploy Application
# ===========================
resource "aws_codedeploy_app" "ecs" {
  name             = "manasvi-strapi-deploy-app"
  compute_platform = "ECS"
}




# ===========================
# CodeDeploy Deployment Group
# ===========================
resource "aws_codedeploy_deployment_group" "ecs" {
  app_name              = aws_codedeploy_app.ecs.name
  deployment_group_name = "manasvi-strapi-blue-green"
  service_role_arn      = "arn:aws:iam::145065858967:role/manasvi-codedeploy-role"

  deployment_style {
  deployment_type = "BLUE_GREEN"
  deployment_option = "WITH_TRAFFIC_CONTROL"
  }

  deployment_config_name = "CodeDeployDefault.ECSAllAtOnce"

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  ecs_service {
    cluster_name = aws_ecs_cluster.cluster.name
    service_name = aws_ecs_service.service.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [ aws_lb_listener.http.arn ]
      }

      target_group {
        name = aws_lb_target_group.blue.name
      }

      target_group {
        name = aws_lb_target_group.green.name
      }
    }
  }

  blue_green_deployment_config {
  terminate_blue_instances_on_deployment_success {
    action                           = "TERMINATE"
    termination_wait_time_in_minutes = 5
  }

  deployment_ready_option {
    action_on_timeout = "CONTINUE_DEPLOYMENT"
  }
}
}

 

