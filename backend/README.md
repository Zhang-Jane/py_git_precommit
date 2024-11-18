# 软件质量
## 1. 代码审查（Code Review）
作用：
代码审查是指在代码提交之前，通过开发团队的其他成员对代码进行检查和讨论，以发现潜在的缺陷、提升代码质量和维护可读性。代码审查有助于：
* 提高代码质量，确保遵循编程规范。
* 促进知识共享，减少团队成员之间的知识差距。
* 早期发现错误，降低后续维护成本。
* 为新成员提供学习机会，加快上手速度。

如何做：
* 选择合适的工具：使用像GitHub、GitLab、Bitbucket等工具自带的代码审查功能。
* 设定明确的审查标准：明确团队在代码风格、结构、性能和安全方面的标准。
* 进行逐行审查：审查人员逐行检查代码，提出意见和建议。
* 提供建设性反馈：应注重提出解决方案而不是仅指出问题，以促进改进。
* 确保跟进：在审查完成后，确保开发人员根据反馈进行修改，并重新提交。

## 2. 单元测试（Unit Testing）
作用：
单元测试是对最小可测试单元（通常是函数或类）进行验证的过程，目的在于确保每个单元都能按预期工作。其作用包括：
* 提高代码可靠性，确保新代码未破坏现有功能。
* 支持重构，便于在不破坏功能的情况下改进代码。
* 提供文档，单元测试可以作为使用代码的示例。
* 缩短调试时间，及早发现和修复错误。

如何做：
* 选择测试框架：常用的测试框架包括JUnit（Java）、pytest（Python）、Mocha（Node.js）等。
* 编写测试用例：为每个单元定义清晰的输入输出，写出相应的测试用例。
* 使用模拟对象：对于依赖外部系统的单元，可以使用模拟对象（Mock）来替代，让测试专注于单元本身。
* 持续集成：在持续集成（CI）过程中自动运行单元测试，确保每次提交都经过验证。

## 3. 日志（Logging）
作用：日志是一种记录系统运行状态和错误信息的机制，对于故障排查、系统监控和性能分析至关重要。其作用包括：
* 监控应用程序的运行情况，及时发现异常状态。
* 提供故障排查依据，便于分析问题根源。
* 为用户行为分析提供数据支持，优化系统性能。
* 记录重要事件，便于后续审计和合规。

如何做：
* 选择合适的日志库：例如，Python中的logging模块、Java中的Log4j等。
* 定义日志级别：通常包括DEBUG、INFO、WARNING、ERROR和CRITICAL，依据不同情况记录不同级别的信息。
* 规范日志格式：确保日志信息清晰，包含时间戳、日志级别、模块名、消息等关键信息。
* 定期监控和分析日志：使用工具（如ELK Stack）集中存储和分析日志，便于实时监控和历时数据分析。

## 4. 断点跟踪（Breakpoint Debugging）
作用：断点跟踪是调试代码时的一种技术，通过设置断点来暂停程序执行，检查程序状态。其目的在于：

* 逐步分析代码执行流程，找出逻辑错误。
* 查看变量的值和状态，理解程序在运行时的表现。
* 重现并调试复杂问题，尤其是难以通过其他手段发现的问题。

如何做：
* 使用 IDE 提供的调试工具：如Visual Studio、Eclipse、PyCharm等，利用其内置的调试器设置断点。
* 逐步执行：在断点处暂停程序，逐步执行每一行代码，观察变量变化和程序逻辑。
* 观察表达式：监控特定变量或表达式的值，了解其在不同执行阶段的状态。
* 堆栈跟踪：在程序崩溃时，查看堆栈信息，分析调用路径以找到出错的地方。

# python代码检测和git预处理

## 1. 创建Makefile文件

```bash
# Define the Python interpreter
PYTHON := xx/bin/python3

# Define the tools for static code analysis
PYLINT := pylint
FLAKE8 := flake8
MYPY := mypy

# 将你的 Python 代码放在 src 和 tests 目录下，或者根据需要修改 SRC 和 TESTS 变量。
#SRC := src
TESTS := xx/*
ALL := $(TESTS)

.PHONY: help lint flake8 pylint mypy check_syntax lint_file pylint_file flake8_file mypy_file check_syntax_file

help:
	@echo "Available targets:"
	@echo "  lint                - Run all static code checks (pylint, flake8, mypy)"
	@echo "  pylint              - Run pylint checks"
	@echo "  flake8              - Run flake8 checks"
	@echo "  mypy                - Run mypy checks"
	@echo "  check_syntax        - Check Python syntax (compilation)"
	@echo "  lint_file file=FILE - Run all static code checks on a specific file"
	@echo "  pylint_file file=FILE - Run pylint checks on a specific file"
	@echo "  flake8_file file=FILE - Run flake8 checks on a specific file"
	@echo "  mypy_file file=FILE - Run mypy checks on a specific file"
	@echo "  check_syntax_file file=FILE - Check Python syntax (compilation) on a specific file"

lint: pylint flake8 mypy

pylint:
	@echo "Running pylint..."
	$(PYTHON) -m $(PYLINT) $(ALL)

flake8:
	@echo "Running flake8..."
	$(PYTHON) -m $(FLAKE8) $(ALL)

mypy:
	@echo "Running mypy..."
	$(PYTHON) -m $(MYPY) $(ALL)

check_syntax:
	@echo "Checking Python syntax..."
	@$(PYTHON) -m compileall $(ALL)

lint_file: pylint_file flake8_file mypy_file

pylint_file:
	@echo "Running pylint on $(file)..."
	$(PYTHON) -m $(PYLINT) $(file)

flake8_file:
	@echo "Running flake8 on $(file)..."
	$(PYTHON) -m $(FLAKE8) $(file)

mypy_file:
	@echo "Running mypy on $(file)..."
	$(PYTHON) -m $(MYPY) $(file)

check_syntax_file:
	@echo "Checking Python syntax on $(file)..."
	@$(PYTHON) -m compileall $(file)
```

## 2. 配置具体规则配置文件

### 2.1 创建pyproject.toml（mypy配置）

```bash
# https://mypy.readthedocs.io/en/stable/config_file.html
# 重要的是要理解，配置文件没有合并，因为它会导致歧义。 --config-file 命令行标志具有最高的优先级，并且必须正确;否则mypy将报告错误并退出。如果没有命令行选项，mypy将按照上面的优先级顺序查找配置文件。
[tool.mypy]
# 排除特定的文件或目录
exclude = [
    '^test*\.py$',  # TOML literal string (single-quotes, no escaping necessary)
    "^test*\\.py$",  # TOML basic string (double-quotes, backslash and other characters need escaping)
]


# 启用严格模式，它将启用一组对类型检查更严格的选项
strict = true

# 显示详细的错误信息
show_error_context = true

# 允许推断为 Any 的变量
allow_untyped_calls = false

# 如果没有提供类型注释，允许推断为 Any
allow_untyped_globals = false

# 检查未使用的忽略指示符（# type: ignore）
warn_unused_ignores = true

# 检查未使用的导入
warn_unused_configs = true

# 警告没有类型提示的函数
warn_no_return = true

# 为 None 检查错误
no_implicit_optional = true

# 忽略缺少导入的模块（例如 C 扩展模块）
ignore_missing_imports = true

# 忽略特定的错误类型
disable_error_code = ["misc", "no-untyped-def", "no-untyped-call"]

# 启用对字节码文件的缓存以提高性能
cache_dir = ".mypy_cache"

# 指定要检查的文件或目录
files = ["src"]

# 打开或关闭特定的类型检查规则
check_untyped_defs = true
disallow_any_unimported = true
disallow_any_expr = true
disallow_any_generics = true
disallow_any_decorated = true

# 禁止未注释的函数定义
disallow_untyped_defs = true

# 禁止未注释的调用
disallow_untyped_calls = true

# 禁止无类型注释的全局变量
disallow_untyped_globals = true

# 禁止使用动态类型（Any）
disallow_any_explicit = true

# 禁止将 None 隐式地分配给可选类型
disallow_subclassing_any = true

# 启用对更严格的类型检查
strict_optional = false

# 启用对字面量类型的支持
allow_redefinition = false

# 警告对动态类型的使用
warn_redundant_casts = true
warn_return_any = true
warn_unreachable = true

# 允许和忽略的类型别名
implicit_reexport = true

# 指定 Python 版本
python_version = "3.9"

# 启用对插件的支持
plugins = []

# 针对特定模块的配置
[[tool.mypy.overrides]]
module = "*.tests.*"
ignore_errors = true

[[tool.mypy.overrides]]
module = "somelibrary"
ignore_missing_imports = true

[[tool.mypy.overrides]]
module = "path.to.ignore"
ignore_errors = true

[[tool.mypy.overrides]]
module = "django.*"
ignore_missing_imports = true

[[tool.mypy.overrides]]
module = "numpy.*"
ignore_missing_imports = true
```

### 2.2 创建.pylintrc（pylint配置）

```bash
# https://mypy.readthedocs.io/en/stable/config_file.html
# 重要的是要理解，配置文件没有合并，因为它会导致歧义。 --config-file 命令行标志具有最高的优先级，并且必须正确;否则mypy将报告错误并退出。如果没有命令行选项，mypy将按照上面的优先级顺序查找配置文件。
[tool.mypy]
# 排除特定的文件或目录
exclude = [
    '^test*\.py$',  # TOML literal string (single-quotes, no escaping necessary)
    "^test*\\.py$",  # TOML basic string (double-quotes, backslash and other characters need escaping)
]


# 启用严格模式，它将启用一组对类型检查更严格的选项
strict = true

# 显示详细的错误信息
show_error_context = true

# 允许推断为 Any 的变量
allow_untyped_calls = false

# 如果没有提供类型注释，允许推断为 Any
allow_untyped_globals = false

# 检查未使用的忽略指示符（# type: ignore）
warn_unused_ignores = true

# 检查未使用的导入
warn_unused_configs = true

# 警告没有类型提示的函数
warn_no_return = true

# 为 None 检查错误
no_implicit_optional = true

# 忽略缺少导入的模块（例如 C 扩展模块）
ignore_missing_imports = true

# 忽略特定的错误类型
disable_error_code = ["misc", "no-untyped-def", "no-untyped-call"]

# 启用对字节码文件的缓存以提高性能
cache_dir = ".mypy_cache"

# 指定要检查的文件或目录
files = ["src"]

# 打开或关闭特定的类型检查规则
check_untyped_defs = true
disallow_any_unimported = true
disallow_any_expr = true
disallow_any_generics = true
disallow_any_decorated = true

# 禁止未注释的函数定义
disallow_untyped_defs = true

# 禁止未注释的调用
disallow_untyped_calls = true

# 禁止无类型注释的全局变量
disallow_untyped_globals = true

# 禁止使用动态类型（Any）
disallow_any_explicit = true

# 禁止将 None 隐式地分配给可选类型
disallow_subclassing_any = true

# 启用对更严格的类型检查
strict_optional = false

# 启用对字面量类型的支持
allow_redefinition = false

# 警告对动态类型的使用
warn_redundant_casts = true
warn_return_any = true
warn_unreachable = true

# 允许和忽略的类型别名
implicit_reexport = true

# 指定 Python 版本
python_version = "3.9"

# 启用对插件的支持
plugins = []

# 针对特定模块的配置
[[tool.mypy.overrides]]
module = "*.tests.*"
ignore_errors = true

[[tool.mypy.overrides]]
module = "somelibrary"
ignore_missing_imports = true

[[tool.mypy.overrides]]
module = "path.to.ignore"
ignore_errors = true

[[tool.mypy.overrides]]
module = "django.*"
ignore_missing_imports = true

[[tool.mypy.overrides]]
module = "numpy.*"
ignore_missing_imports = true

```

## 3. 创建git的pre-commit
**Git hooks manager:**
https://github.com/evilmartians/lefthook
```bash
# 使用 pre-commit 工具，它允许你管理和配置多个预提交钩子
1. pip install pre-commit
2. 创建 .pre-commit-config.yaml 文件
```yaml
repos:
  - repo: local
    hooks:
      - id: run-local-script
        name: Run Local Script
        entry: bash your_script.sh
        language: system
        files: \.py$
        stages: [commit]
        always_run: true
files: \.py$：指定只检查 Python 文件。
stages: [commit]：确保钩子在 commit 阶段运行。
always_run: true：确保钩子始终运行。
```
```yaml
repos:
  - repo: local
    hooks:
      - id: check-all-py  # 每个钩子都有一个唯一的标识符（id），用于引用该钩子。
        name: Check Local .py Script
        entry: bash check_py_files.sh
        language: system  # 每个钩子都有一个唯一的标识符（id），用于引用该钩子。
        files: \.py$  # 每个钩子都有一个唯一的标识符（id），用于引用该钩子。
        stages: [commit]  # 指定钩子在哪些阶段运行。在这里，钩子将在提交阶段运行。
        always_run: true  # 指定钩子是否在每次提交时都运行，即使没有相关文件更改
      - id: check-added-large-files
        name: Check Added Large Files  # 添加 name 键
        entry: echo "Check Added Large Files"  # 添加 entry 键
        language: system
        args: ['--maxkb=10240']  # 设置最大文件大小为10MB
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.6.0 # 指定了使用的版本，这里是 v4.6.0。
    hooks:
      - id: end-of-file-fixer # 确保文件以换行符结束。
      - id: trailing-whitespace # 删除行尾的多余空格。
  - repo: https://github.com/python-jsonschema/check-jsonschema
    rev: 0.29.2
    hooks:
      - id: check-github-workflows
        args: ["--verbose"]
  - repo: https://github.com/codespell-project/codespell
    rev: v2.3.0
    hooks:
      - id: codespell # 用于检查拼写错误，--write-changes 参数表示自动修复拼写错误。
        args: ["--write-changes"]
  - repo: https://github.com/tox-dev/tox-ini-fmt
    rev: "1.4.1"
    hooks:
      - id: tox-ini-fmt # 格式化 tox.ini 文件，-p fix 参数表示进行修复。
        args: ["-p", "fix"]
  - repo: https://github.com/tox-dev/pyproject-fmt
    rev: "2.2.4"
    hooks:
      - id: pyproject-fmt # 格式化 pyproject.toml 文件。
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: "v0.6.7"
    hooks:
      - id: ruff-format # 用于格式化代码。
      - id: ruff
        args: ["--fix", "--unsafe-fixes", "--exit-non-zero-on-fix"] # 进行代码检查，--fix 表示自动修复，--unsafe-fixes 允许不安全的修复，--exit-non-zero-on-fix 表示如果进行了修复则返回非零状态。
  - repo: meta
    hooks:
      - id: check-hooks-apply # 检查所有钩子是否都已应用。
      - id: check-useless-excludes # 检查配置中是否存在无用的排除项。
```
```yaml
repos:
  - repo: local
    hooks:
      - id: check-all-py  # 每个钩子都有一个唯一的标识符（id），用于引用该钩子。
        name: Check Local .py Script
        entry: bash check_py_files.sh
        language: system  # 每个钩子都有一个唯一的标识符（id），用于引用该钩子。
        files: \.py$  # 每个钩子都有一个唯一的标识符（id），用于引用该钩子。
        stages: [commit]  # 指定钩子在哪些阶段运行。在这里，钩子将在提交阶段运行。
        always_run: true  # 指定钩子是否在每次提交时都运行，即使没有相关文件更改
      - id: check-added-large-files
        name: Check Added Large Files  # 添加 name 键
        entry: echo "Check Added Large Files"  # 添加 entry 键
        language: system
        args: ['--maxkb=10240']  # 设置最大文件大小为10MB
```
3. pre-commit install 安装预提交钩子
$ pre-commit install 
pre-commit installed at .git/hooks/pre-commit

## check_py_files.sh
```bash
#!/bin/bash

# Get the list of staged files for commit
FILES=$(git diff --cached --name-only --diff-filter=ACM | grep '\.py$')

# Check if there are any Python files to process
if [ -z "$FILES" ]; then
  echo "No Python files to check."
  exit 0
fi

# Example script
echo "Running pre-commit script..."

# Loop through each file and run make pylint_file, flake8_file, and mypy_file
for FILE in $FILES; do
    echo "STEP0: Running make check file syntax=$FILE..."
    make check_syntax_file file="$FILE"
    if [ $? -ne 0 ]; then
        echo "Compileall failed for $FILE. Aborting commit."
        exit 1
    fi
    
    echo "STEP1: Running make pylint_file file=$FILE..."
    make pylint_file file="$FILE"
    if [ $? -ne 0 ]; then
        echo "Pylint failed for $FILE. Aborting commit."
        exit 1
    fi

    echo "STEP2: Running make flake8_file file=$FILE..."
    make flake8_file file="$FILE"
    if [ $? -ne 0 ]; then
        echo "Flake8 failed for $FILE. Aborting commit."
        exit 1
    fi

    echo "STEP2: Running make mypy_file file=$FILE..."
    make mypy_file file="$FILE"
    if [ $? -ne 0 ]; then
        echo "Mypy failed for $FILE. Aborting commit."
        exit 1
    fi
done

echo "Pre-commit script finished successfully."

```
## git-cliff（generate changelog files）

```bash
# doc
https://git-cliff.org/docs/

# Edit the default configuration (cliff.toml) as you like. Check out the examples for different templates.
git cliff --init

# Generate a changelog
git cliff -o CHANGELOG.md
```

## git message
**commit message类型**
* 🐛 || **fix**: 修复了某个 bug
* ✨ || **feat**: 增加了某个功能
* 🛠 || **build**: 一些影响构建系统的更新
* 🔀 || **change**: 一些不更改核心代码的更新
* 💎 || **style**: 代码格式化、添加空格等代码格式变更
* 🚀 || **perf**: 改进性能的变化
* ⚙️ || **ci**: 变更了一些 CI 配置
* 📚 || **docs**: 对文档做出了一些修改
* 🚨 || **test**: 新增或修改测试文件
* 📦 || **refactor**: 重构了代码（没有新增/修复）
* ♻️ || **chore**: 不修改代码文件的其他修改
* 🗑 || **revert**: 恢复上次的提交
