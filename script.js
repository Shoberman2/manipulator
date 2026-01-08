const manipulativeTactics = {
    gaslighting: {
        name: "Gaslighting",
        patterns: [
            /you're (crazy|insane|imagining things|being dramatic|overreacting)/gi,
            /that never happened/gi,
            /you're remembering it wrong/gi,
            /you're too sensitive/gi,
            /stop being so emotional/gi,
            /you're making things up/gi,
            /you have a bad memory/gi,
            /you're delusional/gi,
            /i never said that/gi,
            /you're losing your mind/gi
        ],
        description: "Making you question your own memory, perception, or sanity through systematic doubt.",
        neutralResponses: [
            "I understand we have different perspectives on this situation.",
            "I'd like to take some time to think about what you've said.",
            "I appreciate you sharing your viewpoint with me."
        ]
    },
    guilt_tripping: {
        name: "Guilt Tripping",
        patterns: [
            /after everything i've done for you/gi,
            /you're being selfish/gi,
            /if you really cared about me/gi,
            /you're hurting me by/gi,
            /i sacrificed so much for you/gi,
            /you owe me/gi,
            /how could you do this to me/gi,
            /i gave up everything for you/gi,
            /this is how you repay me/gi,
            /you're so ungrateful/gi,
            /think about what i've done/gi
        ],
        description: "Making you feel guilty to control your behavior or decisions.",
        neutralResponses: [
            "I understand this is important to you. Let me consider what you've said.",
            "I value our relationship and want to find a solution that works for both of us.",
            "I appreciate everything you've done. I need some time to think about this."
        ]
    },
    isolation: {
        name: "Isolation Tactics",
        patterns: [
            /your friends don't really care about you/gi,
            /your family is toxic/gi,
            /i'm the only one who truly understands you/gi,
            /they're just trying to turn you against me/gi,
            /you don't need anyone else/gi,
            /why do you need to see them/gi
        ],
        description: "Attempting to separate you from your support network.",
        neutralResponses: [
            "I value the relationships in my life and want to maintain them.",
            "I appreciate your concern, but I'd like to make my own decisions about my relationships.",
            "Different people bring different perspectives to my life, which I find valuable."
        ]
    },
    love_bombing: {
        name: "Love Bombing",
        patterns: [
            /you're the only one for me/gi,
            /i've never felt this way before/gi,
            /we're soulmates/gi,
            /you complete me/gi,
            /i can't live without you/gi,
            /you're perfect/gi
        ],
        description: "Excessive flattery and attention, often early in relationships.",
        neutralResponses: [
            "Thank you for sharing your feelings. I'd like to take things at a comfortable pace.",
            "I appreciate your kind words. I believe healthy relationships develop gradually.",
            "I'm glad you care about me. Let's continue getting to know each other better."
        ]
    },
    threats: {
        name: "Threats & Intimidation",
        patterns: [
            /you'll regret this/gi,
            /i'll ruin you/gi,
            /no one will believe you/gi,
            /i'll make your life hell/gi,
            /you'll be sorry/gi,
            /i know where you live/gi,
            /i'll hurt myself if you/gi
        ],
        description: "Using threats or intimidation to control behavior.",
        neutralResponses: [
            "I don't feel comfortable continuing this conversation right now.",
            "I think we both need some space to cool down.",
            "I'd prefer to discuss this when we can both communicate respectfully."
        ]
    },
    minimizing: {
        name: "Minimizing & Dismissing",
        patterns: [
            /you're making a big deal out of nothing/gi,
            /it wasn't that bad/gi,
            /stop overreacting/gi,
            /you're being too dramatic/gi,
            /it's not a big deal/gi,
            /you're blowing this out of proportion/gi
        ],
        description: "Downplaying your feelings or experiences to avoid accountability.",
        neutralResponses: [
            "My feelings about this are valid and important to me.",
            "I'd like us to discuss this issue when you're ready to listen.",
            "I understand we may see this differently, but this matters to me."
        ]
    },
    control: {
        name: "Control & Monitoring",
        patterns: [
            /who were you talking to/gi,
            /show me your phone/gi,
            /you can't go there/gi,
            /i need to know where you are at all times/gi,
            /you're not allowed to/gi,
            /you need my permission/gi
        ],
        description: "Excessive control over your activities, communications, or decisions.",
        neutralResponses: [
            "I value my privacy and independence in our relationship.",
            "I'm comfortable sharing information when I choose to.",
            "I'd like to maintain some autonomy in my daily decisions."
        ]
    },
    blame_shifting: {
        name: "Blame Shifting",
        patterns: [
            /you made me do it/gi,
            /it's your fault/gi,
            /you drove me to this/gi,
            /look what you made me do/gi,
            /i wouldn't have to if you didn't/gi,
            /you started it/gi,
            /this is all because of you/gi,
            /you're responsible for this/gi,
            /if you hadn't/gi
        ],
        description: "Refusing to take responsibility and blaming you instead.",
        neutralResponses: [
            "I think we each need to take responsibility for our own actions.",
            "I'd like to focus on finding solutions rather than assigning blame.",
            "Let's work together to address this issue constructively."
        ]
    },
    
    emotional_blackmail: {
        name: "Emotional Blackmail",
        patterns: [
            /if you leave me i'll/gi,
            /you'll destroy me if/gi,
            /i can't live without you/gi,
            /i'll hurt myself if you/gi,
            /you're killing me/gi,
            /my life will be over/gi,
            /i'll die if you/gi,
            /you're all i have/gi,
            /without you i'm nothing/gi
        ],
        description: "Using extreme emotional consequences to manipulate your decisions.",
        neutralResponses: [
            "I care about you, but I need to make decisions that are right for me too.",
            "I think it would be helpful if you spoke to a counselor about these feelings.",
            "I want what's best for both of us, which means making healthy choices."
        ]
    },
    
    triangulation: {
        name: "Triangulation",
        patterns: [
            /everyone agrees with me/gi,
            /[a-z]+ thinks you're wrong/gi,
            /[a-z]+ said you/gi,
            /other people have told me/gi,
            /nobody likes it when you/gi,
            /everyone says/gi,
            /[a-z]+ would never do that/gi,
            /why can't you be more like/gi
        ],
        description: "Bringing third parties into conflicts to gain support and isolate you.",
        neutralResponses: [
            "I'd prefer to focus on our conversation without involving others.",
            "What matters most to me is how we communicate with each other.",
            "I'd like to hear your thoughts directly, not through other people."
        ]
    },
    
    silent_treatment: {
        name: "Silent Treatment",
        patterns: [
            /i'm not talking to you/gi,
            /don't talk to me/gi,
            /i have nothing to say/gi,
            /figure it out yourself/gi,
            /i'm done with this conversation/gi,
            /whatever/gi,
            /fine/gi,
            /talk to the wall/gi,
            /i'm ignoring you/gi
        ],
        description: "Withdrawing communication as punishment or to force compliance.",
        neutralResponses: [
            "I understand you may need some space. I'm here when you're ready to talk.",
            "It seems like you need time to process. Let me know when you'd like to discuss this.",
            "I respect that you may need a break from this conversation."
        ]
    },
    
    financial_manipulation: {
        name: "Financial Control",
        patterns: [
            /i control the money/gi,
            /you can't afford/gi,
            /i'm not giving you money for/gi,
            /you're financially dependent on me/gi,
            /without me you'd be broke/gi,
            /i pay for everything/gi,
            /you owe me money/gi,
            /i'll cut off your/gi,
            /you can't survive without my money/gi
        ],
        description: "Using financial dependency or control to limit your autonomy.",
        neutralResponses: [
            "I'd like to discuss our financial arrangement when we're both calm.",
            "Financial decisions should be made together in a partnership.",
            "I think we need to establish clear boundaries around money and independence."
        ]
    },
    
    public_humiliation: {
        name: "Public Humiliation",
        patterns: [
            /everyone can see how/gi,
            /you're embarrassing yourself/gi,
            /people are laughing at you/gi,
            /you look ridiculous/gi,
            /everyone thinks you're/gi,
            /i'm embarrassed to be seen with you/gi,
            /you're making a fool of yourself/gi,
            /people are staring/gi
        ],
        description: "Using public shame or embarrassment to control your behavior.",
        neutralResponses: [
            "I don't appreciate being spoken to this way, especially in public.",
            "I'd prefer to discuss this privately if there's an issue.",
            "I'm comfortable with who I am and how I present myself."
        ]
    },
    
    future_faking: {
        name: "Future Faking",
        patterns: [
            /when we get married/gi,
            /after we move in together/gi,
            /once i get that promotion/gi,
            /things will be different when/gi,
            /i promise next time/gi,
            /in the future we'll/gi,
            /someday we'll/gi,
            /when things calm down/gi,
            /after this is over/gi
        ],
        description: "Making false promises about future changes to maintain control.",
        neutralResponses: [
            "I'd like to focus on what we can do now to improve our situation.",
            "Actions today matter more to me than promises about tomorrow.",
            "I appreciate your intentions, but I need to see consistent changes."
        ]
    },
    
    projection: {
        name: "Projection",
        patterns: [
            /you're the one who/gi,
            /you always/gi,
            /you never/gi,
            /you're just like/gi,
            /you have a problem with/gi,
            /you can't handle/gi,
            /you're too/gi,
            /you don't know how to/gi,
            /you're the manipulative one/gi
        ],
        description: "Accusing you of behaviors or traits they themselves exhibit.",
        neutralResponses: [
            "I'd like to focus on the specific situation we're discussing.",
            "Let's talk about what happened without making generalizations.",
            "I think we're both contributing to this dynamic in different ways."
        ]
    },
    
    word_salad: {
        name: "Word Salad/Circular Arguments",
        patterns: [
            /but what about when/gi,
            /that's not the point/gi,
            /you're missing the point/gi,
            /that's completely different/gi,
            /you don't understand/gi,
            /let me explain again/gi,
            /that's not what i meant/gi,
            /you're twisting my words/gi,
            /that's not the same thing/gi
        ],
        description: "Using confusing language or circular logic to avoid accountability.",
        neutralResponses: [
            "I'd like to focus on one issue at a time so we can communicate clearly.",
            "Let's take a step back and clarify what we're actually discussing.",
            "I'm having trouble following the conversation. Can we start over?"
        ]
    }
};

class ManipulationAnalyzer {
    constructor() {
        this.messageInput = document.getElementById('message-input');
        this.analyzeBtn = document.getElementById('analyze-btn');
        this.resultsSection = document.getElementById('results-section');
        this.resultsContent = document.getElementById('results-content');
        this.neutralResponse = document.getElementById('neutral-response');
        this.responseContent = document.getElementById('response-content');
        this.loading = document.getElementById('loading');
        
        // User and subscription state
        this.currentUser = null;
        this.usageCount = this.getUsageCount();
        this.subscriptionStatus = 'free';
        this.conversations = this.getConversations();
        
        // Stripe configuration (replace with your keys)
        this.stripePublishableKey = 'pk_test_YOUR_STRIPE_PUBLISHABLE_KEY'; // Replace with your actual key
        this.monthlyPriceId = 'price_YOUR_MONTHLY_PRICE_ID'; // Replace with your monthly price ID
        this.lifetimePriceId = 'price_YOUR_LIFETIME_PRICE_ID'; // Replace with your lifetime price ID
        
        this.setupEventListeners();
        this.setupTabNavigation();
        this.setupAuthListeners();
        this.setupPaymentListeners();
        this.initializeAuth();
        this.updateUI();
    }
    
    setupEventListeners() {
        this.analyzeBtn.addEventListener('click', () => this.analyzeMessage());
        this.messageInput.addEventListener('input', () => this.toggleAnalyzeButton());
        
        this.messageInput.addEventListener('keydown', (e) => {
            if (e.ctrlKey && e.key === 'Enter') {
                this.analyzeMessage();
            }
        });
    }
    
    setupTabNavigation() {
        const navTabs = document.querySelectorAll('.nav-tab');
        const tabContents = document.querySelectorAll('.tab-content');
        
        navTabs.forEach(tab => {
            tab.addEventListener('click', () => {
                const targetTab = tab.getAttribute('data-tab');
                
                // Remove active class from all tabs and contents
                navTabs.forEach(t => t.classList.remove('active'));
                tabContents.forEach(content => content.classList.remove('active'));
                
                // Add active class to clicked tab and corresponding content
                tab.classList.add('active');
                document.getElementById(`${targetTab}-tab`).classList.add('active');
            });
        });
    }
    
    toggleAnalyzeButton() {
        const hasText = this.messageInput.value.trim().length > 0;
        this.analyzeBtn.disabled = !hasText;
    }
    
    async analyzeMessage() {
        const message = this.messageInput.value.trim();
        
        if (!message) {
            return;
        }
        
        // Check if user needs to sign in (after first usage)
        if (this.usageCount >= 1 && !this.currentUser) {
            this.showAuthModal();
            return;
        }
        
        // Check usage limits for free users
        if (!this.hasValidSubscription() && this.usageCount >= 5) {
            this.showPaymentModal();
            return;
        }
        
        this.showLoading();
        
        setTimeout(() => {
            const detectedTactics = this.detectTactics(message);
            this.displayResults(detectedTactics);
            
            // Save conversation and increment usage
            this.saveConversation(message, detectedTactics);
            this.incrementUsage();
            this.updateUI();
            
            this.hideLoading();
        }, 1500);
    }
    
    detectTactics(message) {
        const detected = [];
        
        for (const [key, tactic] of Object.entries(manipulativeTactics)) {
            const matches = tactic.patterns.some(pattern => pattern.test(message));
            
            if (matches) {
                detected.push({
                    name: tactic.name,
                    description: tactic.description,
                    neutralResponses: tactic.neutralResponses,
                    key: key
                });
            }
        }
        
        return detected;
    }
    
    generateNeutralResponse(detectedTactics) {
        if (detectedTactics.length === 0) {
            return [
                "Thank you for sharing that with me.",
                "I appreciate you reaching out.",
                "I understand what you're saying."
            ];
        }
        
        const allResponses = detectedTactics.flatMap(tactic => tactic.neutralResponses);
        const randomResponse = allResponses[Math.floor(Math.random() * allResponses.length)];
        
        return [randomResponse];
    }
    
    displayResults(tactics) {
        this.resultsContent.innerHTML = '';
        
        if (tactics.length === 0) {
            this.resultsContent.innerHTML = `
                <div class="no-tactics">
                    <strong>No obvious manipulative tactics detected.</strong>
                    <br><br>
                    This doesn't necessarily mean the message is completely harmless - trust your instincts. 
                    If something feels wrong, it's worth discussing with someone you trust.
                </div>
            `;
        } else {
            const tacticsHtml = tactics.map(tactic => `
                <div class="tactic">
                    <div class="tactic-name">${tactic.name}</div>
                    <div class="tactic-description">${tactic.description}</div>
                </div>
            `).join('');
            
            this.resultsContent.innerHTML = `
                <div style="margin-bottom: 20px; padding: 16px; background: #fff3cd; border: 1px solid #ffeaa7; border-radius: 8px; color: #856404;">
                    <strong>Warning:</strong> ${tactics.length} potential manipulative tactic${tactics.length > 1 ? 's' : ''} detected.
                </div>
                ${tacticsHtml}
                <div style="margin-top: 20px; padding: 16px; background: #e8f5e8; border-radius: 8px; font-size: 0.9rem; color: #2d5a2d;">
                    <strong>Remember:</strong> Trust your instincts. If you're feeling confused, guilty, or afraid, consider reaching out to a trusted friend, family member, or professional counselor.
                </div>
            `;
        }
        
        // Show neutral response suggestions
        const autoSuggest = document.getElementById('auto-suggest')?.checked !== false;
        if (autoSuggest) {
            this.showNeutralResponse(tactics);
        }
        
        this.showResults();
    }
    
    showNeutralResponse(tactics) {
        const responses = this.generateNeutralResponse(tactics);
        const responseHtml = responses.map(response => `
            <div class="response-suggestion">"${response}"</div>
        `).join('');
        
        this.responseContent.innerHTML = `
            ${responseHtml}
            <p style="margin-top: 12px; font-size: 0.9rem; color: #6b7280;">
                These neutral responses can help you maintain boundaries while de-escalating the situation.
            </p>
        `;
        
        this.neutralResponse.classList.remove('hidden');
    }
    
    showLoading() {
        this.loading.classList.remove('hidden');
        this.resultsSection.classList.add('hidden');
        this.neutralResponse.classList.add('hidden');
        this.analyzeBtn.disabled = true;
    }
    
    hideLoading() {
        this.loading.classList.add('hidden');
        this.analyzeBtn.disabled = false;
        this.toggleAnalyzeButton();
    }
    
    showResults() {
        this.resultsSection.classList.remove('hidden');
        this.resultsSection.scrollIntoView({ behavior: 'smooth' });
    }
    
    // Authentication methods
    setupAuthListeners() {
        document.getElementById('sign-in-btn')?.addEventListener('click', () => this.signIn());
        document.getElementById('profile-sign-in-btn')?.addEventListener('click', () => this.signIn());
        document.getElementById('google-sign-in')?.addEventListener('click', () => this.signIn());
        document.getElementById('sign-out-btn')?.addEventListener('click', () => this.signOut());
        
        // Modal close listeners
        document.querySelectorAll('.close-modal').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.target.closest('.modal').classList.remove('show');
                e.target.closest('.modal').classList.add('hidden');
            });
        });
        
        // Modal backdrop close
        document.querySelectorAll('.modal').forEach(modal => {
            modal.addEventListener('click', (e) => {
                if (e.target === modal) {
                    modal.classList.remove('show');
                    modal.classList.add('hidden');
                }
            });
        });
    }
    
    initializeAuth() {
        // Initialize Google Sign-In (in production, you'd configure this properly)
        if (window.google) {
            window.google.accounts.id.initialize({
                client_id: 'YOUR_GOOGLE_CLIENT_ID', // Replace with your actual Google client ID
                callback: this.handleGoogleSignIn.bind(this)
            });
        }
        
        // Check for existing session
        const savedUser = localStorage.getItem('manipulatorai_user');
        if (savedUser) {
            try {
                this.currentUser = JSON.parse(savedUser);
                this.subscriptionStatus = localStorage.getItem('manipulatorai_subscription') || 'free';
            } catch (e) {
                console.error('Error parsing saved user:', e);
            }
        }
    }
    
    showAuthModal() {
        const modal = document.getElementById('auth-modal');
        modal.classList.remove('hidden');
        modal.classList.add('show');
    }
    
    async signIn() {
        // For demo purposes, create a mock user
        // In production, this would integrate with Google OAuth
        const mockUser = {
            id: 'demo_user_' + Date.now(),
            name: 'Demo User',
            email: 'demo@example.com',
            picture: null
        };
        
        this.currentUser = mockUser;
        localStorage.setItem('manipulatorai_user', JSON.stringify(mockUser));
        
        // Close auth modal
        document.getElementById('auth-modal').classList.add('hidden');
        document.getElementById('auth-modal').classList.remove('show');
        
        this.updateUI();
        
        // If user was trying to analyze, retry
        if (this.messageInput.value.trim()) {
            this.analyzeMessage();
        }
    }
    
    handleGoogleSignIn(response) {
        // Handle actual Google sign-in response
        try {
            const payload = JSON.parse(atob(response.credential.split('.')[1]));
            this.currentUser = {
                id: payload.sub,
                name: payload.name,
                email: payload.email,
                picture: payload.picture
            };
            
            localStorage.setItem('manipulatorai_user', JSON.stringify(this.currentUser));
            
            document.getElementById('auth-modal').classList.add('hidden');
            this.updateUI();
        } catch (error) {
            console.error('Error handling Google sign-in:', error);
        }
    }
    
    signOut() {
        this.currentUser = null;
        this.subscriptionStatus = 'free';
        localStorage.removeItem('manipulatorai_user');
        localStorage.removeItem('manipulatorai_subscription');
        this.updateUI();
    }
    
    // Payment methods
    setupPaymentListeners() {
        document.querySelectorAll('.payment-btn, .price-btn').forEach(btn => {
            btn.addEventListener('click', (e) => {
                const plan = e.target.getAttribute('data-plan') || e.target.closest('[data-plan]')?.getAttribute('data-plan');
                if (plan) {
                    this.initializePayment(plan);
                }
            });
        });
        
        document.getElementById('upgrade-subscription')?.addEventListener('click', () => {
            this.showPaymentModal();
        });
    }
    
    showPaymentModal() {
        const modal = document.getElementById('payment-modal');
        modal.classList.remove('hidden');
        modal.classList.add('show');
    }
    
    async initializePayment(plan) {
        // For demo purposes, simulate successful payment
        // In production, integrate with Stripe
        
        alert(`Payment for ${plan} plan initiated! (Demo mode - no actual payment processed)`);
        
        // Simulate successful payment
        setTimeout(() => {
            this.subscriptionStatus = plan === 'monthly' ? 'monthly' : 'lifetime';
            localStorage.setItem('manipulatorai_subscription', this.subscriptionStatus);
            
            // Close payment modal
            document.getElementById('payment-modal').classList.add('hidden');
            document.getElementById('payment-modal').classList.remove('show');
            
            this.updateUI();
            
            // Show success message
            alert('Payment successful! You now have unlimited access.');
            
            // If user was trying to analyze, retry
            if (this.messageInput.value.trim()) {
                this.analyzeMessage();
            }
        }, 1000);
    }
    
    hasValidSubscription() {
        return this.subscriptionStatus === 'monthly' || this.subscriptionStatus === 'lifetime';
    }
    
    // Usage tracking methods
    getUsageCount() {
        return parseInt(localStorage.getItem('manipulatorai_usage') || '0');
    }
    
    incrementUsage() {
        this.usageCount++;
        localStorage.setItem('manipulatorai_usage', this.usageCount.toString());
    }
    
    // Conversation history methods
    getConversations() {
        try {
            return JSON.parse(localStorage.getItem('manipulatorai_conversations') || '[]');
        } catch (e) {
            return [];
        }
    }
    
    saveConversation(message, tactics) {
        if (!document.getElementById('save-history')?.checked) return;
        
        const conversation = {
            id: Date.now().toString(),
            date: new Date().toISOString(),
            preview: message.substring(0, 100) + (message.length > 100 ? '...' : ''),
            tacticsDetected: tactics.length,
            tactics: tactics.map(t => t.name),
            userId: this.currentUser?.id || 'anonymous'
        };
        
        this.conversations.unshift(conversation);
        
        // Keep only last 100 conversations
        if (this.conversations.length > 100) {
            this.conversations = this.conversations.slice(0, 100);
        }
        
        localStorage.setItem('manipulatorai_conversations', JSON.stringify(this.conversations));
    }
    
    clearHistory() {
        if (confirm('Are you sure you want to clear all conversation history? This action cannot be undone.')) {
            this.conversations = [];
            localStorage.setItem('manipulatorai_conversations', '[]');
            this.updateUI();
        }
    }
    
    // UI update methods
    updateUI() {
        this.updateUsageStats();
        this.updateProfileUI();
        this.updateHistoryUI();
        this.updateNavigationState();
    }
    
    updateUsageStats() {
        document.getElementById('total-analyses').textContent = this.usageCount;
        document.getElementById('free-remaining').textContent = Math.max(0, 5 - this.usageCount);
        document.getElementById('tactics-detected').textContent = 
            this.conversations.reduce((sum, conv) => sum + conv.tacticsDetected, 0);
        
        // Show upgrade prompt if needed
        const upgradePrompt = document.getElementById('upgrade-prompt');
        if (!this.hasValidSubscription() && this.usageCount >= 5) {
            upgradePrompt.classList.remove('hidden');
        } else {
            upgradePrompt.classList.add('hidden');
        }
    }
    
    updateProfileUI() {
        const signedOutSection = document.getElementById('profile-signed-out');
        const profileContent = document.getElementById('profile-content');
        
        if (this.currentUser) {
            signedOutSection.classList.add('hidden');
            profileContent.classList.remove('hidden');
            
            document.getElementById('user-name').textContent = this.currentUser.name;
            document.getElementById('user-email').textContent = this.currentUser.email;
            
            if (this.currentUser.picture) {
                document.getElementById('user-avatar-img').innerHTML = 
                    `<img src="${this.currentUser.picture}" alt="Profile">`;
            } else {
                document.getElementById('user-avatar-img').textContent = 
                    this.currentUser.name.charAt(0).toUpperCase();
            }
            
            // Update subscription info
            const statusMap = {
                'free': 'Free Plan',
                'monthly': 'Monthly Subscription',
                'lifetime': 'Lifetime Access'
            };
            
            document.getElementById('subscription-status').textContent = statusMap[this.subscriptionStatus];
            document.getElementById('current-plan').textContent = 
                this.subscriptionStatus === 'free' ? 'Free (5 analyses)' : 'Unlimited Access';
            
            const manageBtn = document.getElementById('manage-subscription');
            const upgradeBtn = document.getElementById('upgrade-subscription');
            
            if (this.hasValidSubscription()) {
                manageBtn.classList.remove('hidden');
                upgradeBtn.classList.add('hidden');
            } else {
                manageBtn.classList.add('hidden');
                upgradeBtn.classList.remove('hidden');
            }
        } else {
            signedOutSection.classList.remove('hidden');
            profileContent.classList.add('hidden');
        }
    }
    
    updateHistoryUI() {
        const authRequired = document.getElementById('auth-required');
        const historyContent = document.getElementById('history-content');
        const conversationsContainer = document.getElementById('conversations-container');
        
        if (this.currentUser) {
            authRequired.classList.add('hidden');
            historyContent.classList.remove('hidden');
            
            // Render conversations
            if (this.conversations.length > 0) {
                const conversationsHtml = this.conversations.map(conv => `
                    <div class="conversation-item">
                        <div class="conversation-header">
                            <div class="conversation-date">${new Date(conv.date).toLocaleDateString()}</div>
                        </div>
                        <div class="conversation-preview">${conv.preview}</div>
                        <div class="conversation-tags">
                            ${conv.tactics.map(tactic => 
                                `<span class="tactic-tag">${tactic}</span>`
                            ).join('')}
                            ${conv.tactics.length === 0 ? 
                                '<span style="color: #22c55e; font-weight: 500;">No tactics detected</span>' : ''}
                        </div>
                    </div>
                `).join('');
                
                conversationsContainer.innerHTML = conversationsHtml;
            } else {
                conversationsContainer.innerHTML = `
                    <div class="empty-state">
                        <p>No conversations yet. Start by analyzing a message!</p>
                    </div>
                `;
            }
        } else {
            authRequired.classList.remove('hidden');
            historyContent.classList.add('hidden');
        }
    }
    
    updateNavigationState() {
        // Update navigation based on auth state
        const historyTab = document.querySelector('[data-tab="history"]');
        if (!this.currentUser) {
            historyTab.style.opacity = '0.6';
        } else {
            historyTab.style.opacity = '1';
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const analyzer = new ManipulationAnalyzer();
    
    // Setup additional event listeners
    document.getElementById('clear-history')?.addEventListener('click', () => {
        analyzer.clearHistory();
    });
});