# RunInSync

Run `async/await` code in sync.
* Just for fun, not be seriously tested. *

```swift
RunInSync {
    do {
        try await Task.sleep(nanoseconds: 2 * NSEC_PER_SEC)
        print("1")
    } catch {
        print(error)
    }
}
```
