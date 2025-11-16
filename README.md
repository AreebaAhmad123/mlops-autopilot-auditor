# MLOps Autopilot Auditor

![Python](https://img.shields.io/badge/python-3.11-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![FastAPI](https://img.shields.io/badge/FastAPI-powered-brightgreen.svg)
![Gemini](https://img.shields.io/badge/AI-Gemini%202.5%20Flash-orange.svg)

Automated ML repository auditing, fix generation, and GitHub PR creation — fully orchestrated via CLI, API, and n8n.

---

## 🚀 Features

- Auto-clone & scan any **public ML repository**
- Deep **MLOps audit**: CI/CD, Docker, MLflow, testing, structure, reproducibility
- AI-generated fixes (Dockerfile, mlflow.yaml, tests, workflows)
- Automatic **GitHub Pull Request**
- **n8n workflow** for automation
- Email delivery of **HTML audit report**
- Outputs JSON + fix files

---

## 🏗️ Architecture

```mermaid
flowchart TD
    A[n8n Webhook Trigger] --> B[FastAPI /audit]
    B --> C[Repo Cloner (GitPython)]
    C --> D[Auditor Engine]
    D --> E[Gemini 2.5 Flash]
    E --> F[Audit Report JSON]
    E --> G[Fix Generator]
    G --> H[GitHub PR via PyGithub]
    F --> I[Email Report via SMTP]
    H --> I
    I --> J[User]
```

---

## 📁 Project Structure

mlops-autopilot-auditor  
├── auditor/  
│   ├── scanner.py  
│   ├── mlops_rules.py  
│   ├── ai_fixes.py  
│   ├── pr_utils.py  
│   └── emailer.py  
├── api/  
│   └── main.py  
├── cli/  
│   └── audit.py  
├── fixes/  
├── outputs/  
│   └── audit_report.json  
├── tests/  
├── .env  
└── README.md  

---

## 🔧 Environment Setup

Example `.env` file:

GEMINI_API_KEY=your_key  
GEMINI_MODEL=gemini-2.5-flash  
GITHUB_TOKEN=your_token  
SMTP_EMAIL=your@gmail.com  
SMTP_PASSWORD=app_password  
SMTP_SERVER=smtp.gmail.com  
SMTP_PORT=587  

---

## 🖥️ CLI Usage

Run audit on any public GitHub repo:

python -m cli.audit https://github.com/owner/repo

Options:

--output outputs/audit_report.json  
--apply-fixes true  

---

## 🌐 API Usage (FastAPI)

Start server:

uvicorn api.main:app --reload

POST /audit

{  
  "repo_url": "https://github.com/owner/repo"  
}

Response contains:  
- audit score  
- issues  
- generated fixes  
- PR URL (if created)

---

## 🔗 n8n Webhook Trigger

Send POST request to:

https://n8n.yourdomain.com/webhook/mlops-audit

Body:

{  
  "repo_url": "https://github.com/owner/repo"  
}

n8n then calls `/audit` and emails results.

---

## 🔄 Example n8n JSON Node

{  
  "nodes": [  
    {  
      "id": "1",  
      "name": "Webhook",  
      "type": "n8n-nodes-base.webhook",  
      "parameters": {  
        "path": "mlops-audit",  
        "method": "POST"  
      }  
    },  
    {  
      "id": "2",  
      "name": "HTTP Request",  
      "type": "n8n-nodes-base.httpRequest",  
      "parameters": {  
        "url": "http://localhost:8000/audit",  
        "method": "POST",  
        "jsonParameters": true,  
        "options": {},  
        "bodyParametersJson": "{ "repo_url": "={{$json["repo_url"]}}" }"  
      }  
    }  
  ]  
}

---

## 📤 Output Example (audit_report.json)

{  
  "repo": "https://github.com/owner/repo",  
  "score": 82,  
  "issues": [  
    { "id": 1, "type": "docker", "detail": "Missing Dockerfile" },  
    { "id": 2, "type": "mlflow", "detail": "No mlflow.yaml detected" }  
  ],  
  "fixes": {  
    "dockerfile": "Dockerfile generated...",  
    "mlflow": "mlflow.yaml generated..."  
  },  
  "pr_url": "https://github.com/owner/repo/pull/12"  
}

---

## ✉️ Sample HTML Email Report

<html>  
  <body>  
    <h2>MLOps Audit Report</h2>  
    <p><b>Repository:</b> https://github.com/owner/repo</p>  
    <p><b>Score:</b> 82/100</p>  
    <h3>Issues Found:</h3>  
    <ul>  
      <li>Missing Dockerfile</li>  
      <li>No MLflow configuration</li>  
    </ul>  
    <p>Auto-generated fixes have been applied and a PR is ready:</p>  
    <a href="https://github.com/owner/repo/pull/12">View Pull Request</a>  
  </body>  
</html>

---

## ⚙️ How It Works (High-Level)

1. Clone repo using GitPython  
2. Run rule-based + AI audit  
3. Use Gemini 2.5 Flash to generate fixes  
4. Commit & push fixes on a new branch  
5. Create PR via GitHub API  
6. Generate JSON report  
7. Send HTML email report  
8. n8n orchestrates pipeline  

---

## 📬 Contact

For questions, issues, or contributions:  
GitHub: https://github.com/AreebaAhmad123/mlops-autopilot-auditor  
Email: your-email@example.com

---

## 📄 License

MIT License.
