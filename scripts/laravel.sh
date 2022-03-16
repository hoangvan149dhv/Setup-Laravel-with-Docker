#!/usr/bin/env bash



source <(grep -v '^#' .env | sed -E 's|^(.+)=(.*)$|: ${\1=\2}; export \1|g')
projectName=$PROJECT_NAME
laravelVersion=$LARAVEL_VERSION



# Check user set project name
if [ "$PROJECT_NAME" == "" ]; then
	projectName=Laravel_$(date +'%d-%m-%Y')
fi

# Check version
if [ "$LARAVEL_VERSION" == "" ]; then
	laravelVersion=5.8.*
fi

cd html

composer create-project --prefer-dist laravel/laravel $projectName "$laravelVersion"

# Run php-fpm
php-fpm