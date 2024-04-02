# Template Layouts

This directory contains the template layouts for the CMS. These layouts are used to render the CMS pages.

## Naming

Layouts should be snake cased and prefixed with an underscore. The naming convention for layouts is to use the following format:

`_layout_name.twig`

## Included Layouts

### \_layouts/\_global_variables

This file is not really a layout, but it is included in the `_layouts` folder to make it easier to find. This file contains the global variables that are available in all templates. You can add your own global variables here.

### \_layouts/\_naked_layout

This is the base layout that other layouts or pages can extend. It's where you can add `<head>` and `<body>` global includes and configurations.

All the global `css`, `js` and `link` tags and the `svg` sprite are included in this layout.

### \_layouts/\_base_page_layout

This is the starting base layout for all pages. It extends the `_naked_layout` and it's where you can add the site's header, footer, alerts and any other global visual shared elements.

## Usage & Best Practices

Layouts should always be placed in the `_layouts` folder and omit the `.twig`.

The included layouts extends the layouts and partials from the `_base` folder, which contains a variety of resets and other configurations. You can extend these layouts and partials to create your own layouts and partials.
