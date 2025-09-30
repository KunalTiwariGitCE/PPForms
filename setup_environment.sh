#!/bin/bash

# Script to set up Power Platform environment with sample table and app

echo "=========================================="
echo "Power Platform Environment Setup"
echo "=========================================="
echo ""

# Check if pac CLI is available
if ! command -v pac &> /dev/null; then
    echo "Error: PAC CLI is not installed"
    exit 1
fi

# Check authentication
echo "Checking authentication..."
pac org who

echo ""
echo "=========================================="
echo "Setup Instructions"
echo "=========================================="
echo ""
echo "Unfortunately, the PAC CLI doesn't have direct commands to create"
echo "tables via command line. However, you have several options:"
echo ""
echo "Option 1: Use Power Platform Maker Portal (Recommended)"
echo "---------------------------------------------------------"
echo "1. Visit: https://make.powerapps.com"
echo "2. Select environment: 'KT - Dev'"
echo "3. Navigate to: Tables > New table"
echo "4. Create a table named 'Product' with columns:"
echo "   - Name (Text, Primary)"
echo "   - Price (Currency)"
echo "   - Description (Multiple lines of text)"
echo "5. Create a model-driven app:"
echo "   - Go to: Apps > New app > Model-driven app"
echo "   - Add the Product table"
echo "   - Publish the app"
echo ""
echo "Option 2: Use this solution project"
echo "------------------------------------"
echo "We've created a solution project structure in:"
echo "  ./src/"
echo ""
echo "To deploy it (after fixing XML structure issues):"
echo "  pac solution import --path PPForms.zip"
echo ""
echo "Option 3: Use Dataverse Web API"
echo "--------------------------------"
echo "You can create tables programmatically using:"
echo "  - REST API calls to Dataverse Web API"
echo "  - Power Apps PowerShell module"
echo "  - .NET SDK for Dataverse"
echo ""
echo "=========================================="
echo ""

echo "Current solution files created:"
find src -type f -name "*.xml"