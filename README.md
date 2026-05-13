# SwiftUI macOS View Protocol Body Demo

## 简介

这是 1 个专门讲 `View` protocol 的 macOS SwiftUI demo。

它只回答 1 个问题：

```swift
struct ContentView: View
```

这里的 `View` 到底是什么，为什么只要写 `body`。

## 快速开始

### 环境要求

- macOS 14+
- Xcode 15+
- XcodeGen

### 运行

```bash
cd /Users/peng.li/workspace/freewind-demos/swiftui-macos-view-protocol-body-demo
./scripts/build.sh
open ViewProtocolBodyDemo.xcodeproj
```

### 开发循环

```bash
cd /Users/peng.li/workspace/freewind-demos/swiftui-macos-view-protocol-body-demo
./dev.sh
```

## 注意事项

- 这里不展开讲自定义 protocol
- 只聚焦 `View` 这个 SwiftUI 最常见的协议
- 重点是 `body` 和 `some View`

## 教程

### 1. `View` 是什么

`View` 是 SwiftUI 定义的协议。

意思是：

- 谁说自己是 `View`
- 谁就要满足 `View` 这份约定

最核心的约定就是：

```swift
var body: some View { get }
```

### 2. 为什么只写 `body`

因为对 SwiftUI 来说，1 个 View 的本质不是“你有多少字段”，而是：

- 你最终能描述出什么界面

`body` 就是“把这个界面描述出来”的地方。

### 3. `some View` 是什么

可以先把它理解成：

- “我返回的是某种具体的 View”
- 但我现在不把具体类型名摊给你看

所以你可以写：

```swift
var body: some View {
  Text("Hello")
}
```

也可以写：

```swift
var body: some View {
  VStack {
    Text("A")
    Text("B")
  }
}
```

### 4. 这个 demo 怎么演示

我做了 3 个小 View：

1. `TitleBadgeView`
2. `InfoRowView`
3. `DemoCardView`

它们全都只是：

- `struct Xxx: View`
- 各自交出 `body`

然后再由 `ContentView` 把它们拼起来。

### 5. 生动例子

把 `View` 想成“画图规范”。

SwiftUI 不关心你脑子里怎么想，只关心：

- 你最后能不能按规范交出 1 张图

`body` 就是你交图的地方。

## 操作

1. 运行 app
2. 看页面其实由多个小 View 拼出来
3. 点不同按钮
4. 看右侧日志区记录“是谁通过 body 交出了界面”
5. 回头看代码，体会每个 View 真正要做的事只有“描述 UI”
