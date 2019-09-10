<!-- Build Status -->
<a href="https://travis-ci.org/robertziel/simple_panel_rails_backend">
  <img src="https://travis-ci.org/robertziel/simple_panel_rails_backend.svg" alt="Build Status" />
</a>

# SIMPLE PANEL RAILS API

Staging: https://simple-panel-rails-backend.robertz.co/api/docs

#### REACT CLIENT:
Staging: https://simple-panel-react-client.robertz.co
Repository: https://github.com/robertziel/simple_panel_react_client

#### About service:
* Grape API: `/api`
* Swagger documentation: `/api/docs`

Seed sample user `rake db:seed`:
* email: `hello@robertz.co`
* password: `12345678`

#### ENV
Set in `.env`:
* `CORS_ALLOWED_ORIGINS` - if empty `localhost:3000` is used as default

#### User authentication:
* written from scratch, only `bcrypt` gem is used
  * based on my previous project:
  https://github.com/robertziel/devise_from_scratch
  * using gem `devise_token_auth` would be a quicker solution, I decided to make it on my own instead just for fun
* after successful sign in API returns token used for further authentication active for one day
* user cannot register - should be added from panel `Not implemented yet`
* Other features worth adding in the future (depending on project requirement):
  * new user must confirm email
  * account is locked after N unsuccessful login attempts, then unlocked by token link sent via email
  * forgotten password token link sent via email
  * add last login IP etc.

#### To do:
https://github.com/robertziel/simple_panel_rails_backend/projects/1
