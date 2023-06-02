'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "3fad99d79eee62a67128997726e3d680",
"assets/assets/fonts/NotoSansJP-VariableFont_wght.ttf": "a66bb5eb75c2b6b67e3e22f17e98b1e8",
"assets/assets/img/baseball_direction.mp4": "75e8ac6181cf2cb42940fec1f25a23e4",
"assets/assets/img/baseball_rule.png": "f712f481115b638122da42eedaa6ba81",
"assets/assets/img/baseball_score.png": "e615036753f5e6332a9385fad3e0d3f0",
"assets/assets/img/baseball_share.mp4": "c62774d8803b9ab449cbf623108d7bf7",
"assets/assets/img/baseball_share1.png": "ae0f76fd24b920c9c1e3eaa7c59b1925",
"assets/assets/img/baseball_share2.png": "0dd97d2a5123f5293bb789ff1b14bd26",
"assets/assets/img/memo_directory.mp4": "61539eb283f61f2a578e4949f95f05a5",
"assets/assets/img/memo_edit.mp4": "3301223eb740ae3251ba5d5f536c73d5",
"assets/assets/img/memo_home.png": "7858a20119db72bec4d90093ed8e7821",
"assets/assets/img/memo_new.png": "af8063f440697ad5b80b51d86a7d6384",
"assets/assets/img/memo_search.png": "1643401565c8914a78241af929c3951c",
"assets/assets/img/memo_select.png": "ed9f1f0893f4c0885f643a483debbf6e",
"assets/assets/img/oko_calendar.png": "2265794f8273597ab97903822af1d47a",
"assets/assets/img/oko_detail.mp4": "4e7de6b23a32dde9e9264efb3231b073",
"assets/assets/img/oko_detail.png": "60479887c5a1aa5ecb190e5db4b87d42",
"assets/assets/img/oko_home.png": "0a81cc490879f87f5548948c21fb15bc",
"assets/assets/img/oko_input.png": "46bde458b30e4ca54feab2c862233752",
"assets/assets/img/oko_keyboard.mp4": "7b3ee0670e863ac83d41b9d94972825e",
"assets/assets/img/oko_keyboard.png": "4420cf2fbc68271144f7fef7109959b9",
"assets/assets/img/oko_output.png": "cc383f82db0dc1a8eac7b48e43a387ea",
"assets/assets/img/sensor_graph.mp4": "0692cae828e132a0d4784e3a39922e07",
"assets/assets/img/sensor_home.png": "4e6ebc1fa86ac4259c41815a9566549e",
"assets/assets/img/sensor_save.png": "d31e56e27718af7076b9aafd86795a09",
"assets/FontManifest.json": "f98997d90333f0eb39173ccd5549d8dc",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/NOTICES": "7a2af0a9e1f32d36fe9318f17bd7f5bb",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/shaders/ink_sparkle.frag": "ae6c1fd6f6ee6ee952cde379095a8f3f",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "caf633f5ce876f63764ce2d126285b09",
"/": "caf633f5ce876f63764ce2d126285b09",
"main.dart.js": "93067f0cc5cb9fe6048f4e6e38b5f85a",
"manifest.json": "4137147246a11ba2148318bc696c4202",
"version.json": "7cd6a41407e3ce7ca7e1a9f156efa75f"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
