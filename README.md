# KyberImage Build System

[中文版本](README_zh.md) | English Version

The `image` directory contains a platform-agnostic image building and management system, providing a comprehensive framework for creating, managing, and deploying virtual machine images across different architectures.    It requires configuration based on different architectures and requirements, and needs to be used in conjunction with the KyberBench and Kyber<Board Name> projects.

## Directory Structure

```
image/
├── Build.mk           # Build configuration
├── Config.mk          # Configuration settings
├── Download.mk        # Download configurations
├── Makefile           # Main Makefile
├── Shortcut.mk        # Shortcut commands
├── goal/              # Goal definitions
│   ├── Goal.mk        # Main goal definitions
│   ├── Method.mk      # Method definitions
│   └── Phase.mk       # Phase definitions
├── method/            # Build methods
│   ├── Bin.mk         # Binary build method
│   ├── BuildRoot.mk   # BuildRoot build method
│   ├── Crate.mk       # Crate build method
│   ├── Custom.mk      # Custom build method
│   ├── Dump.mk        # Dump build method
│   ├── File.mk        # File build method
│   ├── Git.mk         # Git build method
│   ├── Install.mk     # Install build method
│   ├── Linux.mk       # Linux build method
│   ├── Make.mk        # Make build method
│   ├── Patch.mk       # Patch build method
│   ├── Scons.mk       # Scons build method
│   ├── Skip.mk        # Skip build method
│   ├── Tar.mk         # Tar build method
│   ├── Ubuntu.mk      # Ubuntu build method
│   └── Wget.mk        # Wget build method
├── scripts/           # Utility scripts
│   ├── LICENCE        # Scripts license
│   ├── install.sh     # Installation script
│   └── licence.py     # License management script
└── type/              # Image types
    ├── Android.mk     # Android image type
    ├── BuildRoot.mk   # BuildRoot image type
    ├── BusyBox.mk     # BusyBox image type
    ├── Crate.mk       # Crate image type
    ├── Custom.mk      # Custom image type
    ├── Dump.mk        # Dump image type
    ├── Linux.mk       # Linux image type
    ├── Make.mk        # Make image type
    ├── U-Boot.mk      # U-Boot image type
    └── Ubuntu.mk      # Ubuntu image type
```

## Features

### 1. Comprehensive Build System

- **Modular Design**: Highly modular build system with separate components for goals, methods, and types
- **Flexible Configuration**: Extensive configuration options for customizing builds
- **Multi-method Support**: Support for various build methods including Git, Wget, Make, and more
- **Automated Dependency Management**: Automatic handling of build dependencies

### 2. Image Types

- **Diverse Image Support**: Support for multiple image types including Linux, BuildRoot, BusyBox, and more
- **Custom Image Creation**: Ability to create custom image types for specific use cases
- **Bootloader Images**: Support for creating bootloader images like U-Boot

### 3. Build Methods

- **Git Integration**: Support for cloning and building from Git repositories
- **Package Management**: Support for various package formats and management systems
- **Cross-compilation**: Support for cross-compiling images for different architectures
- **Patching Support**: Built-in support for applying patches to source code
- **Archive Handling**: Support for handling various archive formats

### 4. Utility Scripts

- **Installation Tools**: Scripts for installing and configuring built images
- **License Management**: Tools for managing software licenses
- **Automation Support**: Scripts for automating common tasks

## Usage

### 1. Basic Build Process

```bash
# Build all images
make image

# Build specific image
make <image-name>_build

# Clean build artifacts
make <image-name>_clean
```

### 2. Configuration

```bash
# Edit main configuration
vim Config.mk

# Edit specific build method
vim method/<method-name>.mk

# Edit specific image type
vim type/<image-type>.mk
```

### 3. Custom Builds

```bash
# Create custom build method
cp method/Custom.mk method/MyCustom.mk
vim method/MyCustom.mk

# Create custom image type
cp type/Custom.mk type/MyCustomType.mk
vim type/MyCustomType.mk
```

## Build Phases

The image build process consists of several phases:

1. **Download Phase**: Downloading required sources and dependencies
2. **Patch Phase**: Applying any necessary code patches
3. **Configuration Phase**: Setting up build configurations and parameters
4. **Build Phase**: Compiling and building the image components
5. **Installation Phase**: Installing components into the image
6. **Packaging Phase**: Packaging the image for deployment

## Supported Image Types

| Image Type | Description | Use Case |
|------------|-------------|----------|
| Linux | Linux kernel image | Kernel development and testing |
| BuildRoot | BuildRoot-based root filesystem | Embedded systems and minimal environments |
| BusyBox | BusyBox-based minimal system | Small footprint environments |
| U-Boot | U-Boot bootloader | Bootloader development and testing |
| Custom | Custom image type | Specialized use cases |

## Build Methods

| Method | Description | Usage |
|--------|-------------|--------|
| Git | Clone and build from Git repository | Source code management |
| Wget | Download files using wget | Fetching binary files and archives |
| Make | Build using Makefile | Standard build systems |
| BuildRoot | Build using BuildRoot | Root filesystem creation |
| Linux | Build Linux kernel | Kernel development |
| Custom | Custom build method | Specialized build processes |

## License

The image system components adopt the Apache License 2.0 open source license. For specific terms, please refer to the [LICENSE](LICENSE) file.

## Contribution

Contributions to the image system are welcome. Please ensure you follow the project's code style and contribution guidelines. Some ways to contribute include:

- Adding new build methods for additional source types
- Supporting new image types for different operating systems
- Improving existing build scripts and configurations
- Adding documentation and examples
- Testing on different hardware platforms

---

**KyberImage Build System**
Platform-agnostic Image Builder
Copyright (c) 2025-2026, Kyber Development Team, all rights reserved.
