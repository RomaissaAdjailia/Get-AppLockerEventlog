# Get-AppLockerEventlog

## DESCRIPTION

This script will parse all the chaneles of AppLocker events from win-event log to extract all the logs relatives to AppLocker. The scrript will gather all the important infomartions relatives to the events for foreinsic or threat-hunting puropse, or even in order to troubleshoot. Here are the logs we fetch from win-event:
- EXE and DLL, 
- MSI and Script, 
- Packaged app-Deployment, 
- Packaged app-Execution.

The out-put:
- The result will be dispalyed to the screen
![all](/Images/All-1.png)

- And, The result will be saved to a csv file

The usefull informations you will get with this script are:
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

### ThuType

This parametre specifie the type of events you are intrested in, there are 04 values for this parametres:

**1. All**

This gets all the events of AppLocker that are intresting for threat-hunting,foreisic or even troubleshooting. This is the default value.

```
.\Get-AppLockerEventlog.ps1 -HunType All

```

![all](/Images/All-2.png)

**2. Block**

This gets all the events that are triggred by the action of blocking an application by AppLocker, this type is critical for threat-hunting or foreisic, and comme with high priority, since it indicate a indicate a malcious attempt, or could be a good indicator of prior malicious activity inorder to evade deffensive mechanisme.
```
.\Get-AppLockerEventlog.ps1 -HunType Block |Format-Table -AutoSize
```
![Block](/Images/Block-1.png)

**3. Allow**

This gets all the events that are triggred by the action of Allowing an application by AppLocker. For threat-hunting or foreisic, even the allowed applocations should be monitored, inorder to detect any possible bypass or configuartion misitakes.

```
.\Get-AppLockerEventlog.ps1 -HunType Allow | Format-Table -AutoSize
```
![Allow](/Images/Allow-1.png)

**4. Audit**

This gets all the events generated when AppLocker would block the application if the enforcement mode were enabled (Audit mode). For threat-hunting or foreisic, this could indicate any configuration mistake, negelction from the admin to switch the mode, or even a malicious action that happened in the audit phase (tunning pahse) .

```
 .\Get-AppLockerEventlog.ps1 -HunType Audit
 
 ```

## Resource

To better understand AppLocker, give this blog a read:

[Diving in AppLocker for Blue Team — Part 1](https://medium.com/@elromaissa2/diving-in-applocker-for-blue-team-57a7328ce5c0)

## Contributing

This project welcomes contributions and suggestions. 






