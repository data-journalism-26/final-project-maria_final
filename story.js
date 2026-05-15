// ============================================================
// A Mile Too Far — Scrollytelling Logic
// ============================================================
//
// ⚠️ ADDING A NEW LAYER? READ THIS FIRST ⚠️
// ------------------------------------------------------------
// To add a new thematic layer (e.g. a new state, demographic,
// or overlay), you need to touch THREE files:
//
//   1. Mapbox Studio  → Create/style the layer in your map
//                       style. Note the exact layer ID.
//
//   2. story.js (this file) → Register the layer ID in TWO
//                       places so it can be hidden when
//                       other chapters are active:
//                         (A) hideAllThematicLayers()  — search "ADD NEW LAYER ID HERE (A)"
//                         (B) setupBeyondSwipeMap()    — search "ADD NEW LAYER ID HERE (B)"
//                       Only add it to (B) if the layer
//                       should appear in the swipe map
//                       (the "A closer look" comparison).
//
//   3. configuration.js → Reference the layer inside the
//                       relevant chapter's onChapterEnter
//                       and onChapterExit arrays.
//
// Layer IDs must match EXACTLY between Mapbox Studio and the
// strings in these files (case-sensitive, no trailing spaces).
// ============================================================

var initLoad = true;

var layerTypes = {
    'fill': ['fill-opacity'],
    'line': ['line-opacity'],
    'circle': ['circle-opacity', 'circle-stroke-opacity'],
    'symbol': ['icon-opacity', 'text-opacity'],
    'raster': ['raster-opacity'],
    'fill-extrusion': ['fill-extrusion-opacity'],
    'heatmap': ['heatmap-opacity']
};

var alignments = {
    'left': 'lefty',
    'center': 'centered',
    'right': 'righty',
    'full': 'fully'
};

// ============================================================
// LAYER HELPERS
// ============================================================

function getLayerPaintType(layer) {
    var mapLayer = map.getLayer(layer);

    if (!mapLayer) {
        console.warn('Layer not found:', layer);
        return [];
    }

    return layerTypes[mapLayer.type] || [];
}

function setLayerOpacity(layer) {
    if (!layer || !layer.layer) {
        console.warn('Invalid layer object:', layer);
        return;
    }

    var paintProps = getLayerPaintType(layer.layer);

    paintProps.forEach(function (prop) {
        if (layer.duration) {
            map.setPaintProperty(layer.layer, prop + '-transition', {
                duration: layer.duration
            });
        }

        map.setPaintProperty(layer.layer, prop, layer.opacity);
    });
}

// ★★★ ADD NEW LAYER ID HERE (A) ★★★
// Every thematic layer in your Mapbox style MUST be listed below.
// This function runs once on map load and hides all of them so
// chapters can selectively reveal layers they need. If you forget
// to add a new layer here, it will stay visible across the whole
// story instead of only on the chapter where you want it.
// Add the new ID to the matching geographic group (NATIONAL, or
// the specific state). Create a new group if needed.
function hideAllThematicLayers() {
    [
        // NATIONAL
        'act1-income-avg',
        'act1-poverty',
        'act1-no-vehicle',
        'act1-fd-tracts',
        'act1-supermarkets',
        'act2-pop-affected',
        'act2-pop-black',
        'act2-pop-hispanic',
        // ← add new NATIONAL layer IDs here

        // MISSISSIPPI
        'act2-pop-affected-ms',
        'act1-poverty-ms',
        'act1-supermarkets-ms',
        'act2-pop-black-ms',
        'mississippi-convenience',
        'mississipi-fastfood',

        // ← add new MISSISSIPPI layer IDs here

        // CALIFORNIA
        'act1-poverty-ca',
        'act2-pop-affected-ca',
        'act1-supermarkets-ca',
        'california-fastfood',
        'california-convenience',
        'act2-pop-hispanic-california',
        
        // ← add new CALIFORNIA layer IDs here

        // ALASKA
        'act1-poverty-ak',
        'act1-supermarkets-ak',
        'act2-pop-affected-ak',
        'act1-no-vehicle-ak',
        'alaska-fastfood',
        'alaska-convenience',


        // ← add new ALASKA layer IDs here

        // TEXAS
        'act1-poverty-tx',
        'act1-supermarkets-tx',
        'act2-pop-affected-tx',
        'texas-fastfood',
        'texas-convenience',
        'act2-pop-hispanic-texas',
        'act2-pop-black-texas',


        // ← add new TEXAS layer IDs here

        // ← add a new STATE/REGION group here if needed,
        //   e.g. // NEW YORK
        //        'act1-poverty-ny', ...
    ].forEach(function (layerId) {
        setLayerOpacity({
            layer: layerId,
            opacity: 0,
            duration: 0
        });
    });
}

// ============================================================
// SWIPE MAP HELPERS
// ============================================================

var beyondSwipeInitialized = false;

function setSwipeLayerOpacity(swipeMap, layerId, opacity) {
    if (!swipeMap.getLayer(layerId)) return;

    var layer = swipeMap.getLayer(layerId);
    var paintProps = layerTypes[layer.type] || [];

    paintProps.forEach(function (prop) {
        swipeMap.setPaintProperty(layerId, prop, opacity);
    });
}

function setupBeyondSwipeMap(swipeMap, mode) {
    swipeMap.on('load', function () {
        // ★★★ ADD NEW LAYER ID HERE (B) ★★★
        // ONLY add an ID here if the new layer might ever appear
        // inside the "A closer look" swipe comparison map.
        // If your new layer is only used in regular scroll chapters
        // (not in the swipe), you can skip this section.
        // This list mirrors the one in hideAllThematicLayers() but
        // applies to the two side-by-side comparison maps.
        [
            // NATIONAL
        
            'act1-fd-tracts',
            'act2-pop-affected',
           
            // ← add new NATIONAL swipe layer IDs here

           
        ].forEach(function (layer) {
            setSwipeLayerOpacity(swipeMap, layer, 0);
        });

        setSwipeLayerOpacity(swipeMap, 'basemap-states', 1);

        if (mode === 'state') {
            setSwipeLayerOpacity(swipeMap, 'basemap-counties', 0);
            setSwipeLayerOpacity(swipeMap, 'act1-fd-tracts', 1);
        }

        if (mode === 'county') {
            setSwipeLayerOpacity(swipeMap, 'basemap-counties', 1);
            setSwipeLayerOpacity(swipeMap, 'act2-pop-affected', 0.9);
        }
    });
}

function initializeBeyondSwipe() {
    if (beyondSwipeInitialized) return;

    var beforeEl = document.getElementById('before');
    var afterEl = document.getElementById('after');
    var containerEl = document.getElementById('comparison-container');

    if (!beforeEl || !afterEl || !containerEl) {
        console.warn('Swipe container elements not found');
        return;
    }

    var beforeMap = new mapboxgl.Map({
        container: 'before',
        style: config.style,
        center: [-96.0, 38.0],
        zoom: 3.5,
        pitch: 0,
        bearing: 0,
        projection: config.projection
    });

    var afterMap = new mapboxgl.Map({
        container: 'after',
        style: config.style,
        center: [-96.0, 38.0],
        zoom: 3.5,
        pitch: 0,
        bearing: 0,
        projection: config.projection
    });

    setupBeyondSwipeMap(beforeMap, 'state');
    setupBeyondSwipeMap(afterMap, 'county');

    new mapboxgl.Compare(beforeMap, afterMap, '#comparison-container', {
        mousemove: false
    });

    beyondSwipeInitialized = true;
}

window.initializeBeyondSwipe = initializeBeyondSwipe;

// ============================================================
// BUILD STORY DOM
// ============================================================

var story = document.getElementById('story');
var features = document.createElement('div');
features.setAttribute('id', 'features');

var header = document.createElement('div');

if (config.title) {
    var titleText = document.createElement('h1');
    titleText.innerText = config.title;
    header.appendChild(titleText);
}

if (config.subtitle) {
    var subtitleText = document.createElement('h2');
    subtitleText.innerText = config.subtitle;
    header.appendChild(subtitleText);
}

if (config.byline) {
    var bylineText = document.createElement('p');
    bylineText.innerText = config.byline;
    header.appendChild(bylineText);
}

if (header.innerText.length > 0) {
    header.classList.add(config.theme);
    header.setAttribute('id', 'header');
    story.appendChild(header);
}

config.chapters.forEach(function (record, idx) {
    var container = document.createElement('div');
    var chapter = document.createElement('div');

    if (record.title) {
        var title = document.createElement('h3');
        title.innerText = record.title;
        chapter.appendChild(title);
    }

    if (record.image) {
        var image = new Image();
        image.src = record.image;
        chapter.appendChild(image);
    }

    if (record.description) {
        var storyPara = document.createElement('p');
        storyPara.innerHTML = record.description;
        chapter.appendChild(storyPara);
    }

    if (record.swipe) {
        var compareWrap = document.createElement('div');
        compareWrap.setAttribute('id', 'comparison-container');

        var beforeDiv = document.createElement('div');
        beforeDiv.setAttribute('id', 'before');
        beforeDiv.classList.add('compare-map');

        var afterDiv = document.createElement('div');
        afterDiv.setAttribute('id', 'after');
        afterDiv.classList.add('compare-map');

        compareWrap.appendChild(beforeDiv);
        compareWrap.appendChild(afterDiv);
        chapter.appendChild(compareWrap);
    }

    if (record.descriptionAfter) {
        var afterPara = document.createElement('p');
        afterPara.classList.add('description-after');
        afterPara.innerHTML = record.descriptionAfter;
        chapter.appendChild(afterPara);
    }

    container.setAttribute('id', record.id);
    container.classList.add('step');

    if (idx === 0) {
        container.classList.add('active');
    }

    chapter.classList.add(config.theme);
    container.appendChild(chapter);
    container.classList.add(alignments[record.alignment] || 'centered');

    if (record.hidden) {
        container.classList.add('hidden');
    }

    features.appendChild(container);
});

story.appendChild(features);

var footer = document.createElement('div');

if (config.footer) {
    var footerText = document.createElement('p');
    footerText.innerHTML = config.footer;
    footer.appendChild(footerText);
}

if (footer.innerText.length > 0) {
    footer.classList.add(config.theme);
    footer.setAttribute('id', 'footer');
    story.appendChild(footer);
}

// ============================================================
// FADE MAP IN AFTER COVER
// ============================================================

function checkMapVisibility() {
    if (window.scrollY > window.innerHeight * 0.3) {
        var mapEl = document.getElementById('map');
        if (mapEl) {
            mapEl.classList.add('visible');
        }
    }
}

window.addEventListener('scroll', checkMapVisibility);
checkMapVisibility();

// ============================================================
// INITIALIZE MAP
// ============================================================

mapboxgl.accessToken = config.accessToken;

var map = new mapboxgl.Map({
    container: 'map',
    style: config.style,
    center: config.chapters[0].location.center,
    zoom: config.chapters[0].location.zoom,
    bearing: config.chapters[0].location.bearing,
    pitch: config.chapters[0].location.pitch,
    interactive: false,
    projection: config.projection
});

if (config.inset) {
    map.addControl(
        new GlobeMinimap({ ...config.insetOptions }),
        config.insetPosition
    );
}

if (config.showMarkers) {
    var marker = new mapboxgl.Marker({ color: config.markerColor });
    marker.setLngLat(config.chapters[0].location.center).addTo(map);
}

// ============================================================
// SCROLLAMA
// ============================================================

var scroller = scrollama();

map.on('load', function () {
    hideAllThematicLayers();

    if (config.use3dTerrain) {
        map.addSource('mapbox-dem', {
            type: 'raster-dem',
            url: 'mapbox://mapbox.mapbox-terrain-dem-v1',
            tileSize: 512,
            maxzoom: 14
        });

        map.setTerrain({
            source: 'mapbox-dem',
            exaggeration: 1.5
        });

        map.addLayer({
            id: 'sky',
            type: 'sky',
            paint: {
                'sky-type': 'atmosphere',
                'sky-atmosphere-sun': [0.0, 0.0],
                'sky-atmosphere-sun-intensity': 15
            }
        });
    }

    scroller
        .setup({
            step: '.step',
            offset: 0.5,
            progress: true
        })

        .onStepEnter(function (response) {
            var current_chapter = config.chapters.findIndex(function (chap) {
                return chap.id === response.element.id;
            });

            if (current_chapter === -1) {
                console.warn('Chapter not found:', response.element.id);
                return;
            }

            var chapter = config.chapters[current_chapter];

            response.element.classList.add('active');

            if (chapter.location) {
                map[chapter.mapAnimation || 'flyTo'](chapter.location);
            }

            if (config.showMarkers && chapter.location) {
                marker.setLngLat(chapter.location.center);
            }

            if (chapter.onChapterEnter && chapter.onChapterEnter.length > 0) {
                chapter.onChapterEnter.forEach(setLayerOpacity);
            }

            if (chapter.callback && typeof window[chapter.callback] === 'function') {
                window[chapter.callback]();
            }

            if (chapter.rotateAnimation) {
                map.once('moveend', function () {
                    var rotateNumber = map.getBearing();
                    map.rotateTo(rotateNumber + 180, {
                        duration: 30000,
                        easing: function (t) {
                            return t;
                        }
                    });
                });
            }

            if (config.auto) {
                var next_chapter = (current_chapter + 1) % config.chapters.length;

                map.once('moveend', function () {
                    var nextStep = document.querySelectorAll(
                        '[data-scrollama-index="' + next_chapter.toString() + '"]'
                    )[0];

                    if (nextStep) {
                        nextStep.scrollIntoView();
                    }
                });
            }
        })

        .onStepExit(function (response) {
            var chapter = config.chapters.find(function (chap) {
                return chap.id === response.element.id;
            });

            response.element.classList.remove('active');

            if (chapter && chapter.onChapterExit && chapter.onChapterExit.length > 0) {
                chapter.onChapterExit.forEach(setLayerOpacity);
            }
        });

    if (config.auto) {
        var firstStep = document.querySelectorAll('[data-scrollama-index="0"]')[0];

        if (firstStep) {
            firstStep.scrollIntoView();
        }
    }
});