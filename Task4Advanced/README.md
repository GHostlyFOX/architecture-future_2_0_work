# Task 4 Advanced: Моделирование домена и интеграций (DDD + Event Storming)

В данной директории содержатся артефакты проектирования системы "Будущее 2.0" с использованием подходов Domain-Driven Design (DDD) и Event-Driven Architecture (EDA).

## Структура

*   `bounded-contexts.puml`: Схема Bounded Contexts (Ограниченных контекстов) и их взаимосвязей (Upstream/Downstream, ACL). Отражает разделение системы на Медицинский, Финтех, ИИ и Аналитический домены.
*   `event-storming.puml`: Диаграмма Event Storming, визуализирующая ключевой бизнес-процесс (от регистрации пациента до диагностики и оплаты) через последовательность Команд, Событий и Агрегатов.
*   `aggregates.md`: Описание ключевых агрегатов (`Patient`, `MedicalRecord`, `DiagnosticOrder`, `BankAccount`, `LoanApplication`), их границ транзакционности и инвариантов.
*   `events.md`: Каталог доменных событий (Domain Events) с примерами payload и семантикой.
*   `justification.md`: Обоснование выбора событийного подхода (EDA) по сравнению с текущей архитектурой (DWH + Camel ESB).

## Как просмотреть диаграммы

Диаграммы описаны на языке PlantUML. Для просмотра можно использовать:
1.  Онлайн-редактор [PlantText](https://www.planttext.com/) или [PlantUML Server](http://www.plantuml.com/plantuml/).
2.  Плагины для IDE (VS Code, IntelliJ IDEA).
