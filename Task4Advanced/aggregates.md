# Описание ключевых агрегатов (Future 2.0)

В рамках Domain-Driven Design (DDD) выделены следующие ключевые агрегаты, обеспечивающие целостность данных в пределах своих транзакционных границ.

## 1. Домен Медицина (Medicine Domain)

### Агрегат: `Patient` (Пациент)
*   **Контекст:** Patient Management Context
*   **Корневая сущность:** `Patient`
*   **Атрибуты:** `PatientID` (Root Key), `FullName`, `DateOfBirth`, `ContactInfo` (VO), `InsuranceDetails` (VO).
*   **Инварианты:**
    *   Пациент должен иметь уникальный идентификатор (СНИЛС/Паспорт).
    *   Дата рождения не может быть в будущем.
*   **Связанные сущности:** Нет (агрегат самодостаточен для регистрации).

### Агрегат: `MedicalRecord` (Медицинская карта / Визит)
*   **Контекст:** Medical Records Context
*   **Корневая сущность:** `Visit` (или `Encounter`)
*   **Атрибуты:** `VisitID` (Root Key), `PatientID` (Ref), `DoctorID` (Ref), `VisitDateTime`, `Status` (Scheduled, InProgress, Completed, Cancelled).
*   **Дочерние сущности:** `Diagnosis`, `Prescription`, `Vitals`.
*   **Инварианты:**
    *   Визит не может быть завершен без установленного диагноза (предварительного или основного).
    *   Врач не может назначить визит самому себе.

### Агрегат: `DiagnosticOrder` (Направление на диагностику)
*   **Контекст:** Diagnostics & AI Context
*   **Корневая сущность:** `DiagnosticOrder`
*   **Атрибуты:** `OrderID` (Root Key), `VisitID` (Ref), `TestType` (MRI, CT, Blood), `Status` (Ordered, SampleCollected, Analyzing, Completed).
*   **Дочерние сущности:** `AIAnalysisResult` (содержит вероятность патологии, выделенные области на снимке).
*   **Инварианты:**
    *   Результат анализа не может быть изменен после утверждения врачом-диагностом.

## 2. Домен Финтех (Fintech Domain)

### Агрегат: `BankAccount` (Банковский счет)
*   **Контекст:** Core Banking Context
*   **Корневая сущность:** `Account`
*   **Атрибуты:** `AccountID` (Root Key), `CustomerID` (Ref to Patient/Person), `Balance`, `Currency`.
*   **Дочерние сущности:** `Transaction`.
*   **Инварианты:**
    *   Баланс дебетового счета не может быть отрицательным (если нет овердрафта).
    *   Сумма транзакции должна быть больше нуля.

### Агрегат: `LoanApplication` (Заявка на кредит)
*   **Контекст:** Lending Context
*   **Корневая сущность:** `Application`
*   **Атрибуты:** `ApplicationID` (Root Key), `CustomerID`, `RequestedAmount`, `Purpose` (Medical, Consumer), `Status` (New, Scoring, Approved, Rejected).
*   **Дочерние сущности:** `CreditScore` (VO).
*   **Инварианты:**
    *   Кредит не может быть выдан, если скоринговый балл ниже порогового значения.
    *   Сумма кредита не должна превышать лимит для данного типа продукта.

## 3. Взаимосвязи
Агрегаты ссылаются друг на друга только по ID (Weak References). Согласованность между агрегатами обеспечивается через доменные события (Eventual Consistency).
