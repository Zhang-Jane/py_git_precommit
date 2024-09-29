# 指定日期范围和文件路径
START_DATE="2024-08-1"
END_DATE="2024-08-16"
FILE_PATH=""

# 根据日期生成输出文件的名称
OUTPUT_FILE="${START_DATE//-/}至${END_DATE//-/}的diffs.txt"

# 如果输出文件存在，先删除它
if [ -f "$OUTPUT_FILE" ]; then
    rm "$OUTPUT_FILE"
fi

# 输出提交日志到文件
echo "提取日期范围内提交的差异..." > "$OUTPUT_FILE"
git log --since="$START_DATE" --until="$END_DATE" --pretty=format:"%h" -- "$FILE_PATH" | while read -r commit; do
    echo "Diff for commit $commit" >> "$OUTPUT_FILE"
    git show "$commit" -- "$FILE_PATH" >> "$OUTPUT_FILE"

    # 增加分隔行，方便阅读
    echo -e "\n----------------------------------------\n" >> "$OUTPUT_FILE"
done

# 提示完成
echo "提交差异已提取到 $OUTPUT_FILE。"