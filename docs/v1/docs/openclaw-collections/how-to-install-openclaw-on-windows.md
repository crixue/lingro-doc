# Windows 用户看过来！四步走教你在电脑上安装"小龙虾"（OpenClaw）🦞

**关键词：OpenClaw Windows部署 / 小龙虾安装教程 / WSL2 / 零基础**

---

想必大家最近都听闻了 **OpenClaw** 这款开源 AI Agent框架，圈子里大家都亲切地叫它 **"小龙虾"** 🦞。

简单来说，小龙虾是一个可以跑在你自己电脑上的**AI 智能管家**。装好之后，你可以通过微信、飞书、浏览器里跟它聊天，让它帮你搜资料、写文案、管理日程……而且所有数据都在你自己手里，不用担心隐私泄露。

听起来是不是很心动？那就跟我一起，一步一步把 OpenClaw 这只"小龙虾"部署到你的 Windows 电脑上吧！

> ⏱️ **预计用时**：20~30 分钟（大部分时间是等下载）

> 💻 **适用系统**：Windows 10（2004 版本及以上）或 Windows 11

---

## 直接在 Windows上装不行吗？

你可能会问：我的电脑就是 Windows 啊，像.exe 文件直接安装不就行了？

这里要先解释一下：小龙虾本质上是一个 Linux 程序。你可以把 Linux 想象成另一种"操作系统语言"——就像有的软件只有英文版没有中文版一样，小龙虾目前在 Windows 原生环境下没有直接安装的可执行文件且**没有经过充分测试**，通过 PowerShell 直接安装可能会遇到各种兼容性问题，甚至安装成功了也可能运行不稳定。

但别担心！微软早就想到了这个问题，给 Windows 内置了一个叫 **WSL2** 的功能。你可以把它理解为：

> **在你的 Windows 电脑里，开了一个"Linux 小房间"。** 小龙虾住在这个小房间里，但你照样可以在 Windows 的浏览器里跟它聊天。两边互不干扰，完美共存！

而且用 WSL2 装东西反而比直接在 Windows 上装**更简单**——因为很多开发工具天生就是为 Linux 设计的，安装和使用也更方便。

---

## 总共就四步

| 步骤 | 做什么 | 难度 |
|:---:|:---|:---:|
| 1️⃣ | 安装 WSL2（给电脑开一个 Linux 小房间）| ⭐ |
| 2️⃣ | 安装 Node.js 22+（小龙虾运行需要的"燃料"）| ⭐ |
| 3️⃣ | 🇨🇳 配置GN镜像源（让下载飞起来）| ⭐ |
| 4️⃣ | 一键安装小龙虾并完成初始设置 | ⭐⭐ |

---

## 第一步：安装 WSL2

**WSL2 是什么？** 前面说了，它就是 Windows 里的一个"Linux 小房间"。安装方法非常简单：

**1. 打开 PowerShell（管理员模式）：**
- 右键点击屏幕左下角的 **Windows 图标**（或按 `Win + X`）
- 选择 **"终端(管理员)"** 或 **"Windows PowerShell(管理员)"**

**2. 输入以下命令，然后按回车：**

```powershell
wsl --install``
```

就这一行！Windows 会自动帮你下载并安装 Ubuntu（一个最流行的 Linux 版本）。

**3. 等待安装完成后，重启电脑。**

**4. 重启后，系统会自动弹出一个黑色窗口**，要求你设置一个用户名和密码。这个是 Linux 小房间里的账号，随便取个名字就行（比如你的英文名），密码也随意设一个好记的。

> ⚠️ **注意**：输入密码时屏幕上不会显示任何字符（连星号 `***` 都没有），这是 Linux 的正常现象，不是卡了！放心大胆地输入，输完按回车就好。

**5. 看到类似 `yourname@DESKTOP:~$` 的提示符，就说明你已经成功进入 Linux 小房间了！** 🎉

> 💡 **以后怎么再打开这个小房间？** 在 Windows 搜索栏里输入 "Ubuntu"，点击打开就行。或者在任意 PowerShell / 命令提示符里输入 `wsl` 回车。

---

## 第二步：安装 Node.js 22+

> 💡此步需在刚才打开的 **Ubuntu 窗口** 里操作（不是 PowerShell！）

小龙虾需要 **Node.js**（版本 22 以上）才能运行。你可以把 Node.js 理解为小龙虾的"燃料"——没有它，小龙虾就跑不起来。

在刚才打开的 **Ubuntu 窗口**里（注意，是 Ubuntu 窗口，不是 PowerShell！），依次输入以下命令：

**1. 先更新一下系统自带的软件清单：**

安装完成之后先别着急装小龙虾，我们先把 Linux 小房间里的系统更新一下，确保房间所有“装饰”组件都是最新的： 不过使用默认的软件源在GN下载可能会很慢，所以我们会换成GN镜像源。

## 配置 Ubuntu APT 阿里云镜像源

`sudo apt update && sudo apt upgrade -y` 默认使用的是 Ubuntu 官方源不在GN会很慢。可以将 APT 源替换为CN 阿里云镜像源来加速。

在 **Ubuntu 窗口** 中依次执行以下命令：

**1. 备份原始源配置文件：**

```bash
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
```

**2. 替换为阿里云镜像源：**

在 WSL2 的 Ubuntu 窗口中执行以下命令确认当前的Ubuntu版本：

```bash
lsb_release -a
```

会输出类似以下信息：

```
Distributor ID: Ubuntu
Description:    Ubuntu 24.04 LTS
Release:        24.04
Codename:       noble
```

其中 Release 就是你的 Ubuntu 版本号，这就代表你当前使用的是 Ubuntu 24.04 (Noble)。根据这个版本号，我们来替换 APT 源：

对于 **Ubuntu 24.04 (Noble)**（WSL2 默认安装的最新版本）：

```bash
sudo sed -i 's|http://archive.ubuntu.com/ubuntu|https://mirrors.aliyun.com/ubuntu|g' /etc/apt/sources.list
sudo sed -i 's|http://security.ubuntu.com/ubuntu|https://mirrors.aliyun.com/ubuntu|g' /etc/apt/sources.list
```

> 💡 如果你的 WSL2 安装的是 **Ubuntu 22.04 (Jammy)**，上面的命令同样适用。可以用 `lsb_release -a` 查看你的 Ubuntu 版本。

> ⚠️ **注意**：Ubuntu 24.04 开始可能使用新的 `/etc/apt/sources.list.d/ubuntu.sources` 格式文件。如果上面的命令执行后 `sources.list` 是空的，则需要改用：
> ```bash
> sudo sed -i 's|http://archive.ubuntu.com/ubuntu|https://mirrors.aliyun.com/ubuntu|g' /etc/apt/sources.list.d/ubuntu.sources
> sudo sed -i 's|http://security.ubuntu.com/ubuntu|https://mirrors.aliyun.com/ubuntu|g' /etc/apt/sources.list.d/ubuntu.sources
> ```

**3. 然后再执行更新：**

```bash
sudo apt update && sudo apt upgrade -y
```
> 💡 `sudo` 的意思是"用管理员权限执行"，系统会让你输入刚才设置的密码。

**2. 安装 Node.js 22：**

我们使用 NodeSource 提供的官方源来安装最新的 Node.js 22：

```bash
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt install -y nodejs
```

**3. 验证安装成功：**

```bash
node -v
```

如果屏幕上显示 `v22.x.x`（比如 `v22.15.0`），就说明安装成功了！👍

---

## 第三步：🇨🇳 配置GN镜像源（重要！）

> 💡此步需在刚才打开的 **Ubuntu 窗口** 里操作（不是 PowerShell！）

这一步**非常关键**！如果你在中国大陆，不配置镜像源的话，后面下载小龙虾会非常慢，甚至可能完全下载不了。

这就好比：你要从海外的仓库搬东西回家，走国际物流要等好几天还可能丢件。但如果GN有一个"分仓"（镜像源），直接从GN拿就快多了！

在 Ubuntu 窗口里输入：

```bash
npm config set registry https://registry.npmmirror.com
```

这行命令的意思是：告诉 npm（Node.js 的包管理工具）以后都从阿里云的GN镜像下载，而不是去国外。

验证一下是否设置成功：

```bash
npm config get registry
```

如果返回 `https://registry.npmmirror.com`，就说明配置好了 ✅

---

## 第四步：安装小龙虾 🦞 并完成初始设置

> 💡此步需在刚才打开的 **Ubuntu 窗口** 里操作（不是 PowerShell！）

终于到了最激动人心的时刻！前面三步我们已经做好了所有准备工作：
- ✅ WSL2 Linux 小房间 — 已就位
- ✅ Node.js 22+ 燃料 — 已加满
- ✅ GN镜像源 — 已配好

现在，我们要正式把小龙虾请进家门了！

### 4.1 一行命令，安装小龙虾

还记得第二步我们安装 Node.js 的时候，系统自动附赠了一个叫 **npm** 的工具吗？你可以把 npm 想象成一个**"软件商店"**——就像手机上的应用商店一样，你想装什么软件，告诉它名字就行，它会自动帮你下载、安装、配置好。

在 Ubuntu 窗口里输入：

```bash
npm install -g openclaw@latest
```

**给你翻译一下这行命令：**
- `npm install` = 去软件商店下载安装
- `-g` = 装成"全局"的（就是说电脑里哪里都能用，而不是只在某个文件夹里能用）
- `openclaw@latest` = 要装的软件叫"openclaw"，下载最新版

因为我们在第三步已经配好了阿里云镜像源，所以这个下载过程会从GN服务器拉取，速度嗖嗖的 🚀。大概等 1~3 分钟就好。

> ⚠️ **如果中途出现 `sharp` 相关的报错**，别慌！这是一个常见的小问题。换成下面这行命令重新安装即可：
> ```bash
> SHARP_IGNORE_GLOBAL_LIBVIPS=1 npm install -g openclaw@latest
> ```
> 这行命令多了一个"小开关"，告诉安装程序："别用系统自带的图片处理库了，直接用预编译好的版本就行。"

### 4.2 验证小龙虾是否安装成功

安装完成后，我们先确认一下小龙虾是否真的住进来了：

```bash
openclaw --version
```

如果屏幕上显示了一个版本号（比如 `x.x.x`），恭喜你，小龙虾已经成功入住！🎉

> ❓ **如果提示 `openclaw: command not found`（找不到命令）怎么办？**
>
> 这说明系统还不知道小龙虾"住在哪个房间"。我们手动告诉它一下：
> ```bash
> echo 'export PATH="$(npm prefix -g)/bin:$PATH"' >> ~/.bashrc
> source ~/.bashrc
> ```
> 然后再试一次 `openclaw --version`，应该就能识别了。

### 4.3 运行新手引导——给小龙虾做"入职培训"

小龙虾虽然装好了，但它还不知道你想让它干什么、用什么 AI 模型、通过什么方式跟你聊天。所以我们需要给它做一个简单的"入职培训"：

```bash
openclaw onboard --install-daemon
```

> 💡 `--install-daemon` 的意思是同时安装一个"后台服务"，让小龙虾可以一直在后台默默运行，随时待命。就像你家的 WiFi 路由器，开机就自动工作，不需要每次手动启动。

运行后会进入一个**交互式引导向导**，它会一步步问你几个简单的问题：

| 引导问题 | 怎么选？                                         |
|:---|:---------------------------------------------|
| 选择 AI 模型提供商 | 推荐选 MiniMax模型（需要在 MiniMax上创建） |
| 工作区位置 | 直接按回车，用默认值就好                                 |
| Gateway 网关设置 | 直接按回车，用默认值就好                                 |
| 选择聊天渠道 | 飞书等，按需选择，配置的时候也可以先全部跳过                       |
| 是否安装后台服务 | 选"是"（前面命令已带此参数）                              |

> 🌟 **小白建议**：如果你还没有配置消息渠道，完全没关系！先全部跳过，装好就能直接在浏览器里聊天，不需要任何第三方渠道，等你熟悉了之后再安装也不迟，目前微信、QQ、飞书等社交软件都在相继接通中。

### 4.4 给小龙虾做个"体检"

入职培训完成后，我们给小龙虾做一个全面体检，确保一切正常：

```bash
openclaw doctor
```

这个命令会自动检查所有关键组件是否就绪。如果所有检查项都通过了，你会看到一片令人愉悦的成功提示 ✅

再看看网关服务的运行状态：

```bash
openclaw status
```

### 4.5 打开浏览器，和小龙虾聊天！

最后一步，也是最有成就感的一步——打开小龙虾的网页聊天界面！

```bash
openclaw dashboard
```

然后在你 **Windows 的浏览器**里打开这个地址：

👉 **http://127.0.0.1:18789/#token=xxx**

你会看到一个仪表板界面，里面有一个聊天窗口。现在，你可以直接跟你的小龙虾对话了！

试着说一句："你好呀，小龙虾！帮我写一首关于春天的诗吧 🌸"

---

> 📌 **第四步小结**：
> ```
> npm install -g openclaw@latest          ← 安装小龙虾
> openclaw --version                       ← 确认安装成功
> openclaw onboard --install-daemon        ← 新手引导 + 后台服务
> openclaw doctor                          ← 体检
> openclaw status                          ← 查看状态
> openclaw dashboard                       ← 打开网页聊天界面
> ```
> 就这 6 行命令，你的小龙虾就活蹦乱跳了！🦞

---

## 🔧 常见问题排查

### Q1：安装脚本运行后提示找不到 `openclaw` 命令？

这通常是"路径"（PATH）没配好。试试关掉 Ubuntu 窗口，重新打开，再输入 `openclaw`。

如果还不行，手动把 npm 的全局路径加到 PATH 里：

```bash
echo 'export PATH="$HOME/.npm-global/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Q2：下载过程中卡住或报错 `ETIMEDOUT`？

大概率是网络问题。检查一下是否已经配置了GN镜像源（回到第三步确认）。

### Q3：`node -v` 显示的版本低于 22？

说明安装的 Node.js 版本不对。重新运行第二步的命令，确保使用的是 `setup_22.x`。

### Q4：WSL2 安装时提示"虚拟化未启用"？

需要在 BIOS 里开启虚拟化（VT-x / AMD-V）。具体方法因电脑品牌而异，搜索"你的电脑品牌 + 开启虚拟化"就能找到教程。

---

## 总结

让我们回顾一下整个流程：

```
安装 WSL2（给 Windows 开个 Linux 小房间）
    ↓
安装 Node.js 22+（给小龙虾加燃料）
    ↓
配置GN镜像源（让下载不再龟速）
    ↓
一键安装小龙虾 + 新手引导
    ↓
打开浏览器，开始聊天！
```

看，其实一点都不难对吧？整个过程就像搭积木一样，一块一块往上叠就好了。

如果你在安装过程中遇到了任何问题，欢迎在评论区留言，我会尽量帮你解答！也欢迎已经安装成功的小伙伴分享一下你的小龙虾都帮你做了什么有趣的事情

**觉得有用的话，记得点赞 ❤️ + 收藏 ⭐ + 关注，下期我们聊聊怎么给小龙虾接上各类消息渠道！**