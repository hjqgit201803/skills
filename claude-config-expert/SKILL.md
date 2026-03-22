---
name: claude-config-expert
description: Claude Code 高级配置专家。精通所有 Claude Code 配置功能，包括 Team、Workflows、Hooks、Permissions、settings.json 等。当用户需要配置、优化或调试 Claude Code 时使用此技能。
context: fork
agent: general-purpose
allowed-tools: Read, Write, Edit, Grep, Glob, Bash
---

# Claude Code 高级配置专家

## 概述

此 skill 提供 Claude Code 的全面配置知识，涵盖从基础设置到高级 Team 功能的所有内容。所有配置均参考官方文档，确保最佳实践。

## 官方文档

**配置前必读官方文档**：
- [Claude Code 官方文档](https://docs.anthropic.com/en/docs/claude-code)
- [Settings 配置参考](https://docs.anthropic.com/en/docs/claude-code/settings)
- [Hooks 文档](https://docs.anthropic.com/en/docs/claude-code/hooks)
- [Team 功能](https://docs.anthropic.com/en/docs/claude-code/teams)
- [Skills 开发最佳实践](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices.md)

## 核心配置区域

### 1. Settings.json 配置

配置文件位置：`~/.claude/settings.json`

**常用配置项**：

```json
{
  "model": "claude-opus-4-6",
  "permissions": {
    "allowedTools": {
      "Read": "allow",
      "Write": "allow",
      "Edit": "allow",
      "Bash": "prompt"
    }
  },
  "hooks": {
    "pre-prompt": [
      {
        "command": "echo 'Starting prompt...'"
      }
    ]
  },
  "environment": {
    "MY_API_KEY": "${MY_API_KEY}"
  }
}
```

**配置层级**：
1. **Global settings**: `~/.claude/settings.json`
2. **Local settings**: `<project>/.claude/settings.local.json`
3. **CLAUDE.md**: 项目级指令文件

### 2. Permissions（权限配置）

权限控制 Claude Code 可以执行的操作。

**配置方式**：

```json
{
  "permissions": {
    "allowedTools": {
      "Read": "allow",
      "Write": "allow",
      "Edit": "allow",
      "Grep": "allow",
      "Glob": "allow",
      "Bash": "prompt",        // 每次询问用户
      "Bash(git *)": "allow",  // 允许 git 命令
      "Bash(npm *)": "prompt"  // npm 命令需确认
    }
  }
}
```

**权限级别**：
- `allow`: 自动允许
- `prompt`: 每次询问
- `deny`: 禁止

### 3. Hooks（钩子配置）

Hooks 在特定事件触发时自动执行命令。

**Hook 类型**：

| Hook 类型 | 触发时机 | 用途 |
|-----------|----------|------|
| `pre-prompt` | 用户发送提示前 | 记录日志、加载上下文 |
| `post-response` | Claude 响应后 | 记录响应、更新状态 |
| `pre-tool-use` | 工具调用前 | 验证操作、记录意图 |
| `post-tool-use` | 工具调用后 | 清理、通知 |
| `on-error` | 错误发生时 | 错误报告、回滚 |

**示例配置**：

```json
{
  "hooks": {
    "pre-prompt": [
      {
        "command": "echo \"[$(date)] Prompt received\" >> ~/.claude/audit.log"
      }
    ],
    "post-response": [
      {
        "command": "echo \"Response completed\" >> ~/.claude/audit.log"
      }
    ],
    "on-error": [
      {
        "command": "notify-send \"Claude Error\" \"Check logs\""
      }
    ]
  }
}
```

### 4. Team 功能

Team 功能支持团队共享配置和协作。

**配置文件**：`~/.claude/team.json`

```json
{
  "name": "My Team",
  "members": ["user1@example.com", "user2@example.com"],
  "sharedSkills": ["./shared-skills/*"],
  "sharedSettings": {
    "model": "claude-sonnet-4-6"
  }
}
```

### 5. Environment Variables

环境变量可通过 settings.json 配置：

```json
{
  "environment": {
    "API_KEY": "${API_KEY}",
    "PROJECT_DIR": "/path/to/project",
    "DEBUG": "true"
  }
}
```

## 配置工作流

### 场景 1：设置新项目

1. 检查是否存在 `.claude/settings.local.json`
2. 根据项目需求配置权限
3. 添加必要的 hooks
4. 创建或更新 CLAUDE.md

### 场景 2：优化现有配置

1. 读取当前 `settings.json`
2. 分析权限和 hooks 配置
3. 参考官方文档验证最佳实践
4. 提出优化建议

### 场景 3：调试配置问题

1. 检查配置文件语法（JSON 格式）
2. 验证 hooks 命令可执行性
3. 检查权限设置是否合理
4. 查看日志文件（如有配置）

### 场景 4：创建自定义 Skill

参考 [references/skill_authoring.md](references/skill_authoring.md) 获取详细指南。

## 诊断命令

```bash
# 检查配置文件
cat ~/.claude/settings.json

# 检查项目本地配置
cat .claude/settings.local.json

# 验证 JSON 格式
jq . ~/.claude/settings.json

# 测试 hook 命令
echo "test" | bash -c 'your_hook_command'

# 查看已安装的 skills
ls ~/.claude/skills/
```

## 资源

- **详细配置参考**: [references/settings_reference.md](references/settings_reference.md)
- **Hook 示例**: [references/hook_examples.md](references/hook_examples.md)
- **常见问题**: [references/troubleshooting.md](references/troubleshooting.md)
