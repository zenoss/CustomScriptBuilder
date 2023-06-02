# CustomScriptBuilder

## How to Build your 'CustomScripts' ZenPack

A framework for creating simple ZenPacks that just need to add custom scripts.

Step 1> clone the repo<br>
Step 2> cd to the CustomScriptBuilder directory<br>
step 3> add your script(s) to the libexec directory<br>
step 4> run `makepack.sh` with -a AUTHOR -v VERSION and -n NAME flags<br>


Your new ZenPack egg will be found in the current directory (next to the makepack.sh script)

Scripts can then be added to a command datasource and called like so:
<pre>/bin/env ${here/ZenPackManager/packs/ZenPacks.NAME.CustomScripts/path}/libexec/SCRIPT-NAME.sh</pre>

Author is the only flag that can contain spaces and should be 'QUOTED'<br>  
***This is a work in progress watch for falling rocks***

## Considerations for your scripts

Your scripts should be thoroughly tested
and vetted before ever being added to a ZenPack. Your scripts should be:
​
* Written with security in mind. Sensitive data should not be hardcoded nor
  passed via the command-line.
* Efficient and performant. A script should not be a resource hog, have a long
  run time, etc.
* Your intellectual property. Licensable for use & distribution by you.
* Not a binary. Script languages used can be any supported by the Zenoss
  image; sh, bash, python, perl, etc.
* Expected Output. Scripts need to exit & output data in a manner exceptable
  by Zenoss.

## How/Where you can use your scripts

### Data Collection
​
The most common use for needing custom scripts is for the polling of data or
metrics via the "COMMAND" Datasource type. It is important that the script
response output is in one of the fomrats that Zenoss can parse; Catci, JSON,
or Nagios.
​

*Reference*: [Performance monitoring / Data sources](https://help.zenoss.com/zsd/RM/administering-resource-manager/performance-monitoring/data-sources)
​
### User Defined Commands
​
User Commands are defined under "*RM > Advance > Commands*". You would defined the
command similar to: `${here/ZenPackManager/packs/ZenPacks.NAME.CustomScripts/path}/libexec/customCommandScript.py "${device/id}"`

​
*Reference*: [General Administration and settings](https://help.zenoss.com/zsd/RM/administering-resource-manager/general-administration-and-settings/user-commands)
​
### Event Notification

Defined under "*Events > Triggers  Notifications*" 

​
*Reference*: [Notification content for Command actions](https://help.zenoss.com/zsd/RM/administering-resource-manager/triggers-and-notifications/working-with-notifications/defining-notification-content/notification-content-for-command-actions)
