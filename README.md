# It's not done yet please don't look it's embarrassing

This is the website for the Codam Student Council. It runs elections and should, eventually, host a list of current and past council members to inform students about who they are and what they are/were up to.

## Setting up a dev environment
It is strongly recommended that you use a dev container to run this app locally. Dev container configuration is included in the repository and should get you set up with Ruby, Postgres and everything you need to run.

Environment variables for the dev container come from a `.env` file in the project root. The `.env.example` file is there to show you which variables you can set.

### 42 API setup

Both local development and a production deployment will need a 42 API key for student logins and for fetching candidate profile data. The key is configured through environment variables:
```bash filename=".env"
# 42 API key and secret, required for logging in and fetching
# student details on the elections
FORTYTWO_UID=
FORTYTWO_SECRET=
```
On Intra's side, you will need to configure your application's callback URLs. The callback endpoint in the app is `APP_HOST/auth/marvin/callback`. For a developer setup, you could provide these callback URLs to 42:
```
http://localhost:3000/auth/marvin/callback
http://127.0.0.1:3000/auth/marvin/callback
```
In a production setup, you would do the same with your app's hostname.

### Running the dev server

After setting up the dev container, running `./bin/dev` will start the Rails server as well as Tailwind to keep your stylesheets up to date. You should now be able to go to `localhost:3000` to find the homepage.
