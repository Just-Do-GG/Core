# Core

Godot addon / модуль для взаємодії ігор з Server.

## Призначення
Спільна логіка для всіх ігор Just-Do-GG:
- Авторизація (Guest, Google, Apple)
- HTTP клієнт для API сервера
- Збереження/завантаження сейвів
- Отримання LiveOps конфігів

## Як використовується
Підключається як git submodule у кожну гру:
```
game-1/addons/core/  →  Just-Do-GG/Core
```

## Залежності
- Godot 4.6+
- HTTPRequest nodes
- JSON (вбудований)
