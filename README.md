# Debouncer

*A simple debouncing utility class in Swift.*

Debouncing any arbitrary block of code means making sure it is not executed too frequently. This is especially useful in UI development where, for example, we may want to delay a network request if the user is still typing her search query.

This can be accomplished rather easily with a debouncer utility:

```
class Debouncer {

  private var pendingWorkItem: DispatchWorkItem?

  func debounce(for timeInterval: TimeInterval, on queue: DispatchQueue = .main, block: @escaping () -> Void) {
    pendingWorkItem?.cancel()

    let workItem = DispatchWorkItem(block: block)
    pendingWorkItem = workItem

    let deadline = DispatchTime.now() + timeInterval

    queue.asyncAfter(deadline: deadline, execute: workItem)
  }

}
```

The `debounce(for:on:block)` method accepts a time interval in seconds, a dispatch queue where the code block should be executed (defaulting to the main queue) and finally, the block of code to execute.

## Usage

**Instantiate the debouncer and keep a reference to it**

```
private let debouncer = Debouncer()
```
Obs: Separate debouncers should be used for separate requests (e.g. one debouncer for typing in a search bar and another for a button press).

**Call the debounce method**

```
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
  debouncer.debounce(for: 0.5) {
    print("\(searchText)")
  }
}
```

