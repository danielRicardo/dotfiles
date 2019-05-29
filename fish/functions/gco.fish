# Defined in /var/folders/1_/c4pt121s787484j9mrx5nt5w0000gn/T//fish.rdK2vy/gco.fish @ line 2
function gco
	git branch | fzf | xargs git checkout
end
