# Defined in /var/folders/1_/c4pt121s787484j9mrx5nt5w0000gn/T//fish.YPY1Sk/cleanup_branches.fish @ line 2
function cleanup_branches
	git pull
	git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d
end
