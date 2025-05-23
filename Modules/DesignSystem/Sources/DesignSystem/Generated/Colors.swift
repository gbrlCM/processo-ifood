// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit.NSColor
  public typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  public typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
public struct Colors: Sendable {
  public let rgbaValue: UInt32
  public var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff0b55"></span>
  /// Alpha: 100% <br/> (0xff0b55ff)
  public static let accent = Colors(rgbaValue: 0xff0b55ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffdede"></span>
  /// Alpha: 100% <br/> (0xffdedeff)
  public static let background = Colors(rgbaValue: 0xffdedeff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fefefe"></span>
  /// Alpha: 100% <br/> (0xfefefeff)
  public static let cellBackground = Colors(rgbaValue: 0xfefefeff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#cf0f47"></span>
  /// Alpha: 100% <br/> (0xcf0f47ff)
  public static let secondaryAccent = Colors(rgbaValue: 0xcf0f47ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2e5077"></span>
  /// Alpha: 100% <br/> (0x2e5077ff)
  public static let secondaryText = Colors(rgbaValue: 0x2e5077ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#212121"></span>
  /// Alpha: 100% <br/> (0x212121ff)
  public static let text = Colors(rgbaValue: 0x212121ff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let components = RGBAComponents(rgbaValue: rgbaValue).normalized
    self.init(red: components[0], green: components[1], blue: components[2], alpha: components[3])
  }
}

private struct RGBAComponents {
  let rgbaValue: UInt32

  private var shifts: [UInt32] {
    [
      rgbaValue >> 24, // red
      rgbaValue >> 16, // green
      rgbaValue >> 8,  // blue
      rgbaValue        // alpha
    ]
  }

  private var components: [CGFloat] {
    shifts.map { CGFloat($0 & 0xff) }
  }

  var normalized: [CGFloat] {
    components.map { $0 / 255.0 }
  }
}

public extension Color {
  convenience init(named color: Colors) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
