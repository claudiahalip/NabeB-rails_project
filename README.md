# NabeB — Neighborhood Business Directory

NabeB is a Ruby on Rails web application that lets users discover and manage local businesses organized by neighborhood and category. Users can sign up with an email/password or via Google OAuth, then browse, add, edit, and delete business listings.

## Technology Stack

- **Ruby** 3.2.0
- **Rails** 7.0.8
- **Database** SQLite (development & test) / PostgreSQL (production)
- **Authentication** BCrypt (password hashing) + OmniAuth Google OAuth2
- **JavaScript** Webpacker 5 / Turbolinks

---

## Prerequisites

### macOS

Install [Homebrew](https://brew.sh) if you haven't already:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install system dependencies:

```bash
brew install rbenv ruby-build node yarn sqlite3
```

### Linux (Ubuntu/Debian)

```bash
sudo apt-get update
sudo apt-get install -y build-essential libssl-dev libreadline-dev zlib1g-dev \
  libsqlite3-dev nodejs yarn git curl
# Install rbenv
curl -fsSL https://github.com/rbenv/rbenv-installer/raw/HEAD/bin/rbenv-installer | bash
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc
```

---

## Ruby & Rails Setup

### 1. Install Ruby 3.2.0

Using rbenv (recommended):

```bash
rbenv install 3.2.0
rbenv global 3.2.0
ruby --version   # should output: ruby 3.2.0 ...
```

### 2. Install Bundler

```bash
gem install bundler
```

---

## Project Setup

### 3. Clone the repository

```bash
git clone https://github.com/claudiahalip/NabeB-rails_project.git
cd NabeB-rails_project
```

### 4. Install Ruby dependencies

```bash
bundle install
```

### 5. Install JavaScript dependencies

```bash
yarn install
```

### 6. Configure environment variables

Copy the example env file and fill in your values:

```bash
cp .env.example .env
```

Open `.env` and set the following:

| Variable | Description |
|---|---|
| `GOOGLE_CLIENT_ID` | Your Google OAuth client ID |
| `GOOGLE_CLIENT_SECRET` | Your Google OAuth client secret |

**To get Google OAuth credentials:**
1. Go to [Google Cloud Console](https://console.developers.google.com/)
2. Create a new project (or select an existing one)
3. Navigate to **APIs & Services → Credentials**
4. Click **Create Credentials → OAuth 2.0 Client IDs**
5. Set the application type to **Web application**
6. Add `http://localhost:3000/auth/google_oauth2/callback` as an **Authorized redirect URI**
7. Copy the Client ID and Client Secret into your `.env` file

> **Note:** Google OAuth is optional for local development. The app fully supports email/password login. You can skip setting up OAuth and still sign up/log in normally.

---

## Database Setup

### 7. Create and migrate the database

```bash
rails db:create
rails db:migrate
```

Or use the all-in-one setup command:

```bash
rails db:setup
```

---

## Start the Server

### 8. Launch the Rails server

```bash
rails server
```

Then open [http://localhost:3000](http://localhost:3000) in your browser.

---

## Quick Start — Copy & Run

All the commands you need, in order:

```bash
# 1. Install Ruby (if not already installed)
rbenv install 3.2.0 && rbenv global 3.2.0

# 2. Clone and enter the project
git clone https://github.com/claudiahalip/NabeB-rails_project.git
cd NabeB-rails_project

# 3. Install dependencies
gem install bundler
bundle install
yarn install

# 4. Set up environment variables
cp .env.example .env
# Edit .env with your Google OAuth credentials (optional)

# 5. Set up the database
rails db:setup

# 6. Start the server
rails server
```

---

## Application Features

- **User accounts** — Sign up with username/email/password or Google OAuth
- **Businesses** — Create, view, edit, and delete business listings
- **Neighborhoods** — Browse businesses by neighborhood
- **Categories** — Filter businesses by category
- **Search** — Full-text search across business names and descriptions

---

## Project Structure

```
app/
  controllers/    # Application controllers (businesses, users, session, etc.)
  models/         # ActiveRecord models (Business, User, Neighborhood, Category)
  views/          # ERB templates
  helpers/        # View helpers (current_user, logged_in?, etc.)
  assets/         # CSS stylesheets and images
  javascript/     # Webpacker JavaScript packs
config/
  database.yml    # Database configuration (SQLite dev/test, PostgreSQL prod)
  routes.rb       # URL routing
  initializers/   # Initializer files (OmniAuth config, etc.)
db/
  migrate/        # Database migrations
```

---

## Environment Variables

| Variable | Required | Description |
|---|---|---|
| `GOOGLE_CLIENT_ID` | Optional | Google OAuth app client ID |
| `GOOGLE_CLIENT_SECRET` | Optional | Google OAuth app client secret |
| `DATABASE_URL` | Production only | Full PostgreSQL connection URL |
| `RAILS_MASTER_KEY` | Production only | Rails credentials master key |
| `RAILS_MAX_THREADS` | Optional | Max DB pool size (default: 5) |

---

## Troubleshooting

### `bundle install` fails with Psych or YAML errors
Make sure you're using Ruby 3.2.0: `ruby --version`. Ruby 3.1+ uses Psych 4 by default; the project has been updated accordingly.

### `yarn install` fails
Make sure Node.js (v14+) and Yarn are installed:
```bash
node --version
yarn --version
```

### SQLite errors on macOS
```bash
brew install sqlite3
bundle config set build.sqlite3 "--with-sqlite3-dir=$(brew --prefix sqlite3)"
bundle install
```

### Port 3000 already in use
```bash
rails server -p 3001
```

### Google OAuth redirect URI mismatch
Make sure `http://localhost:3000/auth/google_oauth2/callback` is listed as an authorized redirect URI in your Google Cloud Console project.

---

## Notes for Developers

- This project uses **Webpacker 5** for JavaScript bundling. Run `./bin/webpack-dev-server` in a separate terminal for faster JS compilation in development (optional but recommended).
- The application uses **SQLite** for local development and **PostgreSQL** for production. No PostgreSQL installation is needed to run the project locally.
- Environment variables are loaded by the `dotenv-rails` gem in development and test environments. Never commit your `.env` file.
- The `spring` pre-loader has been removed from this project to avoid compatibility issues with Ruby 3+. Commands like `rails server` and `rails console` may take a moment longer to start, but will work reliably.

---

## License

(c) 2021 Claudia Vamesu Halip
