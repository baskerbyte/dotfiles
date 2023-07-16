#!/bin/bash

install_dependencies() {
    local distro=$1

    dependencies=()
    while IFS= read -r line; do
        if [[ $line =~ ^[^#]*[^[:space:]] ]] && [[ ! $line =~ ^\# ]]; then
            dependencies+=("$line")
        fi
    done < "$distro/dependencies"

    if [[ ${#dependencies[@]} -gt 0 ]]; then
        echo "Installing dependencies for $distro..."

        if [[ $distro == "gentoo" ]]; then
            sudo emerge -av --noreplace "${dependencies[@]}"
        else
            echo "Unsupported distribution. Exiting."
            exit 1
        fi
    else
        echo "No dependencies found."
    fi 
}

read -p "Which distribution are you using? " distro
distro=${distro}

install_dependencies "$distro"

# Additional dependencies
extra_dependencies_file="$distro/extra-dependencies.sh"
if [[ -f "$extra_dependencies_file" ]]; then
    echo "Installing extra dependencies for $distro..."
    chmod +x "$extra_dependencies_file"
    "./$extra_dependencies_file"
else
    echo "No extra dependencies found for $distro."
fi
