/**
 * ManipulatorAI Detection Test Suite
 *
 * 20 test sentences with predetermined correct answers.
 * Tests that the detection engine correctly identifies each manipulation tactic
 * and correctly clears non-manipulative messages.
 *
 * Run: node test.js
 */

const fs = require('fs');

// Load and evaluate the manipulativeTactics object from script.js
const code = fs.readFileSync(__dirname + '/script.js', 'utf8');
const tacticsCode = code.split('// ─── Specific explanations')[0];
// Replace const with var so eval defines it in this scope
eval(tacticsCode.replace(/^const /, 'var '));

// Detection function (same logic as the app)
function detectTactics(message) {
    const detected = [];
    for (const [key, tactic] of Object.entries(manipulativeTactics)) {
        for (const pattern of tactic.patterns) {
            pattern.lastIndex = 0;
        }
        const matched = tactic.patterns.some(p => { p.lastIndex = 0; return p.test(message); });
        if (matched) {
            detected.push(tactic.name);
        }
    }
    return detected;
}

// ─── 20 Test Cases ───
// Each test has:
//   input: the sentence to analyze
//   expected: the tactic name it MUST detect (null = should detect nothing)

const tests = [
    // 1. Gaslighting — "that never happened" pattern
    { input: "That never happened, you're making things up.", expected: "Gaslighting" },

    // 2. Guilt Tripping — "after everything i've done for you" pattern
    { input: "After everything I've done for you, you treat me like this.", expected: "Guilt Tripping" },

    // 3. Isolation — "your friends don't really care about you" pattern
    { input: "Your friends don't really care about you, only I do.", expected: "Isolation Tactics" },

    // 4. Love Bombing — "we're soulmates" pattern
    { input: "We're soulmates, you complete me, I've never felt this way before.", expected: "Love Bombing" },

    // 5. Threats — "you'll regret this" pattern
    { input: "If you walk out that door, you'll regret this.", expected: "Threats & Intimidation" },

    // 6. Minimizing — "stop overreacting" pattern
    { input: "Stop overreacting, you're blowing this out of proportion.", expected: "Minimizing & Dismissing" },

    // 7. Control — "show me your phone" pattern
    { input: "Show me your phone, who were you talking to?", expected: "Control & Monitoring" },

    // 8. Blame Shifting — "you made me do it" pattern
    { input: "You made me do it, this is all because of you.", expected: "Blame Shifting" },

    // 9. Emotional Blackmail — "without you i'm nothing" pattern
    { input: "Without you I'm nothing, my life will be over.", expected: "Emotional Blackmail" },

    // 10. Triangulation — "everyone agrees with me" pattern
    { input: "Everyone agrees with me, nobody likes it when you act like that.", expected: "Triangulation" },

    // 11. Silent Treatment — "i'm not talking to you" pattern
    { input: "I'm not talking to you, I'm done with this conversation.", expected: "Silent Treatment" },

    // 12. Financial Control — "i pay for everything" pattern
    { input: "I pay for everything, without me you'd be broke.", expected: "Financial Control" },

    // 13. Public Humiliation — "you're embarrassing yourself" pattern
    { input: "You're embarrassing yourself, people are laughing at you.", expected: "Public Humiliation" },

    // 14. Future Faking — "things will be different when" pattern
    { input: "Things will be different when we get married, I promise next time.", expected: "Future Faking" },

    // 15. Projection — "you're the manipulative one" pattern
    { input: "You're the manipulative one here, you're the one who started this.", expected: "Projection" },

    // 16. Word Salad — "that's not the point" pattern
    { input: "That's not the point, you're twisting my words.", expected: "Word Salad / Circular Arguments" },

    // 17. Clean message — should detect NOTHING
    { input: "I had a productive meeting at work today.", expected: null },

    // 18. Clean message — should detect NOTHING
    { input: "Let's grab dinner tonight, I was thinking Italian.", expected: null },

    // 19. Clean message — should detect NOTHING
    { input: "Thanks for helping me move last weekend, I really appreciate it.", expected: null },

    // 20. Clean message — should detect NOTHING
    { input: "The weather looks great tomorrow, want to go for a hike?", expected: null },
];

// ─── Run Tests ───

let passed = 0;
let failed = 0;
const failures = [];

tests.forEach((t, i) => {
    const num = i + 1;
    const detected = detectTactics(t.input);

    let ok;
    if (t.expected === null) {
        // Clean message: should detect nothing
        ok = detected.length === 0;
    } else {
        // Manipulative message: expected tactic must be in detected list
        ok = detected.includes(t.expected);
    }

    if (ok) {
        passed++;
        console.log(`  ✓ Test ${num}: PASS`);
    } else {
        failed++;
        const expectedStr = t.expected || 'None';
        const detectedStr = detected.length > 0 ? detected.join(', ') : 'None';
        console.log(`  ✗ Test ${num}: FAIL — expected "${expectedStr}", got "${detectedStr}"`);
        failures.push({ num, input: t.input, expected: t.expected, detected });
    }
});

console.log(`\n${passed}/${tests.length} passed, ${failed} failed\n`);

if (failures.length > 0) {
    console.log('Failures:');
    failures.forEach(f => {
        console.log(`  #${f.num}: "${f.input}"`);
        console.log(`         Expected: ${f.expected || 'None'}`);
        console.log(`         Got:      ${f.detected.length > 0 ? f.detected.join(', ') : 'None'}`);
    });
}

process.exit(failed > 0 ? 1 : 0);
