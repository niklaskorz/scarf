**Scarf** is a non-blocking web server for Objective-C, supporting both OS X and iOS.

**Dependencies:**

- Grand Central Dispatch (OS X 10.6 or newer, iOS 4.0 or newer)
- New Objective-C literals (Clang 4.0 or newer)
- [CocoaAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket)

License
-------
**Scarf** uses the MIT license. See `LICENSE` for more information.

Usage
-----
You might have noticed that **Scarf** doesn't have any Xcode project files. Instead, you're encouraged to use [CocoaPods](https://github.com/CocoaPods/CocoaPods). Though you're free to copy the source files directly into your project (but keep in mind that you'll also need to add [CocoaAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket) yourself in this case).
See the [wiki](https://github.com/dindresto/scarf/wiki) for examples and documentation.

###With CocoaPods
In this case, you'll just need a Podfile in your project (see the [CocoaPods wiki](https://github.com/CocoaPods/CocoaPods/wiki) for more information) with **Scarf** as a dependency:

	pod 'Scarf', :git => 'https://github.com/dindresto/scarf.git'

###Without CocoaPods
Make sure that you also add [CocoaAsyncSocket](https://github.com/robbiehanson/CocoaAsyncSocket) to your project. **Scarf** assumes that the CocoaAsyncSocket directory is in your header search path, so it can import GCDAsyncSocket:

	#import <CocoaAsyncSocket/GCDAsyncSocket.h>

So if you want to place it somewhere else, just make sure you change the import directives.

Projects using Scarf
--------------------
For now, this list is empty. Anyway, it would be nice of you to contact me if you use **Scarf** in one of your projects.

Other platforms
--------------------------
It may be possible to use **Scarf** on other platforms. Grand Central Dispatch is also available on [FreeBSD](http://wiki.freebsd.org/GCD "Grand Central Dispatch (GCD) on FreeBSD") and Linux ([Debian](http://packages.debian.org/sid/libdispatch0 "user space implementation of the Grand Central Dispatch API"), [source](http://libdispatch.macosforge.org/)), and you're free to port libdispatch to your favorite system, since it's [open source](http://libdispatch.macosforge.org/).
Aside of that, you'll also need a port of the [Foundation Framework](http://developer.apple.com/library/mac/#documentation/cocoa/reference/foundation/ObjC_classic/_index.html "Foundation Framework Reference"), like [GNUStep](http://www.gnustep.org/), and a compiler with support for the new Objective-C literals (Clang 4.0 or newer).