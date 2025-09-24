function Clone-Repos {
    # Define the repository URLs
    $repos = @(
        "https://github.com/AyeletKat/ddsm-server",
        "https://github.com/Oriya-Sigawy/ddsm-electron"
    )

    foreach ($repo in $repos) {
        $repoName = ($repo.Split('/')[-1]).Replace('.git','')

        if (-not (Test-Path "$repoName/.git")) {
            Write-Host "Cloning repository: $repo"
            git clone $repo
        } else {
            Write-Host "Checking for updates in $repoName..."
            Push-Location $repoName

            # Fetch remote state
            git fetch origin | Out-Null

            $localCommit  = (git rev-parse HEAD).Trim()
            $remoteCommit = (git rev-parse "origin/HEAD").Trim()

            if ($localCommit -ne $remoteCommit) {
                Write-Host "Repository $repoName is outdated. Pulling latest changes..."
                git pull
            } else {
                Write-Host "Repository $repoName is up to date."
            }
            Pop-Location
        }
    }
}


# Function to create a virtual environment
function Create-Venv {
    # Check if Python is installed
    if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
        Write-Host "Python is not installed. Please install Python first."
        return 1
    }

    # Define the virtual environment directory
    $VenvDir = "venv"

    # Check if the virtual environment directory already exists
    if (Test-Path $VenvDir) {
        Write-Host "Virtual environment already exists in the '$VenvDir' directory."
        return 0
    }

    # Create the virtual environment
    python -m venv $VenvDir

    # Activate the virtual environment
    & "$VenvDir\Scripts\Activate.ps1"

    # Confirm the virtual environment is activated
    if ($env:VIRTUAL_ENV) {
        Write-Host "Virtual environment created and activated successfully!"
    } else {
        Write-Host "Failed to activate the virtual environment."
        return 1
    }
}

# Function to install Python dependencies
function Python-Install {
    $PythonDir = "ddsm-server"  # Set your Python directory here

    if (Test-Path $PythonDir) {
        Write-Host "Entering Python directory: $PythonDir"
        Set-Location -Path $PythonDir
        Write-Host "location: $(get-location)"
        Write-Host "Running pip install..."

        # Start pip install and capture the PID
        $pythonInstallProcess = Start-Process pip "install -r requirements.txt" -PassThru -NoNewWindow
        $global:pythonInstallPID = $pythonInstallProcess.Id
        Write-Host "Python install process started with PID: $global:pythonInstallPID"
        Set-Location ..
    } else {
        Write-Host "Python directory not found: $PythonDir"
        exit 1
    }
}

# Function to install JavaScript dependencies
function Js-Install {
    $JsDir = "ddsm-electron"   # Set your JavaScript directory here

    if (Test-Path $JsDir) {
        Write-Host "Entering JavaScript directory: $JsDir"
        Set-Location -Path $JsDir
        Write-Host "Running npm install..."

        # Start npm install and capture the PID
        $jsInstallProcess = Start-Process "npm.cmd" "install" -NoNewWindow -PassThru
        $global:jsInstallPID = $jsInstallProcess.Id
        Write-Host "JavaScript install process started with PID: $global:jsInstallPID"
        Set-Location ..
    } else {
        Write-Host "JavaScript directory not found: $JsDir"
        exit 1
    }
}

# Function to run the Python server in a separate process
function Python-Run {
    $PythonDir = "ddsm-server"  # Set your Python directory here

    if (Test-Path $PythonDir) {
        Write-Host "Entering Python directory to start server: $PythonDir"
        Set-Location -Path $PythonDir
        Write-Host "Starting Python server in a separate process..."

        # Start the Python server and capture the PID
        $pythonServerProcess = Start-Process python "run.py" -PassThru -NoNewWindow
        $global:pythonServerPID = $pythonServerProcess.Id
        Write-Host "Python server started with PID: $global:pythonServerPID"
        Set-Location ..
    } else {
        Write-Host "Python directory not found: $PythonDir"
    }
}

# Function to run the JavaScript client in a separate process
function Js-Run {
    $JsDir = "ddsm-electron"   # Set your JavaScript directory here

    if (Test-Path $JsDir) {
        Write-Host "Entering JavaScript directory to start client: $JsDir"
        Set-Location -Path $JsDir
        Write-Host "Starting JavaScript client..."

        # Start the npm dev server and capture the PID
        $jsRunProcess = Start-Process "npm.cmd" -ArgumentList "run dev" -NoNewWindow -PassThru
        $global:jsRunPID = $jsRunProcess.Id
        Write-Host "JavaScript client started with PID: $global:jsRunPID"
    } else {
        Write-Host "JavaScript directory not found: $JsDir"
    }
}

# Main flow to install dependencies and run the applications
function Install-And-Run {
    # Run JavaScript installation
    Js-Install
    Write-Host "JavaScript installation finished."

    Get-Location
    # Run Python installation
    # Python-Install
    Get-Location
    Write-Host "Python installation finished."

    # Start the Python server in a separate process
    Python-Run

    # Wait for server to be ready
    Start-Sleep -Seconds 30

    # Start the JavaScript client
    Js-Run

    # Wait for client to stop running to kill the local server
    Wait-Process -Id $global:jsRunPID
}

# clone the repos
Clone-Repos

# Create virtual environment
Create-Venv

# Call the main flow
Install-And-Run

# Show captured PIDs
Write-Host "Python Install PID: $global:pythonInstallPID"
Write-Host "JavaScript Install PID: $global:jsInstallPID"
Write-Host "Python Server PID: $global:pythonServerPID"
Write-Host "JavaScript Client PID: $global:jsRunPID"
