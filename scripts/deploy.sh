echo This is a deploy script
echo "Respawn is '$RESPAWN'"

if [[ "$RESPAWN" == "false" ]]; then
  echo Break loop
  exit 0
fi
echo Requesting a respawn


body=$(cat << EOF
{ "request": {
    "message": "Override the commit message: this is an api request",
    "branch": "$TRAVIS_BRANCH",
    "config": {
      "env": {
        "global": ["RESPAWN=false"]
      },
      "script": "echo FOO"
    }
  }
}
EOF
)

exec curl -s -X POST \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -H "Travis-API-Version: 3" \
  -H "Authorization: token $REBUILD_TOKEN" \
  -d "$body" \
  https://api.travis-ci.org/repo/$(echo $TRAVIS_REPO_SLUG | sed -es_/_%2F_)/requests
