##Function to generate selection menu
function Show-Menu
{
 param ([string]$Title = 'Menu')
  
 cls
 Write-Host "==================== $Title ===================="
 Write-Host '=============================================='
 Write-Host "1. Set mailbox forwards"
 Write-Host "2. Verify mailbox forwards"
 Write-Host "Q. Quit to Shell"
 Write-Host '=============================================='
}

## CSV:Mailbox, ForwardTo, Condition

##Do loop for the main menu start##
do
{
 Show-Menu
 $input = Read-Host "What would you like to do?"
 switch ($input)
 {
##Start Menu Option 1
  '1' 
    {
     Import-CSV "C:\sada\GoLiveForwards-Exchange2010.csv" | % { $_.Condition = [bool]($_.Condition -as [int]); $_  } | ForEach {Set-Mailbox -Identity $_.mailbox -ForwardingsmtpAddress $_.forwardto -Delivertomailboxandforward $_.Condition}
    } 
##End Menu Option 1

##Start Menu Option 2
  '2' 
    {
     $Verify = Import-Csv c:\sada\GoLiveForwards-Exchange2010.csv
     $Verify | ForEach {Get-Mailbox -Identity $_.Mailbox | Select WindowsEmailAddress,ForwardingSMTPAddress} | FL
     Write-Host -NoNewLine 'Press any key to continue...';
     $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
    }
##End Menu Option 2

##Quit the script##

'q' 
{
 return
}
 }
  pause
}
until ($input -eq 'q')

##Do loop for the menu end##