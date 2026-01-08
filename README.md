# ManipulatorAI

A web application for analyzing text messages to detect manipulative tactics. Helps users identify potential manipulation patterns and provides neutral response suggestions.

## Features

- **Message Analysis**: Detects 8 common manipulation tactics in text
- **Usage Tracking**: 5 free analyses, then subscription required
- **Authentication**: Google Sign-In integration
- **Payment System**: Stripe integration ($2/month or $30 lifetime)
- **Conversation History**: Track and review past analyses
- **Educational Content**: Learn about different manipulation techniques
- **Neutral Responses**: AI-generated suggestions for de-escalating conversations
- **Privacy-First**: Analysis happens locally, only summaries stored

## Quick Start

### Option 1: Simple HTTP Server
```bash
# Using Python (most common)
python3 -m http.server 8000

# Using Python 2
python -m SimpleHTTPServer 8000

# Using Node.js (if installed)
npx http-server

# Using PHP (if installed)
php -S localhost:8000
```

Then open `http://localhost:8000` in your browser.

### Option 2: Direct File Access
Simply open `index.html` directly in your web browser.

### Option 3: VS Code Live Server
1. Install the "Live Server" extension in VS Code
2. Right-click on `index.html`
3. Select "Open with Live Server"

## Configuration

Before deploying to production, update the configuration in `config.js`:

1. **Google OAuth Setup**:
   - Create a project in [Google Cloud Console](https://console.cloud.google.com/)
   - Enable Google Sign-In API
   - Replace `YOUR_GOOGLE_CLIENT_ID` with your actual client ID

2. **Stripe Integration**:
   - Create a [Stripe account](https://stripe.com)
   - Create products for monthly ($2) and lifetime ($30) plans
   - Replace price IDs in `config.js`
   - Update publishable key

3. **Domain Configuration**:
   - Add your domain to Google OAuth authorized origins
   - Configure Stripe webhook endpoints for production

## File Structure

```
manipulatorai/
├── index.html          # Main application
├── style.css          # Styles and responsive design  
├── script.js          # Analysis logic and UI interactions
├── config.js          # Configuration file
├── CLAUDE.md          # Development guidance
└── README.md          # This file
```

## Business Model

- **Free Tier**: 5 message analyses
- **Monthly Plan**: $2.00/month for unlimited access
- **Lifetime Plan**: $30.00 one-time payment for permanent access

Users must sign in after their first analysis to track usage and access premium features.

## Development

No build process required - this is a static web application using vanilla HTML, CSS, and JavaScript.

## iOS App Preparation

The web app is designed to be mobile-responsive and can be wrapped for iOS deployment using:

- **Capacitor**: `npm install @capacitor/core @capacitor/ios`
- **Cordova**: For hybrid app development
- **PWA**: Configure as Progressive Web App for iOS installation

## Privacy & Security

- Message analysis happens locally in browser
- Only conversation summaries and usage data stored
- User authentication via secure Google OAuth
- Payment processing through Stripe (PCI compliant)
- No sensitive message content leaves the device

## Deployment

1. Update `config.js` with production credentials
2. Deploy to any static hosting service (Netlify, Vercel, GitHub Pages)
3. Configure domain and SSL certificate
4. Set up Stripe webhooks for subscription management