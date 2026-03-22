# Settings.json 完整参考

## 配置文件位置

| 配置类型 | 位置 | 优先级 |
|---------|------|-------|
| 全局配置 | `~/.claude/settings.json` | 最低 |
| 项目本地配置 | `<project>/.claude/settings.local.json` | 中等 |
| 环境变量 | 系统环境变量 | 高 |

## 完整配置结构

```json
{
  // 模型选择
  "model": "claude-opus-4-6",

  // 自定义系统提示
  "systemPrompt": "You are a specialized coding assistant...",

  // 权限配置
  "permissions": {
    "allowedTools": {
      "Read": "allow",
      "Write": "allow",
      "Edit": "allow",
      "Grep": "allow",
      "Glob": "allow",
      "Bash": "prompt",
      "Agent": "prompt",
      "WebSearch": "prompt",
      "WebFetch": "prompt"
    }
  },

  // 环境变量
  "environment": {
    "API_KEY": "${API_KEY}",
    "NODE_ENV": "development"
  },

  // Hooks 配置
  "hooks": {
    "pre-prompt": [],
    "post-response": [],
    "pre-tool-use": [],
    "post-tool-use": [],
    "on-error": []
  },

  // 技能配置
  "skills": {
    "enabled": ["skill-name"],
    "disabled": ["another-skill"]
  },

  // MCP 服务器配置
  "mcpServers": {
    "server-name": {
      "command": "node",
      "args": ["path/to/server.js"]
    }
  }
}
```

## 模型选项

| 模型 ID | 用途 |
|---------|------|
| `claude-opus-4-6` | 最强推理能力，复杂任务 |
| `claude-sonnet-4-6` | 平衡性能和速度 |
| `claude-haiku-4-5` | 快速响应，简单任务 |

## 权限配置详解

### Bash 权限通配符

```json
{
  "allowedTools": {
    "Bash": "deny",           // 禁止所有 Bash 命令
    "Bash(git *)": "allow",   // 允许 git 命令
    "Bash(npm *)": "prompt",  // npm 命令需确认
    "Bash(ls *)": "allow",    // 允许 ls 命令
    "Bash(cat *)": "allow"    // 允许 cat 命令
  }
}
```

### 技能相关权限

```json
{
  "allowedTools": {
    "Skill": "allow",         // 允许调用技能
    "Agent": "prompt"         // 子代理需确认
  }
}
```
