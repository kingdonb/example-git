#!/usr/bin/env bash
#readarray -t keys < <( jq '.git_repo | keys' map.json ) --raw-output
# ### There is much debate about how to read an array best, across varying versions
# ### of the Bash interpreter: https://unix.stackexchange.com/a/314379/229312

# This way does not handle failures, so be sure that map.json makes sense:
keys=( $(jq '.git_repo | keys_unsorted | .[]' map.json) )
repos=( $(jq '.git_repo | to_entries | .[].value' map.json) )
normals=( $(jq '.["normalize-hyphenate"] | to_entries | .[].value' map.json) )

len=${#keys[@]}

for (( i=0; i<$len; i++ )); do
  echo git clone $repos[$i] $normals[$i]
  pushd $normals[$i]
  tar xvf ../Jenkinsfile.tar.gz
  bash --login
  popd
done

#for i in git@bitbucket.org:nd-oit/budgetentitygenerator.git git@bitbucket.org:nd-oit/financial-toolkit.git git@bitbucket.org:nd-oit/glez2.git git@bitbucket.org:nd-oit/hire-right-integration.git git@bitbucket.org:nd-oit/maintenance_testing_cucumber.git git@bitbucket.org:nd-oit/nd-application-workflow.git git@bitbucket.org:nd-oit/nd-employee-lookup-gem.git git@bitbucket.org:nd-oit/nd-job-lookup-gem.git git@bitbucket.org:nd-oit/nd-person-api-ws.git git@bitbucket.org:nd-oit/nd_employee_lookup_example.git git@bitbucket.org:nd-oit/nd_facilities_api.git git@bitbucket.org:nd-oit/nd_finance_api_internal.git git@bitbucket.org:nd-oit/nd_foapal_gem.git git@bitbucket.org:nd-oit/nd_hrpy_api_internal.git git@bitbucket.org:nd-oit/pzaforms.git git@github.com:ndoit/personnel-actions.git
#  do
#    echo git clone $i
#    echo pushd ${i%%.git}
#    echo tar xvf ../Jenkinsfile.tar.gz
#    echo popd
#
