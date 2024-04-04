# Project types
$projectTypes = @{
    "1" = "Blog-App";
    "2" = "CMS-App";
    "3" = "Chat-App";
    "4" = "E-Store-App";
    # "5" = "Expense-Tracker-App";
    # "6" = "Job-Board-App";
    # "7" = "E-Learning-App";
    # "8" = "Recipe Sharing-App";
    # "9" = "Social-App";
    # "10" = "TMS-App";
    # "11" = "To-Do-App"
}

# Project dependencies
$dependencies = @{
    "To-Dos" = @("express", "mongoose");
    "Blog" = @("express", "mongoose", "multer");
    "E-commerce Store" = @("express", "mongoose", "stripe");
    "Social Media Platform" = @("express", "mongoose", "socket.io");
    "Chat Application" = @("express", "mongoose", "socket.io");
    "Task Management System" = @("express", "mongoose");
    "Recipe Sharing Platform" = @("express", "mongoose", "multer");
    "Job Board Application" = @("express", "mongoose");
    "Expense Tracker" = @("express", "mongoose");
    "Online Learning Platform" = @("express", "mongoose", "multer");
    "CMS" = @("express", "mongoose", "multer")
}

# Function to create the project structure
function Create-ProjectStructure {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ProjectName
    )

    # Create project directory
    New-Item -ItemType Directory -Path $ProjectName | Out-Null

    # Create .env file
    New-Item -ItemType File -Path "$ProjectName/.env" | Out-Null

    # Create public folder and temp folder with .gitkeep file
    New-Item -ItemType Directory -Path "$ProjectName/public" | Out-Null
    New-Item -ItemType Directory -Path "$ProjectName/public/temp" | Out-Null
    New-Item -ItemType File -Path "$ProjectName/public/temp/.gitkeep" | Out-Null

    # Create src folder and subfolders
    New-Item -ItemType Directory -Path "$ProjectName/src" | Out-Null
    New-Item -ItemType Directory -Path "$ProjectName/src/db" | Out-Null
    New-Item -ItemType Directory -Path "$ProjectName/src/middleware" | Out-Null
    New-Item -ItemType Directory -Path "$ProjectName/src/routes" | Out-Null
    New-Item -ItemType Directory -Path "$ProjectName/src/models" | Out-Null
    New-Item -ItemType Directory -Path "$ProjectName/src/utils" | Out-Null

    # Create files in src folder
    New-Item -ItemType File -Path "$ProjectName/src/app.ts" | Out-Null
    New-Item -ItemType File -Path "$ProjectName/src/constants.ts" | Out-Null
    New-Item -ItemType File -Path "$ProjectName/src/index.ts" | Out-Null
}

# Function to install dependencies with the selected package manager
function Install-Dependencies {
    param (
        [Parameter(Mandatory=$true)]
        [string]$PackageManager,
        [string[]]$Dependencies
    )

    Write-Output "`nInstalling dependencies with $PackageManager..."
    & $PackageManager install $Dependencies
}

# Function to add scripts section to package.json
function Add-ScriptsToPackageJson {
    param (
        [Parameter(Mandatory=$true)]
        [string]$PackageManager
    )

    $scripts = @{
        "npm" = @{ "dev" = "node ./src/index.ts" };
        "pnpm" = @{ "dev" = "node ./src/index.ts" };
        "yarn" = @{ "dev" = "node ./src/index.ts" };
        "bun" = @{ "start" = "bun run ./src/index.ts" }
    }

    $packageJsonPath = "package.json"
    $packageJson = Get-Content $packageJsonPath -Raw | ConvertFrom-Json

    # Add scripts section if it doesn't exist
    if (-not $packageJson.PSObject.Properties.Name.Contains("scripts")) {
        $packageJson | Add-Member -MemberType NoteProperty -Name "scripts" -Value @{}
    }

    # Add scripts based on the selected package manager
    $packageJson.scripts = $scripts[$PackageManager]

    # Save the updated package.json file
    $packageJson | ConvertTo-Json | Set-Content $packageJsonPath
}

# Function to add welcome message to index.ts file
function Add-WelcomeMessageToIndexFile {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ProjectType
    )

    $welcomeMessages = @{
        "To-Dos" = "🚀 Welcome to the To-Dos application! 🚀";
        "Blog" = "📝 Welcome to the Blog application! 📝";
        "E-commerce Store" = "💰 Welcome to the E-commerce Store! 💰";
        "Social Media Platform" = "📱 Welcome to the Social Media Platform! 📱";
        "Chat Application" = "💬 Welcome to the Chat Application! 💬";
        "Task Management System" = "✅ Welcome to the Task Management System! ✅";
        "Recipe Sharing Platform" = "🥘 Welcome to the Recipe Sharing Platform! 🥘";
        "Job Board Application" = "👔 Welcome to the Job Board Application! 👔";
        "Expense Tracker" = "💸 Welcome to the Expense Tracker! 💸";
        "Online Learning Platform" = "📚 Welcome to the Online Learning Platform! 📚";
        "CMS" = "🛠️ Welcome to the CMS! 🛠️"
    }

    $welcomeMessage = $welcomeMessages[$ProjectType]

    # Write the welcome message to index.ts file
     Set-Content -Path "./src/index.ts" -Value ('console.log("' + $welcomeMessage + '");')
}

# Prompt for project type
$projectType = $(Read-Host "`nSelect a project type:`n`n$(($projectTypes.GetEnumerator() | Sort-Object -Property Value | ForEach-Object { "{0}. {1}" -f $_.Key, $_.Value }) -join "`n")`n")

if ($projectTypes.ContainsKey($projectType)) {
    $projectName = Read-Host "`nEnter the project name"

    # Create project structure
    Create-ProjectStructure -ProjectName $projectName

    # Navigate to the project directory
    Set-Location $projectName

    # Prompt for package manager
    $packageManagers = @("npm", "pnpm", "yarn", "bun")
    $selectedPackageManager = $(Read-Host "`nSelect a package manager to install dependencies:`n`n$(($packageManagers | ForEach-Object { "$_" }) -join "`n")`n")

    # Initialize a new Node.js project
    & $selectedPackageManager init -y

    # Install dependencies
    $deps = $dependencies[$projectTypes[$projectType]]
    if ($deps) {
        Install-Dependencies -PackageManager $selectedPackageManager -Dependencies $deps
    }

    # Add scripts to package.json
    Add-ScriptsToPackageJson -PackageManager $selectedPackageManager

    # If bun is selected, delete index.ts file outside of src folder
    if ($selectedPackageManager -eq "bun") {
        Remove-Item "index.ts"
    }

    # Add welcome message to index.ts file
    Add-WelcomeMessageToIndexFile -ProjectType $projectTypes[$projectType]

    Write-Output "`nProject structure and dependencies installed successfully!`n"
}
else {
    Write-Output "`nInvalid project type selected. Please try again.`n"
}
