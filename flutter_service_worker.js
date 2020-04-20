'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "dcg_favico/android-chrome-192x192.png": "9ff0e29529b9b5e40c1edf3917a03a07",
"dcg_favico/favicon-16x16.png": "2e4575c80cbd7785b8ea0cb0ea62e13d",
"dcg_favico/favicon.ico": "4981fe5792ee0cdf4b6d8b80f8162d30",
"dcg_favico/site.webmanifest": "053100cb84a50d2ae7f5492f7dd7f25e",
"dcg_favico/apple-touch-icon.png": "5751f303da9910285f36135aaa530567",
"dcg_favico/android-chrome-512x512.png": "79c471b764906aa487987356e78bca0b",
"dcg_favico/favicon-32x32.png": "d3684469df4020863a5172be32054218",
"index.html": "c6fd45d545b51e4e96dc985e93b2058e",
"/": "c6fd45d545b51e4e96dc985e93b2058e",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"assets/packages/material_design_icons_flutter/lib/fonts/materialdesignicons-webfont.ttf": "e7dec9c5e1bd830c084f2d2fb94fa1e7",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/FontManifest.json": "0621fb7723859a382fc19210904f6578",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/AssetManifest.json": "de4a40444183eff507a5982f7a6bd386",
"assets/LICENSE": "bdfb6abbb7a06346419ad7a56ac6ae5b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "957cafb89abbc8a978fb53a74ade39fd",
"manifest.json": "c606ca94339d82afab2e3b99dbde6f36"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request);
      })
  );
});
