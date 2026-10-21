# ControlFinan

**English** | [Português](README.pt-BR.md)

![Ruby](https://img.shields.io/badge/Ruby-2.5-CC342D?logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/Rails-4.2-CC0000?logo=rubyonrails&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-11-4169E1?logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?logo=docker&logoColor=white)

A web app for personal finance control. Each user records their income (credits) and expenses (debits) across accounts such as cash, banks and ride-hailing wallets, and tracks the balance by day, by account and by month.

The expense categories come ready-made for ride-hailing drivers: rides, fuel, car wash, car rental, parking, fines and maintenance, among others.

## Table of contents

- [What it is for](#what-it-is-for)
- [Features](#features)
- [Tech stack](#tech-stack)
- [Running with Docker](#running-with-docker)
- [How to use](#how-to-use)
- [Project structure](#project-structure)
- [Known limitations](#known-limitations)

## What it is for

- Record day-to-day money movements: how much came in, how much went out, from which account and in which category.
- Check the balance of a specific day or the overall balance.
- See the month's result on the dashboard, with ride totals minus fuel, car wash and phone costs.
- Keep data separated per user: each person only sees their own entries.

## Features

| Screen | Route | What it does |
|---|---|---|
| Conta Corrente (current account) | `/` | Lists the user's entries, newest first, with pagination and the overall balance |
| New entry | `/current_accounts/new` | Creates a credit or a debit |
| Detail, edit and delete | `/current_accounts/:id` | Shows, changes or removes an entry |
| Daily balance lookup | `/search_account` | Takes a date and shows that day's entries and balance |
| Dashboard | `/dashboard` | A balance-by-date form and four tabs for the current month: Saldo Diário (daily balance), Por Conta (by account), Corridas (rides) and Saldo Mensal (monthly balance) |
| Moviment | `/moviments` | Summary by expense groups |
| Entries as JSON | `/current_accounts.json` | Same listing as the main screen, for integrations |

### Entry fields

- **Account:** Cash, Itaú, Santander, CEF Poupança, PagSeguro, Uber, Platinum Itaú, Banco do Brasil or 99Pop.
- **Category:** Fuel, Central, Car rental, Lunch, Snack, Miscellaneous, Rides, Phone, Car wash, Transfer, Deposits, Parking, Taxes, Fines, Maintenance or Uber trips.
- **Type:** Credit (adds to the balance) or Debit (subtracts from it).
- **Date**, as `dd/mm/yyyy`.
- **Amount**, positive, for example `150.00`. The sign comes from the type.
- **History:** optional free text.

The balance is the sum of `amount × type`, that is, credits minus debits.

The interface and the account and category names are in Portuguese.

## Tech stack

Ruby 2.5, Rails 4.2, PostgreSQL, Devise (authentication), Bootstrap 3, bootstrap-datepicker and will_paginate. The development environment runs on Docker.

## Running with Docker

Requirements: Docker and Docker Compose.

1. Create the `config/database.yml` file, which is not versioned:

   ```yaml
   default: &default
     adapter: postgresql
     encoding: unicode
     pool: 5
     host: <%= ENV.fetch("DB_HOST", "localhost") %>
     username: <%= ENV.fetch("DB_USER", "controlfinan") %>
     password: <%= ENV.fetch("DB_PASSWORD", "controlfinan") %>

   development:
     <<: *default
     database: controlfinan_development

   test:
     <<: *default
     database: controlfinan_test
   ```

2. Start the containers:

   ```
   docker compose up -d
   ```

   The first time, the image is built and the gems are installed, which takes a few minutes. The container creates the database and runs the migrations by itself.

3. Open http://localhost:3000. From another machine, use the IP or hostname of the computer running the app, on port 3000.

### Creating the first user

There is no default user. Pick one of the options:

- Through the UI: go to `/users/sign_up` and enter an email and password (at least 8 characters).
- Through the console:

  ```
  docker compose exec web bundle exec rails c
  User.create!(email: "you@email.com", password: "yourpassword123", password_confirmation: "yourpassword123")
  ```

### Useful commands

| Action | Command |
|---|---|
| View logs | `docker compose logs -f web` |
| Rails console | `docker compose exec web bundle exec rails c` |
| Run migrations | `docker compose exec web bundle exec rake db:migrate` |
| Stop | `docker compose down` |
| Stop and delete the database | `docker compose down -v` |

The `PGconn, PGresult, and PGError constants are deprecated` warnings in the logs are normal: they come from the 0.x `pg` gem that Rails 4.2 requires and do not indicate a problem.

## How to use

1. Sign in with your email and password.
2. Under **Conta Corrente**, click **New Current account**.
3. Choose the account, the category and whether it is a credit or a debit. Enter the date, the amount and, optionally, a history. Click **Salvar**.
4. In the listing, use **Show** and **Edit** to view or fix an entry.
5. To check a day's balance, use the daily balance lookup and enter the date.
6. On the **Dashboard**, follow the month: balance per day, totals per account, rides and monthly balance.

## Project structure

- `app/models/current_account.rb`: the entry, with the accounts, categories, validations and balance calculations.
- `app/models/user.rb`: the user (Devise); has many entries.
- `app/controllers/current_accounts_controller.rb`: entry CRUD and daily balance lookup.
- `app/controllers/static_pages_controller.rb`: dashboard and moviment.
- `Dockerfile`, `docker-compose.yml` and `docker-entrypoint.sh`: development environment.

## Known limitations

- Accounts and categories are hard-coded, not editable tables.
- The dashboard calculations use the current month; there is no way to pick another month.
- Rails 4.2 no longer receives security updates. Do not expose this app to the internet without upgrading it first.
