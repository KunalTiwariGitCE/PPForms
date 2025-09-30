# Power Platform Source Control Setup Guide

## Important Note

Power Platform's **native source control integration** in the Maker Portal works with **Azure DevOps (Azure Repos)** only, NOT directly with GitHub.

Your repository is currently on GitHub at: https://github.com/KunalTiwariGitCE/PPForms

You have **three options** to proceed:

---

## Option 1: Azure DevOps (Native Power Platform Integration) ⭐ RECOMMENDED

This gives you the best integration with Power Platform.

### Step 1: Set Up Azure DevOps

1. **Create Azure DevOps Organization** (if you don't have one):
   - Go to https://dev.azure.com
   - Click "Start free"
   - Sign in with your Microsoft account (use same account as Power Platform)
   - Create an organization (e.g., "KunalTiwari" or your company name)

2. **Create a Project:**
   - Click "New project"
   - Name: `PPForms` or `PowerPlatformSolutions`
   - Visibility: Private (recommended) or Public
   - Click "Create"

3. **Initialize Azure Repo:**
   - Go to **Repos** → **Files**
   - Click "Initialize" with a README (or leave empty)

### Step 2: Push Your Solution to Azure Repos

```bash
cd /Users/kunaltiwari/Claude/ClaudeCode/PPForms

# Add Azure DevOps as a remote
git remote add azure https://YOUR_ORG@dev.azure.com/YOUR_ORG/YOUR_PROJECT/_git/PPForms

# Push to Azure DevOps
git push azure master
```

**Example:**
```bash
# If your org is "kunaltiwari" and project is "PPForms"
git remote add azure https://kunaltiwari@dev.azure.com/kunaltiwari/PPForms/_git/PPForms
git push azure master
```

### Step 3: Connect Power Platform to Azure DevOps

1. **Go to Power Platform:**
   - Navigate to https://make.powerapps.com
   - Select environment: **KT - Dev**
   - Go to **Solutions**

2. **Connect to Source Control:**
   - Click on your solution (or create new one for import)
   - Click **...** (More actions) → **Source control** → **Connect to Git**

   OR

   - **Settings** → **Source control** → **Connect**

3. **Configure Connection:**
   - Select **Azure DevOps**
   - Organization: Your Azure DevOps org
   - Project: Your project name
   - Repository: PPForms
   - Branch: master
   - Folder: `src`

4. **Commit Settings:**
   - Solution folder: `src`
   - Click **Connect**

### Step 4: Usage

- **Export to Git:** Changes in Power Platform will sync to Azure DevOps
- **Import from Git:** Pull latest changes from Azure DevOps to Power Platform
- **Branching:** Create feature branches in Azure DevOps for development

---

## Option 2: GitHub + Azure DevOps Bridge (Keep GitHub as Primary)

If you want to keep GitHub as your primary repository and use Azure DevOps just for Power Platform integration.

### Step 1: Set Up Azure DevOps (same as Option 1)

Follow Step 1 from Option 1 above.

### Step 2: Set Up Azure Pipelines to Sync with GitHub

1. **In Azure DevOps**, go to **Pipelines** → **Create Pipeline**
2. Select **GitHub** as source
3. Authenticate and select your repository: `KunalTiwariGitCE/PPForms`
4. Configure pipeline to sync both ways:
   - GitHub → Azure Repos (on commit)
   - Azure Repos → GitHub (on Power Platform export)

### Step 3: Mirror Repository

You can also manually keep both in sync:

```bash
# Keep both remotes
git remote -v
# Should show both 'origin' (GitHub) and 'azure' (Azure DevOps)

# Push to both
git push origin master
git push azure master
```

Or create an alias:
```bash
# Add to your ~/.gitconfig
git config alias.pushall '!git push origin master && git push azure master'

# Now you can use:
git pushall
```

---

## Option 3: GitHub with Power Platform GitHub Actions (Manual ALM)

Use GitHub for version control and automate solution deployment with GitHub Actions.

### Pros:
- ✅ Keep everything in GitHub
- ✅ Full CI/CD control
- ✅ No Azure DevOps needed

### Cons:
- ❌ No native Power Platform portal integration
- ❌ Must use PAC CLI for imports/exports
- ❌ Manual workflow setup

### Setup Steps:

1. **Create GitHub Actions Workflow:**

Create `.github/workflows/deploy-solution.yml`:

```yaml
name: Deploy Power Platform Solution

on:
  push:
    branches: [ master, main ]
  pull_request:
    branches: [ master, main ]
  workflow_dispatch:

jobs:
  build-and-deploy:
    runs-on: windows-latest

    steps:
    - uses: actions/checkout@v3

    - name: Setup Power Platform CLI
      uses: microsoft/powerplatform-actions/actions-install@v1

    - name: Authenticate to Power Platform
      uses: microsoft/powerplatform-actions/authenticate@v1
      with:
        environment-url: 'https://org0cd25106.crm6.dynamics.com/'
        app-id: ${{ secrets.POWER_PLATFORM_CLIENT_ID }}
        client-secret: ${{ secrets.POWER_PLATFORM_CLIENT_SECRET }}
        tenant-id: ${{ secrets.POWER_PLATFORM_TENANT_ID }}

    - name: Pack Solution
      run: |
        pac solution pack --zipfile ProductManagement.zip --folder src --packagetype Unmanaged

    - name: Import Solution
      uses: microsoft/powerplatform-actions/import-solution@v1
      with:
        environment-url: 'https://org0cd25106.crm6.dynamics.com/'
        solution-file: ProductManagement.zip
        force-overwrite: true
```

2. **Set Up GitHub Secrets:**
   - Go to your GitHub repo → **Settings** → **Secrets and variables** → **Actions**
   - Add these secrets:
     - `POWER_PLATFORM_CLIENT_ID`
     - `POWER_PLATFORM_CLIENT_SECRET`
     - `POWER_PLATFORM_TENANT_ID`

3. **Create Service Principal in Azure:**
   ```bash
   # Register app in Azure AD
   az ad app create --display-name "GitHub-PowerPlatform-Deploy"
   ```

4. **Manual Operations:**
   ```bash
   # Export from Power Platform
   pac solution export --path ProductManagement.zip --name ProductManagement

   # Unpack to source
   pac solution unpack --zipfile ProductManagement.zip --folder src

   # Commit and push
   git add .
   git commit -m "Update solution"
   git push
   ```

---

## Comparison Table

| Feature | Azure DevOps (Option 1) | GitHub + Azure (Option 2) | GitHub Actions (Option 3) |
|---------|------------------------|---------------------------|--------------------------|
| Native Power Platform Integration | ✅ Yes | ✅ Yes | ❌ No |
| Portal UI for Git Operations | ✅ Yes | ✅ Yes | ❌ No |
| Primary Repository | Azure Repos | GitHub | GitHub |
| Setup Complexity | 🟢 Easy | 🟡 Medium | 🔴 Complex |
| Automatic Sync | ✅ Yes | ⚠️ Requires pipeline | ⚠️ Manual |
| CI/CD | ✅ Azure Pipelines | ✅ Both | ✅ GitHub Actions |
| Cost | Free tier available | Free tier available | Free for public repos |

---

## My Recommendation for You

Based on your requirement to use the native Power Platform integration, I recommend:

### **Option 1: Azure DevOps** (Easiest and Best Integration)

**Why:**
1. Native Power Platform support in the portal UI
2. Seamless bidirectional sync
3. Built-in ALM capabilities
4. Microsoft's recommended approach

**Quick Start:**
```bash
# 1. Create Azure DevOps org and project at dev.azure.com
# 2. Add Azure DevOps remote
git remote add azure https://YOUR_ORG@dev.azure.com/YOUR_ORG/YOUR_PROJECT/_git/PPForms

# 3. Push your code
git push azure master

# 4. Connect in Power Platform portal (Settings → Source Control)
```

You can still keep your GitHub repository for backup or public sharing, and push to both:
```bash
git push origin master  # GitHub
git push azure master   # Azure DevOps
```

---

## Resources

- [Power Platform ALM with Azure DevOps](https://docs.microsoft.com/power-platform/alm/devops-build-tools)
- [Configure Azure DevOps for Power Platform](https://docs.microsoft.com/power-platform/alm/configure-azure-devops)
- [GitHub Actions for Power Platform](https://github.com/marketplace/actions/powerplatform-actions)
- [Power Platform Build Tools](https://docs.microsoft.com/power-platform/alm/devops-build-tools)

---

## Need Help?

Let me know which option you'd like to proceed with, and I can help you:
1. Set up Azure DevOps
2. Configure the GitHub-Azure bridge
3. Set up GitHub Actions workflows

Just tell me your preference!