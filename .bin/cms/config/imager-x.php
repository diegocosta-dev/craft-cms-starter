<?php

use craft\helpers\App;

return [
  // Global settings
  'imagerSystemPath' => '@imagerRoot',
  'imagerUrl' => '@imagerUrl',
  'interlace' => true,
  'cacheDuration' => 86400 * 7 * 52, // 1 year
  'cacheDurationRemoteFiles' => 86400 * 7 * 52, // 1 year
  'cacheDurationExternalStorage' => 86400 * 7 * 52, // 1 year
  'removeTransformsOnAssetFileops' => true,
  'smartResizeEnabled' => true,
  'removeMetadata' => true,
  'optimizers' => [
    'jpegoptim',
    'optipng',
    'gifsicle',
    'webp'
  ],
  'optimizerConfig' => [
    'jpegoptim' => [
      'extensions' => ['jpg'],
      'path' => '/usr/bin/jpegoptim',
      'optionString' => '-s -q',
    ],
    'optipng' => [
      'extensions' => ['png'],
      'path' => '/usr/bin/optipng',
      'optionString' => '-o2 -quiet',
    ],
    'gifsicle' => [
      'extensions' => ['gif'],
      'path' => '/usr/bin/gifsicle',
      'optionString' => '--optimize=3 --colors 256',
    ],
  ],
  'customEncoders' => [
    'webp' => [
      'path' => '/usr/bin/cwebp',
      'options' => [
        'quality' => 80,
        'effort' => 4,
      ],
      'paramsString' => '-q {quality} -m {effort} {src} -o {dest}'
    ],
  ],
  'webpImagickOptions' => array(
    'lossless' => 'true',
  ),
];
