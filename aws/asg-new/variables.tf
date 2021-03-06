# ----------------------------------------------------------------------------------------------------------------------
# VARIÁVEIS OBRIGATÓRIAS
# ----------------------------------------------------------------------------------------------------------------------

# Autoscaling group
variable "max_size" {
  description = "Capacidade máxima do auto scale group"
  type        = number
}

variable "min_size" {
  description = "Capacidade mínima do auto scale group"
  type        = number
}

variable "desired_capacity" {
  description = "Quantidade de instâncias que devem estar executando no auto scaling group"
  type        = number
}

variable "name" {
  description = "Creates a unique name beginning with the specified prefix"
  type        = string
}

variable "vpc_zone_identifier" {
  description = "Uma lista dos ids das subnet que as instâncias serão criadas"
  type        = list(string)
}

variable "health_check_type" {
  description = "Controla como o health check será feito. Valores permitidos são EC2 e ELB."
  type        = string
}

variable "name_prefix_lc" {
  description = "Um prefixo para o nome do launch configuration"
  type        = string
}

# ----------------------------------------------------------------------------------------------------------------------
# VARIÁVEIS OPCIONAIS
# ----------------------------------------------------------------------------------------------------------------------

variable "create_lc" {
  description = "Se será criado o launch configuration"
  type        = bool
  default     = true
}

variable "launch_configuration" {
  description = "Nome do launch configuration (se caso ele for criado fora desse módulo)"
  type        = string
  default     = ""
}

# Launch configuration
variable "image_id" {
  description = "The EC2 image ID to launch"
  type        = string
  default     = ""
}

variable "instance_type" {
  description = "The size of instance to launch"
  type        = string
  default     = ""
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to associate with launched instances"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Nome da chave que será utilizada para acessar a instância"
  type        = string
  default     = ""
}

variable "security_groups" {
  description = "A list of security group IDs to assign to the launch configuration"
  type        = list(string)
  default     = []
}

variable "associate_public_ip_address" {
  description = "Associate a public ip address with an instance in a VPC"
  type        = bool
  default     = false
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = " "
}

variable "enable_monitoring" {
  description = "Enables/disables detailed monitoring. This is enabled by default."
  type        = bool
  default     = true
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  type        = bool
  default     = false
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance"
  type        = list(map(string))
  default     = []
}

variable "ebs_block_device" {
  description = "Additional EBS block devices to attach to the instance"
  type        = list(map(string))
  default     = []
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral (also known as 'Instance Store') volumes on the instance"
  type        = list(map(string))
  default     = []
}

variable "spot_price" {
  description = "The price to use for reserving spot instances"
  type        = string
  default     = ""
}

variable "placement_tenancy" {
  description = "The tenancy of the instance. Valid values are 'default' or 'dedicated'"
  type        = string
  default     = "default"
}

variable "default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  type        = number
  default     = 300
}

variable "health_check_grace_period" {
  description = "Tempo (em segundos) após a instância entrar em serviço antes de verificar a integridade da mesma (health check)"
  type        = number
  default     = 300
}

variable "force_delete" {
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  type        = bool
  default     = false
}

variable "load_balancers" {
  description = "Uma lista de nomes de load balancer para serem adicionados ao ASG"
  type        = list(string)
  default     = []
}

variable "target_group_arns" {
  description = "Uma lista de ARN de target groups, para ser utilizado com ALB"
  type        = list(string)
  default     = []
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are OldestInstance, NewestInstance, OldestLaunchConfiguration, ClosestToNextInstanceHour, Default"
  type        = list(string)
  default     = ["Default"]
}

variable "suspended_processes" {
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are Launch, Terminate, HealthCheck, ReplaceUnhealthy, AZRebalance, AlarmNotification, ScheduledActions, AddToLoadBalancer. Note that if you suspend either the Launch or Terminate process types, it can prevent your autoscaling group from functioning properly."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A list of tag blocks. Each element should have keys named key, value, and propagate_at_launch."
  type        = list(map(string))
  default     = []
}

variable "tags_as_map" {
  description = "A map of tags and values in the same format as other resources accept. This will be converted into the non-standard format that the aws_autoscaling_group requires."
  type        = map(string)
  default     = {}
}

variable "placement_group" {
  description = "The name of the placement group into which you'll launch your instances, if any"
  type        = string
  default     = ""
}

variable "metrics_granularity" {
  description = "The granularity to associate with the metrics to collect. The only valid value is 1Minute"
  type        = string
  default     = "1Minute"
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are GroupMinSize, GroupMaxSize, GroupDesiredCapacity, GroupInServiceInstances, GroupPendingInstances, GroupStandbyInstances, GroupTerminatingInstances, GroupTotalInstances"
  type        = list(string)
  default = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances",
  ]
}

variable "wait_for_capacity_timeout" {
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. (See also Waiting for Capacity below.) Setting this to '0' causes Terraform to skip all Capacity Waiting behavior."
  type        = string
  default     = "10m"
}

variable "min_elb_capacity" {
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  type        = number
  default     = 0
}

variable "wait_for_elb_capacity" {
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over min_elb_capacity behavior."
  type        = number
  default     = null
}

variable "protect_from_scale_in" {
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for termination during scale in events."
  type        = bool
  default     = false
}
