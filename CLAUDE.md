# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This repository contains two Bash utilities for packaging and unpackaging codebases for interaction with Language Models (LLMs):

- `code-packager`: Converts a directory structure into a structured JSON file containing file contents
- `code-unpackager`: Restores the original directory structure from the JSON file

The tools support extensive filtering options, respect `.gitignore` files, handle binary files appropriately, and can optionally compress the output.

## Development Commands

### Testing
- Run packager tests: `./test-code-packager.sh`
- Run unpackager tests: `./test-code-unpackager.sh`

### Dependencies
The scripts require these system tools:
- `jq` (JSON processing)
- `git` (for .gitignore support)
- `file` (binary file detection)
- `zip` (optional compression)
- `fd` (modern find replacement)
- `fzf` (optional, for TUI file selector)
- `yad` (optional, for GUI file selector)

Install on Debian/Ubuntu: `sudo apt-get install git jq file zip fd-find fzf yad`

### Usage Examples
```bash
# Basic packaging
./code-packager -t ~/myproject -o output.json

# Include specific extensions and files
./code-packager -t ~/myproject -o output.json -i .py -i .js -I README -E .gitignore

# Vector store optimized format (embeds filename in content)
./code-packager -t ~/myproject -o output.json -V

# Use TUI selector (fzf) for interactive file/folder selection with multi-select
./code-packager -S tui -o output.json

# Use GUI selector (yad) for interactive file/folder selection with multi-select
./code-packager -S gui -o output.json

# Unpack with confirmation
./code-unpackager -j output.json -d ~/restored_project

# Unpack silently
./code-unpackager -j output.json -d ~/restored_project -s
```

## Architecture

### code-packager Script
- **File Processing**: Uses `fd` command (modern find replacement) with native filtering for extensions, size, and gitignore
- **Binary Detection**: Leverages the `file` command to identify binary files and excludes their content
- **Git Integration**: Native gitignore support via `fd --no-ignore-vcs` flag
- **JSON Output**: Uses `jq` for structured JSON generation with file metadata (filename, content, path)
- **Vector Store Format**: New `-V` flag creates content-embedded format for better vector store chunking
- **Interactive Selectors**: TUI mode (`-S tui`) uses `fzf` with multi-select (TAB) for cherry-picking files; GUI mode (`-S gui`) uses `yad` multi-select file dialog (Ctrl+click)
- **Advanced Filtering**: Native support for file extensions (`-e`), size limits (`--size`), and hidden files (`--hidden`)
- **Parallel Processing**: Exports functions and uses `xargs` with `bash -c` for efficient file processing

### code-unpackager Script
- **JSON Parsing**: Uses `jq` to iterate through the file array and extract metadata
- **Format Detection**: Automatically detects and handles both legacy and vector store JSON formats
- **Content Extraction**: For vector store format, strips filename headers to restore original content
- **Directory Recreation**: Automatically creates the necessary directory structure
- **Content Restoration**: Handles both text content and binary file placeholders (null content)
- **Safety Features**: Includes confirmation prompts and validation of JSON structure

### Test Framework
Both scripts include comprehensive test suites that:
- Test various command-line option combinations
- Validate JSON structure integrity
- Test edge cases (empty directories, invalid options, missing files)
- Include cleanup functions to maintain a clean test environment
- Use pattern matching for output validation

### Key Design Patterns
- **Modular Functions**: Both scripts use functions for dependency checking, help display, and core processing
- **Error Handling**: Comprehensive validation of inputs, file existence, and command execution
- **Cross-Platform Support**: Handles differences between macOS and Linux `stat` commands
- **Security**: Never includes sensitive content; handles binary files safely by excluding content