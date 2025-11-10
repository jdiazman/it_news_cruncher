<p align="center">
    <img src="assets/it-news-cruncher-logo.png" alt="it_news_cruncher" width="120" />
</p>

<h1 align="center">IT News Cruncher</h1>

<p align="center">
  <em>Automated daily AI-generated tech briefings — cloud, software, devops, and data in a minute.</em>
</p>

---

## 🚀 Overview

**IT News Cruncher** is a lightweight, serverless agent that runs daily to fetch, summarize, and deliver the latest technology news using an LLM.

It lives entirely on **Google Cloud Platform**, deployed with **Terraform**, and runs on **Cloud Run** via a daily **Cloud Scheduler** trigger. The summaries are generated through the **OpenAI API** and emailed via **SendGrid**.

---

## 🧭 Architecture

```mermaid
graph TD
    A[Cloud Scheduler (Cron)] -->|Pub/Sub trigger| B[Cloud Run - it_news_cruncher]
    B -->|LLM request| C[OpenAI API]
    B -->|Email summary| D[SendGrid / Gmail API]
    B -->|Optional| E[(Firestore / GCS)]
```