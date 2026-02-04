'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {".git/COMMIT_EDITMSG": "aa1066d729fce2bb8798336cc1007bae",
".git/config": "514e55b43764b759c2afbfa1ee342379",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
".git/HEAD": "cf7dd3ce51958c5f13fece957cc417fb",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "5029bfab85b1c39281aa9697379ea444",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/sendemail-validate.sample": "4d67df3a8d5c98cb8565c07e42be0b04",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/index": "7d0bb6b1e3904ac3329cc1e164008557",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/logs/HEAD": "56f148e1598a2ce24f849c80f2cde910",
".git/logs/refs/heads/main": "27eb6b98a99b0a2ac89997a317c680aa",
".git/logs/refs/remotes/origin/main": "13eb63a87535e00abcdf1978330acee5",
".git/objects/02/d379985de129bf1118143f9405993014d84a88": "49a3fd720a605cdff3cce75df2a0f8a8",
".git/objects/05/0d42ed7e6f82be23726005a15346349f623001": "c4b59e238796e2e23b13f78f0bf02bd9",
".git/objects/05/a9058f513cce5faf1704e06e3c150688b0a01f": "e8d02f60cf87abd4c1de4b153dd696dc",
".git/objects/11/702b2aba339bcc91aca9cf5f53b1e08d9bd33e": "e8a53e3a0c9be4c9dc0766f86d9be316",
".git/objects/13/70a32a1d31bd9d9a5e43af0683f03e95efaaee": "6b645de606dfd68e312b3ba252d02cac",
".git/objects/14/8e67049adb1a4f73420974c2e9adc32aa3a8f6": "cf42b3ad8e15dd77fe1cbeab9dade935",
".git/objects/16/3cfc55a682a0e981ed7e46c1540006ca330a7a": "acfaf530c1a01d70f0a416752131eec5",
".git/objects/18/c7cbc023fa4488f70b8f9e335743412765d18d": "ee96dc69811fb18da5a4a9937faf7996",
".git/objects/18/e2121c63a2f2bfa65a3e2b4677c7f52fe7cf90": "1a78b5a0230848728d2397af99f90f6a",
".git/objects/1b/f4535f4bf772f932df438541062ad53d60307d": "891b107f09f072def7654d7426818c9d",
".git/objects/1f/45b5bcaac804825befd9117111e700e8fcb782": "7a9d811fd6ce7c7455466153561fb479",
".git/objects/25/8b3eee70f98b2ece403869d9fe41ff8d32b7e1": "05e38b9242f2ece7b4208c191bc7b258",
".git/objects/26/b0e581be8f5d8a98cbcdec4b2c643598cef02a": "1a2e6bec086890083e42f880af5a0209",
".git/objects/27/a297abdda86a3cbc2d04f0036af1e62ae008c7": "51d74211c02d96c368704b99da4022d5",
".git/objects/2a/335bf0c88b44f766400acb7f301ce0fa148d4f": "d4a6579177d9327acecfedf446cac84a",
".git/objects/35/3b84521f5ff0f93537530cf8f10329506f09e3": "6568785b7ddc2f2f2941df562fb3aeec",
".git/objects/37/53fcc54ead5b404fdfe094238f36a253176175": "28199d1ff9a9b87d7bf0d28dc0c1c9b9",
".git/objects/38/7d01d93fe8371ff4d32a5c757f1b6554f89cf8": "8d449ecac0909d6678acc1c106ae4e53",
".git/objects/46/0aefba6c38524d2109cb46ee971e25ccab5697": "29ca937f9be19ee408a28b037800da7b",
".git/objects/4a/901b2661a2fe8b2709df83f39ab251e3ecd0f1": "e15989cc02f5fcfef2901f7a8d290465",
".git/objects/55/bd7d073b83c480d27ab93bbb9ad7cf5f05ffc4": "6f69ee9b346b9c7365ba2dd68788b362",
".git/objects/63/6931bcaa0ab4c3ff63c22d54be8c048340177b": "8cc9c6021cbd64a862e0e47758619fb7",
".git/objects/6b/6114114f4e89a1f2d0e911ff090e541af1260c": "8d69de88f018d1ea3e9f80298fb86856",
".git/objects/6d/5f0fdc7ccbdf7d01fc607eb818f81a0165627e": "2b2403c52cb620129b4bbc62f12abd57",
".git/objects/72/f5e26c82275168fac79ec096f62aa62db5178b": "d012bdb2cd840081dd14bae49712b06f",
".git/objects/73/7f149c855c9ccd61a5e24ce64783eaf921c709": "1d813736c393435d016c1bfc46a6a3a6",
".git/objects/7c/09d499f23e8c9cfadbd067e09e62b423cd8b4a": "4f5d6ea007527788d254cd3ceeb9b8a8",
".git/objects/7c/a81b062ea0e84a9d3125c39516b0cbcbce35d7": "0bce9b17d6b0d57dc090edc22f6f26b3",
".git/objects/7c/e0b648e92a18afc18b97c45a324fcbc3a86153": "9fc809de4f9b783f637973b4a64f29f6",
".git/objects/7d/6e12f76ec0d7e373bd8a531d67729f65f5f3ac": "d8f0a0c13040cc27409d0f34eb167949",
".git/objects/7e/3fdd79a27862560d3f6799e926bae20439739b": "56152bcdcbf5491361c32d28f0653cfa",
".git/objects/80/f92ee8baaab5c262743d5decdddf7bad49f48b": "dff726f3ff033f2870329d56572bf457",
".git/objects/83/bc9562d8007e040a4a5c629b616df3a062a796": "714f0562221b66c1198bb897e7f7a798",
".git/objects/85/6a39233232244ba2497a38bdd13b2f0db12c82": "eef4643a9711cce94f555ae60fecd388",
".git/objects/86/449e6f1dbdeb8ded3280a6c364494e8ec61cbc": "e2e00d8515cb5e24631cf4b16b6bb8c3",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/8b/8b0680b7d85bb1f3a34fa21530ed7552c84a43": "13b579ba74b5e6d7f802f99c2406938c",
".git/objects/8c/59773bee8314a8ffb4431593d0fb49f52e34c6": "2eb993d30677573ffd0e58484cc6a514",
".git/objects/90/90da7434a7a3a80778e6c32066b6aaf600efcf": "8e3be7aedac11d429ef89515dbe759b0",
".git/objects/97/8a4d89de1d1e20408919ec3f54f9bba275d66f": "dbaa9c6711faa6123b43ef2573bc1457",
".git/objects/9d/910f9362b13351649db3a7a3eec4c6067f596f": "4830ee9364d38d03867d1ed0097c5c6f",
".git/objects/a6/aa8df445c6252285043ae99062dd1e83938bb2": "3f7d43688edc5e984b8be357fe65b2fb",
".git/objects/af/31ef4d98c006d9ada76f407195ad20570cc8e1": "a9d4d1360c77d67b4bb052383a3bdfd9",
".git/objects/b1/5ad935a6a00c2433c7fadad53602c1d0324365": "8f96f41fe1f2721c9e97d75caa004410",
".git/objects/b1/afd5429fbe3cc7a88b89f454006eb7b018849a": "e4c2e016668208ba57348269fcb46d7b",
".git/objects/b3/df103772da34153c42aea1b261f4d7fb19b665": "0fe9583041e6b2dd0ee68f6c76a97a95",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/ba/5317db6066f0f7cfe94eec93dc654820ce848c": "9b7629bf1180798cf66df4142eb19a4e",
".git/objects/c3/e81f822689e3b8c05262eec63e4769e0dea74c": "8c6432dca0ea3fdc0d215dcc05d00a66",
".git/objects/c6/06caa16378473a4bb9e8807b6f43e69acf30ad": "ed187e1b169337b5fbbce611844136c6",
".git/objects/c8/787a95d9a4b621e4cac2370de3e80becc1a5ff": "ef98ae57c69280f4f7a25530f7426feb",
".git/objects/ca/8482c88c44dcfdf9ead9d3726df9574ac9775c": "81cbf504c8b90bc81a07b514349a4ac5",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/d5/5394e8d97fb21cc777508844b318f4ef528a96": "ffe43be7c4f90cf9927b99a41d5a2681",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/db/bb195c782faa34f39af15233505e90dcbd6c6b": "892e18cc33cabd957f9af4a46713d254",
".git/objects/dd/7cb560585a62d854dfd71ad1a73011d4b594f9": "5a3fe368ea197d3011e7123d7127540b",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/ec/361605e9e785c47c62dd46a67f9c352731226b": "d1eafaea77b21719d7c450bcf18236d6",
".git/objects/ee/f5806ec9129c8191635d4878c6662432af8543": "9e11c15f7656e0e46f3f9f168877bd54",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f3/c345f51f616ddbfc46eef98a476b1c263f13a5": "7ac137907a9f7fb7b0ef68f7c1758aa1",
".git/objects/f4/40730ca4b8d0dd35ed91768cbb5611f03bbb5b": "265622a50f462e2cfe548d2a4c7a9590",
".git/objects/f4/82fbd7ae393bec3ffee4c63e2f65f271f1b66a": "7403c9739bd2ce625ecf827fa97903a0",
".git/objects/f6/b980b3fdbc63e92a6dfc44a490798e57d4e55e": "5b5adb0d567b228923249424c766d00e",
".git/objects/fb/9a804aa77631ee0178032dfd97342c5628a0a1": "5e95a654e7117b5988ecfabd4fc621f2",
".git/objects/fd/82f05dad9ebc453da15235ed07e74e700dd259": "15595cfb48676c3aa38023eb802c5c95",
".git/refs/heads/main": "45934b8e87833f4af14a994a8ab3f3db",
".git/refs/remotes/origin/main": "45934b8e87833f4af14a994a8ab3f3db",
".vs/slnx.sqlite": "ddb1b20c57ac7fe5b7e51531c570fe1c",
".vs/VSWorkspaceState.json": "c5d8964c7f5288c0be2b2463a8eccc7a",
".vs/web/v17/DocumentLayout.json": "048969f354f2ab7ea8bb4287029d0f7d",
"assets/AssetManifest.bin": "8a45f19e9426fb614f6b5927911593d3",
"assets/AssetManifest.bin.json": "72f1a2be6a374d370d6925bf3f58dc6c",
"assets/AssetManifest.json": "d35e7fea241fe392a46eff15f009872e",
"assets/assets/audio/flash.mp3": "e76e41e0148f30b019e197d46f668f2d",
"assets/assets/audio/music.mp3": "edbe1d0348cfa8ac8f7b285d51898534",
"assets/assets/audio/speaking.mp3": "631ef28d2c0ef2aa999fd65e75ab0e0b",
"assets/assets/fonts/FOT-RodinBokutoh%2520Pro%2520EB.otf": "2c7476a198c2f655078f579b785c6b38",
"assets/assets/images/Bubble.png": "03ac895ec3507dd2049341876791f747",
"assets/assets/images/bunny.webp": "f01c94f4b9a4edf48678f65d9f007dd1",
"assets/assets/images/cloudy.png": "2c120d446fbc56b701ac8eda563de18e",
"assets/assets/images/icon.png": "55b2d11a73c29a5ed7b947424b996ffc",
"assets/assets/images/rain.png": "87a5d91202809f7fae7bc7d65b0353d0",
"assets/assets/images/return.png": "e468eeca6b1e7f6568a431605ec1c68c",
"assets/assets/images/sunny%2520with%2520clouds.png": "b28090c5c76d8a0d9c7719153acbc3ac",
"assets/assets/images/sunny%2520with%2520rain.png": "43817ac478226bc2a145c5023a0d0033",
"assets/assets/images/sunny.png": "648551de79b7d654d60df9ad920c6461",
"assets/assets/images/thunderstorm.png": "3ea142a3c84f2f81151fdf216fc54c73",
"assets/assets/videos/start_menu.mp4": "71f7447539ae16a7bcdf381fecdd7007",
"assets/FontManifest.json": "2495b6f92af3ea6b5e35b37653f68b7e",
"assets/fonts/MaterialIcons-Regular.otf": "0db35ae7a415370b89e807027510caf0",
"assets/NOTICES": "e35077295f59674ab6f7ae1b38ab25f7",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"flutter_bootstrap.js": "3450870fe7bba8a44f1822efecbc4a61",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "2fcedd5c9919f4faa0872925ae68f2d0",
"/": "2fcedd5c9919f4faa0872925ae68f2d0",
"main.dart.js": "9aeb2cf3ed9a6682cc394f09442c7eb1",
"manifest.json": "f3c30c9c3b1bf2df121d4ec31ce900e7",
"version.json": "28bfa0c2351f3fd746c58e9e0342ca97"};
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
