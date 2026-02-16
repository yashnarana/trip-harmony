# Trip Harmony - Readme

### Project Members
Kathleen Duffey, Yashna Rana, Yusen Peng, Lucas Kronenfeld

### Submission Date
12/07/2024

## Ruby Gem Requirements
```ruby
source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.0.0"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 2.1"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_cable"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: true

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
gem 'devise'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end

gem "cssbundling-rails", "~> 1.4"
gem "rails-controller-testing"
```

## Introduction
Have you ever found yourself tangled in messy spreadsheets or endless group chats trying to figure out "who owes what" after a trip or group event? Say goodbye to the hassle! Split The Bill is here to simplify your life.

Split The Bill is a web application designed to make group expense management effortless. Whether you’re planning a dream vacation, organizing a team outing, or sharing a meal with friends, this app ensures everyone pays their fair share—quickly, accurately, and stress-free.

Why struggle with the math when you can let Split The Bill do the work for you? Create trips, add participants, track expenses, and split costs—all with an intuitive, user-friendly platform that works for groups of any size.

With Split The Bill, focus on what truly matters: creating memories, not managing money.

   > "Trips with friends are not just about the destination—they're about the memories, laughter, and connections that turn moments into lifelong stories."
&mdash; William Butler Yeats


## How To Contribute - TODO

If you have ideas to contribute and make our project better, we always welcome new contributions.  There are two types
of additions that can be made - code additions and bug reports.  Below, we will walk through how to complete each.

## How To Use - TODO

### Reporting Bugs

Bugs are a frequent issue that can arise during program execution.  We are constantly working to improve our code, so
if you find a bug, please report it to the "Issue Tracker" of the repository.  Below are the steps to report a bug.

1. Check that the bug has not already been reported

   <i>Navigate to the "Issues" tab and browse the reported issues to confirm yours has not already been reported</i> 

2. Check that the most recent version of main still contains the bug and has not been patched
3. Navigate to the "Issues" tab and click the <b> New Issue </b> button
4. Title your issue report in a concise and descriptive manor
5. Fill in the body of your request with a clear description of the problem and as much information about the bug as possible
6. If you know how to fix the bug or can create a test case to verify the bug's existance, open a pull request as detailed below


### Becoming a Contributor

In order to preserve the integrity of the project, you must do all work on a personal fork to be committed into the project.
As a prerequisite, you must have already set up Git with Github.

1. Create a personal fork of the project to work on
2. Clone the central branch to a personal remote repository

   ```text
   git clone git@github.com:cse3901-2024au-1020/proj6-betadev
   ```

3. Consistently pull from the central repo to keep code up to date
4. Follow the coding convention of the project as detailed below
5. Run/update tests to ensure correctness and incrementally unit test any new methods
6. Submit a pull request to the main branch and wait for approval

### Project convention
If you want to become a project contributor, you must follow convention for this project.

Google HTML Style Guide: https://google.github.io/styleguide/htmlcssguide.html

<b>HTML Basic Convention</b>
- Declare doc type at the beginning of every page
- Use UTF-8 encoding
- Comment code when needed to explain purpose, coverage, and solution
- Separate alll CSS from HTML pages

<b>CSS Basic Convention</b>
- Use valid CSS styling when possible
- Use meaningful class names for each CSS element
- Keep class names short as possible while still being descriptive

<b>Variable naming convention: </b>
- Use snake_case for methods and variables.
- Use CamelCase for classes and modules. (Keep acronyms like HTTP, RFC, XML uppercase.)
- Use SCREAMING_SNAKE_CASE for other constants.


<b>Commit convention:</b>
- One branch per new feature
- Commit each action separately with meaningful commit messages
- Commit message formatted: branch name - commit message


<b>Workflow convention:</b>
- Before sending to central repo send a pull request

<b>Coding design convention:</b>
- Each function does one job

## How To Set Up

1. **Environment Setup:**
   - Ensure you have Ruby (version 3.3.3) installed on your machine. You can verify the installed version by running the following command:
     ```bash
     ruby -v
     ```
     If Ruby is not installed or the version is incorrect, you can install the correct version using a Ruby version manager like `rbenv` or `rvm`.

   - Install the latest version of [Visual Studio Code](https://code.visualstudio.com/).

2. **Install Bundler:**
   - Bundler helps manage project dependencies. To install Bundler, run:
     ```bash
     gem install bundler
     ```

3. **Clone the Repository:**
   - Clone the project repository into your working directory by running:
     ```bash
     git clone <repository-url>
     ```
     Replace `<repository-url>` with the actual Git repository URL.

   - After cloning, navigate to the project directory:
     ```bash
     cd <project-directory>
     ```
     Replace `<project-directory>` with the name of the folder the repository is cloned into.

4. **Install Dependencies:**
   - Now that you're inside the project directory, install all required gem dependencies by running:

     ```bash
     bundle install
     ```

   - Also, we need to install all npm dependencies as well:

     ```bash
     npm install
     ```

## How To Test

Our testing work for this project is split into two parts:

1. JavaScript Testing
2. Ruby Testing (models and controllers)

For JavaScript testing, just run the following command:

```bash
npm test
```

For Ruby Testing, it further splits into model testing and controller testing. However, we need to prepare the database for testing purposes:

```bash
rails db:test:prepare
```

For the model section, run the following commands to test them:

```bash
rails test test/models/user_test.rb
rails test test/models/trip_test.rb
rails test test/models/expense_test.rb
rails test test/models/user_trip_test.rb
rails test test/models/user_expense_test.rb
```

For the controller section, run the following commands to test them:

```bash
rails test test/controllers/users_controller_test.rb
rails test test/controllers/trips_controller_test.rb
rails test test/controllers/expenses_controller_test.rb
```

## Works Cited

“About Pull Requests.” GitHub Docs, Github, https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/about-pull-requests. Accessed 17 Sept. 2024.

“About Readmes.” GitHub Docs, Github, https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes#about-readmes. Accessed 17 Sept. 2024.

Airbnb. “Airbnb/Ruby: Ruby Style Guide.” GitHub, 14 Nov. 2019, https://github.com/airbnb/ruby#whitespace. Accessed 11 Sept. 2024

“Fork a Repository.” GitHub Docs, Github, https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo. Accessed 17 Sept. 2024.

Google HTML/CSS Style Guide, google.github.io/styleguide/htmlcssguide.html. Accessed 20 Oct. 2024. 


## Important Notes About HTML
Due to a recent update with W3C and rails, hidden inputs for forms cause errors for validation checkers.  This is
because HTML generation by the rails form link was changed to fix issues with Firefox's mal behaivor.  In order to 
correct for this in the validator, please make sure to alter the checker to disgregard this behaivor, as it causes 
no major issues overall.

To read more about this, check this forum post on the topic: https://stackoverflow.com/questions/74256523/rails-button-to-fails-with-w3c-validator
