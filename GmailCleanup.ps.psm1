<#
    .SYNOPSIS
    This PowerShell module provides functionality to clean up Gmail inboxes by intelligently determining actions on emails using OpenAI's ChatGPT.

    .DEPENDENCIES
    Gmail.ps
    PsChat
#>

# Import required modules
Import-Module Gmail.ps -Verbose
Import-Module PsChat -Verbose

# Function to setup the module by getting the necessary details
function Setup-GmailCleaner {
    # Prompt for OpenAI API Key
    $openAIKey = Read-Host -Prompt "Please enter your OpenAI API Key"
    $ENV:OPENAI_AUTH_TOKEN = $openAIKey

    # If Gmail.ps requires any setup/authentication, prompt for those details here
    # Example: 
    # $gmailAuth = Read-Host -Prompt "Please enter your Gmail authentication details"
    # Setup-GmailAuthentication -Auth $gmailAuth
}

# Function to handle rate limits
function Handle-RateLimit {
    Start-Sleep -Seconds 10
}

# Function to log actions
function Log-Action {
    param([string]$Message)
    
    $timestamp = Get-Date
    Add-Content -Path "./gmailCleanup.log" -Value "[$timestamp] $Message"
}

# Function to process a group of emails by context using OpenAI
function Process-EmailGroup {
    param([array]$EmailGroup, [string]$Context)
    
    $formattedEmails = $EmailGroup | ForEach-Object { "Subject: $($_.Subject)" } -Join "; "
    
    $question = "For emails from sender: $Context with these subjects: $formattedEmails, what should be the general action (Archive/Label/Categorize/Keep)?"
    
    try {
        $response = Get-PsChatAnswer $question

        switch ($response.Trim()) {
            "Archive" {
                $EmailGroup | ForEach-Object {
                    Archive-GmailEmail -ID $_.ID
                    Log-Action "Archived Email with ID $($_.ID)."
                }
            }
            "Label" {
                $EmailGroup | ForEach-Object {
                    Label-GmailEmail -ID $_.ID
                    Log-Action "Labeled Email with ID $($_.ID)."
                }
            }
            "Categorize" {
                $EmailGroup | ForEach-Object {
                    Categorize-GmailEmail -ID $_.ID
                    Log-Action "Categorized Email with ID $($_.ID)."
                }
            }
            default {
                $EmailGroup | ForEach-Object {
                    Log-Action "Kept Email with ID $($_.ID) as is."
                }
            }
        }

    } catch {
        Log-Action "Error in determining action using OpenAI for the email group by context $Context. Error: $_"
    }
}

# Function to clean up Gmail Inbox
function Clean-GmailInbox {
    # Call the setup function
    Setup-GmailCleaner

    $allEmails = Get-GmailEmails

    # Group by sender
    $groupedEmails = $allEmails | Group-Object -Property Sender

    foreach ($group in $groupedEmails) {
        Process-EmailGroup -EmailGroup $group.Group -Context $group.Name
        
        # Handle rate limits (if required) here
        # Handle-RateLimit
    }
}

# Expose the main function to the user
Export-ModuleMember -Function Clean-GmailInbox
