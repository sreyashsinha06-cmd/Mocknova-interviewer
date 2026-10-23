# Mocknova Demo Video Generator
# Generates high-resolution 1080p presentation frames, Microsoft Zira voiceover narration, and compiles to MP4 via FFmpeg.

$ErrorActionPreference = "Stop"

$baseDir = "C:\Users\lenovo\.gemini\antigravity\scratch\mockify-ai"
$tempDir = "$env:TEMP\mocknova_video_build"
$outputMp4 = "$baseDir\public\mocknova-demo-video.mp4"
$desktopMp4 = "C:\Users\lenovo\OneDrive\Desktop\Mocknova_Demo_Video.mp4"
$docsMp4 = "C:\Users\lenovo\Documents\Mocknova_Demo_Video.mp4"

if (Test-Path $tempDir) { Remove-Item $tempDir -Recurse -Force }
New-Item -ItemType Directory -Path $tempDir | Out-Null

Add-Type -AssemblyName System.Speech
$synth = New-Object System.Speech.Synthesis.SpeechSynthesizer

# Select voice (prefer Zira Desktop)
$voice = ($synth.GetInstalledVoices() | Where-Object { $_.VoiceInfo.Name -like "*Zira*" } | Select-Object -First 1)
if ($voice) {
    $synth.SelectVoice($voice.VoiceInfo.Name)
    Write-Host "Voice selected: $($voice.VoiceInfo.Name)"
} else {
    Write-Host "Zira not found, using default voice: $($synth.Voice.Name)"
}
$synth.Rate = 0  # Natural conversational pace

$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edgePath)) {
    $edgePath = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# Define the 6 scenes
$scenes = @(
    @{
        id = 1
        tag = "INTRO & PROBLEM STATEMENT"
        title = "Mocknova: Next-Gen AI Voice Mock Interviewer"
        subtitle = "Solving Opaque Scoring, Hallucinated Questions & Forced Audio Recording"
        bullets = @(
            "Traceable Source Grounding: Grounded in real Job Description entities with stable source IDs.",
            "Transparent 100-Point Rubric: 40 Technical, 25 Relevance, 20 Reasoning, 15 STAR Structure.",
            "Explicit Human Approval Gate: Candidates preview report changes before committing to archive.",
            "5-Part Independent Verification: Deterministic math consistency & persistent storage read-back."
        )
        metricBadge = "4/4 Deterministic Scenarios Verified"
        accent = "#38bdf8"
        bgGrad = "linear-gradient(135deg, #090d16 0%, #031525 50%, #062b47 100%)"
        cardBg = "rgba(15, 23, 42, 0.90)"
        narration = "Welcome to Mocknova, the next-generation AI Voice Mock Interviewer engineered for technical and behavioral interview preparation. Most AI interview platforms today fail candidates in critical ways: they generate generic, hallucinated questions unrelated to real job requirements, force audio recording without consent, and award arbitrary black-box scores with zero evidence. Mocknova solves this through traceable source grounding, transparent rubrics, an explicit human approval gate, and an independent verification engine."
    },
    @{
        id = 2
        tag = "FEATURE 1 & 2: SETUP & GROUNDING"
        title = "Job Description Entity Extraction & Source Grounding"
        subtitle = "Verifiable Source IDs, Non-Fabrication Guarantee & Consent Refusal Guard"
        bullets = @(
            "Configurable Parameters: Target Company, Role, Internship to Lead levels, Duration, Question counts.",
            "Entity Extraction Engine: Isolates required algorithms, distributed systems, and language skills.",
            "Strict Non-Fabrication Guarantee: Missing or partial JDs explicitly tagged as Generic rather than invented.",
            "Consent Refusal Guard: Denying recording consent strictly blocks microphone access and enables text fallback."
        )
        metricBadge = "Source ID Grounding: 100% Traceable"
        accent = "#10b981"
        bgGrad = "linear-gradient(135deg, #061510 0%, #0a261a 50%, #0f3d28 100%)"
        cardBg = "rgba(6, 21, 16, 0.90)"
        narration = "Candidates begin by configuring their target company, role, experience level, and interview format. When pasting a job description or URL, Mocknova's entity extraction engine isolates technical competencies like Algorithms, Distributed Systems, and Python, issuing a unique traceable source ID under our strict Non-Fabrication Guarantee. Furthermore, Mocknova prioritizes candidate privacy: if audio recording consent is declined, our Consent Refusal Guard strictly blocks microphone capture and activates an honest text-practice fallback mode."
    },
    @{
        id = 3
        tag = "FEATURE 3: LIVE INTERVIEW WORKSPACE"
        title = "Split-Screen Simulation & Real-Time STAR Detection"
        subtitle = "3D AI Interviewer Avatar, Multimodal Voice/Code Workspace & Pacing Telemetry"
        bullets = @(
            "AI Avatar 'Alex': Real-time speaking mesh animation with Web Speech Synthesis.",
            "Dual-Mode Workspace: Live speech-to-text transcription alongside multi-language code editor.",
            "Real-Time STAR Detection: Situation, Task, Action, and Result indicators activate dynamically.",
            "Candidate Telemetry: Pacing monitor (ideal 110-150 WPM), filler word tracking, and benchmark answers."
        )
        metricBadge = "Live STAR Telemetry & Audio Synthesis"
        accent = "#0284c7"
        bgGrad = "linear-gradient(135deg, #090d16 0%, #0c2138 50%, #0a355c 100%)"
        cardBg = "rgba(12, 33, 56, 0.90)"
        narration = "During the interview, candidates experience a realistic split-screen workspace. On the left, our animated AI interviewer avatar speaks questions aloud using speech synthesis. On the right, candidates respond naturally using real-time speech-to-text or our integrated multi-language code and architecture workspace. As the candidate speaks, Mocknova's real-time STAR detection monitors Situation, Task, Action, and Result indicators, providing instant visual feedback on structured communication and trade-off justification."
    },
    @{
        id = 4
        tag = "FEATURE 4: GOVERNANCE & APPROVAL"
        title = "Explicit Human Approval Gate & Idempotency Lock"
        subtitle = "Pre-Commit Change Previews, Destination Scopes & Rapid Retry Protection"
        bullets = @(
            "Explicit Approval Gate: Never auto-commits to storage; pauses for human review upon completion.",
            "Change Preview: Previews targets (mocknova_interview_history, evaluation_records, practice_plan).",
            "Idempotency Engine: Unique actionId and executionId prevent duplicate writes on double-clicks or reloads.",
            "Candidate Control: Options to approve, discard changes, or retain evaluation as draft only."
        )
        metricBadge = "Zero Unverified Auto-Commits"
        accent = "#f59e0b"
        bgGrad = "linear-gradient(135deg, #1c1304 0%, #2e1d05 50%, #452a06 100%)"
        cardBg = "rgba(28, 19, 4, 0.90)"
        narration = "Unlike conventional tools that silently write unverified data to storage, Mocknova enforces an explicit Human Approval Gate. After response evaluation, candidates preview proposed changes to performance records, scores, and practice recommendations before anything is committed. Every action is protected by an idempotency engine with unique action and execution IDs, ensuring accidental double-clicks or page refreshes never produce duplicate records."
    },
    @{
        id = 5
        tag = "FEATURE 5 & 6: AUDIT & ANALYTICS"
        title = "5-Point Independent Verification & Scorecard Analytics"
        subtitle = "Deterministic Audit Trail, Competency Radar & Prioritized Practice Plan"
        bullets = @(
            "Storage Read-Back Check: Confirms record persisted intact in local archive.",
            "Math Consistency Check: Recalculates answer rubrics to mathematically verify overall score.",
            "Competency Radar Chart: Technical depth, communication clarity, STAR structure, and fluency.",
            "Performance Extremes: Side-by-side strongest demonstrated answers vs. targeted growth areas."
        )
        metricBadge = "100-Point Transparent Rubric Audit"
        accent = "#10b981"
        bgGrad = "linear-gradient(135deg, #061a12 0%, #0d2e20 50%, #134530 100%)"
        cardBg = "rgba(6, 26, 18, 0.90)"
        narration = "Immediately upon approval, our independent verification engine runs five automated audit checks: storage read-back confirmation, question source grounding, evaluation count integrity, mathematical score consistency, and single-execution validation. The candidate receives a comprehensive scorecard featuring our transparent forty-twenty-five-twenty-fifteen rubric, competency radar chart, strongest versus weakest answer analysis, and a prioritized practice plan."
    },
    @{
        id = 6
        tag = "FEATURE 7: ENTERPRISE RELIABILITY"
        title = "Deterministic Scenario Suite & Hackathon Summary"
        subtitle = "4/4 Automated Tests Passing, 100% Offline Demo Mode & Production Architecture"
        bullets = @(
            "Scenario 1 Passed: Valid interview end-to-end workflow with source grounding and approval.",
            "Scenario 2 Passed: Recording consent refusal strictly disables audio recording with fallback.",
            "Scenario 3 Passed: Insufficient JD correctly marked generic with zero score for empty answer.",
            "Scenario 4 Passed: Duplicate execution safety confirms exactly one record saved on rapid retries."
        )
        metricBadge = "Production Ready & 100% Deterministic"
        accent = "#818cf8"
        bgGrad = "linear-gradient(135deg, #0e0e1a 0%, #15152b 50%, #202047 100%)"
        cardBg = "rgba(14, 14, 26, 0.90)"
        narration = "To prove enterprise reliability, Mocknova includes an automated Scenario Testing Suite executing four deterministic tests covering happy path workflows, consent refusal enforcement, missing evidence handling, and duplicate execution safety, with all four tests passing with complete evidence steps. Mocknova operates entirely offline in Demo Mode with zero paid service requirements, or connects live with Gemini AI. Thank you for exploring Mocknova."
    }
)

Write-Host ">>> GENERATING 6 SCENE AUDIO TRACKS & 1080P FRAMES <<<"

$sceneClips = @()

foreach ($s in $scenes) {
    $idx = $s.id
    $wavPath = "$tempDir\scene_$idx.wav"
    $htmlPath = "$tempDir\scene_$idx.html"
    $pngPath = "$tempDir\scene_$idx.png"
    $clipMp4 = "$tempDir\scene_$idx.mp4"

    Write-Host "--------------------------------------------------"
    Write-Host "Rendering Scene $idx / 6: $($s.tag)"

    # 1. Synthesize Audio
    $synth.SetOutputToWaveFile($wavPath)
    $synth.Speak($s.narration)
    $synth.SetOutputToNull()

    # Measure exact audio duration with ffprobe
    $ffprobeOut = & ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$wavPath"
    $dur = [Math]::Round([double]$ffprobeOut + 0.6, 2)
    Write-Host "Scene $idx Duration: $dur seconds"

    # 2. Render 1920x1080 HTML frame
    $bulletsHtml = ($s.bullets | ForEach-Object {
        "<li style='margin-bottom: 16px; display: flex; align-items: flex-start; gap: 14px;'>
            <span style='color: $($s.accent); font-weight: 900; font-size: 24px; line-height: 1;'>&#10004;</span>
            <span style='font-size: 21px; color: #e2e8f0; line-height: 1.45; font-weight: 500;'>$_</span>
         </li>"
    }) -join "`n"

    $htmlContent = @"
<!DOCTYPE html>
<html>
<head>
  <meta charset='UTF-8'>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
      width: 1920px;
      height: 1080px;
      overflow: hidden;
      font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, Roboto, sans-serif;
      background: $($s.bgGrad);
      color: #ffffff;
      padding: 60px 80px;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .header-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .logo-badge {
      display: inline-flex;
      align-items: center;
      gap: 12px;
      background: rgba(255, 255, 255, 0.08);
      border: 1px solid rgba(255, 255, 255, 0.18);
      padding: 10px 22px;
      border-radius: 9999px;
      font-size: 16px;
      font-weight: 800;
      letter-spacing: 1.5px;
      text-transform: uppercase;
      color: $($s.accent);
      box-shadow: 0 4px 14px rgba(0,0,0,0.3);
    }
    .scene-counter {
      font-family: 'Consolas', 'Courier New', monospace;
      font-size: 15px;
      font-weight: 700;
      color: #94a3b8;
      background: rgba(0,0,0,0.5);
      border: 1px solid rgba(255,255,255,0.1);
      padding: 8px 18px;
      border-radius: 8px;
    }
    .main-card {
      background: $($s.cardBg);
      border: 1px solid rgba(255, 255, 255, 0.14);
      border-radius: 28px;
      padding: 48px 60px;
      backdrop-filter: blur(25px);
      box-shadow: 0 30px 60px -15px rgba(0, 0, 0, 0.75);
    }
    .tagline-row {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 14px;
    }
    .tagline {
      font-size: 14px;
      font-weight: 800;
      color: $($s.accent);
      letter-spacing: 2px;
      text-transform: uppercase;
    }
    .metric-pill {
      font-size: 13px;
      font-weight: 700;
      background: rgba(255, 255, 255, 0.08);
      border: 1px solid $($s.accent);
      color: $($s.accent);
      padding: 5px 14px;
      border-radius: 9999px;
    }
    .title {
      font-size: 44px;
      font-weight: 900;
      line-height: 1.18;
      letter-spacing: -0.5px;
      margin-bottom: 12px;
      background: linear-gradient(to right, #ffffff, #f1f5f9, $($s.accent));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    .subtitle {
      font-size: 21px;
      color: #94a3b8;
      font-weight: 500;
      margin-bottom: 32px;
    }
    .footer-bar {
      display: flex;
      justify-content: space-between;
      align-items: center;
      color: #64748b;
      font-size: 15px;
      font-weight: 600;
      border-top: 1px solid rgba(255, 255, 255, 0.1);
      padding-top: 22px;
    }
    .link-pill {
      color: #38bdf8;
      background: rgba(56, 189, 248, 0.1);
      padding: 5px 14px;
      border-radius: 6px;
      font-family: 'Consolas', monospace;
      font-size: 14px;
    }
  </style>
</head>
<body>
  <div class='header-bar'>
    <div class='logo-badge'>
      <span style='width: 12px; height: 12px; border-radius: 50%; background: $($s.accent); box-shadow: 0 0 10px $($s.accent);'></span>
      Mocknova Pro • AI Voice Mock Interviewer
    </div>
    <div class='scene-counter'>PHASE $idx OF 6</div>
  </div>

  <div class='main-card'>
    <div class='tagline-row'>
      <div class='tagline'>$($s.tag)</div>
      <div class='metric-pill'>$($s.metricBadge)</div>
    </div>
    <h1 class='title'>$($s.title)</h1>
    <p class='subtitle'>$($s.subtitle)</p>

    <ul style='list-style: none;'>
      $bulletsHtml
    </ul>
  </div>

  <div class='footer-bar'>
    <span class='link-pill'>https://raid-anyway-opposition-senior.trycloudflare.com</span>
    <span>Traceable Source Grounding • Transparent 100-Pt Rubrics • Human Approval Gate</span>
  </div>
</body>
</html>
"@

    Set-Content -Path $htmlPath -Value $htmlContent -Encoding UTF8

    # 3. Screenshot frame via Edge headless (synchronously with Start-Process -Wait)
    Write-Host "Capturing 1080p slide screenshot for Scene $idx..."
    $edgeArgs = @(
        "--headless=new",
        "--disable-gpu",
        "--hide-scrollbars",
        "--window-size=1920,1080",
        "--screenshot=$pngPath",
        "file:///$($htmlPath.Replace('\', '/'))"
    )
    $p = Start-Process -FilePath $edgePath -ArgumentList $edgeArgs -NoNewWindow -Wait -PassThru
    
    # Verify screenshot was created and written
    $retry = 0
    while ((-not (Test-Path $pngPath) -or (Get-Item $pngPath).Length -eq 0) -and $retry -lt 20) {
        Start-Sleep -Milliseconds 250
        $retry++
    }
    if (-not (Test-Path $pngPath) -or (Get-Item $pngPath).Length -eq 0) {
        throw "Failed to capture screenshot for Scene $idx"
    }

    # 4. Render Scene MP4 via FFmpeg with exact synchronized audio/video
    Write-Host "Encoding Scene $idx MP4 video clip..."
    & ffmpeg -y -loop 1 -framerate 30 -i "$pngPath" -i "$wavPath" -c:v libx264 -preset fast -pix_fmt yuv420p -c:a aac -b:a 192k -ar 44100 -ac 2 -t $dur -shortest "$clipMp4"

    if (-not (Test-Path $clipMp4) -or (Get-Item $clipMp4).Length -eq 0) {
        throw "FFmpeg failed to produce clip for Scene $idx"
    }

    $sceneClips += "file '$($clipMp4.Replace('\', '/'))'"
}

# 5. Concatenate all scenes into final master video
Write-Host "=================================================="
Write-Host ">>> CONCATENATING ALL 6 SCENES INTO MASTER DEMO MP4 <<<"
$concatList = "$tempDir\concat_list.txt"

# Write concat list with ASCII encoding (strictly NO UTF-8 BOM)
[System.IO.File]::WriteAllLines($concatList, $sceneClips, [System.Text.Encoding]::ASCII)

Write-Host "Concat list contents:"
Get-Content $concatList

& ffmpeg -y -f concat -safe 0 -i "$concatList" -c copy "$outputMp4"

if (-not (Test-Path $outputMp4) -or (Get-Item $outputMp4).Length -eq 0) {
    throw "FFmpeg concatenation failed to produce final master video."
}

# 6. Copy to Desktop and Documents
Copy-Item "$outputMp4" "$desktopMp4" -Force
Copy-Item "$outputMp4" "$docsMp4" -Force

# Probe final duration
$finalDur = & ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$outputMp4"
$finalMin = [Math]::Floor([double]$finalDur / 60)
$finalSec = [Math]::Round([double]$finalDur % 60)

Write-Host "=================================================="
Write-Host ">>> DEMO VIDEO GENERATED SUCCESSFULLY! <<<"
Write-Host "Final Duration: $finalMin min $finalSec sec ($finalDur seconds)"
Get-Item "$outputMp4" | Select-Object Name, Length, FullName
Get-Item "$desktopMp4" | Select-Object Name, Length, FullName
