# Define the main function
function CreateViteAppWithTailwindCSS {
    # Create Vite app using Bun
    try {
        & bun create vite@latest
    }
    catch {
        Write-Host "Error creating Vite app: $_"
        return
    }

    # Prompt the user to enter the directory name
    $dirName = Read-Host "Enter the same name as before "

    # Change directory to the specified directory
    if (-not (Test-Path $dirName -PathType Container)) {
        Write-Host "Directory '$dirName' does not exist."
        return
    }
    Set-Location -Path $dirName

    # Install necessary dependencies
    try {
        & bun i
        & npm install -D tailwindcss postcss autoprefixer
        & npx tailwindcss init -p
    }
    catch {
        Write-Host "Error installing dependencies: $_"
        return
    }

    # Update tailwind.config.js with custom configuration
    try {
@"
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
"@ | Set-Content -Path "tailwind.config.js" -Force
    }
    catch {
        Write-Host "Error updating tailwind.config.js: $_"
        return
    }

    # Remove App.css file
    Remove-Item -Path "src/App.css" -ErrorAction SilentlyContinue

    # Update App.tsx with custom code
    try {
@"
export default function App() {
  return (
    <h1 className="text-3xl font-bold underline">
      Hello world!
    </h1>
  )
}
"@ | Set-Content -Path "src/App.tsx" -Force
    }
    catch {
        Write-Host "Error updating App.tsx: $_"
        return
    }

    # Update index.css with Tailwind CSS imports
    try {
@"
@tailwind base;
@tailwind components;
@tailwind utilities;
"@ | Set-Content -Path "src/index.css" -Force
    }
    catch {
        Write-Host "Error updating index.css: $_"
        return
    }

    Write-Host "Vite app with Tailwind CSS setup completed successfully!"
}

# Call the main function
CreateViteAppWithTailwindCSS
