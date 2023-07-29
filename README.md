# To-Do!  
<img src="https://github.com/darkwolf999/todo/blob/home_work_4/screenshots/app_icon.png" width="150" />

Менеджер задач, разработанный в рамках обучения в школе мобильной разработки Яндекса

## Домашнее задание 4

Основные нововведения:
+ Навигация в отдельной сущности TasksNavigation
+ Длинные заметки обрезаются
+ Добавлена тёмная тема
+ Анимации для работы с тасками
+ Цвет высокого приоритета меняется через Firebase Remote config
+ Работает Firebase Crashlytics
+ Настроен CI на Github. Форматирование - линтер - тесты - сборка - деплой
+ TaskModel и TaskDto сгенерированы через freezed
+ Реализовано два флейвора. prod и dev. Различие в названии приложения

<img src="https://github.com/darkwolf999/todo/blob/home_work_4/screenshots/flavors.jpg" width="150" />

+ Приложение распространяется через Firebase App Distribution

<img src="https://github.com/darkwolf999/todo/blob/home_work_4/screenshots/app distribution.jpg" width="300" />

+ Добавлена и работает аналитика Firebase. Добавление, удаление, выполнение/отмена выполнения таски, переход по экранам

<img src="https://github.com/darkwolf999/todo/blob/home_work_4/screenshots/events.PNG" width="300" />

+ Поддержка landscape ориентации и больших экранов

<img src="https://github.com/darkwolf999/todo/blob/home_work_4/screenshots/tablet.PNG" width="800" />

Помимо этого также базовый функционал:
+ Приложение полноценно работает без интернета. Если добавил/удалил у себя таски, при следующем запуске с интернетом данные на сервере обновятся. Либо можно сделать swipe-to-refresh после подключения интернета для обновления главной страницы. Также, если на сервере произошли какие-то изменения, они подтягиваются в смартфон.
+ Добавлен DI
+ Работа с данными в репозитории
+ Написаны unit-тесты, интеграционный тест
+ Навигатор полностью перешел на версию 2.0 (он же router)
+ Есть диплинк для открытия страницы создания таски (см. QR код в самом низу Readme)
+ Диплинк открывается в том числе и из закрытого приложения
+ Добавить новую задачу, описав ее текстом и установив ей приоритет и дедлайн
+ Отредактировать уже добавленную задачу
+ Удалить задачу при помощи свайпа вбок, либо на странице редактирования по нажатию кнопки
+ Отметить задачу выполненной при помощи свайпа вбок, либо нажатием на чекбокс задачи
+ Отменить выполнение задачи повторным свайпом вбок
+ Показать / скрыть выполненные задачи
+ Навигация между экранами
+ Смена языка с русского на английский и обратно по нажатию кнопки
+ Обращение к бэкенду. Получение/добавление/обновление/удаление записей
+ Хранение данных в локальной бд. Их получение/добавление/обновление/удаление
___
Дополнительная информация: 

+ В качестве стейт менеджмента используется пакет flutter_bloc https://pub.dev/packages/flutter_bloc
+ В качестве HTTP клиента исопльзуется Dio https://pub.dev/packages/dio
+ Локальная БД организована при помощи Isar https://pub.dev/packages/isar
+ Для ведения логов используется пакет logger https://pub.dev/packages/logger
+ Интернационализация Easy Localization https://pub.dev/packages/easy_localization  

___
### Сборка

Если хотите тестировать приложение со своим токеном, нужно сделать сборку, т.к. релизный APK идет с моим токеном.
1. Склонировать себе репозиторий, перейти в ветку **home_work_4**
2. В корень проекта закинуть файл **.env**. Ссылка на скачивниае шаблона -> [Скачать](https://disk.yandex.ru/d/8ZNzdQmpnt5XwA). В нем есть поля **BASE_URL=""** - адрес бэка. И **AUTH_TOKEN=""** - твой личный токен. Нужно внутри кавычек прописать адрес бэка и свой токен. Адрес бэка прописывать вот в таком формате: ```https://****.******.ru/todobackend```
Помимо этого там есть поля для настройки Firebase. Все свои значения нужно перенести туда. По названиям можно понять где какое.
4. Добавить google_services.json в android/app
5. Подтянуть зависимости ```flutter pub get```
6. Запустить кодогенерацию:
   
    ```dart run build_runner build --delete-conflicting-outputs```

    ```dart run easy_localization:generate -f keys -o locale_keys.g.dart -O "lib/l10n" -S "assets/translations"```

    ```dart run easy_localization:generate -S "assets/translations" -O "lib/l10n"```

7. Если вдруг надо поменять значения в .env файле, то после изменения запустить команду ```dart run build_runner clean```
   <br/>и только потом ```dart run build_runner build --delete-conflicting-outputs```
   <br/>иначе изменения не вступят в силу!
8. Сборка проекта

   Продакшн сборка (рекомендую её)  
```flutter build apk --flavor prod -t lib/main_prod.dart```
    <br/>Установить на телефон  
```flutter install --flavor prod```

    Либо dev сборка  
```flutter build apk --flavor dev -t lib/main_dev.dart```
    <br/>Установить на телефон  
```flutter install --flavor dev```

9. Чтобы запускать проект из Android studio, нужно справа вверху нажать
<br/>Add Configuration
<br/>Далее '+'
<br/>Flutter
<br/>Задать Name
<br/>Выбрать в качестве Entry point файл main_prod.dart
<br/>Прописать в поле Build flavor значение prod
<br/>Сохранить
<br/>Те же шаги и для dev сборки.

<img src="https://github.com/darkwolf999/todo/blob/home_work_4/screenshots/config.PNG" width="800" />

___
### APK
:warning::warning::warning::warning::warning::warning::warning::warning::warning:

### Супер важная информация!!!

Если хочешь запустить релизную сборку на эмуляторе Android, нужно обязательно поставить эмулятор **x86-x64** 

Иначе приложение будет вылетать при запуске :t-rex: :skull_and_crossbones: :skull_and_crossbones: :skull_and_crossbones:

:warning::warning::warning::warning::warning::warning::warning::warning::warning:

Ссылка для скачивания: https://github.com/darkwolf999/todo/releases/tag/4.0.0
___
### Скриншоты

<p align="left">
  <img src="https://github.com/darkwolf999/todo/blob/home_work_4/screenshots/1.JPG" width="250" />
  <img src="https://github.com/darkwolf999/todo/blob/home_work_4/screenshots/2.JPG" width="250" /> 
  <img src="https://github.com/darkwolf999/todo/blob/home_work_4/screenshots/3.JPG" width="250" />
</p>

___
### Deeplink

Диплинк можно открыть, введя в браузер смартфона адрес:

```darkwolf://todo/task```

Также можно ввести команду в терминале:

```adb shell am start -a android.intent.action.VIEW -c android.intent.category.DEFAULT -d darkwolf://todo/task```

Если не работает adb, вот гайд по его настройке:
https://medium.com/androiddevelopers/help-adb-is-not-found-93e9ed8a67ee

Если лень заморачиваться, вот вам красивый большой QR, через который вы сразу откроете диплинк в приложение (лучше издалека камеру наводить):

<p align="center">
  <img src="https://github.com/darkwolf999/todo/blob/home_work_3/screenshots/qr-code-todo-task.png" width=" 500" />
</p>


