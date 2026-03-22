---
name: agent-team-creator
description: Claude Code Agent Team 创建专家。帮助用户创建和管理 Claude Code 的 agent teams，包括团队创建、成员定义、工具权限配置、启动和管理。参考官方文档确保团队配置正确。
context: fork
agent: general-purpose
allowed-tools: Read, Write, Edit, Grep, Glob, Bash, AskUserQuestion
version: 2.0.0
---

# Agent Team 创建专家

## 触发条件
当用户请求以下内容时使用此 skill：
- "创建 agent team" / "创建团队" / "spawn teammates"
- "agent team 配置" / "团队协作" / "并行工作团队"
- 讨论创建多个 agent 协同工作

## 核心功能
1. **团队创建** - TeamCreate 工具创建新团队
2. **成员管理** - Agent 工具创建团队成员
3. **任务管理** - TaskCreate/TaskUpdate/TaskList 管理任务
4. **团队通信** - SendMessage 在成员间传递消息
5. **团队清理** - TeamDelete 清理团队资源

## Agent 类型与工具权限

| 类型 | 可用工具 | 工具权限 | 适用场景 |
|------|---------|---------|----------|
| `general-purpose` | 所有工具 | Read, Write, Edit, Grep, Glob, Bash, AskUserQuestion, Agent, TaskCreate, TaskUpdate, TaskList, SendMessage, TeamCreate, TeamDelete, etc. | 全栈开发、复杂任务 |
| `Explore` | Glob, Grep, Read, Bash | Glob, Grep, Read, Bash (read-only) | 代码库探索、代码审查 |
| `Plan` | Glob, Grep, Read, Bash | Glob, Grep, Read, Bash (read-only) | 架构设计、实现规划 |
| `code-simplifier` | 所有工具 | Read, Write, Edit, Grep, Glob, Bash, AskUserQuestion | 代码重构、优化 |

## 团队配置结构

**推荐方式** - 使用 agents 目录分离配置：
```
~/.claude/teams/{team-name}/
├── config.json      # 团队元数据（引用 promptFile）
└── agents/          # Agent 职责定义目录
    ├── {member-name}.md
    └── ...
```

## Agent 配置文件规范（符合 Skill 规范）

每个 Agent 的配置文件使用 **YAML Frontmatter** 元数据格式，包含工具及权限信息：

```markdown
---
name: frontend-developer
description: 前端开发工程师，负责用户界面实现和交互逻辑。
agentType: general-purpose
model: claude-opus-4-6
color: blue
planModeRequired: false
# 工具权限列表（根据 agentType 自动推断）
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
# 工具权限模式
permission-mode: default
---

# 角色名称

你是团队的[角色]，负责[核心职责]。

## 核心职责
1. **职责名称** - 职责说明
2. **职责名称** - 职责说明

## 工作方式
- 工作方式说明

## 技术关注点
- **关注点1** - 说明
- **关注点2** - 说明

## 交付物
- 交付物1
- 交付物2

请等待任务分配。
```

## 元数据字段说明

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

## config.json 格式

```json
{
  "name": "team-name",
  "description": "团队描述",
  "agentsDir": "agents",
  "members": [
    {
      "agentId": "member-name@team-name",
      "name": "member-name",
      "agentType": "general-purpose",
      "model": "claude-opus-4-6",
      "promptFile": "agents/member-name.md",
      "color": "blue",
      "planModeRequired": false
    }
  ]
}
```

## 工作流程

1. **了解需求** - 团队目的、成员类型、任务
2. **检查环境** - `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`
3. **TeamCreate** - 创建团队
4. **创建 agents/ 目录** - 为每个成员创建配置文件
5. **编写 Agent 配置** - 使用 Skill 规范格式（含元数据）
6. **更新 config.json** - 使用 promptFile 引用
7. **Agent 创建成员** - 选择合适类型和工具权限
8. **TaskCreate 创建任务** - TaskUpdate 分配
9. **SendMessage 协调通信**
10. **完成后清理** - SendMessage 关闭成员，TeamDelete 清理

## Agent 配置文件模板示例

### frontend-developer.md
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

### code-reviewer.md (Explore 类型)
```markdown
---
name: code-reviewer
description: 代码审查专家，负责代码质量审查和安全性检查。
agentType: Explore
model: claude-opus-4-6
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

## 参考文档
https://code.claude.com/docs/en/agent-teams
