# terse


### Gallery

`>>-` (flatMap) (left associative)

####Implementations
```swift
public func >>- <A, B>(a: Future<A>, f: @escaping (A) -> Future<B>) -> Future<B> 
```

```swift
public func <^> <A, B>(a: Future<A>, f: @escaping (A) -> B) -> Future<B> {
```
`<^>` (map) (left associative)

```swift
public func >-> <A, B, C>(f: @escaping (A) -> Future<B>, g: @escaping (B) -> Future<C>) -> (A) -> Future<C> {
```
`>->` Forward composition (left associative)




