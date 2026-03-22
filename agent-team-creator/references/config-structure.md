# Agent Team 配置结构参考

## 推荐的目录结构

使用 `agents/` 目录分离 agent 职责定义，提高可维护性：

```
~/.claude/teams/{team-name}/
├── config.json           # 团队元数据配置
├── agents/               # Agent 职责定义目录
│   ├── {member-name}.md  # 各成员的职责定义（含 Skill 规范元数据）
│   └── ...
└── inboxes/              # 消息存储目录
    └── ...
```

## config.json 格式

```json
{
  "name": "dev-team",
  "description": "团队描述",
  "createdAt": 1774186837870,
  "leadAgentId": "team-lead@dev-team",
  "leadSessionId": "uuid",
  "agentsDir": "agents",
  "members": [
    {
      "agentId": "member-name@team-name",
      "name": "member-name",
      "agentType": "general-purpose",
      "model": "claude-opus-4-6",
      "promptFile": "agents/member-name.md",
      "color": "blue",
      "planModeRequired": false,
      "joinedAt": 1774186837870,
      "tmuxPaneId": "in-process",
      "cwd": "/path/to/project",
      "subscriptions": [],
      "backendType": "in-process"
    }
  ]
}
```

### 配置字段说明

| 字段 | 类型 | 必需 | 说明 |
|------|------|------|------|
| `name` | string | ✓ | 团队名称 |
| `description` | string | ✓ | 团队描述 |
| `agentsDir` | string | ✓ | Agent 配置文件目录 |
| `leadAgentId` | string | ✓ | Team Lead 的 Agent ID |
| `members` | array | ✓ | 成员列表 |
| `agentId` | string | ✓ | 成员唯一 ID (name@team) |
| `name` | string | ✓ | 成员名称 |
| `agentType` | string | ✓ | Agent 类型 |
| `model` | string | ✓ | 使用的模型 |
| `promptFile` | string | ✓ | Agent 配置文件路径 |
| `color` | string | - | 显示颜色 |
| `planModeRequired` | boolean | - | 是否需要计划模式 |
| `cwd` | string | ✓ | 工作目录 |

## Agent 配置文件格式（Skill 规范）

每个 Agent 的职责定义使用 **YAML Frontmatter** 元数据格式：

### 完整模板

```markdown
---
name: frontend-developer
description: 前端开发工程师，负责用户界面实现和交互逻辑开发。
agentType: general-purpose
model: claude-opus-4-6
color: blue
planModeRequired: false
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash
  - AskUserQuestion
  - Agent
  - SendMessage
  - TaskCreate
  - TaskUpdate
  - TaskList
permission-mode: default
---

# 角色名称 (Role Name)

你是团队的[角色]，负责[核心职责]。

## 核心职责

1. **职责名称** - 职责说明
2. **职责名称** - 职责说明
3. **职责名称** - 职责说明

## 工作方式

- 工作方式说明
- 工作方式说明

## 技术关注点

- **关注点1** - 说明
- **关注点2** - 说明

## 交付物

- 交付物1
- 交付物2

请等待任务分配。
```

### 元数据字段说明

| 字段 | 类型 | 必需 | 说明 |
|------|------|------|------|
| `name` | string | ✓ | Agent 名称（唯一标识） |
| `description` | string | ✓ | Agent 描述 |
| `agentType` | string | ✓ | Agent 类型：general-purpose/Explore/Plan/code-simplifier |
| `model` | string | ✓ | 模型：claude-opus-4-6/claude-sonnet-4-6/claude-haiku-4-5 |
| `color` | string | - | 显示颜色：blue/green/red/yellow/purple/orange |
| `planModeRequired` | boolean | - | 是否需要计划模式 |
| `allowed-tools` | array | ✓ | 允许使用的工具列表 |
| `permission-mode` | string | - | 权限模式：default/acceptEdits/bypassPermissions/dontAsk/plan/auto |

## 工具权限快速参考

### general-purpose 工具列表
```yaml
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash
  - AskUserQuestion
  - Agent
  - SendMessage
  - TaskCreate
  - TaskUpdate
  - TaskList
  - TaskGet
  - TeamCreate
  - TeamDelete
  - EnterPlanMode
  - ExitPlanMode
  - Skill
  - Note
  - CronCreate
  - CronDelete
  - CronList
```

### Explore 工具列表
```yaml
allowed-tools:
  - Glob
  - Grep
  - Read
  - Bash
```

### Plan 工具列表
```yaml
allowed-tools:
  - Glob
  - Grep
  - Read
  - Bash
```

## 两种配置方式对比

### 方式1：内联 prompt（不推荐）

```json
{
  "agentId": "developer@team",
  "name": "developer",
  "prompt": "你是开发工程师...\n\n职责：\n1. xxx\n2. xxx"
}
```

**缺点**：
- JSON 文件过大
- 需要处理 `\n` 转义
- 难以编辑和维护
- 不符合关注点分离原则
- **无工具权限元数据**

### 方式2：外部文件（推荐）

```json
{
  "agentId": "developer@team",
  "name": "developer",
  "promptFile": "agents/developer.md"
}
```

**优点**：
- 配置清晰简洁
- 使用 Markdown 编写，易于编辑
- 便于版本控制
- 符合关注点分离原则
- **包含完整的工具权限元数据**

## 创建新团队的步骤

1. **创建团队目录**
   ```bash
   mkdir -p ~/.claude/teams/{team-name}/agents
   ```

2. **创建 Agent 配置文件**
   ```bash
   # 为每个成员创建 .md 文件
   touch ~/.claude/teams/{team-name}/agents/{member-name}.md
   ```

3. **编写 Agent 配置（使用 Skill 规范）**
   ```markdown
   ---
   name: frontend-developer
   description: 前端开发工程师
   agentType: general-purpose
   model: claude-opus-4-6
   allowed-tools:
     - Read
     - Write
     - Edit
     - Grep
     - Glob
     - Bash
   ---

   # 角色名称
   ...
   ```

4. **创建 config.json**
   ```json
   {
     "name": "team-name",
     "agentsDir": "agents",
     "members": [...]
   }
   ```

5. **使用 TeamCreate 创建团队**
6. **使用 Agent 启动成员**

## 示例：完整的团队成员配置

### config.json

```json
{
  "name": "dev-team",
  "agentsDir": "agents",
  "members": [
    {
      "agentId": "frontend@dev-team",
      "name": "frontend",
      "agentType": "general-purpose",
      "model": "claude-opus-4-6",
      "promptFile": "agents/frontend.md",
      "color": "blue"
    },
    {
      "agentId": "backend@dev-team",
      "name": "backend",
      "agentType": "general-purpose",
      "model": "claude-opus-4-6",
      "promptFile": "agents/backend.md",
      "color": "green"
    },
    {
      "agentId": "reviewer@dev-team",
      "name": "reviewer",
      "agentType": "Explore",
      "model": "claude-sonnet-4-6",
      "promptFile": "agents/reviewer.md",
      "color": "purple"
    }
  ]
}
```

### agents/frontend.md

```markdown
---
name: frontend-developer
description: 前端开发工程师，负责用户界面实现和交互逻辑开发。
agentType: general-purpose
model: claude-opus-4-6
color: blue
planModeRequired: false
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash
  - AskUserQuestion
  - Agent
  - SendMessage
  - TaskCreate
  - TaskUpdate
  - TaskList
permission-mode: default
---

# 前端开发工程师

你是团队的前端开发工程师，负责用户界面实现。

## 核心职责

1. **UI 实现** - 根据设计稿实现用户界面
2. **交互逻辑** - 实现用户交互和状态管理
3. **性能优化** - 优化页面加载和渲染性能
4. **组件开发** - 开发可复用的 UI 组件

## 技术栈

- React/Vue/Angular
- TypeScript
- CSS/Tailwind
- 状态管理 (Redux/Vuex)

请等待任务分配。
```

### agents/backend.md

```markdown
---
name: backend-developer
description: 后端开发工程师，负责 API 接口开发和业务逻辑实现。
agentType: general-purpose
model: claude-opus-4-6
color: green
planModeRequired: false
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash
  - AskUserQuestion
  - Agent
  - SendMessage
  - TaskCreate
  - TaskUpdate
  - TaskList
permission-mode: default
---

# 后端开发工程师

你是团队的后端开发工程师，负责 API 接口开发。

## 核心职责

1. **API 开发** - 实现后端 API 接口
2. **数据库设计** - 设计数据库表结构和查询
3. **业务逻辑** - 实现核心业务逻辑
4. **性能优化** - 优化 API 响应性能

## 技术栈

- Node.js / Python / Go
- RESTful API / GraphQL
- PostgreSQL / MongoDB
- Redis 缓存

请等待任务分配。
```

### agents/reviewer.md

```markdown
---
name: code-reviewer
description: 代码审查专家，负责代码质量审查和安全性检查。
agentType: Explore
model: claude-sonnet-4-6
color: purple
planModeRequired: false
allowed-tools:
  - Glob
  - Grep
  - Read
  - Bash
permission-mode: default
---

# 代码审查专家

你是团队的代码审查专家，负责代码质量审查。

## 核心职责

1. **安全审查** - 检查安全漏洞
2. **性能分析** - 分析性能影响
3. **规范检查** - 验证代码规范
4. **测试覆盖** - 检查测试覆盖率

请等待任务分配。
```

## 权限模式说明

| 模式 | 说明 |
|------|------|
| `default` | 默认权限，需要用户确认敏感操作 |
| `acceptEdits` | 自动接受文件编辑 |
| `bypassPermissions` | 绕过所有权限检查 |
| `dontAsk` | 不询问用户，自动执行 |
| `plan` | 计划模式，需要用户批准计划 |
| `auto` | 自动模式，智能判断是否需要确认 |

## 颜色选项

| 颜色 | 适用场景 |
|------|----------|
| `blue` | 前端、UI 相关 |
| `green` | 后端、API 相关 |
| `red` | 安全、测试相关 |
| `yellow` | 警告、注意相关 |
| `purple` | 代码审查、分析相关 |
| `orange` | DevOps、部署相关 |
