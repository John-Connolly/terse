# terse


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