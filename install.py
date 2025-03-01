import argparse
import os
import yaml

LOGGING_ENABLED = True

def log_message(message: str):
    if LOGGING_ENABLED:
        print(message)

def ask_user_permission(action: str, path: str) -> bool:
    response = input(f"Do you want to {action} {path}? (y/n)").lower()
    
    return response == 'y'

def create_symlink(src: str, dest: str):
    if os.path.islink(dest):
        os.remove(dest)

    os.symlink(src, dest)

    log_message(f"Created symlink from {src} to {dest}")

def run_post_commands(commands: list):
    for cmd in commands:
        log_message(f"Running command: {cmd}")
        os.system(cmd)

def install_dotfiles(config_file: str):
    with open(config_file, 'r') as file:
        config = yaml.safe_load(file)

    dotfiles = config.get("dotfiles", [])

    for dotfile in dotfiles:
        log_message(f"\033[1;32mProcessing: {dotfile.get('name')}\033[0m")

        src = dotfile.get("src")
        dest = dotfile.get("dest")

        if src and dest:
            src = os.path.abspath(src)
            dest = os.path.expandvars(dest)
           
            if dotfile.get("type") == "symlink":
                create_symlink(src, dest)

        log_message("")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Install .dotfiles from a YAML config file.")
    parser.add_argument("config_file", help="Path to config file.")

    args = parser.parse_args()

    with open(args.config_file, 'r') as file:
        config = yaml.safe_load(file)

    install_dotfiles(args.config_file)
    
    post_run_commands = config.get("post_install", [])
    run_post_commands(post_run_commands)




