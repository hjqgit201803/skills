# 常见问题与解决方案

## 配置问题

### Q: settings.json 修改后不生效？

**A**: 检查以下几点：
1. JSON 格式是否正确（使用 `jq . settings.json` 验证）
2. 文件路径是否正确
3. 是否有更高优先级的配置覆盖
4. 重启 Claude Code

### Q: Hook 命令没有执行？

**A**: 排查步骤：
1. 手动运行命令验证语法
2. 检查命令路径（使用绝对路径）
3. 查看错误日志：`~/.claude/errors.log`
4. 确认 hook 类型正确

### Q: 权限设置过于严格？

**A**: 调整建议：
```json
{
  "permissions": {
    "allowedTools": {
      "Bash": "prompt",         // 改为 prompt
      "Bash(git *)": "allow",   // 添加允许的命令
      "Bash(npm *)": "allow"
    }
  }
}
```

## 技能问题

### Q: 自定义 Skill 没有被触发？

**A**: 检查：
1. `description` 是否包含触发关键词
2. SKILL.md 语法是否正确
3. Skill 是否在正确位置
4. `disable-model-invocation` 是否为 `false`

### Q: Skill 运行在错误上下文？

**A**: 添加 `context: fork`：
```yaml
---
context: fork
agent: general-purpose
---
```

## 诊断命令

```bash
# 检查配置
jq . ~/.claude/settings.json

# 测试 Hook
echo "test" | bash -c 'your_hook_command'

# 查看已安装技能
ls -la ~/.claude/skills/

# 验证 Skill 结构
find skill-name/ -name "SKILL.md"
```

## 常见错误

| 错误 | 原因 | 解决方案 |
|------|------|---------|
| `Permission denied` | Hook 命令无执行权限 | 添加 `chmod +x` |
| `Command not found` | 命令路径不在 PATH 中 | 使用绝对路径 |
| `JSON parse error` | JSON 格式错误 | 使用 `jq` 验证 |
| `Skill not found` | Skill 路径错误 | 检查安装位置 |
