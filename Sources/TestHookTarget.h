#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// A trivial Objective-C class whose method we hook from Frida
// to confirm the Gadget connected and can modify app behavior.
@interface TestHookTarget : NSObject

+ (NSString *)secretValue;

@end

NS_ASSUME_NONNULL_END
