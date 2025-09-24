#!/bin/bash

# Exit on errors
set -e

# === Function to clone or update repos ===
clone_repos() {
    repos=(
        "https://github.com/AyeletKat/ddsm-server"
        "https://github.com/Oriya-Sigawy/ddsm-electron"
    )

    for repo in "${repos[@]}"; do
        repo_name=$(basename "$repo" .git)

        if [ ! -d "$repo_name/.git" ]; then
            echo "Cloning repository: $repo"
            git clone "$repo"
        else
            echo "Checking for updates in $repo_name..."
            cd "$repo_name"

            # Fetch latest info
            git fetch origin

            local_commit=$(git rev-parse HEAD)
            remote_commit=$(git rev-parse origin/HEAD)

            if [ "$local_commit" != "$remote_commit" ]; then
                echo "Repository $repo_name is outdated. Pulling latest changes..."
                git pull
            else
                echo "Repository $repo_name is up to date."
            fi
            cd ..
        fi
    done
}

# === Function to create virtual environment ===
create_venv() {
    if ! command -v python3 &>/dev/null; then
        echo "Python is not installed. Please install Python first."
        exit 1
    fi

    venv_dir="venv"
    if [ -d "$venv_dir" ]; then
        echo "Virtual environment already exists in '$venv_dir'."
    else
        echo "Creating virtual environment..."
        python3 -m venv "$venv_dir"
    fi

    # Activate the virtual environment
    source "$venv_dir/bin/activate"
    if [ -n "$VIRTUAL_ENV" ]; then
        echo "Virtual environment created and activated successfully!"
    else
        echo "Failed to activate virtual environment."
        exit 1
    fi
}

# === Function to install Python dependencies ===
python_install() {
    python_dir="ddsm-server"
    if [ -d "$python_dir" ]; then
        echo "Entering Python directory: $python_dir"
        cd "$python_dir"
        echo "Running pip install..."
        pip install -r requirements.txt
        cd ..
    else
        echo "Python directory not found: $python_dir"
        exit 1
    fi
}

# === Function to install JavaScript dependencies ===
js_install() {
    js_dir="ddsm-electron"
    if [ -d "$js_dir" ]; then
        echo "Entering JavaScript directory: $js_dir"
        cd "$js_dir"
        echo "Running npm install..."
        npm install
        cd ..
    else
        echo "JavaScript directory not found: $js_dir"
        exit 1
    fi
}

# === Function to run Python server ===
python_run() {
    python_dir="ddsm-server"
    if [ -d "$python_dir" ]; then
        echo "Starting Python server..."
        cd "$python_dir"
        python3 run.py &
        PYTHON_SERVER_PID=$!
        echo "Python server started with PID: $PYTHON_SERVER_PID"
        cd ..
    else
        echo "Python directory not found: $python_dir"
    fi
}

# === Function to run JS client ===
js_run() {
    js_dir="ddsm-electron"
    if [ -d "$js_dir" ]; then
        echo "Starting JavaScript client..."
        cd "$js_dir"
        npm run dev &
        JS_RUN_PID=$!
        echo "JavaScript client started with PID: $JS_RUN_PID"
        wait $JS_RUN_PID
        cd ..
    else
        echo "JavaScript directory not found: $js_dir"
    fi
}

# === Main flow ===
install_and_run() {
    js_install
    echo "JavaScript installation finished."

    python_install
    echo "Python installation finished."

    python_run

    echo "Waiting 30 seconds for server to be ready..."
    sleep 30

    js_run

    echo "Stopping Python server..."
    kill $PYTHON_SERVER_PID
}

# === Script execution ===
clone_repos
create_venv
install_and_run

# Show captured PIDs
echo "Python Server PID: $PYTHON_SERVER_PID"
echo "JavaScript Client PID: $JS_RUN_PID"
