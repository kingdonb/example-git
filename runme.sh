#!/usr/bin/env bash
#readarray -t keys < <( jq '.git_repo | keys' map.json ) --raw-output
# ### There is much debate about how to read an array best, across varying versions
# ### of the Bash interpreter: https://unix.stackexchange.com/a/314379/229312

# This way does not handle failures, so be sure that map.json makes sense:
keys=( $(jq '.git_repo | keys_unsorted | .[]' map.json --raw-output) )
repos=( $(jq '.git_repo | to_entries | .[].value' map.json --raw-output) )
normals=( $(jq '.["normalize-hyphenate"] | to_entries | .[].value' map.json --raw-output) )

len=${#keys[@]}

for (( i=0; i<$len; i++ )); do
  # echo git clone ${repos[$i]} ${normals[$i]}
  # git submodule add ${repos[$i]} ${keys[$i]}
  pushd ${keys[$i]}
  tar xvf ../Jenkinsfile-example.tar.gz
  bash --login
  popd
done
