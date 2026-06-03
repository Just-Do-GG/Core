# Plan: Core

## Phase 1 — Auth Manager
- [ ] Guest авторизація (UUID + збереження локально)
- [ ] Google OAuth (web view або deep link)
- [ ] Apple Sign In
- [ ] Token refresh

## Phase 2 — API Client
- [ ] HTTP клієнт (HTTPRequest node)
- [ ] Методи: login, save, load, get_config
- [ ] Обробка помилок + reconnection

## Phase 3 — Save System
- [ ] Локальний save (JSON/Resource)
- [ ] Хмарний save через Server API
- [ ] Конфлікти + мерж

## Phase 4 — LiveOps
- [ ] Отримання фічів з сервера
- [ ] Кешування конфігів
- [ ] Інтеграція з ігровими менеджерами
