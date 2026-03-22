# Skill 编写指南

## Skill 结构

```
skill-name/
├── SKILL.md          # 必需：技能定义
├── scripts/          # 可选：可执行脚本
├── references/       # 可选：参考资料
└── assets/           # 可选：资源文件
```

## SKILL.md 模板

```yaml
---
name: my-skill
description: 简洁描述技能功能和使用场景。当用户提到 X、Y 或 Z 时使用。
context: fork                    # 可选：在子代理中运行
agent: general-purpose           # 可选：子代理类型
disable-model-invocation: true   # 可选：仅手动触发
allowed-tools: Read, Grep        # 可选：允许的工具
---

# 技能标题

## 概述
1-2 句话说明此技能的功能。

## 使用场景
- 场景 1
- 场景 2

## 参考资料
- [详细指南](references/guide.md)
```

## 编写最佳实践

### 1. 命名规范
- 使用小写字母、数字、连字符
- 推荐：动名词形式（如 `processing-pdfs`）
- 避免保留词：`anthropic`、`claude`

### 2. Description 规范
- 第三人称描述（"Processes files" 而非 "I process files"）
- 包含触发关键词
- 明确使用场景

**好示例**：
```yaml
description: 处理 Excel 文件、生成数据透视表、创建图表。当用户分析 .xlsx 文件或提及电子表格时使用。
```

**坏示例**：
```yaml
description: 帮助处理文档
```

### 3. 渐进式披露
- SKILL.md 保持简洁（<500 行）
- 详细内容放入 references/
- 脚本放入 scripts/

### 4. 路径规范
- 使用正斜杠：`scripts/helper.py`
- 禁止：`scripts\\helper.py`（Windows 风格）

## 验证 Skill

```bash
# 验证结构
python skill-creator/scripts/quick_validate.py path/to/skill

# 安全扫描
python skill-creator/scripts/security_scan.py path/to/skill

# 打包
python skill-creator/scripts/package_skill.py path/to/skill
```
