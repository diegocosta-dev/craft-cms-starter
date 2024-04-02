# Starter Templates

The `craft-cms-starter` comes with an opinionated base template system that is designed to get you up and running quickly. You can use the templates as-is, or you can customize them to your project needs.

The templates uses the Twig tem­plat­ing lan­guage, and as such it should not be used for com­pli­cat­ed busi­ness or inten­sive calculations.

Not that it can’t han­dle either (it can) but rather that it shouldn’t.

If you’re unclear as to why, read about why Twig was cre­at­ed to begin with in the [Tem­plat­ing Engines in PHP article](http://fabien.potencier.org/templating-engines-in-php.html).

## Introduction

Every project is dif­fer­ent, but some underly­ing prin­ci­ples are the same. So here’s what we want out of a base tem­plat­ing system:

1. The abil­i­ty to use it unmod­i­fied on a wide vari­ety of projects
2. One tem­plate that can be used both as a web page, and as pop­up modals via AJAX / XHR
3. Imple­ment core fea­tures for us, with­out restrict­ing me in terms of flexibility

Throughout this doc­u­men­ta­tion, we’ll refer to templates as a **Project** or **Boilerplate** template:

A **Project** template may vary from project to project.

A **Boilerplate** template is the same for every project.

## Structure

The tem­plat­ing sys­tem is built on the fol­low­ing struc­ture:

```bash
├── _base
│   ├── _base_html_layout.twig
│   ├── _base_web_layout.twig
│   ├── _body_js.twig
│   ├── _head_js.twig
│   ├── _head_meta.twig
│   └── _tab_handler.twig
├── _components
│   ├── _heading.twig
│   ├── _img.twig
│   ├── _pageHeader.twig
│   ├── _useSprite.twig
│   └── _contentBlocks
│       ├── index.twig
│       ├── _richText.twig
│       └── _picture.twig
├── _layouts
│   ├── _global_variables.twig
│   ├── _naked_layout.twig
│   └── _base_page_layout.twig
├── _pages
│   ├── _page.twig
│   ├── _default_page.twig
│   └── _home.twig
├── _partials
│   ├── _site_header.twig
│   └── _site_footer.twig
├── index.twig
└── page.twig
```

I will explain each of these files in detail below, following Twig's processing order. You can learn more about [Twig Processing Order & Scope here](https://nystudio107.com/blog/twig-processing-order-and-scope).

### \_layouts/\_global_variables.twig (Project)

Due to Twig’s Pro­cess­ing Order & Scope, if we want to have glob­al vari­ables that are always avail­able in all of our tem­plates, they need to be defined in the root tem­plate that all oth­ers extends from.

Since these glob­als can vary from project to project, they are not part of the boil­er­plate, but they are required for the setup.

The `_global_variables.twig` tem­plate has the fol­low­ing blocks that can be over­rid­den by its children:

`htmlPage` —  a block that encom­pass­es the entire ren­dered HTML page

### \_base/\_base_web_layout.twig (Boilerplate)

Every web­page, whether a reg­u­lar web page or a Google AMP page inher­its from this tem­plate. The set­up may look a lit­tle weird, but it’s done this way so that child tem­plates can over­ride bits like the open­ing <html> tag if they need to:

```twig
{% extends "_layouts/_global_variables.twig" %}

{%- block htmlPage -%}
	{% minify %}
	<!DOCTYPE html>

		{% block htmlTag %}
			<html lang="{{ craft.app.language |slice(0,2) }}">
		{% endblock htmlTag %}

		{% block headTag %}
			<head>
		{% endblock headTag %}

			{{ include("_base/_head_meta.twig") }}

			{# -- Page content that should be included in the <head> -- #}
			{% block headContent %}{% endblock headContent %}
			</head>

			{% block bodyTag %}
			<body>
			{% endblock bodyTag %}
				{% block svgSprite %}{% endblock %}
				{% block bodyContent %}{% endblock bodyContent %}
			</body>
	</html>
	{% endminify %}
{%- endblock htmlPage -%}
```

The `_base_web_layout.twig` tem­plate has the fol­low­ing blocks that can be over­rid­den by its children:

- `htmlTag ` —  the `<html>` tag, which child tem­plates might need to override
- `headTag ` —  the `<head>` tag, which child tem­plates might need to override
- `headContent` —  what­ev­er tags need to go into the `<head>`
- `bodyTag` —  the `<body>` tag, which child tem­plates might need to override
- `bodyContent`  —  what­ev­er tags need to go in the `<body>`

In addi­tion, the `\_base/\_head_meta.twig` par­tial that con­tains boil­er­plate tags put into the `<head>` is includ­ed here as well.

### \_base/\_base_ajax_layout.twig (Boilerplate)

If the request is an AJAX / XHR request, we want to return just the page’s {% content %} block, with­out any of the web page ​“chrome” around it.

This is exact­ly what this tem­plate does:

```twig
{% extends "_layouts/_global_variables.twig" %}

{%- block htmlPage -%}
    {% minify %}
        {# -- Primary content block -- #}
        {% block content %}
            <code>No content block defined.</code>
        {% endblock content %}
    {% endminify %}
{%- endblock htmlPage -
```

The `_base_ajax_layout.twig` tem­plate has the fol­low­ing blocks that can be over­rid­den by its children:

- `content` — the core con­tent that is rep­re­sent­ed on the page

### \_base/\_base_html_layout.twig (Boilerplate)

This is the base HTML lay­out that all HTML requests inher­it from:

```twig
{% extends "_base/_base_web_layout.twig" %}

{% block htmlTag %}
	<html class="fonts-loaded" lang="en" prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb#">
{% endblock htmlTag %}

{% block headContent %}
	{% block headMeta %}{% endblock headMeta %}
	{% block headLinks %}{% endblock headLinks %}
	{{ include("_base/_head_js.twig") }}
	{% block headJs %}{% endblock headJs %}
	{% block headCss %}{% endblock headCss %}
{% endblock headContent %}

{% block bodyContent %}
	{% block bodyHtml %}{% endblock bodyHtml %}
	{% include "_base/_body_js.twig" %}
	{% block bodyJs %}{% endblock bodyJs %}
{% endblock bodyContent %}
```

The `_base_html_layout.twig` tem­plate has the fol­low­ing blocks that can be over­rid­den by its children:

- `headMeta` — Any `<meta>` tags that should be includ­ed in the `<head>`
- `headLinks` — Any `<link>` tags that should be includ­ed in the `<head>`
- `headJs` — Any JavaScript that should be includ­ed before `</head>`
- `headCss` — Any CSS that should be includ­ed before `</head>`
- `bodyHtml` — Page con­tent that should be includ­ed in the `<body>`
- `bodyJs` — Any JavaScript that should be includ­ed before `</body>`

In addi­tion, the `_base/_head_js.twig` and `_base/_body_js.twig` boil­er­plate par­tials are includ­ed here as well.
