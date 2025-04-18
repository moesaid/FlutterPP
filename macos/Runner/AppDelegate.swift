import Cocoa
import FlutterMacOS

@main
class AppDelegate: FlutterAppDelegate {
  override func applicationDidBecomeActive(_ notification: Notification) {
      signal(SIGPIPE, SIG_IGN)
  }
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
  override func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
      return true
  }
}
