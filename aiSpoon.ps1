Add-Type -AssemblyName System.Windows.Forms

# Your OpenAI API key
$apiKey = 'YOUR_OPENAI_API_KEY'
$baseURL = 'https://api.openai.com/v1/engines/davinci-turbo/completions'

$headers = @{
    'Authorization' = "Bearer $apiKey"
    'Content-Type' = 'application/json'
}

function GetGPTResponse {
    param (
        [string]$prompt
    )

    $body = @{
        prompt  = $prompt
        max_tokens = 150
    } | ConvertTo-Json

    $response = Invoke-RestMethod -Method Post -Uri $baseURL -Headers $headers -Body $body

    return $response.choices[0].text.Trim()
}

# Create main form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'GPT-3.5 Turbo Chat'
$form.Size = New-Object System.Drawing.Size(500,400)
$form.StartPosition = 'CenterScreen'

# Create textbox for conversation
$conversationBox = New-Object System.Windows.Forms.TextBox
$conversationBox.Location = New-Object System.Drawing.Point(10,10)
$conversationBox.Size = New-Object System.Drawing.Size(460,260)
$conversationBox.Multiline = $true
$conversationBox.ScrollBars = 'Vertical'
$form.Controls.Add($conversationBox)

# Create textbox for user input
$inputBox = New-Object System.Windows.Forms.TextBox
$inputBox.Location = New-Object System.Drawing.Point(10,280)
$inputBox.Size = New-Object System.Drawing.Size(360,20)
$form.Controls.Add($inputBox)

# Send button
$sendButton = New-Object System.Windows.Forms.Button
$sendButton.Location = New-Object System.Drawing.Point(380,278)
$sendButton.Size = New-Object System.Drawing.Size(90,25)
$sendButton.Text = 'Send'
$sendButton.Add_Click({
    $userInput = $inputBox.Text
    $conversationBox.AppendText("`nYou: $userInput")
    $gptResponse = GetGPTResponse -prompt $userInput
    $conversationBox.AppendText("`nGPT-3.5 Turbo: $gptResponse")
    $inputBox.Clear()
})
$form.Controls.Add($sendButton)

# Copy to clipboard button
$copyButton = New-Object System.Windows.Forms.Button
$copyButton.Location = New-Object System.Drawing.Point(10,328)
$copyButton.Size = New-Object System.Drawing.Size(460,25)
$copyButton.Text = 'Copy Conversation to Clipboard'
$copyButton.Add_Click({
    $clipText = $conversationBox.Text
    Set-Clipboard -Value $clipText
})
$form.Controls.Add($copyButton)

$form.ShowDialog()
