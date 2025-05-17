env             ="dev"
vpc_name        =""
subnet_name     =""
ami_id          =""
zone_id         =""
# fill details



ec2_instance={
    grafana={
        instance_type ="t3.large"
        volume_size   =30
        policy_name=["AmazonEC2FullAccess","AmazonSSMFullAccess","AmazonS3ReadOnlyAccess"]
        server_port={
                ssh={
                    port="22"
                }
                  grafana={
                    port="3000"
                }
                 http={
                    port="80"
                }
                 https={
                    port="443"
                }
            }
    }
}