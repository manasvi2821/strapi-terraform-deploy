# Strapi Assignment - my-strapi-app

## Steps I followed
1. Created Strapi project: npx create-strapi@latest my-strapi-app --quickstart
2. Created content type "Article" at src/api/article/content-types/article/schema.json
   - fields: title (string), content (richtext), publishedAt (date)
3. Built admin and ran: npm run build && npm run develop
4. Pushed code to branch `Aman` of repository https://github.com/PearlThoughtsInternship/The-Config-Crew

## Run locally
git clone <repo-url>
cd my-strapi-app
npm install
npm run develop
open http://localhost:1337/admin
