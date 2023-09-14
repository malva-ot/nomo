# Nomo: Schemas

version `0.18.0` • 2023-09-14

## 1. Introduction

Nomo is a standard for constructing identifiers that are unique, semantic, and mechanically easy to process. Nomo describes identifiers that are not bound to any institutional or mechanical infrastructure, nor to any central authority. Its purpose is to facilitate systematic cooperation and distributed recordkeeping by providing a stable framework for producing and consuming identifiers that are mutually intelligible and stable across many cultures and contexts, over arbitrarily short or long time spans.

For an extended introduction to the Nomo standard, see [Nomo: Introduction](./nomo-intro.md).

### 1.1 Scope

[Nomo: Identifier Structures](./nomo-id-structures.md) defines the abstract primitives from which any Nomo identifier can be constructed and compared. Most practical uses of identifiers require two additional concepts: **serialization** and **validation**. A set of associated serialization and/or validation rules is called a **schema**.

This specification document formally defines a set of concepts which describe how identifier structures may be validated, and may be mapped to or from serialized strings.

### 1.2 Limitations

This specification specifically and only describes schemas that transform identifier structures into one-dimensional [strings](./nomo-id-structures.md#3-string). There is an infinite range of other ways that the abstract Nomo [identifier structures](./nomo-id-structures.md#5-value) could be digitally or physically stored or transmitted. The Nomo standard as a whole makes no attempt to describe any approach besides the one presented in general in this specification and in concrete in the [Common Schema](./nomo-common-schema.md).
 
## 2. Identifier-strings

The foundational concept of Nomo schemas is the identifier-string. An identifier-string **is** a string that meets that same definition as in [Identifier Structures](./nomo-id-structures.md#3-string): it is a sequence of glyphs selected from a defined glyph set. 

There are several critical differences in usage: 

 - identifier-strings are never assembled into larger structures. The only stored and transmitted structure is a string. 
 - identifier-strings are explicitly understood to be **encodings** of other underlying identifier structures. In addition to the possibility of a mapping to a different glyph set, an identifier-string will generally contain delimiter and annotation glyphs that denote structure rather the content. 
 - identifier-strings intentionally allow ambiguity, in that a single underlying identifier structure may be encoded as any number of different identifier-string sequences. 

### 2.1 Identifier-string types

Nomo defines the following serialized string types, all of which include any delimiters or other annotation glyphs as required to describe the underlying identifier structure which the string encodes. A string of any of these types can be called an **identifier-string**:

  - **encoded-string** - A bare [**string**](./nomo-id-structures.md#3-string) value encoded and escaped as necessary
  - **name-string** - A [**name**](./nomo-id-structures.md#4-name) encoded as a single string
  - **tuple-string** - A [**tuple**](./nomo-id-structures.md#6-tuple) value encoded as a single string
  - **map-string** - A [**map**](./nomo-id-structures.md#7-map) value encoded as a single string
  - **qrn-string** - A [**QRN**](./nomo-id-structures.md#10-qualified-resource-name) encoded as a single string
  - **null-string** - A placeholder string which explicitly indicates a [null value](./nomo-id-structures.md#8-null)
  - **reference-string** - A [**reference**](./nomo-id-structures.md#9-reference) value encoded as a single string

### 2.2 name-string and tuple-string

Readers may note that here that a Nomo schema distinguishes between the serialization of a name and of a tuple in general, even though the underlying [Identifier Structures](./nomo-id-structures.md) specification simply considers a name to be a tuple for all comparison and evaluation purposes. 

This is an example of the intentional ambiguity offered by a schema, which allows for flexibility and clarity when encoding identifiers. 

For illustration, the following [Common Schema](./nomo-common-schema.md) identifier-strings are all valid representations of the three-segment tuple / name [ `www`, `example`, `com` ]:

```
www.example.com
'www'.'example'.com
(www,example,com)
('www',example,'com')
```

The first two representations are common schema name-strings, while the third and fourth representations are common schema tuple-strings. All four values encode the same underlying identifier structure, which is a name, and is therefore also a tuple.

In the context of a QRN, however, the deterministic encode and decode algorithms of the common schema enforce that the name-string form is always used for the set name, group name, or element name parts of a QRN, while the tuple-string form is always used within the encoding of a set key or element key. 

The distinction is purely aesthetic, but is intended to help humans understand the intent and structure of an encoded QRN.

### 2.3 Identifier-string equivalence

The rules defined in [Identifier Structures: String](./nomo-id-structures.md#33-comparison) strictly define whether two strings are considered the **same**, and these rules apply to identifier-strings as well.

However, this specification defines one additional boolean comparison operator `equivalent` that can be applied to two identifier-strings.

Specifically, two identifier-string values are `equivalent` if and only if:

  - Both identifier-strings can be decoded to an identifier structure and validated according to their respective schemas
  - Applying the primitive `same` operator to the respective decoded identifier structures evaluates to true

identifier-strings that are equivalent but not the same are valid and allowed, as described further under [5.2 Schema Operations](#52-schema-operations). Mechanisms such as *escape sequences* or allowance of non-significant whitespace included in valid schemas allow many distinct identifier-strings to deterministically decode to the same underlying identifier.

This use of the term "equivalent" is an intentional additional application of the word beyond its use in the identifier structures specification, where it is used only to describe the mapping between individual glyphs in two compatible glyph sets.

### 2.4 Identifier-string support

Any valid schema must be able to represent name-strings and qrn-strings. 

Schemas that allow tuple values must be able to represent tuple-strings, and likewise schemas that allow map values must be able to represent map-strings. 

#### 2.4.1 null-strings

No schema is required to represent non-empty null-strings, if other delimiters or punctuation unambiguously encode where null values would be. For example, the common schema tuple-string `(,,)` unambiguously encodes a tuple with three null values, even though the actual null values are not represented by any glyphs at all. Instead, the tuple is encoded entirely by delimiting characters. 

Instead, null-strings are defined here as a valid concept that schema designers may choose to use if desired, where a non-empty sequence of glyphs in a tuple-string or map-string is used to explicitly note a null value. Imagine for example a schema that requires all string values to be delimited with single quotes, and then also allows the literal glyph sequence `null` to denote a null value. The same tuple of three null values could be encoded even without surrounding parentheses as `null,null,null`. And this would be unambiguously different from the encoding of a sequence of three string values where the actual contents of each string are the literal characters n-u-l-l: `'null','null','null'`.


## 3. Schema Definition

A **schema** is composed of the following:

- An **identifier glyph set**: The glyph set used for identifiers
- An **encoding glyph set**: The glyph set used for [identifier-strings](#2-identifier-strings)
- An **encode algorithm**  
- A **decode algorithm**  
- An *optional* **validate algorithm**

### 3.1 Glyph sets

#### 3.1.1 Compatibility

There is no requirement that the identifier glyph set and encoding glyph set for a schema be compatible with each other; they need not even be defined in the same medium.

Even for the usual case where both glyph sets are defined in the same medium and where there is partial compatibility (some glyph types in the identifier set are the same or equivalent to some glyph types in the encoding set), it is likely that the identifier glyph set will include glyph types that are not allowed in the encoding glyph set, and likewise that the encoding glyph set may include delimiting glyph types that are not included in the identifier glyph set.

Glyph types that are allowed only in the identifier set or which have special meaning in an identifier-string are generally decomposed or escaped to multiple glyphs in the resulting identifier-string, while delimiters in an identifier-string are always eliminated completely in translation to a structured identifier. Insignificant whitespace glyphs in an identifier-string would also be eliminated during decoding.

### 3.2 Algorithms

The three schema algorithms are described further below in [Schema Operations](#4-schema-operations).

#### 3.2.1 Default validate algorithm

If a schema includes no explicit **validate algorithm**, then all possible identifiers composed from the identifier glyph set are valid. Common schema validation rules might prohibit empty values or certain subsequences of otherwise allowed glyphs, or might require that certain parts of a QRN be either defined or undefined. Regardless, a validate algorithm must be deterministic and based solely on the input identifier.

## 4. Schema Operations

Nomo defines three schema operations:

  - **encode** - A deterministic algorithm that maps an identifier structure to a representation as a single identifier-string
  - **decode** - A deterministic algorithm that maps an identifier-string to the one structured identifier it represents
  - **validate** - A deterministic algorithm that can take any identifier structure and determine whether it is valid or invalid according to some internal rule set

### 4.1 Parameters

#### 4.1.1 Encoding Parameters

The encode operation may include parameters that affect how an identifier is mapped to an identifier-string. Examples could include parameters determining how aggressively escaping or delimiting is applied, or whether non-significant whitespace is included in the output. 

If an encode algorithm does support parameters, all the following requirements must be met:

- All parameters defined must have a default value, so that the default behavior of `encode` is fully defined. 
- All possible combinations of valid parameters must produce identifier-strings that decode back to the same input identifier. 
- All possible combinations of valid parameters must be deterministic: the same input identifier plus the same parameters must always produce the same identifier-string.

#### 4.1.2 Decoding Parameters

The decode algorithm itself does not allow outside parameters. However, this does not prevent the inclusion of glyphs in an identifier-string itself that function as control features which determine how all or part of the identifier-string is interpreted during decoding. Imagine for example a schema that allows identifier-strings to begin with the sequence `L:`, which is omitted from the resulting identifier but which causes all glyphs in the source identifier-string to be decoded as the lower-case equivalent of the source glyph.

#### 4.1.3 Validation Parameters

The validate algorithms may not define parameters.

### 4.2 Identifier-string validity

Nomo does not define a schema operation for testing the validity of an *identifier-string* directly, as this is a redundant. Any identifier-string is valid if it can be unambiguously decoded to an identifier, and the resulting identifier is valid according to the validate algorithm of the schema.

An identifier-string may be rejected as *syntactically* invalid if its sequence of glyphs cannot be interpreted according to the decode algorithm.

### 4.3 Determinism

To reiterate, all three schema operations must be deterministic. 

-  The encode operation allows parameters, therefore its output must depend solely on the combination of the parameters and input identifier.
 - The decode operations does not allow parameters but takes an identifier-string as input, therefore its output depends solely on the input identifier-string.
 - The validate operation does not allow parameters and takes an identifier as input, therefore its output depends solely on the input identifier.

#### 4.3.1 Round Trip Stability

It follows from the descriptions above that, for any valid schema, all round-trips of the following are stable:

```
identifier -[encode]-> identifier-string -[decode]-> identifier
```
   
That is, the starting and ending identifier are the same. Likewise a schema itself is valid only if round-trip stability is satisfied for all possible and valid identifiers. This relation is true regardless of any parameters defined or specified for the encode step.

However, even for a valid schema, **not** all round-trips of the following are stable:

```
identifier-string -[decode]-> identifier -[encode]-> identifier-string
```

The starting and ending identifier-strings are guaranteed to be **equivalent**, but they might not be equal.

### 4.3.2 Glyph ordering and map-strings

Several requirements in the Nomo standard present a potential contradiction:

 - [Nomo: Identifier Structures](./nomo-id-structures.md) explicitly [prohibits](./nomo-id-structures.md#24-collation-and-comparison) defining any properties on or between glyph types such as ordering, collation, etc. 
 - The key-value pairs of a [map](./nomo-id-structures.md#7-map) are explicitly unordered
 - The algorithm of any [encode operation](#4-schema-operations) must be deterministic

The challenge here is that a naive encode operation that simply decorated an input identifier with delimiters and possible escape sequences would have no way of determining which order to encode the key-value pairs of a input map into an output map-string, and would therefore fail the requirement that encoding be deterministic.

It follows that all valid schemas provide one of the following two features:

 - The validate operation is defined and prohibits maps with more than one key-value pair
 - The encode operation includes some *string* ordering mechanism, either embedded in the algorithm or provided as a parameter

The [common schema](#6-common-schema), for example, uses Unicode for both its identifier and encoding glyph sets. To address key ordering during encoding, the common schema relies on the unique integer value assigned to each code point in Unicode and then on the intrinsic ordering of integers to sort the keys in an input map, using traditional character-by-character comparison to yield an overall sorting of two input strings.

This is not a violation of the prohibition on primitive glyph type properties. It is instead simply an implementation detail of the encode operation of the schema. Assigning an arbitrary unique integer in this manner to each glyph type in an identifier glyph set is one generic strategy for string ordering. Any number of other algorithms could also be constructed and would all be valid provided their output is deterministic. 

Regardless, these mechanics are conceptually implementation details of encode operations rather than intrinsic properties of the glyph types themselves. Since the only requirement is to deterministically sort the *keys* of a map, which are entire strings, it is not even required that the algorithm have a predictable ordering based on glyph-by-glyph comparison. Some imaginary ordering algorithm that always sorts `arrow` before `zoo` but also `zoo` before `apple` is perfectly valid as long is it always yields the same outcome.

It remains meaningless within Nomo to ask whether one identifier or even identifier-string "comes before" another.

### 4.3.3 Constructed Equivalent identifier-strings

The strict requirement that encode operations be deterministic does not prevent parties from manually assembling valid equivalent identifier-strings, such as by merely changing the order of the encoded key-value pairs of a map. All the above relations and constraints described in this specification continue to hold:

Given a map with *n* key-value pairs, and the *n!* possible orderings (permutations) of its key-value pairs in an encoded map-string

 - Any of the *n!* encodings will decode back to the same map, because the definition of ["same" for a map](./nomo-id-structures.md#73-comparison) is defined without respect to key-value ordering
 - Applying the encode operation to the map will always produce the same one of the *n!* possible valid map-strings
 - The ordering mechanics used in the encode operation are not visible outside the algorithm

That is, the observable behaviors are still limited to those allowed:

 - Each distinct encoding can be determined to be equivalent to all other encodings, while also not the same as any of the other encodings (equivalence can be tested)
 - The map-string produced by one application of the encode operation can be determined to be the same as the map-string produced by any other application of the encode operation (determinism can be verified)
 - It is undefined which encoding is "first" or "next", and unknown *how* the encode operation selects the same output map-string each time (no glyph type properties are defined)

In summary, a deterministic *string* ordering algorithm is required to implement a valid deterministic encode operation that accepts maps with more than one key-value pair, and yet this does not pollute the concept space by introducing glyph ordering.
 
### 5. Bound Identifiers

As described in [Identifier Structures](./nomo-id-structures.md), QRNs may contain an optional [schema annotation](./nomo-id-structures.md#101-schema). If present, this annotation must be faithfully encoded to a qrn-string, and decoded from a qrn-string back into a QRN. 

#### 5.1 Schema Embedding

Note that allowing one schema to define how to encode the fact that some QRN is actually bound to yet another schema is not necessarily a contradiction. It is intended that authors use the underlying mechanics of the common schema to build their own more restrictive schemas. Those more restrictive schemas will mostly add validation rules with in turn constrain the possible identifiers, while the substance of the encode and decode algorithms from the underlying common schema are fully preserved.

In these cases, *any* valid derived schema will produce qrn-strings that are valid and parsable by the underling common schema rules. If the source qrn-string includes a schema name prefix, then the human or computer reading the qrn-string will be aware that there may also be additional validation rules, or interpretive context, which can be applied to the otherwise raw decoded QRN.

As an example, would could define a schema that maps the parts of a generic QRN to any valid internet URL. The set name corresponds to the domain, with the set key used to specify an optional port and/or protocol. The group name represents all parts of the path that are followed by a slash. The element name represents the final part of the path if there is no trailing slash, and the element key can be used to encode URL parameters and/or a URL fragment. We could further define this schema such that the authority is optional, but if present must be `iana`, reflecting the fact that the IANA has the sole power to allocate the domain names that are the root of any internet URL:

```
url<iana/github.com[443]::malva-ot.nomo.blob.spec.main:common-schema.ebnf[#L49]>
```

In the above example, the schema denoted by the prefix `url` is a more-restrictive subset of the common schema. As a result, any conformant implementation of the common schema can successfully decode the full QRN. The schema prefix `url` is decoded either as a plain string or as a reference value and is assigned to the schema annotation of the full decoded QRN. That annotation can then be used in context to identify the more-restrictive schema and, if it is recognized, to apply the validate algorithm to determine if the decoded QRN is in fact valid under that more restrictive schema.

## 6. Semantic Standards

It is intended and expected that cooperating parties will find it useful to agree on standard *semantics* to require for certain situations. Extending the JavaScript example from [Identifier Structures: 11.8 User-defined QRN Semantics](./nomo-id-structures.md#118-user-defined-qrn-semantics), one could imagine an inter-language working group deciding on a codified, QRN-based standard for identifying the components of different language specifications, for the purposes of facilitating human research, automated transpilation, or other goals.

To the extent that the resulting standards can be expressed as mechanical glyph sets and algorithms as described in this specification, such standards are part of a schema and are therefore a Nomo concern. Any and all of the infinite range of possible administrative, mechanical, and semantic rules which could be layered on top are and shall remain outside the scope of Nomo.
 
### 6.1 Identifier Part Aliases

The Nomo identifier structures and the parts of a QRN are named according to generic concepts in set theory. While these terms match well the the abstract intent of Nomo structure, schema authors may also wish to provide their own context-specific names for the parts of a QRN, or for the QRN concept itself.

For example, imagine a schema that applies the QRN concept to identifying versioned data models and the definitions within those models. The schema authors may wish to define the following aliases, to facilitate clarity and understanding when working with this schema:

|Part|Alias|Purpose|
|-|-|-|
|set name|domain|The set name is always used to define the domain (name) of the data model itself. The set is the set of definitions contained in that data model|
|set key|domain version|The set key, if present, is always used to indicate a semver-conforming version of that domain|
|group name|namespace|The group name, if present, is always used to specify a "namespace": A semantically-named, likely topical, subset of the overall data model|
|element name|type|The element name is always used to specify a named type or entity within the data model|
|element key|enum key|If an element key is present, it is used to identify a specific predefined value of an enumeration type|

Ultimately, such aliases are merely a matter of technical communication between humans. The actual mechanics of identifiers and schemas do not depend on what humans choose to call the identifier types or the parts of a QRN. Take this section then as explicit encouragement to other authors to be creative and pragmatic with how they build on Nomo concepts. The usefulness of all these ideas is enhanced by creativity in semantics on the one hand with conservation of mechanics on the other. 

