# 🚀 Next.js Template Generator

A comprehensive tool for generating modern, visually appealing Next.js projects with specialized templates for different niches, Tailwind CSS styling, and seamless Cursor AI integration.

## ✨ Features

- 🎨 Custom project templates for different niches (ecommerce, blog, portfolio, technology)
- 💫 Modern UI with gradient hero sections and responsive layouts 
- 🔧 Pre-configured Tailwind CSS with extended color schemes and animations
- 📱 Responsive layouts with mobile-optimized navigation
- 🤖 Seamless integration with Cursor AI for intelligent code assistance
- 🎭 Framer Motion animations for smooth page transitions and UI effects
- 🧩 Interactive components (contact forms, product displays, navigation)
- ♿ Accessibility-focused design elements

## 🏁 Getting Started

1. 📥 Clone this repository
2. 🔑 Make the setup script executable: `chmod +x scripts/setup-project-v1.sh`
3. 🔄 Run the setup script: `./scripts/setup-project-v1.sh`
4. 📝 Follow the prompts to create your project
5. ✏️ Enter your site name, niche, target audience, and brand tone

The generator will create a complete project with niche-specific components and optimized layouts based on your selections.

### 📂 Project Separation Best Practices

To maintain a clean separation between the generator and your new projects:

1. 🏠 **Use a Different Directory**: Always move your generated project to a separate directory from the generator.
   ```bash
   # After generation, move your project to its final location
   mv ./Site1 ~/projects/my-new-site
   ```

2. 🧹 **Clean Start**: This ensures your project doesn't inherit any generator-specific configurations or rules.

3. 🔄 **Fresh Git Repository**: Initialize a new git repository for your project:
   ```bash
   cd ~/projects/my-new-site
   git init
   git add .
   git commit -m "Initial commit from template generator"
   ```

4. 📝 **Customize Your README**: Replace or modify the generated README to better match your specific project (see README customization section below).

## 🏪 Available Niches

### 🛒 E-commerce
- 🏷️ ProductCard component with pricing and sale indicators
- 🛍️ Cart functionality with animations
- 💳 Checkout process with form validation
- 📊 Product grid layouts optimized for conversions

### 📰 Blog
- 📝 BlogPost component with featured post highlighting
- 🔖 CategoryList for organizing and filtering content
- 👤 AuthorBio for writer profiles with social links
- 📮 Newsletter subscription components

### 🖼️ Portfolio
- 🖌️ ProjectCard for showcasing work with modern hover effects
- 🧠 Skills component for highlighting expertise with visual indicators
- ⏳ Timeline for displaying professional experience
- 🏢 Work galleries with filtering options

### 💻 Technology/SaaS
- ⚙️ Feature showcase sections with icons and animations
- 💰 Pricing tables and comparison components
- 🔌 Integration display components
- 💬 Client testimonial sections

## 🎭 Modern Design System

All templates include a consistent design system featuring:

- 🌈 Gradient hero sections with responsive text
- 📟 Card-based UI components with hover effects
- 🎨 Unified color schemes adaptable to brand colors
- 📄 Typography system with optimized readability
- 📱 Mobile-first responsive layouts
- ✨ Animated transitions and micro-interactions
- 📋 Form components with validation and feedback

## 🛠️ Customizing Templates

You can customize the templates by modifying files in the `templates` directory:

- 🧩 `templates/components`: Base components used in all projects (Header, Footer, Layout)
- 📄 `templates/pages`: Basic pages with modern layouts (home, about, contact)
- 🎨 `templates/styles`: Global styles and enhanced Tailwind configuration
- 🏪 `templates/niche`: Niche-specific components for specialized functionality

## 📝 README Customization Guide

The generated README provides a starting point, but customizing it for your specific project offers several benefits:

### 🎯 Why Customize Your README

1. 🔍 **Project-Specific Focus**: Tailor documentation to your project's unique features and goals
2. 🧭 **Better Onboarding**: Help new team members understand your specific implementation
3. 📋 **Clear Requirements**: Document dependencies and setup steps specific to your project
4. 🏗️ **Architecture Documentation**: Describe your particular architectural decisions
5. 🧪 **Testing Guidelines**: Add instructions for your project's testing approach

### 💡 Recommended Sections to Add

1. 🌟 **Project Overview**: Brief description of your specific application purpose
2. 🔌 **API Integration Details**: Document external services your app connects with
3. 💾 **Data Models**: Explain your data structure and relationships
4. 📱 **Feature Roadmap**: Outline planned future enhancements
5. 🧰 **Environment Setup**: List any special environment configurations
6. 🔑 **Authentication**: Document your auth implementation (if applicable)
7. 🔄 **CI/CD Pipeline**: Explain your deployment workflow
8. 📊 **Analytics**: Detail any analytics implementation

### ⚡ Leverage AI to Enhance Your README

Use Cursor AI to enhance your README by:

1. 📋 Asking it to generate section-specific content based on your codebase
2. 🖼️ Creating diagrams or flowcharts that explain your architecture
3. 📊 Generating tables that document your API endpoints
4. 🔍 Extracting key information from your codebase to document
5. 🧪 Creating examples showing how to use your components

## 🤖 Cursor AI Integration

This generator seamlessly integrates with Cursor AI to accelerate development:

1. 🧠 **Project Context Awareness**: Generated project-config.json provides Cursor AI with context about your project's niche, audience, and brand tone.

2. 🎯 **Niche-Specific Rules**: Custom AI rules are loaded based on your selected niche, enabling Cursor to provide more relevant code suggestions.

3. 🎨 **Design Consistency**: The AI gets instructions on your project's design language, helping maintain visual consistency when generating new components.

4. 🔍 **Component Recognition**: Cursor AI can understand the relationships between your components and suggest improvements or extensions.

5. 💡 **Development Assistance**: Common patterns and best practices for your specific niche are provided to the AI, improving code quality.

6. 🖼️ **Design Reference Screenshots**: Store website screenshots in `.cursor/design-reference` that Cursor AI can reference when designing components to match specific visual styles.

### ⚡ How it Enhances Your Workflow

- 🚀 **Faster Prototyping**: Generate complete, styled pages with a single command
- 🧠 **Reduced Decision Fatigue**: Pre-configured design systems eliminate common design decisions
- 💡 **Intelligent Suggestions**: Cursor AI understands your project context and can suggest appropriate code
- 🎨 **Consistent Styling**: The AI helps maintain your design system across new components
- 📚 **Learning Tool**: Example components demonstrate modern React patterns and Tailwind techniques
- 🎭 **Visual Design Matching**: Reference screenshots from existing sites to guide AI in matching specific design styles

### 🖼️ Using Design Reference Screenshots

The generator now creates a dedicated `.cursor/design-reference` directory in each new project for storing UI screenshots:

1. **Organization by Niche**:
   - Screenshots can be organized by niche (ecommerce, blog, portfolio, technology)
   - Niche-specific designs are automatically copied to new projects of that niche

2. **How to Use**:
   - Take screenshots of websites or UI elements with designs you like
   - Place them in the `.cursor/design-reference` directory
   - Reference these images in your prompts to Cursor AI

3. **Example Prompts**:
   - "Create a product card component similar to the design in `.cursor/design-reference/product-card.png`"
   - "Update this navbar to match the style shown in `.cursor/design-reference/navbar-example.jpg`"

4. **Benefits**:
   - Provides visual context that text-based instructions can't capture
   - Ensures design consistency across your project
   - Reduces the need for detailed design explanations
   - Helps Cursor AI understand your aesthetic preferences

### 📸 Taking High-Quality Screenshots for Design Reference

To get the most out of the design reference feature, you'll want to capture high-quality screenshots of websites and UI elements. Here's how to take full site screenshots using browser developer tools:

#### Google Chrome
1. Open the website you want to capture
2. Press `F12` or `Ctrl+Shift+I` (Windows/Linux) or `Cmd+Option+I` (Mac) to open Developer Tools
3. Press `Ctrl+Shift+P` (Windows/Linux) or `Cmd+Shift+P` (Mac) to open the Command Menu
4. Type "screenshot" and you'll see several options:
   - **Capture full size screenshot**: Takes a screenshot of the entire page, including parts not visible in the viewport
   - **Capture node screenshot**: Captures a specific element (select an element in the Elements panel first)
   - **Capture screenshot**: Takes a screenshot of the current viewport

#### Firefox
1. Open the website you want to capture
2. Press `F12` or `Ctrl+Shift+I` to open Developer Tools
3. Click the three-dot menu (⋯) in the top-right corner of the Developer Tools panel
4. Select "Take a screenshot" or "Take a full-page screenshot"

#### Microsoft Edge
1. Open the website you want to capture
2. Press `F12` or `Ctrl+Shift+I` to open Developer Tools
3. Press `Ctrl+Shift+P` to open the Command Menu
4. Type "screenshot" and select the appropriate option

#### For UI Component Screenshots
When capturing specific UI components:
1. Use the element inspector (click the icon with a cursor pointing at a square)
2. Select the specific component you want to capture
3. Right-click the element in the HTML tree and choose "Capture node screenshot" (Chrome/Edge)

Once you've captured your screenshots, save them to your project's `.cursor/design-reference` directory with descriptive names like `card-component.png`, `navbar-dark.png`, or `product-gallery.jpg`.

### ⚙️ Advanced Cursor Rules Setup

The template generator includes a powerful Cursor AI rules setup script (`setup-cursor-rules-v1.sh`) that further enhances your development experience:

- 🔍 **Automatic Project Analysis**: The script analyzes your project structure, detecting frameworks, styling approaches, build tools, and more to provide tailored AI assistance.

- 🧩 **Tech Stack Detection**: Automatically identifies technologies like Next.js, Tailwind CSS, testing frameworks, and database connections.

- 🧠 **Intelligent Rule Application**: Applies specific AI instruction sets based on your detected tech stack.

- 🎨 **Enhanced Design Rules**: Includes specialized design system rules for maintaining visual consistency.

- 📚 **Framework-Specific Knowledge**: Loads specialized knowledge about React, Next.js, and other frameworks to improve code suggestions.

To use the advanced setup:

1. 🔄 After creating your project, the setup script automatically places `setup-cursor-rules-v1.sh` in your project's `.cursor/scripts/` directory.
2. 🔁 You can run it again anytime to update your AI rules: `./.cursor/scripts/setup-cursor-rules-v1.sh`

## 🔌 Extending with Model Context Protocol (MCP)

The Next.js Template Generator creates a foundation that you can extend using Cursor's Model Context Protocol (MCP) for powerful integrations with external systems:

### 🤔 What is MCP?

Model Context Protocol allows you to create custom tools that integrate with Cursor, enabling the AI editor to interact with external systems, APIs, databases, and custom data sources.

### 💡 Implementation Possibilities

With MCP, you can extend your generated Next.js application in numerous ways:

1. 📊 **Content Management Integrations**: Connect to headless CMS systems (Contentful, Sanity, Strapi) to pull content directly into your components through Cursor.

2. 🛒 **E-commerce Data Fetching**: For e-commerce niches, build MCP tools that connect to product databases, inventory systems, or pricing APIs.

3. 📈 **Analytics Insights**: Create tools that pull analytics data to help optimize components based on user interaction patterns.

4. 🎨 **Design System Enforcement**: Build custom tools that ensure new components follow your design system by checking against design tokens or style guidelines.

5. 📚 **API Documentation Access**: Enable Cursor to fetch and understand your API documentation to assist in building data-fetching layers.

### 🚀 Getting Started with MCP

To implement MCP with your generated project:

1. 🖥️ **Create an MCP Server**: Build a simple Express or Node.js server that implements the MCP protocol.

2. 🛠️ **Define Custom Tools**: Create tool definitions that describe what capabilities you want to expose to Cursor.

3. ⚙️ **Handle Tool Requests**: Implement the logic for your tools to fetch data, process information, or interact with external systems.

4. 🔗 **Connect to Cursor**: Configure Cursor to connect to your MCP server through the settings interface.

### 🌟 Real-World Examples

- 🛍️ **Dynamic Product Catalog**: For e-commerce sites, create an MCP tool that fetches real product data when building product listing pages.

- 🔍 **SEO Optimization**: Build a tool that analyzes content and provides SEO recommendations directly in the editor.

- 🌐 **Localization Assistance**: Create a tool that helps manage translations and localized content across different components.

- 🎨 **Design Token Integration**: Connect to design systems like Figma to pull the latest design tokens and ensure component styles match the design.

## 🎨 Tailwind CSS Configuration

The template includes an enhanced Tailwind configuration with:

- 🌈 Extended color palettes for primary, secondary, and accent colors
- ✨ Custom animations and transitions
- 📝 Typography optimizations
- 📋 Form element styling
- 🔲 Custom shadow effects
- 📱 Responsive breakpoint utilities

## 📜 License

MIT

## Acknowledgments

- This project was developed with assistance from Claude AI
- Built on the excellent Next.js framework
- Uses Tailwind CSS for styling
- Incorporates Framer Motion for animations

## AI Disclosure

This project represents a collaborative effort between human creativity and AI capabilities. The initial concept was human-originated, but the development process was a significant collaboration with AI (Claude):

- **Project Concept**: Human-originated idea for a Next.js template generator
- **Implementation**: Extensive AI assistance in code generation and feature implementation
- **Decision Making**: Collaborative process where human direction guided AI suggestions and implementations
- **Code Generation**: Majority of code was AI-generated based on human requirements
- **Documentation**: AI-assisted creation with human oversight
- **Features**: Mix of human-requested and AI-suggested capabilities

The AI (Claude) was used as more than just a development tool - it was an active participant in the development process, contributing to architecture decisions, feature suggestions, and implementation details while operating under human oversight and direction.
