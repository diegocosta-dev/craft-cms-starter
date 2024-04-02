#!/bin/bash

# Load common functions and variables
DIR="$(dirname "${BASH_SOURCE[0]}")"
source "${DIR}/common.sh"

setup_ddev() {
  read -rp "Enter project name: " PROJECT_NAME
  # PROJECT_ROOT=/home/linux/code/dative
  # PROJECT_ROOT=/home/linux/code/me/craft-5-starter
  
  # Certifique-se de que o diretório do projeto existe
  if [ ! -d "$PROJECT_ROOT" ]; then
    echo "Directory '$PROJECT_ROOT' does not exist."
    return 1
  fi
  
  PROJECT_CRAFT_NAME=$PROJECT_NAME-craftcms

  # Crie a pasta no diretório especificado
  mkdir "$PROJECT_ROOT/$PROJECT_CRAFT_NAME"
  cd $PROJECT_ROOT/$PROJECT_CRAFT_NAME

  ddev config --project-type=craftcms --docroot=cms/web --php-version=8.2 --project-name=$PROJECT_CRAFT_NAME

  cd .ddev
  rm config.yaml

  # # # Copy .bin/ddev to .ddev
  raise "Copying $TASKS_DIR/ddev to $PROJECT_ROOT/$PROJECT_CRAFT_NAME/.ddev"
  rsync -ur $TASKS_DIR/ddev/. $PROJECT_ROOT/$PROJECT_CRAFT_NAME/.ddev;

  if [ -f "config.yaml" ]; then
    sed -i "s/###project-name###/$PROJECT_CRAFT_NAME/g" $PROJECT_ROOT/$PROJECT_CRAFT_NAME/.ddev/config.yaml || return 1
  fi
}

setup_craftcms() {
  printf "Setting up CMS...\n";

  ddev composer create -y --no-scripts "craftcms/craft"

  # echo "Copying $DIR/cms to $CRAFT_PATH";
  rsync -ur $TASKS_DIR/cms/. $PROJECT_ROOT/$PROJECT_CRAFT_NAME/cms;
  
  # echo "Copying $CRAFT_PATH/.env.example to $CRAFT_PATH/.env";
  cp $TASKS_DIR/cms/.env.example $PROJECT_ROOT/$PROJECT_CRAFT_NAME/cms/.env;
  
  # echo "Installing Craft...";
  ddev craft setup/app-id
  ddev craft setup/security-key

  DEFAULT_SITE_NAME=${PROJECT_NAME:-"Dative Boilerplate"}
  # Generate a random password
  ADMIN_PASSWORD=$(openssl rand -base64 8)
  SITE_URL=$(ddev describe -j | jq -r '.raw.primary_url')
  CRAFT_INSTALL_ARGS="--interactive=0 --email=${ADMIN_USERNAME} --language=en-US --password=${ADMIN_PASSWORD} --username=admin --site-name=${DEFAULT_SITE_NAME} --site-url=${SITE_URL}"

  ddev craft install/craft $CRAFT_INSTALL_ARGS

  # Replace PRIMARY_SITE_URL with $DDEV_PRIMARY_URL variable in .env file
  if [ -f "$PROJECT_ROOT/$PROJECT_CRAFT_NAME/cms/.env" ]; then
    sed -i 's/PRIMARY_SITE_URL=.*/PRIMARY_SITE_URL=\"$\{DDEV_PRIMARY_URL\}\"/' $PROJECT_ROOT/$PROJECT_CRAFT_NAME/cms/.env
  else
    printf "\033[31mCould not find .env file in $PROJECT_ROOT/$PROJECT_CRAFT_NAME/cms/.\033[0m\n"
  fi

  print_site_info() {
    printf "    \033[32mCraft CMS successfully set up!\033[0m\n";
    printf "    Site URL: $SITE_URL\n";
    printf "    Admin URL: $SITE_URL/admin\n";
    printf "    Username: $ADMIN_USERNAME\n";
    printf "    Password: $ADMIN_PASSWORD\n";
  }
}

setup_buildchain() {
  cd $PROJECT_ROOT/$PROJECT_CRAFT_NAME
  
  rsync -ur $TASKS_DIR/buildchain/. $PROJECT_ROOT/$PROJECT_CRAFT_NAME;

  if [ -f "package.json" ]; then
    sed -i "s/###site-name###/$PROJECT_CRAFT_NAME/g" $PROJECT_ROOT/$PROJECT_CRAFT_NAME/package.json || return 1
  fi

  printf "\033[32mBuildchain successfully copied!\033[0m\n";
}

plugins() {
  if [ ! -f "$TASKS_DIR/cms/plugins.txt" ]; then
    printf "\033[31mCould not find plugins.txt file in $TASKS_DIR/cms/.\033[0m\n"
  else
    PLUGINS_INSTALL_ARGS="--no-progress --no-scripts --no-interaction --optimize-autoloader --ignore-platform-reqs --update-with-dependencies $(cat $TASKS_DIR/cms/plugins.txt)"
    
    printf "Add Craft plugins...\n"
    ddev composer config allow-plugins.treeware/plant false
    ddev composer require $PLUGINS_INSTALL_ARGS
    ddev composer update
    
    # echo "Installing Craft plugins...";
    ddev craft plugin/install --all
  fi
}

install_plugins() {
  read -p "Install plugins? (y/n) " choice
  
  choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

  if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
    plugins
  elif [[ "$choice" == "n" || "$choice" == "no" ]]; then
      echo "Plugin installation cancelled.
  "
  else
      echo "Invalid response. Please answer Y for yes or N for no."
      install_plugins
  fi
}

launch_site() {
  cd $PROJECT_ROOT/$PROJECT_CRAFT_NAME

  ddev yarn
  ddev launch
}

run_main() {
  setup_ddev "$@" 
  setup_craftcms "$@"
  install_plugins "$@"
  setup_buildchain "$@"
  launch_site "$@"
  print_site_info
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  run_main "$*"
fi
