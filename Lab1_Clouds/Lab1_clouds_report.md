# Лабораторная 1 (облака)

Для выполнения задания мы взяли файл ```Mapping Rules AWS team 4```. 

### ШАГ 1. Импортируем файл.

Сначала просто импортируем .csv файл в пустую exel табличку с разделением по ```;```:

<div align="center">
    <img width="703" height="779" alt="image" src="https://github.com/user-attachments/assets/dfb8bd77-f24e-45f6-aec4-438ea14043b6" />
</div>

### ШАГ 2. IT Tower.

Так как ```IT Tower``` самый высокий уровень, то и начнем с него. Смотрим по ```Product Code``` и сопоставляем вариант из образца: "```Compute```, ```Database```, ```Storage&Content Delivery```, ```Networking```, ```Cloud Services```, ```Support```"

1) Если указанный сервис это ```IaaS```, тогда соответствующий ```IT Tower```
2) Если это ```PaaS/SaaS```, то ```Cloud Services```
3) Все ```Tax``` это ```Support```

### ШАГ 3. Service Family.

Так как ```Service Family``` это группа ресурсов внутри ```IT Tower```, то эта ячейка либо дублирует значение ячейки из ```IT Tower```, либо, как у ```Cloud Services``` - расшираяет/уточняет его.

Тут тоже в зависимости от конкретного ```Product Code``` и серча в интернете определяем конкретный ```Service Family``` для ```Cloud Services```. 

### ШАГ 4. Service Type. 

Это по сути просто расшифровка ```Product Code``` в читаемом формате.

### ШАГ 5. Service Sub Type. 

Тут смотрим на документацию и ```Usage Type```. Отражает вариант использования конкретного сервиса.

я пользовался этой (и еще несколькими) документацией: https://docs.aws.amazon.com/AmazonS3/latest/userguide/aws-usage-report-understand.html

### ШАГ 6. Service Usage Type.

Тут тоже надо смотреть на документацию + ```Usage Type```. Здесь показывается, как именно измеряется использование сервиса.

### Итоговая таблица: 

<div align="center">
    <img width="1288" height="479" alt="image" src="https://github.com/user-attachments/assets/af301e83-bff8-4f90-a5cf-5875426a6cc6" />
</div>
<div align="center">
    <img width="1293" height="399" alt="image" src="https://github.com/user-attachments/assets/47f91b5a-958b-4535-b841-ab95a4b241ef" />
</div>

### Вывод о иерархии и разбиении. 

1) Была реализована 5-уровневая иерархия, обеспечивающая возможность провести анализ от большего к меньшему (```IT Tower```, ```Service Family```, ```Service Type```,
    ```Service Sub Type```, ```Service Usage Type```).
2) Сервисы были разделены по уровням абстракции:
   1) IaaS (```Amazon EC2```)
   2) PaaS (```AWS Lambda```, ```Amazon EMR```, ```Amazon CloudWatch```)
   3) SaaS (```Amazon WorkMail```, ```Amazon WorkSpaces```)
3) Было проведено разбиение больших сервисов, например, ```Amazon CloudWatch``` был разделен на ```Logs Storage```, ```Metrics```, ```Data Scanned```, ```General```.

Вывод: Таким образом в таблице реализована иерархическая классификация, классификация по асбтрактности и разбиение сервисов на составляющие. 

### ИТОГ. 

В итоге у нас получилась полноценная, связная и исчерпывающая таблица классификации облачных сервисов AWS, от общих категорий (IT Tower) до конкретных моделей потребления (Service Usage Type).
Мы научились читать официальную документацию (что на самом деле сложно), узнали какие бывают уровни классификации web-сервисов и научились их отличать и распределять. 



