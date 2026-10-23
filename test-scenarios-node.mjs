import { runScenario1, runScenario2, runScenario3, runScenario4, runAllScenarios } from './src/services/scenarioRunner.js';

console.log('=== RUNNING ALL 4 LABELLED SCENARIOS ===\n');

async function test() {
  const results = await runAllScenarios();

  results.forEach((r, idx) => {
    console.log(`[${r.status}] ${r.scenarioId}: ${r.name}`);
    console.log(`  Actual Result: ${r.actualResult}`);
    console.log(`  Evidence Steps (${r.evidence.length}):`);
    r.evidence.forEach(e => console.log(`    - ${e}`));
    console.log('');
  });

  const allPassed = results.every(r => r.status === 'Passed');
  console.log(`>>> ALL 4 SCENARIOS TEST FINISHED: ${allPassed ? 'ALL PASSED (4/4)' : 'SOME FAILED'} <<<`);
  if (!allPassed) process.exit(1);
}

test().catch(err => {
  console.error("Test failed with error:", err);
  process.exit(1);
});
