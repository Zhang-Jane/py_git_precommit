# Define the Python interpreter
PYTHON := /Users/xx/miniforge3/envs/zs-ads-data_3.10.2/bin/python3

# Define the tools for static code analysis
PYLINT := pylint
FLAKE8 := flake8
MYPY := mypy
BANDIT := bandit
MEMORY_PROFILER := memory_profiler
PY_SPY := py-spy

# 将你的 Python 代码放在 src 和 tests 目录下，或者根据需要修改 SRC 和 TESTS 变量。
#SRC := src
TESTS := /Users/xx/work_space/
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
	@echo "  memory_profile file=FILE - Profile memory usage of a specific file"
	@echo "  cpu_profile file=FILE - Profile CPU usage of a specific file"
	@echo "  bandit_file file=FILE - Run bandit security checks on a specific file"

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

memory_profile:
	@echo "Profiling memory usage on $(file)..."
	$(PYTHON) -m $(MEMORY_PROFILER) $(file)

cpu_profile:
	@echo "Profiling CPU usage on $(file)..."
	$(PY_SPY) top -- $(PYTHON) $(file)

bandit_file:
	@echo "Running bandit on $(file)..."
	$(PYTHON) -m $(BANDIT) $(file)