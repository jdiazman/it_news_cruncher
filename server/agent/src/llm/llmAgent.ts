import OpenAI from "openai"
import { Briefing } from "./llmModel"

const client = new OpenAI({ apiKey: process.env.OPENAI_API_KEY })

export async function fetchBriefing(): Promise<Briefing> {
  const prompt = `
You are a tech news summarizer. Fetch the most relevant, international, and highest-impact technology stories across these scopes: software engineering, cybersecurity, devops, cloud, ai, data, frontend, backend, and general IT news.
Do not restrict to specific publications. Include official sources (vendor blogs, release notes, security advisories), reputable publications, social media posts from official accounts, GitHub issues/PRs, mailing lists, and other primary sources when they contain important updates, incidents, or changes to widely used services.
Focus on important changes, updates to widely used services, major incidents, security advisories, product launches, significant research, and tooling or platform updates that affect practitioners.

Return a single valid JSON object exactly matching this schema:
{
  "date": "YYYY-MM-DD",
  "articles": [
    {"title": "", "summary": "", "source": "", "url": "", "tags": []}
  ]
}

Requirements:
- Return up to 20 articles total (limit 20). Prefer the most important and globally relevant items.
- Sort articles by importance (most important first).
- Each article must include:
  - title: headline string
  - summary: concise neutral summary focused on impact and technical relevance (1–3 sentences, ~70 words max)
  - source: publication or primary source name (e.g., vendor blog, advisory, official social account)
  - url: direct link to the article or primary source evidence
  - tags: array using one or more of these exact tags:
    ["software engineering","cybersecurity","devops","cloud","ai","data","frontend","backend","general IT news"]
- Use today's date for "date" in YYYY-MM-DD format.
- Do not fabricate sources or URLs. If you cannot verify an article or URL, omit that item.
- Return only the JSON object and nothing else (no explanations, no surrounding text).`

  const response = await client.chat.completions.create({
    model: "gpt-4-turbo",
    messages: [{ role: "user", content: prompt }],
    response_format: { type: "json_object" }
  })

  const json = response.choices[0]?.message?.content ?? "{}"
  return JSON.parse(json) as Briefing
}
