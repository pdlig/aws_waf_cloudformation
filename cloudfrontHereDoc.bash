#!/bin/bash

count=1
counter=0

while read -r line
do
formatCount=$(printf '%0.3d\n' $count)
formatCount2=$(printf '%0.3d\n' $counter)
	cat << CLOUDFORMATION_RESOURCES >> CloudFormationOutput.yml

  WebACLAssociation$formatCount:
    Type: 'AWS::WAFv2::WebACLAssociation'
    Properties:
      ResourceArn: $line
      WebACLArn: !GetAtt 
        - webAcl
        - Arn
    DependsOn: WebACLAssociation$formatCount2

CLOUDFORMATION_RESOURCES

((count++))
((counter++))

done < playgroundApiGateways.txt

