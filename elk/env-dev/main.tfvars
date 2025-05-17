env             ="dev"
vpc_name        =""
subnet_name     =""
ami_id          =""
zone_id         =""
# fill details



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