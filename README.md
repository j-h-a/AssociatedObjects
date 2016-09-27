
# AssociatedObjects

Works, but experimental.

Associate objects and values with any instance of any class.
The associated objects/values automatically go away after the instance
is deinited (but see issues below).

Issues:

 * Associated objects stay alive unless internal clean-up is performed, although
   this does happen automatically whenever the `associate(value:withKey:)` and
   `associatedValue(forKey:)` methods are called. So as long as the interface is
   being used regularly (on any instance), it's ok.
 * No attempt whatsoever to make it thread safe yet,
   recommend only using from main thread for now.

### Using

Import the framework:

``` swift
import AssociatedObjects
```

Any classes you want to use this feature on need to be made `Associable`:

``` swift
extension SomeClass: Associable {}
```

Then just call the methods defined in the `Associable` protocol:

``` swift

someClassInstance.associate(value: 7, withKey: "anInt")
someClassInstance.associate(value: anyObjectInstance, withKey: "anObject")

// Later...

let theInt = someClassInstance.associatedValue(forKey: "anInt") as? Int
let theObject = someClassInstance.associatedValue(forKey: "anObject") as? AnyObject

```
