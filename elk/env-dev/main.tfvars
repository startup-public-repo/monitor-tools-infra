env             ="dev"
vpc_name        ="default_vpc_south2"
subnet_name     ="default-ap-south-2c"
ami_id          ="ami-0e86c549c4c958e98"
zone_id         ="Z02556032JV56RSCGA16T"



ec2_instance={
    elk={
        instance_type ="r6i.large"
        volume_size   =30
        policy_name=["AmazonEC2FullAccess","AmazonSSMFullAccess","AmazonS3ReadOnlyAccess"]
        server_port={
                ssh={
                    port="22"
                }
                  elastic_search={
                    port="9200"
                }
                 http={
                    port="80"
                }
                 https={
                    port="443"
                }
                  kibana={
                    port="5601"
                }
                   logstash={
                    port="9600"
                }
                     beats={
                    port="5044"
                }
                    tcp_input={
                    port="5000"
                }
                    tool_input={
                    port="9300"
                }
            }
    }
}