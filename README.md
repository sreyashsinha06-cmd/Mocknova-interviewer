# Mocknova — AI Voice Mock Interviewer & Evaluation Platform

**Mocknova** is a production-ready, responsive, full-stack AI Voice Mock Interviewer application engineered for hackathon-winning impact. Built in React 18, Vite, and Tailwind CSS, Mocknova pairs candidates with an intelligent, reactive AI lead interviewer grounded in real job descriptions, transparent rubrics, explicit human approval workflows, and independent verification.

---

## 🚀 Seven Integrated Features

### 1. Comprehensive Interview Setup Form
- **Candidate Configuration**: Company name, target job role, experience level (*Internship*, *Junior*, *Mid-Level*, *Senior*, *Staff/Lead*), interview format (*Technical*, *System Design*, *Behavioral*, *Mixed HR*), duration, and question count (3 to 8).
- **Job Description Parsing**: Paste full job postings or fetch from remote URLs.
- **Microphone & Recording Consent Gate**: Explicit Audio Recording Consent and Terms of Fair Practice checkboxes with visual status warnings.

### 2. Job-Description Analysis & Source-Grounded Question Generation
- **Entity Extraction**: Automatically identifies required programming languages, frameworks, system engineering concepts, and years of experience.
- **Traceable Source IDs**: Every question links back to a verifiable source (`sourceId`, `sourceTitle`, `sourceType`, `reliability`).
- **Public Research Patterns**: Grounded in public tech interview patterns for major tech companies.
- **Strict Non-Fabrication Guarantee**: When a job description is partial or unavailable, questions are explicitly tagged with `isGeneric: true` rather than inventing false facts or fictitious company criteria.

### 3. Live Split-Screen Interview Workspace & Transparent Scoring
- **Animated AI Interviewer Avatar ("Alex")**: Real-time mouth speaking animations, reactive sound ripples, question prompt card, audio replay, and strategy hints.
- **Voice Recognition (STT) & Speech Synthesis (TTS)**: Speech-to-text with microphone visualizer, live interim transcript stream, editable response textarea, and STAR method detection.
- **Consent Refusal Guard & Text Fallback**: When audio consent is denied, microphone capture is strictly disabled with a clear warning; candidates seamlessly answer via the structured text fallback.
- **Code & Architecture Workspace**: Multi-language editor (JavaScript, Python, TypeScript, SQL, Go) with starter templates.
- **Transparent 100-Point Scoring Rubric**:
  - *Technical / Subject Correctness*: 40 pts
  - *Relevance to the Question*: 25 pts
  - *Explanation & Reasoning*: 20 pts
  - *Clarity & STAR Structure*: 15 pts

### 4. Human Approval Workflow & Idempotency Safeguards
- **Pre-Commit Action Preview**: Inspect proposed changes to storage, score records, practice topics, and audit logs before committing.
- **Explicit Human Gate**: Report persistence requires candidate confirmation via the "Approve & Save Report" modal.
- **Idempotency Protection Engine**: Assigns unique `actionId` and `executionId` to prevent duplicate writes caused by rapid double-clicking, browser reloads, or network retries.
- **Draft Rejection**: Candidates can discard changes or view uncommitted drafts without polluting the archive.

### 5. Independent Verification Engine
- **Read-Back Verification**: Reads persisted records from storage and verifies exact match against expected output.
- **Mathematical Consistency Audit**: Recalculates answer rubrics to mathematically verify overall score accuracy (+/- 1 pt rounding tolerance).
- **Question Source Grounding Check**: Validates that all questions cite verifiable source IDs.
- **Evaluations Count Integrity**: Ensures all questions and candidate quotes are intact.
- **Duplicate Execution Check**: Verifies that exactly 1 copy exists in persistent storage.

### 6. Candidate Dashboard, Scorecards & Analytics
- **Performance Overview**: Average score, completed interviews, verification status, and active practice topics.
- **Competency Radar**: Multi-axis polar visualization across Technical Depth, Communication, STAR Structure, and Fluency.
- **Strongest vs. Weakest Answers**: Side-by-side performance extremes highlighting top strengths and immediate focus areas.
- **Prioritized Practice Plan**: Personalized, prioritized exercise suggestions mapped to candidate score gaps.
- **Export & Deletion Controls**: Download PDF / Print reports (`window.print()`), export structured JSON, and delete individual or all records.

### 7. Deterministic Scenario Testing Suite
- **Executable In-Browser & Headless**: Interactive UI page (`/scenarios`) and CLI test runner (`node test-scenarios-node.mjs`).
- **Four Dedicated Test Scenarios**:
  1. `SCENARIO-1`: Valid Interview — Successful End-to-End Workflow (IDs, JD grounding, 40/25/20/15 rubric, approval gate, verification).
  2. `SCENARIO-2`: Recording Consent Denied Workflow Guard (microphone capture blocked, consent warning, text fallback enabled).
  3. `SCENARIO-3`: Insufficient Source or Answer Evidence (detects partial JD, generic label, 0 score for unanswered questions, unresolved items listed).
  4. `SCENARIO-4`: Duplicate Execution and Retry Safety (idempotent action execution, duplicate calls return existing execution, exactly 1 record saved).

---

## 🛠️ Technology Stack
- **Framework**: React 18 with Vite
- **Styling**: Tailwind CSS with dark mode class strategy & fluid motion design
- **Icons**: Lucide React
- **Celebration Effects**: Canvas Confetti
- **Audio & Speech**: Web Speech API (`SpeechSynthesis` & `SpeechRecognition`)
- **Persistence**: LocalStorage with in-memory fallback for headless test runners

---

## 🚦 Getting Started & Launch Instructions

### Prerequisites
- Node.js 18+ (tested on Node v20)
- npm 9+

### Installation & Run
```bash
# 1. Navigate to the project root
cd C:\Users\lenovo\.gemini\antigravity\scratch\mockify-ai

# 2. Build for production
npm run build

# 3. Start local development server
npm run dev
```

Visit the displayed local URL (typically `http://localhost:5173`) in any modern browser (Google Chrome or Microsoft Edge recommended for full Web Speech API support).

### Executing Scenario Tests
```bash
# Run the 4 deterministic test scenarios from CLI
node test-scenarios-node.mjs

# Run the simulation and integration test suite
node test-simulation.mjs
```

---

## 🔒 Security & Privacy Notice
- **Zero Paid Service Requirement**: Mocknova functions 100% in Demo Mode out-of-the-box using built-in deterministic heuristics, local speech synthesis, and client-side speech recognition.
- **BYOK (Bring Your Own Key)**: Optional Google Gemini API keys are stored solely in browser `localStorage` and never transmitted to external third-party logging servers.
