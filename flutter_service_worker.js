'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"main.dart.js": "5d52a3ae526bf3f9dac316753a44e18c",
"manifest.json": "08f6e55fe536eef077c455589ddc4a46",
"version.json": "8bae31c255ba2d299b4b3089da13d920",
"flutter.js": "eb2682e33f25cd8f1fc59011497c35f8",
"index.html": "21267d79d3cf3468a6a0e66650c208fa",
"/": "21267d79d3cf3468a6a0e66650c208fa",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"assets/loading.gif": "1d767c87e6aca53e0077450e8e1c3bd5",
"assets/AssetManifest.json": "993f3cea3c6e0769bfabdcf1309a681f",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/assets/icons/task.svg": "b35c4bfe20dfb240b3ce27805b9710f1",
"assets/assets/icons/logo.svg": "9e1b562054c80b2f14a60eadeb92d9ff",
"assets/assets/icons/folder.svg": "40a82e74e930ac73aa6ccb85d8c5a29c",
"assets/assets/icons/google_drive.svg": "9a3005a58d47a11bfeffc11ddd3567c1",
"assets/assets/icons/menu_store.svg": "cde36f502257ea692ac32ff5966ec392",
"assets/assets/icons/Search.svg": "396d519c18918ed763d741f4ba90243a",
"assets/assets/icons/menu_profile.svg": "5aae32f18b4121d7294cb61efaccd7e6",
"assets/assets/icons/reward.svg": "cc79c186941c770caa5b91d6e4fd2d54",
"assets/assets/icons/media_file.svg": "2ac15c968f8a8cea571a0f3e9f238a66",
"assets/assets/icons/Documents.svg": "51896b51d35e28711cf4bd218bde185d",
"assets/assets/icons/pdf_file.svg": "ca854643eeee7bedba7a1d550e2ba94f",
"assets/assets/icons/menu_notification.svg": "460268d6e4bdeab56538d7020cc4b326",
"assets/assets/icons/menu_task.svg": "299d2ab20845cf8f638f9bfb0128ff86",
"assets/assets/icons/drop_box.svg": "3295157e194179743d6093de9f1ff254",
"assets/assets/icons/unknown.svg": "b2f3cdc507252d75dea079282f14614f",
"assets/assets/icons/menu_tran.svg": "a58af7c7f1cef1c83ff9ab48d6478d59",
"assets/assets/icons/Figma_file.svg": "0ae328b79325e7615054aed3147c81f9",
"assets/assets/icons/sound_file.svg": "fe212d5edfddd0786319edf50601ec73",
"assets/assets/icons/media.svg": "059dfe46bd2d92e30bf361c2f7055c3b",
"assets/assets/icons/menu_dashbord.svg": "8d8dedc1257b6bbfb2ae44968aced08f",
"assets/assets/icons/excle_file.svg": "dc91b258ecf87f5731fb2ab9ae15a3ec",
"assets/assets/icons/one_drive.svg": "aa908c0a29eb795606799385cdfc8592",
"assets/assets/icons/menu_setting.svg": "d0e24d5d0956729e0e2ab09cb4327e32",
"assets/assets/icons/doc_file.svg": "552a02a5a3dbaee682de14573f0ca9f3",
"assets/assets/icons/menu_doc.svg": "09673c2879de2db9646345011dbaa7bb",
"assets/assets/icons/xd_file.svg": "38913b108e39bcd55988050d2d80194c",
"assets/assets/images/profile_pic.png": "5f56c3070f1c066ae15ecad12fb44f54",
"assets/assets/images/logo.png": "25036c696391d9e53b4b5aeeaea85e49",
"assets/NOTICES": "c7ad57c4afca511b294929add341f8a6",
"assets/shaders/ink_sparkle.frag": "23537f743ddf5e6ff1269be337892bc7",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"cors.json": "1062ca6df922ed1df5381cd17b287e06",
"favicon.png": "5dcef449791fa27946b3d35ad8803796"
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
