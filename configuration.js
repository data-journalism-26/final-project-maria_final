// ============================================================
// A Mile Too Far — Configuration
// ============================================================

var config = {
    style: 'mapbox://styles/mariasferro/cmp2lqwlu000j01qwcyzyhcvz',
    accessToken: 'pk.eyJ1IjoibWFyaWFzZmVycm8iLCJhIjoiY21wMmJxdDQ3MDB2bDJwczM4NHV1b2NwZiJ9.-rl6lthOKr-IvgereTT-uA',
    projection: 'albers',
    showMarkers: false,
    markerColor: '#c00',
    theme: 'light',
    use3dTerrain: false,
    auto: false,
    footer: 'Sources: USDA Economic Research Service, Food Access Research Atlas (2019). Supermarket, corner stores and fast-food locations were scraped using osmextract from public available data.',

    chapters: [

        // ============================================================
        // INTRO — Definition (national basemap, no thematic layers)
        // ============================================================
        {
            id: 'intro',
            alignment: 'full',
            hidden: false,
            title: '',
            description: '<p>In parts of Alaska&rsquo;s Yukon-Koyukuk Borough, the nearest full-service supermarket sits in Fairbanks or Galena, 130 to 300 miles away. In stretches of the Mississippi Delta, it is a 30-minute drive past gas stations and dollar stores. In neighbourhoods of South Los Angeles, it is a single bus transfer that, for a family without a car, can turn a grocery run into a half-day expedition. These places share almost nothing in common except a government label: <strong>food deserts</strong>.</p><p>In 2019, nearly 39 million Americans live in one. <strong>The U.S. Department of Agriculture (USDA)</strong> defines a food desert based on Census tracts and they have to meet two conditions. The first one, tracts must be in a <strong>low income</strong> and the second one they need to have <strong>low food access</strong>. When both are present within a tract, the area receives this designation.</p><p>To examine food deserts is to examine how access to food is unevenly distributed across the United States. In many of these communities, families rely on convenience stores and corner shops where fresh produce is limited and often more expensive than heavily processed food. Yet the same federal label is applied to places that differ sharply in geography, infrastructure, and daily life. This story maps those differences and explores what the designation of a food desert can hide.</p><p>Food deserts have long been framed as a public health issue, but mapping their geography reveals broader patterns tied to poverty, segregation, underinvestment, and limited policy action. The following maps show that food deserts are not simply places without supermarkets, they are landscapes shaped by economic exclusion.</p>',
            location: { center: [-96.0, 38.0], zoom: 2.8, pitch: 0, bearing: 0 },
            mapAnimation: 'flyTo',
            rotateAnimation: false,
            callback: '',
            onChapterEnter: [
                { layer: 'act1-supermarkets',   opacity: 0,   duration: 400 },
                { layer: 'basemap-counties',    opacity: 0.2, duration: 400 },
                { layer: 'basemap-states',      opacity: 1,   duration: 400 },
                { layer: 'act1-poverty',        opacity: 0,   duration: 400 },
                { layer: 'act1-income-avg',     opacity: 0,   duration: 400 },
                { layer: 'act1-no-vehicle',     opacity: 0,   duration: 400 },
                { layer: 'act1-fd-tracts',      opacity: 0,   duration: 400 },
                { layer: 'act2-pop-affected',   opacity: 0,   duration: 400 },
                { layer: 'act2-pop-black',      opacity: 0,   duration: 400 },
                { layer: 'act2-pop-hispanic',   opacity: 0,   duration: 400 },

            ],
            onChapterExit: []
        },

        // ============================================================
        // PART 1 — DEFINING A FOOD DESERT
        // ============================================================

        // --- 1A. introducing USDA definition ---
        {
            id: 'basemap-states',
            alignment: 'left',
            hidden: false,
            title: 'Classifying food deserts:',
description: '<p>Under the USDA definition, food deserts must meet two conditions: <strong>low income</strong> and <strong>low food access</strong>. The following maps explore how these two measures appear across the United States.</p>',            location: { center: [-92.0, 36.0], zoom: 4.2, pitch: 0, bearing: 0 },
            mapAnimation: 'flyTo',
            onChapterEnter: [
                { layer: 'basemap-counties',  opacity: 0.2, duration: 600 },
                { layer: 'basemap-states',    opacity: 1,   duration: 600 },
                { layer: 'act1-poverty',      opacity: 0,   duration: 400 },
                { layer: 'act1-income-avg',   opacity: 0,   duration: 400 },
                { layer: 'act1-no-vehicle',   opacity: 0,   duration: 400 },
                { layer: 'act1-supermarkets', opacity: 0,   duration: 400 },
                { layer: 'act1-fd-tracts',    opacity: 0,   duration: 400 }
            ],
            onChapterExit: []
        },

        // --- 1B. Low income: median family income ---
        {
            id: 'income',
            alignment: 'right',
            hidden: false,
            title: 'Income below the threshold',
description: '<p>A census tract is classified as <strong>low income</strong> when median family income falls below <strong>80%</strong> of the surrounding area&rsquo;s median income, or when at least <strong>20%</strong> of residents live below the poverty line.</p><p>In 2019, the median household income in the United States was around <strong>$68,821</strong>. In census tracts classified as food deserts, that figure dropped to roughly <strong>$48,750</strong>.</p><p>The map highlights the areas where income falls below the national threshold. <strong>Darker areas indicate communities with lower income levels and deeper economic disadvantage.</strong></p>',
            location: { center: [-92.0, 36.0], zoom: 4.2, pitch: 0, bearing: 0 },
            mapAnimation: 'flyTo',
            onChapterEnter: [
                { layer: 'basemap-counties',  opacity: 0.2, duration: 400 },
                { layer: 'basemap-states',    opacity: 1,   duration: 400 },
                { layer: 'act1-income-avg',   opacity: 1,   duration: 700 },
                { layer: 'act1-poverty',      opacity: 0,   duration: 400 },
                { layer: 'act1-no-vehicle',   opacity: 0,   duration: 400 },
                { layer: 'act1-supermarkets', opacity: 0,   duration: 400 },
                { layer: 'act1-fd-tracts',    opacity: 0,   duration: 400 }
            ], 
                        onChapterExit: []

        },

        // --- 1C. Low income: poverty rate ---
        {
            id: 'poverty',
            alignment: 'right',
            hidden: false,
            title: 'Concentrated poverty',
description: '<p>A second measure used to identify low-income census tracts is the <strong>poverty rate</strong>. Across the United States, the poverty rate in 2019 stood at <strong>10.5%</strong>. In census tracts classified as food deserts, the average rate reached <strong>24.4%</strong>.</p><p>As with income, darker areas on the map indicate communities where poverty levels rise further above the national average.</p>',
            location: { center: [-92.0, 36.0], zoom: 4.2, pitch: 0, bearing: 0 },
            mapAnimation: 'flyTo',
            onChapterEnter: [
                { layer: 'act1-poverty',      opacity: 1,   duration: 800 },
                { layer: 'basemap-counties',  opacity: 0.2, duration: 400 },
                { layer: 'basemap-states',    opacity: 1,   duration: 400 },
                { layer: 'act1-income-avg',   opacity: 0,   duration: 500 },
                 { layer: 'act1-poverty',      opacity: 1,   duration: 400 },

                { layer: 'act1-no-vehicle',   opacity: 0,   duration: 400 },
                { layer: 'act1-supermarkets', opacity: 0,   duration: 400 },
                { layer: 'act1-fd-tracts',    opacity: 0,   duration: 400 }
            ], 
                        onChapterExit: []

        },

        // --- 1D. Low access: distance + no vehicle ---
        {
            id: 'no-vehicle',
            alignment: 'left',
            hidden: false,
            title: 'Transportation barriers',
            description: '<p>The second condition used to identify food deserts is <strong>low food access</strong>, meaning limited access to <strong>supermarkets</strong> and fresh food.</p><p><strong>Transportation</strong> plays an important role in determining that access. For households without a <strong>vehicle</strong>, even short distances to a supermarket can become difficult because of <strong>travel time</strong>, limited <strong>public transportation</strong>, or infrastructure gaps.</p><p>The highlighted areas on the map represent households in food desert census tracts without access to a vehicle. In <strong>large cities</strong>, public transportation can partially reduce these barriers. But in <strong>rural areas</strong>, where distances are greater and transit options are limited, the absence of a car can turn grocery shopping into a major challenge.</p>',
            location: { center: [-96.0, 38.0], zoom: 3.8, pitch: 0, bearing: 0 },
            mapAnimation: 'flyTo',
            onChapterEnter: [
                { layer: 'basemap-counties',  opacity: 0.2, duration: 400 },
                { layer: 'basemap-states',    opacity: 1,   duration: 400 },
                { layer: 'act1-income-avg',   opacity: 0,   duration: 400 },
                { layer: 'act1-poverty',      opacity: 0,   duration: 400 },
                { layer: 'act1-no-vehicle',   opacity: 1,   duration: 700 },
                { layer: 'act1-supermarkets', opacity: 0,   duration: 700 },
                { layer: 'act1-fd-tracts',    opacity: 0,   duration: 400 }
            ], 
                        onChapterExit: []

        },

        // --- 1E. Supermarket distribution ---
        {
            id: 'supermarkets',
            alignment: 'left',
            hidden: false,
            title: 'Supermarket availability',
description: '<p>Under the USDA definition, a census tract is considered low access when at least <strong>500 residents</strong>, or <strong>one-third of the population</strong>, live more than one mile from the nearest supermarket in urban areas. In <strong>rural areas</strong>, that distance increases to <strong>ten miles</strong>.</p><p>The distribution of supermarkets across the United States is uneven. The map reveals clear regional differences in access to what the USDA considers fresh food retailers, measured through proximity to supermarkets.</p><p>The blue dots represent major supermarket chains across the country.</p>',
            location: { center: [-96.0, 38.0], zoom: 3.8, pitch: 0, bearing: 0 },
            mapAnimation: 'flyTo',
            onChapterEnter: [
                { layer: 'basemap-counties',  opacity: 0.2, duration: 400 },
                { layer: 'basemap-states',    opacity: 1,   duration: 400 },
                { layer: 'act1-income-avg',   opacity: 0,   duration: 400 },
                { layer: 'act1-poverty',      opacity: 0,   duration: 400 },
                { layer: 'act1-no-vehicle',   opacity: 0,   duration: 700 },
                { layer: 'act1-supermarkets', opacity: 1,   duration: 700 },
                { layer: 'act1-fd-tracts',    opacity: 0,   duration: 400 }
            ], 
                        onChapterExit: []

        },

        // --- 1F. Reveal: where the two collide ---
        {
            id: 'where-two-collide',
            alignment: 'right',
            hidden: false,
            title: 'Where the two collide',
description: '<p><strong>Food deserts emerge</strong> where <strong>low income</strong> and <strong>low food access</strong> overlap. These census tracts, classified by the USDA as <strong>low-income and low-access areas</strong>, are places where economic hardship and physical distance combine to restrict access to fresh food.</p>',            location: { center: [-96.0, 38.0], zoom: 3.8, pitch: 0, bearing: 0 },
            mapAnimation: 'flyTo',
            onChapterEnter: [
                { layer: 'basemap-counties',  opacity: 0.2, duration: 400 },
                { layer: 'basemap-states',    opacity: 1,   duration: 400 },
                { layer: 'act1-income-avg',   opacity: 0,   duration: 400 },
                { layer: 'act1-poverty',      opacity: 0,   duration: 400 },
                { layer: 'act1-no-vehicle',   opacity: 0,   duration: 400 },
                { layer: 'act1-supermarkets', opacity: 0,   duration: 400 },
                { layer: 'act2-pop-affected', opacity: 1,   duration: 500 }
            ],
            onChapterExit: []
        },

        // ============================================================
// PART 2 — A CLOSER LOOK (text + swipe map + post-map framing)
// ============================================================
{
    id: 'article-transition-1',
    alignment: 'full',
    hidden: false,
    swipe: true,
    title: 'A closer look',
description: '<p>To move from the national pattern to the local reality, the maps below shift between two scales of analysis. The state view highlights the broader regional concentration of food deserts, while the county view reveals the specific communities where limited food access becomes part of everyday life.</p><p>Darker shades indicate a higher concentration of food desert census tracts at both scales. Drag the divider to compare the two perspectives and see how statewide patterns translate into local disparities.</p>',
descriptionAfter: '<p>Looking only at statewide totals or darker regions can flatten very different realities into a single national label. A food desert in rural Alaska does not look like one in South Los Angeles or the Mississippi Delta, even when all fall under the same federal definition.</p><p>The maps reveal where food deserts are located, but not who lives there or what replaces the supermarket when one is absent. In many communities, <strong>convenience stores</strong>, <strong>dollar stores</strong>, and <strong>fast food chains</strong> become the most accessible food options.</p><p>The following section takes a closer look at four states with some of the highest concentrations of food desert census tracts in the United States. Together, they show how <strong>low income</strong> and <strong>low food access</strong> create very different landscapes across the country.</p>',
location: { center: [-96.0, 38.0], zoom: 2.8, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    rotateAnimation: false,
    callback: 'initializeBeyondSwipe',
    onChapterEnter: [
        { layer: 'act1-supermarkets',   opacity: 0,   duration: 400 },
        { layer: 'basemap-counties',    opacity: 0.2, duration: 400 },
        { layer: 'basemap-states',      opacity: 1,   duration: 400 },
        { layer: 'act1-poverty',        opacity: 0,   duration: 400 },
        { layer: 'act1-income-avg',     opacity: 0,   duration: 400 },
        { layer: 'act1-no-vehicle',     opacity: 0,   duration: 400 },
        { layer: 'act1-fd-tracts',      opacity: 0,   duration: 400 },
        { layer: 'act2-pop-affected',   opacity: 0,   duration: 400 },
        { layer: 'act2-pop-black',      opacity: 0,   duration: 400 },
        { layer: 'act2-pop-hispanic',   opacity: 0,   duration: 400 }
    ],
    onChapterExit: []
},
 

// ============================================================
// PART 2B — FOUR PLACES, FOUR MECHANISMS
// ============================================================

// --- 2A. Mississippi: severity (intro) ---
{
    id: 'mississippi',
    alignment: 'right',
    hidden: false,
    title: 'The most severe concentration',
description: '<p>Mississippi contains one of the country&rsquo;s highest concentrations of food deserts. Around <strong>31.6%</strong> of its census tracts meet the USDA definition. Within these tracts, the average poverty rate reaches <strong>32.6%</strong>, while median family income sits slightly above <strong>$40,000</strong>.</p><p>A closer look at the state reveals how uneven food access becomes across the <strong>Mississippi Delta</strong> and rural counties.</p>',
    location: { center: [-90.0, 33.0], zoom: 6.2, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-states',       opacity: 1,   duration: 500 },

        // hide national layers
        { layer: 'act1-poverty',        opacity: 0,   duration: 400 },
        { layer: 'act2-pop-affected',    opacity: 0,   duration: 400 },

        // show Mississippi context
        { layer: 'act1-poverty-ms',      opacity: 1,   duration: 600 },
        { layer: 'act2-pop-affected-ms', opacity: 1,   duration: 600 }
    ],
    onChapterExit: []
},

// --- 2A.1 Mississippi: supermarkets ---
{
    id: 'mississippi-supermarkets',
    alignment: 'right',
    hidden: false,
    title: 'Mapping food access: supermarkets',
description: '<p>The blue circles on the map represent major supermarket chains across Mississippi. Most cluster around larger urban areas such as Jackson, leaving wide stretches of the Delta and rural counties with fewer options.</p>',
    location: { center: [-90.0, 33.0], zoom: 6.2, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',     opacity: 0.2, duration: 500 },
        { layer: 'basemap-states',       opacity: 1,   duration: 500 },

        // dim context
        { layer: 'act1-poverty-ms',      opacity: 0.4, duration: 600 },
        { layer: 'act2-pop-affected-ms', opacity: 0.4, duration: 600 },

        // retail: supermarkets on
        { layer: 'act1-supermarkets-ms', opacity: 1,   duration: 600 }
    ],
    onChapterExit: []
},

// --- 2A.2 Mississippi: + convenience stores ---
{
    id: 'mississippi-convenience',
    alignment: 'right',
    hidden: false,
    title: 'Mapping food access: corner stores',
description: '<p>In many of the darker red census tracts, convenience stores and gas stations become the closest available food retailers. Represented in grey, these stores often fill the gaps left by supermarkets, particularly across rural communities where food options are already limited.</p>',
    location: { center: [-90.0, 33.0], zoom: 6.2, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',      opacity: 0.2, duration: 500 },
        { layer: 'basemap-states',        opacity: 1,   duration: 500 },

        // keep context dim
        { layer: 'act1-poverty-ms',       opacity: 0.4, duration: 600 },
        { layer: 'act2-pop-affected-ms',  opacity: 0.4, duration: 600 },

        // retail stack: supermarkets stay, add convenience
        { layer: 'act1-supermarkets-ms',  opacity: 1,   duration: 600 },
        { layer: 'mississippi-convenience', opacity: 1, duration: 600 }
    ],
    onChapterExit: []
},

// --- 2A.3 Mississippi: + fast food ---
{
    id: 'mississippi-fastfood',
    alignment: 'right',
    hidden: false,
    title: 'And what else is on the road: fast food',
description: '<p>Fast food chains, shown in yellow, fill much of the remaining commercial landscape. Together, these layers reveal communities where access to fresh food becomes increasingly limited and heavily dependent on processed or fast food options.</p>',
    location: { center: [-90.0, 33.0], zoom: 6.2, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',        opacity: 0.2, duration: 500 },
        { layer: 'basemap-states',          opacity: 1,   duration: 500 },

        // keep context dim
        { layer: 'act1-poverty-ms',         opacity: 0.4, duration: 600 },
        { layer: 'act2-pop-affected-ms',    opacity: 0.4, duration: 600 },

        // full retail stack
        { layer: 'act1-supermarkets-ms',    opacity: 1,   duration: 600 },
        { layer: 'mississippi-convenience', opacity: 1,   duration: 600 },
        { layer: 'mississipi-fastfood',     opacity: 1,   duration: 600 }
    ],
    onChapterExit: [
        // clean up all Mississippi layers before Texas
        { layer: 'act1-poverty-ms',         opacity: 0, duration: 400 },
        { layer: 'act2-pop-affected-ms',    opacity: 0, duration: 400 },
        { layer: 'act1-supermarkets-ms',    opacity: 0, duration: 400 },
        { layer: 'mississippi-convenience', opacity: 0, duration: 400 },
        { layer: 'mississipi-fastfood',     opacity: 0, duration: 400 }
    ]
},


// --- 2A.4 Mississippi: + racial demographics ---
{
    id: 'mississippi-demographics',
    alignment: 'right',
    hidden: false,
    title: 'Demographic layer: who is most affected',
description: '<p>A final demographic layer reveals another pattern. Many of the census tracts with the highest concentration of food deserts also contain some of the state&rsquo;s largest Black populations, particularly across the Mississippi Delta. The geography of food access overlaps closely with the geography of historical racial and economic inequality in the state.</p><p>More clearly than in almost any other state, Mississippi visually aligns with the USDA definition of food deserts. Large concentrations of low income, limited supermarket access, convenience stores, and fast food chains overlap across the same communities. But while Mississippi shows the most severe concentration of food deserts on the map, the following state reveals how the same designation expands across a much larger and more geographically diverse population.</p>',
    location: { center: [-90.0, 33.0], zoom: 6.2, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',        opacity: 0.2, duration: 500 },
        { layer: 'basemap-states',          opacity: 1,   duration: 500 },

        // demographic layer (under the retail points)
        { layer: 'act2-pop-black-ms',       opacity: 0.9, duration: 600 },

      
    ],
    onChapterExit: [
        // clean up all Mississippi layers before Texas
        { layer: 'act2-pop-black-ms',       opacity: 0, duration: 400 },
        { layer: 'act1-supermarkets-ms',    opacity: 0, duration: 400 },
        { layer: 'mississippi-convenience', opacity: 0, duration: 400 },
        { layer: 'mississipi-fastfood',     opacity: 0, duration: 400 }
    ]
},



// --- 2B. Texas: scale (intro) ---
{
    id: 'texas',
    alignment: 'left',
    hidden: false,
    title: 'The largest burden by overall population',
description: '<p>If Mississippi reveals the country&rsquo;s most concentrated food deserts, Texas reveals their largest scale. More than <strong>2.4 million people</strong> in Texas live in census tracts classified as food deserts, more than in any other state.</p>',
    location: { center: [-99.0, 30.5], zoom: 5.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,    duration: 500 },
        { layer: 'basemap-states',         opacity: 1,    duration: 500 },
        { layer: 'act1-poverty-tx',        opacity: 1,    duration: 600 },
        { layer: 'act2-pop-affected-tx',   opacity: 1,    duration: 600 }
    ],
    onChapterExit: []
},

// --- 2B.1 Texas: supermarkets ---
{
    id: 'texas-supermarkets',
    alignment: 'left',
    hidden: false,
    title: 'Mapping food access in Texas',
description: '<p>Unlike Mississippi, where food deserts cluster heavily across the Delta, Texas presents a far more geographically uneven landscape. Large urban centers contain dense concentrations of supermarkets, while rural East Texas and the Rio Grande Valley remain far less connected to full-service grocery stores.</p>',
    location: { center: [-99.0, 30.5], zoom: 5.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,    duration: 500 },
        { layer: 'basemap-states',         opacity: 1,    duration: 500 },

        // dim context
        { layer: 'act1-poverty-tx',        opacity: 0.2,  duration: 600 },
        { layer: 'act2-pop-affected-tx',   opacity: 0.2,  duration: 600 },

        // retail: supermarkets on
        { layer: 'act1-supermarkets-tx',   opacity: 1,    duration: 600 }
    ],
    onChapterExit: []
},

// --- 2B.2 Texas: + convenience stores (text visible) ---
{
    id: 'texas-convenience',
    alignment: 'left',
    hidden: false,
    title: '',
    description: '<p>As in Mississippi, the maps layer supermarkets, convenience stores, and fast food chains to show how food access changes across the state. In many rural counties along the southern border, convenience stores and fast food chains become far more common than supermarkets.</p>',
    location: { center: [-99.0, 30.5], zoom: 5.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,    duration: 500 },
        { layer: 'basemap-states',         opacity: 1,    duration: 500 },

        { layer: 'act1-poverty-tx',        opacity: 0.2,  duration: 600 },
        { layer: 'act2-pop-affected-tx',   opacity: 0.2,  duration: 600 },

        { layer: 'act1-supermarkets-tx',   opacity: 1,    duration: 600 },
        { layer: 'texas-convenience',      opacity: 1,    duration: 600 }
    ],
    onChapterExit: []
},

// --- 2B.3 Texas: + fast food (invisible scroll trigger) ---
{
    id: 'texas-fastfood',
    alignment: 'left',
    hidden: true,
    title: '',
    description: '',
    location: { center: [-99.0, 30.5], zoom: 5.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,    duration: 500 },
        { layer: 'basemap-states',         opacity: 1,    duration: 500 },

        { layer: 'act1-poverty-tx',        opacity: 0.2,  duration: 600 },
        { layer: 'act2-pop-affected-tx',   opacity: 0.2,  duration: 600 },

        { layer: 'act1-supermarkets-tx',   opacity: 1,    duration: 600 },
        { layer: 'texas-convenience',      opacity: 1,    duration: 600 },
        { layer: 'texas-fastfood',         opacity: 1,    duration: 600 }
    ],
    onChapterExit: [
        { layer: 'act1-poverty-tx',        opacity: 0, duration: 400 },
        { layer: 'act2-pop-affected-tx',   opacity: 0, duration: 400 },
        { layer: 'act1-supermarkets-tx',   opacity: 0, duration: 400 },
        { layer: 'texas-convenience',      opacity: 0, duration: 400 },
        { layer: 'texas-fastfood',         opacity: 0, duration: 400 }
    ]
},

// --- 2B.4 Texas: + Hispanic demographics ---
{
    id: 'texas-demographics-hispanic',
    alignment: 'left',
    hidden: false,
    title: 'Who is most affected: the Rio Grande Valley',
description: '<p>The demographic patterns also shift. Along the Rio Grande Valley, food desert census tracts overlap closely with heavily Hispanic communities, where supermarkets become increasingly scarce and alternative food retailers dominate the landscape.</p>',    location: { center: [-99.0, 30.5], zoom: 5.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',        opacity: 0.2, duration: 500 },
        { layer: 'basemap-states',          opacity: 1,   duration: 500 },

        // demographic layer
        { layer: 'act2-pop-hispanic-texas', opacity: 0.95, duration: 600 },
        { layer: 'act2-pop-black-texas',    opacity: 0,    duration: 400 },

    
    ],
    onChapterExit: []
},

// --- 2B.5 Texas: + Black demographics ---
{
    id: 'texas-demographics-black',
    alignment: 'left',
    hidden: false,
    title: 'Who is most affected: East Texas',
description: '<p>East Texas reveals a different pattern. Many predominantly Black communities remain classified as food deserts despite being geographically closer to supermarkets. Here, the federal designation becomes more difficult to interpret through distance alone, suggesting that transportation, poverty, and infrastructure continue to shape practical access to food.</p><p>California pushes that contradiction even further. Unlike Mississippi or Texas, where food deserts are often associated with rural distance and limited infrastructure, the next state reveals how food deserts can also exist inside dense and highly connected urban environments.</p>',
location: { center: [-99.0, 30.5], zoom: 5.5, pitch: 0, bearing: 0 },    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',        opacity: 0.2, duration: 500 },
        { layer: 'basemap-states',          opacity: 1,   duration: 500 },

        // swap demographic layers
        { layer: 'act2-pop-hispanic-texas', opacity: 0,    duration: 400 },
        { layer: 'act2-pop-black-texas',    opacity: 0.95, duration: 600 },

            ],
    onChapterExit: [
        // clean up everything Texas before next state
        { layer: 'act2-pop-black-texas',    opacity: 0, duration: 400 },
        { layer: 'act2-pop-hispanic-texas', opacity: 0, duration: 400 },
        { layer: 'act1-supermarkets-tx',    opacity: 0, duration: 400 },
        { layer: 'texas-convenience',       opacity: 0, duration: 400 },
        { layer: 'texas-fastfood',          opacity: 0, duration: 400 }
    ]
},



// ============================================================
// 2C. CALIFORNIA — the paradox of access
// ============================================================

// --- 2C. California: state-level paradox ---
{
    id: 'california',
    alignment: 'right',
    hidden: false,
    title: 'The urban paradox',
    description: '<p>From a state-level view, California looks relatively spared. Only <strong>6.7%</strong> of its census tracts qualify as food deserts &mdash; one of the lowest shares in the country, far below Mississippi or Texas.</p><p>And yet nearly <strong>1.2 million people in California</strong> live in one. The state\u2019s food deserts are not spread across rural counties; they are concentrated in the dense urban neighborhoods that a state-level map cannot show.</p>',
    location: { center: [-119.5, 37.0], zoom: 5.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,   duration: 500 },
        { layer: 'basemap-states',         opacity: 1,   duration: 500 },
        { layer: 'act1-poverty-ca',        opacity: 1,   duration: 600 },
        { layer: 'act2-pop-affected-ca',   opacity: 1,   duration: 600 }
    ],
    onChapterExit: []
},

// --- 2C.1 Los Angeles: zoom into the urban form ---
{
    id: 'los-angeles',
    alignment: 'right',
    hidden: false,
    title: 'Los Angeles: the urban form',
description: '<p>In South and East Los Angeles, food deserts cluster within highly populated communities surrounded by wealth, traffic, and extensive transportation infrastructure. What appears limited at the state scale becomes far more visible at the neighborhood level.</p>',    location: { center: [-118.25, 33.95], zoom: 9.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,    duration: 500 },
        { layer: 'basemap-states',         opacity: 1,    duration: 500 },

        // keep state context visible underneath at lower opacity
        { layer: 'act1-poverty-ca',        opacity: 0.3,  duration: 600 },
        { layer: 'act2-pop-affected-ca',   opacity: 0.3,  duration: 600 }
    ],
    onChapterExit: []
},

// --- 2C.2 Los Angeles: where the supermarkets are ---
{
    id: 'los-angeles-supermarkets',
    alignment: 'right',
    hidden: false,
    title: 'Mapping food access',
description: '<p>The same spatial pattern emerges once again: supermarkets become less common while convenience stores and fast food chains dominate the surrounding food landscape.</p>',    location: { center: [-118.25, 33.95], zoom: 9.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,    duration: 500 },
        { layer: 'basemap-states',         opacity: 1,    duration: 500 },

        // dim context
        { layer: 'act1-poverty-ca',        opacity: 0.2,  duration: 600 },
        { layer: 'act2-pop-affected-ca',   opacity: 0.2,  duration: 600 },

        // retail: supermarkets on
        { layer: 'act1-supermarkets-ca',   opacity: 1,    duration: 600 }
    ],
    onChapterExit: []
},

// --- 2C.3 Los Angeles: + convenience stores ---
{
    id: 'los-angeles-convenience',
    alignment: 'right',
    hidden: true,
    title: '',
    description: '',
    location: { center: [-118.25, 33.95], zoom: 9.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,    duration: 500 },
        { layer: 'basemap-states',         opacity: 1,    duration: 500 },

        { layer: 'act1-poverty-ca',        opacity: 0.2,  duration: 600 },
        { layer: 'act2-pop-affected-ca',   opacity: 0.2,  duration: 600 },

        { layer: 'act1-supermarkets-ca',   opacity: 1,    duration: 600 },
        { layer: 'california-convenience', opacity: 1,    duration: 600 }
    ],
    onChapterExit: []
},

// --- 2C.4 Los Angeles: + fast food ---
{
    id: 'los-angeles-fastfood',
    alignment: 'right',
    hidden: false,
    title: '',
description: '<p>California complicates the definition of food deserts by showing how limited food access can persist even inside dense and highly connected urban environments. In a city as economically powerful and connected as Los Angeles, distance alone cannot fully explain access to fresh food. The maps suggest that proximity to supermarkets does not always translate into practical or affordable access.</p><p>Alaska pushes that contradiction even further. In this next state, geography itself becomes the barrier.</p>',    location: { center: [-118.25, 33.95], zoom: 9.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,    duration: 500 },
        { layer: 'basemap-states',         opacity: 1,    duration: 500 },

        { layer: 'act1-poverty-ca',        opacity: 0.2,  duration: 600 },
        { layer: 'act2-pop-affected-ca',   opacity: 0.2,  duration: 600 },

        { layer: 'act1-supermarkets-ca',   opacity: 1,    duration: 600 },
        { layer: 'california-convenience', opacity: 1,    duration: 600 },
        { layer: 'california-fastfood',    opacity: 1,    duration: 600 }
    ],
    onChapterExit: [
        // clean up all California layers before Alaska
        { layer: 'act1-poverty-ca',        opacity: 0, duration: 400 },
        { layer: 'act2-pop-affected-ca',   opacity: 0, duration: 400 },
        { layer: 'act1-supermarkets-ca',   opacity: 0, duration: 400 },
        { layer: 'california-convenience', opacity: 0, duration: 400 },
        { layer: 'california-fastfood',    opacity: 0, duration: 400 }
    ]
},


// ============================================================
// 2D. ALASKA — geography as the barrier
// ============================================================

// --- 2D. Alaska: state intro ---
{
    id: 'alaska',
    alignment: 'left',
    hidden: false,
    title: 'Geography as the barrier',
    description: '<p>Unlike Mississippi, Texas, or California, Alaska does not closely match the economic patterns usually associated with food deserts. The state&rsquo;s poverty rate, <strong>11.4%</strong>, sits close to the national average and far below the levels seen across many Southern states. By income measures alone, Alaska would be expected to contain relatively few food deserts.</p><p>Instead, Alaska holds one of the highest shares of food desert census tracts in the country. In this case, distance performs the role poverty plays elsewhere.</p>',
    location: { center: [-152.0, 64.5], zoom: 4.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,    duration: 500 },
        { layer: 'basemap-states',         opacity: 1,    duration: 500 },
        { layer: 'act1-poverty-ak',        opacity: 1,    duration: 600 },
        { layer: 'act2-pop-affected-ak',   opacity: 1,    duration: 600 }
    ],
    onChapterExit: []
},

// --- 2D.1 Alaska: where the supermarkets are ---
{
    id: 'alaska-supermarkets',
    alignment: 'left',
    hidden: false,
    title: '',
    description: '<p>The maps reveal a very different landscape from the previous states. Supermarkets, convenience stores, and fast food chains cluster tightly around a small number of urban centers and road-connected communities, while vast areas of the state remain largely uncovered.</p>',
    location: { center: [-152.0, 64.5], zoom: 4.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,    duration: 500 },
        { layer: 'basemap-states',         opacity: 1,    duration: 500 },

        // dim context
        { layer: 'act1-poverty-ak',        opacity: 0.2,  duration: 600 },
        { layer: 'act2-pop-affected-ak',   opacity: 0.2,  duration: 600 },

        // retail: supermarkets on
        { layer: 'act1-supermarkets-ak',   opacity: 1,    duration: 600 }
    ],
    onChapterExit: []
},

// --- 2D.2 Alaska: + convenience stores ---
{
    id: 'alaska-convenience',
    alignment: 'left',
    hidden: true,
    title: '',
    description: '',
    location: { center: [-152.0, 64.5], zoom: 4.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,    duration: 500 },
        { layer: 'basemap-states',         opacity: 1,    duration: 500 },

        { layer: 'act1-poverty-ak',        opacity: 0.2,  duration: 600 },
        { layer: 'act2-pop-affected-ak',   opacity: 0.2,  duration: 600 },

        { layer: 'act1-supermarkets-ak',   opacity: 1,    duration: 600 },
        { layer: 'alaska-convenience',     opacity: 1,    duration: 600 }
    ],
    onChapterExit: []
},

// --- 2D.3 Alaska: + fast food ---
{
    id: 'alaska-fastfood',
    alignment: 'left',
    hidden: true,
    title: '',
    description: '',
    location: { center: [-152.0, 64.5], zoom: 4.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,    duration: 500 },
        { layer: 'basemap-states',         opacity: 1,    duration: 500 },

        { layer: 'act1-poverty-ak',        opacity: 0.2,  duration: 600 },
        { layer: 'act2-pop-affected-ak',   opacity: 0.2,  duration: 600 },

        { layer: 'act1-supermarkets-ak',   opacity: 1,    duration: 600 },
        { layer: 'alaska-convenience',     opacity: 1,    duration: 600 },
        { layer: 'alaska-fastfood',        opacity: 1,    duration: 600 }
    ],
    onChapterExit: []
},

// --- 2D.4 Alaska: distance without a vehicle ---
{
    id: 'alaska-no-vehicle',
    alignment: 'left',
    hidden: false,
    title: 'What happens without a vehicle',
description: '<p>TMeans of transportation becomes especially important in Alaska. The state contains one of the country&rsquo;s highest shares of households without access to a vehicle. In many communities, the nearest supermarket can sit hundreds of miles away, reachable only by long drives, ferries, or small aircraft.</p><p>Here, food deserts are shaped less by urban inequality or concentrated poverty than by isolation itself. Geography becomes the defining barrier to food access.</p>',    location: { center: [-152.0, 64.5], zoom: 4.5, pitch: 0, bearing: 0 },
    mapAnimation: 'flyTo',
    onChapterEnter: [
        { layer: 'basemap-counties',       opacity: 1,    duration: 500 },
        { layer: 'basemap-states',         opacity: 1,    duration: 500 },

        // retail layers fade to background context
        { layer: 'act1-poverty-ak',        opacity: 0.2,  duration: 600 },
        { layer: 'act2-pop-affected-ak',   opacity: 0.2,  duration: 600 },
        { layer: 'act1-supermarkets-ak',   opacity: 0,  duration: 600 },
        { layer: 'alaska-convenience',     opacity: 0,  duration: 600 },
        { layer: 'alaska-fastfood',        opacity: 0,  duration: 600 },

        // no-vehicle becomes the featured layer
        { layer: 'act1-no-vehicle-ak',     opacity: 1,  duration: 700 }
    ],
    onChapterExit: [
        // clean up everything Alaska before the synthesis chapter
        { layer: 'act1-poverty-ak',        opacity: 0, duration: 400 },
        { layer: 'act2-pop-affected-ak',   opacity: 0, duration: 400 },
        { layer: 'act1-no-vehicle-ak',     opacity: 0, duration: 400 },
        { layer: 'act1-supermarkets-ak',   opacity: 0, duration: 400 },
        { layer: 'alaska-convenience',     opacity: 0, duration: 400 },
        { layer: 'alaska-fastfood',        opacity: 0, duration: 400 }
    ]
},


        // ============================================================
        // OUTRO
        // ============================================================
        {
            id: 'outro',
            alignment: 'center',
            hidden: false,
            title: 'Four cases, one federal label',
description: '<p>Together, these four cases reveal what the national map alone cannot: the same federal label can describe profoundly different realities. Food deserts are shaped not only by poverty, but by distance, infrastructure, segregation, transportation, and uneven investment across the American landscape.</p><p>In Mississippi, food deserts appear through concentrated poverty and limited supermarket access across the Delta. In Texas, the scale of the issue stretches across rural counties and border communities. In California, food deserts exist inside dense urban neighborhoods surrounded by wealth and infrastructure. In Alaska, geography itself becomes the barrier.</p><p>The maps reveal where food deserts are located, who is most affected, and what kinds of food environments replace supermarkets when they are absent. Convenience stores, gas stations, dollar stores, and fast food chains become part of the daily landscape in communities where fresh food is harder to reach.</p><p>But the maps also reveal the limits of the designation itself. A single federal label cannot fully capture the different realities that exist between these communities, nor the ways residents adapt, organize, and navigate limited food access in everyday life.</p><p>Food deserts are not one American reality. They are many different landscapes connected by uneven access to food.</p><p>And today, that inequality no longer appears as a line drawn on a map. It appears in the distance to the nearest supermarket, the absence of transportation, and the food options left behind in its place.</p>',    location: { center: [-96.0, 38.0], zoom: 3.5, pitch: 0, bearing: 0 },
            location: { center: [-96.0, 38.0], zoom: 3.2, pitch: 0, bearing: 0 },
            mapAnimation: 'flyTo',
            onChapterEnter: [
                { layer: 'act1-fd-tracts',      opacity: 0.75, duration: 600 },
                { layer: 'act1-supermarkets',   opacity: 0,  duration: 600 }
            ],
            onChapterExit: []
        }
    ]
};