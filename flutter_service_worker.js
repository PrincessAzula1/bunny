'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "e60eb3563b3b73083d388e0daa430397",
"index.html": "662f3780e7f4ce9b927920959511c64e",
"/": "662f3780e7f4ce9b927920959511c64e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "b6c4224cf95572476840a22ac16d08e5",
"assets/assets/assets/bunnyhop/web_1.2.1/index.html": "be97fba4de39f5e0b1c176b5c224400a",
"assets/assets/assets/bunnyhop/web_1.2.1/Build/web_1.2.1.asm.code.unityweb": "b9e2225f932aa47bdd509b5d7a9a1080",
"assets/assets/assets/bunnyhop/web_1.2.1/Build/web_1.2.1.asm.memory.unityweb": "33ff52a3fa41bd6e3ae8c2b82b0cdca0",
"assets/assets/assets/bunnyhop/web_1.2.1/Build/web_1.2.1.json": "4806ddac22567443bae070821c1004ac",
"assets/assets/assets/bunnyhop/web_1.2.1/Build/web_1.2.1.data.unityweb": "40b05f4ec82077057bb05a28d09194bb",
"assets/assets/assets/bunnyhop/web_1.2.1/Build/UnityLoader.js": "9b952195ab79ef94f0feaae8cbb8d8ac",
"assets/assets/assets/bunnyhop/web_1.2.1/Build/web_1.2.1.asm.framework.unityweb": "820acdd08f2334a2632ec44f456e42ce",
"assets/assets/assets/bunnyhop/web_1.2.1/TemplateData/progressFull.Dark.png": "c74f81d50322b06afa5f20a1447a17ba",
"assets/assets/assets/bunnyhop/web_1.2.1/TemplateData/progressLogo.Light.png": "e608e32fb2102e953b6cae6f97f38286",
"assets/assets/assets/bunnyhop/web_1.2.1/TemplateData/progressFull.Light.png": "d030ba7511bc275365f856d2af200e58",
"assets/assets/assets/bunnyhop/web_1.2.1/TemplateData/style.css": "f174b271049153b3e9c4e483098e25d4",
"assets/assets/assets/bunnyhop/web_1.2.1/TemplateData/progressLogo.Dark.png": "cc0d7c1db16b413eb67aed0f10c3e99d",
"assets/assets/assets/bunnyhop/web_1.2.1/TemplateData/webgl-logo.png": "8c9889fd3f9272b942d4868a9c1b094c",
"assets/assets/assets/bunnyhop/web_1.2.1/TemplateData/progressEmpty.Light.png": "28df3e3bc879a2cffaaf78e371980f33",
"assets/assets/assets/bunnyhop/web_1.2.1/TemplateData/progressEmpty.Dark.png": "59cf8c9349b0be3828ea6ab0b7b7d126",
"assets/assets/assets/bunnyhop/web_1.2.1/TemplateData/favicon.ico": "57b5a31d2566cf227c47819eb3e5acfa",
"assets/assets/assets/bunnyhop/web_1.2.1/TemplateData/UnityProgress.js": "8560a078de48bb4ede068cbdd48a4938",
"assets/assets/assets/bunnyhop/web_1.2.1/TemplateData/fullscreen.png": "f698ed7e8838ae7fef68b1423b6a3bc8",
"assets/assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/NOTICES": "be42f75a137da2bfebb04cbce0d0199d",
"assets/packages/flutter_inappwebview_web/assets/web/web_support.js": "509ae636cfdd93e49b5a6eaf0f06d79f",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.css": "5a8d0222407e388155d7d1395a75d5b9",
"assets/packages/flutter_inappwebview/assets/t_rex_runner/t-rex.html": "16911fcc170c8af1c5457940bd0bf055",
"assets/FontManifest.json": "df7222275ca2b279f96e579b7d190e69",
"assets/AssetManifest.bin": "5cb4e0ff655258e646feb35b8c20f7ae",
"assets/AssetManifest.json": "08df887ba175d2f4be8955b2ce4c705c",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "6c498495745f302839b7a4d69873e241",
"version.json": "28bfa0c2351f3fd746c58e9e0342ca97",
"main.dart.js": "f57d724f1ce6ea13f52eb1dabf69500e"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
