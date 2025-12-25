# Лабораторная 2 (облака)

Для выполнения задания мы взяли файл ```Azure lab team 4```. 

### ШАГ 1. Импортируем файл.

Как и в первой лабораторной сначала импортируем файл себе: 

<div align="center">
    <img width="792" height="779" alt="Снимок экрана 2025-12-25 214609" src="https://github.com/user-attachments/assets/c47f58d6-e88a-49f9-bc02-33e84cbf41b5" />
</div>

### ШАГ 2. Создание таблицы и классификация. 

Поскольку этот этап повторяет задание из 1 лабораторной работы, я пропущу тоноксти и сразу рассмотрим классификацию: 

1) Сначала Определяем IaaS/PaaS/SaaS и классифицируем сервисы по ним через IT Tower:
   1) ```IaaS```: ```Compute```, ```Networking```
   2) ```PaaS/SaaS```: ```Cloud Services```
2) Также по образцу классифицируем сервисы по функциональности через ```Service Family```:
   1) ```Analytics & Integration``` -> Data Factory, Databricks, Power B
   2) ```Database``` -> PostgreSQL, Redis Cache, FireBird
   3) ```Artificial Intelligence``` -> Machine Learning
3) Составляем ```Service Sub Type``` анализируя ```Meter Name``` и ```Meter Sub-Category```

### Анализ различий между таблицами: 
1) ```IT Tower```:
   1) В таблице AWS 29 ```Cloud Services```, основные из них: ```CloudWatch```, ```Lambda```, ```Device Farm```, ```EMR```, ```WorkMail```, ```WorkSpaces```.
      В таблице Azure 22 ```Cloud Services```, основные из них: ```Data Factory```, ```PostgreSQL```, ```Databricks```, ```Redis```, ```Power BI```.
2) Распределение по типам сервисов:
   1) ```IaaS```: в AWS 15%, в Azure 43%
   2) ```PaaS/SaaS``` в AWS 72.5%, в Azure 59.5%

## Создание кросс-провайдерной сервисной модели.

### Сначала нужно создать единую таксонамию.

Так как в таблицах получились разные атрибуты в ```IT Tower```, то нам нужно привести их к одному виду (должны использоваться одни и те же категории).

В итоге получилась такая система категорий в ```IT Tower```: 
1) ```Support & Billing``` — из Support + Tax
2) ```Management & Monitoring``` — из CloudWatch, Budgets
3) ```Developer Tools``` — из Device Farm
4) ```Compute & Serverless``` — из Lambda (особый случай)
5) ```Compute & Containers``` — из EC2 + Container Instances
6) ```Analytics & Big Data``` — из EMR + Databricks
7) ```Business Applications``` — из WorkMail, WorkSpaces, Alexa
8) ```Security & Compliance``` — из Inspector, Detective, Macie
9) ```Mobile Services``` — из Pinpoint, Mobile Analytics, Notification Hubs
10) ```Integration & ETL``` — из Data Factory
11) ```Databases``` — из PostgreSQL, Redis
12) ```Networking``` — из CDN, VPN, Firewall, Traffic Manager
13) ```Artificial Intelligence``` — из Machine Learning
14) ```Analytics & BI``` — из Power BI

Далее по такому же принципу создаем новые семьи и единиц измерения

Далее мы просто берем каждую строку из AWS и Azure и распределяем их в соответствии с новой категорией (изменяя, собственно, сами категории с строках на новые) 

И в итоге у нас получаетс ятакая табличка: 

<div align="center">
    <img width="1212" height="797" alt="image" src="https://github.com/user-attachments/assets/f87759dd-8ecf-49d8-b990-4832ba9873d1" />
</div>
<div align="center">
    <img width="1212" height="718" alt="image" src="https://github.com/user-attachments/assets/12128db1-3208-4af3-92cd-df5a34f91d93" />
</div>

### Вывод.

Вывод: Лабораторная работа успешно выполнена. Создана кросс-провайдерная сервисная модель, объединяющая AWS и Azure в единую систему классификации.
Разработана универсальная таксономия из 14 категорий, позволившая сравнивать сервисы разных провайдеров на сопоставимой основе. Достигнута основная цель — формирование комплексного видения облака без привязки к вендору

