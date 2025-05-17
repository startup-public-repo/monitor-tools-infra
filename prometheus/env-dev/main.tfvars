env             ="dev"
vpc_name        =""
subnet_name     =""
ami_id          =""
zone_id         =""
# fill required details



ec2_instance={
    prometheus={
        instance_type ="t3.large"
        volume_size   =30
        policy_name=["AmazonEC2FullAccess","AmazonSSMFullAccess","AmazonS3ReadOnlyAccess"]
        server_port={
                ssh={
                    port="22"
                }
                  prometheus={
                    port="9090"
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