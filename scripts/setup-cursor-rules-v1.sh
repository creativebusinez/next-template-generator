# =================================================================
# Cursor AI Rules Setup Script
# Version: 1.0.0
#
# This script sets up AI rules for your development project.
# It automatically detects your project structure and applies
# appropriate rulesets for your tech stack.
#
# Usage:
#   1. Place this script in .cursor/scripts/setup-cursor-rules-v1.sh
#   2. Make it executable: chmod +x .cursor/scripts/setup-cursor-rules-v1.sh
#   3. Run: ./.cursor/scripts/setup-cursor-rules-v1.sh
#
# Requirements:
#   - Bash shell
#   - Basic Unix commands (grep, find, etc.)
#   - Write permissions in the project directory
# =================================================================

# Add at the start of the script
set -x  # Enable debug mode

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Function to display the welcome screen and get user preferences
show_welcome() {
    clear
    echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║       ${YELLOW}Cursor AI Rules Setup Wizard${BLUE}         ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
    echo -e "\n${CYAN}This wizard will help you set up AI rules for your project:${NC}"
    echo -e "• Automatic project structure detection"
    echo -e "• Framework-specific rules"
    echo -e "• Styling and build tool configuration"
    echo -e "• Security and best practices\n"
    
    # Check if script has necessary permissions
    check_permissions
    
    # Ask about design rules
    echo -e "\n${YELLOW}Would you like to include design system rules? (y/n)${NC}"
    read -r INCLUDE_DESIGN
    export INCLUDE_DESIGN
    
    echo -e "\n${YELLOW}Press Enter to begin the setup...${NC}"
    read
}

# Function to check and set permissions
check_permissions() {
    if [ ! -x "$0" ]; then
        echo -e "${RED}⚠️  Script is not executable${NC}"
        echo -e "${YELLOW}Running: chmod +x $0${NC}"
        chmod +x "$0"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✅ Permissions set successfully${NC}"
        else
            echo -e "${RED}❌ Failed to set permissions. Please run:${NC}"
            echo -e "chmod +x $0"
            exit 1
        fi
    fi
}

# Function to print colored output
print_message() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Function to create directories
create_directories() {
    if [ ! -d ".cursor" ]; then
        mkdir -p .cursor
        print_message $GREEN "✅ Created .cursor directory"
    fi
    
    if [ ! -d ".cursor/instructions" ]; then
        mkdir -p .cursor/instructions
        print_message $GREEN "✅ Created instructions directory"
    fi
}

# Function to detect framework from package.json
detect_package_framework() {
    if [ ! -f "package.json" ]; then
        return 1
    fi
    
    local dependencies=$(cat package.json | grep -E '"dependencies"|"devDependencies"' -A 50)
    
    if echo "$dependencies" | grep -q '"next"'; then
        echo "nextjs"
    elif echo "$dependencies" | grep -q '"react"'; then
        echo "react"
    elif echo "$dependencies" | grep -q '"vue"'; then
        echo "vue"
    elif echo "$dependencies" | grep -q '"svelte"'; then
        echo "svelte"
    elif echo "$dependencies" | grep -q '"angular"'; then
        echo "angular"
    else
        echo "node"
    fi
}

# Function to detect WordPress in Local Sites environment
detect_wordpress() {
    echo "DEBUG: Starting WordPress detection..."
    echo "DEBUG: Current directory: $(pwd)"
    echo "DEBUG: Checking for wp-config.php..."
    
    if [ -f "app/public/wp-config.php" ]; then
        echo "DEBUG: Found wp-config.php"
        return 0
    else
        echo "DEBUG: wp-config.php not found"
        ls -la app/public/ 2>/dev/null || echo "DEBUG: app/public/ not accessible"
    fi
    
    return 1
}

# Function to detect backend framework
detect_backend_framework() {
    # Try WordPress detection first
    if detect_wordpress; then
        echo "wordpress"
        return 0
    fi
    
    # Laravel detection
    if [ -f "artisan" ] && [ -f "composer.json" ]; then
        echo "laravel"
    # Django detection
    elif [ -f "manage.py" ] && [ -f "requirements.txt" ]; then
        echo "django"
    # Rails detection
    elif [ -f "Gemfile" ] && [ -d "app" ] && [ -d "config" ]; then
        echo "rails"
    # Express.js detection
    elif [ -f "package.json" ] && grep -q '"express"' package.json; then
        echo "express"
    else
        echo "unknown"
    fi
}

# Function to detect build tools
detect_build_tools() {
    local build_tools=()
    
    # Check for various build tools
    [ -f "vite.config.js" ] || [ -f "vite.config.ts" ] && build_tools+=("vite")
    [ -f "webpack.config.js" ] && build_tools+=("webpack")
    [ -f "rollup.config.js" ] && build_tools+=("rollup")
    [ -f "gulpfile.js" ] && build_tools+=("gulp")
    [ -f "Gruntfile.js" ] && build_tools+=("grunt")
    
    echo "${build_tools[@]}"
}

# Function to detect testing frameworks
detect_testing_frameworks() {
    local test_frameworks=()
    
    if [ -f "package.json" ]; then
        local dependencies=$(cat package.json | grep -E '"dependencies"|"devDependencies"' -A 50)
        
        echo "$dependencies" | grep -q '"jest"' && test_frameworks+=("jest")
        echo "$dependencies" | grep -q '"mocha"' && test_frameworks+=("mocha")
        echo "$dependencies" | grep -q '"cypress"' && test_frameworks+=("cypress")
        echo "$dependencies" | grep -q '"playwright"' && test_frameworks+=("playwright")
    fi
    
    if [ -f "phpunit.xml" ]; then
        test_frameworks+=("phpunit")
    fi
    
    echo "${test_frameworks[@]}"
}

# Function to detect styling approach
detect_styling() {
    local styling=()
    
    # Check package.json for styling dependencies
    if [ -f "package.json" ]; then
        local dependencies=$(cat package.json | grep -E '"dependencies"|"devDependencies"' -A 50)
        
        echo "$dependencies" | grep -q '"tailwindcss"' && styling+=("tailwind")
        echo "$dependencies" | grep -q '"sass"' && styling+=("sass")
        echo "$dependencies" | grep -q '"styled-components"' && styling+=("styled-components")
        echo "$dependencies" | grep -q '"@emotion"' && styling+=("emotion")
    fi
    
    # Check for CSS/SCSS files
    find . -maxdepth 3 -type f -name "*.scss" | grep -q . && styling+=("scss")
    find . -maxdepth 3 -type f -name "*.less" | grep -q . && styling+=("less")
    
    echo "${styling[@]}"
}

# Function to detect project structure
detect_project_structure() {
    local structure=()
    
    # Check for common directories
    [ -d "src" ] && structure+=("src")
    [ -d "public" ] && structure+=("public")
    [ -d "assets" ] && structure+=("assets")
    [ -d "components" ] && structure+=("components")
    [ -d "pages" ] && structure+=("pages")
    [ -d "api" ] && structure+=("api")
    [ -d "tests" ] && structure+=("tests")
    [ -d "docs" ] && structure+=("docs")
    
    echo "${structure[@]}"
}

# Function to detect package manager
detect_package_manager() {
    local managers=()
    
    [ -f "package-lock.json" ] && managers+=("npm")
    [ -f "yarn.lock" ] && managers+=("yarn")
    [ -f "pnpm-lock.yaml" ] && managers+=("pnpm")
    [ -f "composer.lock" ] && managers+=("composer")
    [ -f "Gemfile.lock" ] && managers+=("bundler")
    [ -f "poetry.lock" ] && managers+=("poetry")
    [ -f "requirements.txt" ] && managers+=("pip")
    
    echo "${managers[@]}"
}

# Function to detect linters and formatters
detect_linters() {
    local linters=()
    
    # Check package.json for linting dependencies
    if [ -f "package.json" ]; then
        local dependencies=$(cat package.json | grep -E '"dependencies"|"devDependencies"' -A 50)
        
        echo "$dependencies" | grep -q '"eslint"' && linters+=("eslint")
        echo "$dependencies" | grep -q '"prettier"' && linters+=("prettier")
        echo "$dependencies" | grep -q '"stylelint"' && linters+=("stylelint")
        echo "$dependencies" | grep -q '"tslint"' && linters+=("tslint")
    fi
    
    # Check for config files
    [ -f ".eslintrc" ] || [ -f ".eslintrc.js" ] || [ -f ".eslintrc.json" ] && linters+=("eslint")
    [ -f ".prettierrc" ] || [ -f ".prettierrc.js" ] || [ -f ".prettierrc.json" ] && linters+=("prettier")
    [ -f ".stylelintrc" ] || [ -f ".stylelintrc.js" ] || [ -f ".stylelintrc.json" ] && linters+=("stylelint")
    [ -f "phpcs.xml" ] || [ -f "phpcs.xml.dist" ] && linters+=("phpcs")
    [ -f ".php_cs" ] || [ -f ".php_cs.dist" ] && linters+=("php-cs-fixer")
    
    echo "${linters[@]}"
}

# Enhanced version control detection
detect_version_control() {
    local vcs=()
    
    # Git detection with additional info
    if [ -d ".git" ]; then
        vcs+=("git")
        # Check for git flow
        if git flow config >/dev/null 2>&1; then
            vcs+=("git-flow")
        fi
        # Check for common CI configs
        [ -f ".github/workflows" ] && vcs+=("github-actions")
        [ -f ".gitlab-ci.yml" ] && vcs+=("gitlab-ci")
        [ -f "bitbucket-pipelines.yml" ] && vcs+=("bitbucket-pipelines")
    fi
    
    # Other VCS systems
    [ -d ".svn" ] && vcs+=("svn")
    [ -d ".hg" ] && vcs+=("mercurial")
    
    echo "${vcs[@]}"
}

# Function to detect containerization
detect_containers() {
    local containers=()
    
    # Docker detection
    if [ -f "Dockerfile" ] || [ -f "docker-compose.yml" ] || [ -f "docker-compose.yaml" ]; then
        containers+=("docker")
        # Check for docker-compose version
        if [ -f "docker-compose.yml" ] || [ -f "docker-compose.yaml" ]; then
            containers+=("docker-compose")
        fi
    fi
    
    # Kubernetes detection
    if [ -d "k8s" ] || [ -d "kubernetes" ] || find . -maxdepth 2 -name "*.yaml" -exec grep -l "kind: Deployment\|kind: Service" {} \; | grep -q .; then
        containers+=("kubernetes")
    fi
    
    # Other container technologies
    [ -f "podman-compose.yml" ] && containers+=("podman")
    [ -f "vagrant.yml" ] && containers+=("vagrant")
    
    echo "${containers[@]}"
}

# Enhanced database detection
detect_database() {
    local databases=()
    
    # Check configuration files
    if [ -f ".env" ] || [ -f ".env.example" ]; then
        local env_file=".env"
        [ ! -f ".env" ] && env_file=".env.example"
        
        grep -q "MYSQL" "$env_file" && databases+=("mysql")
        grep -q "POSTGRES" "$env_file" && databases+=("postgresql")
        grep -q "MONGODB" "$env_file" && databases+=("mongodb")
        grep -q "REDIS" "$env_file" && databases+=("redis")
    fi
    
    # Check for database configuration files
    [ -f "config/database.yml" ] && databases+=("rails-db")
    [ -f "prisma/schema.prisma" ] && databases+=("prisma")
    [ -f "sequelize.config.js" ] && databases+=("sequelize")
    [ -f "knexfile.js" ] && databases+=("knex")
    
    echo "${databases[@]}"
}

# Function to detect CI/CD tools
detect_cicd() {
    local cicd=()
    
    # GitHub Actions
    [ -d ".github/workflows" ] && cicd+=("github-actions")
    
    # Other CI/CD tools
    [ -f ".gitlab-ci.yml" ] && cicd+=("gitlab-ci")
    [ -f "jenkins.yml" ] || [ -f "Jenkinsfile" ] && cicd+=("jenkins")
    [ -f ".travis.yml" ] && cicd+=("travis-ci")
    [ -f "circle.yml" ] || [ -f ".circleci/config.yml" ] && cicd+=("circle-ci")
    [ -f "azure-pipelines.yml" ] && cicd+=("azure-pipelines")
    [ -f "bitbucket-pipelines.yml" ] && cicd+=("bitbucket-pipelines")
    
    echo "${cicd[@]}"
}

# Function to detect cloud providers
detect_cloud() {
    local cloud=()
    
    # AWS
    if [ -f "serverless.yml" ] || [ -d ".aws" ] || [ -f "aws-exports.js" ]; then
        cloud+=("aws")
    fi
    
    # Google Cloud
    if [ -f "app.yaml" ] || [ -f "cloudbuild.yaml" ]; then
        cloud+=("gcp")
    fi
    
    # Azure
    if [ -f "azure-pipelines.yml" ] || [ -f ".deployment" ]; then
        cloud+=("azure")
    fi
    
    # Vercel/Netlify
    [ -f "vercel.json" ] && cloud+=("vercel")
    [ -f "netlify.toml" ] && cloud+=("netlify")
    
    echo "${cloud[@]}"
}

# Function to detect design tools and frameworks
detect_design_tools() {
    local design_tools=()
    
    echo "DEBUG: Checking design tools..."
    
    # Check theme's package.json for design dependencies
    if [ -f "app/public/wp-content/themes/*/package.json" ]; then
        local package_json=$(cat app/public/wp-content/themes/*/package.json)
        
        # Tailwind detection
        if echo "$package_json" | grep -q '"tailwindcss"'; then
            design_tools+=("tailwind")
        fi
        
        # SASS/SCSS detection
        if echo "$package_json" | grep -q '"sass"\|"node-sass"'; then
            design_tools+=("sass")
        fi
        
        # PostCSS detection
        if echo "$package_json" | grep -q '"postcss"'; then
            design_tools+=("postcss")
        fi
        
        # Bootstrap detection
        if echo "$package_json" | grep -q '"bootstrap"'; then
            design_tools+=("bootstrap")
        fi
    fi
    
    # Check for design-related files
    find app/public/wp-content/themes/ -type f -name "*.scss" 2>/dev/null && design_tools+=("sass")
    find app/public/wp-content/themes/ -type f -name "tailwind.config.js" 2>/dev/null && design_tools+=("tailwind")
    
    echo "${design_tools[@]}"
}

# Update the display_analysis function to show new detections
display_analysis() {
    local frontend_framework=$1
    local backend_framework=$2
    local build_tools=$3
    local testing_frameworks=$4
    local styling=$5
    local structure=$6
    
    echo -e "\n${CYAN}📊 Project Analysis Results:${NC}"
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Package Manager
    local package_managers=($(detect_package_manager))
    [ ! -z "${package_managers[*]}" ] && echo -e "📦 Package Managers: ${YELLOW}${package_managers[*]}${NC}"
    
    # Frameworks
    [ ! -z "$frontend_framework" ] && echo -e "📱 Frontend Framework: ${YELLOW}$frontend_framework${NC}"
    [ ! -z "$backend_framework" ] && echo -e "🖥️  Backend Framework: ${YELLOW}$backend_framework${NC}"
    
    # Tools and Infrastructure
    [ ! -z "${build_tools[*]}" ] && echo -e "🛠️  Build Tools: ${YELLOW}${build_tools[*]}${NC}"
    
    # Linters
    local linters=($(detect_linters))
    [ ! -z "${linters[*]}" ] && echo -e "🔍 Linters & Formatters: ${YELLOW}${linters[*]}${NC}"
    
    # Version Control
    local vcs=($(detect_version_control))
    [ ! -z "${vcs[*]}" ] && echo -e "📝 Version Control: ${YELLOW}${vcs[*]}${NC}"
    
    # Containers
    local containers=($(detect_containers))
    [ ! -z "${containers[*]}" ] && echo -e "🐳 Containers: ${YELLOW}${containers[*]}${NC}"
    
    # Databases
    local databases=($(detect_database))
    [ ! -z "${databases[*]}" ] && echo -e "💾 Databases: ${YELLOW}${databases[*]}${NC}"
    
    # CI/CD
    local cicd=($(detect_cicd))
    [ ! -z "${cicd[*]}" ] && echo -e "🔄 CI/CD: ${YELLOW}${cicd[*]}${NC}"
    
    # Cloud
    local cloud=($(detect_cloud))
    [ ! -z "${cloud[*]}" ] && echo -e "☁️  Cloud: ${YELLOW}${cloud[*]}${NC}"
    
    # Testing
    [ ! -z "${testing_frameworks[*]}" ] && echo -e "🧪 Testing: ${YELLOW}${testing_frameworks[*]}${NC}"
    
    # Styling
    [ ! -z "${styling[*]}" ] && echo -e "🎨 Styling: ${YELLOW}${styling[*]}${NC}"
    
    # Project Structure
    [ ! -z "${structure[*]}" ] && echo -e "📁 Structure: ${YELLOW}${structure[*]}${NC}"
    
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n"
}

# Enhanced project detection function
detect_project_type() {
    print_message $YELLOW "🔍 Analyzing project structure..."
    
    # Detect frontend framework
    local frontend_framework=$(detect_package_framework)
    # Detect backend framework
    local backend_framework=$(detect_backend_framework)
    # Detect build tools
    local build_tools=($(detect_build_tools))
    # Detect testing frameworks
    local testing_frameworks=($(detect_testing_frameworks))
    # Detect styling approach
    local styling=($(detect_styling))
    # Detect project structure
    local structure=($(detect_project_structure))
    
    # Print detected configuration
    echo "📊 Project Analysis Results:"
    [ ! -z "$frontend_framework" ] && echo "- Frontend Framework: $frontend_framework"
    [ ! -z "$backend_framework" ] && echo "- Backend Framework: $backend_framework"
    [ ! -z "${build_tools[*]}" ] && echo "- Build Tools: ${build_tools[*]}"
    [ ! -z "${testing_frameworks[*]}" ] && echo "- Testing Frameworks: ${testing_frameworks[*]}"
    [ ! -z "${styling[*]}" ] && echo "- Styling: ${styling[*]}"
    [ ! -z "${structure[*]}" ] && echo "- Project Structure: ${structure[*]}"
    
    # Determine primary project type
    if [ "$frontend_framework" = "nextjs" ]; then
        echo "nextjs"
    elif [ "$backend_framework" = "wordpress" ]; then
        echo "wordpress"
    elif [ ! -z "$frontend_framework" ] && [ "$backend_framework" = "unknown" ]; then
        echo "$frontend_framework"
    elif [ "$backend_framework" != "unknown" ]; then
        echo "$backend_framework"
    else
        echo "unknown"
    fi
}

# Function to copy rule file - updated to work with our directory structure
copy_rule_file() {
    local source=$1
    local destination=$2
    
    if [[ "$source" == @rules/* ]]; then
        source=".cursor/rules/${source#@rules/}"
    fi
    
    echo "DEBUG: Attempting to copy rule from $source to $destination"
    
    if [ -f "$source" ]; then
        mkdir -p "$(dirname "$destination")"
        cp "$source" "$destination"
        print_message $GREEN "✅ Applied ruleset: $(basename "$source")"
    else
        print_message $RED "❌ Missing ruleset: $(basename "$source"): $source"
        # No need for fallback now that the path is correct
    fi
}

# Function to apply framework-specific rules - simplified from original
apply_framework_rules() {
    print_message $YELLOW "\n📦 Applying rulesets based on detection..."
    
    # Base rules
    copy_rule_file "@rules/global_rules.mdc" ".cursor/instructions/global.mdc"
    copy_rule_file "@rules/security_rules.mdc" ".cursor/instructions/security.mdc"
    
    # Next.js related rules
    copy_rule_file "@rules/react_rules.mdc" ".cursor/instructions/react.mdc"
    copy_rule_file "@rules/nextjs_rules.mdc" ".cursor/instructions/nextjs.mdc"
    copy_rule_file "@rules/typescript_rules.mdc" ".cursor/instructions/typescript.mdc"
    copy_rule_file "@rules/tailwind_rules.mdc" ".cursor/instructions/tailwind.mdc"
    copy_rule_file "@rules/design_rules.mdc" ".cursor/instructions/design.mdc"
    
    # Add more tech-specific rules
    copy_rule_file "@rules/automation_rules.mdc" ".cursor/instructions/automation.mdc"
    copy_rule_file "@rules/framer_motion_rules.mdc" ".cursor/instructions/framer.mdc"
}

# Updated setup_rules function
setup_rules() {
    create_directories
    apply_framework_rules
    validate_setup
}

# Function to validate setup
validate_setup() {
    local error=0
    
    print_message $YELLOW "\n🔍 Validating setup..."
    
    # Check if instructions directory exists
    if [ ! -d ".cursor/instructions" ]; then
        print_message $RED "❌ Instructions directory not created"
        error=1
    fi
    
    # Check if required files were created
    if [ ! -f ".cursor/instructions/global.mdc" ]; then
        print_message $RED "❌ Global rules not applied"
        error=1
    fi
    
    # List all created instruction files
    if [ -d ".cursor/instructions" ]; then
        echo -e "\n${CYAN}Created instruction files:${NC}"
        ls -1 .cursor/instructions/*.mdc 2>/dev/null | while read file; do
            echo -e "  • $(basename "$file")"
        done
    fi
    
    if [ $error -eq 1 ]; then
        print_message $RED "❌ Setup validation failed"
        return 1
    else
        print_message $GREEN "✅ Setup validated successfully"
    fi
}

# Function to show completion message
show_completion() {
    echo -e "\n${GREEN}╔════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║       🎉 Setup Completed Successfully!       ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════╝${NC}"
    echo -e "\n${CYAN}What's Next?${NC}"
    echo -e "• Cursor AI will now use these rules for your project"
    echo -e "• Rules are stored in ${YELLOW}.cursor/instructions/${NC}"
    echo -e "• You can manually edit rules in the instructions directory"
    echo -e "\n${CYAN}Need Help?${NC}"
    echo -e "• Check the documentation in ${YELLOW}.cursor/README${NC}"
    echo -e "• Run this script again to reconfigure rules"
    echo -e "\n${GREEN}Happy coding! 🚀${NC}\n"
}

# Run the setup
setup_rules 

# Add to setup-rules.sh
validate_rule_file() {
    local file=$1
    
    # Check file exists
    if [ ! -f "$file" ]; then
        return 1
    fi
    
    # Check file has required sections
    if ! grep -q "^description:" "$file" || ! grep -q "^globs:" "$file"; then
        return 1
    fi
    
    return 0
}

# Add to setup-rules.sh
test_setup() {
    local test_dir=$(mktemp -d)
    cd "$test_dir"
    
    # Test WordPress detection
    mkdir -p wp-content
    touch wp-config.php
    if ! detect_wordpress; then
        print_message $RED "❌ WordPress detection failed"
        return 1
    fi
    
    # Test React detection
    rm -rf *
    mkdir src
    echo '{"dependencies":{"react":""}}' > package.json
    if ! detect_frontend_framework | grep -q "react"; then
        print_message $RED "❌ React detection failed"
        return 1
    fi
    
    cd - >/dev/null
    rm -rf "$test_dir"
    print_message $GREEN "✅ Setup tests passed"
}

validate_wordpress_rules() {
    local error=0
    
    # Check for rule conflicts
    if [ -f ".cursor/instructions/wordpress.mdc" ] && [ -f ".cursor/instructions/theme.mdc" ]; then
        print_message $YELLOW "Checking WordPress rule compatibility..."
        
        # Verify no duplicate sections
        local core_sections=$(grep "^##" .cursor/instructions/wordpress.mdc | sort)
        local theme_sections=$(grep "^##" .cursor/instructions/theme.mdc | sort)
        
        local duplicates=$(comm -12 <(echo "$core_sections") <(echo "$theme_sections"))
        
        if [ ! -z "$duplicates" ]; then
            print_message $RED "Found overlapping sections:"
            echo "$duplicates"
            error=1
        fi
    fi
    
    return $error
}

# Function to check project files
check_project_files() {
    export HAS_PACKAGE_JSON=false
    export HAS_COMPOSER_JSON=false
    export HAS_DOCKER=false
    
    [ -f "app/public/wp-content/themes/*/package.json" ] && HAS_PACKAGE_JSON=true
    [ -f "app/public/wp-content/themes/*/composer.json" ] && HAS_COMPOSER_JSON=true
    [ -f "docker-compose.yml" ] || [ -f "app/docker-compose.yml" ] && HAS_DOCKER=true
}

# Function to detect frameworks
detect_frameworks() {
    local frameworks=()
    
    # WordPress detection
    if detect_wordpress; then
        frameworks+=("wordpress")
    fi
    
    echo "${frameworks[@]}"
}

# Update Next.js detection
detect_nextjs() {
    if [ -f "package.json" ]; then
        echo "DEBUG: Checking package.json for Next.js..."
        if grep -q '"next":' package.json; then
            echo "DEBUG: Found Next.js in package.json"
            return 0
        fi
    fi
    return 1
}

# Update Tailwind detection
detect_tailwind() {
    if [ -f "package.json" ]; then
        echo "DEBUG: Checking package.json for Tailwind..."
        if grep -q '"tailwindcss":' package.json; then
            echo "DEBUG: Found Tailwind in package.json"
            return 0
        fi
    fi
    return 1
}

# Add this function to check if copy_rule_file exists and is working
check_rule_file() {
    local source=$1
    echo "DEBUG: Checking rule file: $source"
    if [ -f "$source" ]; then
        echo "DEBUG: Rule file exists: $source"
        return 0
    else
        echo "DEBUG: Rule file not found: $source"
        return 1
    fi
} 