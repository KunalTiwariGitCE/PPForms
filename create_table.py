#!/usr/bin/env python3
"""
Script to create a sample Product table in Power Platform using PAC CLI
"""

import subprocess
import json
import sys

def run_command(command):
    """Run a shell command and return the result"""
    print(f"Running: {command}")
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"Error: {result.stderr}")
        return None
    return result.stdout

def main():
    # Get organization info
    print("Getting organization information...")
    org_info = run_command("pac org who")
    if not org_info:
        print("Failed to get organization info")
        sys.exit(1)

    print(org_info)

    # Note: Creating tables via PAC CLI requires using the Dataverse Web API
    # For now, we'll provide the PowerShell commands that can be used

    print("\n" + "="*80)
    print("To create the table, you can use the Power Platform Maker Portal:")
    print("="*80)
    print("\n1. Go to: https://make.powerapps.com")
    print("2. Select your environment: 'KT - Dev'")
    print("3. Go to 'Tables' -> 'New table' -> 'New table'")
    print("4. Create a table with:")
    print("   - Display Name: Product")
    print("   - Plural Name: Products")
    print("   - Add columns:")
    print("     * Name (Text) - Primary column")
    print("     * Price (Currency)")
    print("     * Description (Multiple lines of text)")
    print("5. Save the table")
    print("\n" + "="*80)

    print("\nAlternatively, here are the pac commands you can use:")
    print("="*80)
    print("\n# This approach requires creating a plugin or using the Web API directly")
    print("# The PAC CLI doesn't have a direct 'create table' command")
    print("\nFor programmatic creation, you would need to:")
    print("1. Use the Dataverse Web API")
    print("2. Or use Power Platform Build Tools in Azure DevOps")
    print("3. Or use the Power Apps PowerShell module")

if __name__ == "__main__":
    main()