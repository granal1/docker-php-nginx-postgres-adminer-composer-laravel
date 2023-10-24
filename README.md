# Docker PHP NGINX PostgreSQL Adminer Composer Laravel

Docker использует Nginx, PHP-FPM, PostgreSQL, Composer, Adminer и Laravel.  
Позволяет легко развернуть требуемую среду для разработки проектов как на основе Laravel, так и без использования фреймворка.
В качестве БД используется PostgreSQL в связке с Adminer.

## Системные требования

...

## Настройка и запуск

1. Загрузка из гит репозитория `git clone https://github.com/granal1/docker-php-nginx-postgres-adminer-composer-laravel.git`  
2. При необходимости перенести проект в требуемую директорию.  
3. Изменение настроек доступа к БД в части имени пользователя, пароля и названия базы данных можно выполнить отредактировав .env  
4. Сборка контейнеров выполняется командой `make build-dev` (`docker-compose build`)   
5. ВАЖНО! Для работы контейнера необходимо, чтобы порты 80, 443, 8080, 5432 были свободны. Это может потребовать остановки запущенных сервисов сервера и БД.


## Начало работы с Composer (без использования фреймворка)

Предварительно необходимо выполнить действия из раздела **[Настройка и запуск](#-Настройка-и-запуск)**

1. Установка Composer осуществляется командой `make composer-install-dev` (`docker-compose run --rm php composer install`)   
2. По умолчанию в composer.json указана библиотека для логироваия "monolog/monolog". Дополнить при необходимости.  
3. Загрузка указанных в composer.json библиотек выполняется командой `make composer-update` (`docker-compose run --rm php`)  
4. Команда запуска контейнера - `make start-dev` (`docker-compose up -d`)  

Дополнительные команды:

- Обновление Composer - `make composer-update` (`docker-compose run --rm php composer update`)  
- Остановка контейнера - `make stop-dev` (`docker-compose down --remove-orphans`)  
- Перезапуск контейнера - `make restart-dev` (`docker-compose down --remove-orphans && docker-compose up -d`)


## Создание нового проекта Laravel

Предварительно необходимо выполнить действия из раздела **[Настройка и запуск](#-Настройка-и-запуск)**

1. Установка Laravel - `make laravel-install` (`docker-compose run --rm php composer create-project laravel/laravel laravel --prefer-dist && -rm -rf ./html/public/* && -mv -f ./html/laravel/.* ./html/laravel/* ./html && -rm -rf ./html/laravel`).  
2. В директории html создать .env по примеру .env.example. Внести в .env настройки работы с БД из .env, находящегося в корне проекта.  
3. Загрузка указанных в composer.json библиотек - `make composer-update` (`docker-compose run --rm php`)  
4. Создание рабочих таблиц в БД - `make database-migrate` (`docker-compose run --rm php php artisan migrate --force`)   
5. Команда запуска контейнера - `make start-dev` (`docker-compose up -d`)  

Дополнительные команды:

- Обновление Composer - `make composer-update` (`docker-compose run --rm php composer update`)  
- Остановка контейнера - `make stop-dev` (`docker-compose down --remove-orphans`)  
- Перезапуск контейнера - `make restart-dev` (`docker-compose down --remove-orphans && docker-compose up -d`)

## Добавление проекта WfMS из существующего репозитория

Предварительно необходимо выполнить действия из раздела **[Настройка и запуск](#-Настройка-и-запуск)**

1. Установка WfMS - `make wfms-install` (`rm -R html && git commit -a -m 'html deleted' &&  git submodule add https://github.com/granal1/WfMS.git html`)  
2. В директории html создать .env по примеру .env.example. Внести в .env настройки работы с БД из .env, находящегося в корне проекта.  
3. Сгенерировать ключ безопасности - `make generate-app-key` (`docker-compose run --rm php php artisan key:generate`)
4. Загрузка указанных в composer.json библиотек - `make composer-update` (`docker-compose run --rm php`)  
5. Создание рабочих таблиц в БД - `make database-migrate` (`docker-compose run --rm php php artisan migrate --force`)   
6. Добавление в БД первичных данных - `make data-seed` (`docker-compose run --rm php composer seed`)   
7. Перекэширование данных - `make laravel-cache` (`docker-compose exec php php artisan cache:clear && docker-compose exec php php artisan config:cache && docker-compose exec php php artisan event:cache && docker-compose exec php php artisan route:cache && docker-compose exec php php artisan view:cache`)  
8. Команда запуска контейнера - `make start-dev` (`docker-compose up -d`)  

Дополнительные команды:

- Заполнение БД фэйковыми демонстрационными данными - `make data-seed`  (`docker-compose run --rm php composer seed`)  
- Запуск обработчика событий - `make laravel-schedule` (`docker-compose run --rm php php artisan schedule:work`)  
- Запуск обработчика очередей - `make laravel-queue` (`docker-compose run --rm php php artisan queue:work`)  
- Остановка контейнера - `make stop-dev` (`docker-compose down --remove-orphans`)  
- Перезапуск контейнера - `make restart-dev` (`docker-compose down --remove-orphans && docker-compose up -d`)  


