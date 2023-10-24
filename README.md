 
 ### Доступны команды:   
 
 * `make build-dev`: docker-compose build  
 * `make composer-install`: docker-compose run --rm -u 1000:1000 composer composer install  
 * `make composer-update`: docker-compose run --rm php composer update 
 * `make wfms-install`: git submodule add https://github.com/granal1/WfMS.git html
 * `make laravel-install`: docker-compose run --rm -u 1000:1000 composer composer create-project laravel/laravel html --prefer-dist (после установки отредактировать .env и изменить владельца файлов)  
 * `make database-migrate`: docker-compose run --rm php php artisan migrate --force  
 * `make restart-dev`: stop-dev start-dev  
 * `make start-dev`: docker-compose up -d  
 * `make stop-dev`: docker-compose down --remove-orphans  
 * `make update-dev`: down git-pull-dev composer-install-dev database-migrate up  
 * `make upgrade-dev`: stop-dev git-pull pull-dev build-dev composer-install-dev database-migrate start-dev  


