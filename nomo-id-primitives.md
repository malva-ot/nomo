# Nomo: Identifier Primitives
 
version `0.17.0` • 2023-07-06

## 1. Introduction

Nomo is a standard for constructing identifiers that are unique, semantic, and mechanically easy to process. Nomo describes identifiers that are not bound to any institutional or mechanical infrastructure, nor to any central authority. Its purpose is to facilitate systematic cooperation and distributed record-keeping by providing a stable framework for producing and consuming identifiers that are mutually intelligible and stable across many cultures and contexts, over arbitrarily short or long time spans.

For an extended introduction to the Nomo standard, see [Nomo: Introduction](./nomo-intro.md).

### 1.1 Identifier Primitives

This document contains the first layer of the formal specification of Nomo: the **identifier primitives**. The identifier primitives form the theoretical and mechanical foundation of Nomo. They are designed and intended to be normative and permanent.

Nomo identifier primitives are abstract ontological or mathematical concepts. They do not imply or require anything with regards to implementation, and impose no constraints besides those explicitly noted. Practical orthographic and protocol decisions for an implementation of QRNs in distributed record keeping is provided in the [common schema](./nomo-common-schema.md).

TODO: 
- Explain layers of "primitives"
- Consider more precised language to distinguish true indivisible "primitives" (glyphs) from "values" (string, tuple, map, null), from "identifiers", (names, QRN)
 
Nomo defines the following identifier primitives:

  - [**glyph type**](#211-glyph-type) - A single unique reproducible pattern unit
  - [**glyph set**](#212-glyph-set) - A set of glyph types
  - [**glyph**](#213-glyph) - A representation of a glyph type
  - [**string**](#3-string) - A sequence of zero or more glyphs from a glyph set
  - [**name**](#4-name) - A sequence of zero or more strings
  - [**value**](#5-value) - A compound primitive
  - [**tuple**](#6-tuple) - A sequence of values
  - [**map**](#7-map) - An unordered map of string keys to values
  - [**null**](#8-null) - The absence of any value
  - [**qualified resource name**](#9-qualified-resource-name) - A composition of names and values that constitutes a complete identifier

### 1.2 Terms

- "This document" refers to this specific document: "Nomo: Identifier Primitives", as distinct from the additional documents or other media which constitute the Nomo standard as a whole.
- "This specification" refers to the normative sections of this document. 

#### 1.2.1 Comparison terms

The most basic task when evaluating identifiers is to determine whether two identifiers are the same. Some [other relations](#10-relations) may also be determined due to the semantic structure of [qualified resource names](#9-qualified-resource-name). This specification takes care to use or not use the following terms to describe comparisons: 

##### 1.2.1.1 Same

This specification includes many descriptions of how two given primitives or identifiers may evaluated to be the **same** or not.

##### 1.2.1.2 Equivalent

**Equivalent** is a conceptual synonym for "same", but in this specification that term is reserved to describe a formal (injective) mapping between glyphs and glyph types, as described in [2.5 Glyphs: Compatibility and equivalence](#25-compatibility-and-equivalence). 

##### 1.2.1.3 Compatible

**Compatible** is an adjacent term to "same", but in this specification is reserved to describe the formal mapping between two glyph sets, as described in [2.5 Glyphs: Compatibility and equivalence](#25-compatibility-and-equivalence). 

##### 1.2.1.4 Equal

**Equal** is also a conceptual synonym for "same", but is absolutely excluded from this specification in favor of "same". "Same" is preferred over "equal" to avoid any implication of quantity or ordering associated with glyph types or identifiers.  

Likewise, "sameness" is also used where "equality" would be conceptually synonymous.

### 1.3 Versioning

Each independent specification document of Nomo is versioned strictly according to semver 2.0. Nomo does not describe a software system, but it does describe a mechanical, verifiable contract of concepts and relations.

## 2. Glyphs

### 2.1 Definitions

The atoms of any Nomo identifier are the glyphs from which it is assembled. The following definitions imply a means to determine whether any given glyph corresponds to a glyph type within a particular set. Such an implementation is not defined in this specification, rather it is an assumed precondition.

#### 2.1.1 Glyph type
A **glyph type** is a single symbolic pattern which can be consistently represented and recognized. 

#### 2.1.2 Glyph set
A **glyph set** is a set of one or more distinct glyph types. 

#### 2.1.3 Glyph
A **glyph** is an instance of a glyph type. 

### 2.2 Characters

In most use cases immediately contemplated by the authors, a glyph type means either a specific integer or an orthographic pattern: a shape that can be recognized and distinguished by some biological or synthetic visual system. A distinct orthographic shape is usually called a character.

Likewise in these use cases a glyph set means a finite set of integers, or a finite set of distinct orthographic shapes (characters).

Character encodings used in contemporary computing provide mappings between integers and orthographic shapes, so that in practice a glyph set is understood by a computer as a set of integers, while the same glyph set is understood by a human as a set of characters. The character encoding provides the mapping between the two sets. 

### 2.3 Alternative mediums

The term glyph implies a two-dimensional pattern in the manner of a character in a human natural writing system, but any pattern in any medium that can be consistently reproduced and recognized can be used as a glyph type. As glyphs are the atoms of which all Nomo identifiers are built, Nomo identifiers of any complexity can likewise be constructed or evaluated in any medium which can be used to express and recognize glyphs.

### 2.4 Collation and comparison

Many natural writing systems have cultural rules about the ordering of written characters, or about equivalence between different representations of the "same" character. Nomo recognizes no such rules. Each glyph type is strictly distinct from every other glyph type in a glyph set. The only meaningful evaluation between two glyphs types or glyphs is whether they are the same or different.

### 2.5 Compatibility and equivalence

Two distinct glyph sets are **compatible** if there is defined an unambiguous (injective) mutual mapping between at least one glyph type in one set with a glyph type in the other set. Two distinct glyph sets are **fully compatible** if both sets have the same count of glyph types, and for every glyph type in one set there exists an unambiguous mutual mapping to one glyph in the other set. In other words, two glyph sets are fully compatible if there is a bijective mapping between them.

Between compatible glyph sets, a mutually mapped glyph type in one set is **equivalent** to the glyph type in the other set to which it is mapped, and vice versa.

When comparing two identifiers, where the respective glyph sets of the two identifiers are compatible, a particular glyph in one identifier is **equivalent** to a particular glyph in another identifier if the glyph type that the glyph in the first identifier represents is equivalent to the glyph type which the glyph in the other identifier represents.

## 3. String

### 3.1 Definition 

A Nomo **string** is a sequence of zero or more glyphs from the same glyph set.

The term "string" is chosen for agreement with common usage in computing, but again does not imply any constraint on the medium used to define a glyph set or compose as string. The only defining feature of a string is that it is a finite sequence of glyphs. An algorithm that produces a finite sequence is not a string, but the sequence it produces is. An empty string of zero glyphs is a valid Nomo string. Serializations of such strings generally require delimiters for disambiguation, but the underlying string is defined as the (empty) sequence itself.

### 3.2 Properties

All strings have the property of length, but length has no significance within Nomo.

### 3.3 Comparison

The only meaningful evaluation between two Nomo strings is whether they are the same or different. Two strings are the same if and only if:

 - The glyph sets of the two strings are the same or are compatible 
 - The two strings have the same number of glyphs
 - For all *n* from 1 to the length of the strings, the glyph at ordinal *n* in one string is the same or equivalent to the glyph at the same ordinal in the other string

In the special case of zero-length strings, two strings are the same if and only if their respective glyphs sets are the same or are compatible. Conversely, zero-length strings of two incompatible glyph sets are not the same.

## 4. Name

### 4.1 Definitions

A Nomo **name** is a sequence of zero or more strings, where all strings use the same glyph set. Each string within a name is called a **segment**. 

### 4.2 Semantics

Names provide an additional dimension of semantic representation beyond the choice and ordering of glyphs within a single string.

The name concept itself does not define intrinsic meaning about the selection or ordering of strings within a name. It instead provides a primitive mechanical feature which may be used by humans to represent any number of meanings.

In other words, a name definitely specifies the ordering of its segments, but only humans or other parties have any opinion about what that ordering "means".

### 4.3 Properties

All names have the property of count (the number of constituent segments) and of length (the sum of the lengths of the constituent segments). Neither of these properties has any significance within Nomo.

### 4.4 Comparison

The only meaningful evaluation between two Nomo names is whether they are the same or different. Two names are the same if any only if:

 - The glyph sets of the two names are the same or are compatible 
 - The two names have the same number of segments
 - For all *n* from 1 to the count of segments, the string of segment *n* in one name is the same as the string of segment *n* in the other name, according to the rules described in [3. String](#3-string).

It follows that:
 - Two names composed solely of zero-length segments are the same if and only if they have the same count of segments, and the glyph sets of the names are the same or compatible
 - Two names that have zero segments are the same if and only if the glyph sets of the names are the same or compatible


## 5. Value 

### 5.1 Definitions

A **value** is a compound primitive datum composed of one of the following:

 - **string** - A single string as defined above
 - **tuple**  - A sequence of values
 - **map**    - An unordered set of key-value pairs
 - **null**   - The absence of any value

Tuples, maps, and null values are described further below.

### 5.2 Semantics

Values provide extensibility to the qualified resource name concept by providing structures that humans may use to express a wide variety of meanings.

### 5.3 Type and Comparison
 
All values have a type: string, tuple, map, or null. The possible values of each type are strictly non-overlapping.
 
Two values are the same if and only if they are composed from the same or compatible glyph sets, they have the same type (string, tuple, map, or null), and the constituent parts of the value are also the same according the rules in this specification:
 
  - [3.3 String: Comparison](#33-comparison)
  - [6.3 Tuple: Comparison](#63-comparison)
  - [7.3 Map: Comparison](#73-comparison)
  - [8.1 Null: Comparison](#81-comparison)

### 5.4 Empty values

The string, tuple, and map types each have an empty value - a string with zero glyphs, a tuple with zero values, or a map with zero key-value pairs. As noted above, for two values to be considered the same they must have the same type and the same or compatible glyph sets. Therefore, even for the same glyph set, the empty string, empty tuple, and empty map are three distinct values. In addition, the null value has a different type and is therefore a distinct value which is not the same as any of the empty values of the string, tuple, or map types.

### 5.5 Numeric or other value semantics

The tuple and map types allow for values that resemble general purpose data structures used in digital data storage, processing and exchange. That is not their purpose, and Nomo is not designed to be a universal data primitive representation standard.

Specifically, Nomo values are exclusively composed of strings - of sequences of atomic pattern types (glyph types) that have no intrinsic meaning or comparison besides whether they are the same or different. Considering the additional numeric-symbolic meaning of the glyph "9", let alone the collective numeric interpretation of the string "-3.1415", is strictly outside the scope of Nomo. It follows that there are no multi-glyph types besides "string".

All other types and identifiers (name, tuple, map, QRN) are in turn simply logical arrangements of strings. Nomo does not and will never define numeric, chronological, or any other data type whose meaning depends on the symbolic human ideas associated with a glyph or string. 

Put yet another way, there are no *data types* in Nomo, just a handful of string arrangements.

## 6. Tuple

### 6.1 Definition

A **tuple** is a sequence of zero or more values. The values of a tuple may themselves be string, tuple, map, or null values.

### 6.2 Properties

Tuples have the property of length (the count of elements), but this property has no significance within Nomo.

### 6.3 Comparison

Two tuples are the same if and only if:

 - The glyph sets of the two tuples are the same or are compatible 
 - The two tuples have the same number of elements
 - For all *n* from 1 to the count of elements, the value of element *n* in one tuple is the same as the value of element *n* is the other tuple, according to the rules described in this specification.

### 6.4 Equivalence to Name concept

As defined above, a name is a sequence of string segments. Likewise, a tuple is a sequence of values which might all be strings. 

A **name** therefore **is** a tuple where all the values are strings, and likewise a tuple where all the values are strings **is** a name. 

Note that the null value is not a string, so a tuple which contains a null element is not a name, and likewise a name can contain an empty string segment but cannot contain a null segment.

The identity relation between a name and a tuple of strings has no meaningful implication for QRNs, which are the ultimate purpose of this specification. However, where software implementations or logical analyses of Nomo allow or execute comparisons between arbitrary identifiers, they must evaluate a "tuple" value to be the same as a "name" value if the underlying sequences of strings of the respective values would be evaluated as the same.

## 7. Map

### 7.1 Definition

A **map** is an unordered set of key-value pairs, where each key is a string and each value is a string, tuple, map, or null.

The keys within a map must be unique. Uniqueness is strictly defined according to the string comparison rules described above (see [3.3 String:  Comparison](#33-comparison)).
 
### 7.2 Properties

Tuples have the property of size (the count of key-value pairs), but this property has no significance within Nomo.

### 7.3 Comparison

Two maps are the same if and only if:

 - The glyph sets of the two maps are the same or are compatible 
 - The two maps have the same number of key-value pairs
 - For each key *k* in one map, the same key exists in the other map, and the value associated with *k* in the first map is the same as the value associated with *k* in the other map, according to the rules described in this specification.

### 7.4 Subset relations

According to the definitions above, any given pairs of maps can also be evaluated to determine if there is a strict subset / superset relation between the two maps. Although well-defined, such relations have no particular meaning or significance within Nomo. 

## 8. Null

A **null** value is the absence of any value, and is distinct from the concept of an empty (zero-length) string. Any null value is still defined in reference to an associated glyph set.

### 8.1 Comparison

Two null values are the same if and only if the glyph sets of the values are the same or compatible. 

As noted above, a null value is not the same as an empty string, map, or tuple value, even if the respective glyph sets are the same or compatible.

## 9. Qualified Resource Name

A Nomo **qualified resource name** (QRN) is a composition of other Nomo primitives whose parts are chosen to correspond directly to concepts in set theory. A QRN represents a fully qualified identifier, and is the ultimate purpose of this specification.
 
A QRN is composed of the following parts, all of which are optional. All parts in a QRN must use the same glyph set:

|Part|Type|Description|
|-|-|-|
|**authority**|**string**|An arbitrary string identifying the universe of a set. In general, the principal which declares the identifier|
|**set name**|**name**|The identifier of a **set** itself|
|**set key**|**value**|A further qualifier on the identity of a **set** itself|
|**group name**|**name**|The identifier of a proper **subset** within a set|
|**element name**|**name**|The identifier for a specific **element** within a set|
|**element key**|**value**|A further qualifier on the identity of an **element** within a set|

### 9.1 Authority

The authority is the root disambiguating context of a qualified resource name. Nomo itself intentionally does not provide any opinion or mechanism for allocating authority strings. Assignment, agreement, or proof of ownership of some particular authority string is an authentication concept outside the scope of Nomo.

### 9.2 Set

The set name and key represent the identifier of a set itself. The primitive QRN concept does not require that a set name be present if a set key is present. The set name and key are collectively called the set identifier.

When both a set name and a set key are present, the QRN concept itself defines this to mean that the set name represents a set of sets which share some unifying character or attribute, while each unique key value appended to the set name represents a specific instance of such a set.

A common intended usage is to use the set name to denote a software, data, or administrative concept domain, and the key to denote a specific version of that domain.

### 9.3 Group

The group name represents the identifier of a proper subset within the set identified by the set identifier. A QRN containing only a group name expresses the concept of an identified subset independent of any particular set to which it may belong.

### 9.4 Element

The element name and key represent the identifier of a specific element within the set identified by the set identifier or the subset identified by the group name. The primitive QRN concept does not require that an element name be present if an element key is present. The set name and key are collectively called the element identifier.

When both an element name and an element key are present, the QRN concept itself defines this to mean that the element name represents a set of elements which share some unifying character or attribute, while each unique key value appended to the element name represents a specific instance of such an element.

A QRN containing only an element name or key represents the concept of an identified element independent of any particular set or subset to which it may belong.

A common intended usage is to use the element name to denote a resource collection and element key to identify a specific resource within that collection: colloquially, to identify a table with the element name and a row within that table with the element key.

### 9.5 Empty and Missing Parts

As section [5.4 Empty Values](#54-empty-values) describes, the null value is not the same as the empty value of string, tuple, or map. It follows that the empty value of a given part of a QRN is not the same as a missing value for the same part: a QRN may include an authority whose value is the empty string of the glyph set used by the QRN, and this is different from a QRN which uses the same glyph set but has no authority part.

An explicit null value for a set key or element key is defined to have the same meaning as a missing key part.

### 9.6 Equality

Two QRNs are the same if and only if:

 - The glyph sets of the two QRNs are the same or are compatible 
 - For each of the six parts of a QRN, the part is undefined in both QRNs, OR the part is defined in both QRNs and the corresponding values are the same according to the rules defined in this specification

## 10. Relations

### 10.1 Value relations

As noted in the sections above, Nomo does not define any relationship or comparison between values of any type except for sameness.

As an illustration, consider an internet domain name such as `mail.example.com` as represented by a Nomo name with the ordered segments [`mail`, `example`, `com`]. The internet domain name system as centrally coordinated by IANA explicitly does define subset semantics such that `mail.example.com` is definitely a "subdomain" of `example.com`, which is itself a member of the "top level domain" `com`.

But Nomo itself defines no relationship between the names [`mail`, `example`, `com`], [`example`, `com`], and [`com`]. It only concludes that they are different names.

### 10.2 QRN relations

In addition to sameness, Nomo itself **does** define one additional boolean complementary comparison relationship between QRNs. This comparison is called **in** or **contains**. One formulation expresses whether a QRN is **in** the domain of possible identifiers denoted by a second QRN. The complementary formulation expresses whether the domain of possible identifiers denoted by a QRN **contains** another QRN.

#### 10.2.1 Operators

In summary, three operators are defined between two QRNs, with similar meanings as in standard set theory:

||Name|Example|Description|
|-|-|-|-|
|`=`|same|`A = B`|A is the same as B|
|`∈`|in|`A ∈ B`|A is in B|
|`∋`|contains|`B ∋ A`|B contains A|

Further:

 - All three operators are boolean and binary: They accept a left and right operand, and definitely evaluate to `true` or `false`. 
 - Nomo also asserts that all three operators are mutually exclusive: Given any left operand `A` and right operand `B`, if one operator applied to these operands evaluates to true, then the other two operators definitely evaluate to false.
 - **same** is complementary to itself, i.e. it is commutative
 - **in** is complementary to **contains** and vice versa

#### 10.2.2 Corollaries

The above implies the following corollaries regarding these operators:

|||
|-|-|
|`A = B ⇒ B = A`|If A is the **same** as B, then B is the **same** as A|
|`A ∈ B ⇒ B ∋ A`|If A is **in** B, then B **contains** A|
|`A ∋ B ⇒ B ∈ A`|If A **contains** B, then B is **in** A|
|`A = B ⇒ !(A ∈ B)`|If A is the **same** as B, then A is **not in** B|
|`A = B ⇒ !(A ∋ B)`|If A is the **same** as B, then A does **not contain** B|
|`A ∈ B ⇒ !(A = B)`|If A is **in** B, then A is **not the same** as B|
|`A ∋ B ⇒ !(A = B)`|If A **contains** B, then A is **not the same** as B|

#### 10.2.3 Subset relations

Readers familiar with set theory may note that additional set relationships could be expressed, and that it may seem to make more sense if, for example, one QRN contains a group name but no element identifier. In this case would it not make more sense to say the following, for example?:

```
ecma/es[11]::types ⊂ ecma/es[11]
```

And **not**

```
ecma/es[11]::types ∈ ecma/es[11]
```

Which is to say, according the the semantics defined for QRNs, isn't the first identifier above (`ecma/es[11]::types`) a **subset** rather than **element of** of the second identifier (`ecma/es[11]`)?

The answer is that Nomo is strictly concerned with relationships between identifiers, not between things or concepts which those identifiers may denote. Further, Nomo limits itself to defining binary relations -- relations between exactly one identifier and exactly one other identifier. In this context, `ecma/es[11]::types` *denotes* a subset of the ideas or things *denoted* by `ecma/es[11]`, but the identifier itself is a single element, a single defined entity. 

According to the relations further described below, the identifier `ecma/es[11]::types` is in the domain of possible identifiers relative to `ecma/es[11]`, therefore `ecma/es[11]::types` is **in** `ecma/es[11]`, and by complement `ecma/es[11]` **contains** `ecma/es[11]::types`. We use the symbols `∈` and `∋` to describe this. Whether this constitutes the "same" usage of these symbols as in set theory in general, is merely an analogy, or is in fact a misuse of the symbols is a philosophical question we leave to readers to debate.

The descriptions below do use the union `∪` and intersection `∩` symbols to illustrate relationships. The intended result is still to define the outcome of applying the **in** (`∈`) or **contains** (`∋`) operator to two identifiers.

#### 10.2.4 Notation

For convenience, the following descriptions represent QRNs using [common schema](#6-common-schema) notation. The relationships hold regardless of the medium or glyph sets used for two identifiers.

The asterisk is used to stand for *any or all identifiers* with at least one defined part in the position indicated by the asterisk. This symbolic meaning is not part of the common schema, and is only used here to illustrate the relationships described.

### 10.3 Authority relations

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`A/*`|`∩`|`B/*`|`=`|`∅`|The domains of any two authorities are disjoint|
|`A/*`|`∈`|`A/`|||All identifiers relative to an authority are in the authority's domain| 

By definition, no possible identifier relative to authority `A` is in the set of possible identifiers relative to authority `B`. Conversely, all possible identifiers relative to a given authority string are considered in the same domain -- namely, the identifier domain denoted by that authority string.
  
### 10.4 Set relations
  
#### 10.4.1 Unkeyed sets

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`x::*`|`∩`|`y::*`|`=`|`∅`|The domains of two set names are disjoint|
|`x::*`|`∈`|`x::`|||All subsets and elements relative to a set name without a key are in the set denoted by that unkeyed set name|
  
#### 10.4.2 Keyed sets

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`x[1]::*`|`∩`|`x[2]::*`|`=`|`∅`|The sets denoted by two different key values relative to the same set name are disjoint|
|`x[1]::*`|`∈`|`x[1]::`|||All subsets and elements relative to a set name with a key are in the set denoted by that keyed set name|
 
#### 10.4.3 Relation between keyed and unkeyed sets

The relation between a QRN with a keyed set name and a QRN with an unkeyed set name is more subtle, but is still well defined.

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`x[*]::*`|`∈`|`x::`|||All set keys relative to the same set name are in the same set of sets denoted by the set name without a key|
|`x::*`|`∩`|`x[*]::`|`=`|`∅`|The subsets and elements relative to a set name without a key are disjoint the the set of keyed sets relative to that same set name|
|`x::*`|`∪`|`x[*]::`|`≡`|`x::`|The union of the subsets and elements relative to a set name without a key with the set of keyed sets relative to that same set name exactly equals the entire set of possible identifiers relative to the unkeyed set name.<br><br>In other words, the subsets and elements relative to an unkeyed set name along with the set of keyed sets relative to that set name form a partition over the possible identifiers relative to the unkeyed set name.|

### 10.5 Group relations

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`g:*`|`∩`|`h:*`|`=`|`∅`|The domains of two group names are disjoint|
|`g:*`|`∈`|`g:`|||All identifiers relative to a group name are in the group's domain| 

### 10.6 Element relations

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`e`|`∩`|`f`|`=`|`∅`|The domains of two element names are disjoint| 
|`e[1]`|`∩`|`e[2]`|`=`|`∅`|The domains of two element key values relative to the same element name are disjoint |
|`e[*]`|`∈`|`e`|||All element keys relative to the same element name are in the same set of elements denoted by the element name without a key|

### 10.7 User-defined QRN Semantics

Nomo itself defines no semantics or relations between identifiers other than those described above. This does not prevent parties from agreeing on their own semantics for relations between identifiers that the underlying standard simply recognizes as not the same. 

A common use case here, for elements within keyed and unkeyed set names, is to express the identity of a concept in general in association or contrast with the identity of that "same" concept within one or more specific "versions" of a concept collection.

Example:

|||
|-|-|
|`ecma/es::types:object`|The `Object` type in general across all versions of ECMAScript (JavaScript)|
|`ecma/es[1]::types:object`|The `Object` type with features and APIs specifically as defined in the first edition (1997) spec|
|`ecma/es[11]::types:object`|The `Object` type with features and APIs specifically as defined in the eleventh edition (2020) spec|

Nomo itself defines only that
- all three QRNs above are different from each other
- all three QRNs above are in the domain of possible identifiers relative to the unkeyed set `ecma/es::`
- the group and element parts of all three QRNs (`types:object`) are identical

Humans are free outside of Nomo to recognize or even formally define a semantic equivalence or relatedness between the three identifiers as all relating to the concept of the `Object` type within JavaScript / ECMAScript.