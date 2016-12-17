hexo generate
cp -r ./public/* .deploy/meleslilijing.github.io
cd .deploy/meleslilijing.github.io
git add .
git commit -sm "update by Hexo deploy bash"
git push origin master
