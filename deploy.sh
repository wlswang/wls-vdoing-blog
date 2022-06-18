#!/usr/bin/env sh
###
 # @Author: WangLiShuai
 # @Date: 2022-06-17 16:43:19
 # @LastEditTime: 2022-06-18 16:45:03
 # @FilePath: \wls-vdoing-blog\deploy.sh
 # @Description: 
### 

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

# deploy to github pages
# 如果是发布到自定义域名
echo 'wls.ink' > CNAME

if [ -z "$VDOING_TOKEN" ]; then
  msg='deploy'
  githubUrl=git@github.com:wlswang/wls-vdoing-blog.git
else
  msg='来自github actions的自动部署'
  githubUrl=https://wlswang:${VDOING_TOKEN}@github.com/wlswang/wls-vdoing-blog.git
  git config --global user.name "wlswang"
  git config --global user.email "121840415@qq.com"
fi
git init
git add -A
git commit -m "${msg}"
git push -f $githubUrl master:gh-pages # 推送到github gh-pages分支


# 如果发布到 https://<USERNAME>.github.io
# git push -f git@github.com:<wlswang>/<USERNAME>.github.io.git master

# 如果发布到 https://<USERNAME>.github.io/<REPO>
# git push -f git@github.com:<USERNAME>/<REPO>.git master:gh-page

# deploy to coding pages
# echo 'www.xugaoyi.com\nxugaoyi.com' > CNAME  # 自定义域名
# echo 'google.com, pub-7828333725993554, DIRECT, f08c47fec0942fa0' > ads.txt # 谷歌广告相关文件

# if [ -z "$CODING_TOKEN" ]; then  # -z 字符串 长度为0则为true；$CODING_TOKEN来自于github仓库`Settings/Secrets`设置的私密环境变量
#   # codingUrl=git@e.coding.net:xgy/xgy.git
#   codingUrl=git@e.coding.net:iit666/github/wls-vdoing-blog.git

# else
#   codingUrl=https://iit666:${CODING_TOKEN}@e.coding.net/iit666/github/wls-vdoing-blog.git
# fi
# git add -A
# git commit -m "${msg}"
# git push -f $codingUrl master # 推送到coding

cd -
rm -rf docs/.vuepress/dist
