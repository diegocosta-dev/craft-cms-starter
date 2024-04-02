###################################################
# 	Variables                                     #
#                                                 #
# 	Uncomment and set the variables to override 	#
# 	the defaults.                                 #
#                                                 #
###################################################

# System defaults
SHELL = /bin/sh

ADMIN_USERNAME		:= user@email.com # Set project user email/user-name
PROJECT_ROOT			:= "/home/linux/code/me/craft-5-starter" # Set project path

# Source the shell script function tasks
mkfile_path 			:= $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir 				:= $(dir $(mkfile_path))
TASKS_DIR        	:= "${mkfile_dir}.bin"

ifdef PROJECT_ROOT
TASK_VARS			 += PROJECT_ROOT=${PROJECT_ROOT}
endif

ifdef ADMIN_USERNAME
TASK_VARS			 += ADMIN_USERNAME=${ADMIN_USERNAME}
endif

ifdef TASKS_DIR
TASK_VARS			 += TASKS_DIR=${TASKS_DIR}
endif

# Macros
args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`

.PHONY: project-setup

project-setup:
	@${TASK_VARS} bash ${TASKS_DIR}/project-setup.sh
%:
	@:
# ref: https://stackoverflow.com/questions/6273608/how-to-pass-argument-to-makefile-from-command-line
