#/bin/bash
{{ karaf_base }}/bin/start
sleep 60
{{ karaf_base }}/bin/client -f {{ karaf_base }}/install_service/karaf_service.script
{{ karaf_base }}/bin/stop

