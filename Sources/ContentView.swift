import SwiftUI

// 这是主界面；`View` 是协议，所以这里只是在“遵守协议”。
struct ContentView: View {
  // 这是右侧日志列表。
  @State private var logs: [String] = []

  // 组织主界面布局；这就是交给 `View` 协议的 `body`。
  var body: some View {
    // 用纵向布局包住顶部与左右分栏。
    VStack(alignment: .leading, spacing: 16) {
      headerCard

      HStack(alignment: .top, spacing: 16) {
        examplesPanel
        logsPanel
      }
    }
    .padding(20)
    .frame(minWidth: 1180, minHeight: 800)
  }

  // 顶部说明卡；它自己也是 1 个 View。
  private var headerCard: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("View protocol 最核心只问你 1 件事：body 在哪")
        .font(.system(size: 28, weight: .bold))

      Text("SwiftUI 不要求你继承什么类。你只要说自己是 `View`，然后交出 `body: some View`，它就知道怎么把你的 UI 拼进整棵界面树。")
        .foregroundStyle(.secondary)

      HStack(spacing: 10) {
        badge("View 是协议")
        badge("body 是 UI 描述")
        badge("some View = 某种具体 View")
      }
    }
    .padding(18)
    .background(.thinMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }

  // 左边示例区。
  private var examplesPanel: some View {
    VStack(alignment: .leading, spacing: 16) {
      Text("左边：3 个小 View，各自只负责交 body")
        .font(.headline)

      TitleBadgeView(text: "我只是 1 个最小 View") {
        logs.insert("TitleBadgeView 通过 body 交出了 1 个标题角标。", at: 0)
      }

      InfoRowView(label: "body 做什么", value: "描述 UI，而不是处理业务真相") {
        logs.insert("InfoRowView 通过 body 交出了 1 行信息。", at: 0)
      }

      DemoCardView(
        title: "组合 View",
        bodyText: "这个卡片内部又是 Text、Button、VStack 的组合。对外它仍只是 1 个 View。",
        actionTitle: "记录组合 View"
      ) {
        logs.insert("DemoCardView 通过 body 交出了 1 张组合卡片。", at: 0)
      }

      insightCard(
        title: "看点",
        body: "这 3 个类型的字段、布局、样子都不同，但对 SwiftUI 来说，它们都只是在说：我满足 `View` 协议，因为我有 `body`。"
      )
    }
    .padding(18)
    .frame(width: 540, alignment: .topLeading)
    .background(.regularMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }

  // 右边日志区。
  private var logsPanel: some View {
    VStack(alignment: .leading, spacing: 14) {
      Text("右边：把 View protocol 的体感讲白")
        .font(.headline)

      insightCard(
        title: "`struct Xxx: View` 真正在说什么",
        body: "不是“我是某个类的子类”，而是“我承诺自己能提供 1 份界面描述”。这个描述就是 `body`。"
      )

      insightCard(
        title: "为什么 SwiftUI 要这么设计",
        body: "因为 UI 天生适合被拆成很多很小的组件。每个组件只负责返回自己的 `body`，再由更大的 View 去组合它们。"
      )

      Text("交 body 日志")
        .font(.headline)

      ScrollView {
        LazyVStack(alignment: .leading, spacing: 10) {
          ForEach(Array(logs.enumerated()), id: \.offset) { _, line in
            Text(line)
              .font(.system(.body, design: .monospaced))
              .frame(maxWidth: .infinity, alignment: .leading)
              .padding(12)
              .background(Color.primary.opacity(0.04))
              .clipShape(RoundedRectangle(cornerRadius: 10))
          }
        }
      }
      .overlay {
        if logs.isEmpty {
          Text("点左边按钮，看不同小 View 如何各自“交 body”。")
            .foregroundStyle(.secondary)
        }
      }
    }
    .padding(18)
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .background(.regularMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 16))
  }

  // 通用说明卡。
  private func insightCard(title: String, body: String) -> some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(title)
        .font(.headline)

      Text(body)
        .foregroundStyle(.secondary)
    }
    .padding(14)
    .background(Color.primary.opacity(0.04))
    .clipShape(RoundedRectangle(cornerRadius: 12))
  }

  // 顶部小标签。
  private func badge(_ text: String) -> some View {
    Text(text)
      .font(.caption.weight(.medium))
      .padding(.horizontal, 10)
      .padding(.vertical, 6)
      .background(Color.primary.opacity(0.06))
      .clipShape(Capsule())
  }
}

// 这是最小示例 View。
struct TitleBadgeView: View {
  // 注入标题文本。
  let text: String

  // 注入点击回调。
  let onTap: () -> Void

  // 交出这个小组件自己的 body。
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(text)
        .font(.title3.weight(.semibold))

      Button("记录这个最小 View") {
        onTap()
      }
    }
    .padding(16)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color.blue.opacity(0.08))
    .clipShape(RoundedRectangle(cornerRadius: 14))
  }
}

// 这是信息行示例 View。
struct InfoRowView: View {
  // 左侧标签。
  let label: String

  // 右侧内容。
  let value: String

  // 点击回调。
  let onTap: () -> Void

  // 交出这个小组件自己的 body。
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(label)
        .font(.caption)
        .foregroundStyle(.secondary)

      Text(value)
        .font(.body)

      Button("记录这个信息行 View") {
        onTap()
      }
    }
    .padding(16)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color.green.opacity(0.08))
    .clipShape(RoundedRectangle(cornerRadius: 14))
  }
}

// 这是组合型示例 View。
struct DemoCardView: View {
  // 卡片标题。
  let title: String

  // 卡片正文。
  let bodyText: String

  // 按钮文案。
  let actionTitle: String

  // 点击回调。
  let onTap: () -> Void

  // 交出这个组合组件自己的 body。
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title)
        .font(.title3.weight(.semibold))

      Text(bodyText)
        .foregroundStyle(.secondary)

      Button(actionTitle) {
        onTap()
      }
    }
    .padding(16)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background(Color.orange.opacity(0.08))
    .clipShape(RoundedRectangle(cornerRadius: 14))
  }
}
