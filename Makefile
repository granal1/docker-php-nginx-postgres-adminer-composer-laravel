
build-dev:
	docker-compose build

composer-install:
	unzip html.zip
	docker-compose run --rm php composer install

composer-install-dev:
	unzip html.zip
	docker-compose run --rm php composer install

composer-update:
	docker-compose run --rm php composer update

database-migrate:
	docker-compose run --rm php php artisan migrate --force

wfms-install:
	mkdir -m 777 html
	git clone https://github.com/granal1/WfMS.git html

generate-app-key:
	docker-compose run --rm php php artisan key:generate

database-seed:
	docker-compose run --rm php php artisan migrate:fresh --seed

demo-seed:
	docker-compose run --rm php composer seed

laravel-schedule:
	docker-compose run --rm php php artisan schedule:work

laravel-queue:
	docker-compose run --rm php php artisan queue:work

laravel-install:
	mkdir -m 777 html
	docker-compose run --rm php composer create-project laravel/laravel laravel --prefer-dist
	-mv -f ./html/laravel/.* ./html/laravel/* ./html
	-rm -rf ./html/laravel

laravel-cache:
	docker-compose exec php php artisan cache:clear
	docker-compose exec php php artisan config:cache
	docker-compose exec php php artisan event:cache
	docker-compose exec php php artisan route:cache
	docker-compose exec php php artisan view:cache

laravel-storage:
	docker-compose run --rm php php artisan storage:link

restart-dev: stop-dev start-dev

start-dev:
	docker-compose up -d

stop-dev:
	docker-compose down --remove-orphans

upgrade-dev: stop-dev git-pull pull-dev build-dev composer-install-dev database-migrate start-dev

wfms-begin: composer-update start-dev generate-app-key database-migrate database-seed laravel-cache
