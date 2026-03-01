# KyberImage 构建系统

本项目包含一个平台无关的镜像构建和管理系统，为不同架构提供全面的框架，用于创建、管理和部署虚拟机镜像，需要根据不同的架构和需求进行配置，需要配合KyberBench和Kyber<Board Name>项目进行使用。

## 目录结构

```
image/
├── Build.mk           # 构建配置
├── Config.mk          # 配置设置
├── Download.mk        # 下载配置
├── Makefile           # 主 Makefile
├── Shortcut.mk        # 快捷命令
├── goal/              # 目标定义
│   ├── Goal.mk        # 主目标定义
│   ├── Method.mk      # 方法定义
│   └── Phase.mk       # 阶段定义
├── method/            # 构建方法
│   ├── Bin.mk         # 二进制构建方法
│   ├── BuildRoot.mk   # BuildRoot 构建方法
│   ├── Crate.mk       # Crate 构建方法
│   ├── Custom.mk      # 自定义构建方法
│   ├── Dump.mk        # Dump 构建方法
│   ├── File.mk        # 文件构建方法
│   ├── Git.mk         # Git 构建方法
│   ├── Install.mk     # 安装构建方法
│   ├── Linux.mk       # Linux 构建方法
│   ├── Make.mk        # Make 构建方法
│   ├── Patch.mk       # 补丁构建方法
│   ├── Scons.mk       # Scons 构建方法
│   ├── Skip.mk        # 跳过构建方法
│   ├── Tar.mk         # Tar 构建方法
│   ├── Ubuntu.mk      # Ubuntu 构建方法
│   └── Wget.mk        # Wget 构建方法
├── scripts/           # 实用脚本
│   ├── LICENCE        # 脚本许可证
│   ├── install.sh     # 安装脚本
│   └── licence.py     # 许可证管理脚本
└── type/              # 镜像类型
    ├── Android.mk     # Android 镜像类型
    ├── BuildRoot.mk   # BuildRoot 镜像类型
    ├── BusyBox.mk     # BusyBox 镜像类型
    ├── Crate.mk       # Crate 镜像类型
    ├── Custom.mk      # 自定义镜像类型
    ├── Dump.mk        # Dump 镜像类型
    ├── Linux.mk       # Linux 镜像类型
    ├── Make.mk        # Make 镜像类型
    ├── U-Boot.mk      # U-Boot 镜像类型
    └── Ubuntu.mk      # Ubuntu 镜像类型
```

## 功能特点

### 1. 全面的构建系统

- **模块化设计**：高度模块化的构建系统，将目标、方法和类型分离为独立组件
- **灵活的配置**：广泛的配置选项，用于自定义构建过程
- **多方法支持**：支持各种构建方法，包括 Git、Wget、Make 等
- **自动化依赖管理**：自动处理构建依赖关系

### 2. 镜像类型

- **多样化镜像支持**：支持多种镜像类型，包括 Linux、BuildRoot、BusyBox、Ubuntu、Android 等
- **自定义镜像创建**：能够为特定用例创建自定义镜像类型
- **引导加载程序镜像**：支持创建 U-Boot 等引导加载程序镜像

### 3. 构建方法

- **Git 集成**：支持从 Git 仓库克隆和构建
- **包管理**：支持各种包格式和管理系统
- **交叉编译**：支持为不同架构交叉编译镜像
- **补丁支持**：内置支持向源代码应用补丁
- **归档处理**：支持处理各种归档格式

### 4. 实用脚本

- **安装工具**：用于安装和配置构建镜像的脚本
- **许可证管理**：管理软件许可证的工具
- **自动化支持**：用于自动化常见任务的脚本

## 使用方法

### 1. 基本构建过程

```bash
# 构建所有镜像
make image

# 构建特定镜像
make <image-name>_build

# 清理构建产物
make <image-name>_clean
```

### 2. 配置

```bash
# 编辑主配置
vim Config.mk

# 编辑特定构建方法
vim method/<method-name>.mk

# 编辑特定镜像类型
vim type/<image-type>.mk
```

### 3. 自定义构建

```bash
# 创建自定义构建方法
cp method/Custom.mk method/MyCustom.mk
vim method/MyCustom.mk

# 创建自定义镜像类型
cp type/Custom.mk type/MyCustomType.mk
vim type/MyCustomType.mk
```

## 构建阶段

镜像构建过程包括几个阶段：

1. **下载阶段**：下载所需的源代码和依赖项
2. **补丁阶段**：应用任何必要的代码补丁
3. **配置阶段**：设置构建配置和参数
4. **构建阶段**：编译和构建镜像组件
5. **安装阶段**：将组件安装到镜像中
6. **打包阶段**：打包镜像以进行部署

## 支持的镜像类型

| 镜像类型 | 描述 | 用例 |
|---------|------|------|
| Linux | Linux 内核镜像 | 内核开发和测试 |
| BuildRoot | 基于 BuildRoot 的根文件系统 | 嵌入式系统和最小环境 |
| BusyBox | 基于 BusyBox 的最小系统 | 小 footprint 环境 |
| U-Boot | U-Boot 引导加载程序 | 引导加载程序开发和测试 |
| Custom | 自定义镜像类型 | 专用用例 |

## 构建方法

| 方法 | 描述 | 用途 |
|------|------|------|
| Git | 从 Git 仓库克隆和构建 | 源代码管理 |
| Wget | 使用 wget 下载文件 | 获取二进制文件和归档 |
| Make | 使用 Makefile 构建 | 标准构建系统 |
| BuildRoot | 使用 BuildRoot 构建 | 根文件系统创建 |
| Linux | 构建 Linux 内核 | 内核开发 |
| Custom | 自定义构建方法 | 专用构建过程 |

## 许可证

镜像系统组件采用 Apache License 2.0 开源许可证。有关具体条款，请参阅 [LICENSE](LICENSE) 文件。

## 贡献

欢迎对镜像系统做出贡献。请确保您遵循项目的代码风格和贡献指南。一些贡献方式包括：

- 为其他源类型添加新的构建方法
- 为不同操作系统支持新的镜像类型
- 改进现有的构建脚本和配置
- 添加文档和示例
- 在不同的硬件平台上进行测试

---

**KyberImage 构建系统**
平台无关镜像构建器
版权所有 (c) 2025-2026，Kyber 开发团队，保留所有权利。
