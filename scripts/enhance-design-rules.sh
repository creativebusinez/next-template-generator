#!/bin/bash

# =================================================================
# Design Rules Enhancement Script
# Version: 1.0.0
#
# This script collects design preferences and appends niche-specific
# design guidance to the existing design_rules.mdc file.
#
# Usage:
#   1. Make it executable: chmod +x .cursor/scripts/enhance-design-rules.sh
#   2. Run: ./.cursor/scripts/enhance-design-rules.sh
# =================================================================

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

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

# Function to collect design preferences
collect_design_preferences() {
    echo -e "\n${CYAN}🎨 Design Preferences Collection${NC}"
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    
    # Collect niche/industry
    echo -e "\n${YELLOW}What is the primary niche/industry for this site? (e.g., Healthcare, E-commerce, Education)${NC}"
    read -r NICHE
    
    # Collect target audience
    echo -e "\n${YELLOW}Who is the target audience? (e.g., Professionals, Students, Parents)${NC}"
    read -r AUDIENCE
    
    # Collect brand personality/tone
    echo -e "\n${YELLOW}What is the brand personality/tone? (e.g., Professional, Playful, Minimalist)${NC}"
    read -r BRAND_TONE
    
    # Collect color scheme preference
    echo -e "\n${YELLOW}What is the preferred color scheme? (e.g., Blue/White, Earth tones, Vibrant)${NC}"
    read -r COLOR_SCHEME
    
    # Collect design inspirations
    echo -e "\n${YELLOW}List any design inspirations or sites you'd like to emulate (comma-separated):${NC}"
    read -r INSPIRATIONS
    
    echo -e "\n${GREEN}✅ Design preferences collected successfully${NC}"
}

# Function to generate niche-specific design guidance
generate_niche_guidance() {
    local niche=$1
    local audience=$2
    local brand_tone=$3
    local color_scheme=$4
    local inspirations=$5
    
    # Create a temporary file for the niche-specific guidance
    local temp_file=$(mktemp)
    
    # Write the niche-specific guidance header
    cat > "$temp_file" << EOF

---

# 🎯 Niche-Specific Design Guidance

## 📊 Project-Specific Information
- **Industry/Niche:** $niche
- **Target Audience:** $audience
- **Brand Personality:** $brand_tone
- **Color Scheme:** $color_scheme
- **Design Inspirations:** $inspirations

EOF
    
    # Add niche-specific recommendations based on the provided niche
    case "${niche,,}" in
        *healthcare*|*medical*|*health*)
            cat >> "$temp_file" << EOF

## 🏥 Healthcare Design Recommendations
- **Use calming, trustworthy colors** like blues and greens to convey professionalism and care
- **Prioritize accessibility** for all users, including those with disabilities
- **Ensure clear information hierarchy** for critical health information
- **Use simple, direct language** to explain complex medical concepts
- **Implement intuitive navigation** for users who may be stressed or in pain
- **Include clear calls-to-action** for appointment booking or emergency information
- **Ensure mobile responsiveness** for users accessing on-the-go
- **Maintain HIPAA compliance** in all user interactions and data collection
- **Use authentic imagery** that represents diverse patients and healthcare providers
- **Provide easy access to contact information** and emergency resources
EOF
            ;;
            
        *ecommerce*|*shop*|*store*|*retail*)
            cat >> "$temp_file" << EOF

## 🛒 E-commerce Design Recommendations
- **Showcase products with high-quality images** from multiple angles
- **Implement intuitive product filtering and search** functionality
- **Design clear, compelling call-to-action buttons** for "Add to Cart" and "Checkout"
- **Create streamlined checkout process** with minimal steps
- **Display shipping information and return policies** prominently
- **Include customer reviews and ratings** to build trust
- **Use product recommendations** to increase average order value
- **Ensure mobile-optimized shopping experience** for on-the-go purchases
- **Implement wish lists and saved items** functionality
- **Design abandoned cart recovery** mechanisms
- **Ensure fast page load times** to reduce bounce rates
- **Use high-contrast colors** for sale items and promotions
EOF
            ;;
            
        *education*|*learning*|*school*|*academic*)
            cat >> "$temp_file" << EOF

## 📚 Education Design Recommendations
- **Create clear content organization** with logical progression
- **Use engaging, interactive elements** to enhance learning
- **Implement progress tracking** for learners to monitor advancement
- **Design distraction-free reading environments** for content-heavy pages
- **Include multimedia learning options** (video, audio, text) for different learning styles
- **Create mobile-responsive designs** for learning on any device
- **Use color coding for different subjects or categories**
- **Implement intuitive navigation** between related learning materials
- **Design accessible interfaces** for learners with disabilities
- **Include social learning components** where appropriate
- **Create clear visual hierarchy** to guide attention to important information
EOF
            ;;
            
        *finance*|*banking*|*investment*)
            cat >> "$temp_file" << EOF

## 💰 Finance Design Recommendations
- **Prioritize security and trust signals** throughout the interface
- **Use conservative, professional color schemes** (blues, greens, neutrals)
- **Create clear data visualizations** for financial information
- **Design intuitive dashboards** for account monitoring
- **Implement progressive disclosure** for complex financial information
- **Ensure accessibility** for all users regardless of ability
- **Use clear calls-to-action** for primary financial tasks
- **Design for different financial literacy levels** with appropriate guidance
- **Create mobile-responsive interfaces** for on-the-go financial management
- **Implement strong form validation** for financial transactions
- **Use familiar patterns** for sensitive operations like transfers and payments
EOF
            ;;
            
        *technology*|*tech*|*software*|*saas*)
            cat >> "$temp_file" << EOF

## 💻 Technology Design Recommendations
- **Create clean, modern interfaces** with ample whitespace
- **Use progressive disclosure** for complex features
- **Implement intuitive onboarding** for new users
- **Design clear navigation** between different product sections
- **Create responsive designs** for multi-device usage
- **Use subtle animations** to enhance user experience
- **Implement dark mode options** for user preference
- **Design for accessibility** across all user abilities
- **Create consistent UI patterns** throughout the application
- **Use clear error messages** with actionable solutions
- **Implement keyboard shortcuts** for power users
EOF
            ;;
            
        *food*|*restaurant*|*culinary*)
            cat >> "$temp_file" << EOF

## 🍽️ Food & Restaurant Design Recommendations
- **Use appetizing food photography** as a central design element
- **Implement easy-to-read menus** with clear categorization
- **Create mobile-friendly ordering systems** for on-the-go customers
- **Design intuitive reservation systems** if applicable
- **Use colors that stimulate appetite** (reds, oranges, yellows)
- **Include clear business hours and location information**
- **Design for quick loading times** for hungry users
- **Implement easy contact methods** for questions or support
- **Create special sections for dietary restrictions** and allergen information
- **Use authentic imagery** that represents your actual food and atmosphere
EOF
            ;;
            
        *travel*|*tourism*|*hospitality*)
            cat >> "$temp_file" << EOF

## ✈️ Travel & Tourism Design Recommendations
- **Use inspiring destination imagery** to create emotional connection
- **Implement intuitive booking systems** with clear steps
- **Create mobile-responsive designs** for travelers on the go
- **Design clear navigation** between different destinations or services
- **Include interactive maps** where appropriate
- **Use trust signals and reviews** prominently
- **Design for different languages** if serving international audiences
- **Create easy access to support** for booking assistance
- **Implement filters for personalized travel options**
- **Design for offline access** of important travel information
- **Use clear pricing information** with all fees disclosed upfront
EOF
            ;;
            
        *real*estate*)
            cat >> "$temp_file" << EOF

## 🏠 Real Estate Design Recommendations
- **Showcase properties with high-quality photography**
- **Implement intuitive property search and filtering**
- **Create detailed property listings** with all relevant information
- **Design interactive maps** for location-based searching
- **Use virtual tours or 3D walkthroughs** where possible
- **Implement contact forms** for property inquiries
- **Design for mobile users** searching properties on the go
- **Include clear calls-to-action** for viewings or inquiries
- **Create saved searches and favorites** functionality
- **Design for fast loading of property images**
- **Include neighborhood information** for contextual understanding
EOF
            ;;
            
        *fitness*|*gym*|*wellness*)
            cat >> "$temp_file" << EOF

## 💪 Fitness & Wellness Design Recommendations
- **Use motivational imagery and design elements**
- **Create clear program or membership information**
- **Design intuitive class scheduling systems** if applicable
- **Implement progress tracking** for fitness goals
- **Use energetic colors** balanced with calming elements
- **Create mobile-responsive designs** for on-the-go fitness tracking
- **Design for accessibility** for users of all ability levels
- **Include clear calls-to-action** for sign-ups or trials
- **Use authentic imagery** representing diverse body types
- **Create community elements** for social motivation
- **Design intuitive navigation** between different fitness programs
EOF
            ;;
            
        *)
            # Generic recommendations for any other niche
            cat >> "$temp_file" << EOF

## 🌟 Custom Design Recommendations for $niche
- **Align visual design with $brand_tone brand personality**
- **Optimize user experience for $audience as the primary audience**
- **Implement $color_scheme color scheme consistently throughout the interface**
- **Draw inspiration from $inspirations while maintaining unique identity**
- **Create intuitive navigation patterns** specific to your industry
- **Design clear calls-to-action** that resonate with your audience
- **Implement responsive design** for all device types
- **Ensure accessibility** for all users regardless of ability
- **Use authentic imagery** that represents your brand and audience
- **Create consistent UI patterns** throughout the application
EOF
            ;;
    esac
    
    # Add brand tone specific recommendations
    case "${brand_tone,,}" in
        *professional*|*corporate*|*formal*)
            cat >> "$temp_file" << EOF

## 👔 Professional Brand Tone Implementation
- **Use clean, structured layouts** with ample whitespace
- **Implement a restrained color palette** with limited accent colors
- **Choose serif or professional sans-serif typography**
- **Design minimal, purposeful animations** if any
- **Use formal, precise language** in UI copy
- **Create consistent, predictable UI patterns**
- **Implement traditional navigation patterns** for familiarity
- **Design subtle hover and interaction states**
- **Use high-quality, professional imagery**
- **Create clear information hierarchy** with traditional typographic scale
EOF
            ;;
            
        *playful*|*fun*|*casual*)
            cat >> "$temp_file" << EOF

## 😊 Playful Brand Tone Implementation
- **Use vibrant, energetic colors** throughout the interface
- **Implement playful micro-interactions** and animations
- **Choose friendly, rounded typography**
- **Design with asymmetrical layouts** for dynamic feel
- **Use conversational, casual language** in UI copy
- **Create unique, memorable UI components**
- **Implement unexpected (but intuitive) navigation patterns**
- **Design expressive hover and interaction states**
- **Use illustrations and playful imagery**
- **Create engaging loading states** and transitions
EOF
            ;;
            
        *minimalist*|*clean*|*simple*)
            cat >> "$temp_file" << EOF

## ✨ Minimalist Brand Tone Implementation
- **Use abundant whitespace** throughout the interface
- **Implement a limited, monochromatic color palette**
- **Choose clean, geometric typography**
- **Design with grid-based, aligned layouts**
- **Use concise, essential language** in UI copy
- **Create simplified UI components** with minimal ornamentation
- **Implement intuitive, predictable navigation**
- **Design subtle hover and interaction states**
- **Use minimal, high-quality imagery** or no imagery
- **Create clear focus on content** over design elements
EOF
            ;;
            
        *luxury*|*premium*|*elegant*)
            cat >> "$temp_file" << EOF

## 💎 Luxury Brand Tone Implementation
- **Use sophisticated color palette** with gold, black, or deep tones
- **Implement refined animations** with smooth transitions
- **Choose elegant serif or thin sans-serif typography**
- **Design with generous spacing** for content breathing room
- **Use refined, sophisticated language** in UI copy
- **Create high-end UI components** with subtle details
- **Implement discreet navigation patterns**
- **Design subtle but distinctive hover states**
- **Use high-quality, artistic imagery**
- **Create an exclusive feel** through design choices
EOF
            ;;
            
        *innovative*|*modern*|*cutting-edge*)
            cat >> "$temp_file" << EOF

## 🚀 Innovative Brand Tone Implementation
- **Use gradient or duotone color schemes**
- **Implement distinctive micro-interactions** and animations
- **Choose contemporary, unique typography**
- **Design with asymmetrical or broken grid layouts**
- **Use forward-thinking language** in UI copy
- **Create unique UI components** that differentiate from standards
- **Implement innovative navigation patterns** (with usability testing)
- **Design distinctive hover and interaction states**
- **Use cutting-edge imagery or 3D elements**
- **Create surprising but delightful user experiences**
EOF
            ;;
            
        *)
            # Generic recommendations for any other brand tone
            cat >> "$temp_file" << EOF

## 🎭 $brand_tone Brand Tone Implementation
- **Align color choices with $brand_tone personality**
- **Select typography that reflects $brand_tone characteristics**
- **Design interactions that feel $brand_tone in nature**
- **Create layouts that express $brand_tone qualities**
- **Use language in UI copy that embodies $brand_tone voice**
- **Implement navigation that feels appropriate for $brand_tone experience**
- **Design UI components that reflect $brand_tone attributes**
- **Select imagery that reinforces $brand_tone qualities**
- **Create a consistent experience** that aligns with brand values
EOF
            ;;
    esac
    
    # Add audience-specific recommendations
    cat >> "$temp_file" << EOF

## 👥 Designing for $audience
- **Research $audience needs, behaviors, and preferences**
- **Create user personas** based on your specific $audience segments
- **Design with appropriate complexity level** for $audience technical proficiency
- **Use language and terminology** familiar to $audience
- **Select imagery that $audience will relate to and connect with**
- **Test designs with actual $audience members** for validation
- **Consider accessibility needs** specific to $audience demographics
- **Design for the devices most commonly used** by $audience
- **Address pain points specific** to $audience in your industry
- **Create features that solve problems** unique to $audience
EOF
    
    # Return the path to the temporary file
    echo "$temp_file"
}

# Main function
main() {
    echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║       ${YELLOW}Design Rules Enhancement Tool${BLUE}        ║${NC}"
    echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"
    
    create_directories
    
    # Check if design_rules.mdc exists, if not create it
    local design_rules_file=".cursor/instructions/design.mdc"
    if [ ! -f "$design_rules_file" ]; then
        # Create a basic design rules file if it doesn't exist
        mkdir -p "$(dirname "$design_rules_file")"
        cat > "$design_rules_file" << EOF
---
description: Design and UI rules for Next.js projects
globs: ["*.tsx", "*.jsx", "*.css", "*.scss", "tailwind.config.js"]
---

# Next.js Project Design Guidelines

EOF
        print_message $GREEN "✅ Created basic design rules file"
    else
        print_message $GREEN "✅ Found existing design rules file"
    fi
    
    # Collect design preferences
    collect_design_preferences
    
    # Generate niche-specific guidance
    print_message $YELLOW "🔄 Generating niche-specific design guidance..."
    local guidance_file=$(generate_niche_guidance "$NICHE" "$AUDIENCE" "$BRAND_TONE" "$COLOR_SCHEME" "$INSPIRATIONS")
    
    # Create a backup of the original file
    cp "$design_rules_file" "${design_rules_file}.bak"
    
    # Append the niche-specific guidance to the design rules file
    cat "$guidance_file" >> "$design_rules_file"
    rm "$guidance_file"
    
    print_message $GREEN "✅ Design rules enhanced with niche-specific guidance"
    
    echo -e "\n${GREEN}🎉 Design rules enhancement completed successfully!${NC}"
    echo -e "Your design rules file now includes customized guidance for:"
    echo -e "• ${YELLOW}$NICHE${NC} industry"
    echo -e "• ${YELLOW}$AUDIENCE${NC} audience"
    echo -e "• ${YELLOW}$BRAND_TONE${NC} brand personality"
    echo -e "\nFile location: ${CYAN}$design_rules_file${NC}"
}

# Run the main function
main 