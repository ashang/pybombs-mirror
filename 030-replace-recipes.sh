#!/bin/bash

# Currently, all mirrored repo are served through http or https: 
# like: 
# 	git+http, svn+http, wget+http
# or:
# 	git+https, svn+https, wget+https
PYBOMBS_MIRROR_BASE_URL="http://localhost/pybombs" # *NO* tailing / should be added.

if [ ! -e _recipes-mirror-replacement.urls ]; then
	echo "No recipes-mirror-replacement.urls found! Exit."
	exit -1
fi

if [ ! -d recipes ]; then
	echo "No target recipes directory found! Exit."
	exit -1
fi

echo "Replacing PYBOMBS_MIRROR_BASE_URL with ${PYBOMBS_MIRROR_BASE_URL} in recipes-mirror-replacement.urls .."
cp _recipes-mirror-replacement.urls recipes-mirror-replacement.urls 
sed -i "s,PYBOMBS_MIRROR_BASE_URL,${PYBOMBS_MIRROR_BASE_URL}," recipes-mirror-replacement.urls
echo "Done."


cat recipes-mirror-replacement.urls | while read origin new
do
	echo "Replacing ${origin} with ${new}"
	find ./recipes/ -name \*.lwr -exec sed -i "s,${origin},${new},g" {} \;
	echo
done
