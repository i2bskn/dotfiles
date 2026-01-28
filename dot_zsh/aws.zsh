if command -v aws &> /dev/null; then
  # default
  export AWS_PROFILE="${AWS_PROFILE:-default}"
  export AWS_DEFAULT_REGION="$(aws configure get region 2>/dev/null)"

  # lightsail Container Status
  lsc-status() {
    if command -v jq &> /dev/null; then
      local result
      result=$(aws lightsail get-container-services \
        --service-name "$1" \
        --query "containerServices[0].{State:state,Deploy:currentDeployment.state,Version:currentDeployment.version,DeployedAt:currentDeployment.createdAt}" \
        --output json) || return 1

      local state deploy version deployed_at
      state=$(echo "$result" | jq -r '.State')
      deploy=$(echo "$result" | jq -r '.Deploy')
      version=$(echo "$result" | jq -r '.Version')
      deployed_at=$(date -j -f "%Y-%m-%dT%H:%M:%S" "$(echo "$result" | jq -r '.DeployedAt' | sed 's/\.[0-9]*Z$//')" "+%Y-%m-%d %H:%M:%S" 2>/dev/null || echo "$result" | jq -r '.DeployedAt')

      local green='\033[32m' yellow='\033[33m' red='\033[31m' reset='\033[0m'

      local state_icon state_color
      case "$state" in
        RUNNING)   state_icon="✅"; state_color=$green ;;
        DEPLOYING) state_icon="🚀"; state_color=$yellow ;;
        *)         state_icon="⚠️";  state_color=$red ;;
      esac

      local deploy_icon deploy_color
      case "$deploy" in
        ACTIVE)     deploy_icon="✅"; deploy_color=$green ;;
        ACTIVATING) deploy_icon="🔄"; deploy_color=$yellow ;;
        FAILED)     deploy_icon="❌"; deploy_color=$red ;;
        *)          deploy_icon="⚠️";  deploy_color=$yellow ;;
      esac

      echo "    State: ${state_icon} ${state_color}${state}${reset}"
      echo "   Deploy: ${deploy_icon} ${deploy_color}${deploy}${reset}"
      echo "  Version: ${version}"
      echo "DeployedAt: ${deployed_at}"
    else
      aws lightsail get-container-services \
        --service-name "$1" \
        --query "containerServices[0].{State:state,Deploy:currentDeployment.state,Version:currentDeployment.version,DeployedAt:currentDeployment.createdAt}" \
        --output table
    fi
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
