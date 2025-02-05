provider "aws" {
 region  = "${var.aws_region}"
 profile = "{var.aws_profile}"
}

##Profile_Creation
resource "aws_iam_instance_profile" "s3_access_profile" {
name  =  "s3_access"
role  =  "${aws_iam_role.s3_access_role.name}"
}

##Policy_Creation
resource "aws_iam_role_policy" "s3_access_profile" {
name  =  "s3_access_policy"
role  =  "${aws_iam_role.s3_access_role.id}"

policy  =  <<EOF
{
 "Version" :  "2012-10-17",
 "Statement"  :  [
  {
        "Effect"  :  "Allow",
        "Action"  :  "s3:*",
        "Resource" : "*"
  }
]
}
EOF
}

##Role_Creation
resource "aws_iam_role" "s3_access_role"  {
name =  "s3_access_role"
assume_role_policy  =   <<EOF
{
 "Version": "2012-10-17",
  "Statement"  :  [
  {
        "Action" : "sts_AssumeRole",
        "Principal" : {
          "Service"  : "ec2.amazonaws.com"
  },
        "Effect"  :  "Allow",
        "Sid"  :  ""
  }
 ]
}
EOF
}

