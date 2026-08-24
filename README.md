# skills

个人开发工作流中沉淀的 Codex Skills 集合。

## Skills

| Skill | 功能 | 适用场景 |
| --- | --- | --- |
| [`read-source`](skills/read-source/) | 先从文档定位项目类型，再按类型精读核心方法、组件、命令或生成能力，并顺着这些能力深入源码学习架构。 | 源码导读、陌生仓库学习、按项目类型梳理对外能力和运行时架构。 |

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

## 许可

[MIT](LICENSE)
