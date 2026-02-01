#!/usr/bin/env bash
# GitHub Repository Cloner
# Clones all public and private repositories from your GitHub account

# Color codes for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Print header
echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}  GitHub Repository Cloner${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Prompt for GitHub username
read -p "Enter your GitHub username: " USER

# Prompt for Personal Access Token
echo ""
echo -e "${YELLOW}Enter your GitHub Personal Access Token:${NC}"
echo -e "${YELLOW}(Your input will be hidden for security)${NC}"
read -s TOKEN
echo ""

# Validate inputs
if [ -z "$USER" ] || [ -z "$TOKEN" ]; then
    echo -e "${RED}Error: Username and token are required!${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}Starting repository cloning process...${NC}"
echo ""

# Create a directory for all repos
REPO_DIR="github_repos_${USER}"
mkdir -p "$REPO_DIR"
cd "$REPO_DIR"

# Disable SSL verification for this session (fixes certificate errors on Windows)
export GIT_SSL_NO_VERIFY=1

# Fetch all repos with pagination
page=1
total_cloned=0

while true; do
  echo -e "${BLUE}[INFO] Fetching page $page from GitHub API...${NC}"
  
  response=$(curl -k -H "Authorization: token $TOKEN" \
    "https://api.github.com/user/repos?per_page=100&page=$page&type=all" 2>/dev/null)
  
  # Check if response is empty (no more repos)
  repo_count=$(echo "$response" | grep -c 'clone_url')
  if [ "$repo_count" -eq 0 ]; then
    break
  fi
  
  echo -e "${GREEN}[INFO] Found $repo_count repositories on page $page${NC}"
  echo ""
  
  # Extract clone URLs and clone each repo with authentication
  echo "$response" | grep -w clone_url | cut -d '"' -f 4 | while read repo_url; do
    # Modify URL to include token for authentication
    auth_url=$(echo "$repo_url" | sed "s|https://|https://$USER:$TOKEN@|")
    repo_name=$(echo "$repo_url" | sed 's|https://github.com/||' | sed 's|.git||')
    
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}[CLONING]${NC} $repo_name"
    echo -e "${YELLOW}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    
    git clone "$auth_url" 2>&1 | grep -E "(Cloning|done|error|fatal)" || true
    
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}✓ Successfully cloned: $repo_name${NC}"
    else
      echo -e "${RED}✗ Failed to clone: $repo_name${NC}"
    fi
    echo ""
    
  done
  
  ((page++))
done

# Count total repositories cloned
total_cloned=$(find . -maxdepth 1 -type d | wc -l)
total_cloned=$((total_cloned - 1)) # Subtract 1 for current directory

echo ""
echo -e "${BLUE}========================================${NC}"
echo -e "${GREEN}✓ Clone process completed!${NC}"
echo -e "${GREEN}Total repositories cloned: $total_cloned${NC}"
echo -e "${GREEN}Location: $(pwd)${NC}"
echo -e "${BLUE}========================================${NC}"
