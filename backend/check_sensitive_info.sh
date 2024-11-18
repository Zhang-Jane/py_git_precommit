#!/bin/bash

# 定义敏感信息模式
sensitive_patterns=("password" "api_key" "secret" "token")

# 扫描所有已暂存的文件
files=$(git diff --cached --name-only)
found_sensitive_info=false

for file in $files; do
    if [ -f "$file" ]; then
        for pattern in "${sensitive_patterns[@]}"; do
            if grep -q "$pattern" "$file"; then
                echo "Sensitive information detected in file: $file"
                echo "Pattern: $pattern"
                found_sensitive_info=true
            fi
        done
    fi
done

# 如果发现敏感信息，拒绝提交
if [ "$found_sensitive_info" = true ]; then
    echo "Commit rejected due to sensitive information."
    exit 1
fi
