# Nomo: Schema Primitives

version `0.17.0` • 2023-06-29

## 1. Introduction

Nomo is a standard for constructing identifiers that are unique, semantic, and mechanically easy to process. Nomo describes identifiers that are not bound to any institutional or mechanical infrastructure, nor to any central authority. Its purpose is to facilitate systematic cooperation and distributed recordkeeping by providing a stable framework for producing and consuming identifiers that are mutually intelligible and stable across many cultures and contexts, over arbitrarily short or long time spans.

For an extended introduction to the Nomo standard, see [Nomo: Introduction](./nomo-intro.md).

### 1.1 Schema Primitives

[Nomo: Identifier Primitives](./nomo-id-primitives.md) defines the abstract primitives from which any Nomo identifier can be constructed and compared. Most practical uses of identifiers require two additional concepts: **serialization** and **validation**. A set of associated serialization and/or validation rules is called a **schema**. 

This specification document formally defines a set of concepts which describe how identifier primitives may be validated, and may be mapped to or from serialized strings.
 
## 2. Identifier-strings

Nomo defines the following serialized string types, all of which include any delimiters or other annotation glyphs as required to describe the underlying identifier which the string encodes. A string of any of these types can be called an identifier-string:

  - **name-string** - A [**name**](./nomo-id-primitives.md#4-name) encoded as a single string
  - **tuple-string** - A [**tuple**](./nomo-id-primitives.md#6-tuple) value encoded as a single string
  - **map-string** - A [**map**](./nomo-id-primitives.md#7-map) value encoded as a single string
  - **qrn-string** - A [**QRN**](./nomo-id-primitives.md#9-qualified-resource-name) encoded as a single string
  - **null-string** - A placeholder string which explicitly indicates a [null value](./nomo-id-primitives.md#8-null)

### 2.1 Relation to string primitives

All identifier-strings are by definition strings according to the definition of the string primitive in Nomo: Identifier Primitives. They are a sequence of glyphs composed from glyph types of a definite glyph set. 

Despite this fact, it is not generally useful to compare a string primitive directly to an identifier-string. A string primitive represents a single (string) piece of an identifier itself, while an identifier-string represents a transformation of an identifier with all its structure and constituent glyphs in the abstract into a single sequence of glyphs, usually in a related but distinct glyph set, and usually with some transformations or annotations to embed the identifier structure into the output (or input) identifier-string.

### 2.2 Identifier-string equivalence

The rules defined in [section 4](#4-identifier-primitives) strictly define whether two identifiers are considered equal. The same strict rules of equality as defined in [4.2 Strings](#42-string) apply to identifier-strings as well.

In addition, two identifier strings are **equivalent** if they [decode](#52-schema-operations) to the same identifier, even if the identifier-strings themselves are not the same. By definition, two identifier-strings that are the same are also equivalent.

identifier-strings that are equivalent but not the same are valid and allowed, as described further under [5.2 Schema Operations](#52-schema-operations). Mechanisms such as *escape sequences* or allowance of non-significant whitespace included in many practical schemas allow many distinct identifier-strings to deterministically decode to the same underlying identifier.

This use of the term "equivalent" is an intentional additional application of the word beyond its use in the identifier primitives specification, where it is used only to describe the mapping between individual glyphs in two compatible glyph sets.

### 2.3 Identifier-string support

Any valid schema must be able to represent name-strings and qrn-strings. 

Schemas that allow tuple values must be able to represent tuple-strings, and likewise schemas that allow map values must be able to represent map-strings. 

#### 2.3.1 null-strings

No schema is required to represent non-empty null-strings, if other delimiters or punctuation unambiguously encode where null values would be. For example, the common schema tuple-string `(,,)` unambiguously encodes a tuple with three null values, even though the actual values are not represented by any glyphs at all. Instead, the tuple is encoded entirely by delimiting characters. 

null-strings are instead defined above as a valid concept that schema designers may choose to use if desired, where a non-empty sequence of glyphs in a tuple-string or map-string is used to explicitly note a null value. Imagine for example a schema that requires all string values to be delimited with single quotes, and then also allows the literal glyph sequence `null` to denote a null value. The same tuple of three null values could be encoded even without surrounding parentheses as `null,null,null`. And this would be unambiguously different from the encoding of a sequence of three string values where the actual contents of each string are the literal characters n-u-l-l: `'null','null','null'`.

## 3. Schema Operations

Nomo defines three schema operations:

  - **encode** - A deterministic algorithm that maps a structured identifier to a representation as a single identifier-string
  - **decode** - A deterministic algorithm that maps a single identifier-string to the one structured identifier it represents
  - **validate** - A deterministic algorithm that can take any identifier primitive and determine whether it is valid or invalid according to some internal rule set

#### 5.2.1 Encoding Parameters

The encode operation may include parameters that affect how an identifier is mapped to an identifier-string. Examples could include parameters determining how aggressively escaping or delimiting is applied, or whether non-significant whitespace is included in the output. 

Any parameters defined must have a default value. All possible combinations of valid parameters must produce identifier-strings that decode back to the same input identifier. All possible combinations of valid parameters must be deterministic: the same input identifier plus the same parameters must always produce the same identifier-string.

The decode and validate algorithms may not define parameters.

#### 5.2.2 Determinism

To reiterate, all three schema operations must be deterministic. 

-  The encode operation allows parameters, therefore its output must depend solely on the combination of the parameters and input identifier. 
 - The validate operation does not allow parameters and takes an identifier as input, therefore its output depends solely on the input identifier
 - The decode operations does not allow parameters but takes an identifier-string as input. This does allow for what are effectively decoding parameters to be embedded in an identifier-string.

#### 5.2.3 Round Trip Stability

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

#### 5.2.4 Identifier-string validity

Nomo does not define a schema operation for testing the validity of an *identifier-string* directly, as this is a redundant. Any identifier-string is valid if it can be unambiguously decoded to an identifier, and the resulting identifier is valid according to the validate algorithm of the schema.

An identifier-string may be rejected as *syntactically* invalid if its sequence of glyphs cannot be interpreted according to the decode algorithm.

### 5.3 Schema Composition

A **schema** is composed of the following:

- An **identifier glyph set**: The glyph set used for identifiers
- An **encoding glyph set**: The glyph set used for identifier-strings
- An **encode algorithm** as described above
- A **decode algorithm** as described above
- An *optional* **validate algorithm** as described above

If a schema includes no explicit **validate algorithm**, then all possible identifiers composed from the identifier glyph set are valid. Common schema validation rules might prohibit empty values or certain subsequences of otherwise allowed glyphs, or might require that certain parts of a QRN be either defined or undefined. Regardless, a validate algorithm must be deterministic and based solely on the input identifier.

#### 5.3.1 Glyph set compatibility

There is no requirement that the identifier glyph set and encoding glyph set for a schema be compatible with each other; they need not even be defined in the same medium.

Even for the usual case where both glyph sets are defined in the same medium and where there is partial compatibility (some glyph types in the identifier set are the same or equivalent to some glyph types in the encoding set), it is likely that the identifier glyph set will include glyph types that are not allowed in the encoding glyph set, and likewise that the encoding glyph set may include delimiting glyph types that are not included in the identifier glyph set. 

Glyph types that are allowed only in the identifier set or which have special meaning in an identifier-string are generally decomposed or escaped to multiple glyphs in the resulting identifier-string, while delimiters in an identifier-string are always eliminated completely in translation to a structured identifier. Insignificant whitespace glyphs in an identifier-string would also be eliminated during decoding.

Finally, the prohibition on outside parameters for the decode algorithm does not prevent the inclusion of glyphs in an identifier-string itself that function as control features which determine how all or part of the identifier-string is interpreted during decoding. Imagine for example a schema that allows identifier-strings to begin with the sequence `L:`, which is omitted from the resulting identifier but which causes all glyphs in the source identifier-string to be decoded as the lower-case equivalent of the source glyph.

#### 5.3.2 Glyph ordering and map-strings

Several requirements in the preceding sections present a potential contradiction:

 - [Section 4: Identifier Primitives](#4-identifier-primitives) explicitly [prohibits](#413-collation-and-comparison) defining any properties on or between glyph types such as ordering, collation, etc. 
 - The key-value pairs of a [map](#443-map-equality) are explicitly unordered
 - The algorithm of any [encode operation](#52-schema-operations) must be deterministic

A naive encode operation that simply decorated an input identifier with delimiters and possible escape sequences would have no way of determining which order to encode the key-value pairs of a input map into an output map-string, and would therefore fail the requirement that encoding be deterministic.

It follows that all valid schemas provide one of the following two features:

 - The validate operation is defined and prohibits maps with more than one key-value pair
 - The encode operation includes some *string* ordering mechanism, either embedded in the algorithm or provided as a parameter

The [common schema](#6-common-schema), for example, uses Unicode for both its identifier and encoding glyph sets. To address key ordering during encoding, the common schema relies on the unique integer value assigned to each code point in Unicode and then on the intrinsic ordering of integers to sort the keys in an input map, using traditional character-by-character comparison to yield an overall sorting of two input strings.

This is not a violation of the prohibition on primitive glyph type properties. It is instead simply an implementation detail of the encode operation of the schema. Assigning an arbitrary unique integer in this manner to each glyph type in an identifier glyph set is one generic strategy for string ordering. Any number of other algorithms could also be constructed and would all be valid provided their output is deterministic. 

Regardless, these mechanics are conceptually implementation details of encode operations rather than intrinsic properties of the glyph types themselves. Since the only requirement is to deterministically sort the *keys* of a map, which are entire strings, it is not even required that the algorithm have a predictable ordering based on glyph-by-glyph comparison. Some imaginary ordering algorithm that always sorts `arrow` before `zoo` but also `zoo` before `apple` is perfectly valid as long is it always yields the same outcome.

It remains meaningless within Nomo to ask whether one identifier or even identifier-string "comes before" another, or whether one identifier-string is some transformation of another.

Finally, the strict requirement that encode operations be deterministic does not prevent parties from manually assembling valid equivalent identifier-strings merely by changing the order of encoded key-value pairs. All above the relations and constraints described in this specification continue to hold:

Given a map with *n* key-value pairs, and the *n!* possible orderings (permutations) of its key-value pairs in an encoded map-string

 - Any of the *n!* encodings will decode back to the same map, because the definition of ["same" for a map](#443-map-equality) is defined without respect to key-value ordering
 - Applying the encode operation to the map will always produce the same one of the *n!* possible valid map-strings
 - The ordering mechanics used in the encode operation are not visible outside the algorithm

That is, the observable behaviors are still limited to those allowed:

 - Each distinct encoding can be determined to be equivalent to all other encodings, while also not the same as any of the other encodings (equivalence can be tested)
 - The map-string produced by one application of the encode operation can be determined to be the same as the map-string produced by any other application of the encode operation (determinism can be verified)
 - It is undefined which encoding is "first" or "next", and unknown *how* the encode operation selects the same output map-string each time (no glyph type properties are defined)

In summary, a deterministic *string* ordering algorithm is required to implement a valid deterministic encode operation that accepts maps with more than one key-value pair, and yet this does not pollute the concept space by introducing glyph ordering.

### 5.4 Semantic Standards

It is intended and expected that cooperating parties will also find it useful to agree on standard *semantics* to require for certain situations. Extending the JavaScript example from [4.7 User-defined QRN Semantics](#47-user-defined-qrn-semantics), one could imagine an inter-language working group deciding on a codified, QRN-based standard for identifying the components of different language specifications, for the purposes of facilitating human research, automated transpilation, or other goals.

To the extent that the resulting standards can be expressed as mechanical glyph sets and algorithms as described in this [section 5](#5-schema-primitives), such standards are part of a schema and are therefore a Nomo concern. Any and all of the infinite range of possible administrative, mechanical, and semantic rules which could be layered on top are and shall remain outside the scope of Nomo.
 
#### 5.4.1 Identifier Part Aliases

The [identifier primitives](#4-identifier-primitives) and QRN parts are named according to generic concepts in set theory. In addition to validation rules that support a specific use case, schema authors may also wish to provide their own context-specific names for the identifier primitives, the parts of a QRN, or for the QRN concept itself.

For example, imagine a schema that applies the QRN concept to identifying versioned data models and the definitions within those models. The schema authors may wish to define the following aliases, to facilitate clarity and understanding when working with this schema:

|Part|Alias|Purpose|
|-|-|-|
|set name|domain|The set name is always used to define the domain (name) of the data model itself. The set is the set of definitions contained in that data model|
|set key|domain version|The set key, if present, is always used to indicate a semver-conforming version of that domain|
|group name|namespace|The group name, if present, is always used to specify a "namespace": A semantically-named, likely topical, subset of the overall data model|
|element name|type|The element name is always used to specify a named type or entity within the data model|
|element key|enum key|If an element key is present, it is used to identify a specific predefined value of an enumeration type|

Ultimately, such aliases are merely a matter of technical communication between humans. The actual mechanics of identifiers and schemas do not depend on what humans choose to call the identifier types or the parts of a QRN. Take this section then as explicit encouragement to other authors to be creative and pragmatic with how they build on Nomo concepts. The usefulness of all these ideas is enhanced by creativity in semantics on the one hand with conservation of mechanics on the other. 

### 5.5 Bound Identifiers

With the concept of a schema in hand, it becomes useful to also conceive of a particular QRN or other identifier as **bound** to a particular schema. All identifier primitives are implicitly bound to an identifier glyph set, but the validation, encode, and decode operations defined by a useful schema provide additional context that can help humans and machines known how to validate and understand an identifier-string.

#### 5.5.1 Schema Embedding

Because of this, schema authors may wish to consider defining a way in which to encode an indication of the schema to which a particular identifier is bound when producing an identifier-string. The common schema does this by allowing a schema-name prefix to bracketed qrn-strings.

Note that allowing one schema to define how to encode the fact that some QRN is actually bound to another schema is not necessarily a contradiction. It is intended that authors use the underlying mechanics of the common schema -- including the schema name prefix of a qrn-string -- to build their own more restrictive schemas. Those more restrictive schemas will mostly add validation rules with in turn constrain the possible identifiers, while the substance of the encode and decode algorithms from the underlying common schema are fully preserved.

In these cases, *any* valid derived schema will produce qrn-strings that are valid and parsable by the underling common schema rules. If the source qrn-string includes a schema name prefix, then the human or computer reading the qrn-string will be aware that there may also be additional validation rules, or interpretive context, which can be applied to the otherwise raw decoded QRN.

As an example, would could define a schema that maps the parts of a generic QRN to any valid internet URL. The set name corresponds to the domain, with the set key used to specify an optional port and/or protocol. The group name represents all parts of the path that are followed by a slash. The element name represents the final part of the path if there is no trailing slash, and the element key can be used to encode URL parameters and/or a URL fragment. We could further define this schema such that the authority is optional, but if present must be `iana`, reflecting the fact that the IANA has the sole power to allocate the domain names that are the root of any internet URL.

```
url<iana/github.com[443]::malva-ot.nomo.blob.spec.main:common-schema.ebnf[#L49]>
```
