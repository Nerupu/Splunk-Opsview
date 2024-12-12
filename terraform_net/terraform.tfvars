tags = {
  product   = "opsview"
  terraform = "true"
  project   = "EAF"
}

prefix = "eaf"


private_subnet_tags = {
  private  = "true"
  tier     = "tier1"
  resource = "subnet"
}

intra_subnet_tags = {
  private  = "true"
  tier     = "tier2"
  resource = "subnet"
}
database_subnet_group_tags = {
  logical-id = "DatabaseSubnetGroup"
  Name       = "EAF-Database-Subnet-Group"
  owner      = "product-team"
  Project    = "EAF Opsview"
}

database_subnet_tags = {
  private     = "false"
  tier        = "tier1"
  resource    = "subnet"
  application = "database"
}


ssm_policy = [
  "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
  "arn:aws:iam::aws:policy/AmazonSSMDirectoryServiceAccess",
  "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy",
  "arn:aws:iam::aws:policy/AmazonS3FullAccess"

]

azs_list         = ["a", "b"]
privt_netmask    = 4
database_netmask = 4
intra_netmask    = 4
# other_netmask = 4
private_num  = 2
database_num = 2
intra_num    = 2

#=================security groups tfvars=====================

security_groups = {
  eaf_aws_serv_sec_grp = {
    name        = "eaf-aws-serv-sec-grp-sg"
    description = "SG for Opsview aws-services-security-group"
    ingress_rules = [
      {
        description     = "AWS Services Security Group 1"
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["100.110.9.96/28"]
        security_groups = []
      },
      {
        description     = "AWS Services Security Group 2"
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["100.110.9.80/28"]
        security_groups = []
      },
      {
        description     = "AWS Services Security Group 3"
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["100.110.9.64/28"]
        security_groups = []
      },
    ]
  },
  eaf_external_sg = {
    name        = "eaf-ext-sg"
    description = "SG for OpsView External"
    ingress_rules = [
      {
        description     = "Another Rule 1"
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["192.168.2.0/24"]
        security_groups = []
      },
      {
        description     = "Another Rule 2"
        from_port       = 8080
        to_port         = 8080
        protocol        = "tcp"
        cidr_blocks     = ["10.0.1.0/24"]
        security_groups = []
      },
    ]
  },
  eaf_jumpbox_sg = {
    name        = "eaf-jmpbx-sg"
    description = "SG for OpsView Jumpbox"
    ingress_rules = [
      {
        description     = "Allow traffic "
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
    ]
  }
  eaf_pri_inflx_db_sg = {
    name        = "eaf_pri_inflx_db_sg"
    description = "SG for OpsView Primary-Influx-Database"
    ingress_rules = [{
      description     = "Primary Influx Database"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      },
      {
        description     = "Secondary Orchestrator port 12378"
        from_port       = 12378
        to_port         = 12378
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []

      },
      {
        description     = "Secondary Orchestrator port 45673"
        from_port       = 9096
        to_port         = 9096
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []

      },
      {
        description     = "Secondary Orchestrator port 15985"
        from_port       = 15985
        to_port         = 15985
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []

      },
      {
        description     = "Secondary Orchestrator port 5666"
        from_port       = 5666
        to_port         = 5666
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []

      },
      {
        description     = "Secondary Orchestrator port 11601"
        from_port       = 11601
        to_port         = 11601
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []

      },
      {
        description     = "Secondary Orchestrator port 35673"
        from_port       = 35673
        to_port         = 35673
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []

      },
      {
        description     = "Secondary influx Database port SSH / 22"
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []

      },
      #   {
      #     description = "Primary influx Database port SSH / 8086"
      #     from_port   = 0
      #     to_port     = 0
      #     protocol    = "-1"
      #     cidr_blocks = ["0.0.0.0/0"]
      #     security_groups = []

      #   },
      #   {
      #     description = "Allow all ingress within VPC"
      #     from_port   = 0
      #     to_port     = 0
      #     protocol    = "-1"
      #     cidr_blocks = [] #module.ipam_vpc.vpc_cidr_block
      #     security_groups = []

      # }
    ]
  }
  eaf_pri_orc_sg = {
    name        = "eaf_pri_orc_sg"
    description = "SG for OpsView eaf_primary_orc_sg"
    ingress_rules = [{
      description     = "Secondary Iflux Database allow port number 5666"
      from_port       = 5666
      to_port         = 5666
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      },
      {
        description     = "Secondary Iflux Database allow port number 15985"
        from_port       = 15985
        to_port         = 15985
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
      {
        description     = "Secondary Iflux Database allow port number 35673"
        from_port       = 35673
        to_port         = 35673
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
      {
        description     = "Secondary Iflux Database allow port number 12378"
        from_port       = 12378
        to_port         = 12378
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
      {
        description     = "Secondary Iflux Database allow port number 45673"
        from_port       = 45673
        to_port         = 45673
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
      {
        description     = "Secondary Iflux Database allow port number 11601"
        from_port       = 11601
        to_port         = 11601
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
      {
        description     = "Secondary Orchestrator allow port number 22 / SSH"
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
      {
        description     = "Primary Orchestrator allow All port"
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
      {
        description     = "External allow port number 443"
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
    ]
  }
  eaf-rds-db-sg = {
    name        = "eaf-rds-db-sg"
    description = "SG for RDS Database"
    ingress_rules = [{
      description     = "Secondary Orchestrator"
      from_port       = 5666
      to_port         = 5666
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      },
      {
        description     = "RDS Database"
        from_port       = 0
        to_port         = 0
        protocol        = "-1"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
      {
        description     = "Jumpbox"
        from_port       = 22
        to_port         = 22
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },
      {
        description     = "Secondary Influx Database"
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
        security_groups = []
      },

    ]
  }
  eaf_sec_inflx_db_sg = {
    name        = "eaf_sec_inflx_db_sg"
    description = "SG for OpsView Secondary-Influx-DataBase"
    ingress_rules = [{
      description     = "Allow all traffic from secondary influx database"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Allow traffic from port 9096 on Secondary orchestrator "
      from_port       = 9096
      to_port         = 9096
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Allow traffic from port 15985 on secondary orchestrator"
      from_port       = 15985
      to_port         = 15985
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Allow traffic from port 12378 on secondary orchestrator"
      from_port       = 12378
      to_port         = 12378
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Allow traffic from port 22 SSH on Primary Influx Database "
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Allow traffic from port 8086  on Primary Influx Database "
      from_port       = 8086
      to_port         = 8086
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Allow traffic from port 5666  on Primary Influx Database "
      from_port       = 5666
      to_port         = 5666
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Allow traffic from port 11601 on secondary orchestrator"
      from_port       = 11601
      to_port         = 11601
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Allow traffic from port 45673 on secondary orchestrator"
      from_port       = 45673
      to_port         = 45673
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Allow traffic from port 35673 on secondary orchestrator"
      from_port       = 35673
      to_port         = 35673
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
    }]
  }
  eaf_sec_orch_sg = {
    name        = "eaf_sec_orch_sg"
    description = "SG for Opsview Secondary-Orchestrator"
    ingress_rules = [{
      description     = "Secondary Orchestrator allow all traffic "
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Primary Orchestrator Allow SSH / 22 "
      from_port       = 22
      to_port         = 22
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "External Port 443 / https "
      from_port       = 443
      to_port         = 443
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Secondary Iflux Database allow port number 45673 "
      from_port       = 45673
      to_port         = 45673
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Secondary Iflux Database allow port number 15985 "
      from_port       = 15985
      to_port         = 15985
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Secondary Iflux Database allow port number 35673 "
      from_port       = 35673
      to_port         = 35673
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Secondary Iflux Database allow port number 11601 "
      from_port       = 11601
      to_port         = 11601
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Secondary Iflux Database allow port number 12378 "
      from_port       = 12378
      to_port         = 12378
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Secondary Iflux Database allow port number 5666 "
      from_port       = 5666
      to_port         = 5666
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      },
    ]
  }
  eaf_stp_stone_sg = {
    name        = "eaf-step-stone-sg"
    description = "SG for step-stone"
    ingress_rules = [{
      description     = "Secondary Orchestrator allow TCP Port 5666"
      from_port       = 5666
      to_port         = 5666
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Aloow alll from stepping stone subnet"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      }, {
      description     = "Allow SSH / 22  Port from Jumpbox"
      from_port       = 8088
      to_port         = 8088
      protocol        = "tcp"
      cidr_blocks     = ["0.0.0.0/0"]
      security_groups = []
      },

    ]
  }
}

egress_rules = [
  {
    description = "Allow all IP and Ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  },
]

# tags = {
#   "Environment" = "Production"
# }

sg_tags = {
  private  = "false"
  tier     = "public"
  resource = "securitygroup"
}
#=======================aws_security_group.eaf_external_sg======================

