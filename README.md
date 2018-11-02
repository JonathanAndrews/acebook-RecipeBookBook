# RecipeBookBook

This is a facebook clone that was developed by four awesome developers over two weeks.

## Motivation

The overall goal of this project was to improve our Agile Development practices.

## Build Status

[![Build Status](https://travis-ci.com/JonathanAndrews/acebook-RecipeBookBook.svg?branch=master)](https://travis-ci.com/JonathanAndrews/acebook-RecipeBookBook)
[![Maintainability](https://api.codeclimate.com/v1/badges/06873fca63b8f1abdcda/maintainability)](https://codeclimate.com/github/JonathanAndrews/acebook-RecipeBookBook/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/06873fca63b8f1abdcda/test_coverage)](https://codeclimate.com/github/JonathanAndrews/acebook-RecipeBookBook/test_coverage)

## Tech used

### Core Stack
- React - Front End
- Rails - Back End
  - devise - User Authentication
  - Action Mailer - Email Confirmation
- PostgreSQL - Database

### Continuous Deployment and Continuous Integration
- Travis - CI
- Heroku - CD

### Development

- RSpec - Unit Testing
  - Factory Bot - Doubling and Mocking
  - Database Cleaner - Clean database after each test
- Jest/Enzyme - Testing react components
- SimpleCov - Test Coverage
- RuboCop - Linter

## Features

```
As a User,
So that I can have a unique account,
I can Sign up.

As a User,
So that I can use my account,
I can Sign in.

As a User,
So that I can socialise online,
I can Post messages.

As a User,
So that I can interact online,
I can Comment on Posts.

As a User,
So that I can interact online,
I can see who authored a Comment or a Post.

As a User,
So that I can correct typos,
I can edit Posts and Comments.

As a User,
So that I can remove evidence of drunkness,
I can delete Posts and Comments.

```
## Local Development for Rails API

Install Dependencies and Setup Databases

```bash
> bundle install
> bin/rails db:create
> bin/rails db:migrate
```

Run Tests and Server

```bash
> bundle exec rspec # Run the tests to ensure it works
> bin/rails server -p 3001 # Start the server at localhost:3001
```

## Local Development for React front-end 

To run the react server open up another terminal

Install dependencies
```bash
> cd recipebookbook-frontend
> npm install
```

Run Tests and Server

```bash
> npm test
> npm start
```

## Contributing to the Project

Pull Requests are always welcome.

When you edit the code, please run `bundle exec rspec` to check all the tests pass.
Also run the linter `rubocop` to formatting of your code before you git commit.

Ensure the PR description clearly describes the problem and solution. It should include the relevant issue number, if applicable.

## Deploying to Heroku

__Heroku Set Up__
1. Create a Heroku account
1. Install the Heroku command line tools `brew install heroku/brew/heroku`
1. Create the Heroku application `heroku create app-name`
1. Push the app code to Heroku `git push heroku master`
1. Create the app database on Heroku `heroku run rake db:migrate`
1. Open the app on Heroku `heroku open`
1. You may need to login via the Heroku command line interface (CLI) at any point: `heroku login`
1. On the Heroku website, go to your app console and take a look at the deploy options.

__From there, you can connect to GitHub via the Heroku integration. Select the option to automatically deploy the app to Heroku only when the CI build passes.__

## Current App in Production

### https://recipebookbook.herokuapp.com

## Learning Documentation

### https://github.com/JonathanAndrews/acebook-RecipeBookBook/wiki




