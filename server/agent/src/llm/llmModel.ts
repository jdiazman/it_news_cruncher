export interface NewsArticle {
  title: string
  summary: string
  source: string
  url?: string
  tags: string[]
}

export interface Briefing {
  date: string
  articles: NewsArticle[]
}