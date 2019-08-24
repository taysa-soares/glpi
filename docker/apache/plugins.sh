#!/bin/bash
#
set -x
# 

SetPermission () {

    chown -Rf apache:apache /var/www/html/glpi

}

PluginModifications() {

	curl --progress-bar -L "https://github.com/stdonato/glpi-modifications/archive/1.4.0.tar.gz" | tar -zxf - -C /var/www/html/glpi/plugins/

	mv /var/www/html/glpi/plugins/glpi-modifications-1.4.0 /var/www/html/glpi/plugins/Mod

}


PluginTelegramBot() {

	curl --progress-bar -L "https://github.com/pluginsGLPI/telegrambot/releases/download/2.0.0/glpi-telegrambot-2.0.0.tar.bz2" | tar -jxf - -C /var/www/html/glpi/plugins/

}

PluginPDF() {

	curl --progress-bar -L "https://forge.glpi-project.org/attachments/download/2293/glpi-pdf-1.6.0.tar.gz" | tar -zxf - -C /var/www/html/glpi/plugins/

}


PluginOCS() {

    curl --progress-bar -L "https://github.com/pluginsGLPI/ocsinventoryng/releases/download/1.6.0/glpi-ocsinventoryng-1.6.0.tar.gz" | tar -zxf - -C /var/www/html/glpi/plugins/

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

				all)
					PluginModifications
					PluginTelegramBot
					PluginPDF
					PluginOCS

				;;

				*)
				
					echo "Use: $0 <plugin_name> "
					echo "Available: "
					echo " all (all plugins above)"
					echo " glpi-modifications"
					echo " glpi-telegrambot"
					echo " glpi-pdf"
					echo " glpi-ocsinventoryng"

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