# Taste
- Writes requests in Indonesian and expects replies in Indonesian (agent's final summaries should match the user's language). Confidence: 0.7
- Expects new screens/features to reuse the existing visual theme — same palette, card/button styling, app bar and layout patterns as current pages — instead of introducing a new look. Confidence: 0.75
- When hitting an error, pastes the raw terminal/build output verbatim with little to no accompanying question, expecting the agent to diagnose the root cause and fix it end-to-end (including verifying with a real build/run) rather than just explain. Confidence: 0.55
- Delegates work as terse, high-level instructions (often a single run-on sentence with multiple comma-separated tasks, no file paths or acceptance criteria) and expects the agent to explore the codebase and implement it end-to-end autonomously without asking clarifying questions. Confidence: 0.7
- Expects interactive controls (e.g. logout, menu items, buttons) to be actually wired to real behavior/state rather than left as placeholder no-ops. Confidence: 0.6
- When a specific third-party package/link is provided, expects that exact library to be used and installed (e.g. adding the named package to the manifest) rather than a substitute or a hand-rolled implementation. Confidence: 0.55
