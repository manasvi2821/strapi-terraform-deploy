# 🚀 DevOps Internship Task - Strapi CMS Setup

![Strapi Logo](https://raw.githubusercontent.com/strapi/strapi/main/docs/assets/images/strapi-logo.png)

This repository demonstrates the **Strapi CMS setup**. It covers running Strapi locally, creating a **sample content type**, and documenting all steps with visuals and a Loom walkthrough.

---

## 🛠 Technologies & Tools
| Tool/Technology | Version/Notes                  |
|-----------------|--------------------------------|
| Node.js          | 18+                            |
| npm / yarn       | Latest stable                  |
| Strapi CMS       | v4.x                           |
| Git & GitHub     | For version control & PR       |

---


## ⚡Steps to run locally
- Open the Admin Panel: http://localhost:1337/admin
- Create an admin account
- Explore folder structure and Content-Type Builder
- Create the sample content type


## Steps Performed to explore strapi & create sample content-type
1. Cloned Strapi repo: [https://github.com/strapi/strapi](https://github.com/strapi/strapi)
2. Installed dependencies using `npm install`
3. Started Strapi locally with `npm run develop`
4. Accessed Admin Panel at `http://localhost:1337/admin`
5. Created an admin user
6. Explored folder structure:
   - `/src`, `/config`, `/public`, `package.json`
7. Created a sample Content Type `Blog` with fields:
   - Title (Text)
   - Description (Rich Text)
   - Published Date (Date)
   - Author (text)
8. Added a few sample entries
9. Pushed the setup to GitHub repo under branch `manasvi-sharma`


## 🚀 Steps to Run Docker-compose

1. Build images -> docker-compose build
2. Start containers -> docker-compose up -d
3. Check running containers -> docker ps
4. Access Strapi at -> http://localhost/admin
5. Stop containers -> docker-compose down


## 🚀 Steps to Deploy Strapi on AWS EC2 with Terraform & Docker

- 1. Build & Push Docker Image
   docker build -t <dockerhub-username>/strapi-app .
   docker push <dockerhub-username>/strapi-app

- 2. Configure Terraform
      - Providers
      - Variables
      - user-data
      - outputs

- 3. Deploy with terraform
      - terraform init
      - terraform plan
      - terraform apply

- 4. Access strapi app
      - http://<EC2_PUBLIC_IP>:1337
      
- 5. Destroy 
      - terraform destroy


## Loom Video
- TASK-1
🔗 [Loom Video Link](https://www.loom.com/share/8c5968aa68c84e80a3669db47c34d510?sid=2967c912-04e4-4337-aaf0-95b94b8aae47)  

- TASK-2
🔗 [Loom Video Link](https://www.loom.com/share/ee203d86def142039836a223f6b7bf62?sid=0d95cf66-73d2-4fdf-a23c-e18db47921c7)

- TASK -3 
🔗 [Loom Video Link](https://www.loom.com/share/f26fd5eca69c48ee82e6792696810438?sid=bad90da1-b603-4fc3-80d2-583c1c14a845)

- TASK-4
🔗 [Loom Video Link](https://www.loom.com/share/8e5f4ff1321747f79035d07b0382500b?sid=d25ae940-8381-4d66-9577-1d5791d615dd)