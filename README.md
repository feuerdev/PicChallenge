# Piccy (PicChallenge)

An early SwiftUI photo-selection app. Import photos, choose between pairs in a knockout tournament, then share the winner. The app is a prototype from 2021; a current native build and release have not been verified.

This is the uppercase `feuerdev/PicChallenge` repository. The separate lowercase `pic-challenge` repository contains an older UIKit experiment.

## Source layout

- `Piccy/`: app state, picker, staging, comparison and winner screens.
- `PiccyShare/`: image handoff from the iOS share sheet.
- `PiccyTests/` and `PiccyUITests/`: existing test targets; the app unit tests are still template placeholders.
- `PicChallenge.xcworkspace`: opens Piccy and the sibling Feuerlib project.

## Native setup and known blockers

Use macOS with Xcode. Clone [feuerlib](https://github.com/feuerdev/feuerlib) beside this repository so the workspace reference `../feuerlib/Feuerlib.xcodeproj` resolves, then inspect the workspace:

```bash
xcodebuild -list -workspace PicChallenge.xcworkspace
```

Choose an available simulator and scheme from your own Xcode installation before building. Existing signing/app-group settings need to be reviewed for your account; do not commit credentials or personal signing changes.

The workspace also references `Pods/Pods.xcodeproj`, while the Podfile still names older `PicChallenge` targets rather than `Piccy`. Do not assume `pod install` fixes a fresh checkout. First determine whether these stale CocoaPods references can be removed on a Mac and verify the app/share targets together. The current source uses legacy APIs and has no established modern iOS/Xcode compatibility matrix.

Other readiness gaps include stable photo ordering/identifiers, empty/single-image tournaments, image-memory bounds, undo, session restoration, and replacing whole-image UserDefaults storage in the share extension. Original photos must remain untouched.

See [the product plan and technical specification](docs/project-readiness.md) for discovery gates, scope, acceptance criteria and the native validation checklist.
