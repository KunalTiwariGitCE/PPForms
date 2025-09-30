# Power Platform Forms Project

This project demonstrates how to create a custom table and model-driven app in Power Platform using Claude Code.

## Environment Information
- **Environment**: KT - Dev
- **Organization URL**: https://org0cd25106.crm6.dynamics.com/
- **User**: kunal.tiwari@snownimbus.com

## What We've Created

1. **Solution Project Structure**: A Power Platform solution project initialized with PAC CLI
2. **Entity Definition**: XML definition for a custom "Product" table with fields:
   - Name (Text - Primary field)
   - Price (Currency)
   - Description (Multiple lines of text)

## Next Steps to Complete Setup

Since the PAC CLI has limited capabilities for creating tables directly, please follow these steps in the Power Platform Maker Portal:

### Step 1: Create the Product Table

1. Navigate to [Power Apps Maker Portal](https://make.powerapps.com)
2. Select your environment: **KT - Dev**
3. Click on **Tables** in the left navigation
4. Click **+ New table** → **New table**
5. Configure the table:
   - **Display name**: Product
   - **Plural name**: Products
   - **Description**: Sample product table for demo
   - Click **Save**

### Step 2: Add Custom Fields

After creating the table, add these columns:

1. **Price** (Currency)
   - Data type: Currency
   - Display name: Price
   - Required: Optional
   - Minimum value: 0
   - Maximum value: 1,000,000,000

2. **Description** (Multiple lines of text)
   - Data type: Multiple lines of text
   - Display name: Description
   - Maximum character count: 2000
   - Required: Optional

### Step 3: Create a Model-Driven App

1. In the Maker Portal, click **Apps** in the left navigation
2. Click **+ New app** → **Model-driven app**
3. Enter app details:
   - **Name**: Product Management App
   - **Description**: Sample model-driven app for managing products
4. Click **Create**
5. In the app designer:
   - Click **+ Add page**
   - Select **Dataverse table**
   - Select the **Product** table
   - Check: Forms, Views, Charts (as needed)
   - Click **Add**
6. Click **Save**
7. Click **Publish**

### Step 4: Test Your App

1. Click **Play** to open the app
2. You should see your Product table
3. Click **+ New** to create a new product record
4. Fill in the form with:
   - Name: Sample Product
   - Price: 99.99
   - Description: This is a sample product
5. Click **Save & Close**

## Alternative: API-Based Creation

If you prefer programmatic creation, you can use the Dataverse Web API:

```bash
# Get an access token (this would need additional OAuth setup)
# Then use curl to create the table:

curl -X POST https://org0cd25106.crm6.dynamics.com/api/data/v9.2/EntityDefinitions \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "SchemaName": "cc_Product",
    "DisplayName": {"LocalizedLabels": [{"Label": "Product", "LanguageCode": 1033}]},
    "DisplayCollectionName": {"LocalizedLabels": [{"Label": "Products", "LanguageCode": 1033}]},
    "OwnershipType": "UserOwned",
    "IsActivity": false,
    "HasNotes": true,
    "HasActivities": true
  }'
```

## Project Structure

```
PPForms/
├── src/
│   ├── Entities/
│   │   └── cc_product/
│   │       └── Entity.xml
│   └── Other/
│       ├── Customizations.xml
│       ├── Relationships.xml
│       └── Solution.xml
├── PPForms.cdsproj
└── README.md
```

## Commands Used

```bash
# Initialize solution project
pac solution init --publisher-name "ClaudeCode" --publisher-prefix "cc"

# Check authentication
pac auth list

# View current organization
pac org who

# Pack solution (when XML structure is complete)
pac solution pack --zipfile PPForms.zip --folder src

# Import solution (after packing)
pac solution import --path PPForms.zip
```

## Resources

- [Power Platform CLI Documentation](https://docs.microsoft.com/power-platform/developer/cli/introduction)
- [Create tables using Power Apps](https://docs.microsoft.com/power-apps/maker/data-platform/create-edit-entities-portal)
- [Create a model-driven app](https://docs.microsoft.com/power-apps/maker/model-driven-apps/build-first-model-driven-app)
- [Dataverse Web API](https://docs.microsoft.com/power-apps/developer/data-platform/webapi/overview)

## Notes

- The solution project structure has been created but manual table creation in the Maker Portal is recommended for simplicity
- The XML entity definition in `src/Entities/cc_product/Entity.xml` can serve as a reference
- Once the table is created in the portal, you can add it to this solution and export it for version control