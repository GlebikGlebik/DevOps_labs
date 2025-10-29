# Лабораторная 1 (со звездочкой)

В рамказ задания (никаких личных мотивов у нас, конечно же, нет) будем пытаться ~~взломать~~ проверить на уязвимости сайт факультета ВТ университета ИТМО: https://se.ifmo.ru. 

### ШАГ 1. Curl запросы

Для начала, с помощью curl, мы проверили заголовки нескольких сайтов, чтобы выбрать самый вкусный для ~~атаки~~ проверки:

1) Конечно же мы не оставили без внимания ИСУ:
<div align="center">
    <img width="1093" height="368" alt="Проверка ИСУ на использование nginx" src="https://github.com/user-attachments/assets/54f89318-c860-49b3-bd82-896d38e38557" />
</div>

2) Моя "любимая" прогимназия:
<div align="center">
    <img width="1094" height="351" alt="Проверка 81 прогимназии на nginx" src="https://github.com/user-attachments/assets/0529c66f-551a-409b-82b3-c5968b6e45b0" />
</div>

3) И наш злотой билетик:
<div align="center">
    <img width="1094" height="370" alt="Проверка ifmo на nginx (проверку не прошли)" src="https://github.com/user-attachments/assets/d561f28b-c7c7-4e4c-9ee1-4b6029a71607" />
</div>

Вывод: как видно из скриншотов, сайт ifmo.ru, мало того, что полностью не скрыл информацию о server (как сделали в прогимназии), так еще и не спрятал версию, используемого nginx (как сделал ИСУ). Благодаря выставленной на показ версии nginx, злоумышленники точно могут узнать какие именно эксплойты им использовать, а при условии, что версия, используемая на сайте, еще и не обновлена до новейшей (на 8.10.2025 года это nginx/1.29.2), то проблема еще критичнее так как в ней могут содержаться неисправленные уязвимости. А еще есть риск, что такой сайт легко можно найти по устаревшей версии с помощью ботов)

### ШАГ 2. robots.txt и sitemap.xml

Окей, мы нашли потенциально уязвимый сайт, теперь стоит проверить его robots.txt:

<div align="center">
    <img width="1876" height="1039" alt="image" src="https://github.com/user-attachments/assets/4da17edb-c293-46ec-ad90-49dc34113444" />
</div>

Вывод: Можно считать, что robots.txt вообще нет! ```Disallow:``` позволяет всем поисковым ботам (Google, Yandex, Bing и любым другим) индексировать буквально любой файл сайта! Это 100% уязвимость, так как такая организация ```robots.txt``` позволяет поисковым роботам сканировать все файлы сайта, и даже если у пользователя может не быть к ним доступа (мы это еще проверим), злоумышленник может спокойно найти этот файл через кеш поисковика.

Также стоит проверить sitemap.xml:

<div align="center">
    <img width="1115" height="969" alt="sitemap xml" src="https://github.com/user-attachments/assets/c72c8d0d-4ccd-43a3-ace0-fc5ca17e63c6" />
</div>

Вывод: в целом это обычный sitemap, но ```p_l_id```, похоже, идут по порядку, что можно попробовать использовать для перебора страниц (что мы и сделаем в следующем шаге) 

Так как в robots.txt не запрещена никакая индексация, попробуем получить доступ к некоторым страницам сайта

<div align="center">
    <img width="1865" height="510" alt="image" src="https://github.com/user-attachments/assets/1bac23c4-7577-4ad5-8ce4-0384966e077e" />
</div>

Вывод: страницы не находятся

### ШАГ 3. Перебор ffuf.

Теперь мы плавно перебираемся в ```Ubuntu``` для того, чтоб использовать ffuf

1) сначала устанавливаем ffuf:

<div align="center">
    <img width="1206" height="622" alt="image" src="https://github.com/user-attachments/assets/5cce7e5f-cdfd-4c05-a564-b2e0dfb73d3b" />
</div>

2) Теперь пытаемся найти скрытые страницы, вокруг тех, что были в sitemap:
```
gleb@gleb-VirtualBox:~$ ffuf -u "https://se.ifmo.ru/sitemap.xml?p_l_id=FUZZ&quot; -w ids.txt -mc 200

        /'___\  /'___\           /'___\       
       /\ \__/ /\ \__/  __  __  /\ \__/       
       \ \ ,__\\ \ ,__\/\ \/\ \ \ \ ,__\      
        \ \ \_/ \ \ \_/\ \ \_\ \ \ \ \_/      
         \ \_\   \ \_\  \ \____/  \ \_\       
          \/_/    \/_/   \/___/    \/_/       

       v2.1.0-dev
________________________________________________

 :: Method           : GET
 :: URL              : https://se.ifmo.ru/sitemap.xml?p_l_id=FUZZ
 :: Wordlist         : FUZZ: /home/gleb/ids.txt
 :: Follow redirects : false
 :: Calibration      : false
 :: Timeout          : 10
 :: Threads          : 40
 :: Matcher          : Response status: 200
________________________________________________

1543042                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 88ms]
1543039                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 348ms]
1543073                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 292ms]
1543074                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 299ms]
1543084                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 189ms]
1543121                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 204ms]
1543141                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 152ms]
1543148                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 167ms]
1543149                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 186ms]
1543194                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 114ms]
1543195                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 165ms]
1543211                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 149ms]
1543189                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 276ms]
1543212                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 199ms]
1543214                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 254ms]
1543226                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 437ms]
1543242                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 463ms]
1543239                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 468ms]
1543241                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 474ms]
1543248                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 494ms]
1543247                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 517ms]
1543259                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 508ms]
1543047                 [Status: 200, Size: 3543, Words: 5, Lines: 2, Duration: 1722ms]
:: Progress: [301/301] :: Job [1/1] :: 179 req/sec :: Duration: [0:00:01] :: Errors: 0 ::
gleb@gleb-VirtualBox:~$
```

И правда нашлись! Некоторые страницы действительно были указаны в sitemap (этим мы доказываем, что перебор сработал):
<div align="center">
    <img width="1037" height="252" alt="image" src="https://github.com/user-attachments/assets/36d9212c-ba78-45d6-ae7e-fa81e047d530" />
</div>

<br>

а некоторые нет:

<br>

<div align="center">
    <img width="1046" height="210" alt="image" src="https://github.com/user-attachments/assets/32be4e83-8e60-44c2-adf9-576ec38e11fc" />
</div>

<br>

<div align="center">
    <img width="1047" height="254" alt="image" src="https://github.com/user-attachments/assets/f91d623c-23fb-47e7-9923-c45a2bad11dd" />
</div>

Теперь попробуем получить к ним доступ: 

Снова возвращаемся в cmd (мне удобней писать curl в windows):
```
C:\Users\tb>curl -s "https://se.ifmo.ru/?p_l_id=1543039" > page.html

C:\Users\tb>start page.html
```

И действительно мы получаем html код страницы (на 10 экранов командной строки)!!! Для того чтоб это вообще можно было прочитать сразу сохраняем в html документ и выводим: 

<div align="center">
    <img width="1876" height="1041" alt="image" src="https://github.com/user-attachments/assets/a047d8bc-246c-4fc6-b0cf-a14c6172abdb" />
</div>

Вывод: У нас получилось с помощью перебора найти сраницу сайта, которая не была указана в sitemap и получить к ней доступ через перебор p_l_id с помощью ffuf. В браузерной строке видно, что это мой локальный документ, который я открыл в браузере. Скорей всего это старая версия главного экрана, она ей визуально соответствует, но при этом на ней нет иконок у направлений. Также сохраняется функционал, мы можем открывать, например, журналы:  

<div align="center">
    <img width="1872" height="836" alt="image" src="https://github.com/user-attachments/assets/075a74ba-4e0a-4775-a9dc-a4842e680096" />
</div>



