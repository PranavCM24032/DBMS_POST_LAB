# 🔬 Aura Clinical Trial Management System (CTMS)

A professional, database-driven platform for managing clinical investigations, patient enrollment, and safety monitoring.

## 🚀 Key Modules (DBMS Laboratory)

This project implements all four modules of the Clinical Trial Management System lab:
- **Module 1**: Database Design (ER-Diagram & Schema)
- **Module 2**: DDL & DML Commands (Table creation and record management)
- **Module 3**: Advanced Querying (Joins & Aggregate Functions)
- **Module 4**: Complex Subqueries (Trial logic & site monitoring)

## 🛠️ Features

- **Trial Portfolio**: Track studies from Phase I to IV with real-time status updates.
- **Subject Directory**: Manage patient demographic and medical history.
- **Safety Monitoring**: Log and track Adverse Events (AEs) with severity levels.
- **Analytics Dashboards**: Interactive reports reflecting complex SQL query results.
- **Aura UI**: Premium teal-themed interface with glassmorphism and smooth animations.

## 📥 Getting Started

### 1. Database Initialization
1. Execute `database/clinical_trial_schema.sql` in your MySQL environment.
2. The schema includes all sample data and pre-configured views for analytics.

### 2. Backend Setup
1. Activate your virtual environment and install dependencies:
   ```bash
   pip install -r backend/requirements.txt
   ```
2. Configure `.env`: Update `DB_USER` and `DB_PASSWORD` if necessary.

### 3. Execution
1. Start the Flask server:
   ```bash
   python backend/app.py
   ```
2. Open `http://localhost:5000` to access the Aura CTMS platform.

## 📂 Project Architecture

```bash
clinical-trial-system/
├── database/    # SQL Schemas (DDL/DML/Views)
├── backend/     # Flask API (Includes Subquery logic)
├── frontend/    # Aura UI (HTML, CSS, JS)
├── .env         # System Config
└── README.md    # Lab Documentation
```
