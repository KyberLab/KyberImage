#!/usr/bin/env python3
#                                 KyberImage
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.

"""
License Text Processor Script

Description:
    This script processes license text files and injects the appropriate language
    version into a target script file. It supports multiple languages and
    handles text escaping for shell script compatibility.

Usage:
    python license.py -l <language> <source_file> <destination_file>

Arguments:
    -l, --language   Language code (e.g., zh_CN.UTF-8, en_US.UTF-8)
    source_file     Path to the license text file containing both language versions
    destination_file Path to the target script file to update

Example:
    python license.py -l zh_CN.UTF-8 LICENSE.txt install.sh
"""

import sys
import re


# ==============================================
# Utility Functions
# ==============================================

def split_license_file(license_file_path):
    """
    Split a license file into language sections using dash separators.
    
    The license file should contain two sections separated by three or more dashes (---).
    The first section is treated as English, the second as Chinese.
    
    Args:
        license_file_path: Path to the license file to split
        
    Returns:
        List of license text sections
    """
    # Open and read the license file with UTF-8 encoding
    with open(license_file_path, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # Split the content using a regex pattern for 3 or more dashes
    license_sections = re.split(r'---+', content)
    return license_sections


def extract_chinese_license(license_file_path):
    """
    Extract the Chinese version of the license text.
    
    Args:
        license_file_path: Path to the license file
        
    Returns:
        Chinese license text with escaped percent signs for shell script compatibility
    """
    # Split the license file into sections
    license_sections = split_license_file(license_file_path)
    
    # Get the second section (index 1) which contains the Chinese text
    # Escape percent signs (%) to double percent signs (%%) for shell script compatibility
    chinese_license = license_sections[1].replace('%', '%%')
    return chinese_license


def extract_english_license(license_file_path):
    """
    Extract the English version of the license text.
    
    Args:
        license_file_path: Path to the license file
        
    Returns:
        English license text with escaped percent signs and quotes for shell script compatibility
    """
    # Split the license file into sections
    license_sections = split_license_file(license_file_path)
    
    # Get the first section (index 0) which contains the English text
    english_license = license_sections[0].replace('%', '%%')  # Escape percent signs
    english_license = english_license.replace('"', '\\"')  # Escape double quotes
    return english_license


def update_target_file(license_text, destination_file_path):
    """
    Update the target file with the new license text.
    
    This function reads the target file, replaces the license_info variable
    with the new license text, and writes the updated content back to the file.
    
    Args:
        license_text: The license text to inject
        destination_file_path: Path to the destination file to update
    """
    # Read the current content of the destination file
    with open(destination_file_path, 'r', encoding='utf-8') as file:
        content = file.read()
    
    # Replace the empty license_info variable with the new license text
    updated_content = content.replace('license_info=""', f'license_info="{license_text}"')
    
    # Write the updated content back to the destination file
    with open(destination_file_path, 'w', encoding='utf-8') as file:
        file.write(updated_content)


# ==============================================
# Language Handler Functions
# ==============================================

def process_chinese_license(source_file_path, destination_file_path):
    """
    Handle the Chinese license processing workflow.
    
    This function extracts the Chinese license text from the source file
    and injects it into the destination file.
    
    Args:
        source_file_path: Path to the source license file
        destination_file_path: Path to the destination file to update
    """
    # Extract the Chinese license text
    chinese_license = extract_chinese_license(source_file_path)
    
    # Inject the Chinese license text into the destination file
    update_target_file(chinese_license, destination_file_path)


def process_english_license(source_file_path, destination_file_path):
    """
    Handle the English license processing workflow.
    
    This function extracts the English license text from the source file
    and injects it into the destination file.
    
    Args:
        source_file_path: Path to the source license file
        destination_file_path: Path to the destination file to update
    """
    # Extract the English license text
    english_license = extract_english_license(source_file_path)
    
    # Inject the English license text into the destination file
    update_target_file(english_license, destination_file_path)


# ==============================================
# Main Execution
# ==============================================

def main():
    """
    Main entry point for the script.
    
    This function parses command line arguments, determines the appropriate
    language handler, and executes the license processing workflow.
    """
    # Dictionary mapping language codes to their respective handler functions
    # Supported languages: Chinese (zh_CN.UTF-8) and English (en_US.UTF-8)
    language_handlers = {
        'zh_CN.UTF-8': process_chinese_license,
        'en_US.UTF-8': process_english_license,
    }
    
    # Parse command line arguments
    # sys.argv[0]: Script name
    # sys.argv[1]: -l flag
    # sys.argv[2]: Language code (e.g., zh_CN.UTF-8)
    # sys.argv[3]: Source file path
    # sys.argv[4]: Destination file path
    language_code = sys.argv[2]      # Language code
    source_file_path = sys.argv[3]    # Source license file
    destination_file_path = sys.argv[4]    # Destination script file
    
    # Execute the appropriate language handler based on the command
    # The handler function will extract and inject the license text
    language_handlers[language_code](source_file_path, destination_file_path)


# ==============================================
# Script Entry Point
# ==============================================

if __name__ == '__main__':
    # Execute the main function when the script is run directly
    main()
