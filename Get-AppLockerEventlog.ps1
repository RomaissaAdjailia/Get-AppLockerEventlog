# Let's define Parameters

Param(
        [ValidateSet(“All”,”Block”,”Allow”,"Audit")]
        [String]
        $HunType="ALL"
 )
switch ($HunType)
{

All 
{
    
    $output = Get-WinEvent -FilterHashtable @{LogName="microsoft-windows-applocker/*"}  | ForEach-Object {

    # First, the UserID give the SID, to have the username, we need to translate this value:
    # The userid is a propriety of Get-WinEvent
    if($_.userid -eq $null) { $user= "N/A";}
    else {$user = (New-Object System.Security.Principal.SecurityIdentifier($_.userid)).Translate([System.Security.Principal.NTAccount]).value;}
    
    # Most Information we needs are not present in Proprities of Get-WinEvent, so we need the xml format to extract them
    # So, Let's convert each event to XML and extract the Event node from the XML File
    $eventXml = ([xml]$_.ToXml()).Event

    # Then, we collect the data we are intrested in and we put them in an order hashtable
    # The xml file have 02 prinicipales nodes <System> and <UserData>, all intresting information of <userdata> are within the child <RuleAndFileData>

    $evt = [ordered]@{        
        
        FileType = $eventXml.UserData.RuleAndFileData.PolicyName
        EventID = $eventXml.System.EventID
        Message = $_.message
        User = $user
        Computer  = $eventXml.System.Computer
        EventTime = [DateTime]$eventXml.System.TimeCreated.SystemTime
        
        
        #RuleSddl = $eventXml.UserData.RuleAndFileData.RuleSddl
        FilePath = $eventXml.UserData.RuleAndFileData.FilePath
        Publisher = $eventXml.UserData.RuleAndFileData.Fqbn
        FileHash = $eventXml.UserData.RuleAndFileData.FileHash
        Package = $eventXml.UserData.RuleAndFileData.Package
        RuleName = $eventXml.UserData.RuleAndFileData.RuleName
        LogName = $eventXml.System.Channel
        TargetUser = $eventXml.UserData.RuleAndFileData.TargetUser
           
    }
       
    # we need to creat those events as a custom PowerShell object to make the information more usable and displays the data more clearly.
    [PsCustomObject]$evt
    
    }

    $Header= " ======= This is the list of ALL events of Applocker.======="

}

Block 
{
    
    $output = Get-WinEvent -FilterHashtable @{LogName="microsoft-windows-applocker/*";id=8004,8007,8022,8024}  | ForEach-Object {

    # First, the UserID give the SID, to have the username, we need to translate this value:
    # The userid is a propriety of Get-WinEvent
    if($_.userid -eq $null) { $user= "N/A";}
    else {$user = (New-Object System.Security.Principal.SecurityIdentifier($_.userid)).Translate([System.Security.Principal.NTAccount]).value;}
    
    # Most Information we needs are not present in Proprities of Get-WinEvent, so we need the xml format to extract them
    # So, Let's convert each event to XML and extract the Event node from the XML File
    $eventXml = ([xml]$_.ToXml()).Event

    # Then, we collect the data we are intrested in and we put them in an order hashtable
    # The xml file have 02 prinicipales nodes <System> and <UserData>, all intresting information of <userdata> are within the child <RuleAndFileData>

    $evt = [ordered]@{        
        
        FileType = $eventXml.UserData.RuleAndFileData.PolicyName
        EventID = $eventXml.System.EventID
        Message = $_.message
        User = $user
        Computer  = $eventXml.System.Computer
        EventTime = [DateTime]$eventXml.System.TimeCreated.SystemTime
        
        
        #RuleSddl = $eventXml.UserData.RuleAndFileData.RuleSddl
        FilePath = $eventXml.UserData.RuleAndFileData.FilePath
        Publisher = $eventXml.UserData.RuleAndFileData.Fqbn
        FileHash = $eventXml.UserData.RuleAndFileData.FileHash
        Package = $eventXml.UserData.RuleAndFileData.Package
        RuleName = $eventXml.UserData.RuleAndFileData.RuleName
        LogName = $eventXml.System.Channel
        TargetUser = $eventXml.UserData.RuleAndFileData.TargetUser
           
    }
       
    # we need to creat those events as a custom PowerShell object to make the information more usable and displays the data more clearly.
    [PsCustomObject]$evt
    
    }
    $header = " ======= This is the list of BLOCKED events of Applocker.======="

}

Allow 
{
    
    $output = Get-WinEvent -FilterHashtable @{LogName="microsoft-windows-applocker/*"; Id=8002,8005,8020,8023}  | ForEach-Object {

    # First, the UserID give the SID, to have the username, we need to translate this value:
    # The userid is a propriety of Get-WinEvent
    if($_.userid -eq $null) { $user= "N/A";}
    else {$user = (New-Object System.Security.Principal.SecurityIdentifier($_.userid)).Translate([System.Security.Principal.NTAccount]).value;}
    
    # Most Information we needs are not present in Proprities of Get-WinEvent, so we need the xml format to extract them
    # So, Let's convert each event to XML and extract the Event node from the XML File
    $eventXml = ([xml]$_.ToXml()).Event

    # Then, we collect the data we are intrested in and we put them in an order hashtable
    # The xml file have 02 prinicipales nodes <System> and <UserData>, all intresting information of <userdata> are within the child <RuleAndFileData>

    $evt = [ordered]@{        
        
        FileType = $eventXml.UserData.RuleAndFileData.PolicyName
        EventID = $eventXml.System.EventID
        Message = $_.message
        User = $user
        Computer  = $eventXml.System.Computer
        EventTime = [DateTime]$eventXml.System.TimeCreated.SystemTime
        
        
        #RuleSddl = $eventXml.UserData.RuleAndFileData.RuleSddl
        FilePath = $eventXml.UserData.RuleAndFileData.FilePath
        Publisher = $eventXml.UserData.RuleAndFileData.Fqbn
        FileHash = $eventXml.UserData.RuleAndFileData.FileHash
        Package = $eventXml.UserData.RuleAndFileData.Package
        RuleName = $eventXml.UserData.RuleAndFileData.RuleName
        LogName = $eventXml.System.Channel
        TargetUser = $eventXml.UserData.RuleAndFileData.TargetUser
           
    }
       
    # we need to creat those events as a custom PowerShell object to make the information more usable and displays the data more clearly.
    [PsCustomObject]$evt
    
    }
    $header = " ======= This is the list of ALLOWED events of Applocker.======="

}

Audit 
{
    
    $output = Get-WinEvent -FilterHashtable @{LogName="microsoft-windows-applocker/*"; Id= 8003,8006,,8021,8024}  | ForEach-Object {

    # First, the UserID give the SID, to have the username, we need to translate this value:
    # The userid is a propriety of Get-WinEvent
    if($_.userid -eq $null) { $user= "N/A";}
    else {$user = (New-Object System.Security.Principal.SecurityIdentifier($_.userid)).Translate([System.Security.Principal.NTAccount]).value;}
    
    # Most Information we needs are not present in Proprities of Get-WinEvent, so we need the xml format to extract them
    # So, Let's convert each event to XML and extract the Event node from the XML File
    $eventXml = ([xml]$_.ToXml()).Event

    # Then, we collect the data we are intrested in and we put them in an order hashtable
    # The xml file have 02 prinicipales nodes <System> and <UserData>, all intresting information of <userdata> are within the child <RuleAndFileData>

    $evt = [ordered]@{        
        
        FileType = $eventXml.UserData.RuleAndFileData.PolicyName
        EventID = $eventXml.System.EventID
        Message = $_.message
        User = $user
        Computer  = $eventXml.System.Computer
        EventTime = [DateTime]$eventXml.System.TimeCreated.SystemTime
        
        
        #RuleSddl = $eventXml.UserData.RuleAndFileData.RuleSddl
        FilePath = $eventXml.UserData.RuleAndFileData.FilePath
        Publisher = $eventXml.UserData.RuleAndFileData.Fqbn
        FileHash = $eventXml.UserData.RuleAndFileData.FileHash
        Package = $eventXml.UserData.RuleAndFileData.Package
        RuleName = $eventXml.UserData.RuleAndFileData.RuleName
        LogName = $eventXml.System.Channel
        TargetUser = $eventXml.UserData.RuleAndFileData.TargetUser
           
    }
       
    # we need to creat those events as a custom PowerShell object to make the information more usable and displays the data more clearly.
    [PsCustomObject]$evt
    
    }
    $header = " ======= This is the list of Audited events of Applocker.======="

}

}

# Display the output to the screen
Write-Host "`n $header" -ForegroundColor Magenta
$output

# Export the output to a CSV file
$output  | Export-Csv AppLocker-log.csv -NoTypeInformation


