## Electsys++ for Microsoft Edge

上海交通大学本科教学信息服务网优化插件Microsoft Edge版。

该代码库中包含子模块[ZhaobangChina/electsys](https://github.com/ZhaobangChina/electsys)，为原版Chrome扩展派生而来。核心代码均位于子模块中。克隆时请留意子模块是否正确克隆。

### 生成安装包
#### 先决条件
1. 安装有node.js和manifoldjs，并且确保可以在PowerShell中直接运行manifoldjs命令。
2. 安装有Windows 10 SDK。若安装位置不是默认位置的话，需要在PowerShell中手动指定签名工具signtool的位置。例如：
    - $signtool = "C:\Program Files (x86)\Windows Kits\10\bin\x86\signtool.exe"
#### 生成
1. 克隆源代码。注意：应确保位于edgeextension/manifest/Extension的子模块也正确克隆。
2. 在代码库根目录运行PowerShell，输入命令./build/package.ps1 。
3. 成功生成安装包后，安装包位于edgeextension/package/edgeExension.appx 。

### 安装
由于Windows应用商店尚未通过上架商店的申请，所以目前只能通过“旁加载”方式安装。
#### 先决条件
1. 操作系统至少为Windows 10 1607版本。
2. 设置-针对开发人员-使用开发人员功能中至少设置为“旁加载应用”。
#### 安装
1. 双击Electsys_StoreKey.pfx安装证书。存储位置需要选择“本地计算机”，密码为空，证书存储选择“受信任人”。
2. 双击appx安装包安装。