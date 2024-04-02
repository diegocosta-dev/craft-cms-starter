# Template Components

This folder contains all the templates that are used to render components. Components are small pieces of code that can be reused in multiple places and follows the Single Responsability pattern.

## Naming

Components should be camel cased and prefixed with an underscore. The naming convention for components is to use the following format:

`_componentName.twig`

## Usage & Best Practices

To use a component in a template, use the following syntax:

`{{ include('_components/_componentName') }}`

Components should always be placed in the `_components` folder and omit the `.twig`.

Components should always have a single purpose, focusing on a single task. This makes them easier to reuse and test.

When deciding if a twig include shoud be a component or partial, ask yourself if the include requires a specific context parameter to work. If it does, it should be a component. If it doesn't, it should be a partial. For example:

### Site Header Partial

The main site header is a partial, because even though it will likely have lots of code in it, and it will use a lot of variables, it doesn't require any specific context to work. It will always be the same header, no matter what page it's included in.

`{{ include('_partials/_siteHeader') }}`

### useSprite Component

The `useSprite` is a component, because it requires a specific context parameter to work. It needs to know the symbol id in the sprite to use, and it will render the sprite's symbol that matches the given id.

`{{ include('_components/_useSprite', { id: 'symbolId' }) }}`

### Img Component

The `img` is another example of a component, because it requires that the `imgAsset` parameter is passed to it with a Asset. This is because the `img` component will perform various checks and transforms, then it will render the `img` tag with the `src` attribute set to the asset's url.

`{{ include('_components/_img', { imgAsset: entry.cover.one() }) }}`
