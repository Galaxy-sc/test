// Run with:
//   frida -H <device-ip-or-127.0.0.1>:27042 -l scripts/test-hook.js
//
// Since the Gadget config sets "code_signing": "required", the app runs
// standalone (no debugger attached) and Interceptor.attach() cannot JIT
// new trampolines. ObjC.implement() replaces the method's IMP pointer
// directly (Objective-C swizzling), which is a data-level change and
// still works. This mirrors the workaround confirmed in the frida/frida
// GitHub issue #3650.

if (!ObjC.available) {
  console.log('[-] Objective-C runtime is not available.');
} else {
  var TestHookTarget = ObjC.classes.TestHookTarget;
  var method = TestHookTarget['+ secretValue'];

  method.implementation = ObjC.implement(method, function () {
    console.log('[*] secretValue() was called - hook fired!');
    return ObjC.classes.NSString.stringWithString_('hooked-by-frida');
  });

  console.log('[+] Hook installed on +[TestHookTarget secretValue].');
  console.log('[+] Now tap "Check secretValue()" in the app.');
  console.log('[+] It should now show: secretValue() = hooked-by-frida');
}
