# 仓库维护约定

## 交流语言

- 默认使用中文交流和编写仓库级文档。
- Skill 内容根据目标用户选择中文或英文，并保持单个 Skill 内语言一致。

## Skill 结构

- 将每个 Skill 存放在 `skills/<skill-name>/`。
- 名称仅使用小写字母、数字和连字符，并确保目录名与 `SKILL.md` 中的 `name` 一致。
- `SKILL.md` 的 YAML frontmatter 只包含 `name` 和 `description`。
- 在 `description` 中同时说明 Skill 的能力和触发场景。
- 保持 `SKILL.md` 简洁，使用祈使句编写操作步骤。
- 将详细资料放入 `references/`，确定性工具放入 `scripts/`，输出素材放入 `assets/`。
- 不要在单个 Skill 中添加 README、CHANGELOG 或其他辅助文档。
- 推荐添加 `agents/openai.yaml`，并确保其界面信息与 `SKILL.md` 一致。

## 验证

- 修改 Skill 后运行 `./scripts/validate.sh`。
- 发布前运行 `npx skills add . --list`，确认 Skills CLI 能发现所有 Skill。
- 新增脚本时必须实际执行代表性用例。

## 安全

- 不要提交密钥、令牌、个人配置或生产环境数据。
- 避免在 Skill 脚本中执行未提示用户的破坏性操作。
- 修改现有 Skill 时保持向后兼容；无法兼容时在提交说明中明确指出。
