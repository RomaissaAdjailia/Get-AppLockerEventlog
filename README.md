# Get-AppLockerEventlog

## DESCRIPTION

This script will parse all the channels of events from the win-event log to extract all the log relatives to AppLocker. The script will gather all the important pieces of information relative to the events for forensic or threat-hunting purposes, or even in order to troubleshoot. Here are the logs we fetch from win-event:

- EXE and DLL, 
- MSI and Script, 
- Packaged app-Deployment, 
- Packaged app-Execution.

### The output:
- The result will be displayed on the screen  
![all](/Images/All-1.png)

- And, The result will be saved to a csv file: **AppLocker-log.csv**

![csv](/Images/csv.png)


The juicy and useful information you will get with this script are:
- FileType,
- EventID,
- Message,
- User,
- Computer,
- EventTime,
- FilePath,
- Publisher,
- FileHash,
- RuleName,
- LogName,
- TargetUser.

## PARAMETERS

### HunType

This parameter specifies the type of events you are interested in, there are 04 values for this parameter:

**1. All**

This gets all the events of AppLocker that are interesting for threat-hunting, forensic or even troubleshooting. This is the default value.

```
.\Get-AppLockerEventlog.ps1 -HunType All

```

![all](/Images/All-2.png)

**2. Block**

This gets all the events that are triggered by the action of blocking an application by AppLocker, this type is critical for threat-hunting or forensics, and comes with high priority, since it indicates malicious attempts, or could be a good indicator of prior malicious activity in order to evade defensive mechanisms.
```
.\Get-AppLockerEventlog.ps1 -HunType Block |Format-Table -AutoSize
```
![Block](/Images/Block-1.png)

**3. Allow**

This gets all the events that are triggered by the action of Allowing an application by AppLocker. For threat-hunting or forensics, even the allowed applications should be monitored, in order to detect any possible bypass or configuration mistakes.
```
.\Get-AppLockerEventlog.ps1 -HunType Allow | Format-Table -AutoSize
```
![Allow](/Images/Allow-1.png)

**4. Audit**

This gets all the events generated when AppLocker would block the application if the enforcement mode were enabled (Audit mode). For threat-hunting or forensics, this could indicate any configuration mistake, neglect from the admin to switch the mode, or even a malicious action that happened in the audit phase (tuning phase).
```
 .\Get-AppLockerEventlog.ps1 -HunType Audit
 
 ```

## Resource

To better understand AppLocker, give this blog a read:

[Diving in AppLocker for Blue Team — Part 1](https://medium.com/@elromaissa2/diving-in-applocker-for-blue-team-57a7328ce5c0)

https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-application-control/applocker/using-event-viewer-with-applocker


## Contributing

This project welcomes contributions and suggestions. 






