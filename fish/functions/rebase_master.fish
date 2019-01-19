function rebase_master
  set -lx BRANCH (git rev-parse --abbrev-ref HEAD)
  git checkout master
  git pull
  git checkout $BRANCH
  git rebase master
end
