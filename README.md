# To-Do!

To-Do list для школы мобильной разработки Яндекса

---

## Домашнее задание 2

Основные функции:

+ Стейт менеджмент с соблюдением консистентности данных
+ Обращение к бэкенду. Получение/добавление/обновление/удаление записей
+ Хранение данных в локальной бд. Их получение/добавление/обновление/удаление
+ Синхронизация с бэком по следующему принципу: если на бэке произошли какие-либо изменения, они подтягиваются в локальное хранилище смартфона
+ Смена языка с русского на английский и обратно по нажатию кнопки

Помимо этого также базовый функционал:

+ Добавить новую задачу, описав ее текстом и установив ей приоритет и дедлайн
+ Отредактировать уже добавленную задачу
+ Удалить задачу при помощи свайпа вбок, либо на странице редактирования по нажатию кнопки
+ Отметить задачу выполненной при помощи свайпа вбок, либо нажатием на чекбокс задачи
+ Отменить выполнение задачи повторным свайпом вбок
+ Показать / скрыть выполненные задачи
+ Навигация между экранами
___
Дополнительная информация: 

+ В качестве стейт менеджмента используется пакет flutter_bloc https://pub.dev/packages/flutter_bloc
+ В качестве HTTP клиента исопльзуется Dio https://pub.dev/packages/dio
+ Локальная бд организована при помощи Isar https://pub.dev/packages/isar
+ Для ведения логов используется пакет logger https://pub.dev/packages/logger
+ Интернационализация Easy Localization https://pub.dev/packages/easy_localization  

___
### Сборка

Если хотите тестировать приложение со своим токеном, нужно сделать сборку, т.к. релизный APK идет с моим токеном.
1. Склонировать себе репозиторий, перейти в ветку **home_work_3**
2. В корне проекта есть файл **template.env**. В нем есть поля **BASE_URL=""** - адрес бэка. И **AUTH_TOKEN=""** - твой личный токен. Нужно внутри кавычек прописать адрес бэка и свой токен. Адрес бэка прописывать вот в таком формате: ```https://****.******.ru/todobackend```
3. Далее нужно открыть **pubdpec.yaml** и в разделе assets удалить строку: ```- url_token.env```
4. Открыть **main.dart**, закомментировать строку: ```await dotenv.load(fileName: 'url_token.env');``` и раскомментировать находящуюся рядом строку ```//await dotenv.load(fileName: 'template.env');```
5. Собрать проект и пользоваться

___
### APK
:warning::warning::warning::warning::warning::warning::warning::warning::warning:

### Супер важная информация!!!

Если хочешь запустить релизную сборку на эмуляторе Android, нужно обязательно поставить эмулятор **x86-x64** 

Иначе приложение будет вылетать при запуске :t-rex: :skull_and_crossbones: :skull_and_crossbones: :skull_and_crossbones:

:warning::warning::warning::warning::warning::warning::warning::warning::warning:

Ссылка для скачивания: https://github.com/darkwolf999/todo/releases/tag/2.0.0
___
### Скриншоты

<p align="left">
  <img src="https://github.com/darkwolf999/todo/blob/home_work_3/screenshots/1.JPG" width="250" />
  <img src="https://github.com/darkwolf999/todo/blob/home_work_3/screenshots/2.JPG" width="250" /> 
  <img src="https://github.com/darkwolf999/todo/blob/home_work_3/screenshots/3.JPG" width="250" />
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


