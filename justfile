#!/usr/bin/env -S just --justfile

# Default target - list all available commands
default:
    @just --list

## Playbook Operations

# Run ansible-lint on the playbooks
lint:
    ansible-lint playbooks/*.yaml playbooks/tasks/*.yaml

# Automatically fix ansible-lint violations where possible
lint-fix:
    ansible-lint playbooks/*.yaml playbooks/tasks/*.yaml --fix

# Run main configuration playbook
run HOST *TAGS:
    ansible-playbook -b playbooks/run.yaml --limit {{HOST}} {{TAGS}}

# Run playbook in check mode (dry run)
check HOST *TAGS:
    ansible-playbook -b playbooks/run.yaml --limit {{HOST}} {{TAGS}} --check

# Run playbook in debug mode
debug HOST *TAGS:
    ansible-playbook -b playbooks/run.yaml --limit {{HOST}} {{TAGS}} -vvv

## Update Operations

# Full system update (system, rust, cargo packages, starship)
update HOST *TAGS:
    ansible-playbook playbooks/update.yaml --limit {{HOST}} {{TAGS}}

# Quick update - only system packages
quick-update HOST:
    ansible-playbook playbooks/update.yaml --limit {{HOST}} --tags system

# Update development tools (rust, cargo packages, starship)
dev-update HOST:
    ansible-playbook playbooks/update.yaml --limit {{HOST}} --tags development,shell

# Reboot the server
reboot HOST:
    ansible-playbook playbooks/reboot.yaml --limit {{HOST}}

## Repository Management

# Initialize/Update git submodules
sub-update:
    git submodule update --init --recursive

# Add new git submodule (URL + optional local folder name)
sub-add URL *NAME:
    #!/usr/bin/env sh
    if [ -z "{{NAME}}" ]; then
        # Extract repo name from URL if no name provided
        basename=$(basename "{{URL}}" .git)
        git submodule add {{URL}} "roles/${basename}"
        git submodule update --init --recursive
        git add .gitmodules "roles/${basename}"
        git commit -m "Adds ${basename} as a submodule"
    else
        git submodule add {{URL}} "roles/{{NAME}}"
        git submodule update --init --recursive
        git add .gitmodules "roles/{{NAME}}"
        git commit -m "Adds {{NAME}} as a submodule"
    fi

# Remove a git submodule
sub-remove NAME:
    #!/usr/bin/env sh
    git submodule deinit -f "roles/{{NAME}}"
    rm -rf ".git/modules/roles/{{NAME}}"
    git rm -f "roles/{{NAME}}"
    git commit -m "Removes {{NAME}} submodule"

## Ansible Operations

# Install/Update Ansible requirements (optionally force reinstall)
reqs *FORCE:
    ansible-galaxy install -r requirements.yaml {{FORCE}}

# Manage Ansible vault (encrypt/decrypt/edit)
vault ACTION:
    EDITOR='code --wait' ansible-vault {{ACTION}} group_vars/secrets.enc.yaml

# Show Ansible facts for a host
facts HOST:
    ansible {{HOST}} -m ansible.builtin.setup

# Ping host to verify connectivity
ping HOST:
    ansible {{HOST}} -m ping

## Development Helpers

# Clean up temporary and cache files
clean:
    find . -type f -name '*.retry' -delete
    find . -type d -name '__pycache__' -exec rm -rf {} +
    find . -type f -name '*.pyc' -delete

# Format and lint yaml files
format:
    yamllint playbooks/*.yaml playbooks/tasks/*.yaml
    ansible-lint playbooks/*.yaml playbooks/tasks/*.yaml

# Initialize development environment
init:
    just sub-update
    just reqs
