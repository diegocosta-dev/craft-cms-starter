<?php

/**
 * Note on transforms:
 *
 * Transform sizes should be in ascending order, so that the largest image is
 * the first one in the array. This is because of Imager transform order, where
 * the next transform in the array will use the previous transform as the source,
 * if the previous transform is bigger than the next one.
 *
 * We also assume that the last transform will be the smallest one, where we can
 * use it to create the blurhashes.
 *
 * https://imager-x.spacecat.ninja/usage/#transform-the-transform
 */
return [

  // This is the default transform that will be
  // applied to all images to prevent the successive
  // transforms from being too large.
  'baseTransform' => [
    'transforms' => [
      'width' => 1920,
    ],
    'defaults' => [
      'quality' => 100
    ]
  ],

  'cover[16/9]' => [
    'transforms' => [
      ['width' => 1024],
      ['width' => 768],
      ['width' => 640],
    ],
    'defaults' => [
      'ratio' => 16 / 9,
      'format' => 'jpg',
      'quality' => 90
    ]
  ],
  'square' => [
    'transforms' => [
      ['width' => 1024],
      ['width' => 768],
      ['width' => 640],
    ],
    'defaults' => [
      'ratio' => 1 / 1,
      'format' => 'jpg',
      'quality' => 90
    ]
  ],
];
