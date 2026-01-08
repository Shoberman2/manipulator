# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

ManipulatorAI is a platform for analyzing text messages for manipulative tactics. The project consists of:

**Core Functionality:**
- Text input field for users to paste messages
- Analysis button that processes the text for manipulative patterns
- Results display showing identified manipulative tactics
- Modern, clean UI design

**Platform Targets:**
- Website (current focus) - static HTML/CSS/JavaScript
- Future iOS app expansion

**Design Requirements:**
- Simple, intuitive interface
- Modern aesthetic
- Fast, responsive user experience

## Architecture

Currently a static web project with potential for future API integration for text analysis. The project structure includes:
- `index.html` - Main application interface
- `style.css` - Modern styling and responsive design
- Future: JavaScript for text analysis logic and API calls

## Development Commands

No package.json or build system detected. This is a static HTML/CSS project that can be opened directly in a browser or served with a simple HTTP server.

To serve locally:
```bash
# Using Python 3
python -m http.server 8000

# Using Node.js (if http-server is installed globally)
npx http-server

# Using VS Code Live Server extension
# Right-click on index.html and select "Open with Live Server"
```

## Key Implementation Notes

- Focus on defensive security analysis - detecting manipulative patterns, not creating them
- Ensure user privacy - avoid logging or storing analyzed messages
- Design should be clean and non-intimidating for users seeking help
- Consider accessibility for users who may be in vulnerable situations
- Future iOS app should maintain consistent UX with web version