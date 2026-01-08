// Configuration for ManipulatorAI
// Replace these values with your actual API keys and IDs

const CONFIG = {
    // Google OAuth Configuration
    google: {
        clientId: 'YOUR_GOOGLE_CLIENT_ID.googleusercontent.com'
    },
    
    // Stripe Configuration
    stripe: {
        publishableKey: 'pk_live_YOUR_STRIPE_PUBLISHABLE_KEY', // Use pk_test_ for testing
        priceIds: {
            monthly: 'price_YOUR_MONTHLY_PRICE_ID',
            lifetime: 'price_YOUR_LIFETIME_PRICE_ID'
        }
    },
    
    // App Configuration
    app: {
        freeUsageLimit: 5,
        maxConversationHistory: 100,
        enableAnalytics: true
    }
};

// Export for use in main application
if (typeof window !== 'undefined') {
    window.CONFIG = CONFIG;
}