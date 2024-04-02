<!-- [![CraftCMS Build & Atomic Deployment](https://github.com/dative/###PROJECT_NAME###/actions/workflows/build-and-deploy.yml/badge.svg?branch=main)](https://github.com/dative/###PROJECT_NAME###/actions/workflows/build-and-deploy.yml) -->

# ###PROJECT_NAME###

This is the project repository code for the [###PROJECT_URL###](https://###PROJECT_URL###/) website.

<!-- [Google PageSpeed Insights](https://pagespeed.web.dev/report?url=https%3A%2F%2F###PROJECT_URL###%2F&form_factor=desktop) -->

[Teamwork Project](https://dative.teamwork.com/app/projects/###PROJECT_ID###)

## Overview

ENTER PROJECT OVERVIEW HERE

## Initial Setup

If you are running the project for the first time, ensure that DDEV is installed and running on your machine and that you have a fresh copy of the database and environment variables, then:

```bash
# 1. Clone the git repo
git clone https://github.com/dative/###PROJECT_NAME###.git

# 2. Change into the project directory
cd ###PROJECT_NAME###

# 3. Copy the `.env.example` file to `.env`
cp cms/.env.example cms/.env

# 4. Start DDEV
ddev start

# 5. Install dependencies
ddev composer install && ddev yarn

# 6. Create the cms/storage directory
mkdir cms/storage

# (Optional) Import the database
ddev import-db --src=PATH_TO_DB_DUMP.sql
```

Once the dependencies are installed, you can start development.

## Development

In the project root, you can start the frontend buildchain by running:

```bash
ddev yarn dev
```

My intent is that the `setup` command can be broken into sub tasks that can handle different the parts of the project setup:

- DDEV:

  - Check if ddev is installed in the system
  - Check if `.ddev` existis in the project root, and if it doesn't:
    - Copy `.boilerplate/ddev` to .ddev
    - Prompt for the `project-name`
    - Run `ddev config --project-name=<project-name>` with the project name
    - Run `ddev start`

- CMS:

  - Check if `cms` directory exists in the project root, and if it doesn't:
    - Copy `.boilerplate/cms` to `cms`
    - Copy cms/example.env to cms/.env
  - Check if DDEV is running, and if it isn't:
    - Start DDEV
  - Check if Craft is already installed, and if it isn't:
    - Install composer dependencies using DDEV
    - Install Craft using DDEV
    - Install plugins using DDEV

- Frontend:

  - Check if `src` directory exists in the project root, and if it doesn't:
    - Copy `.boilerplate/src` to `src`
  - Check and copy each file in `.boilerplate/devtools` directory that doesn't exist to the project root
  - Check if DDEV is running, and if it isn't:
    - Start DDEV
  - Check if `node_modules` exist at the root of the project, and if it doesn't:
    - Install npm dependencies using DDEV

ddev craft install/craft --interactive=0 --email="$(ADMIN_USERNAME)" --language="en-US" --password="$(TMP_CRAFT_PASS)" --username="admin" --site-name="$(DEFAULT_SITE_NAME)"; \

# Windows Notes:

- Need to run in WSL2
- Need to install `make` with `sudo apt install make`
- Need to install `jq` with `sudo apt install jq`

# Forgot New Install Admin Password

ddev craft users/set-password info@hellodative.com --password=NEW_PASSWORD

# Reset cms-setup command

cat drop.sql | ddev mysql && ddev stop && rm -rf cms && make cms-setup

# Craft Config Files

- general.php
- vite.php

# Front End Config Files

- tsconfig.json
- package.json

# Notes on Alpine and CSP

https://alpinejs.dev/advanced/csp

# Imager-X

Make sure you are using the Pro version instead of the Lite version.
