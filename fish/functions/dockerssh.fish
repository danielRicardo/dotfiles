# Defined in /var/folders/1_/c4pt121s787484j9mrx5nt5w0000gn/T//fish.pSMf3F/dockerssh.fish @ line 2
function dockerssh
	set container_name (docker ps --format "{{.Names}}" | fzf)
        docker exec -it $container_name /bin/bash
end
