import express from "express"
import "dotenv/config"
import { fetchBriefing } from "./llm/llmAgent"


const app = express()


app.get("/", async (_req, res) => {
  try {
    const briefing = await fetchBriefing()
    console.log(briefing)
    res.status(200).send(briefing)
  } catch (err: any) {
    console.error("Error generating briefing:", err)
    res.status(500).send(`Error: ${err.message}`)
  }
})

const port = process.env.PORT || 8080

app.listen(port, () => {
  console.log(`🚀 it_news_cruncher agent running on port ${port}`)
})
