# Setup Laravel by Docker

## Step 1 (Option). Setup .env 
- Open file `.env` change `PROJECT_NAME` to set project name (default `laravel_example`) and change version laravel `LARAVEL_VERSION`.
- When we run docker-compose, it automatic create project name`laravel_example` in folder `./www/`
- **Note: Project already installed dependencies (composer, generate encryption key, npm)**

```
PROJECT_NAME=laravel_example
LARAVEL_VERSION=7.*
```
## Step 2 (Required). Start Docker 
- Run `docker-compose up -d` command to build container.
```
docker-compose up -d
```
- If you want to execute migrate, npm, restart composer,... 
```
docker exec -it app /bin/bash
cd html/your_project_name
composer install
npm install
npm run watch/dev/prod
```
## Step 3 (Required). Create virtualhost in project
- **Note: Please stay your path in repo here. Ex: /home/{name}/your_repo**
- Run command 
```
sudo ./scripts/create-virtualhost.sh {your_domain} {your_project_in_path_www}
``` 
- Ex: I created project name `laravel` and my domain `laravel.local`. After ran `docker-compose` `laravel` was created in path `./www/laravel`
- Then I run `sudo ./scripts/create-virtualhost.sh laravel.local laravel`
- Check the service online at http://laravel.local/
![Screenshot from 2022-03-20 12-54-18](https://user-images.githubusercontent.com/64452682/159150132-28d24152-b07f-4942-bd48-29e1144c8186.png)

## Contact

* Duong Hoang Van | [hoangvan149dhv@gmail.com](hoangvan149dhv@gmail.com)
