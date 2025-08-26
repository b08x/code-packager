#!/bin/bash

# Test script for code-unpackager

# Function to run the code-unpackager with given options and compare the output
run_test() {
    local test_name="$1"
    local options="$2"
    local expected_output_pattern="$3"

    echo "Running test: $test_name"

    output=$(./code-unpackager $options 2>&1)

    if [[ "$output" =~ $expected_output_pattern ]]; then
        echo "Test passed: $test_name"
    else
        echo "Test failed: $test_name"
        echo "Expected output pattern:"
        echo "$expected_output_pattern"
        echo "Actual output:"
        echo "$output"
    fi
    echo "------------------------"
}

# Function to create a test JSON file (legacy format)
create_test_json() {
    cat << EOF > test.json
{
  "files": [
    {
      "filename": "test.txt",
      "content": "This is a test file.",
      "path": "/"
    },
    {
      "filename": "binary.bin",
      "content": null,
      "path": "/subdir/"
    },
    {
      "filename": "README",
      "content": "This is a README file without extension.",
      "path": "/"
    },
    {
      "filename": "LICENSE",
      "content": "This is a LICENSE file without extension.",
      "path": "/"
    }
  ]
}
EOF
}

# Function to create a test JSON file (vector store format)
create_vector_store_json() {
    cat << EOF > test_vector.json
{
  "files": [
    {
      "content": "File: /test.txt\n\nThis is a test file for vector store format.",
      "metadata": {
        "filename": "test.txt",
        "path": "/",
        "full_path": "/test.txt"
      }
    },
    {
      "content": "File: /subdir/binary.bin\n\n[Binary file - content not included]",
      "metadata": {
        "filename": "binary.bin",
        "path": "/subdir/",
        "full_path": "/subdir/binary.bin"
      }
    }
  ]
}
EOF
}

# Function to cleanup test files and directories
cleanup() {
    rm -f test.json test_vector.json invalid.json notebook_test.json
    rm -rf test_output test_vector_output notebook_output
}

# Test case 1: Basic functionality
test_basic_functionality() {
    create_test_json
    local options="-j test.json -d test_output -s"
    local expected_output_pattern="Folder structure restored to: test_output"
    run_test "Basic functionality" "$options" "$expected_output_pattern"

    # Verify the created files
    if [[ -f "test_output/test.txt" && -f "test_output/subdir/binary.bin" && \
          -f "test_output/README" && -f "test_output/LICENSE" ]]; then
        echo "File structure verified."
    else
        echo "File structure verification failed."
    fi

    # Verify file contents
    if [[ "$(cat test_output/test.txt)" == "This is a test file." && \
          "$(cat test_output/README)" == "This is a README file without extension." && \
          "$(cat test_output/LICENSE)" == "This is a LICENSE file without extension." ]]; then
        echo "File contents verified."
    else
        echo "File contents verification failed."
    fi

    # Display the contents of the test_output directory
    echo "Contents of test_output directory:"
    ls -R test_output
}

# Test case 2: Missing required parameters
test_missing_parameters() {
    local options=""
    local expected_output_pattern="Error: Both JSON file path and destination directory are required."
    run_test "Missing required parameters" "$options" "$expected_output_pattern"
}

# Test case 3: Non-existent JSON file
test_nonexistent_json() {
    local options="-j nonexistent.json -d test_output"
    local expected_output_pattern="Error: JSON file 'nonexistent.json' does not exist."
    run_test "Non-existent JSON file" "$options" "$expected_output_pattern"
}

# Test case 4: Displaying version information
test_version_info() {
    local options="-v"
    local expected_output_pattern="Code Unpackager for Language Models - Version"
    run_test "Displaying version information" "$options" "$expected_output_pattern"
}

# Test case 5: Displaying help information
test_help_info() {
    local options="-h"
    local expected_output_pattern="Usage: ./code-unpackager -j <json_file> -d <destination_directory> \[options\]"
    run_test "Displaying help information" "$options" "$expected_output_pattern"
}

# Test case 6: Invalid JSON structure
test_invalid_json() {
    echo "Invalid JSON" > invalid.json
    local options="-j invalid.json -d test_output"
    local expected_output_pattern="Error: JSON structure is invalid or does not contain any files."
    run_test "Invalid JSON structure" "$options" "$expected_output_pattern"
    rm -f invalid.json
}

# Test case 7: Vector store format unpacking
test_vector_store_format() {
    create_vector_store_json
    local options="-j test_vector.json -d test_vector_output -s"
    local expected_output_pattern="Folder structure restored to: test_vector_output"
    run_test "Vector store format unpacking" "$options" "$expected_output_pattern"

    # Verify the created files
    if [[ -f "test_vector_output/test.txt" && -f "test_vector_output/subdir/binary.bin" ]]; then
        echo "Vector store file structure verified."
    else
        echo "Vector store file structure verification failed."
    fi

    # Verify file contents (should extract original content)
    if [[ "$(cat test_vector_output/test.txt)" == "This is a test file for vector store format." ]]; then
        echo "Vector store file contents verified."
    else
        echo "Vector store file contents verification failed."
        echo "Expected: 'This is a test file for vector store format.'"
        echo "Actual: '$(cat test_vector_output/test.txt)'"
    fi

    # Display the contents of the test_vector_output directory
    echo "Contents of test_vector_output directory:"
    ls -R test_vector_output
}

# Test case 8: Unpacking a converted Jupyter Notebook
test_unpacking_converted_notebook() {
    cat << EOF > notebook_test.json
{
  "files": [
    {
      "filename": "test.md",
      "content": "# Test Notebook",
      "path": "/"
    }
  ]
}
EOF
    local options="-j notebook_test.json -d notebook_output -s"
    local expected_output_pattern="Folder structure restored to: notebook_output"
    run_test "Unpacking a converted Jupyter Notebook" "$options" "$expected_output_pattern"

    # Verify the created file
    if [[ -f "notebook_output/test.md" ]]; then
        echo "File structure for converted notebook verified."
    else
        echo "File structure verification for converted notebook failed."
    fi

    # Verify file contents
    if [[ "$(cat notebook_output/test.md)" == "# Test Notebook" ]]; then
        echo "File contents for converted notebook verified."
    else
        echo "File contents verification for converted notebook failed."
    fi

    rm -rf notebook_output
    rm -f notebook_test.json
}

# Clean up before running tests
cleanup

# Run all test cases
test_basic_functionality
test_missing_parameters
test_nonexistent_json
test_version_info
test_help_info
test_invalid_json
test_vector_store_format
test_unpacking_converted_notebook

# Clean up after running tests
cleanup

echo "Tests completed. All test files and directories have been removed."