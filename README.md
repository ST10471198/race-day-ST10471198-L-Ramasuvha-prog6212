# RaceDay - Event Management System
---
## 🏃 System Overview

**RaceDay** is a full-stack web-based event management system designed specifically for the South African road running, walking, and cycling community. The platform streamlines event management by replacing paper-based registration, spreadsheets, and disconnected communication channels with a unified digital solution.

### Key Features:
- 📅 **Event Management**: Create, update, and manage events
- 🏷️ **Category Management**: Define race categories with distances, fees, and age restrictions
- 👥 **Participant Enrolment**: Browse events and enrol in categories
- 📊 **Results Tracking**: Record and view participant results and positions
- 🌤️ **Weather Integration**: View weather forecasts for events
- 🔐 **Role-Based Access**: Separate interfaces for Organisers and Participants

---

## 👥 System Roles

### 🏅 Participant
| Feature | Description |
|---------|-------------|
| Account Management | Register, login, and update profile |
| Event Discovery | Browse and search for upcoming events |
| Enrolment | Enrol in event categories |
| History | View enrolment history and personal results |
| Withdrawal | Withdraw from events before the start |
| Public Viewing | View event details, weather, categories, and results |

### 🎯 Organiser
| Feature | Description |
|---------|-------------|
| Event Management | Create, update, and delete events |
| Category Management | Define distances, start times, fees, age restrictions |
| Enrolment Oversight | View and manage participant enrolments |
| Results Recording | Record and update participant results |
| Weather Data | Manage weather forecasts for events |
| Reporting | View event statistics and participant reports |

---

## 🗄️ Database Schema

### Entity Relationship Diagram (ERD)
┌─────────────────┐ ┌─────────────────┐
│ Organiser │ │ Participant │
├─────────────────┤ ├─────────────────┤
│ OrganiserID (PK)│ │ ParticipantID(PK)│
│ Name │ │ Name │
│ Email │ │ Email │
│ Phone │ │ PasswordHash │
│ PasswordHash │ │ DateOfBirth │
│ CreatedAt │ │ IdNumber │
└────────┬────────┘ │ EmergencyContact │
│ │ CreatedAt │
│ 1 └────────┬────────┘
│ │
│ M │ M
▼ ▼
┌─────────────────┐ ┌─────────────────┐
│ Event │─────────▶│ Result │
├─────────────────┤ M ├─────────────────┤
│ EventId (PK) │ │ ResultID (PK) │
│ OrganiserID (FK)│ │ EventID (FK) │
│ Name │ │ ParticipantID(FK)│
│ Description │ │ CategoryID (FK) │
│ Date │ │ FinishTime │
│ Location │ │ Position │
│ MaxParticipants │ │ Status │
│ Status │ └─────────────────┘
└────────┬────────┘ ▲
│ 1 │
│ │
▼ │
┌─────────────────┐ ┌─────────────────┐
│ Category │──────────│ │
├─────────────────┤ M │ │
│ CategoryID (PK) │ │ │
│ EventID (FK) │ │ │
│ Name │ │ │
│ DistanceKM │ │ │
│ StartTime │ │ │
│ AgeMin │ │ │
│ AgeMax │ │ │
│ EntryFee │ │ │
└─────────────────┘ └─────────────────┘
▲
│ 1
│
▼
┌─────────────────┐
│ Weather │
├─────────────────┤
│ WeatherID (PK) │
│ EventID (FK) │
│ ForecastDate │
│ Temperature │
│ Condition │
│ WindSpeed │
│ Humidity │
└─────────────────┘


### Database Tables

| Entity | Description | Fields |
|--------|-------------|--------|
| **Organiser** | Event organisers who create and manage events | OrganiserID, Name, Email, Phone, PasswordHash, CreatedAt |
| **Participant** | Registered athletes who enrol in events | ParticipantID, Name, Email, PasswordHash, DateOfBirth, IdNumber, EmergencyContact, CreatedAt |
| **Event** | Running events with details | EventId, OrganiserID, Name, Description, Date, Location, MaxParticipants, Status |
| **Category** | Race categories within events | CategoryID, EventID, Name, DistanceKM, StartTime, AgeMin, AgeMax, EntryFee |
| **Result** | Participant results including finish times | ResultID, EventID, ParticipantID, CategoryID, FinishTime, Position, Status |
| **Weather** | Weather forecasts associated with events | WeatherID, EventID, ForecastDate, Temperature, Condition, WindSpeed, Humidity |

### Relationships
- **Organiser (1) → Event (M)**: One organiser manages many events
- **Event (1) → Category (M)**: One event has many categories
- **Event (1) → Weather (M)**: One event has many weather forecasts
- **Event (1) → Result (M)**: One event generates many results
- **Participant (1) → Result (M)**: One participant has many results
- **Category (1) → Result (M)**: One category has many participant results

---

## 🔗 API Endpoints

### Endpoint Summary

| Resource | Endpoints | HTTP Methods | Description |
|----------|-----------|--------------|-------------|
| **Authentication** | 3 | POST | Register/Login |
| **Organisers** | 4 | GET, PUT, DELETE | Organiser management |
| **Participants** | 5 | GET, PUT, DELETE | Participant management |
| **Events** | 5 | GET, POST, PUT, DELETE | Event CRUD operations |
| **Categories** | 4 | GET, POST, PUT, DELETE | Category management |
| **Results** | 8 | GET, POST, PUT, DELETE | Result recording/retrieval |
| **Weather** | 3 | GET, POST, PUT, DELETE | Weather data management |
| **Enrolments** | 5 | GET, POST, PUT, DELETE | Enrolment management |
| **Total** | **37** | - | |

### Detailed Endpoint Plan

| HTTP Method | Route | Description | Role Required |
|-------------|-------|-------------|---------------|
| **Authentication** |
| POST | `/api/auth/register/organiser` | Register a new organiser | Public |
| POST | `/api/auth/register/participant` | Register a new participant | Public |
| POST | `/api/auth/login` | Login and get JWT token | Public |
| **Organisers** |
| GET | `/api/organisers` | Get all organisers | Organiser |
| GET | `/api/organisers/{id}` | Get organiser by ID | Organiser (own) |
| GET | `/api/organisers/me` | Get current organiser profile | Organiser |
| PUT | `/api/organisers/me` | Update organiser profile | Organiser |
| DELETE | `/api/organisers/me` | Delete organiser account | Organiser |
| **Participants** |
| GET | `/api/participants` | Get all participants | Organiser |
| GET | `/api/participants/{id}` | Get participant by ID | Participant (own)/Organiser |
| GET | `/api/participants/me` | Get current participant profile | Participant |
| PUT | `/api/participants/me` | Update participant profile | Participant |
| DELETE | `/api/participants/me` | Delete participant account | Participant |
| **Events** |
| GET | `/api/events` | Get all events | Public |
| GET | `/api/events/{id}` | Get event by ID | Public |
| POST | `/api/events` | Create new event | Organiser |
| PUT | `/api/events/{id}` | Update event | Organiser (creator) |
| DELETE | `/api/events/{id}` | Delete event | Organiser (creator) |
| **Categories** |
| GET | `/api/categories/event/{eventId}` | Get categories for event | Public |
| POST | `/api/categories/event/{eventId}` | Create category | Organiser (event creator) |
| PUT | `/api/categories/{id}` | Update category | Organiser (event creator) |
| DELETE | `/api/categories/{id}` | Delete category | Organiser (event creator) |
| **Results** |
| GET | `/api/results/event/{eventId}` | Get results for event | Public |
| GET | `/api/results/participant/{participantId}` | Get participant results | Participant (own)/Organiser |
| GET | `/api/results/participant/me` | Get current participant results | Participant |
| POST | `/api/results/event/{eventId}` | Record result | Organiser (event creator) |
| PUT | `/api/results/{id}` | Update result | Organiser (event creator) |
| DELETE | `/api/results/{id}` | Delete result | Organiser (event creator) |
| **Weather** |
| GET | `/api/weather/event/{eventId}` | Get weather for event | Public |
| POST | `/api/weather/event/{eventId}` | Add weather forecast | Organiser (event creator) |
| PUT | `/api/weather/{id}` | Update weather | Organiser (event creator) |
| DELETE | `/api/weather/{id}` | Delete weather | Organiser (event creator) |
| **Enrolments** |
| POST | `/api/enrolments` | Enrol in event | Participant |
| GET | `/api/enrolments/participant/me` | Get my enrolments | Participant |
| GET | `/api/enrolments/event/{eventId}` | Get event enrolments | Organiser |
| PUT | `/api/enrolments/{id}` | Update enrolment status | Participant/Organiser |
| DELETE | `/api/enrolments/{id}` | Withdraw from event | Participant |

---

## 🔧 CI/CD Pipeline

### GitHub Actions Workflow

The repository includes a GitHub Actions CI/CD workflow that automatically validates:

| Validation Check | Description |
|------------------|-------------|
| 📁 Repository Structure | Verifies `doc` folder exists |
| 📄 ERD File | Checks for Entity Relationship Diagram |
| 📊 SQL Script | Validates `script.sql` with required tables |
| 📝 API Plan | Ensures `API_ENDPOINT_PLAN.pdf` exists |
| 📖 README | Confirms `README.md` is present |
| 🔢 Commit Count | Verifies 20+ meaningful commits |
| 🔑 SQL Keywords | Validates CREATE TABLE, PRIMARY KEY, FOREIGN KEY |
| 📈 Table Count | Ensures minimum 6 tables |
| 🌱 Seed Data | Checks for INSERT statements |

### CI/CD Status

![CI/CD Build Passing](screenshot-ci-success.png)

---

## 🚀 Setup Instructions

### Prerequisites
- ✅ SQL Server Management Studio (SSMS)
- ✅ SQL Server instance (Express or Developer edition)
- ✅ Git (for cloning the repository)

### Step 1: Clone the Repository
git clone https://github.com/ST10471198/race-day-ST10471198-L-Ramasuvha-prog6212.git
cd race-day-ST10471198-L-Ramasuvha-prog6212

Step 2: Create the Database
Open SQL Server Management Studio (SSMS)
Connect to your SQL Server instance
Open doc/script.sql
Execute the script (press F5 or click Execute)

Step 3: Verify Database
The script will create:
Database: RaceDayDB
Tables: Organiser, Participant, Event, Category, Weather, Result
Sample data with 2 Organisers, 3 Participants, 3 Events, and associated records

Step 4: Verify Sample Data
Run this query to check the data:
SELECT 'Organiser' AS TableName, COUNT(*) AS RowCount FROM Organiser
UNION ALL
SELECT 'Participant', COUNT(*) FROM Participant
UNION ALL
SELECT 'Event', COUNT(*) FROM Event
UNION ALL
SELECT 'Category', COUNT(*) FROM Category
UNION ALL
SELECT 'Weather', COUNT(*) FROM Weather
UNION ALL
SELECT 'Result', COUNT(*) FROM [Result];


🎬 Video Walkthrough
An unlisted YouTube video covering:

Topic	Description
📊 ERD Design	Explanation of entity relationships and cardinality
🔗 API Planning	Endpoint design decisions and role-based access
🗄️ SQL Script	Database creation and seed data demonstration
🏃 Live Demo	Running the script in SSMS and verifying data

📁 Project Structure
race-day-ST10471198-L-Ramasuvha-prog6212/
│
├── .github/
│   └── workflows/
│       └── validate-docs.yml          # CI/CD workflow
│
├── doc/
│   ├── API_ENDPOINT_PLAN.pdf          # API endpoint specification
│   ├── ERD DIAGRAM                    # Text-based ERD
│   ├── Entity Relationship Diagram.png # Visual ERD
│   └── script.sql                     # Database creation script
│
├── screenshot-ci-success.png           # CI/CD build status
├── README.md                           # Project documentation
└── .gitignore                          # Git ignore rules


👤 Author
Name:	Lufuno Ramasuvha




