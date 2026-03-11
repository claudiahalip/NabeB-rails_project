# CLAUDE.md — Project Context

## Overview
NabeB is a neighborhood business directory web application. Users can browse businesses by neighborhood or category, and logged-in users can add and manage business listings. The app supports both traditional email/password signup and Google OAuth2 login.

## Tech Stack
- **Ruby version:** 3.2.0
- **Rails version:** ~> 7.0.8
- **Database:** SQLite3 (development/test), PostgreSQL (production)
- **Frontend:** Webpacker 5.0, Turbolinks 5, SCSS (sass-rails)
- **App server:** Puma ~> 6.0

## Authentication
- **Method:** `has_secure_password` (bcrypt) — no Devise
- **OAuth:** OmniAuth with Google OAuth2 (`omniauth-google-oauth2`)
- **Session management:** Manual — `session[:user_id]` stored on login
- **Helpers:** `current_user` and `logged_in?` defined in `ApplicationHelper` (included in `ApplicationController`)
- **Login route:** `POST /login` → `session#create`
- **OAuth callback:** `GET /auth/google_oauth2/callback` → `session#omniauth`
- **Signup:** `GET/POST /signup` → `users#new` / `users#create`
- **Logout:** `DELETE /logout` → `session#destroy`

## Key Models & Relationships

### User
- `has_secure_password`
- `has_many :businesses`
- Fields: `username`, `email`, `password_digest`, `uid`, `provider`
- Validates presence and uniqueness of `username` and `email`
- Class method `create_from_omniauth(auth)` handles OAuth user creation

### Business
- `belongs_to :neighborhood`
- `belongs_to :user`
- `belongs_to :category`
- Fields: `name`, `description`, `website`, `phone_number`, `neighborhood_id`, `user_id`, `category_id`
- Validates presence of `name`, `description`, `phone_number`
- Validates uniqueness of `name`, `website`, `phone_number`
- Scopes: `alpha_sort` (order by name), `search_business(params)` (LIKE search on name/description)
- Accepts nested attributes for `category` via `category_attributes=`
- Custom writer `neighborhood_name=` for find-or-create by name

### Category
- `has_many :businesses`
- `has_many :neighborhoods, through: :businesses`
- Fields: `name`
- Validates presence and uniqueness of `name`

### Neighborhood
- `has_many :businesses`
- `has_many :categories, through: :businesses`
- Fields: `name`, `city`, `state`, `zipcode`
- Validates presence of all fields; uniqueness of `name` scoped to `zipcode`
- Scope: `search_neighborhood(params)` (LIKE search on name)
- Class method `sort_nebe_businesses` — returns all neighborhoods sorted by business count (descending)
- **Note:** `NeighborhoodsController` calls `alpha_sort` scope on `Neighborhood`, but this scope is not defined in the model — this is a known bug.

## Authorization Rules
- **Public (not logged in):** Can view businesses, neighborhoods, categories
- **Logged in:** Can create businesses, categories, neighborhoods
- **Owner only:** Can edit and delete their own business listings
- Enforced via `before_action :require_login` and `before_action :authorize_owner!` in `BusinessesController`
- `require_login` is defined in `ApplicationController`; redirects to login on failure
- `authorize_owner!` checks `@business.user == current_user`; redirects to businesses index on failure

## Key Routes
```
root 'welcome#welcome'

GET  /auth/google_oauth2/callback → session#omniauth
GET  /login                       → session#new
POST /login                       → session#create
DELETE /logout                    → session#destroy

GET  /signup                      → users#new
POST /signup                      → users#create
GET  /user/:id                    → users#show

resources :businesses             (full CRUD)
resources :categories, only: [:new, :create]
resources :neighborhoods do
  resources :businesses           (nested — scoped by neighborhood)
end
resources :users

match '*unmatched', to: 'application#route_not_found', via: :all
```

## Gems of Note
| Gem | Purpose |
|-----|---------|
| `bcrypt` | Password hashing for `has_secure_password` |
| `omniauth` | OAuth framework |
| `omniauth-google-oauth2` | Google OAuth2 strategy |
| `omniauth-rails_csrf_protection` | CSRF protection for OmniAuth |
| `webpacker` | JavaScript bundling |
| `turbolinks` | SPA-like page navigation |
| `sass-rails` | SCSS stylesheet support |
| `dotenv-rails` | Environment variable management (dev/test) |
| `jbuilder` | JSON API responses |
| `pry` | REPL/debugger |
| `byebug` / `debug` | Debugging (dev/test) |
| `capybara` + `selenium-webdriver` | System testing |
| `pg` | PostgreSQL adapter (production only) |
| `sqlite3` | SQLite adapter (dev/test only) |

## Setup
```bash
bundle install
cp .env.example .env  # fill in GOOGLE_CLIENT_ID and GOOGLE_CLIENT_SECRET
rails db:create db:migrate db:seed
rails server
```

Environment variables required (`.env` in development):
- `GOOGLE_CLIENT_ID` — Google OAuth2 client ID
- `GOOGLE_CLIENT_SECRET` — Google OAuth2 client secret

## Coding Conventions
- Controllers use `before_action` for auth guards
- Session-based authentication (no tokens/JWT)
- `ApplicationHelper` included in `ApplicationController` (not typical Rails default)
- Search uses raw SQL LIKE with `LOWER()` for case-insensitive matching
- Nested resources for businesses under neighborhoods
- Flash keys used: `:error`, `:alert`, `:messages`
- 404 fallback via catch-all route → `application#route_not_found`

## Known Issues / TODOs
- `Neighborhood` model is missing the `alpha_sort` scope, but `NeighborhoodsController#index` calls it — this will raise a `NoMethodError`
- `categories_controller.rb` and `session_controller.rb` behavior should be verified for completeness
- No authorization on `NeighborhoodsController` edit/update/destroy — any logged-in user can edit or delete any neighborhood
- No test coverage currently (test gems are in Gemfile but no test files appear to exist)
- `users_controller.rb` `resources :users` is declared but only `show`, `new`, and `create` actions are implemented
