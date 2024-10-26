# CBIS-DDSM Dataset Analyzer

This project provides a graphical user interface (GUI) for exploring the **CBIS-DDSM** (Curated Breast Imaging Subset of the Digital Database for Screening Mammography) dataset. The application is designed to allow researchers to browse, filter, and analyze mammography images and corresponding metadata without needing to write code.

Due to technical limitations, we were unable to package the server (Python) and client (Electron/TypeScript) into a single executable file. As a workaround, this repository includes a script to automate the setup process by cloning the necessary repositories, installing dependencies, and running both the client and server.

## Features

- **Interactive Filtering**: Filter patients based on metadata such as BIRADS category, breast side, abnormality type, and more.
- **Data Viewing**: View patient mammography images along with corresponding region of interest (ROI) and mask images.
- **Query Management**: Save frequently used filters for quick access later.
- **Server-Side Processing**: Efficiently handle large datasets with server-side filtering and image conversion.

## Requirements

To run this project, you will need the following installed on your system:

- **Git**
- **Node.js** (for the Electron client)
- **Python 3.x** (for the Flask server)
- **Pip** (for Python dependencies)

## Setup Instructions

To set up the project on your local machine, follow these steps:

### 1. Clone This Repository

```bash
git clone https://github.com/DDSM-CBIS/ddsm-analyzer.git
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

The provided script will automatically clone the server and client repositories, install all required dependencies, and start both the client and server.
Once you downloaded the files in the repository, double click on `run.bat`.

This script performs the following actions:

1. Clones the [**client**](https://github.com/DDSM-CBIS/ddsm-electron) repository from GitHub.
2. Clones the [**server**](https://github.com/DDSM-CBIS/ddsm-electron) repository from GitHub.
3. Installs dependencies for both the client and server.
4. Starts the Flask server.
5. Launches the Electron client.

**Note**: The first run will be slower as the project install itself and its (python and js) dependencies.

### 3. Access the Application

Once the script completes successfully, the program will open automatically, and you can start exploring the CBIS-DDSM dataset through the Electron-based GUI.
