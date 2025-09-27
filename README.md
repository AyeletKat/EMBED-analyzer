#  EMBED Open Data Analyzer

This project provides a graphical user interface (GUI) for exploring the **EMBED Open Data** (Emory Breast Imaging Dataset).  
The application is designed to allow researchers to browse, filter, and analyze mammography images and corresponding metadata without needing to write code.  
  
The viewer is build from a server that works with the dataset and an Electron that makes the UI.  
You can find the server here:  
[server](https://github.com/AyeletKat/ddsm-server.git)  
and the electron here:   
[electron](https://github.com/Oriya-Sigawy/ddsm-electron.git)  
This repository includes a script that automates the setup process by cloning the server and the electron repos, installing dependencies, and running them.  

## Features

- **Interactive Filtering**: Filter patients based on metadata such as BIRADS category, breast side, abnormality type, and more.
- **Data Viewing**: View patient mammography images along with corresponding data.
- **Query Management**: Save frequently used filters for quick access later.
- **Server-Side Processing**: Efficiently handle large datasets with server-side filtering and image conversion.

This is how the viewer looks like:
![alt text](https://github.com/AyeletKat/EMBED-analyzer/blob/main/pictures/full_screen.png)

## Requirements

To run this project, you will need the following installed on your system:

- **Git**
- **Node.js** (for the Electron electron)
- **Python 3.x** (for the Flask server)
- **Pip** (for Python dependencies)

## Setup Instructions

To set up the project on your local machine, follow these steps:

### 1. Clone This Repository

```bash
git clone https://github.com/AyeletKat/ddsm-analyzer.git
cd <this-repo-directory>
```

#### Installing Python

1. **Download Python Installer**  
   Go to [https://www.python.org/downloads/](https://www.python.org/downloads/) and click on "Download Python 3.x.x".

2. **Run the Installer**

   - Open the downloaded installer.
   - Check the box **"Add Python 3.x to PATH"**.
   - Click **Install Now**.

3. **Verify Installation**  
   Open Command Prompt and run:
   ```bash
   python --version
   pip --version
   ```

#### Installing Node

1. **Download Node.js Installer**  
   Go to [https://nodejs.org/en/](https://nodejs.org/en/) and download the **LTS** version.

2. **Run the Installer**

   - Open the downloaded installer.
   - Accept the license agreement and proceed with the default settings.
   - Check the box **"Automatically install the necessary tools"** if available, and click **Install**.

3. **Verify Installation**  
   Open Command Prompt and run:
   ```bash
   node --version
   npm --version
   ```

### 2. Run the Script

The provided script will automatically clone the server and electron repositories, install all required dependencies, and start both the electron and server.
**windows**: *runnable.ps1* is the script for windows, run it by:
```bash
cd <analyzer-repo-directory>  
.\runnable.ps1  
```
**Linux/mac**: *runnable.sh* is the script for Linux/mac, run it by:
```bash
cd <analyzer-repo-directory>
chmod +x runnable.sh  
./runnable.sh  
```
This script performs the following actions:

1. Clones the [**electron**](https://github.com/Oriya-Sigawy/ddsm-electron.git) repository from GitHub. If its already cloned, its only pulls the last changes.
2. Clones the [**server**](https://github.com/AyeletKat/ddsm-server.git) repository from GitHub. If its already cloned, its only pulls the last changes.
3. Installs dependencies for both the electron and server.
4. Starts the Flask server.
5. Launches the Electron electron.

**Note**: The first run will be slower as the project install itself and its (python and js) dependencies.

### 3. Access the Application

Once the script completes successfully, the program will open automatically, and you can start exploring the EMBED Open Data through the Electron-based GUI.
