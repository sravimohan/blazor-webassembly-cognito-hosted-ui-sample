#!/bin/bash -x

aws cloudformation deploy \
    --stack-name blazor-demo-cognito \
    --template-file cognito-stack.yml
