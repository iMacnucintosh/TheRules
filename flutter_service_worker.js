'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "flutter.js": "a85fcf6324d3c4d3ae3be1ae4931e9c5",
"main.dart.js": "09f3c074f051fd3d7dbf30a8b1fb5a28",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"version.json": "03fbd2141c0d74860ee35d4369e8ce94",
"manifest.json": "75979d9ae16f5757c03e5f913636d63a",
"assets/AssetManifest.json": "b587f6e3a82d920900a8398a94700bcd",
"assets/assets/images/rules/Relojito.png": "c30107400f13e0cf3335496d7e54c179",
"assets/assets/images/rules/Valkiria.png": "018bab68b62a937e4a18f826371a2cae",
"assets/assets/images/rules/Palabra%2520encadenada.png": "1b64aaaf6ee43842b0b50425f8934902",
"assets/assets/images/rules/Ropajes%2520de%2520color.png": "173a76617d8f2415e98191a2adab63f3",
"assets/assets/images/rules/Caballo%2520loco.png": "40037643b667f774a016fbe286bd9170",
"assets/assets/images/rules/Ruleta%2520rusa.png": "ace6deb280baabb9b69fe9d34869fc9c",
"assets/assets/images/rules/Rey%2520rule.png": "857e539a8174b4c2daffdca9b729253d",
"assets/assets/images/rules/Portada.png": "6ba8566074c2d7773d5ebf0cca7a4159",
"assets/assets/images/rules/Beso.png": "c660a8820c60d8b77ecc0d6219137945",
"assets/assets/images/rules/Isla%2520desierta.png": "414c5da64338e079e1ca1af48881c041",
"assets/assets/images/rules/Mujeres%2520borrachas.png": "e751bb1baa87a883575ba8ef23dd71d6",
"assets/assets/images/rules/Mano.png": "d3a53f149d7b57b3ad570f9d7a7260c9",
"assets/assets/images/rules/El%252010.png": "fd50fcb29fbc7834173a13d4741acc5c",
"assets/assets/images/rules/Buenos%2520d%25C3%25ADas%2520Manolo.png": "b671201e6ed99c3b63d081d19a06c714",
"assets/assets/images/rules/Las%2520palmas.png": "3d69f1fd3c9610cd15d973db85464129",
"assets/assets/images/rules/Palabra%2520prohibida.png": "cb8230765e2bee8e4213e49a2b081e7c",
"assets/assets/images/rules/Follar,%2520matar%2520o%2520casar.png": "0976ec70339bd07889bde2a48d7dc3f1",
"assets/assets/images/rules/Verdadero%2520o%2520falso.png": "70a23f43b0aba2d7a89367590950e28a",
"assets/assets/images/rules/Medusa.png": "b0ccf7d4061f32b67023cf5e58ba550b",
"assets/assets/images/rules/Chupito.png": "f2d40b3a3bd662f31a622d394f87586c",
"assets/assets/images/rules/Yo%2520nunca.png": "6b716d543b7a7861a5a200e6ff45c744",
"assets/assets/images/rules/Adictos%2520a%2520la%2520bebida.png": "59e166f1dd6107c6deebb44bef85b7a2",
"assets/assets/images/rules/Historia%2520enlazada.png": "630c0ecabd3ebda68003a8bd865b2c13",
"assets/assets/images/rules/Prueba%2520o%252010%2520tragos.png": "3ceebc272fd10aafed745942dff1920b",
"assets/assets/images/rules/Piedra%2520papel%2520o%2520tijera.png": "7f6385fe14335d0ceb70ae12b04ee151",
"assets/assets/images/rules/T%25C3%25ADo%2520maragato.png": "faf0defb1fd07d88233f059577c93221",
"assets/assets/images/rules/Barquito%2520Peruano%2520.png": "9b3c40bb9d661bbee3a0ea8c7bdcc1e4",
"assets/assets/images/rules/Virgen%2520del%2520papo.png": "51b588895b98dafde63911196cd713f6",
"assets/assets/images/rules/Pim%2520Pam%2520Pum.png": "84ef45c7a3a47ed030066a49b300ce9f",
"assets/assets/images/rules/Vocal.png": "e37a36cda985246e383d82edc75faa09",
"assets/assets/images/rules/A%2520cantar.png": "656822a87517f18ed8be317751fdb7c0",
"assets/assets/images/rules/PortadaPortrait.png": "51ea3c0fce3010ff170fd60d90d7c0de",
"assets/assets/images/rules/Lim%25C3%25B3n.png": "b12e28b6ac5d10b591dc6b2577570b67",
"assets/assets/images/rules/Hombres%2520borrachos.png": "7511bab0ffaff5ee7eddc0cf20735045",
"assets/assets/images/rules/Chirla.png": "41a5fff4656b55833e7a0aaa0b34bef4",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/NOTICES": "2b0871f30011ef722802082c88b5eb02",
"index.html": "627d0c7bd5dfc19116a5f8c30229f02c",
"/": "627d0c7bd5dfc19116a5f8c30229f02c",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c"
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
