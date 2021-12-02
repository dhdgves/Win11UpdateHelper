# WIN11升级脚本

### 这是什么

这是一个简单的，能够自动替换掉WIN11升级时的AppraiserRes.dll以跳过对TPM的检查。这个脚本需要在管理员模式下运行，运行后将检测升级文件夹中的AppraiserRes.dll是否存在，如果存在，则使用一个只读的空文件替代它，如果不存在，则会等待，直到其被创建。这个脚本极其简单。

### 怎么使用

在你选择升级你的WIN11时，右键左下角的windows图标，选择Windows终端 （管理员），进入这个目录输入

```powershell
.\RunWhileUpdateWin11.ps1
```

等待完成即可。

### 可能对哪些人有用

对于那些向我一样使用[offlineinsiderenroll](https://github.com/abbodi1406/offlineinsiderenroll)强行升级win11的人可能会有用。

win11每次升级时不必再和windows拼手速了。