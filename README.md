# Frida Gadget iOS 26 test app

A minimal iOS app that embeds `FridaGadget.dylib` so you can confirm you
can actually attach to it on **iPhone 15 Plus / iOS 26.5**, given the
[frida/frida#3650](https://github.com/frida/frida/issues/3650) crash issue.

## Why it's built this way

The linked issue shows that on iOS ≥ 26, embedding the Gadget the classic
way (and letting a debugger/LLDB attach) crashes with `EXC_BREAKPOINT`,
because Apple made it harder to JIT code with a debugger attached.
`oleavr`'s fix, confirmed by other users in the thread, is:

- Set `"code_signing": "required"` in `FridaGadget.config` → the app runs
  **without** a debugger attached, so it doesn't crash.
- The trade-off: `Interceptor.attach()` needs to JIT a trampoline, which
  is no longer allowed. Full `Interceptor` support would require running
  `gum-graft` on the target binary first.
- Pointer-level tricks (Objective-C swizzling via `ObjC.implement`) still
  work, since they don't need to JIT new executable memory. That's what
  `scripts/test-hook.js` uses to prove the connection works end-to-end.

`on_load: "wait"` is also set, so the app will pause at launch until a
Frida client connects — that itself is a clear signal the Gadget loaded
and is listening correctly.

## Project layout

```
project.yml                    XcodeGen spec (generates the .xcodeproj)
Sources/                       Swift + a tiny ObjC class to hook
FridaGadget/FridaGadget.config Gadget config (dylib itself is downloaded in CI)
scripts/test-hook.js           Frida script used to verify the hook
.github/workflows/build-ipa.yml GitHub Actions workflow
```

## 1. Build the IPA (GitHub Actions)

Push this repo to GitHub, then run the "Build Frida test IPA" workflow
manually (Actions tab → Run workflow). It will:

1. Download the latest `frida-gadget-*-ios-universal.dylib.xz` from the
   Frida releases page.
2. Generate the Xcode project with XcodeGen.
3. Build an **unsigned** `.app` for a real device (`-sdk iphoneos`).
4. Zip it into `FridaTest.ipa` and upload it as a build artifact.

It's built unsigned on purpose — no certificates/provisioning profiles
are needed in CI. Signing happens on your own machine at install time
(step 2), and free sideloading tools re-sign every embedded binary,
including the Gadget dylib.

> If your Apple Developer account is paid and you'd rather have CI sign
> and export a ready-to-install ad-hoc IPA directly, that's also
> possible — you'd add your `.p12` certificate and `.mobileprovision`
> as GitHub Actions secrets and switch the build/export steps to a
> signed `xcodebuild archive` + `-exportArchive`. Say the word if you
> want that version instead.

## 2. Install it on your iPhone 15 Plus (iOS 26.5)

Download the `FridaTest-ipa` artifact from the finished workflow run,
then install it with a free sideloading tool, e.g.:

- **Sideloadly** (Windows/macOS) — drag the IPA in, sign in with any
  Apple ID, install to the device over USB.
- **AltStore / SideStore** — similar flow, works over Wi-Fi after
  initial pairing.

Trust the developer certificate on the phone afterward: **Settings →
General → VPN & Device Management**.

## 3. Connect with Frida

On your computer:

```bash
pip install frida-tools
```

Launch the app on the phone. Because `on_load` is `"wait"`, it will sit
there until Frida connects — that's expected.

**Same Wi-Fi network:**

```bash
frida -H <iPhone-IP-address>:27042 -l scripts/test-hook.js
```

**Over USB instead (no Wi-Fi needed):**

```bash
pip install pymobiledevice3   # provides iproxy-equivalent tooling
python3 -m pymobiledevice3 usbmux forward 27042 27042 &
frida -H 127.0.0.1:27042 -l scripts/test-hook.js
```

You should see:

```
[+] Hook installed on +[TestHookTarget secretValue].
```

The app's UI will un-pause. Tap **"Check secretValue()"** — it should
now show:

```
secretValue() = hooked-by-frida
```

That confirms: the Gadget loaded on iOS 26.5 without crashing, Frida
connected to it, and a live hook took effect.

## If you need full `Interceptor.attach()` (not just swizzling)

Per the issue thread, run `gum-graft` on the compiled binary and tell it
which functions to instrument, so tracepoints are baked in ahead of
time. That's a separate step on the built `.app`'s executable before
packaging — happy to add it if you get to that point.
