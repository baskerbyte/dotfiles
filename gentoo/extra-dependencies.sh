#!/bin/bash

dirs=()

install_dependency() {
    local repo_url=$1
    local build_command=$2

    repo_name=$(basename "$repo_url" .git)
    dirs+=("$repo_name")

    echo "==============================="
    if ! git clone "$repo_url"; then
        echo "Failed to clone repository $repo_url."
        exit 1
    fi

    pushd "$repo_name" || { echo "Failed to change directory to $repo_name."; exit 1; }

    echo "==============================="
    echo "Building $repo_name..."
    if ! eval "$build_command"; then
        echo "Failed to build $repo_name."
        exit 1
    fi

    popd || { echo "Failed to change back to previous directory."; exit 1; }

    echo "Installation of $repo_name completed."
}

move_binary() {
    local path=$1

    chmod +x ./"$path"
    sudo mv "$path" /usr/bin
}

# Tiny dynamic menu for Wayland
install_dependency "https://github.com/philj56/tofi.git" "meson build && ninja -C build install"

# WM widgets
install_dependency "https://github.com/elkowar/eww.git" "cargo build --release --no-default-features --features=wayland"
move_binary "eww/target/release/eww"

# Wayland wallpaper manager
install_dependency "https://github.com/Horus645/swww.git" "cargo build --release"
move_binary "swww/target/release/swww"
move_binary "swww/target/release/swww-daemon"

# Wayland notification daemon
install_dependency "https://github.com/emersion/mako.git" "meson build && ninja -C build"
move_binary "mako/build/mako"

# Screenshot tool
install_dependency "https://github.com/waycrate/wayshot.git" "make setup && make && sudo make install"

# Clean up
echo "==============================="
echo "Cleaning up..."
for dir in "${dirs[@]}"; do
    if [[ -d "$dir" ]]; then
        rm -rf "$dir"
        echo "Directory $dir deleted."
    else
        echo "Directory $dir does not exist."
    fi
done