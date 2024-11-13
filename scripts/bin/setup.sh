#!/bin/sh
# This is test sh file to create project from scratch.
# I will modify this file leather for my personal needs.

echo "Setting up test project..."

REPOSITORY=$1
DIRECTORY="./$2"

if [ -z "$REPOSITORY" ] || [ -z "$DIRECTORY" ]; then
    echo "Please provide both a repository and target directory."

    exit 1
fi

git clone $REPOSITORY $DIRECTORY
cd $DIRECTORY

cp .env.example .env
sed -i '' 's/DB_DATABASE=.*/DB_DATABASE=laravel/' .env
sed -i '' 's/DB_USERNAME=.*/DB_USERNAME=root/' .env
sed -i '' 's/DB_PASSWORD=.*/DB_PASSWORD=password/' .env

composer install
php artisan key:generate
php artisan migrate:fresh --seed

npm install
npm run dev

open -a "/Applications/Visual Studio Code.app" "`pwd`"