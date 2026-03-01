#!/bin/bash
#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.

# ==============================================
# KyberImage Installation Script
# Description: Install KyberImage package to specified directory
# Usage: ./install.sh [-d <install_path>] [-h]
# ==============================================

# ==============================================
# Configuration Variables
# ==============================================

# Package information
pkg_name="KyberImage"
pkg_version="1.0.0"

# Directory and file paths
temp_dir="/tmp"
temp_file="${pkg_name}-$(echo ${RANDOM}).tar.xz"

# Installation configuration
install_path=""
license_info=""

# ==============================================
# Language Detection
# ==============================================

# Detect system language from LANG environment variable
lang=$(echo $LANG | cut -d '.' -f1)
if [[ $lang == "zh"* ]]; then
	language="zh"
else
	language="en"
fi

# ==============================================
# Color Definitions
# ==============================================

RED='\033[31m'    # Error messages
GREEN='\033[32m'  # Success messages
YELLOW='\033[33m' # Warning messages
BLUE='\033[34m'   # Information messages
PURPLE='\033[35m' # Highlighted text
CYAN='\033[36m'   # Additional information
WHITE='\033[37m'  # Default text
RESET='\033[0m'   # Reset to default color

# ==============================================
# Internationalization (i18n) Strings
# ==============================================

# Load language-specific strings based on detected language
if [ "$language" = "zh" ]; then
	# ==============================================
	# Chinese Strings
	# ==============================================
	
	# Help and usage messages
	STR_HELP_TITLE="${pkg_name} 帮助    "
	STR_HELP_OPTION_D="   -d <安装路径> "
	STR_HELP_OPTION_H="   -h 显示此帮助      "
	
	# Error messages
	STR_UNKNOWN_ARG_PREFIX="未知参数 : \""
	STR_UNKNOWN_ARG_SUFFIX="\""
	STR_INVALID_ARGS_PREFIX="无效的非选项参数: "
	
	# License and consent messages
	STR_LICENSE_PROMPT="为了继续安装过程，请查看许可协议 按空格键阅读下一页。 \n请按ENTER键继续。\n"
	STR_CONSENT_PROMPT="您是否同意软件许可协议？ [y/n]"
	STR_CONSENT_AGREE="您已同意许可协议。"
	STR_CONSENT_DISAGREE="您不同意许可协议。退出。"
	STR_CONSENT_INVALID="输入无效，请重新输入 y/Y 继续，n/N 退出"
	
	# Installation progress messages
	STR_INSTALL_PREPARE="  ${pkg_name} 安装准备中 ... "
	STR_INSTALL_PATH_PREFIX="  安装路径 : "
	STR_INSTALL_COMPLETE="  ${pkg_name} 安装完成 ! "
	STR_INSTALL_ERROR="  ${pkg_name} 安装失败 ! "
	STR_EXTRACT_ERROR="  文件解压失败 ! "
	STR_CREATE_DIR_ERROR="  创建目录失败 ! "
	
else
	# ==============================================
	# English Strings
	# ==============================================
	
	# Help and usage messages
	STR_HELP_TITLE="${pkg_name} Help    "
	STR_HELP_OPTION_D="   -d <install path> "
	STR_HELP_OPTION_H="   -h this help      "
	
	# Error messages
	STR_UNKNOWN_ARG_PREFIX="Unknown argument: \""
	STR_UNKNOWN_ARG_SUFFIX="\""
	STR_INVALID_ARGS_PREFIX="Invalid non-option arguments: "
	
	# License and consent messages
	STR_LICENSE_PROMPT="To proceed with the installation, please review the license agreement. Press the space bar to read the next page. \nPlease press ENTER to continue.\n"
	STR_CONSENT_PROMPT="Do you agree to the software license agreement? [y/n]"
	STR_CONSENT_AGREE="You have agreed to the license agreement."
	STR_CONSENT_DISAGREE="You do not agree to the license agreement. Exiting."
	STR_CONSENT_INVALID="Invalid input. Please enter y/Y to continue or n/N to exit"
	
	# Installation progress messages
	STR_INSTALL_PREPARE="  ${pkg_name} Installation in progress ... "
	STR_INSTALL_PATH_PREFIX="  Installation path: "
	STR_INSTALL_COMPLETE="  ${pkg_name} installation completed successfully! "
	STR_INSTALL_ERROR="  ${pkg_name} installation failed! "
	STR_EXTRACT_ERROR="  File extraction failed! "
	STR_CREATE_DIR_ERROR="  Directory creation failed! "
fi

# ==============================================
# Utility Functions
# ==============================================

# Print colored message
# Parameters: $1 - color code, $2 - message
print_colored() {
	local color=$1
	local message=$2
	printf "${color}${message}${RESET}\n"
}

# Print error message in red
# Parameters: $1 - error message
print_error() {
	print_colored "${RED}" "$1"
}

# Print success message in green
# Parameters: $1 - success message
print_success() {
	print_colored "${GREEN}" "$1"
}

# Print information message in blue
# Parameters: $1 - information message
print_info() {
	print_colored "${BLUE}" "$1"
}

# Print warning message in yellow
# Parameters: $1 - warning message
print_warning() {
	print_colored "${YELLOW}" "$1"
}

# ==============================================
# Core Functions
# ==============================================

# Display help information
# Parameters: None
help() {
	print_info "${STR_HELP_TITLE}"
	print_info "${STR_HELP_OPTION_D}"
	print_info "${STR_HELP_OPTION_H}"
}

# Check and parse command line parameters
# Parameters: $@ - all command line arguments
check_param() {
	local OPTIND arg
	
	# Parse command line parameters using getopts
	while getopts "d:h" arg; do
		case $arg in
			d)  # Specify installation path
				install_path="${OPTARG}"
				;;
			
			h)  # Display help information
				help
				exit 0
				;;
			
			\?)  # Unknown parameter
				print_error "${STR_UNKNOWN_ARG_PREFIX}${arg}${STR_UNKNOWN_ARG_SUFFIX}"
				help
				exit 1
				;;
		esac
	done

	# Remove processed parameters
	shift $((OPTIND - 1))

	# Check for invalid non-option arguments
	if [ $# -ne 0 ]; then
		print_error "${STR_INVALID_ARGS_PREFIX}$*"
		help
		exit 1
	fi
}

# Display license page to user
# Parameters: $1 - license text content
printf_license() {
	print_info "${STR_LICENSE_PROMPT}"
	printf ">>> "
	read -r dummy
	
	# Select appropriate pager for displaying license
	local pager="cat"
	if command -v "more" > /dev/null 2>&1; then
		pager="more"
	elif command -v "less" > /dev/null 2>&1; then
		pager="less"
	fi
	
	# Display license using selected pager
	printf "${1}\n" | ${pager}
}

# Check user consent for license agreement
# Parameters: None
check_user_consent() {
	local valid_input=false
	local answer

	# Loop until valid input is received
	while [ "$valid_input" = false ]; do
		echo "${STR_CONSENT_PROMPT}"
		read -r answer

		case "$answer" in
			y|Y)  # User agrees to license
				print_success "${STR_CONSENT_AGREE}"
				valid_input=true
				;;
			
			n|N)  # User disagrees with license
				print_error "${STR_CONSENT_DISAGREE}"
				exit 1
				;;
			
			*)  # Invalid input
				print_warning "${STR_CONSENT_INVALID}"
				;;
		esac
	done
}

# Create directory with error handling
# Parameters: $1 - directory path to create
create_directory() {
	local dir_path=$1
	
	if ! mkdir -p "${dir_path}" 2>/dev/null; then
		print_error "${STR_CREATE_DIR_ERROR}"
		print_error "  Failed to create directory: ${dir_path}"
		exit 1
	fi
}

# Extract installation files with error handling
# Parameters: $1 - source file, $2 - destination directory, $3 - strip components flag
extract_files() {
	local source_file=$1
	local dest_dir=$2
	local strip_components=$3
	
	if ! tar xf "${source_file}" -C "${dest_dir}" ${strip_components:+--strip-components=$strip_components} 2>/dev/null; then
		print_error "${STR_EXTRACT_ERROR}"
		print_error "  Failed to extract: ${source_file}"
		exit 1
	fi
}

# Execute installation process
# Parameters: None
install() {
	print_info "${STR_INSTALL_PREPARE}"

	# Create temporary directory
	create_directory "${temp_dir}"
	
	# Extract installation files from script (skip header, start after exit 0)
	if ! sed '1,/^exit 0$/d' "$0" > "${temp_dir}/${temp_file}" 2>/dev/null; then
		print_error "${STR_INSTALL_ERROR}"
		print_error "  Failed to extract installation package"
		exit 1
	fi

	# Determine installation path
	if [ -z "${install_path}" ]; then
		# Use current directory as installation path
		install_path=${PWD}
	fi

	# Display installation path
	print_info "${STR_INSTALL_PATH_PREFIX}${install_path} "
	
	# Create installation directory
	create_directory "${install_path}"
	
	# Extract files based on installation path specification
	if [ -z "${install_path}" ] || [ "${install_path}" = "${PWD}" ]; then
		# Extract to current directory (keep directory structure)
		extract_files "${temp_dir}/${temp_file}" "${install_path}" ""
	else
		# Extract to specified directory (remove top-level directory)
		extract_files "${temp_dir}/${temp_file}" "${install_path}" "1"
	fi

	# Clean up temporary files
	if ! rm -rf "${temp_dir}/${temp_file}" 2>/dev/null; then
		print_warning "  Warning: Failed to remove temporary file: ${temp_dir}/${temp_file}"
	fi

	print_success "${STR_INSTALL_COMPLETE}"
}

# ==============================================
# Main Execution Flow
# ==============================================

main() {
	# Step 1: Check and parse command line parameters
	check_param "$@"

	# Step 2: Display license page
	printf_license "${license_info}"

	# Step 3: Check user consent for license
	check_user_consent

	# Step 4: Execute installation
	install
}

# Execute main function with all arguments
main "$@"

# Script termination marker
exit 0
