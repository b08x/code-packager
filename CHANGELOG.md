### Change Log

- [Jun 07, 2025] Enhanced TUI selector with step-by-step workflow and improved directory/file filtering
  - **Complete TUI workflow redesign**: Replaced fzf with gum for a guided step-by-step selection process
    1. Select base directory to package
    2. Choose top-level directories to include (with smart exclusion of unselected directories)
    3. Select subdirectories to exclude within included directories
    4. Choose file types to exclude (with improved extension detection)
    5. Set output filename
  - **Smart filtering logic**: Directory exclusions now take precedence over file type inclusions
  - **Hidden directory support**: When dot files are enabled (`-d 1`), hidden directories (`.git`, `.vscode`, etc.) appear in the selector for explicit inclusion/exclusion
  - **Fixed extension detection**: Improved logic to properly detect file extensions from full file paths
  - **Cleaner output**: Removed `./` prefixes from directory tree display for better readability
  - **Bug fixes**: Resolved issues where selected directories were incorrectly excluded and empty extension patterns caused global exclusions
  - Updated dependency from `fzf` to `gum` for TUI mode
  - Enhanced error handling and user feedback throughout the workflow
- [Nov 10, 2024] Added support for including/excluding specific filenames using -I and -E options
- [Sep 15, 2024] code-unpacker added
- [Jun 22, 2024] max_depth option added
- [May 01, 2024] initial commit
