# Каталог доменных событий (Future 2.0)

В данной таблице представлены ключевые доменные события (Domain Events), обеспечивающие асинхронное взаимодействие между ограниченными контекстами (Bounded Contexts).

| Событие (Event Name) | Контекст-источник (Source) | Семантика и Триггер | Пример Payload (Минимальный контракт) |
|---|---|---|---|
| **PatientRegistered** | Patient Management | Создана новая учетная запись пациента. Триггер: завершение регистрации. | `{ "patientId": "UUID", "name": "Ivanov I.I.", "dob": "1980-01-01" }` |
| **PatientUpdated** | Patient Management | Изменены контактные данные пациента. Триггер: обновление профиля. | `{ "patientId": "UUID", "fieldsChanged": ["phone", "email"] }` |
| **VisitScheduled** | Medical Records | Запланирован визит к врачу. Триггер: запись через портал/колл-центр. | `{ "visitId": "UUID", "patientId": "UUID", "doctorId": "UUID", "dateTime": "2024-05-20T10:00:00Z" }` |
| **VisitCompleted** | Medical Records | Визит завершен, диагноз установлен. Триггер: врач закрывает прием. | `{ "visitId": "UUID", "patientId": "UUID", "diagnosisCode": "ICD-10-J01", "isBillable": true }` |
| **DiagnosticOrdered** | Medical Records | Врач назначил диагностику (МРТ, КТ). Триггер: создание направления. | `{ "orderId": "UUID", "patientId": "UUID", "testType": "MRI_BRAIN", "urgency": "High" }` |
| **DiagnosticResultReady** | Diagnostics & AI | Результат диагностики (включая AI-анализ) готов. Триггер: завершение анализа. | `{ "orderId": "UUID", "resultUrl": "s3://results/...", "aiProbability": 0.95, "findings": ["Tumor detected"] }` |
| **InvoiceCreated** | Core Banking | Выставлен счет за медицинские услуги. Триггер: событие `VisitCompleted` (если услуга платная). | `{ "invoiceId": "UUID", "patientId": "UUID", "amount": 5000.00, "currency": "RUB", "serviceId": "CONSULTATION" }` |
| **InvoicePaid** | Core Banking | Пациент оплатил счет. Триггер: подтверждение транзакции. | `{ "invoiceId": "UUID", "paymentDate": "2024-05-20T11:30:00Z" }` |
| **LoanApplicationReceived** | Lending | Подана заявка на медицинский кредит. Триггер: пациент запрашивает рассрочку. | `{ "applicationId": "UUID", "patientId": "UUID", "amount": 150000.00 }` |
| **LoanApproved** | Lending | Кредит одобрен. Триггер: скоринг пройден успешно. | `{ "applicationId": "UUID", "approvedAmount": 150000.00, "rate": 12.5 }` |
| **LoanRejected** | Lending | В кредите отказано. Триггер: скоринг не пройден. | `{ "applicationId": "UUID", "reason": "Low credit score" }` |

## Принципы проектирования событий
1.  **Immutability:** События неизменяемы после публикации.
2.  **Versioning:** Используется схема версионирования (например, CloudEvents или Schema Registry) для обратной совместимости.
3.  **Idempotency:** Потребители должны быть готовы получать одно и то же событие несколько раз.
