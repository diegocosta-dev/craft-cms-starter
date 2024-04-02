<?php

use craft\helpers\App;

return [
  'useDevServer' => App::env('CRAFT_ENVIRONMENT') === 'dev',
  'manifestPath' => '@webroot/dist/.vite/manifest.json',
  'devServerPublic' => App::env('PRIMARY_SITE_URL') . ':' . App::env('VITE_PRIMARY_PORT'),
  'serverPublic' => App::env('PRIMARY_SITE_URL') . '/dist/',
  'errorEntry' => '',
  'cacheKeySuffix' => '',
  'devServerInternal' => 'http://localhost:' . App::env('VITE_PRIMARY_PORT') . '/',
  'checkDevServer' => true,
  'includeReactRefreshShim' => false,
  'includeModulePreloadShim' => true,
  'criticalPath' => '@webroot/dist/criticalcss',
  'criticalSuffix' => '_critical.min.css',
];
