#!/bin/bash

echo "=== ДЕМОНСТРАЦИЯ ВСЕХ ВАРИАНТОВ ==="
echo ""

echo "1. ПЛОХОЙ ВАРИАНТ (порт 80):"
echo "Запускаем..."
docker-compose -f docker-compose-bad.yml up -d
sleep 2
echo "Сайт работает:"
curl -s http://localhost | head -2
echo ""
echo "Проблемы:"
echo "  - Latest тег:"
docker exec my_web_app nginx -v
echo "  - Секреты в коде:"
docker exec my_web_app printenv DB_PASSWORD | head -c 20
echo "..."
echo "  - Запуск от root:"
docker exec my_web_app whoami
echo "  - Нет изоляции (web → db):"
docker exec my_web_app ping -c 1 my_db >/dev/null && echo "    МОЖЕТ общаться" || echo "    НЕ МОЖЕТ общаться"
docker-compose -f docker-compose-bad.yml down
echo ""

echo "2. ХОРОШИЙ ВАРИАНТ (порт 8080):"
echo "Запускаем..."
docker-compose -f docker-compose-good.yml up -d
sleep 2
echo "Сайт работает:"
curl -s http://localhost:8080 | head -2
echo ""
echo "Улучшения:"
echo "  - Фиксированная версия:"
docker exec good_web nginx -v
echo "  - Пароль БД не в коде web"
echo "  - Контейнеры в одной сети (могут общаться):"
docker exec good_web ping -c 1 good_db >/dev/null && echo "    МОГУТ общаться" || echo "    НЕ МОГУТ общаться"
docker-compose -f docker-compose-good.yml down
echo ""

echo "3. ИЗОЛИРОВАННЫЙ ВАРИАНТ (порт 8081):"
echo "Запускаем..."
docker-compose -f docker-compose-isolated.yml up -d
sleep 2
echo "Сайт работает:"
curl -s http://localhost:8081 | head -2
echo ""
echo "Сетевая изоляция:"
echo "  - Web пытается пинговать БД:"
docker exec isolated_web ping -c 1 isolated_db 2>&1 | head -1
echo "  - Разные сети:"
WEB_NET=$(docker inspect isolated_web --format '{{range .NetworkSettings.Networks}}{{.NetworkID}}{{end}}')
DB_NET=$(docker inspect isolated_db --format '{{range .NetworkSettings.Networks}}{{.NetworkID}}{{end}}')
if [ "$WEB_NET" != "$DB_NET" ]; then
    echo "    ✅ Сети РАЗНЫЕ"
else
    echo "    ❌ Сети ОДИНАКОВЫЕ"
fi
docker-compose -f docker-compose-isolated.yml down
echo ""
echo "Демонстрация завершена!"
