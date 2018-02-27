
<p align="center">
    <img src="https://user-images.githubusercontent.com/8390081/36566527-2374fe40-17fa-11e8-9cad-e4336fedf5f5.png"  alt="SwiftQ">
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


#### Implementations

`>>-` (flatMap) (left associative)
```swift
public func >>- <A, B>(a: Future<A>, f: @escaping (A) -> Future<B>) -> Future<B> 
```

`<^>` (map) (left associative)
```swift
public func <^> <A, B>(a: Future<A>, f: @escaping (A) -> B) -> Future<B> {
```

`>->` Forward composition (left associative)

```swift
public func >-> <A, B, C>(f: @escaping (A) -> Future<B>, g: @escaping (B) -> Future<C>) -> (A) -> Future<C> {
```

`<*>` Applicative (left associative)
```swift
public func <*> <A, B>(f: Future<((A) -> B)>, a: Future<A>) -> Future<B> {
```

### Usage
The goal when creating these operators was to try and prevent heavily nested functions in vapor 3. Here are some strategies to try and avoid that.

The example bellow is a really silly and is an extreme example of nesting however it demonstrates terse very well.

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


### Forward composition
`>->` is a monadic version of forward composition.  This is a very powerful operator that allows you to create entirely new functions from composition.

```swift

func query(with: String) -> Future<Int> {
    return Future(2)
}

func updateCache(with id: Int) -> Future<String> {
    return Future("Success")
}

let queryAndUpdate = query >-> updateCache

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
This is really useful for using the operators with non unary functions. 

