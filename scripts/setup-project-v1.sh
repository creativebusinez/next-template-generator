#!/bin/bash

# =================================================================
# Next.js Project Template Generator Instructions
#
# This section provides instructions on how to use the setup script.
#
# Usage:
#   1. Make the script executable: chmod +x scripts/setup-project-v1.sh
#   2. Run the script: ./scripts/setup-project-v1.sh
#   3. Follow the prompts to configure your project.
#
# Prompts:
#   - Project name: Enter the desired name for your project directory.
#   - Project niche: Choose from available niches (ecommerce, healthcare, technology).
#   - Target audience: Specify the target audience for your project.
#   - Brand tone: Define the brand tone (modern, professional, playful).
#
# The script will:
#   - Create the project directory structure.
#   - Copy base templates and niche-specific components.
#   - Set up initial configuration files.
#
# Requirements:
#   - Bash shell
#   - Next.js and related dependencies
#   - Cursor AI setup (for AI integration)
# =================================================================


# Base paths
TEMPLATE_DIR="$(dirname "$(dirname "$0")")/templates"
RULES_GENERATOR="$(dirname "$(dirname "$0")")"

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# Show welcome screen
echo -e "${BLUE}╔════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║       ${YELLOW}Next.js + Cursor AI Setup${BLUE}          ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════════╝${NC}"

# Project Configuration
read -p "Enter project name (e.g., my-site): " PROJECT_NAME
read -p "Enter project niche (ecommerce, blog, portfolio, technology): " NICHE_INPUT
read -p "Enter target audience: " AUDIENCE
read -p "Enter brand tone (modern, professional, playful): " BRAND_TONE

# Standardize niche name (lowercase and remove spaces)
NICHE=$(echo "$NICHE_INPUT" | tr '[:upper:]' '[:lower:]' | tr -d ' ')

# Validate niche
VALID_NICHES=("ecommerce" "blog" "portfolio" "technology")
NICHE_VALID=false

for valid_niche in "${VALID_NICHES[@]}"; do
  if [ "$valid_niche" = "$NICHE" ]; then
    NICHE_VALID=true
    break
  fi
done

if [ "$NICHE_VALID" = false ]; then
  echo -e "${YELLOW}Warning: '$NICHE' is not a recognized niche. Using 'technology' as default.${NC}"
  echo -e "${YELLOW}Valid niches are: ${VALID_NICHES[*]}${NC}"
  NICHE="technology"
fi

# Remove whitespace from project name
PROJECT_NAME=$(echo "$PROJECT_NAME" | xargs)

# Set PROJECT_DIR to match PROJECT_NAME for backward compatibility
PROJECT_DIR="$PROJECT_NAME"

# Validate project name
if [ -d "$PROJECT_NAME" ]; then
  echo -e "${RED}Error: Directory '$PROJECT_NAME' already exists.${NC}"
  exit 1
fi

echo -e "${CYAN}Creating project: $PROJECT_NAME${NC}"

# Create project structure
mkdir -p "$PROJECT_NAME"/{components,pages,public/images,styles,utils,.cursor/{instructions,rules,scripts,design-reference}}

# Create placeholder images for components
if [ "$NICHE" = "blog" ]; then
  echo -e "${CYAN}Adding placeholder images for blog components...${NC}"
  
  # Ensure images directory exists
  mkdir -p "$PROJECT_NAME/public/images"
  
  # Create placeholder images directory
  touch "$PROJECT_NAME/public/images/blog-placeholder.jpg"
  touch "$PROJECT_NAME/public/images/author.jpg"
  
  # Note to remind user to replace placeholders
  echo "Remember to replace placeholder images in public/images/ with real content." >> "$PROJECT_NAME/README.md"
elif [ "$NICHE" = "portfolio" ]; then
  echo -e "${CYAN}Adding placeholder images for portfolio components...${NC}"
  
  # Ensure images directory exists
  mkdir -p "$PROJECT_NAME/public/images"
  
  # Create placeholder images directory
  touch "$PROJECT_NAME/public/images/project1.jpg"
  touch "$PROJECT_NAME/public/images/project2.jpg"
  
  # Note to remind user to replace placeholders
  echo "Remember to replace placeholder images in public/images/ with real content." >> "$PROJECT_NAME/README.md"
fi

# Copy base templates, excluding those we'll generate dynamically
cp -r "$TEMPLATE_DIR/config/"* "$PROJECT_NAME/"
cp -r "$TEMPLATE_DIR/components/"* "$PROJECT_NAME/components/"
cp -r "$TEMPLATE_DIR/pages/"* "$PROJECT_NAME/pages/"
cp -r "$TEMPLATE_DIR/styles/"* "$PROJECT_NAME/styles/"
cp -r "$TEMPLATE_DIR/utils/"* "$PROJECT_NAME/utils/"

# Update package.json with project name
echo -e "${CYAN}Updating package.json with project name...${NC}"
sed -i "s/\"name\": \"PLACEHOLDER_PROJECT_NAME\"/\"name\": \"$PROJECT_NAME\"/" "$PROJECT_NAME/package.json"

# Copy niche-specific components if they exist
if [ -d "$TEMPLATE_DIR/niche/$NICHE" ]; then
  echo -e "${CYAN}Adding $NICHE-specific components...${NC}"
  # Create niche directory inside components
  mkdir -p "$PROJECT_NAME/components/niche"
  
  # Copy all tsx components from the niche directory to components/niche
  find "$TEMPLATE_DIR/niche/$NICHE" -name "*.tsx" -exec cp {} "$PROJECT_NAME/components/niche/" \;
  
  # Also copy the project-config.json if it exists
  if [ -f "$TEMPLATE_DIR/niche/$NICHE/project-config.json" ]; then
    cp "$TEMPLATE_DIR/niche/$NICHE/project-config.json" "$PROJECT_NAME/"
    
    # Update with user-provided values
    sed -i "s/\"audience\": \".*\"/\"audience\": \"$AUDIENCE\"/" "$PROJECT_NAME/project-config.json"
    sed -i "s/\"brandTone\": \".*\"/\"brandTone\": \"$BRAND_TONE\"/" "$PROJECT_NAME/project-config.json"
  fi
else
  echo -e "${YELLOW}No components found for $NICHE niche${NC}"
fi

# Create Header.tsx with project name
cat > "$PROJECT_NAME/components/Header.tsx" << EOF
import React, { useState } from 'react';
import Link from 'next/link';
import { motion } from 'framer-motion';

const Header = () => {
  const [isMenuOpen, setIsMenuOpen] = useState(false);

  return (
    <header className="sticky top-0 z-50 bg-white shadow-sm border-b border-gray-100">
      <div className="container mx-auto flex justify-between items-center h-16 px-4">
        <Link href="/" className="text-xl font-bold text-gray-900 hover:text-indigo-600 transition-colors">
          ${PROJECT_NAME}
        </Link>
        
        {/* Desktop Navigation */}
        <nav className="hidden md:flex space-x-1">
          <Link href="/" className="px-4 py-2 text-gray-600 hover:text-indigo-600 hover:bg-indigo-50 rounded-md transition-colors">
            Home
          </Link>
          <Link href="/about" className="px-4 py-2 text-gray-600 hover:text-indigo-600 hover:bg-indigo-50 rounded-md transition-colors">
            About
          </Link>
          <Link href="/contact" className="px-4 py-2 text-gray-600 hover:text-indigo-600 hover:bg-indigo-50 rounded-md transition-colors">
            Contact
          </Link>
        </nav>
        
        {/* Mobile menu button */}
        <button 
          className="md:hidden text-gray-500 hover:text-gray-700 focus:outline-none"
          onClick={() => setIsMenuOpen(!isMenuOpen)}
        >
          <span className="sr-only">Open main menu</span>
          <svg className="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path 
              strokeLinecap="round" 
              strokeLinejoin="round" 
              strokeWidth={2} 
              d={isMenuOpen ? "M6 18L18 6M6 6l12 12" : "M4 6h16M4 12h16M4 18h16"} 
            />
          </svg>
        </button>
      </div>
      
      {/* Mobile Navigation */}
      {isMenuOpen && (
        <motion.div 
          initial={{ opacity: 0, height: 0 }}
          animate={{ opacity: 1, height: 'auto' }}
          exit={{ opacity: 0, height: 0 }}
          className="md:hidden border-t border-gray-100"
        >
          <div className="container mx-auto px-4 py-3 space-y-1">
            <Link href="/" 
              className="block py-2 px-3 text-gray-600 hover:text-indigo-600 hover:bg-indigo-50 rounded-md"
              onClick={() => setIsMenuOpen(false)}
            >
              Home
            </Link>
            <Link href="/about" 
              className="block py-2 px-3 text-gray-600 hover:text-indigo-600 hover:bg-indigo-50 rounded-md"
              onClick={() => setIsMenuOpen(false)}
            >
              About
            </Link>
            <Link href="/contact" 
              className="block py-2 px-3 text-gray-600 hover:text-indigo-600 hover:bg-indigo-50 rounded-md"
              onClick={() => setIsMenuOpen(false)}
            >
              Contact
            </Link>
          </div>
        </motion.div>
      )}
    </header>
  );
};

export default Header;
EOF

# Create Footer.tsx with project name
cat > "$PROJECT_NAME/components/Footer.tsx" << EOF
import React from 'react';
import Link from 'next/link';

const Footer = () => (
  <footer className="bg-blue-700 text-white">
    <div className="container mx-auto py-12 px-4">
      <div className="grid grid-cols-1 md:grid-cols-3 gap-12">
        <div>
          <h3 className="text-lg font-bold text-white mb-4">${PROJECT_NAME}</h3>
          <p className="text-blue-100 mb-4">A modern, responsive website built with Next.js and Tailwind CSS.</p>
        </div>
        <div>
          <h3 className="text-lg font-bold text-white mb-4">Quick Links</h3>
          <ul className="space-y-2">
            <li>
              <Link href="/" className="text-blue-100 hover:text-white transition-colors">Home</Link>
            </li>
            <li>
              <Link href="/about" className="text-blue-100 hover:text-white transition-colors">About</Link>
            </li>
            <li>
              <Link href="/contact" className="text-blue-100 hover:text-white transition-colors">Contact</Link>
            </li>
          </ul>
        </div>
        <div>
          <h3 className="text-lg font-bold text-white mb-4">Connect</h3>
          <p className="text-blue-100 mb-4">Follow us on social media for updates.</p>
          <div className="flex space-x-4">
            <a href="#" aria-label="X (Twitter)" className="text-blue-100 hover:text-white transition-colors">
              <svg className="h-6 w-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/>
              </svg>
            </a>
            <a href="#" aria-label="GitHub" className="text-blue-100 hover:text-white transition-colors">
              <svg className="h-6 w-6" fill="currentColor" viewBox="0 0 24 24" aria-hidden="true">
                <path fillRule="evenodd" d="M12 2C6.477 2 2 6.484 2 12.017c0 4.425 2.865 8.18 6.839 9.504.5.092.682-.217.682-.483 0-.237-.008-.868-.013-1.703-2.782.605-3.369-1.343-3.369-1.343-.454-1.158-1.11-1.466-1.11-1.466-.908-.62.069-.608.069-.608 1.003.07 1.531 1.032 1.531 1.032.892 1.53 2.341 1.088 2.91.832.092-.647.35-1.088.636-1.338-2.22-.253-4.555-1.113-4.555-4.951 0-1.093.39-1.988 1.029-2.688-.103-.253-.446-1.272.098-2.65 0 0 .84-.27 2.75 1.026A9.564 9.564 0 0112 6.844c.85.004 1.705.115 2.504.337 1.909-1.296 2.747-1.027 2.747-1.027.546 1.379.202 2.398.1 2.651.64.7 1.028 1.595 1.028 2.688 0 3.848-2.339 4.695-4.566 4.943.359.309.678.92.678 1.855 0 1.338-.012 2.419-.012 2.747 0 .268.18.58.688.482A10.019 10.019 0 0022 12.017C22 6.484 17.522 2 12 2z" clipRule="evenodd"></path>
              </svg>
            </a>
          </div>
        </div>
      </div>
      <div className="mt-12 py-4 border-t border-blue-600 text-center">
        <p className="text-white font-medium">&copy; {new Date().getFullYear()} ${PROJECT_NAME}. All rights reserved.</p>
      </div>
    </div>
  </footer>
);

export default Footer;
EOF

# Create README.md with project name
cat > "$PROJECT_NAME/README.md" << EOF
# ${PROJECT_NAME}

This project is a template for a static Next.js site with TypeScript and Tailwind CSS.

## Features

- **Static Generation:** Uses Next.js's static export mode.
- **Tailwind CSS:** Utility-first styling.
- **TypeScript:** For type safety.
- **Framer Motion:** For page animations.
- **External Integrations:** Example components for Formspree, Stripe, Disqus, and social media feeds.
- **Caching:** Recommendations for browser caching and optional service worker caching.

## Getting Started

1. **Install dependencies:**

   \`\`\`
   npm install
   \`\`\`

2. **Run development server:**

   \`\`\`
   npm run dev
   \`\`\`

3. **Build and Export:**

   \`\`\`
   npm run build && npm run export
   \`\`\`

4. **Deploy:** Upload the contents of the \`out/\` folder to your shared hosting service.

## Caching and Optimization

- Configure your server (or .htaccess for Apache) to cache static assets.
- Consider using a CDN for serving static files.
- Optionally, implement a service worker for offline caching using libraries like Workbox.

Happy coding!
EOF

# Create home page with project name and niche components - improved with dynamic component detection
cp "$TEMPLATE_DIR/pages/index.tsx" "$PROJECT_NAME/pages/index.tsx"
# Replace the project name placeholder in the index file
sed -i "s/Welcome to Your Site/Welcome to ${PROJECT_NAME}/" "$PROJECT_NAME/pages/index.tsx"

# Create about page
cp "$TEMPLATE_DIR/pages/about.tsx" "$PROJECT_NAME/pages/about.tsx"

# Create contact page
cp "$TEMPLATE_DIR/pages/contact.tsx" "$PROJECT_NAME/pages/contact.tsx"

# Process the pages based on niche components
if [ "$NICHE" = "ecommerce" ]; then
  # Import ecommerce components if they exist
  for file in "$PROJECT_NAME/components/niche/"*.tsx; do
    if [ -f "$file" ]; then
      component=$(basename "$file" .tsx)
      sed -i "1s/^/import $component from '..\\/components\\/niche\\/$component';\n/" "$PROJECT_NAME/pages/index.tsx"
    fi
  done
  # Add motion import if not already present
  grep -q "import { motion } from 'framer-motion';" "$PROJECT_NAME/pages/index.tsx" || sed -i "1s/^/import { motion } from 'framer-motion';\n/" "$PROJECT_NAME/pages/index.tsx"
  # Add product section to index page
  sed -i "/<\\/section>/a\\
      <div className=\"container mx-auto px-4\">\\
        <h2 className=\"text-3xl font-bold mb-8 text-gray-900\">Featured Products</h2>\\
        <div className=\"grid grid-cols-1 md:grid-cols-3 gap-8\">\\
          {/* Add ProductCard components here if available */}\\
          <motion.div whileHover={{ y: -5 }} className=\"transition-all\">\\
            <ProductCard id=\"1\" name=\"Product 1\" price={99.99} imageUrl=\"/images/product1.jpg\" category=\"Category\" rating={4.5} />\\
          </motion.div>\\
          <motion.div whileHover={{ y: -5 }} className=\"transition-all\">\\
            <ProductCard id=\"2\" name=\"Product 2\" price={149.99} imageUrl=\"/images/product2.jpg\" category=\"Category\" rating={4.8} onSale />\\
          </motion.div>\\
          <motion.div whileHover={{ y: -5 }} className=\"transition-all\">\\
            <ProductCard id=\"3\" name=\"Product 3\" price={199.99} imageUrl=\"/images/product3.jpg\" category=\"Category\" rating={4.2} />\\
          </motion.div>\\
        </div>\\
      </div>" "$PROJECT_NAME/pages/index.tsx"
elif [ "$NICHE" = "blog" ]; then
  # Import blog components if they exist
  for file in "$PROJECT_NAME/components/niche/"*.tsx; do
    if [ -f "$file" ]; then
      component=$(basename "$file" .tsx)
      sed -i "1s/^/import $component from '..\\/components\\/niche\\/$component';\n/" "$PROJECT_NAME/pages/index.tsx"
    fi
  done
  # Add motion import if not already present
  grep -q "import { motion } from 'framer-motion';" "$PROJECT_NAME/pages/index.tsx" || sed -i "1s/^/import { motion } from 'framer-motion';\n/" "$PROJECT_NAME/pages/index.tsx"
  # Add blog section to index page
  sed -i "/<\\/section>/a\\
      <div className=\"container mx-auto px-4\">\\
        <h2 className=\"text-3xl font-bold mb-8 text-gray-900\">Latest Articles</h2>\\
        <div className=\"grid grid-cols-1 lg:grid-cols-3 gap-8\">\\
          <div className=\"lg:col-span-2 space-y-8\">\\
            <motion.div whileHover={{ y: -5 }} className=\"transition-all\">\\
              <BlogPost\\
                title=\"Getting Started with Next.js\"\\
                content=\"Learn how to build modern websites with Next.js\"\\
                excerpt=\"A beginner's guide to building modern websites with Next.js.\"\\
                coverImage=\"/images/blog-placeholder.jpg\"\\
                slug=\"getting-started-with-nextjs\"\\
                categories={['Next.js', 'React', 'Web Development']}\\
                author={{\\
                  name: \"John Doe\",\\
                  avatar: \"/images/author.jpg\"\\
                }}\\
                date=\"2023-03-15\"\\
                isFeatured\\
              />\\
            </motion.div>\\
            <div className=\"mt-10 bg-white rounded-xl shadow-lg p-6 border border-gray-100\">\\
              <AuthorBio\\
                name=\"John Doe\"\\
                bio=\"Web developer and technical writer with over 5 years of experience building modern web applications.\"\\
                image=\"/images/author.jpg\"\\
                role=\"Senior Frontend Developer\"\\
              />\\
            </div>\\
          </div>\\
          <div className=\"lg:col-span-1\">\\
            <div className=\"sticky top-8 space-y-8\">\\
              <div className=\"bg-white rounded-xl shadow-lg p-6 border border-gray-100\">\\
                <CategoryList categories={['Next.js', 'React', 'Web Development']} />\\
              </div>\\
              <div className=\"bg-white p-6 rounded-xl shadow-lg border border-gray-100\">\\
                <h3 className=\"text-lg font-semibold mb-4\">Subscribe to Newsletter</h3>\\
                <p className=\"text-gray-600 mb-4 text-sm\">Get the latest articles and news delivered to your inbox.</p>\\
                <div className=\"flex\">\\
                  <input\\
                    type=\"email\"\\
                    placeholder=\"Your email address\"\\
                    className=\"px-4 py-2 border border-gray-300 rounded-l-md flex-grow focus:outline-none focus:ring-2 focus:ring-indigo-500\"\\
                  />\\
                  <button className=\"bg-indigo-600 text-white px-4 py-2 rounded-r-md hover:bg-indigo-700 transition-colors\">Subscribe</button>\\
                </div>\\
              </div>\\
            </div>\\
          </div>\\
        </div>\\
      </div>" "$PROJECT_NAME/pages/index.tsx"
elif [ "$NICHE" = "portfolio" ]; then
  # Import portfolio components if they exist
  for file in "$PROJECT_NAME/components/niche/"*.tsx; do
    if [ -f "$file" ]; then
      component=$(basename "$file" .tsx)
      sed -i "1s/^/import $component from '..\\/components\\/niche\\/$component';\n/" "$PROJECT_NAME/pages/index.tsx"
    fi
  done
  # Add motion import if not already present
  grep -q "import { motion } from 'framer-motion';" "$PROJECT_NAME/pages/index.tsx" || sed -i "1s/^/import { motion } from 'framer-motion';\n/" "$PROJECT_NAME/pages/index.tsx"
  # Add portfolio section to index page
  sed -i "/<\\/section>/a\\
      <div className=\"container mx-auto px-4\">\\
        <h2 className=\"text-3xl font-bold mb-8 text-gray-900\">My Work</h2>\\
        <div className=\"grid grid-cols-1 md:grid-cols-2 gap-8\">\\
          <motion.div whileHover={{ y: -5 }} className=\"transition-all\">\\
            <ProjectCard\\
              title=\"Project 1\"\\
              description=\"This is a description of your amazing project.\"\\
              image=\"/images/project1.jpg\"\\
              tags={['React', 'Next.js', 'Tailwind']}\\
              link=\"#\"\\
              featured\\
            />\\
          </motion.div>\\
          <motion.div whileHover={{ y: -5 }} className=\"transition-all\">\\
            <ProjectCard\\
              title=\"Project 2\"\\
              description=\"This is a description of your amazing project.\"\\
              image=\"/images/project2.jpg\"\\
              tags={['TypeScript', 'Node.js', 'MongoDB']}\\
              link=\"#\"\\
            />\\
          </motion.div>\\
        </div>\\
        {/* Skills section */}\\
        <div className=\"mt-16\">\\
          <h2 className=\"text-3xl font-bold mb-8 text-gray-900\">My Skills</h2>\\
          <div className=\"bg-white rounded-xl shadow-lg p-6 border border-gray-100\">\\
            <Skills categories={[\\
              {\\
                name: \"Frontend\",\\
                skills: [\\
                  { name: \"React\", level: 5 },\\
                  { name: \"JavaScript\", level: 5 },\\
                  { name: \"CSS\", level: 4 },\\
                  { name: \"HTML5\", level: 5 }\\
                ]\\
              },\\
              {\\
                name: \"Backend\",\\
                skills: [\\
                  { name: \"Node.js\", level: 4 },\\
                  { name: \"Express\", level: 3 },\\
                  { name: \"MongoDB\", level: 3 }\\
                ]\\
              }\\
            ]} />\\
          </div>\\
        </div>\\
      </div>" "$PROJECT_NAME/pages/index.tsx"
elif [ "$NICHE" = "technology" ]; then
  # Add motion import if not already present
  grep -q "import { motion } from 'framer-motion';" "$PROJECT_NAME/pages/index.tsx" || sed -i "1s/^/import { motion } from 'framer-motion';\n/" "$PROJECT_NAME/pages/index.tsx"
  # Add technology section to index page
  sed -i "/<\\/section>/a\\
      <div className=\"container mx-auto px-4\">\\
        <h2 className=\"text-3xl font-bold mb-8 text-gray-900\">Our Features</h2>\\
        <div className=\"grid grid-cols-1 md:grid-cols-3 gap-8\">\\
          <motion.div whileHover={{ y: -5 }} className=\"bg-white rounded-xl shadow-lg p-6 transition-all hover:shadow-xl border border-gray-100\">\\
            <div className=\"bg-indigo-100 text-indigo-600 p-3 rounded-full w-14 h-14 flex items-center justify-center mb-4\">\\
              <svg xmlns=\"http://www.w3.org/2000/svg\" className=\"h-8 w-8\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\\
                <path strokeLinecap=\"round\" strokeLinejoin=\"round\" strokeWidth={2} d=\"M5 13l4 4L19 7\" />\\
              </svg>\\
            </div>\\
            <h3 className=\"text-xl font-semibold mb-2 text-gray-800\">Easy Integration</h3>\\
            <p className=\"text-gray-600\">Seamlessly integrate with your existing tech stack.</p>\\
          </motion.div>\\
          <motion.div whileHover={{ y: -5 }} className=\"bg-white rounded-xl shadow-lg p-6 transition-all hover:shadow-xl border border-gray-100\">\\
            <div className=\"bg-indigo-100 text-indigo-600 p-3 rounded-full w-14 h-14 flex items-center justify-center mb-4\">\\
              <svg xmlns=\"http://www.w3.org/2000/svg\" className=\"h-8 w-8\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\\
                <path strokeLinecap=\"round\" strokeLinejoin=\"round\" strokeWidth={2} d=\"M13 10V3L4 14h7v7l9-11h-7z\" />\\
              </svg>\\
            </div>\\
            <h3 className=\"text-xl font-semibold mb-2 text-gray-800\">Lightning Fast</h3>\\
            <p className=\"text-gray-600\">Optimized performance for the best user experience.</p>\\
          </motion.div>\\
          <motion.div whileHover={{ y: -5 }} className=\"bg-white rounded-xl shadow-lg p-6 transition-all hover:shadow-xl border border-gray-100\">\\
            <div className=\"bg-indigo-100 text-indigo-600 p-3 rounded-full w-14 h-14 flex items-center justify-center mb-4\">\\
              <svg xmlns=\"http://www.w3.org/2000/svg\" className=\"h-8 w-8\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\\
                <path strokeLinecap=\"round\" strokeLinejoin=\"round\" strokeWidth={2} d=\"M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z\" />\\
              </svg>\\
            </div>\\
            <h3 className=\"text-xl font-semibold mb-2 text-gray-800\">Secure By Design</h3>\\
            <p className=\"text-gray-600\">Built with security as a fundamental principle.</p>\\
          </motion.div>\\
        </div>\\
        \\
        <div className=\"mt-16 bg-white rounded-xl shadow-lg p-8 border border-gray-100\">\\
          <h2 className=\"text-3xl font-bold mb-8 text-gray-900\">Pricing Plans</h2>\\
          <div className=\"grid grid-cols-1 md:grid-cols-3 gap-8\">\\
            <motion.div whileHover={{ y: -5 }} className=\"border border-gray-200 rounded-xl p-6 transition-all hover:shadow-lg\">\\
              <h3 className=\"text-xl font-bold mb-2\">Basic</h3>\\
              <div className=\"text-3xl font-bold mb-4\">$9<span className=\"text-lg text-gray-500\">/mo</span></div>\\
              <ul className=\"space-y-2 mb-6\">\\
                <li className=\"flex items-center\">\\
                  <svg className=\"h-5 w-5 text-green-500 mr-2\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\\
                    <path strokeLinecap=\"round\" strokeLinejoin=\"round\" strokeWidth=\"2\" d=\"M5 13l4 4L19 7\" />\\
                  </svg>\\
                  <span>Feature one</span>\\
                </li>\\
                <li className=\"flex items-center\">\\
                  <svg className=\"h-5 w-5 text-green-500 mr-2\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\\
                    <path strokeLinecap=\"round\" strokeLinejoin=\"round\" strokeWidth=\"2\" d=\"M5 13l4 4L19 7\" />\\
                  </svg>\\
                  <span>Feature two</span>\\
                </li>\\
              </ul>\\
              <button className=\"w-full py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700 transition-colors\">\\
                Get Started\\
              </button>\\
            </motion.div>\\
            <motion.div whileHover={{ y: -5 }} className=\"border-2 border-indigo-500 rounded-xl p-6 transition-all hover:shadow-lg relative\">\\
              <div className=\"absolute top-0 right-0 bg-indigo-500 text-white text-xs font-bold px-3 py-1 rounded-bl-lg rounded-tr-lg\">\\
                POPULAR\\
              </div>\\
              <h3 className=\"text-xl font-bold mb-2\">Pro</h3>\\
              <div className=\"text-3xl font-bold mb-4\">$29<span className=\"text-lg text-gray-500\">/mo</span></div>\\
              <ul className=\"space-y-2 mb-6\">\\
                <li className=\"flex items-center\">\\
                  <svg className=\"h-5 w-5 text-green-500 mr-2\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\\
                    <path strokeLinecap=\"round\" strokeLinejoin=\"round\" strokeWidth=\"2\" d=\"M5 13l4 4L19 7\" />\\
                  </svg>\\
                  <span>All Basic features</span>\\
                </li>\\
                <li className=\"flex items-center\">\\
                  <svg className=\"h-5 w-5 text-green-500 mr-2\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\\
                    <path strokeLinecap=\"round\" strokeLinejoin=\"round\" strokeWidth=\"2\" d=\"M5 13l4 4L19 7\" />\\
                  </svg>\\
                  <span>Pro feature one</span>\\
                </li>\\
                <li className=\"flex items-center\">\\
                  <svg className=\"h-5 w-5 text-green-500 mr-2\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\\
                    <path strokeLinecap=\"round\" strokeLinejoin=\"round\" strokeWidth=\"2\" d=\"M5 13l4 4L19 7\" />\\
                  </svg>\\
                  <span>Pro feature two</span>\\
                </li>\\
              </ul>\\
              <button className=\"w-full py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700 transition-colors\">\\
                Get Started\\
              </button>\\
            </motion.div>\\
            <motion.div whileHover={{ y: -5 }} className=\"border border-gray-200 rounded-xl p-6 transition-all hover:shadow-lg\">\\
              <h3 className=\"text-xl font-bold mb-2\">Enterprise</h3>\\
              <div className=\"text-3xl font-bold mb-4\">$99<span className=\"text-lg text-gray-500\">/mo</span></div>\\
              <ul className=\"space-y-2 mb-6\">\\
                <li className=\"flex items-center\">\\
                  <svg className=\"h-5 w-5 text-green-500 mr-2\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\\
                    <path strokeLinecap=\"round\" strokeLinejoin=\"round\" strokeWidth=\"2\" d=\"M5 13l4 4L19 7\" />\\
                  </svg>\\
                  <span>All Pro features</span>\\
                </li>\\
                <li className=\"flex items-center\">\\
                  <svg className=\"h-5 w-5 text-green-500 mr-2\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\\
                    <path strokeLinecap=\"round\" strokeLinejoin=\"round\" strokeWidth=\"2\" d=\"M5 13l4 4L19 7\" />\\
                  </svg>\\
                  <span>Enterprise feature</span>\\
                </li>\\
                <li className=\"flex items-center\">\\
                  <svg className=\"h-5 w-5 text-green-500 mr-2\" fill=\"none\" viewBox=\"0 0 24 24\" stroke=\"currentColor\">\\
                    <path strokeLinecap=\"round\" strokeLinejoin=\"round\" strokeWidth=\"2\" d=\"M5 13l4 4L19 7\" />\\
                  </svg>\\
                  <span>24/7 Support</span>\\
                </li>\\
              </ul>\\
              <button className=\"w-full py-2 bg-indigo-600 text-white rounded-md hover:bg-indigo-700 transition-colors\">\\
                Contact Sales\\
              </button>\\
            </motion.div>\\
          </div>\\
        </div>\\
      </div>" "$PROJECT_NAME/pages/index.tsx"
fi

# Copy Cursor AI rule files from generator to new project
echo -e "${CYAN}Copying Cursor AI rule files...${NC}"
cp -r "$RULES_GENERATOR/.cursor/rules/"* "$PROJECT_NAME/.cursor/rules/"
cp "$RULES_GENERATOR/scripts/setup-cursor-rules-v1.sh" "$PROJECT_NAME/.cursor/scripts/"
cp "$RULES_GENERATOR/scripts/enhance-design-rules.sh" "$PROJECT_NAME/.cursor/scripts/"

# Copy design reference screenshots if they exist
echo -e "${CYAN}Copying design reference screenshots...${NC}"
if [ -d "$RULES_GENERATOR/.cursor/design-reference/$NICHE" ]; then
  cp -r "$RULES_GENERATOR/.cursor/design-reference/$NICHE/"* "$PROJECT_NAME/.cursor/design-reference/"
  echo "Design reference screenshots copied from $NICHE niche directory."
elif [ -d "$RULES_GENERATOR/.cursor/design-reference" ]; then
  cp -r "$RULES_GENERATOR/.cursor/design-reference/"* "$PROJECT_NAME/.cursor/design-reference/"
  echo "Generic design reference screenshots copied."
else
  echo -e "${YELLOW}No design reference screenshots found.${NC}"
  mkdir -p "$PROJECT_NAME/.cursor/design-reference"
  echo "# Design Reference" > "$PROJECT_NAME/.cursor/design-reference/README.md"
  echo "Place website screenshots in this directory for Cursor AI to reference when designing components." >> "$PROJECT_NAME/.cursor/design-reference/README.md"
fi

# Change directory to project and run the Cursor AI setup scripts there
echo -e "${CYAN}Setting up Cursor AI rules...${NC}"
CURRENT_DIR="$(pwd)"
cd "$PROJECT_NAME"

# Make scripts executable
chmod +x .cursor/scripts/setup-cursor-rules-v1.sh
chmod +x .cursor/scripts/enhance-design-rules.sh

# Run the scripts
./.cursor/scripts/setup-cursor-rules-v1.sh
./.cursor/scripts/enhance-design-rules.sh

# Return to original directory
cd "$CURRENT_DIR"

# Create project-config.json
cat > "$PROJECT_NAME/project-config.json" << EOF
{
    "niche": "$NICHE",
    "audience": "$AUDIENCE",
    "brandTone": "$BRAND_TONE",
    "aiPreferences": {
      "styleGuide": "tailwind",
      "codeStyle": "functional",
      "componentPattern": "atomic",
      "accessibility": "strict",
      "performance": "optimized",
      "testing": "comprehensive"
    },
    "features": {
      "authentication": true,
      "analytics": true,
      "seo": true,
      "responsive": true,
      "darkMode": true
    },
    "dependencies": {
      "ui": "tailwind",
      "animations": "framer-motion",
      "forms": "react-hook-form",
      "validation": "zod",
      "state": "zustand"
    }
  }
EOF

# Create project-specific design instruction
cat > "$PROJECT_NAME/.cursor/instructions/niche.mdc" << EOF
---
description: Niche-specific guidance for ${NICHE} projects
globs: **/*.{js,ts,jsx,tsx,css}
---

# ${NICHE^} Next.js Project Guidance

## 📊 Project-Specific Information
- **Industry/Niche:** ${NICHE}
- **Target Audience:** ${AUDIENCE}
- **Brand Tone:** ${BRAND_TONE}

## 🎯 Key Considerations
- Optimize user experience specifically for ${AUDIENCE}
- Maintain a ${BRAND_TONE} tone throughout the interface and content
- Focus on conversion-optimized patterns for ${NICHE} sites
- Implement accessibility best practices for broad usability
- Ensure responsive design works flawlessly across all devices

EOF

# Copy niche-specific rules if they exist
if [ -f "$RULES_GENERATOR/.cursor/rules/niches/${NICHE}/${NICHE}_rules.mdc" ]; then
  echo -e "${CYAN}Adding ${NICHE}-specific Cursor AI rules...${NC}"
  cp "$RULES_GENERATOR/.cursor/rules/niches/${NICHE}/${NICHE}_rules.mdc" "$PROJECT_NAME/.cursor/instructions/${NICHE}.mdc"
else
  echo -e "${YELLOW}No specific rules found for ${NICHE} niche${NC}"
fi

echo -e "${GREEN}✅ Project setup complete: $PROJECT_NAME${NC}"
echo -e "${CYAN}Next steps:${NC}"
echo "  1. cd $PROJECT_NAME"
echo "  2. npm install --legacy-peer-deps"
echo "  3. npm run dev"