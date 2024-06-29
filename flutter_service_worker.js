'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"icons/Icon-512.png": "558ae9d270fe553f1fc2c7e58c9ede02",
"icons/Icon-maskable-192.png": "ae3b371c6fa73d8c68978ff29544694c",
"icons/Icon-192.png": "ae3b371c6fa73d8c68978ff29544694c",
"icons/Icon-maskable-512.png": "558ae9d270fe553f1fc2c7e58c9ede02",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"version.json": "03fbd2141c0d74860ee35d4369e8ce94",
"favicon.png": "c29b78f35a55f10256ffca81b6537ff1",
"main.dart.js": "cc465aef85399ec0b18489065e7dc8c5",
"assets/NOTICES": "03bf5c01d78640a0fe071f9b0d0f5429",
"assets/AssetManifest.bin": "c58c5dd60202c29e7ef6c09b0e71fb6e",
"assets/assets/images/TheRulesWallpaper.png": "51ea3c0fce3010ff170fd60d90d7c0de",
"assets/assets/images/rules/9.png": "9fb567445da5337b412a1f865c6fc495",
"assets/assets/images/rules/20.png": "0423522f8517ca3858cd6c7abf25286f",
"assets/assets/images/rules/8.png": "782ea31347b44d80f39fdfe783c87efa",
"assets/assets/images/rules/5.png": "341db8e28aec94feaf7235c8bde7c27a",
"assets/assets/images/rules/15.png": "435b2bdc947ba32aeacbfdeec42e5811",
"assets/assets/images/rules/16.png": "70dc029f7747a20801b5f8c90005d30e",
"assets/assets/images/rules/29.png": "b35b64a2e2324374ebab5a8451ca544b",
"assets/assets/images/rules/24.png": "17006214579af02b5df8e99c3c5e00ac",
"assets/assets/images/rules/18.png": "eebd9af923835b0ab311bad620fcb7ab",
"assets/assets/images/rules/13.png": "e8a4741903e9f508f1c28db985cf50af",
"assets/assets/images/rules/23.png": "90edf37ad3ce1a155dc89d068dc6891c",
"assets/assets/images/rules/1.png": "19c545f508b1824efd48d05083853079",
"assets/assets/images/rules/19.png": "6d82563399e71affc93165e36d267dc5",
"assets/assets/images/rules/21.png": "4adba4a13e05b397a45d4ddaba075ae8",
"assets/assets/images/rules/17.png": "f258d566282ab1171e39da74b779f38e",
"assets/assets/images/rules/27.png": "07ad5f7bbcf37b95d4d1220af2e93b09",
"assets/assets/images/rules/3.png": "29d679162f92cfccc0342ee4a9611af1",
"assets/assets/images/rules/7.png": "5b435e45af7decfd73f14be18191f21d",
"assets/assets/images/rules/26.png": "f72bdd35b586bc5f6988af6e174f472f",
"assets/assets/images/rules/22.png": "c16a3dbd5e5db7605cc6c6ee35971403",
"assets/assets/images/rules/10.png": "414be6661b606fcb16584b8871701c95",
"assets/assets/images/rules/28.png": "fcb74e890a5a0776149e4ac31dd0cc52",
"assets/assets/images/rules/11.png": "31dd979c8f7ba39670b4e2c67b4fe2c8",
"assets/assets/images/rules/14.png": "df04d9cba423bd7c792a146f89299965",
"assets/assets/images/rules/25.png": "947b4073337e62465df98fa08987660a",
"assets/assets/images/rules/4.png": "9e4bf8a416100009ebf3594f576e2b2c",
"assets/assets/images/rules/12.png": "68c1a5d0884fbb58ddf697400c6a4ad1",
"assets/assets/images/rules/6.png": "a60d415f09b12950ea02d000ff7f015a",
"assets/assets/images/rules/2.png": "8c315b67737e35009876b8e25fbdea4a",
"assets/assets/images/shoot.png": "3ad0b7624f889a41b6231ce552bbae81",
"assets/assets/images/icon.png": "0b593a580c38d2af2edfbc53cd69a0b6",
"assets/assets/audio/shot.wav": "06cf8f9ea71c38ac4accc5c3a91dcb51",
"assets/assets/audio/shotPop.wav": "654575c55da189e263cb65f418e597eb",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/AssetManifest.bin.json": "c9f7618477151ba3644a832b8cd25938",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "37f0e5b6c67199246bd3be59fe628775",
"assets/AssetManifest.json": "770d29a1c72d010d05b813a5e79800fb",
"index.html": "d437251a149306b7f1edd7d7755dfb26",
"/": "d437251a149306b7f1edd7d7755dfb26",
"manifest.json": "abaad18af358bac2b29a5c96fab587db"};
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
