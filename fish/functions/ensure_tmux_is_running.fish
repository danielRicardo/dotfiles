function ensure_tmux_is_running -d 'reattach to tmux in case you drop out'
	if [ -z $TMUX ]
		if [ -z (tmux list-sessions) ]
			tat
		else 
			tmux attach
		end
	end
end
