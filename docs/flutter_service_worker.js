'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "47e1108489ea4563dbf8303232c782cd",
"assets/AssetManifest.json": "3fad99d79eee62a67128997726e3d680",
"assets/assets/fonts/NotoSansJP-VariableFont_wght.ttf": "a66bb5eb75c2b6b67e3e22f17e98b1e8",
"assets/assets/img/baseball_direction.mp4": "75e8ac6181cf2cb42940fec1f25a23e4",
"assets/assets/img/baseball_rule.png": "90922a7c5a384194885399fd4f02ff76",
"assets/assets/img/baseball_score.png": "55ebdb46d9901de6fc0513fe7427cb35",
"assets/assets/img/baseball_share.mp4": "c62774d8803b9ab449cbf623108d7bf7",
"assets/assets/img/baseball_share1.png": "8857493eefa15d6c43f1e119c7570622",
"assets/assets/img/baseball_share2.png": "2ae591df32d80e3e8690b18789b6593e",
"assets/assets/img/memo_directory.mp4": "61539eb283f61f2a578e4949f95f05a5",
"assets/assets/img/memo_edit.mp4": "3301223eb740ae3251ba5d5f536c73d5",
"assets/assets/img/memo_home.png": "0eca9023bad6ad496f57d1468bf0063b",
"assets/assets/img/memo_new.png": "5c300bec061bab76066b2bf7ab3d468d",
"assets/assets/img/memo_search.png": "e5cc64cda4c288c8c6bf69bdd59f7f6c",
"assets/assets/img/memo_select.png": "fd767dccf69a45d40a64a9d18fbbc0eb",
"assets/assets/img/oko_calendar.png": "6fa4481172cb0f21b0a03929e0e772d0",
"assets/assets/img/oko_detail.mp4": "4e7de6b23a32dde9e9264efb3231b073",
"assets/assets/img/oko_detail.png": "602a76f75e394d1ced946a82a90da8f6",
"assets/assets/img/oko_home.png": "44975f078c79646279c5ee73076e118e",
"assets/assets/img/oko_input.png": "8ce22b7068d2f8299297beb4ad8d48b5",
"assets/assets/img/oko_keyboard.mp4": "7b3ee0670e863ac83d41b9d94972825e",
"assets/assets/img/oko_keyboard.png": "b804446c1bb6ddc1cae62a4e1c7d16a0",
"assets/assets/img/oko_output.png": "1808dd83c5a83002938a112d71de306d",
"assets/assets/img/sensor_graph.mp4": "0692cae828e132a0d4784e3a39922e07",
"assets/assets/img/sensor_home.png": "15e6c37de37e4fda5aa2588b99910b76",
"assets/assets/img/sensor_save.png": "267081d1b45dd10bffd0f0833ec6f4fe",
"assets/FontManifest.json": "f98997d90333f0eb39173ccd5549d8dc",
"assets/fonts/MaterialIcons-Regular.otf": "d7f3ec5f972367f03cd11238cf39f341",
"assets/NOTICES": "866481cb7132a95d576e30c26bf94cb4",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "57d849d738900cfd590e9adc7e208250",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "69c7b8c0233e98b7cd28edad715efd1c",
"/": "69c7b8c0233e98b7cd28edad715efd1c",
"main.dart.js": "bae5843afcd035214ca26ce2d151bd1a",
"manifest.json": "4137147246a11ba2148318bc696c4202",
"version.json": "7cd6a41407e3ce7ca7e1a9f156efa75f"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
