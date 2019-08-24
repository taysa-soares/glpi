#!/bin/bash
#
set -x
# 

SetPermission () {

    chown -Rf apache:apache /var/www/html/glpi

}

RemoveOldPlugin() {

	if [ -z $1 ]
	then
		return "Use: $0 directory"
	fi

	if [ ! -d /var/www/html/glpi/$1 ]
	then

		echo "Directory not found."

	else

		rm -rf /var/www/html/glpi/$1

	fi

}

PluginModifications() {

	RemoveOldPlugin Mod

	curl --progress-bar -L "https://github.com/stdonato/glpi-modifications/archive/1.4.0.tar.gz" | tar -zxf - -C /var/www/html/glpi/plugins/

	mv /var/www/html/glpi/plugins/glpi-modifications-1.4.0 /var/www/html/glpi/plugins/Mod

}




PluginTelegramBot() {

	RemoveOldPlugin telegrambot

	curl --progress-bar -L "https://github.com/pluginsGLPI/telegrambot/releases/download/2.0.0/glpi-telegrambot-2.0.0.tar.bz2" | tar -jxf - -C /var/www/html/glpi/plugins/

}

PluginPDF() {

	RemoveOldPlugin pdf

	curl --progress-bar -L "https://forge.glpi-project.org/attachments/download/2293/glpi-pdf-1.6.0.tar.gz" | tar -zxf - -C /var/www/html/glpi/plugins/

}


PluginOCS() {

	RemoveOldPlugin ocsinventoryng

    curl --progress-bar -L "https://github.com/pluginsGLPI/ocsinventoryng/releases/download/1.6.0/glpi-ocsinventoryng-1.6.0.tar.gz" | tar -zxf - -C /var/www/html/glpi/plugins/

}


PluginDataInjection() {

	RemoveOldPlugin datainjection

    curl --progress-bar -L "https://github.com/pluginsGLPI/datainjection/releases/download/2.7.0/glpi-datainjection-2.7.0.tar.bz2" | tar -jxf - -C /var/www/html/glpi/plugins/

}

PluginFields() {

	RemoveOldPlugin fields

	curl --progress-bar -L "https://github.com/pluginsGLPI/fields/releases/download/1.10.1/glpi-fields-1.10.1.tar.bz2" | tar -jxf - -C /var/www/html/glpi/plugins/

}


PluginTasklists() {

	RemoveOldPlugin tasklists
	
	curl --progress-bar -L "https://github.com/InfotelGLPI/tasklists/releases/download/1.5.0/glpi-tasklists.1.5.0.tar.gz" | tar -zxf - -C /var/www/html/glpi/plugins/ 

}


InstallPlugins() {

	if [ ! -z $PLUGINS ]
	then
		
		LIST=$(echo $PLUGINS | sed "s/,/ /g")

		for i in $LIST
		do

			case $i in

				glpi-modifications)

					PluginModifications

				;;

				glpi-telegrambot)

					PluginTelelgramBot

				;;

				glpi-pdf)

					PluginPDF

				;;

				glpi-ocsinventoryng)

				    PluginOCS

				;;

				glpi-datainjection)

					PluginDataInjection

				;;

				glpi-fields) 

					PluginFields

				;;

				glpi-tasklists)

					PluginTasklists

				;;

				all)
					PluginModifications
					PluginTelegramBot
					PluginPDF
					PluginOCS
					PluginDataInjection
					PluginFields
					PluginTasklists

				;;

				*)
				
					echo "Use: $0 <plugin_name> "
					echo "Available: "
					echo " all (all plugins above)"
					echo " glpi-modifications"
					echo " glpi-telegrambot"
					echo " glpi-pdf"
					echo " glpi-ocsinventoryng"
					echo " glpi-datainjection"
					echo " glpi-fields"
					echo " glpi-tasklists"

				;;

			esac	

		done

	fi

}

#
#
InstallPlugins
#
#
SetPermission
#
#
