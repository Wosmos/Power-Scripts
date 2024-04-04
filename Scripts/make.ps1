# # # Define the main function
# # function CreateFilesAndFolders {
# #     # Loop until an empty input is received
# #     while ($true) {
# #         # Prompt the user to enter a file or folder name
# #         $inputName = Read-Host "Enter a file or folder name (press Enter to quit)"

# #         # Check if the input is empty
# #         if ([string]::IsNullOrWhiteSpace($inputName)) {
# #             Write-Host "Exiting script..."
# #             break  # Exit the loop if input is empty
# #         }

# #         # Extract the file name and extension (if provided)
# #         $fileName = $inputName -replace '\..*'
# #         $fileExtension = $inputName -replace '^.*\.'

# #         # Check if the input ends with '_'
# #         if ($inputName.EndsWith('_')) {
# #             # Create a folder with the provided name (without the trailing underscore)
# #             $folderName = $fileName.TrimEnd('_')
# #             New-Item -ItemType Directory -Name $folderName -ErrorAction SilentlyContinue
# #             Write-Host "Folder '$folderName' created successfully"
# #             # Create a nested file named page.tsx
# #             New-Item -Path ".\$folderName" -ItemType File -Name "page.tsx" -ErrorAction SilentlyContinue
# #             Write-Host "Nested file 'page.tsx' created successfully"
# #         }
# #         else {
# #             # Create a folder with the provided name
# #             New-Item -ItemType Directory -Name $inputName -ErrorAction SilentlyContinue
# #             Write-Host "Folder '$inputName' created successfully"
# #         }

# #         # Go back to the initial path
# #         Set-Location -Path $PSScriptRoot
# #     }
# # }

# # # Call the main function
# # CreateFilesAndFolders




# # Define the main function
# function CreateFilesAndFolders {
#     # Loop until an empty input is received
#     while ($true) {
#         # Prompt the user to enter a file or folder name
#         $inputName = Read-Host "Enter a file or folder name (press Enter to quit)"

#         # Check if the input is empty
#         if ([string]::IsNullOrWhiteSpace($inputName)) {
#             Write-Host "Exiting script..."
#             break  # Exit the loop if input is empty
#         }

#         # Extract the file name and extension (if provided)
#         $fileName = $inputName -replace '\..*'
#         $fileExtension = $inputName -replace '^.*\.'

#         # Check if the input ends with '_'
#         if ($inputName.EndsWith('_')) {
#             # Create a folder with the provided name (without the trailing underscore)
#             $folderName = $fileName.TrimEnd('_')
#             New-Item -ItemType Directory -Name $folderName -ErrorAction SilentlyContinue
#             Write-Host "Folder '$folderName' created successfully"
#             # Create a nested file named page.tsx
#             New-Item -Path ".\$folderName" -ItemType File -Name "page.tsx" -ErrorAction SilentlyContinue
#             Write-Host "Nested file 'page.tsx' created successfully"
#             # Populate page.tsx with the specified content
#             $pageContent = @"
# import React from 'react'

# const $folderName = () => {
#   return (
#     <div>
#      this is $folderName
#     </div>
#   )
# }

# export default $folderName
# "@
#             Set-Content -Path ".\$folderName\page.tsx" -Value $pageContent
#         }
#         else {
#             # Create a folder with the provided name
#             New-Item -ItemType Directory -Name $inputName -ErrorAction SilentlyContinue
#             Write-Host "Folder '$inputName' created successfully"
#         }

#         # Go back to the initial path
#         Set-Location -Path $PSScriptRoot
#     }
# }

# # Call the main function
# CreateFilesAndFolders




# Define the main function
function CreateFilesAndFolders {
    # Loop until an empty input is received
    while ($true) {
        # Prompt the user to enter a file or folder name
        $inputName = Read-Host "Enter a file or folder name (press Enter to quit)"

        # Check if the input is empty
        if ([string]::IsNullOrWhiteSpace($inputName)) {
            Write-Host "Exiting script..."
            break  # Exit the loop if input is empty
        }

        # Extract the file name and extension (if provided)
        $fileName = $inputName -replace '\..*'
        $fileExtension = $inputName -replace '^.*\.'

        # Check if the input ends with '_'
        if ($inputName.EndsWith('_')) {
            # Create a folder with the provided name (without the trailing underscore)
            $folderName = $fileName.TrimEnd('_')
            New-Item -ItemType Directory -Name $folderName -ErrorAction SilentlyContinue
            Write-Host "Folder '$folderName' created successfully"
            # Create a nested file named page.tsx
            New-Item -Path ".\$folderName" -ItemType File -Name "page.tsx" -ErrorAction SilentlyContinue
            Write-Host "Nested file 'page.tsx' created successfully"
            # Populate page.tsx with the specified content
            $pageContent = @"
import React from 'react'

const $folderName = () => {
  return (
    <div>
     this is $folderName
    </div>
  )
}

export default $folderName
"@
            Set-Content -Path ".\$folderName\page.tsx" -Value $pageContent
        }
        else {
            # Check if the input contains a dot (file creation)
            if ($inputName.Contains('.')) {
                # Create a file with the provided name and extension
                New-Item -ItemType File -Name $inputName -ErrorAction SilentlyContinue
                Write-Host "File '$inputName' created successfully"
            }
            else {
                # Create a folder with the provided name
                New-Item -ItemType Directory -Name $inputName -ErrorAction SilentlyContinue
                Write-Host "Folder '$inputName' created successfully"
            }
        }

        # Go back to the initial path
        Set-Location -Path $PSScriptRoot
    }
}

# Call the main function
CreateFilesAndFolders
