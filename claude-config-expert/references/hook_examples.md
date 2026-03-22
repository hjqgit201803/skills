# Hooks 实用示例

## 常见 Hook 场景

### 1. 自动保存对话历史

```json
{
  "hooks": {
    "post-response": [
      {
        "command": "mkdir -p ~/.claude/history && echo \"--- [$(date +'%Y-%m-%d %H:%M:%S')] ---\" >> ~/.claude/history/session-$(date +%Y%m%d).log"
      }
    ]
  }
}
```

### 2. Git 自动备份

```json
{
  "hooks": {
    "pre-prompt": [
      {
        "command": "git -C . add -A && git -C . commit -m 'Auto-backup before Claude session' --allow-empty 2>/dev/null || true"
      }
    ]
  }
}
```

### 3. 项目上下文加载

```json
{
  "hooks": {
    "pre-prompt": [
      {
        "command": "[ -f .claude/context.txt ] && cat .claude/context.txt || echo 'No context file'"
      }
    ]
  }
}
```

### 4. 错误通知

```json
{
  "hooks": {
    "on-error": [
      {
        "command": "echo 'Error occurred - check logs' >> ~/.claude/errors.log"
      }
    ]
  }
}
```

### 5. 工作目录自动切换

```json
{
  "hooks": {
    "pre-prompt": [
      {
        "command": "cd ~/workspace/project || true"
      }
    ]
  }
}
```

### 6. 依赖检查

```json
{
  "hooks": {
    "pre-prompt": [
      {
        "command": "command -v node >/dev/null 2>&1 || echo 'Warning: Node.js not installed'"
      }
    ]
  }
}
```

## Hook 环境变量

Hook 可以使用以下环境变量：

| 变量 | 描述 |
|------|------|
| `$CLAUDE_MODEL` | 当前使用的模型 |
| `$CLAUDE_SESSION_ID` | 会话 ID |
| `$PWD` | 当前工作目录 |
| `$HOME` | 用户主目录 |

## 高级：条件 Hooks

```json
{
  "hooks": {
    "pre-prompt": [
      {
        "command": "if [ -f package.json ]; then echo 'Node.js project detected'; npm list --depth=0; fi"
      }
    ]
  }
}
```
