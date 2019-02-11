function pr --description 'Open the PR for the current branch in the browesr'
	set branch=(command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
set url=git pr list -h $branch -f %U
if [ test -n "$url" ]
open $url
else
echo 'There is no PR for this branch yet'
set create=(read -P 'Would you like to open a PR now? (y/n)' -n 1)
if [ $create == "y" ]
git pull-request
end
end
end
