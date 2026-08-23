# skills

个人开发工作流中沉淀的 Codex Skills 集合。

## 安装

交互式选择并安装 Skill：

```bash
npx skills add wanglsh97/skills
```

安装指定 Skill：

```bash
npx skills add wanglsh97/skills --skill <skill-name>
```

将仓库中的全部 Skill 全局安装到 Codex：

```bash
npx skills add wanglsh97/skills --skill '*' --agent codex --global --yes
```

查看仓库中可安装的 Skill：

```bash
npx skills add wanglsh97/skills --list
```

查看或更新已安装的 Skill：

```bash
npx skills list
npx skills update
```

安装完成后，重启 Codex 或开启一个新会话，使 skill 被重新发现。

## 仓库结构

```text
.
├── skills/              # 每个子目录是一个独立 skill
│   └── <skill-name>/
│       ├── SKILL.md     # 必需：触发描述与操作说明
│       ├── agents/      # 推荐：Codex UI 元数据
│       ├── scripts/     # 可选：可复用脚本
│       ├── references/  # 可选：按需加载的参考资料
│       └── assets/      # 可选：输出所需素材
├── scripts/validate.sh  # 仓库级校验
└── AGENTS.md            # 仓库维护约定
```

## 新增 skill

1. 在 `skills/` 下创建与 skill 名称一致的目录（仅使用小写字母、数字和连字符）。
2. 添加 `SKILL.md`，其 YAML frontmatter 只包含 `name` 和 `description`。
3. 按需添加 `agents/openai.yaml`、`scripts/`、`references/` 或 `assets/`。
4. 运行 `./scripts/validate.sh`。
5. 本地检查发现结果：`npx skills add . --list`。
6. 本地试装：`npx skills add . --skill <skill-name>`。

最小示例：

```markdown
---
name: example-skill
description: 简洁说明该 skill 做什么，以及应在什么请求或场景下使用。
---

# Example Skill

使用祈使句写明执行步骤、判断标准和必要约束。
```

## 许可

[MIT](LICENSE)
