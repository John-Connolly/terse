
<p align="center">
    <img src="https://user-images.githubusercontent.com/8390081/50832000-2827f080-1323-11e9-8887-a45842aabd9c.png"  alt="SwiftQ">
    <br>
    <br>
    <a href="LICENSE">
        <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
    </a>
    <a href="https://swift.org">
        <img src="http://img.shields.io/badge/swift-4.1-brightgreen.svg" alt="Swift 4.1">
    </a>
</p>

### Gallery


## Implementations

## Monad
`>>-` (flatMap) (left associative)
```swift
public func >>- <A, B>(a: EventLoopFuture<A>, f: @escaping (A) -> EventLoopFuture<B>) -> EventLoopFuture<B> 
```
`-<<` (flatMap) (right associative)
```swift
public func -<< <A, B>(f: @escaping (A) -> EventLoopFuture<B>, a: EventLoopFuture<A>) -> EventLoopFuture<B> 
```

`>=>` Left-to-right Kleisli composition of monads (left associative)

```swift
public func >=> <A, B, C>(f: @escaping (A) -> EventLoopFuture<B>, g: @escaping (B) -> EventLoopFuture<C>) -> (A) -> EventLoopFuture<C> 
```

`<=<` Kleisli composition of monads (right associative)

```swift
public func <=< <A, B, C>(f: @escaping (B) -> EventLoopFuture<C>, g: @escaping (A) -> EventLoopFuture<B>) -> (A) -> EventLoopFuture<C> 
```

## Functor
`<^>` (map) (left associative)
```swift
public func <^> <A, B>(a: EventLoopFuture<A>, f: @escaping (A) -> B) -> EventLoopFuture<B> 
```

## Applicative
`<*>` Applicative
```swift
public func <*> <A, B>(f: EventLoopFuture<((A) -> B)>, a: EventLoopFuture<A>) -> EventLoopFuture<B> 
```

### Usage

```swift

func get(with client: RedisClient, for data: RedisData) -> Future<RedisData> {
        return client.command("GET", [data])
}

private func terse(_ req: Request) throws -> Future<RedisResponse> {
        let client = try req.make(RedisClient.self)
        return get(with: client, for: "KEY")
            >>-  curry(get)(client)
            >>-  curry(get)(client)
            >>-  curry(get)(client)
            <^> RedisResponse.init
}

``` 

vs

```swift

 private func nested(_ req: Request) throws -> Future<RedisResponse> {
        let client = try req.make(RedisClient.self)
        return client.command("GET", ["key"]).flatMap(to: RedisResponse.self) { data in
            return client.command("GET", [data]).flatMap(to: RedisResponse.self) { data in
                return client.command("GET", [data]).map(to: RedisResponse.self) { data in
                    return RedisResponse(data)
                }
            }
        }
    }

```


### Kleisli composition of monads
`>=>` is a monadic version of function composition.

```swift

func query(with: String) -> EventLoopFuture<Int> {
    return EventLoopFuture(2)
}

func updateCache(with id: Int) -> EventLoopFuture<String> {
    return EventLoopFuture("Success")
}

let queryAndUpdate = query >=> updateCache

```

### Applicative
Applies a future function to a future value

### Curry
Currying is the technique of translating the evaluation of a function that takes multiple arguments into evaluating a sequence of functions, each with a single argument.

```swift 
 let renderer: (String, Encodable) -> Future<View> = try req.make(LeafRenderer.self).render
 
 curry(renderer) //(String) -> (Encodable) -> Future<View>
 overview >>- curry(renderer)("overview")
```
This is useful for using the operators with non unary functions. 

## SwiftPM
```
.package(url: "https://github.com/John-Connolly/terse.git", from: "1.0.0")
```

