# GitHub Setup Instructions for Power Platform Solution

## Step 1: Create GitHub Repository

You have two options:

### Option A: Using GitHub CLI (Recommended)

1. **Authenticate with GitHub:**
   ```bash
   gh auth login
   ```
   - Select "GitHub.com"
   - Select "HTTPS" as your preferred protocol
   - Authenticate with your browser or paste an authentication token

2. **Create and push the repository:**
   ```bash
   gh repo create PPForms --public --source=. --remote=origin --description="Power Platform Product Management Solution - Custom table with model-driven app" --push
   ```

### Option B: Using GitHub Web Interface

1. **Go to GitHub** and create a new repository:
   - Visit: https://github.com/new
   - Repository name: `PPForms`
   - Description: `Power Platform Product Management Solution - Custom table with model-driven app`
   - Choose Public or Private
   - **DO NOT** initialize with README, .gitignore, or license (we already have these)
   - Click "Create repository"

2. **Push your local repository:**
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/PPForms.git
   git branch -M main
   git push -u origin main
   ```

## Step 2: Connect Power Platform to GitHub

Once your repository is on GitHub, follow these steps to connect it to Power Platform:

### Prerequisites
- Power Platform environment (you're already connected to "KT - Dev")
- GitHub account with the repository created
- Maker permissions in Power Platform

### Connection Steps

1. **Navigate to Power Platform Maker Portal:**
   - Go to: https://make.powerapps.com
   - Select your environment: **KT - Dev**

2. **Open Solutions:**
   - Click **Solutions** in the left navigation

3. **Import from Source Control:**

   **Method 1: Using Power Platform CLI**
   ```bash
   # Make sure you're authenticated
   pac auth list

   # Set up source control (from your solution directory)
   pac solution sync --packagetype Both
   ```

   **Method 2: Using Power Platform Portal**
   - In Solutions, click the dropdown next to **Import**
   - Select **Import from source control**
   - Choose **GitHub** as the source control provider
   - Click **Authenticate** and sign in to your GitHub account
   - Select your repository: **PPForms**
   - Select the branch: **main** (or **master**)
   - Choose the solution folder: `src`
   - Click **Import**

4. **Configure GitHub Actions (Optional but Recommended):**

   Power Platform can automatically sync changes between your environment and GitHub.

   - In your solution, click on the **...** menu
   - Select **Set up GitHub Actions**
   - Follow the wizard to configure:
     - Build validation on PR
     - Deploy to environment on merge
     - Export solution on change

## Step 3: Manual Import (Alternative)

If you prefer to manually import the solution without GitHub integration:

1. **Pack the solution locally:**
   ```bash
   cd /Users/kunaltiwari/Claude/ClaudeCode/PPForms
   pac solution pack --zipfile ProductManagement.zip --folder src --packagetype Unmanaged
   ```

2. **Import via Portal:**
   - Go to https://make.powerapps.com
   - Select **Solutions** → **Import solution**
   - Click **Browse** and select `ProductManagement.zip`
   - Click **Next** → **Import**
   - Wait for import to complete

3. **Create Model-Driven App (if not included):**
   - After import, go to **Apps** → **New app** → **Model-driven app**
   - Name: "Product Management"
   - Add the **Product** table
   - Publish the app

## Repository Structure

```
PPForms/
├── .gitignore              # Git ignore rules
├── README.md               # Project documentation
├── PPForms.cdsproj         # Solution project file
├── GITHUB_SETUP.md         # This file
└── src/                    # Solution source files
    ├── AppModules/         # Model-driven apps
    ├── Entities/           # Custom tables
    │   └── cc_product/     # Product table
    │       ├── Entity.xml  # Table definition
    │       ├── FormXml/    # Forms
    │       └── SavedQueries/ # Views
    └── Other/              # Solution metadata
        ├── Solution.xml
        ├── Customizations.xml
        └── Relationships.xml
```

## What's Included in This Solution

### Product Table (cc_product)
- **Fields:**
  - Name (Text, Primary field)
  - Price (Currency)
  - Description (Multiple lines of text)
  - All standard system fields (Owner, Created By, Modified By, Status, etc.)

### Forms
- Main form: "Product Information" - displays Name, Price, Description, and Owner fields

### Views
- Active Products (default view)
- Inactive Products

### Model-Driven App
- Product Management app definition included

## Troubleshooting

### Import Errors

If you encounter import errors:

1. **Check Publisher:**
   - Ensure the publisher "ClaudeCode" with prefix "cc" exists in your environment
   - Or create it in Power Platform: Settings → Customizations → Publishers

2. **Dependencies:**
   - The solution has no external dependencies
   - Should import cleanly into any environment

3. **Permissions:**
   - Ensure you have System Customizer or System Administrator role

### GitHub Connection Issues

- Make sure your GitHub account has access to the repository
- Verify you've granted Power Platform OAuth permissions to access GitHub
- Check that the repository branch and folder path are correct

## Next Steps

After successful import:

1. **Verify the table:** Navigate to Tables → search for "Product"
2. **Test the app:** Go to Apps → find "Product Management" → Play
3. **Create sample data:** Create a few product records
4. **Customize:** Add more fields, forms, or business rules as needed

## Resources

- [Power Platform ALM Guide](https://docs.microsoft.com/power-platform/alm/)
- [GitHub Actions for Power Platform](https://github.com/marketplace/actions/powerplatform-actions)
- [PAC CLI Documentation](https://docs.microsoft.com/power-platform/developer/cli/introduction)
- [Solution Import Best Practices](https://docs.microsoft.com/power-platform/alm/solution-import-best-practices)

## Support

If you encounter any issues:
- Check the Power Platform import logs
- Review GitHub repository permissions
- Verify PAC CLI authentication: `pac auth list`
- Ensure solution files are not corrupted: `pac solution pack` locally first