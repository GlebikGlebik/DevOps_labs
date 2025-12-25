#!/bin/bash
echo "=== Минимальная демонстрация ==="
echo ""

# Очистка
docker-compose -f docker-compose-bad.yml down 2>/dev/null
docker-compose -f docker-compose-good.yml down 2>/dev/null
docker-compose -f docker-compose-isolated.yml down 2>/dev/null

echo "1. Плохой файл (порт 80):"
docker-compose -f docker-compose-bad.yml up -d
sleep 2
curl -s http://localhost | head -2
echo "Версия: $(docker exec my_web_app nginx -v 2>&1 | cut -d'/' -f2)"
echo "Пользователь: $(docker exec my_web_app whoami)"
docker-compose -f docker-compose-bad.yml down
echo ""

echo "2. Хороший файл (порт 8080):"
docker-compose -f docker-compose-good.yml up -d
sleep 2
curl -s http://localhost:8080 | head -2
echo "Версия: $(docker exec good_web nginx -v 2>&1 | cut -d'/' -f2)"
docker-compose -f docker-compose-good.yml down
echo ""

echo "3. Изолированный файл (порт 8081):"
docker-compose -f docker-compose-isolated.yml up -d
sleep 2
curl -s http://localhost:8081 | head -2
echo "Проверка изоляции:"
docker exec isolated_web ping -c 1 isolated_db 2>&1 | head -1
docker-compose -f docker-compose-isolated.yml down
echo ""
echo "Демонстрация завершена."
