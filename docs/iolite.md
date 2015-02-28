# iotelite

## これは何？

式を遅延評価するためのライブラリです。
ブロックで行う処理を抽象化し、コードを簡略化することを目的としています。  
ちなみにライブラリ名である iolite（アイオライト）は菫青石から取っています。

## イントロダクション

さて、Ruby ではブロック付きメソッド呼び出しを行うことが多いです。

```ruby
["homu", "mami", "mado"].map { |it| it.capitalize }
# => ["Homu", "Mami", "Mado"]
```

しかし、上記のようにブロックを使用すると it を2回書く必要が出てきてちょっと手間ですね。  
これは 以下のように Symbol#to_proc を利用するように書き換える事が可能です。

```ruby
["homu", "mami", "mado"].map &:capitalize
# => ["Homu", "Mami", "Mado"]
```

これでブロックを記述することなく map を使用する事ができました。  
では、次のようなコードはどうでしょうか。

```ruby
["homu", "mami", "mado"].select{ |it| it =~ /^m/ }
# => ["mami", "mado"]

[{ name: "homu" }, { name: "mami" }, { name: "mado" }].map { |it| it[:name] }
# => ["homu", "mami", "mado"]
```

上記のように呼び出したいメソッドに対して引数を渡したい場合はどうしてもブロックで記述する必要が出てきます。  
このような場合に iolite を使用することですっきりとした記述をすることができます。


```ruby
# Use iolite
["homu", "mami", "mado"].select &arg1 =~ /^m/
# => ["mami", "mado"]

[{ name: "homu" }, { name: "mami" }, { name: "mado" }].map &arg1[:name]
# => ["homu", "mami", "mado"]
```


## Iolite::Lazy (class)

Iolite::Lazy は遅延評価を行うためのオブジェクトです。

```ruby
f = Iolite::Lazy.new { |a, b| a + b }
p f.call(1, 2)
# => 10
```

これは次のようにメソッド呼び出しを遅延評価する事ができます。

```ruby
twice = Iolite::Lazy.new { |a| a + a }
twice.call(2)
# => 4

twice_plus3 = (twice + 3)
twice_plus3.call(1) # to twice.call(1) + 3
# => 5

length_ = twice.length
length_.call("homu") # to twice.call("homu").length
# => 8
length_.call("an") # to twice.call("mami").length
# => 4
```

#### Iolite::Lazy#call(*args)

初期化時に渡したブロックを評価します。


#### Iolite::Lazy#send(name, *args)

name という名前のメソッドを遅延評価します。  
遅延評価した結果に対して `#send(name, *args)` を呼び出す Iolite::Lazy を返します。

```ruby
it = Iolite::Lazy.new { |it| it }
it.send(:length).call("homu") # to { |it| it }.call("homu").length
```

#### Iolite::Lazy#method_missing(name, *args)

`Iolite::Lazy#send(name, *args)` を返します。  
Iolite::Lazy で定義されていないメソッドであれば `#send` を使用することなくメソッドを遅延評価することができます。


#### Iolite::Lazy で定義されているメソッド名を遅延評価する

Iolite::Lazy (Object クラス) のメソッド名で遅延評価したい場合は `#send` または `_{呼び出したいメソッド名}` で遅延評価を定義する事ができます。

```
Iolite::Lazy.new{}.class
# => Iolite::Lazy

# Object のメソッドを呼び出したい場合は #send を介して呼び出す
to_s_ = Iolite::Lazy.new { |a| a }.send(:to_s)
to_s_.call(42)
# => "42"
to_s_.call(:homu)
# => "homu"

# _ を着けて呼び出すことも可能
class_ = Iolite::Lazy.new { |a| a }._class
class_.call(10)
# => Fixnum
class_.call("homu")
# => String
```

#### Iolite::Lazy#to_proc

`#call` を呼び出す Proc を返します。  
これにより & を着けてブロックに渡すことができます。

```ruby
it = Iolite::Lazy.new { |it| it }
["homu", "mami", "mado"].map &it.capitalize
# => ["Homu", "Mami", "Mado"]

["homu", "mami", "mado"].select &it =~ /^m/
# => ["mami", "mado"]
```


## プレースホルダ

プレースホルダは任意の引数値に対して遅延評価を行うために使用します。  
プレースホルダは arg1 〜 arg10 まで定義されており、argN 番目の引数に対応します。  
これは module Iolite::Placeholders で定義されています。

```ruby
include Iolite::Placeholders

arg1.call(1, 2)
# => 1

arg2.call(1, 2)
# => 1
```

このプレースホルダは Iolite::Lazy オブジェクトなので Iolite::Lazy と同様に遅延評価を行うことができます。


```ruby
include Iolite::Placeholders

(arg1 + arg2).call(1, 2)
# => 3

arg1._to_s.length.call(:homu)
# => 4

["homu", "mami", "mado"].select(&arg1 =~ /^m/).map &arg1.capitalize
# => ["Mami", "Mado"]

(1..5).map &arg1._to_s(2)
# => ["1", "10", "11", "100", "101"]

[:homu, :mami, :an].select &arg1._to_s.length > 3
# => [:homu, :mami]
```

## Object#to_lazy

`Object#to_lazy` は自身を遅延評価するオブジェクト（Iolite::Lazy オブジェクト）として返すメソッドです。

```ruby
```


`Object#to_lazy` を使用したい場合は refinements が使える環境であれば、

```ruby
using Iolite::Refinements::ObjectWithToLazy
```

refinements が使えない、もしくは直接 Object を拡張したい場合は

```ruby
require "iolite/adaptored/object_with_to_lazy"
```

することで利用することができます。


#### Example

```
# (1..Float::INFINITY) を遅延評価する
lazy_list = (1..Float::INFINITY).to_lazy
twice_list = lazy_list.first(arg1).map(&arg1 * 2)

p twice_list.call(5)
# => [2, 4, 6, 8, 10]
p twice_list.call(10)
# => [2, 4, 6, 8, 10, 12, 14, 16, 18, 20]

["homu", "mami", "mado"].each &to_lazy.printf("%s:%s, ", arg1, arg1)
# => homu:homu, mami:mami, mado:mado,
```



