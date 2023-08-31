# Gmail Cleanup with PsChat Integration
A PowerShell module that integrates Gmail with OpenAI's ChatGPT for intelligent and dynamic Gmail inbox cleanup.

## Features
- Automatic Cleanup: Uses OpenAI's ChatGPT to make smart decisions about emails.
- Customizable Workflow: User can intervene and dictate actions using PsChat.
- Secure Authentication: Ensures safe OAuth2.0 authentication with Gmail.
- Detailed Logging: Keep track of every decision made and action performed.
- Chunked Analysis: Contextually chunks data by Sender, Subject, etc., to manage API calls.
- Getting Started
- Prerequisites
- OpenAI API key: Required for PsChat to communicate with OpenAI.
- Gmail Account: Ensure that API access is enabled and set up OAuth2.0 for the Gmail API.

## Installation
```
$url = 'https://raw.githubusercontent.com/ssmanji89/GmailCleanup.ps/master/GmailCleanup.ps.psm1'
$output = './GmailCleanup.ps.psm1'
Invoke-WebRequest -Uri $url -OutFile $output
```

# Navigate to the cloned directory and Import the module
```
cd GmailCleanupWithPsChat
Import-Module ./GmailCleaner.psm1
```

## Configuration
Before starting, set up your OpenAI API key:
```
# Get OpenAI API Key
$apiKey = Read-Host -Prompt "Enter your OpenAI API Key" -AsSecureString
$ENV:OPENAI_AUTH_TOKEN = [System.Net.NetworkCredential]::new("", $apiKey).Password
```

## Usage
Start the cleanup session:
```
Invoke-GmailCleanupSession
```

## Advanced Features
- Manual Overrides: During any step of the cleanup, interject and dictate what action you'd like to be taken.
- Custom Cleanup Logic: Adjust the OpenAI model's behavior according to your needs.
- Extensive Logging: For audit trails and debugging.
- Advanced Cleanup: Labeling, categorizing, sorting, and more.

## Considerations
- Gmail API and OpenAI have rate limits. The script gracefully handles these limits.
- Ensure Gmail authentication using OAuth2.0 and securely store tokens.
- Handle scenarios like 2FA, token revocation, and reduced permissions gracefully.

# Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you'd like to change.

# License: 
The MIT License (MIT)

Copyright (c) 2023 Suleman Manji

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

