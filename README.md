# craft-cms-starter

## Acknowledgements
I want to extend my thanks to [@webrgp](https://github.com/webrgp). The repository I'm creating draws heavily from @Webrgp's work on the [original repository](https://github.com/dative/craftcms-starter).

## Overview

`craft-cms-starter` is a project starter tool designed to streamline the setup process for a Craft CMS project with a modern development environment. This tool integrates a Makefile, Docker, DDEV, Craft CMS, ViteJS, and Tailwind CSS to provide a seamless setup experience for your team.

## Notable Features

- [DDEV](https://ddev.readthedocs.io/) for local development
- [Craft CMS 5.x](https://craftcms.com/) for content management
- [Vite 5.x](https://vitejs.dev/) for front-end bundling & HMR
- [Tailwind 3.x](https://tailwindcss.com) for utility-first CSS
- [Alpine 3.x](https://alpinejs.dev/) for lightweight reactivity
- [Makefile](https://www.gnu.org/software/make/manual/make.html) for common CLI commands

## Prerequisites

Before using the `craft-cms-starter` tool, make sure you have the following installed:

- [Docker](https://docs.docker.com/get-docker/)
- [DDEV](https://ddev.readthedocs.io/), minimum version v1.22.7

## Getting Started

## Setup Makefile

Configure your username and where you want to install projects.

```sh
ADMIN_USERNAME		:= user@email.com # Set project user email/user-name
PROJECT_ROOT		:= "/home/user/projects-path" # Set project path
```
## Commands

To set up a new project, run the following command in your terminal:

```sh
make project-setup
```

## Template System

The `craft-cms-starter` comes with a base template system that is designed to get you up and running quickly. You can use the templates as-is, or you can customize them to your project needs.

To learn more about the template system, see the [Template System](TEMPLATES.md) section below.
