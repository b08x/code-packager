# Code Packager and Unpackager for LLMs 📦

> **Based on the original project by [Yoichiro Hasebe](https://github.com/yohasebe)**  
> *Bridging the Gap Between Complex Codebase 🖥️ and AI 🤖*

Effortlessly package and unpack your codebase into structured formats (JSON/CSV) ready to be analyzed and understood by large language models (LLMs) like GPT-4, Claude, Command R, and Gemini.

This enhanced toolkit builds upon **[Yoichiro Hasebe's](https://github.com/yohasebe)** original code-packager project, providing a comprehensive suite of bash scripts that simplify the process of preparing your code for interaction with LLMs and various AI platforms:

- **`code-packager`**: Core JSON packaging tool (original by Yoichiro Hasebe)
- **`code-unpackager`**: Restores directory structure from JSON files (original by Yoichiro Hasebe)
- **`code-packager-csv`**: CSV format variant for spreadsheet compatibility
- **`code-packager-chunked`**: Advanced chunking tool optimized for dify.ai and vector databases
- **`code-packager-batch`**: Batch processor for handling multiple projects recursively

By converting your code into structured formats and restoring it back, you unlock the potential for advanced analysis, code generation, and insightful interactions with AI.

[![asciicast](https://asciinema.org/a/722443.svg)](https://asciinema.org/a/722443)

## 📋 Table of Contents

- [👨‍💻 About the Original Project](#-about-the-original-project)
- [📋 Change Log](#-change-log)
- [🛠️ Available Tools](#️-available-tools)
- [✨ Features](#-features)
- [🚀 Installation](#-installation)
  - [Homebrew (Recommended for macOS Users)](#homebrew-recommended-for-macos-users)
  - [Manual Installation](#manual-installation)
- [💻 Usage](#-usage)
  - [Code Packager](#code-packager)
  - [Code Unpackager](#code-unpackager)
  - [Code Packager CSV](#code-packager-csv)
  - [Code Packager Chunked](#code-packager-chunked)
- [📚 Examples](#-examples)
  - [Example Output](#example-output)
  - [File/Directory Structure Example](#filedirectory-structure-example)
- [🔧 Troubleshooting](#-troubleshooting)
- [🙏 Acknowledgements](#-acknowledgements)
- [🤝 Contributing](#-contributing)
- [📄 License](#-license)
- [👨‍💻 Original Author](#-original-author)

## 👨‍💻 About the Original Project

The core concept and foundation of this toolkit was created by **[Yoichiro Hasebe](https://github.com/yohasebe)** (<yohasebe@gmail.com>), who designed the original `code-packager` and `code-unpackager` tools to bridge the gap between complex codebases and AI language models. His innovative approach of structuring code for LLM consumption has made this project a valuable resource for developers working with AI-assisted code analysis and generation.

This enhanced version builds upon that solid foundation with additional output formats and interactive capabilities to serve a broader range of use cases.

## 📋 Change Log

- [Jun 07, 2025] Enhanced TUI selector with step-by-step workflow and improved directory/file filtering
- [Nov 10, 2024] Added support for including/excluding specific filenames using `-I` and `-E` options
- [Sep 15, 2024] `code-unpackager` script added
- [Jun 22, 2024] `max_depth` option added
- [May 01, 2024] initial commit

## 🛠️ Available Tools

This toolkit includes five powerful utilities designed for different use cases:

### 📦 `code-packager`

Yoichiro Hasebe's core tool for packaging codebases into structured JSON format:

- Standard JSON output with comprehensive metadata
- Vector store optimized format for AI/ML pipelines
- Interactive TUI/GUI selection modes
- Extensive filtering and customization options

### 📤 `code-unpackager`

Yoichiro Hasebe's companion tool that restores directory structures from JSON files:

- Supports both legacy and vector store JSON formats
- Automatic content extraction and directory recreation
- Safe restoration with confirmation prompts

### 📊 `code-packager-csv`

CSV format variant for spreadsheet and database compatibility:

- Same powerful filtering as the core tool
- CSV output: `filename,path,full_path,content,is_binary`
- Perfect for data analysis and reporting workflows
- Compatible with Excel, Google Sheets, and database imports

### 🧩 `code-packager-chunked`

Advanced chunking tool optimized for AI platforms and vector databases:

- **Smart code-aware chunking** with language-specific boundary detection
- **Parent-child chunk structure** optimized for dify.ai document processing
- **Configurable chunk sizes** (default: 2000 chars parent, 600 chars child)
- **CSV output format**: `parent_id,parent_content,child_id,child_content,filename,path,is_binary`
- **Automatic size limits** to prevent oversized outputs
- **Intelligent splitting** at logical code boundaries (functions, classes, etc.)

### 🚀 `code-packager-batch`

Batch processor for handling multiple projects at scale:

- **Recursive project discovery** with intelligent project detection
- **Support for all packager types** (JSON, CSV, chunked)
- **Configurable project indicators** (package.json, .git, requirements.txt, etc.)
- **Interactive and saved configuration modes** 
- **Comprehensive reporting** with processing statistics and metadata
- **Batch processing output structure**: organized by project with individual metadata files
- **Skip existing outputs** to resume interrupted batch operations
- **Verbose logging** and progress tracking

## ✨ Features

- 📦 **Comprehensive Code Packaging and Unpacking:**
  - `code-packager` handles various file types and sizes, allowing you to include or exclude specific extensions or filenames, respect `.gitignore` rules, and optionally zip archive the resulting JSON file for efficient storage and sharing.
  - `code-unpackager` restores the packaged JSON back to its original directory structure, making it easy to manage and modify your codebase.
- 🎯 **Interactive File Selection:**
  - **TUI mode** with `gum` provides a step-by-step workflow:
    1. Select base directory to package
    2. Choose top-level directories to include
    3. Select subdirectories to exclude (fine-tuning)
    4. Choose file types to exclude
    5. Set output filename
  - **GUI mode** with `yad` for graphical file/folder browsing and selection with multi-select (Ctrl+click)
  - **Smart filtering** where directory exclusions take precedence over file type inclusions
  - **Hidden directory support** - when dot files are enabled (`-d 1`), hidden directories like `.git`, `.vscode` appear in the selector for explicit inclusion/exclusion
- 🚀 **Vector Store Optimized Format:**
  - Special `-V` flag creates vector store optimized JSON format that embeds filename information directly into file content
  - Ensures filename context is preserved when content is chunked by vector databases
  - Backward compatible with existing JSON format
- ⚙️ **Customizable Output and Restoration:**
  - Control the level of detail and structure of the generated JSON file by including or excluding files of particular extensions, tailoring the output to your specific Language Model (LLM) and use case requirements.
  - Seamlessly restore the directory structure and file contents from the JSON file, ensuring consistency and ease of use.
- 🤖 **Structured JSON Output for LLM Interpretation:**
  - Formats the packaged codebase into JSON, enabling easy interpretation by Language Models (LLMs) for advanced analysis and code-related tasks. The structured organization facilitates seamless integration with various LLMs.
- 😀 **Easy Installation and Usage:**
  - Available as a Homebrew formula for macOS users and supports manual installation on various platforms. The scripts offer a range of options to customize the code packaging and unpacking process, providing flexibility and control over the output.
- 🖼️ **Binary File Handling:**
  - Automatically omits the contents of binary files for efficiency, ensuring that only relevant code is included in the packaged output. This feature streamlines the code packaging process and enhances the usability of the resulting JSON file.
- 🛡️ **Graceful Exit Handling:**
  - Both `code-packager` and `code-unpackager` handle CTRL+C interruptions gracefully, cleaning up temporary files and incomplete outputs to prevent corrupted states. The tools exit with proper status codes and informative messages.

## 🚀 Installation

### Homebrew (Recommended for macOS Users)

Run the following commands:

```bash
brew tap yohasebe/code-packager
brew install code-packager 
```

That's it! All four utilities (`code-packager`, `code-unpackager`, `code-packager-csv`, and `code-packager-chunked`) should now be available in your terminal.

### Manual Installation

1. Install the following dependencies:

- `git`
- `jq`
- `file`
- `zip`
- `fd` (modern find replacement)
- `gum` (for TUI file selector)
- `yad` (optional, for GUI file selector)

On a Debian-based Linux distribution, you can install these dependencies with:

```bash
sudo apt-get install git jq file zip fd-find gum yad
```

Note: On some distributions, `fd` may be packaged as `fd-find`.

2. Identify a directory in your system's PATH variable where you want to place the scripts. You can check the directories in your PATH variable by running the following command:

```bash
echo $PATH
```

3. Move all four scripts to the chosen directory. For example, if you want to move them to `/usr/local/bin`, run the following commands:

```bash
mv code-packager /usr/local/bin
mv code-unpackager /usr/local/bin
mv code-packager-csv /usr/local/bin
mv code-packager-chunked /usr/local/bin
```

4. Make sure all scripts are executable by running the following commands:

```bash
chmod +x /usr/local/bin/code-packager
chmod +x /usr/local/bin/code-unpackager
chmod +x /usr/local/bin/code-packager-csv
chmod +x /usr/local/bin/code-packager-chunked
```

## 💻 Usage

### Code Packager

```bash
code-packager -t <directory_path> -o <output_file> [options]
```

**Options:**

- `-t <directory_path>`: **(Required)** Path to the directory containing the code you want to package.
- `-o <output_file>`: **(Required)** Path to the output JSON file. If a directory path is specified, the output file will be named based on the target directory.
- `-i <include_extension>`: Include files with the specified extension (e.g., `.py`, `.js`). You can use this option multiple times to include files with different extensions.
- `-I <include_filename>`: Include files with the specified filename (e.g., `README`, `LICENSE`). You can use this option multiple times to include different files.
- `-e <exclude_extension>`: Exclude files with the specified extension. You can use this option multiple times to exclude files with different extensions. (**Note:** This option is useful if you are including most files but want to exclude specific types.)
- `-E <exclude_filename>`: Exclude files with the specified filename. You can use this option multiple times to exclude different files.
- `-s <max_size_in_kb>`: Include files up to the specified size in kilobytes.
- `-g <respect_gitignore>`: Set to `1` to respect `.gitignore`, `0` to ignore (default: `1`).
- `-d <include_dot_files>`: Set to `1` to include dot files and folders, `0` to exclude (default: `0`).
- `-z <zip_output>`: Set to `1` to zip the output JSON file, `0` to leave uncompressed (default: `0`).
- `-S <selector_mode>`: Use file/folder selector: `tui` for gum-based interactive step-by-step workflow, `gui` for yad-based graphical selection with multi-select (Ctrl+click for multiple files).
- `-V`: Enable vector store optimized format (embeds filename in content for better chunking).
- `-m <max_depth>`: Limit the maximum depth of the search (default: unlimited).
- `-v, --version`: Display the version of the script and exit.
- `-h, --help`: Display this help message and exit.

### Code Unpackager

```bash
code-unpackager -j <json_file> -d <destination_directory> [options]
```

**Options:**

- `-j <json_file>`: **(Required)** Path to the JSON file generated by code-packager.
- `-d <destination_directory>`: **(Required)** Path to the directory where the folder structure should be restored.
- `-s, --silent`: Skip confirmation before restoration.
- `-v, --version`: Display the version of the script and exit.
- `-h, --help`: Display this help message and exit.

### Code Packager CSV

```bash
code-packager-csv -t <directory_path> -o <output_file> [options]
```

The CSV variant supports all the same options as the main `code-packager`, but outputs to CSV format instead of JSON:

- `-t <directory_path>`: **(Required)** Path to the directory containing the code you want to package.
- `-o <output_file>`: **(Required)** Path to the output CSV file (.csv extension will be added if not present).
- All filtering options (`-i`, `-I`, `-e`, `-E`, `-s`, `-g`, `-d`, `-m`) work the same as the main tool
- `-S <selector_mode>`: Interactive selection modes (TUI/GUI)
- `-V`: Enable vector store optimized format
- `-z <zip_output>`: Zip the output file
- `-v, --version`: Display version information
- `-h, --help`: Display help message

### Code Packager Chunked

```bash
code-packager-chunked -t <directory_path> -o <output_file> [options]
```

The chunked variant creates parent-child chunk structures optimized for AI platforms:

- `-t <directory_path>`: **(Required)** Path to the directory containing the code you want to package.
- `-o <output_file>`: **(Required)** Path to the output CSV file (.csv extension will be added if not present).
- `-P <parent_max_chars>`: Maximum characters for parent chunks (default: 2000).
- `-C <child_max_chars>`: Maximum characters for child chunks (default: 600).
- `-M <max_output_mb>`: Maximum output file size in MB (default: 14).
- All standard filtering options (`-i`, `-I`, `-e`, `-E`, `-s`, `-g`, `-d`, `-m`)
- `-S tui`: Interactive TUI selection workflow
- `-V`: Enable vector store optimized format
- `-z <zip_output>`: Zip the output file
- `-v, --version`: Display version information
- `-h, --help`: Display help message

### Code Packager Batch

```bash
code-packager-batch -s <source_directory> -o <output_directory> [options]
```

Batch process multiple projects with automatic project discovery:

**Required Options:**
- `-s <source_directory>`: Root directory containing project directories
- `-o <output_directory>`: Directory where packaged outputs will be saved

**Optional Arguments:**
- `-t <packager_type>`: Type of packager: 'json', 'csv', or 'chunked' (default: json)
- `-d <max_depth>`: Maximum depth to search for projects (default: 3)
- `-m <min_files>`: Minimum files to consider directory a project (default: 5)
- `-i <interactive>`: Use interactive TUI menu: 0=no, 1=yes (default: 1)
- `-c <use_config>`: Try saved configs first: 0=no, 1=yes (default: 1)
- `-k <skip_existing>`: Skip existing outputs: 0=no, 1=yes (default: 1)
- `-p <include_pattern>`: Pattern that indicates project directory (can be used multiple times)
- `-x <exclude_pattern>`: Pattern to exclude from search (can be used multiple times)
- `-v, --verbose`: Enable verbose output
- `-h, --help`: Display help message

**Project Detection:**
A directory is considered a project if it contains:
- At least the minimum number of files (default: 5), AND
- One or more project indicator files/patterns

**Default Project Indicators:**
- `.git` (Git repository)
- `package.json` (Node.js)
- `requirements.txt` (Python)
- `Cargo.toml` (Rust)
- `pom.xml` (Java/Maven)
- `composer.json` (PHP)
- `Gemfile` (Ruby)
- `go.mod` (Go)
- `Makefile` (Make)
- `CMakeLists.txt` (CMake)
- `setup.py` (Python)
- `*.sln`, `*.vcxproj` (Visual Studio)

**Output Structure:**
```
<output_directory>/
├── project1/
│   ├── project1.json (or .csv)
│   └── metadata.json
├── project2/
│   ├── project2.json
│   └── metadata.json
└── batch_report.json
```

## 📚 Examples

**1. Including Multiple File Types:**

```bash
code-packager -t ~/myproject -o code.json -i .py -i .js -s 2048 -z 1
```

This command packages the code from the `~/myproject` directory, including only Python (`.py`) and JavaScript (`.js`) files. It limits the file size to 2MB and zips the output file (`code.json`).

**2. Excluding Specific File Types (Without Inclusion):**

```bash
code-packager -t ~/myproject -o code.json -e .txt -e .md -d 1
```

This command packages the code from the `~/myproject` directory, excluding text (`.txt`) and markdown (`.md`) files. It includes dot files and folders and does not zip the output file.

**3. Packaging All File Types:**

```bash
code-packager -t ~/myproject -o code.json -s 10240 -g 0
```

This command packages all files from the `~/myproject` directory, regardless of file type. It limits the file size to 10MB, ignores the `.gitignore` file, and does not zip the output file.

**4. Specifying Output Directory:**

```bash
code-packager -t ~/myproject -o ~/output_dir -s 10240 -g 0
```

This command packages all files from the `~/myproject` directory, regardless of file type. It limits the file size to 10MB, ignores the `.gitignore` file, and saves the output JSON file as `~/output_dir/myproject.json`.

**5. Limiting Search Depth:**

```bash
code-packager -t ~/myproject -o code.json -m 2
```

This command packages the code from the `~/myproject` directory, including files up to a depth of 2 levels.

**6. Unpacking a JSON File with Confirmation:**

```bash
code-unpackager -j code.json -d ~/restored_project
```

This command restores the directory structure and files from `code.json` into the `~/restored_project` directory, asking for confirmation before proceeding.

**7. Unpacking a JSON File Silently:**

```bash
code-unpackager -j code.json -d ~/restored_project -s
```

This command restores the directory structure and files from `code.json` into the `~/restored_project` directory without asking for confirmation.

**8. Including and Excluding Specific Files:**

```bash
code-packager -t ~/myproject -o code.json -I README -I LICENSE -E .gitignore
```

This command packages the code from the `~/myproject` directory, specifically including `README` and `LICENSE` files while excluding `.gitignore`.

**9. Combining Extensions and Filenames:**

```bash
code-packager -t ~/myproject -o code.json -i .py -i .js -I README -E TODO.md
```

This command packages Python and JavaScript files along with the `README` file, but excludes `TODO.md`.

**10. Interactive TUI Step-by-Step Workflow:**

```bash
code-packager -S tui -o code.json
```

This command opens an interactive gum-based step-by-step workflow to:

1. Select the base directory to package
2. Choose which top-level directories to include (e.g., `src`, `lib`, `docs`)
3. Optionally exclude specific subdirectories
4. Select file types to exclude (e.g., `.log`, `.tmp`, `.cache`)
5. Set the output filename

**11. Interactive GUI File Selection with Multi-Select:**

```bash
code-packager -S gui -o code.json
```

This command opens a graphical yad-based file browser to select the target directory, then opens a file selection dialog where you can select multiple files using Ctrl+click.

**12. Vector Store Optimized Format:**

```bash
code-packager -t ~/myproject -o code.json -V
```

This command packages the code using vector store optimized format where filename information is embedded directly in the content for better chunking by vector databases.

**13. Combined Interactive Selection and Vector Format:**

```bash
code-packager -S tui -V
```

This command combines interactive TUI selection with vector store optimized format.

**14. CSV Format Output:**

```bash
code-packager-csv -t ~/myproject -o output.csv -i .py -i .js
```

This command packages Python and JavaScript files into CSV format for spreadsheet analysis.

**15. Advanced Chunking for AI Platforms:**

```bash
code-packager-chunked -t ~/myproject -o chunks.csv -P 4000 -C 800
```

This command creates intelligent code chunks with 4000-character parent chunks and 800-character child chunks, optimized for dify.ai and vector databases.

**16. Interactive Chunked Workflow:**

```bash
code-packager-chunked -S tui
```

This command opens an interactive workflow for chunked packaging, allowing you to configure chunk sizes and filtering options step-by-step.

**17. Batch Process Multiple Projects:**

```bash
code-packager-batch -s ~/workspace -o ~/packaged-projects
```

This command recursively discovers and processes all projects in `~/workspace`, creating JSON packages for each project in `~/packaged-projects`.

**18. Batch Processing with CSV Format:**

```bash
code-packager-batch -s ~/repositories -o ~/outputs -t csv -i 0
```

This command processes all projects using CSV format without interactive prompts for each project.

**19. Advanced Batch Processing:**

```bash
code-packager-batch -s ~/code -o ~/results -t chunked -d 5 -p 'setup.cfg' -x 'node_modules' -v
```

This command searches up to 5 levels deep, includes custom project indicator `setup.cfg`, excludes `node_modules` directories, uses chunked format, and provides verbose output.

**20. Resume Interrupted Batch Processing:**

```bash
code-packager-batch -s ~/workspace -o ~/packaged-projects -k 1
```

This command skips projects that already have output files, allowing you to resume an interrupted batch operation.

### Example Output

The resulting JSON output may look similar to the following structure:

```json
{
  "files": [
    {
      "filename": "main.py",
      "content": "from utils.data_loader import load_data\n\nfile_path = 'data/sample.csv'\ndata = load_data(file_path)\nprint(data.head())\n",
      "path": "/"
    },
    {
      "filename": "sample.csv",
      "content": "name, age, city\nAlice, 30, New York\nBob, 25, Los Angeles\nCharlie, 35, Chicago\n",
      "path": "/data/"
    },
    {
      "filename": "__init__.py",
      "content": "class Example:\n    def __init__(this):\n        this.data = []\n\n    def add_data(this, new_data):\n        this.data.append(new_data)\n",
      "path": "/utils/"
    },
    {
      "filename": "data_loader.py",
      "content": "import pandas as pd\n\ndef load_data(file_path):\n    data = pd.read_csv(file_path)\n    return data\n",
      "path": "/utils/"
    },
    {
      "filename": "model.py",
      "content": "class Model:\n    def __init__(this):\n        this.weights = {}\n\n    def train(this, data):\n        # Training logic here\n        pass\n",
      "path": "/utils/"
    }
  ]
}
```

#### Vector Store Optimized Format (with `-V` flag)

When using the vector store optimized format, the JSON structure embeds filename information directly in the content:

```json
{
  "files": [
    {
      "content": "File: /main.py\n\nfrom utils.data_loader import load_data\n\nfile_path = 'data/sample.csv'\ndata = load_data(file_path)\nprint(data.head())\n",
      "metadata": {
        "filename": "main.py",
        "path": "/",
        "full_path": "/main.py"
      }
    },
    {
      "content": "File: /utils/data_loader.py\n\nimport pandas as pd\n\ndef load_data(file_path):\n    data = pd.read_csv(file_path)\n    return data\n",
      "metadata": {
        "filename": "data_loader.py",
        "path": "/utils/",
        "full_path": "/utils/data_loader.py"
      }
    }
  ]
}
```

This format ensures that when content is chunked by vector stores, each chunk retains the filename context.

#### CSV Format Output (from `code-packager-csv`)

The CSV format provides a tabular structure that's easy to import into spreadsheets and databases:

```csv
filename,path,full_path,content,is_binary
main.py,/,/main.py,"from utils.data_loader import load_data

file_path = 'data/sample.csv'
data = load_data(file_path)
print(data.head())
",false
data_loader.py,/utils/,/utils/data_loader.py,"import pandas as pd

def load_data(file_path):
    data = pd.read_csv(file_path)
    return data
",false
```

#### Chunked Format Output (from `code-packager-chunked`)

The chunked format creates parent-child relationships optimized for AI platforms like dify.ai:

```csv
parent_id,parent_content,child_id,child_content,filename,path,is_binary
main.py_p1,"from utils.data_loader import load_data

file_path = 'data/sample.csv'
data = load_data(file_path)
print(data.head())
",main.py_c1,"from utils.data_loader import load_data

file_path = 'data/sample.csv'",main.py,/,false
main.py_p1,"from utils.data_loader import load_data

file_path = 'data/sample.csv'
data = load_data(file_path)
print(data.head())
",main.py_c2,"data = load_data(file_path)
print(data.head())
",main.py,/,false
```

This format allows AI platforms to:

- Process large files in manageable chunks
- Maintain context relationships between chunks
- Optimize for vector database storage and retrieval
- Support semantic search across code segments

### File/Directory Structure Example

The script will also print a list of files and directories that were processed, similar to this:

```
File/Directory Structure:
./main.py
./data/sample.csv
./utils/__init__.py
./utils/data_loader.py
./utils/model.py
```

## 🔧 Troubleshooting

*Note: The following troubleshooting advice applies to all variants of the code-packager tools (`code-packager`, `code-packager-csv`, and `code-packager-chunked`).*

#### Changes to `.gitignore` not taking effect

If you find that changes made to your `.gitignore` file are not being respected (e.g., files that should be ignored are still being processed), you may need to clear your Git cache. This issue can occur because Git continues to track files that were previously committed before they were added to `.gitignore`.

To resolve this issue, you can use the following commands to clear the Git cache:

```bash
# Navigate to your repository root
cd path/to/your/repository

# Remove cached files from the index
git rm -r --cached .

# Re-add all the files to the index
git add .

# Commit the changes to your repository
git commit -m "Cleared cache to respect .gitignore changes"
```

#### Handling of binary files

All code-packager variants do not include the contents of binary files (e.g., images, executables) in the resulting output files. As a result:

- **JSON format**: Binary files appear with `"content": null`
- **CSV format**: Binary files have `is_binary: true` and content shows `[Binary file - content not included]`
- **Chunked format**: Binary files are marked as binary and create single-chunk entries
- **Unpacking**: Binary files will be restored with 0 bytes

This is by design to ensure efficient packaging and to focus on text-based content that is more relevant for analysis by language models.

If you want to exclude certain types of files (e.g., binary files) from being included altogether, you can use the `-e <exclude_extension>` option with any of the code-packager variants.

For example, to exclude image files from any variant, you can use:

```bash
# JSON format
code-packager -t ~/myproject -o code.json -e .png -e .jpg

# CSV format  
code-packager-csv -t ~/myproject -o code.csv -e .png -e .jpg

# Chunked format
code-packager-chunked -t ~/myproject -o chunks.csv -e .png -e .jpg
```

These commands will exclude `.png` and `.jpg` files from the output.

## 🙏 Acknowledgements

This project was inspired by Simon Willison's [`files-to-prompt`](https://github.com/simonw/files-to-prompt). While `files-to-prompt` uses horizontal bars (`---`) to separate file paths and their contents, **Code Packager and Unpackager for LLMs** takes a different approach by utilizing structured formats (JSON/CSV). This choice makes the resulting text more structured, unambiguous, and versatile, allowing for enhanced interpretation and interaction with Language Models (LLMs).

The expanded toolkit now includes multiple output formats and advanced chunking capabilities, offering developers a comprehensive solution for code-to-AI workflows that goes far beyond the original inspiration.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit pull requests or open issues for any bugs or feature requests.

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for details.

## 👨‍💻 Original Author

**[Yoichiro Hasebe](https://github.com/yohasebe)** (<yohasebe@gmail.com>)

*Creator of the original Code Packager and Unpackager for LLMs project*
