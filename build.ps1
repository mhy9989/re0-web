# Github Pages 要求所发布的 Html 路径不能有下划线，否则无法解析
# 此脚本的目的是把 GitBook 生成的 _book 目录复制到 book

If((Test-Path 'gitbook/book')) {
Write-Output "Remove gitbook/book ..."
Remove-Item gitbook/book -recurse
Start-Sleep 1
}

If((Test-Path 'gitbook/_book')) {
Write-Output "Remove gitbook/_book ..."
Remove-Item gitbook/_book -recurse
Start-Sleep 1
}

If(!(Test-Path 'gitbook/node_modules')) {
    echo "Copy nodejs module ..."
    Copy-Item node_modules gitbook/node_modules -recurse -force
    Sleep 2
}

Write-Output "GitBook Building ..."
gitbook build gitbook
Start-Sleep 2

Write-Output "Building for GitHub Pages ..."
mv gitbook/_book gitbook/book
Start-Sleep 1

Write-Output "Remove *.md..."
Remove-Item gitbook/book/markdown/ch -Include *.md -Recurse
Remove-Item gitbook/book/markdown/character.md -Recurse
Start-Sleep 1

Write-Output "Remove gitbook/node_modules ..."
Remove-Item "gitbook/node_modules" -Recurse -Force
Start-Sleep 1

Write-Output "Build Finish."
Write-Output "You can push to github now."

