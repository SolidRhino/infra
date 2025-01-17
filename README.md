# 🚀 RPi Infrastructure

> 🤖 Infrastructure as Code (IaC) for managing Raspberry Pi servers using Ansible. Automates the setup and maintenance of development tools, system configurations, and services.

## ✨ Features

### 🔧 System Configuration
- 📦 Package management and system updates
- 🔒 Security configurations
- 🌡️ Performance optimizations with Argon cooling
- ⚡ Overclocking support (when cooling is properly configured)

### 👨‍💻 Development Environment
- 🦀 Rust and Cargo setup
- 🛠️ Modern CLI tools installation and configuration
- 🐋 Docker environment setup
- 📚 Common development packages

### 🐟 Shell Environment
- 🐠 Fish shell with modern configuration
- ⭐ Starship prompt for enhanced CLI experience
- 🔗 Useful aliases and functions
- 🧰 Improved CLI tools:
  - 📊 Bottom (btm) - Modern system monitor
  - 📂 Eza - Enhanced file listing
  - 📝 Bat - Enhanced file viewer
  - 🗺️ Zoxide - Smart directory navigation

## 📋 Prerequisites

- 🎮 Ansible 2.9 or higher
- 🥧 Raspberry Pi running Ubuntu/Debian
- 🔑 SSH access configured
- ⚡ Just command runner (optional, but recommended)

## 📁 Directory Structure

```
infra/
├── playbooks/
│   ├── tasks/
│   │   ├── system.yaml        # 🔧 System configuration tasks
│   │   ├── development.yaml   # 👨‍💻 Development tools tasks
│   │   ├── shell.yaml         # 🐟 Shell configuration tasks
│   │   ├── terminal.yaml      # 💻 Terminal configuration tasks
│   │   └── overclocking.yaml  # ⚡ Overclocking configuration
│   ├── run.yaml               # 🚀 Main playbook
│   ├── update.yaml            # 🔄 Update playbook
│   └── reboot.yaml            # 🔌 Reboot playbook
├── roles/                     # 🎭 Ansible roles
├── group_vars/                # ⚙️ Variable files
└── justfile                   # 📜 Just command definitions
```

## 🚀 Quick Start

1. Clone the repository:
```bash
git clone https://github.com/SolidRhino/infra.git
cd infra
```

2. Initialize the environment:
```bash
just init
```

3. Run the playbook:
```bash
just run server
```

## 🎮 Available Commands

### 🎯 Main Operations
- `just run server` - 🚀 Run main configuration playbook
- `just update server` - 🔄 Update system and tools
- `just quick-update server` - ⚡ Quick system update only
- `just dev-update server` - 🛠️ Update development tools
- `just reboot server` - 🔌 Reboot the server

### 👨‍💻 Development Operations
- `just lint` - 🔍 Run ansible-lint
- `just format` - ✨ Format and lint yaml files
- `just init` - 🎮 Initialize development environment

### 🔧 Maintenance
- `just clean` - 🧹 Clean up temporary files
- `just facts server` - 📊 Show Ansible facts for host
- `just ping server` - 🔔 Test connectivity

## 🔄 Update Process

The repository includes separate playbooks for different update scenarios:

- 📦 Full system update:
```bash
just update server
```

- ⚡ Quick system update (OS packages only):
```bash
just quick-update server
```

- 🛠️ Development tools update:
```bash
just dev-update server
```

## ⚙️ Customization

1. ✏️ Edit `vars/` files to customize configurations
2. 🔧 Modify tasks in `playbooks/tasks/` for specific needs
3. ➕ Add new roles to `roles/` directory
4. 📝 Update `justfile` for new commands

## 🤝 Contributing

1. 🍴 Fork the repository
2. 🌿 Create a feature branch
3. 💾 Commit your changes
4. 🚀 Push to the branch
5. 📬 Create a Pull Request

## 🙏 Acknowledgments

- 🎮 [Ansible](https://www.ansible.com/)
- 🐟 [Fish Shell](https://fishshell.com/)
- ⭐ [Starship](https://starship.rs/)
- 📊 [Bottom](https://github.com/ClementTsang/bottom)
- 📂 [Eza](https://github.com/eza-community/eza)
- 📝 [Bat](https://github.com/sharkdp/bat)
- 🗺️ [Zoxide](https://github.com/ajeetdsouza/zoxide)

---
<div align="center">
🌟 Star this repository if you find it helpful!
</div>
