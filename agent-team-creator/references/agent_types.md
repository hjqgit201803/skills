# Agent Types Reference

## general-purpose

**Description**: Most versatile agent type with access to all tools.

**Available Tools**:
```yaml
allowed-tools:
  - Read              # 读取文件内容
  - Write             # 写入新文件
  - Edit              # 编辑现有文件
  - Grep              # 内容搜索
  - Glob              # 文件模式匹配
  - Bash              # 执行系统命令
  - AskUserQuestion   # 向用户提问
  - Agent             # 启动子代理
  - SendMessage       # 发送消息给团队成员
  - TaskCreate        # 创建任务
  - TaskUpdate        # 更新任务状态
  - TaskList          # 列出任务
  - TaskGet           # 获取任务详情
  - TeamCreate        # 创建团队
  - TeamDelete        # 删除团队
  - EnterPlanMode     # 进入计划模式
  - ExitPlanMode      # 退出计划模式
  - Skill             # 执行 skill
  - Note              # 记录笔记
  - CronCreate        # 创建定时任务
  - CronDelete        # 删除定时任务
  - CronList          # 列出定时任务
  - EnterWorktree     # 进入工作树
  - ExitWorktree      # 退出工作树
  - NotebookEdit      # 编辑 Jupyter 笔记本
```

**Use Cases**:
- Full-stack development
- Tasks requiring file read/write
- Complex multi-step tasks
- Tasks requiring system commands
- Team coordination and communication

**Example Agent Config**:
```markdown
---
name: fullstack-developer
description: 全栈开发工程师，负责前后端开发
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
  - TaskGet
permission-mode: default
---

# 全栈开发工程师

你是团队的全栈开发工程师。

## 核心职责
1. **前端开发** - UI 组件和页面实现
2. **后端开发** - API 接口和业务逻辑
3. **数据库** - 数据模型设计
4. **测试** - 单元测试和集成测试

请等待任务分配。
```

---

## Explore

**Description**: Read-only agent specialized for fast codebase exploration.

**Available Tools**:
```yaml
allowed-tools:
  - Glob    # 文件模式匹配
  - Grep    # 内容搜索
  - Read    # 读取文件
  - Bash    # 系统命令（只读操作）
```

**Limitations**:
- Cannot edit files (no Edit, Write)
- Cannot create new files
- Cannot execute state-modifying operations
- Read-only mode

**Use Cases**:
- Codebase exploration and understanding
- Finding specific files or functions
- Code review (read-only)
- Architecture analysis
- Security audit
- Performance analysis

**Example Agent Config**:
```markdown
---
name: code-explorer
description: 代码探索专家，负责代码库分析和探索
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

# 代码探索专家

你是团队的代码探索专家。

## 核心职责
1. **代码搜索** - 查找特定文件和函数
2. **架构分析** - 分析代码库结构
3. **依赖分析** - 追踪模块依赖关系
4. **模式发现** - 识别代码模式

请等待任务分配。
```

---

## Plan

**Description**: Software architect agent for designing implementation approaches.

**Available Tools**:
```yaml
allowed-tools:
  - Glob    # 文件模式匹配
  - Grep    # 内容搜索
  - Read    # 读取文件
  - Bash    # 系统命令（只读操作）
```

**Limitations**:
- Read-only mode, cannot modify code
- Must exit plan mode before implementation
- Requires user approval for plans

**Use Cases**:
- Architecture design
- Implementation planning
- Technical decision making
- Code refactoring planning
- API design

**Example Agent Config**:
```markdown
---
name: architect
description: 架构师，负责系统设计和实现规划
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

# 系统架构师

你是团队的系统架构师。

## 核心职责
1. **架构设计** - 设计系统架构
2. **技术选型** - 选择合适的技术栈
3. **实现规划** - 制定实现计划
4. **风险评估** - 识别潜在风险

## 工作流程
1. 分析需求和约束
2. 设计技术方案
3. 制定实施计划
4. 等待用户批准

请等待任务分配。设计方案需要用户批准。
```

---

## code-simplifier

**Description**: Agent specialized in simplifying and optimizing code.

**Available Tools**:
```yaml
allowed-tools:
  - Read              # 读取文件
  - Write             # 写入文件
  - Edit              # 编辑文件
  - Grep              # 内容搜索
  - Glob              # 文件匹配
  - Bash              # 系统命令
  - AskUserQuestion   # 用户交互
```

**Special Capabilities**:
- Code simplification
- Readability improvement
- Maintainability enhancement
- Consistency optimization
- Performance optimization

**Use Cases**:
- Code refactoring
- Performance optimization
- Code style standardization
- Complex logic simplification
- Dead code elimination

**Example Agent Config**:
```markdown
---
name: code-optimizer
description: 代码优化专家，负责代码重构和优化
agentType: code-simplifier
model: claude-opus-4-6
color: orange
planModeRequired: false
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash
  - AskUserQuestion
permission-mode: default
---

# 代码优化专家

你是团队的代码优化专家。

## 核心职责
1. **代码简化** - 简化复杂逻辑
2. **性能优化** - 提升执行效率
3. **可读性** - 改善代码可读性
4. **一致性** - 统一代码风格

## 优化原则
- 保持功能不变
- 提高代码质量
- 遵循最佳实践
- 添加必要注释

请等待任务分配。
```

---

## Selection Guide

### 按任务需求选择

| 任务需求 | 推荐类型 | 模型选择 |
|---------|---------|---------|
| 需要修改代码 | general-purpose, code-simplifier | Opus |
| 只需要探索/审查 | Explore | Sonnet (节省成本) |
| 需要设计方案 | Plan | Opus |
| 代码优化/重构 | code-simplifier | Opus |
| 新功能开发 | general-purpose | Opus |
| 代码搜索/分析 | Explore | Sonnet |
| 简单任务 | general-purpose | Sonnet/Haiku |

### 按工具需求选择

| 需要的工具 | 推荐类型 |
|-----------|---------|
| Read + Write + Edit | general-purpose, code-simplifier |
| 仅 Read (只读) | Explore, Plan |
| Bash (写操作) | general-purpose, code-simplifier |
| TeamCreate/TeamDelete | general-purpose |
| SendMessage | general-purpose |
| TaskCreate/TaskUpdate | general-purpose |

### 按成本优化选择

| 场景 | 推荐模型 |
|------|---------|
| 复杂架构设计 | claude-opus-4-6 |
| 代码实现 | claude-opus-4-6 |
| 代码审查 | claude-sonnet-4-6 |
| 简单分析 | claude-sonnet-4-6 |
| 大批量任务 | claude-haiku-4-5 |

---

## 工具权限对照表

### 完整工具列表

| 工具 | 功能 | general-purpose | Explore | Plan | code-simplifier |
|------|------|:---------------:|:-------:|:----:|:---------------:|
| Read | 读取文件 | ✓ | ✓ | ✓ | ✓ |
| Write | 写入文件 | ✓ | ✗ | ✗ | ✓ |
| Edit | 编辑文件 | ✓ | ✗ | ✗ | ✓ |
| Grep | 内容搜索 | ✓ | ✓ | ✓ | ✓ |
| Glob | 文件匹配 | ✓ | ✓ | ✓ | ✓ |
| Bash | 系统命令 | ✓ | ✓* | ✓* | ✓ |
| AskUserQuestion | 用户交互 | ✓ | ✗ | ✗ | ✓ |
| Agent | 启动子代理 | ✓ | ✗ | ✗ | ✗ |
| SendMessage | 团队消息 | ✓ | ✗ | ✗ | ✗ |
| TaskCreate | 创建任务 | ✓ | ✗ | ✗ | ✗ |
| TaskUpdate | 更新任务 | ✓ | ✗ | ✗ | ✗ |
| TaskList | 列出任务 | ✓ | ✗ | ✗ | ✗ |
| TeamCreate | 创建团队 | ✓ | ✗ | ✗ | ✗ |
| TeamDelete | 删除团队 | ✓ | ✗ | ✗ | ✗ |
| EnterPlanMode | 计划模式 | ✓ | ✗ | ✗ | ✗ |
| ExitPlanMode | 退出计划 | ✓ | ✗ | ✗ | ✗ |

*注：Explore 和 Plan 的 Bash 工具仅限只读操作

---

## 快速模板生成

### general-purpose 模板
```yaml
---
name: your-agent-name
description: 你的 agent 描述
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
  - TaskGet
permission-mode: default
---
```

### Explore 模板
```yaml
---
name: your-agent-name
description: 你的 agent 描述
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
```

### Plan 模板
```yaml
---
name: your-agent-name
description: 你的 agent 描述
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
```

### code-simplifier 模板
```yaml
---
name: your-agent-name
description: 你的 agent 描述
agentType: code-simplifier
model: claude-opus-4-6
color: orange
planModeRequired: false
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash
  - AskUserQuestion
permission-mode: default
---
```
