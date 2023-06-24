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
### APK
:warning::warning::warning::warning::warning::warning::warning::warning::warning:

### Супер важная информация!!!

Если хочешь запустить релизную сборку на эмуляторе Android, нужно обязательно поставить эмулятор **x86-x64** 

Иначе приложение будет вылетать при запуске :t-rex: :skull_and_crossbones: :skull_and_crossbones: :skull_and_crossbones:

:warning::warning::warning::warning::warning::warning::warning::warning::warning:

Ссылка для скачивания: https://github.com/darkwolf999/todo/releases/tag/2.0.0
___
### Скриншоты

<p float="center">
  <img src="https://github.com/darkwolf999/todo/blob/home_work_2/screenshots/1.JPG" width="250" />
  <img src="https://github.com/darkwolf999/todo/blob/home_work_2/screenshots/2.JPG" width="250" /> 
  <img src="https://github.com/darkwolf999/todo/blob/home_work_2/screenshots/3.JPG" width="250" />
</p>
