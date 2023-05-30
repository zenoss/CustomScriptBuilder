# CustomScriptBuilder
A framework for creating simple ZenPacks that just need to add custom scripts.

Step 1> clone the repo<br>
Step 2> cd to the CustomScriptBuilder directory<br>
step 3> add your script(s) to the libexec directory<br>
step 4> run makepack.sh with -a AUTHOR -v VERSION and -n NAME flags<br>


Your new ZenPack egg will be found in the current directory (next to the makepack.sh script)

Scripts can then be added to a command datasource and called like so:
<pre>/bin/env ${here/ZenPackManager/packs/ZenPacks.NAME.CustomScripts/path}/libexec/SCRIPT-NAME.sh</pre>

Note: This currently will build an egg file and then clean up everything but the built ZenPack. If you need to add more scripts you will need to maintain your version information and scripts from previous builds.

Author is the only flag that can contain spaces and should be 'QUOTED'<br>  
***This is a work in progress watch for falling rocks***
