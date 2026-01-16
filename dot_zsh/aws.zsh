if command -v aws &> /dev/null; then
  # default
  export AWS_PROFILE="${AWS_PROFILE:-default}"
  export AWS_DEFAULT_REGION="$(aws configure get region 2>/dev/null)"

  # lightsail Container Status
  lsc-status() {
    aws lightsail get-container-services \
      --service-name "$1" \
      --query "containerServices[0].{State:state,Deploy:currentDeployment.state,Version:currentDeployment.version}" \
      --output table
  }

  # AWS profile selector
  aws-switch() {
    local profile="${1:-$(aws configure list-profiles | fzf --prompt='AWS Profile> ')}"
    if [ -n "$profile" ]; then
      export AWS_PROFILE="$profile"
      export AWS_DEFAULT_REGION="$(aws configure get region --profile "$profile" 2>/dev/null)"
      echo "→ $AWS_PROFILE ($AWS_DEFAULT_REGION)"
    fi
  }
  _aws_profiles() { compadd $(aws configure list-profiles 2>/dev/null) }
  compdef _aws_profiles aws-switch
fi
