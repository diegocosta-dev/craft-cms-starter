# Template Partials

This folder contains all the partials to be used in the templates. Partials are small pieces of code that can be reused in multiple places and are usually used when related to layout or design primarily.

## Naming

Partials should be camel cased and prefixed with an underscore. The naming convention for partials is to use the following format:

`_partialName.twig`

## Usage & Best Practices

To use a partial in a template, use the following syntax:

`{{ include('_partials/_partialName') }}`

Partials should always be placed in the `_partials` folder and omit the `.twig` extension when using the `include` function.

If a partial starts to get too big, you should first move the file in a folder with the partial original name, and rename it to `index.twig`. That way any existing includes will still work, and you can then start to break the partial into smaller pieces. For example:

`_partials/_partialName.twig` becomes `_partials/_partialName/index.twig`
