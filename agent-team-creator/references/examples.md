# Agent Team Examples

## Example 1: Full-Stack Development Team

**Scenario**: Building a user authentication feature

**Team Configuration**:
```
Team Name: auth-feature-team
Description: Build user authentication with login, registration, and password recovery
```

**Teammates**:

| Name | Type | Model | Responsibility |
|------|------|-------|----------------|
| frontend-dev | general-purpose | claude-opus-4-6 | Build login/register UI forms |
| backend-dev | general-purpose | claude-opus-4-6 | Implement auth API endpoints |
| db-dev | general-purpose | claude-opus-4-6 | Design database schema |
| qa-tester | general-purpose | claude-sonnet-4-6 | Write tests and validate |

**Task List**:
1. Design database schema for users table
2. Create registration API endpoint
3. Create login API endpoint with JWT
4. Build registration form UI
5. Build login form UI
6. Write unit tests for API
7. Write integration tests
8. Document API endpoints

**User Prompt**:
```
Create an agent team called "auth-feature-team" to build user authentication.
I need:
- A frontend developer for the login/register UI
- A backend developer for the API endpoints
- A database developer for schema design
- A QA tester for test coverage

Use in-process mode. Each teammate should work on independent parts.
```

**Agent 配置文件示例** - `agents/frontend-dev.md`：
```markdown
---
name: frontend-dev
description: 前端开发工程师，负责登录和注册界面实现
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

你是团队的前端开发工程师，负责用户认证界面实现。

## 核心职责

1. **登录表单** - 实现用户登录界面，包括用户名/密码输入
2. **注册表单** - 实现用户注册界面，包括表单验证
3. **状态管理** - 管理认证状态（登录/未登录）
4. **错误处理** - 显示登录/注册错误信息

## 技术栈

- React + TypeScript
- 表单验证库
- CSS/Tailwind

请等待任务分配。
```

---

## Example 2: Code Review Team

**Scenario**: Review a pull request for security, performance, and test coverage

**Team Configuration**:
```
Team Name: pr-review-team
Description: Comprehensive PR review across multiple dimensions
```

**Teammates**:

| Name | Type | Model | Responsibility |
|------|------|-------|----------------|
| security-reviewer | Explore | claude-opus-4-6 | Check for security vulnerabilities |
| performance-reviewer | Explore | claude-opus-4-6 | Analyze performance impact |
| test-reviewer | Explore | claude-opus-4-6 | Validate test coverage |

**Task List**:
1. Security reviewer: Check authentication handling, input validation, SQL injection risks
2. Performance reviewer: Analyze query efficiency, N+1 problems, caching opportunities
3. Test reviewer: Verify edge cases covered, assertions meaningful, mocks appropriate
4. Synthesize findings into combined report

**User Prompt**:
```
Create an agent team to review PR #142.
Spawn three reviewers using Explore type:
- One focused on security implications (SQL injection, XSS, auth)
- One checking performance impact (queries, N+1, caching)
- One validating test coverage (edge cases, assertions)

Have them each review and report findings. Use Sonnet for cost efficiency.
```

**Agent 配置文件示例** - `agents/security-reviewer.md`：
```markdown
---
name: security-reviewer
description: 安全审查专家，负责检查代码中的安全漏洞
agentType: Explore
model: claude-opus-4-6
color: red
planModeRequired: false
allowed-tools:
  - Glob
  - Grep
  - Read
  - Bash
permission-mode: default
---

# 安全审查专家

你是团队的安全审查专家，负责代码安全性检查。

## 核心职责

1. **SQL 注入** - 检查数据库查询是否存在注入风险
2. **XSS 防护** - 验证用户输入是否正确转义
3. **认证处理** - 检查认证和授权逻辑
4. **敏感数据** - 确保敏感数据不被泄露

## 审查要点

- 用户输入验证
- 参数化查询
- CSRF 保护
- 密码加密存储

请等待任务分配。
```

---

## Example 3: Debugging with Competing Hypotheses

**Scenario**: Users report app exits after one message

**Team Configuration**:
```
Team Name: debug-investigation-team
Description: Parallel investigation of root cause theories
```

**Teammates**:

| Name | Type | Model | Responsibility |
|------|------|-------|----------------|
| hypothesis-1 | Explore | claude-opus-4-6 | Test theory: Uncaught exception |
| hypothesis-2 | Explore | claude-opus-4-6 | Test theory: Memory leak |
| hypothesis-3 | Explore | claude-opus-4-6 | Test theory: Connection timeout |
| hypothesis-4 | Explore | claude-opus-4-6 | Test theory: Resource limit |
| synthesizer | general-purpose | claude-opus-4-6 | Combine findings |

**Task List**:
1. Hypothesis 1: Search for unhandled exception handlers
2. Hypothesis 2: Analyze memory allocation patterns
3. Hypothesis 3: Check connection timeout configurations
4. Hypothesis 4: Review resource limits and quotas
5. Synthesizer: Debate findings and reach consensus

**User Prompt**:
```
Users report the app exits after one message instead of staying connected.
Spawn 5 agent teammates to investigate different hypotheses. Have them talk to
each other to try to disprove each other's theories, like a scientific debate.
Update the findings doc with whatever consensus emerges.
```

---

## Example 4: New Module Development

**Scenario**: Build a new payment processing module

**Team Configuration**:
```
Team Name: payment-module-team
Description: Design and implement payment processing with multiple providers
```

**Teammates**:

| Name | Type | Model | Responsibility |
|------|------|-------|----------------|
| architect | Plan | claude-opus-4-6 | Design payment interface |
| stripe-dev | general-purpose | claude-opus-4-6 | Implement Stripe provider |
| paypal-dev | general-purpose | claude-opus-4-6 | Implement PayPal provider |
| test-dev | general-purpose | claude-sonnet-4-6 | Write payment tests |

**Task List**:
1. Architect: Design payment provider interface
2. Architect: Plan error handling strategy
3. Stripe dev: Implement Stripe payment flow
4. PayPal dev: Implement PayPal payment flow
5. Test dev: Write integration tests for both
6. Synthesize: Combine into working module

**User Prompt**:
```
Create a team to build a payment processing module.
First spawn an architect teammate to design the provider interface.
Require plan approval before they make any changes. Only approve plans that:
- Support multiple payment providers
- Handle errors gracefully
- Include comprehensive testing

Then spawn developers for Stripe and PayPal implementations.
```

**Agent 配置文件示例** - `agents/architect.md`：
```markdown
---
name: architect
description: 架构师，负责设计支付模块的接口和实现方案
agentType: Plan
model: claude-opus-4-6
color: purple
planModeRequired: true
allowed-tools:
  - Glob
  - Grep
  - Read
  - Bash
permission-mode: plan
---

# 支付模块架构师

你是团队的架构师，负责支付模块的设计。

## 核心职责

1. **接口设计** - 设计统一的支付提供商接口
2. **错误处理** - 设计完善的错误处理策略
3. **扩展性** - 确保易于添加新的支付提供商
4. **安全性** - 设计安全的支付流程

## 设计原则

- 接口隔离
- 依赖倒置
- 开闭原则
- 最小惊讶原则

请等待任务分配。设计方案需要用户批准后才能实施。
```

---

## Example 5: Documentation Team

**Scenario**: Update API documentation for a new version

**Team Configuration**:
```
Team Name: docs-update-team
Description: Update API docs for v2.0 release
```

**Teammates**:

| Name | Type | Model | Responsibility |
|------|------|-------|----------------|
| api-analyzer | Explore | claude-sonnet-4-6 | Extract API endpoints |
| doc-writer | general-purpose | claude-opus-4-6 | Write endpoint docs |
| example-creator | general-purpose | claude-opus-4-6 | Create code examples |
| reviewer | Explore | claude-opus-4-6 | Review for accuracy |

**Task List**:
1. API analyzer: Find all new/changed endpoints
2. API analyzer: Extract request/response schemas
3. Doc writer: Write documentation for each endpoint
4. Example creator: Create code examples in Python and JavaScript
5. Reviewer: Verify docs match actual API behavior

**User Prompt**:
```
Create a documentation team to update API docs for v2.0.
Teammates should:
- Analyze the new API endpoints
- Write clear documentation
- Create code examples
- Review for accuracy

Use Sonnet for analysis to save costs, Opus for writing quality.
```

---

## Example 6: Complete Team Setup

以下是一个完整的团队设置示例，包含所有配置文件：

### 目录结构
```
~/.claude/teams/web-dev-team/
├── config.json
└── agents/
    ├── frontend.md
    ├── backend.md
    └── reviewer.md
```

### config.json
```json
{
  "name": "web-dev-team",
  "description": "全栈开发团队，负责 Web 应用开发",
  "agentsDir": "agents",
  "members": [
    {
      "agentId": "frontend@web-dev-team",
      "name": "frontend",
      "agentType": "general-purpose",
      "model": "claude-opus-4-6",
      "promptFile": "agents/frontend.md",
      "color": "blue"
    },
    {
      "agentId": "backend@web-dev-team",
      "name": "backend",
      "agentType": "general-purpose",
      "model": "claude-opus-4-6",
      "promptFile": "agents/backend.md",
      "color": "green"
    },
    {
      "agentId": "reviewer@web-dev-team",
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
name: frontend
description: 前端开发工程师，负责用户界面和交互实现
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

你是团队的前端开发工程师。

## 核心职责
1. **UI 实现** - 根据设计实现界面
2. **状态管理** - 管理应用状态
3. **API 集成** - 对接后端 API
4. **性能优化** - 优化加载和渲染

## 技术栈
- React + TypeScript
- Tailwind CSS
- React Query

请等待任务分配。
```

### agents/backend.md
```markdown
---
name: backend
description: 后端开发工程师，负责 API 开发和业务逻辑
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

你是团队的后端开发工程师。

## 核心职责
1. **API 开发** - 实现 RESTful API
2. **数据库** - 设计和优化数据库
3. **认证授权** - 实现用户认证
4. **性能优化** - 优化 API 响应

## 技术栈
- Node.js + Express
- PostgreSQL
- Redis

请等待任务分配。
```

### agents/reviewer.md
```markdown
---
name: reviewer
description: 代码审查专家，负责代码质量和安全检查
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

你是团队的代码审查专家。

## 核心职责
1. **代码质量** - 检查代码规范
2. **安全审查** - 发现安全漏洞
3. **性能分析** - 分析性能问题
4. **测试覆盖** - 验证测试完整性

请等待任务分配。
```

## 使用流程

1. **创建团队**
   ```bash
   # 使用 Agent 工具时指定团队配置
   TeamCreate("web-dev-team", "全栈开发团队")
   ```

2. **启动成员**
   ```bash
   # 启动前端开发
   Agent("frontend-dev", prompt="启动前端开发", team_name="web-dev-team")

   # 启动后端开发
   Agent("backend-dev", prompt="启动后端开发", team_name="web-dev-team")

   # 启动代码审查
   Agent("reviewer", prompt="启动代码审查", team_name="web-dev-team", subagent_type="Explore")
   ```

3. **创建和分配任务**
   ```bash
   TaskCreate("实现登录页面", description="...")
   TaskUpdate(taskId="1", owner="frontend", status="in_progress")
   ```

4. **协调通信**
   ```bash
   SendMessage(to="backend", message="前端登录页面已完成，请提供 API", summary="通知后端开发")
   ```

5. **完成清理**
   ```bash
   SendMessage(to="*", message={type: "shutdown_request", reason: "项目完成"})
   TeamDelete()
   ```
