---
name: latest-knowledge
description: 获取并解读最新技术知识，从热门开源项目和 AI 官方动态中提炼关键变化、趋势及其影响。适用于用户询问近期技术热点、AI 官方更新、热门项目，或需要生成最新知识简报时。
---

# Latest Knowledge

以 `youknow` 返回的结构化数据为事实输入，完成采集、筛选和分析。不要仅凭模型已有知识回答“最新”问题，也不要把标题之外的推断写成已确认事实。

## 确定采集范围

根据用户问题选择最小必要数据源：

- GitHub 热门项目、技术栈或编程语言趋势：使用 `github`。
- OpenAI 产品、研究或公司动态：使用 `openai`。
- Anthropic 新闻、研究或 Claude Platform 更新：使用 `claude`。
- AI 官方动态对比：同时使用 `openai` 和 `claude`。
- 未指定领域的“最新知识”或“技术简报”：使用全部三个数据源。

沿用用户给出的时间范围、语言、分类、条数等约束。用户没有指定时：GitHub 使用 `daily`，每个数据源最多取 10 条；需要观察较稳定的趋势时可改用 `weekly`。不要把 OpenAI 的 `category` 与 Claude 的 `scope` 混用。

## 获取 JSON

使用 shell 调用 `npx --yes youknow`，显式指定 `--format json`，不要使用 `--output` 或 Markdown 输出。按需执行以下命令并替换参数：

```bash
npx --yes youknow github --since daily --language typescript --limit 10 --format json --timeout 30000
npx --yes youknow openai --limit 10 --format json --timeout 30000
npx --yes youknow claude --scope all --limit 10 --format json --timeout 30000
```

GitHub 的 `--since` 只使用 `daily`、`weekly` 或 `monthly`；`--language` 使用 GitHub Trending 支持的语言名。OpenAI 可用 `--category` 筛选 RSS 分类。Claude 的 `--scope` 只使用 `all`、`news`、`research` 或 `platform`。

将每次标准输出解析为 JSON，并在分析前检查：

- 顶层对象包含 `source`、`collectedAt`、`total` 和 `items`。
- `items` 是数组，条目包含标题和原始链接。
- OpenAI 与 Claude 条目的 `publishedAt` 是内容发布时间；`collectedAt` 只是采集时间。
- GitHub 的 `metrics.periodStars` 是所选周期内新增 Star，`rank` 是当前榜单位置，二者都不等于项目质量。

若命令失败或输出无法解析，保留原始错误摘要。单个来源失败时继续分析其他成功来源并说明缺失范围；全部来源失败时直接说明无法获取数据，不要虚构结果，也不要用模型记忆冒充最新数据。

## 分析与总结

先按用户目标筛选条目，再综合标题、摘要、分类、发布时间、榜单排名和增长指标：

1. 提炼最值得关注的新发布、研究进展、平台变化或热门项目，不机械复述所有条目。
2. 对官方动态优先依据 `publishedAt` 判断新旧；对 GitHub 热点结合 `periodStars`、总 Star、榜单位置和项目简介判断关注度。
3. 合并同一事件或同一项目的重复信号，保留最直接的原始链接。
4. 将“数据明确显示的事实”与“基于多个条目的趋势判断”分开表达。只有标题或摘要不足以支持的细节，标为尚未确认。
5. 解释每个重点为什么值得关注，以及它可能影响的开发者、团队或技术方向；不要把热度直接解释为成熟度、安全性或长期价值。

## 输出

使用用户的语言，默认给出一份紧凑简报，包含：

- 数据时间与覆盖范围，包括各来源的 `collectedAt` 和 GitHub 周期。
- 按重要性排列的关键发现，每项附发布日期或榜单指标及原始链接。
- 有足够证据时总结跨条目的趋势，并明确标注这是分析判断。
- 数据缺口、采集失败、摘要不足或时效性限制。

用户要求特定格式、数量或关注主题时优先遵从。不要输出完整原始 JSON，除非用户明确要求。
