# race-day-ST10471198-L-Ramasuvha-prog6212
# RaceDay - Event Management System

## System Description

RaceDay is a full-stack web-based event management system designed for the South African road running, walking, and cycling community. The platform allows Event Organisers to create and manage events, categories, and participant results, while Participants can browse upcoming events, enter events, and track their personal performance history.

---

## Roles in the System

### Participant
- Register for an account and manage their profile
- Browse and search for upcoming events
- Enrol in event categories
- View their enrolment history and results
- Withdraw from events
- View public event information (weather, categories, results)

### Organiser
- Create, update, and delete events
- Manage event categories (distances, start times, fees, age restrictions)
- Oversee participant enrolments
- Record and update participant results
- Manage weather data for events
- View event statistics and reports

---

## Database Schema

The system uses a relational database with the following entities:

| Entity | Description |
|--------|-------------|
| **Organiser** | Event organisers who create and manage events |
| **Event** | Running events with details like date, location, capacity |
| **Category** | Race categories within events (e.g., Elite Men, Open Women) |
| **Participant** | Registered athletes who enrol in events |
| **Result** | Participant results including finish times and positions |
| **Weather** | Weather forecasts associated with events |

### Entity Relationships

- **Organiser (1) → Event (M)**: One organiser manages many events
- **Event (1) → Category (M)**: One event has many categories
- **Event (1) → Weather (M)**: One event has many weather forecasts
- **Event (1) → Result (M)**: One event generates many results
- **Participant (1) → Result (M)**: One participant has many results
- **Category (1) → Result (M)**: One category has many participant results

---

## API Endpoints Overview

| Resource | Endpoints | Description |
|----------|-----------|-------------|
| **Authentication** | 2 | Register and login |
| **User Profile** | 3 | Profile management and enrolments |
| **Events** | 5 | CRUD operations for events |
| **Categories** | 4 | Category management |
| **Enrolments** | 4 | Participant enrolment management |
| **Results** | 5 | Result recording and retrieval |
| **Weather** | 4 | Weather data management |
| **Dashboard** | 2 | Organiser and participant dashboards |
| **Total** | **29** | |

---

## Getting Started

### Prerequisites
- SQL Server Management Studio (SSMS)
- SQL Server instance

### Database Setup

1. **Clone the repository:**
```bash
git clone https://github.com/yourusername/RaceDay.git
cd RaceDay
```

2. **Run the SQL script:**
   - Open SQL Server Management Studio
   - Connect to your SQL Server instance
   - Open `docs/RaceDay_Database.sql`
   - Execute the script (F5)

3. **Verify the database:**
   - The script creates a database called `RaceDay`
   - 6 tables are created with sample data
   - Check the Messages tab for success confirmations

### Sample Data
The database is seeded with:
- 2 Organisers
- 3 Events
- 6 Categories (2 per event)
- 3 Participants
- 6 Weather records
- 6 Results/Enrolments

---

## CI/CD Pipeline

### GitHub Actions Workflow
The repository includes a GitHub Actions workflow that validates:
- Repository structure
- Presence of /docs folder
- Required files in /docs (ERD, endpoint plan, SQL script)



## Video Presentation

An unlisted YouTube video walkthrough covering:
- ERD decisions and design choices
- Endpoint plan reasoning
- SQL script demonstration
- Live execution in SSMS



## Contributors

Lufuno Ramasuvha

