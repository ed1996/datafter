### Getting Started Projetc Datafter
nouveau test
Add publishable_key and secret_key 
in files config => initialiszers => stripe.rb 

#### Update slug user, hommage and message:
```markdown
    rails c
    User.find_each(&:save)
    Hommage.find_each(&:save)
    Message.find_each(&:save)
```

#### Fake card stripe:
Number: 4242424242424242
Date: > today
CVC: 123

Init variables environment: config/local_env.yml

    - For send email: gmail_username and gmail_password and 
    - connect db mysql dev (MYSQL_HOST, MYSQL_PASSWORD, MYSQL_USERNAME and DATABASE_NAME)
    
1. Clone project "datafter":

```markdown
git clone git@gitlab.devinci.fr:datadeath/datafter.git
```

2. Install Rails at the command prompt if you haven't yet:
```markdown
 gem install rails
```
3. Change directory to "datafter":

```markdown
cd datafter
```

4. Install bundler for install dependencies project "Gemfile":
```markdown
 gem install bundler
 bundle install
```
    
Option config app development:
```markdown
export RAILS_ENV=development
```
 
5. Replace auth: id and secret => providers [GOOGLE and FACEBOOK]
- local_env.yml
    - Copy `cp config/_env.yml config/local_env.yml`
- Generate keys:
    - For GOOGLE: https://medium.com/@pablo127/google-api-authentication-with-oauth-2-on-the-example-of-gmail-a103c897fd98
    - For FACEBOOK: https://elfsight.com/blog/2017/10/how-to-get-facebook-access-token/
    - Edit local_env.yml: `GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET ` and ` FACEBOOK_CLIENT_ID, FACEBOOK_CLIENT_SECRET` 

6. LAUNCH migrate db and set env=development
```markdown
rake db:create
rails db:migrate RAILS_ENV=development
```

7. Run project Serve
```markdown
rails s (or) rails server
```

Run with --help or -h for options.

8. Go to http://localhost:3000 and you'll see: "Yay! You’re on Rails!"

9. Follow the guidelines to start developing your application. You may find the following resources handy:

    - Getting Started with Rails
    - Ruby on Rails Guides
    - The API Documentation
    - Ruby on Rails Tutorial

    
### Add heroku remotes
Using Heroku CLI:

```markdown
heroku git:remote -a project
heroku git:remote --remote heroku-staging -a project-staging
```
Serve
rails s
Deploy
With Heroku pipeline (recommended)
Push to Heroku staging remote:
```markdown
git push heroku-staging
```
Go to the Heroku Dashboard and promote the app to production or use Heroku CLI:
```markdown
heroku pipelines:promote -a project-staging
```
Directly to production (not recommended)
Push to Heroku production remote:
```markdown
git push heroku    
```
Go to the Heroku Dashboard and promote the app to production or use Heroku CLI:
```markdown
heroku pipelines:promote -a project-staging
```
### CI/CD with Auto DevOps

This template is compatible with [Auto DevOps](https://docs.gitlab.com/ee/topics/autodevops/).

If Auto DevOps is not already enabled for this project, you can [turn it on](https://docs.gitlab.com/ee/topics/autodevops/#enabling-auto-devops) in the project settings.
