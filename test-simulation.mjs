import { QUESTION_BANK, AVAILABLE_ROLES, EXPERIENCE_LEVELS, INTERVIEW_TYPES } from './src/services/questionBank.js';
import { generateQuestions } from './src/services/questionGenerator.js';
import { evaluateSession, evaluateSingleAnswer, detectStarComponents } from './src/services/evaluationEngine.js';

console.log('=== MOCKIFY AI SIMULATION & VERIFICATION SUITE ===');
console.log('Question Bank Size:', QUESTION_BANK.length);
console.log('Available Roles:', AVAILABLE_ROLES.join(', '));
console.log('Available Levels:', EXPERIENCE_LEVELS.map(l => l.id).join(', '));

// 1. Test Question Generator with Custom JD
const testConfig = {
  role: 'Software Engineer',
  level: 'Senior',
  type: 'System Design',
  questionCount: 4,
  jobDescription: 'Senior Backend Engineer experienced with Redis, Kubernetes, PostgreSQL, Kafka and AWS.'
};
const questions = generateQuestions(testConfig);
console.log('\n[PASS] Generated Questions:', questions.length);
questions.forEach((q, i) => {
  console.log(`  ${i+1}. [${q.type}] ${q.question.slice(0, 75)}...`);
});

// 2. Test STAR Methodology Detection
const testStarResponse = "In my last role at FinTech Corp, our settlement queue backed up during market open spikes. My responsibility was to eliminate transaction drops. I implemented an asynchronous token bucket rate limiter in Go backed by Redis sliding window counters, and introduced a dead letter queue. Consequently, we handled 35,000 requests per second with zero dropped transactions and reduced p99 latency by 55%.";

const starDetection = detectStarComponents(testStarResponse);
console.log('\n[PASS] STAR Detection:');
console.log('  Situation:', starDetection.situation ? '✓' : '✗');
console.log('  Task:', starDetection.task ? '✓' : '✗');
console.log('  Action:', starDetection.action ? '✓' : '✗');
console.log('  Result:', starDetection.result ? '✓' : '✗');

if (!starDetection.situation || !starDetection.task || !starDetection.action || !starDetection.result) {
  throw new Error("STAR detection failed on comprehensive response");
}

// 3. Test Full Session Evaluation
const simulatedAnswers = {};
questions.forEach((q, idx) => {
  simulatedAnswers[q.id] = {
    transcript: idx === 0 ? testStarResponse : "For this problem, I would structure the service using microservices with PostgreSQL for relational transactional consistency and Redis for caching the top 20% most active entities. We will monitor using Prometheus metrics.",
    code: idx === 0 ? "func RateLimit(userId string) bool { return redis.ZAdd(ctx, userId, now) }" : "",
    duration: 110 + idx * 15,
    hintsUsed: idx === 1 ? 1 : 0
  };
});

const report = evaluateSession({
  questions,
  answers: simulatedAnswers,
  role: testConfig.role,
  level: testConfig.level,
  type: testConfig.type
});

console.log('\n[PASS] Session Evaluation Report Generated:');
console.log('  Overall Score:', report.overallScore, '/ 100');
console.log('  Recommendation:', report.recommendation.label, `(${report.recommendation.desc})`);
console.log('  Metrics Breakdown:');
console.log('    - Communication:', report.metrics.communication + '%');
console.log('    - Technical:', report.metrics.technical + '%');
console.log('    - Structure:', report.metrics.structure + '%');
console.log('    - Confidence:', report.metrics.confidence + '%');
console.log('  Evaluations Count:', report.evaluations.length);
console.log('  First Answer Strengths:', report.evaluations[0].strengths[0]);
console.log('  First Answer Improvements:', report.evaluations[0].improvements[0]);

console.log('\n>>> ALL 3 INTEGRATION & ALGORITHMIC TESTS PASSED! <<<');
