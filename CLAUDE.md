# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**ManipulatorAI** is an iOS App Store app that detects manipulation tactics in text conversations. The primary product is the **SwiftUI iOS app**. The website (`index.html`) is a **landing page** that markets the app and will link to the App Store listing once the app is published.

## Architecture

### Landing Page (Web)
- Static HTML/CSS/JS site in the repo root (`index.html`, `style.css`, `script.js`)
- No build system or package manager — open directly in a browser or serve locally
- Purpose: marketing landing page with an App Store download link (placeholder until app is live)

### iOS App (SwiftUI)
- Source files live in `iOS/ManipulatorAI/`
- Key files:
  - `ManipulatorAIApp.swift` — app entry point
  - `ManipulatorAIViewModel.swift` — core logic, manipulation tactic detection via regex patterns
  - `HistoryView.swift` — conversation history + authentication UI
  - `ProfileView.swift` — user profile + subscription/payment UI
- Xcode project: `iOS/ManipulatorAI.xcodeproj` (generated via XcodeGen from `iOS/project.yml`)
- Asset catalog: `iOS/ManipulatorAI/Assets.xcassets/` (13 custom color sets + app icon placeholder)

## Development Commands

### Serve the landing page locally
```bash
# Python 3
python -m http.server 8000

# Node.js
npx http-server

# VS Code Live Server
# Right-click index.html → "Open with Live Server"
```

### iOS app
```bash
# Regenerate Xcode project after changing project.yml
cd iOS && xcodegen generate

# Build from command line
xcodebuild -project iOS/ManipulatorAI.xcodeproj -scheme ManipulatorAI \
  -destination 'platform=iOS Simulator,name=iPhone 16' build

# Or open in Xcode
open iOS/ManipulatorAI.xcodeproj
```

## App Store Release Checklist

The app is **not ready for release**. The following items must be completed:

### Xcode Project Setup
- [x] Create an `.xcodeproj` (via XcodeGen) so the iOS source files actually build
- [x] Add an `Info.plist` with bundle identifier, version, required device capabilities (auto-generated)
- [ ] Configure signing & capabilities (team, provisioning profiles)

### Complete All 16 Manipulation Tactics
- [x] The ViewModel now implements all **16 tactics**: Gaslighting, Guilt Tripping, Isolation Tactics, Love Bombing, Threats & Intimidation, Emotional Blackmail, Control & Monitoring, Blame Shifting, Minimizing & Dismissing, Triangulation, Silent Treatment, Financial Control, Public Humiliation, Future Faking, Projection, Word Salad / Circular Arguments
- [x] Landing page count matches what the app detects

### Real Authentication
- [ ] Replace the mocked `signIn()` in `HistoryView.swift` (currently creates a fake "Demo User")
- [ ] Integrate Sign in with Apple (required for App Store if any third-party sign-in is offered)
- [ ] Optionally add Firebase Auth / Google Sign-In alongside Sign in with Apple

### Real In-App Purchases
- [ ] Replace the mocked `selectPlan()` in `ProfileView.swift` (currently just toggles a local variable)
- [ ] Integrate StoreKit 2 for subscription management
- [ ] Set up products in App Store Connect
- [ ] Handle receipt validation and entitlement checks

### App Store Assets
- [ ] App icon (1024x1024 + all required sizes via asset catalog)
- [ ] App Store screenshots for required device sizes (6.7", 6.5", 5.5" at minimum)
- [ ] App Store description, keywords, and subtitle
- [ ] Privacy policy URL (required)
- [ ] Terms of service URL (recommended)
- [ ] Support URL

### Data Persistence
- [ ] Currently uses basic `UserDefaults` — evaluate whether Core Data, SwiftData, or a backend is needed for conversation history

### Testing
- [ ] Build and run on a real device
- [ ] TestFlight beta distribution to at least a small group of testers
- [ ] Test all 16 tactic detection patterns with real-world conversation samples
- [ ] Test purchase flows in the StoreKit sandbox

### App Store Connect Submission
- [ ] Create the app listing in App Store Connect
- [ ] Upload the build via Xcode or `xcodebuild`
- [ ] Submit for App Review
- [ ] Once approved, update the landing page with the real App Store link
