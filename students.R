students <- r"(
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Portugal’s broken social ladder</title>

  <link href="https://fonts.googleapis.com/css2?family=Lora:ital,wght@0,400;0,500;0,600;0,700;1,400&family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.js"></script>

  <style>
    :root {
      --econ-red: #E3120B;
      --econ-ink: #121212;
      --econ-text: #2C2C2C;
      --econ-grey: #6E6E6E;
      --econ-grey-light: #B0B0B0;
      --econ-rule: #D9D9D9;
      --econ-bg-tint: #F5F5F0;
      --econ-blue: #1F77A8;
    }

    * { margin: 0; padding: 0; box-sizing: border-box; }

    body {
      font-family: 'Lora', Georgia, serif;
      font-size: 17px;
      line-height: 1.55;
      color: var(--econ-text);
      background: #FFFFFF;
    }

    .red-rule { height: 6px; background: var(--econ-red); width: 100%; }

    .masthead {
      border-bottom: 1px solid var(--econ-rule);
      padding: 14px 0;
      background: #fff;
    }

    .masthead-flex,
    .header-inner,
    .article-body,
    .figures-strip,
    .chart-block,
    .calculator,
    .table-block,
    .methodology,
    .footer-inner {
      max-width: 720px;
      margin: 0 auto;
      padding-left: 24px;
      padding-right: 24px;
    }

    .masthead-flex {
      display: flex;
      justify-content: space-between;
      align-items: baseline;
    }

    .publication-name {
      font-family: 'Inter', sans-serif;
      font-size: 13px;
      font-weight: 700;
      letter-spacing: 0.5px;
      color: var(--econ-ink);
      text-transform: uppercase;
    }

    .issue-date {
      font-family: 'Inter', sans-serif;
      font-size: 12px;
      color: var(--econ-grey);
    }

    .header {
      padding: 48px 0 32px;
      border-bottom: 1px solid var(--econ-rule);
    }

    .rubric {
      font-family: 'Inter', sans-serif;
      font-size: 12px;
      font-weight: 700;
      color: var(--econ-red);
      text-transform: uppercase;
      letter-spacing: 1.2px;
      margin-bottom: 14px;
    }

    .rubric::before {
      content: "";
      display: inline-block;
      width: 14px;
      height: 6px;
      background: var(--econ-red);
      margin-right: 10px;
      transform: translateY(-2px);
    }

    .headline {
      font-family: 'Inter', sans-serif;
      font-size: 42px;
      font-weight: 800;
      line-height: 1.05;
      color: var(--econ-ink);
      letter-spacing: -0.8px;
      margin-bottom: 16px;
    }

    .dek {
      font-family: 'Lora', serif;
      font-size: 19px;
      line-height: 1.45;
      color: var(--econ-text);
      margin-bottom: 24px;
    }

    .byline {
      font-family: 'Inter', sans-serif;
      font-size: 12px;
      color: var(--econ-grey);
      letter-spacing: 0.3px;
      text-transform: uppercase;
      font-weight: 500;
    }

    .article-body { padding-top: 36px; padding-bottom: 36px; }
    .article-body p { margin-bottom: 18px; }

    .lead::first-letter {
      font-family: 'Inter', sans-serif;
      font-weight: 800;
      font-size: 60px;
      float: left;
      line-height: 0.9;
      padding: 4px 8px 0 0;
      color: var(--econ-ink);
    }

    .article-body h2 {
      font-family: 'Inter', sans-serif;
      font-size: 22px;
      font-weight: 700;
      color: var(--econ-ink);
      margin: 36px 0 14px;
      letter-spacing: -0.3px;
    }

    .article-body strong { font-weight: 600; color: var(--econ-ink); }

    .smcp {
      font-variant-caps: small-caps;
      letter-spacing: 0.3px;
      font-weight: 500;
    }

    .pullquote {
      font-family: 'Lora', serif;
      font-size: 24px;
      font-style: italic;
      line-height: 1.35;
      color: var(--econ-ink);
      margin: 32px 0;
      padding: 8px 0 8px 24px;
      border-left: 3px solid var(--econ-red);
    }

    .figures-strip {
      padding-top: 24px;
      padding-bottom: 24px;
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      border-top: 1px solid var(--econ-ink);
      border-bottom: 1px solid var(--econ-ink);
    }

    .figure-cell {
      padding: 4px 18px;
      border-right: 1px solid var(--econ-rule);
    }

    .figure-cell:first-child { padding-left: 0; }
    .figure-cell:last-child { padding-right: 0; border-right: none; }

    .figure-num {
      font-family: 'Inter', sans-serif;
      font-size: 32px;
      font-weight: 700;
      color: var(--econ-red);
      line-height: 1;
      margin-bottom: 6px;
      letter-spacing: -0.5px;
    }

    .figure-lbl {
      font-family: 'Inter', sans-serif;
      font-size: 11.5px;
      color: var(--econ-grey);
      line-height: 1.35;
    }

    .chart-block {
      margin-top: 36px;
      margin-bottom: 36px;
      padding-top: 24px;
      padding-bottom: 24px;
      background: var(--econ-bg-tint);
    }

    .chart-tag {
      font-family: 'Inter', sans-serif;
      font-size: 11px;
      font-weight: 700;
      color: var(--econ-red);
      text-transform: uppercase;
      letter-spacing: 1px;
      margin-bottom: 8px;
      display: flex;
      align-items: center;
    }

    .chart-tag::before {
      content: "";
      width: 8px;
      height: 8px;
      background: var(--econ-red);
      margin-right: 8px;
    }

    .chart-title {
      font-family: 'Inter', sans-serif;
      font-size: 19px;
      font-weight: 700;
      color: var(--econ-ink);
      margin-bottom: 4px;
      line-height: 1.2;
      letter-spacing: -0.2px;
    }

    .chart-subtitle {
      font-family: 'Lora', serif;
      font-size: 14px;
      font-style: italic;
      color: var(--econ-grey);
      margin-bottom: 18px;
      line-height: 1.4;
    }

    .chart-controls {
      display: flex;
      gap: 4px;
      margin-bottom: 16px;
      flex-wrap: wrap;
      align-items: center;
    }

    .control-label {
      font-family: 'Inter', sans-serif;
      font-size: 11px;
      color: var(--econ-grey);
      text-transform: uppercase;
      letter-spacing: 0.6px;
      font-weight: 500;
      margin-right: 8px;
    }

    .toggle-btn {
      font-family: 'Inter', sans-serif;
      padding: 5px 12px;
      background: transparent;
      border: 1px solid var(--econ-grey-light);
      cursor: pointer;
      font-size: 12px;
      font-weight: 500;
      color: var(--econ-text);
    }

    .toggle-btn:hover { border-color: var(--econ-red); color: var(--econ-red); }
    .toggle-btn.active { background: var(--econ-red); color: #fff; border-color: var(--econ-red); }

    .chart-canvas-wrapper {
      position: relative;
      width: 100%;
      height: 360px;
      background: #fff;
      padding: 12px 8px 8px;
    }

    .chart-source {
      font-family: 'Inter', sans-serif;
      font-size: 11px;
      color: var(--econ-grey);
      margin-top: 12px;
      padding-top: 10px;
      border-top: 1px solid var(--econ-rule);
    }

    .chart-source-label {
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.4px;
      color: var(--econ-grey);
      margin-right: 4px;
    }

    .calculator {
      margin-top: 36px;
      margin-bottom: 36px;
      padding-top: 24px;
      padding-bottom: 24px;
      background: #fff;
      border-top: 3px solid var(--econ-red);
      border-bottom: 1px solid var(--econ-rule);
    }

    .calc-grid {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 24px;
      align-items: start;
      margin-top: 18px;
    }

    .calc-controls { display: flex; flex-direction: column; gap: 16px; }

    .calc-field-label {
      font-family: 'Inter', sans-serif;
      font-size: 11px;
      color: var(--econ-grey);
      text-transform: uppercase;
      letter-spacing: 0.6px;
      font-weight: 600;
      margin-bottom: 6px;
      display: block;
    }

    .calc-select {
      font-family: 'Inter', sans-serif;
      padding: 10px 12px;
      border: 1px solid var(--econ-grey-light);
      font-size: 14px;
      background: #fff;
      cursor: pointer;
      width: 100%;
      color: var(--econ-ink);
    }

    .calc-result {
      background: var(--econ-bg-tint);
      padding: 24px;
      border-left: 4px solid var(--econ-red);
    }

    .result-num {
      font-family: 'Inter', sans-serif;
      font-size: 56px;
      font-weight: 800;
      color: var(--econ-red);
      line-height: 1;
      margin-bottom: 12px;
      letter-spacing: -1.5px;
    }

    .result-text {
      font-family: 'Lora', serif;
      font-size: 14px;
      line-height: 1.5;
      color: var(--econ-text);
    }

    .table-block {
      margin-top: 36px;
      margin-bottom: 36px;
      padding-top: 24px;
      padding-bottom: 24px;
    }

    .data-table {
      width: 100%;
      border-collapse: collapse;
      font-family: 'Inter', sans-serif;
      font-size: 13px;
      margin-top: 12px;
    }

    .data-table th {
      padding: 10px 8px;
      text-align: left;
      font-weight: 700;
      color: var(--econ-ink);
      font-size: 11px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      border-bottom: 1.5px solid var(--econ-ink);
      border-top: 1px solid var(--econ-ink);
    }

    .data-table th.num,
    .data-table td.num {
      text-align: right;
      font-variant-numeric: tabular-nums;
    }

    .data-table td {
      padding: 9px 8px;
      border-bottom: 1px solid var(--econ-rule);
      color: var(--econ-text);
    }

    .data-table tr:hover { background: var(--econ-bg-tint); }
    .data-table .gap-row { background: #FFF4F3; font-weight: 600; }
    .data-table .gap-row:hover { background: #FFEAE8; }
    .data-table .highlight { color: var(--econ-red); font-weight: 700; }
    .data-table .positive { color: var(--econ-blue); }

    .methodology {
      margin-top: 48px;
      margin-bottom: 24px;
      padding-top: 20px;
      padding-bottom: 20px;
      background: var(--econ-bg-tint);
      border-top: 2px solid var(--econ-ink);
    }

    .methodology h3 {
      font-family: 'Inter', sans-serif;
      font-size: 11px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 1px;
      margin-bottom: 12px;
      color: var(--econ-ink);
    }

    .methodology ul {
      font-family: 'Inter', sans-serif;
      font-size: 13px;
      line-height: 1.6;
      color: var(--econ-text);
      list-style: none;
    }

    .methodology li {
      margin-bottom: 6px;
      padding-left: 14px;
      position: relative;
    }

    .methodology li::before {
      content: "■";
      color: var(--econ-red);
      position: absolute;
      left: 0;
      font-size: 8px;
      top: 6px;
    }

    .footer {
      border-top: 6px solid var(--econ-red);
      padding: 24px 0;
      margin-top: 48px;
    }

    .footer-inner {
      font-family: 'Inter', sans-serif;
      font-size: 12px;
      color: var(--econ-grey);
      text-align: center;
      line-height: 1.6;
    }

    @media (max-width: 700px) {
      body { font-size: 16px; }
      .headline { font-size: 32px; }
      .dek { font-size: 17px; }
      .figures-strip { grid-template-columns: 1fr; gap: 12px; }
      .figure-cell { border-right: none; border-bottom: 1px solid var(--econ-rule); padding: 8px 0; }
      .figure-cell:last-child { border-bottom: none; }
      .calc-grid { grid-template-columns: 1fr; }
      .chart-canvas-wrapper { height: 320px; }
      .result-num { font-size: 42px; }
    }
  </style>
</head>

<body>
  <div class="red-rule"></div>

  <div class="masthead">
    <div class="masthead-flex">
      <div class="publication-name">Data Journalism Project</div>
      <div class="issue-date">Data Bit 2 · April 30th 2026</div>
    </div>
  </div>

  <div class="header">
    <div class="header-inner">
      <div class="rubric">Education in Portugal</div>
      <h1 class="headline">Portugal’s broken social ladder: more education, same inequality for the next generation</h1>
      <p class="dek">Despite rapid gains in education, Portuguese teenagers’ expectations remain closely tied to their mother’s level of schooling.</p>
      <div class="byline">By Maria da Silva Ferro · 239552</div>
    </div>
  </div>

  <div class="article-body">
    <p class="lead">For much of the 20th century, education in Portugal was a privilege, not a right. Under dictatorship, access to schooling was limited and literacy rates lagged far behind the rest of Europe. When democracy arrived, education expanded rapidly, opening classrooms to a generation that had long been excluded.</p>

    <p>By any historical measure, the progress is striking. In just a few decades, Portugal transformed the educational profile of its population, lifting millions out of low schooling levels.</p>

    <p>Among today’s teenagers, a familiar pattern persists. Ask them about their future, and their answers still reflect where they come from. A child’s ambitions, especially the expectation of reaching university, remain closely tied to their mother’s education.</p>

    <p class="pullquote">The system expanded, but the ladder did not level.</p>
  </div>

  <div class="figures-strip">
    <div class="figure-cell">
      <div class="figure-num">12,729</div>
      <div class="figure-lbl">Portuguese 15-year-olds surveyed in <span class="smcp">pisa</span> 2015 and 2022</div>
    </div>

    <div class="figure-cell">
      <div class="figure-num">37<span style="font-size: 18px; font-weight: 500;"> pp</span></div>
      <div class="figure-lbl">Gap in university expectations by mother's education, 2022</div>
    </div>

    <div class="figure-cell">
      <div class="figure-num">84<span style="font-size: 18px; font-weight: 500;">%</span></div>
      <div class="figure-lbl">Children of university-educated mothers expecting university in 2022</div>
    </div>
  </div>

  <div class="chart-block">
    <div class="chart-tag">Chart 1</div>
    <h2 class="chart-title">Mother knows best</h2>
    <p class="chart-subtitle">Share of Portuguese 15-year-olds expecting a university degree, by mother's education</p>

    <div class="chart-controls">
      <span class="control-label">View</span>
      <button class="toggle-btn" data-year="2015">2015</button>
      <button class="toggle-btn" data-year="2022">2022</button>
      <button class="toggle-btn active" data-year="both">Both years</button>
    </div>

    <div class="chart-canvas-wrapper">
      <canvas id="expectationsChart"></canvas>
    </div>

    <div class="chart-source">
      <span class="chart-source-label">Source:</span><span class="smcp">oecd pisa</span> 2015 & 2022, Portuguese sample. Author's calculations.
    </div>
  </div>

  <div class="article-body">
    <h2>The stubborn gap</h2>

    <p>In 2015, only <strong>37%</strong> of Portuguese teenagers whose mothers had little education expected to go to university. Among those with university-educated mothers, that figure was <strong>79%</strong>, a gap of more than 40 percentage points.</p>

    <p>By 2022, expectations had risen for everyone. But the divide barely changed: <strong>46%</strong> for children of low-educated mothers, compared with <strong>84%</strong> for those whose mothers went to university. More teenagers are aiming higher, but their starting point still shapes how far they think they can go.</p>
  </div>

  <div class="calculator">
    <div class="chart-tag">Interactive</div>
    <h2 class="chart-title">Calculate the expectation</h2>
    <p class="chart-subtitle">Pick a mother's education level and a year. The figure shows the predicted probability that a Portuguese 15-year-old in that group expects to earn a university degree.</p>

    <div class="calc-grid">
      <div class="calc-controls">
        <div>
          <label class="calc-field-label" for="mother-edu">Mother's education</label>
          <select id="mother-edu" class="calc-select">
            <option value="low">Primary or less</option>
            <option value="below">Lower secondary</option>
            <option value="upper">Upper / post-secondary</option>
            <option value="tertiary" selected>Tertiary / university</option>
          </select>
        </div>

        <div>
          <label class="calc-field-label" for="cycle-year">PISA cycle</label>
          <select id="cycle-year" class="calc-select">
            <option value="2015">2015</option>
            <option value="2022" selected>2022</option>
          </select>
        </div>
      </div>

      <div class="calc-result">
        <div class="result-num" id="result-percentage">83.5%</div>
        <div class="result-text" id="result-text">
          of children whose mother holds a university degree expected to complete a Bachelor's degree or higher in 2022.
        </div>
      </div>
    </div>
  </div>

  <div class="article-body">
    <h2>What the numbers say</h2>

    <p>Portugal has rewritten the educational profile of an entire generation. More mothers are educated, more children expect degrees, and fewer families are locked out of schooling altogether. These are real gains.</p>

    <p>But the engine of inequality has not been switched off. As access expanded, the gap moved upstream: from who gets to study to who believes university is for them. A child’s horizon is still being drawn, in large part, before they ever walk into a classroom.</p>

<p> This matters because expectations are not just opinions — they shape decisions. Students who believe university is within reach are more likely to stay in school, invest effort, and apply. Those who do not often rule themselves out early, long before ability becomes the issue.

In that sense, inequality no longer begins at the school gate. It begins at home, in the signals children receive about what is possible for them. </p>

<p>Portugal’s education system has grown wider, but not yet fairer. The classrooms are full, but the futures they lead to are still uneven.</p>
  </div>

  <div class="methodology">
    <h3>Methodology &amp; sources</h3>
    <ul>
      <li><strong>Primary data:</strong> <span class="smcp">oecd</span> Programme for International Student Assessment, <span class="smcp">pisa</span> 2015 and 2022 Portuguese student samples.</li>
      <li><strong>Sample:</strong> 12,729 Portuguese 15-year-olds across both waves.</li>
      <li><strong>Outcome:</strong> Educational expectations, coded as expecting a Bachelor’s degree or higher.</li>
      <li><strong>Key predictor:</strong> Mother’s highest educational level, grouped into four categories from <span class="smcp">isced</span> codes.</li>
      <li><strong>Figures:</strong> Percentages are author’s calculations from the Portuguese <span class="smcp">pisa</span> student data.</li>
    </ul>
  </div>

  <div class="footer">
    <div class="footer-inner">
      <div>Interactive visualisations built with Chart.js · Statistical analysis in R</div>
      <div style="margin-top: 6px;">Data Journalism Course · 2026</div>
    </div>
  </div>

<script>
  const expectationsData = {
    labels: ['Primary or less', 'Lower secondary', 'Upper / post-sec.', 'Tertiary'],
    y2015: [37.2, 43.6, 68.2, 79.2],
    y2022: [46.1, 53.7, 67.4, 83.5]
  };

  const predictedProbs = {
    '2015': { low: 37.2, below: 43.6, upper: 68.2, tertiary: 79.2 },
    '2022': { low: 46.1, below: 53.7, upper: 67.4, tertiary: 83.5 }
  };

  const eduLabels = {
    low: 'whose mother has primary education or less',
    below: 'whose mother completed lower secondary education',
    upper: 'whose mother has upper or post-secondary education',
    tertiary: 'whose mother holds a university degree'
  };

  const COLOR_2015 = '#6E6E6E';
  const COLOR_2022 = '#E3120B';

  const baseOptions = () => ({
    responsive: true,
    maintainAspectRatio: false,
    layout: { padding: { top: 8, right: 8, bottom: 4, left: 4 } },
    plugins: {
      legend: {
        position: 'top',
        align: 'start',
        labels: {
          boxWidth: 12,
          boxHeight: 12,
          padding: 14,
          font: { size: 12, family: "'Inter', sans-serif", weight: '500' },
          color: '#2C2C2C'
        }
      },
      tooltip: {
        backgroundColor: '#121212',
        titleFont: { family: "'Inter', sans-serif", size: 12, weight: '600' },
        bodyFont: { family: "'Inter', sans-serif", size: 12 },
        padding: 10,
        cornerRadius: 0,
        displayColors: true,
        boxPadding: 4,
        callbacks: { label: c => c.dataset.label + ': ' + c.parsed.y + '%' }
      }
    }
  });

  function makeScales(xTitle, yMax) {
    return {
      y: {
        beginAtZero: true,
        max: yMax || 100,
        ticks: {
          callback: v => v + '%',
          font: { size: 11, family: "'Inter', sans-serif" },
          color: '#6E6E6E'
        },
        grid: { color: '#E5E5E5', drawBorder: false },
        border: { display: false }
      },
      x: {
        ticks: {
          font: { size: 11, family: "'Inter', sans-serif" },
          color: '#2C2C2C'
        },
        grid: { display: false },
        border: { color: '#121212', width: 1 },
        title: {
          display: !!xTitle,
          text: xTitle || '',
          font: { size: 11, family: "'Inter', sans-serif", weight: '500' },
          color: '#6E6E6E',
          padding: { top: 8 }
        }
      }
    };
  }

  const expCtx = document.getElementById('expectationsChart').getContext('2d');
  const expOptions = baseOptions();
  expOptions.scales = makeScales("Mother's education", 100);

  let expChart = new Chart(expCtx, {
    type: 'bar',
    data: {
      labels: expectationsData.labels,
      datasets: [
        { label: '2015', data: expectationsData.y2015, backgroundColor: COLOR_2015, borderWidth: 0, barPercentage: 0.85, categoryPercentage: 0.7 },
        { label: '2022', data: expectationsData.y2022, backgroundColor: COLOR_2022, borderWidth: 0, barPercentage: 0.85, categoryPercentage: 0.7 }
      ]
    },
    options: expOptions
  });

  document.querySelectorAll('.toggle-btn[data-year]').forEach(btn => {
    btn.addEventListener('click', () => {
      document.querySelectorAll('.toggle-btn[data-year]').forEach(b => b.classList.remove('active'));
      btn.classList.add('active');

      const year = btn.dataset.year;

      if (year === '2015') {
        expChart.data.datasets = [
          { label: '2015', data: expectationsData.y2015, backgroundColor: COLOR_2015, borderWidth: 0, barPercentage: 0.7, categoryPercentage: 0.8 }
        ];
      } else if (year === '2022') {
        expChart.data.datasets = [
          { label: '2022', data: expectationsData.y2022, backgroundColor: COLOR_2022, borderWidth: 0, barPercentage: 0.7, categoryPercentage: 0.8 }
        ];
      } else {
        expChart.data.datasets = [
          { label: '2015', data: expectationsData.y2015, backgroundColor: COLOR_2015, borderWidth: 0, barPercentage: 0.85, categoryPercentage: 0.7 },
          { label: '2022', data: expectationsData.y2022, backgroundColor: COLOR_2022, borderWidth: 0, barPercentage: 0.85, categoryPercentage: 0.7 }
        ];
      }

      expChart.update();
    });
  });

  const motherEduSelect = document.getElementById('mother-edu');
  const cycleYearSelect = document.getElementById('cycle-year');
  const resultPct = document.getElementById('result-percentage');
  const resultText = document.getElementById('result-text');

  function updateCalculator() {
    const edu = motherEduSelect.value;
    const year = cycleYearSelect.value;
    const pct = predictedProbs[year][edu];

    resultPct.textContent = pct.toFixed(1) + '%';
    resultText.innerHTML =
      'of children ' +
      eduLabels[edu] +
      " expected to complete a Bachelor's degree or higher in " +
      year +
      '.';
  }

  motherEduSelect.addEventListener('change', updateCalculator);
  cycleYearSelect.addEventListener('change', updateCalculator);
  updateCalculator();
</script>

</body>
</html>
)"

writeLines(students, "students.html")
browseURL("students.html")