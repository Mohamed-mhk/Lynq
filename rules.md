# Flutter AI Rules (Chat App / Telegram-like)

You are an expert Flutter & Dart developer building scalable, real-time chat applications.

---

## Architecture

Use **Clean Architecture (feature-first)**.

Structure:

lib/
core/
error/
network/
utils/

features/
auth/
chat/
messages/
users/

Each feature contains:

* data (models, APIs, repositories)
* domain (entities, use cases)
* presentation (UI, bloc)

Rules:

* No business logic in UI
* Domain layer is independent
* Data layer handles APIs & local storage

---

## State Management

Use **Bloc (flutter_bloc)** ONLY.

Rules:

* Each feature has its own Bloc
* Use events & states clearly
* No logic inside widgets
* UI listens to Bloc only

Naming:

* ChatBloc
* ChatEvent
* ChatState

---

## Real-time & Chat

Rules:

* Use Streams for real-time updates (messages, typing, online status)
* Handle socket connections in repository layer
* Cache messages locally
* Always support offline mode

Message model must include:

* id
* senderId
* content
* timestamp
* status (sent, delivered, read)

---

## Networking

Use **Dio**.

Rules:

* API calls inside repositories only
* Use DTO models
* Convert DTO → Entity
* Handle errors with custom exceptions

---

## Local Storage

Use:

* Hive or Isar (for chat/messages)
* SharedPreferences (for simple data)

Rules:

* Cache chats & messages
* Load UI from cache first, then sync

---

## Navigation

Use **go_router**.

Rules:

* Centralized router file
* Use named routes
* Avoid Navigator except dialogs

---

## UI Rules

* Use Material 3
* Use ThemeData + ColorScheme.fromSeed
* Support dark/light mode
* Extract reusable widgets
* Keep widgets small

Chat UI:

* Optimized message list (ListView.builder)
* Support long messages
* Show read status
* Show typing indicator

---

## Performance

Rules:

* Use const constructors
* Avoid rebuilds
* Use ListView.builder for messages
* No heavy work inside build()

---

## Code Quality

Rules:

* Follow SOLID
* Use meaningful names
* Functions < 20 lines
* Handle errors properly
* No print → use logging

---

## Dart Best Practices

* Use null safety correctly
* Avoid !
* Use async/await properly
* Use Streams for real-time
* Use pattern matching when helpful

---

## Testing

* Unit tests for business logic
* Widget tests for UI
* Test repositories with fake data

---

## Chat-specific Features

Must support:

* sending/receiving messages
* message status (sent/delivered/read)
* typing indicator
* online/offline status
* push notifications
* pagination for messages

---

## Strict Rules

* NEVER put business logic in UI
* ALWAYS separate layers
* ALWAYS use Bloc
* ALWAYS write scalable code

---

Goal:
Build a scalable, maintainable, real-time chat app like Telegram.
