# nomo
 
#### versioning

|Part|Sections|Version|Date|
|-|-|-|-|
|Introduction and Purpose|1-3| -- |2022-12-23|
|[Identifier primitives](#4-identifier-primitives)|5|`0.1.0`|2022-12-23|
|[Schema primitives](#5-schema-primitives)|6|`0.1.0`|2022-12-23|
|[Common schema](#6-common-schema)|7|`0.1.0`|2022-12-23|
|[Theoretical Background](#a1-theoretical-background)|Appx 1| -- |2022-11-21|

## 1. Introduction

nomo is a standard for constructing identifiers that are unique, semantic, and mechanically easy to process. nomo describes identifiers that are not bound to any institutional or mechanical infrastructure, nor to any central authority.
 
The practical product of nomo is a suggested [common schema](#6-common-schema) for validating, parsing, and serializing [qualified resource names](#45-qualified-resource-name) and their component [primitives](#4-identifier-primitives). This schema is built on lower levels of specification which are described first. It is expected and intended that the common schema may change over time, while the underlying primitives which the schema encodes will remain stable indefinitely.

nomo includes three modules of specification:

- [**Identifier primitives**](#4-identifier-primitives) - Abstract concepts that provide a mathematically complete description of an identifier
- [**Schema primitives**](#5-schema-primitives) - Abstract concepts that describe how identifier primitives may be validated and mapped to or from strings
- [**Common schema**](#6-common-schema) - An instance of a schema intended for general use in distributed computing

## 2. License
Unless explicitly identified otherwise in the contents of a file, the content in this repository is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license. As summarized in the [Commons Deed](https://creativecommons.org/licenses/by-sa/4.0/) and strictly defined in the [license](./LICENSE.md) itself: you may share or adapt this work, provided you give appropriate credit, provide a link to the license, and indicate if changes were made. In addition, you must preserve the original license. For the details and actual legal license, consult the [license](./LICENSE.md).

### 2.1 Source Code
The [license](#2-license) of this work is designed for cultural works, [not source code](https://creativecommons.org/faq/#can-i-apply-a-creative-commons-license-to-software). Any source code intended for more than an illustration should be distributed under an appropriate license by including that license in the applicable source code file, or by placing the source code file in another repository with an appropriate license.
 
## 3. Purpose 

nomo provides a consistent mechanism for constructing and evaluating semantic identifiers, for the purpose of facilitating systematic cooperation between humans, and between humans and automated information systems.

nomo is designed to address situations where central allocation or arbitration of identifiers is impractical or undesirable, and yet it is useful or desirable that identifiers declared by unrelated parties be mutually intelligible and easy to disambiguate.

### 3.1 Characteristics 

In more detail, nomo identifiers are designed to achieve the following characteristics:
 
#### 3.1.1 Uniqueness

Uniqueness is an intrinsic goal of any identifier. nomo is designed to make it easy to construct identifiers that will not collide with other identifiers.

#### 3.1.2 Semantic clarity

"Semantic" means the content of the identifier has symbolic meaning to humans. Semantic clarity helps humans to compose, remember, and understand identifiers. 

The demand for semantic clarity precludes many contemporary unique identifier conventions such as [UUID / GUID](https://datatracker.ietf.org/doc/html/rfc4122), [Mongo ObjectId](https://www.mongodb.com/docs/manual/reference/method/ObjectId/), [XID](https://github.com/rs/xid), or similar constructions that are essentially serializations of a large random integer, with or without a time-based prefix.

#### 3.1.3 Mechanical clarity

Mechanical clarity helps both machines and humans to reliably determine whether or not two identifiers are equivalent or are related.

The demand for mechanical clarity precludes simply using unstructured natural language.

#### 3.1.4 Decentralization

nomo is designed to facilitate cooperation without the need for a central authority that arbitrates, authorizes, or allocates identifiers or identifier spaces.

To achieve mutual intelligibility, nomo defines identifier primitives along with deterministic rules for comparing them. 

To achieve decentralization, nomo provides two points where choice or implementation are left to cooperating parties to negotiate.

These two points of negotiation are the choice of [glyph set](#41-glyphs) for an identifier, and authentication of the [authority string](#451-authority) of a [qualified resource name](#45-qualified-resource-name). 

The [common schema](#6-common-schema) specifies a well-known glyph set, and many methods exist for authenticating ownership of an identifier string.

##### 3.1.4.1 Negotiation - Glyph set

Two nomo identifiers declared by two different parties are mutually intelligible if and only if those two parties agree on the equivalence of or a mapping between the [glyph sets](#41-glyphs) associated with the respective identifiers. 

Neither the identifier primitives nor schema primitives sections of the nomo standard provide any predefined glyph set, nor do they define any algorithm for establishing equivalence among potential glyph sets.

The [common schema](#6-common-schema) does specify a related pair of glyph sets: the widely used [Unicode standard](https://www.unicode.org/main.html). Unicode defines a set of positive integers, a set of visual shapes (characters), and a mapping between the two sets. For further detail, including rules for handling ambiguous mappings from characters to underlying code point integers, see [common schema](#6-common-schema).

##### 3.1.4.2 Negotiation - Authority string

The first level of qualification in a qualified resource name is the authority string. An authority string declared by one party is recognized by another party if and only if the recognizing party chooses to recognize it.

Even the [common schema](#6-common-schema) does not provide a mechanism for establishing or agreeing upon ownership of an authority string, which in the common schema is simply any valid sequence of one or more Unicode code points. The authors of this standard regard this as an authentication question which is delegated to any mechanism of authentication which cooperating parties agree to use. The name "authority" was chosen for concept equivalence to a forthcoming distributed authentication protocol described by the same authors of this standard, but nomo itself does not require or demand any particular choice of authentication system.

##### 3.1.4.3 Deterministic operations

**If** parties agree to recognize each other's respective glyph sets and authority strings, **then** nomo provides clear definitions so that the parties can understand the semantics of any identifier declared by any of the parties, and can deterministically answer whether any two identifiers are equivalent or are related in specific ways.

#### 3.1.5 Durability

A second order goal of all the characteristics described above is that nomo identifiers may be durable over time and space. While the authors intend to solve some immediate problems in distributed computing, they also aim to provide a means of establishing identifiers that can be communicated, understood, and continuously used across changing cultural and political boundaries, over indefinitely long time spans. Prime examples here include identification of persons, properties, documents, or industry and scientific standards.

Designing for durability is a key reason that the common schema included here is defined separately from the underlying primitives. One of the most important but also arbitrary decisions in that schema is the choice of characters used as delimiters between the serialized parts of an identifier. The characters chosen (`/`, `:`, `,`, `.`, `=`, `[`, `]`) are a function of specific cultural and industrial conditions at the time of writing. Most importantly, these characters are available on the vast majority of computer keyboards in use at the time. From that limited set of potential glyphs, these were chosen for visual distinction such that human brains intuitively perceive segmentation between parts, and for analogy to existing symbolic uses of the same glyphs in computing, mathematics, and general use.

And yet these choices are not ideal. Mechanically and visually, it would be much preferable to use some of the hundreds of symbolic glyphs already defined in the Unicode standard, which are visually distinct and not widely used in other contexts, and so unlikely to be used within identifier segments themselves, or for other confounding purposes in data serialization and transfer. But at this time, these other characters would be culturally unfamiliar to most contemporary users and difficult for them to type even if they became familiar with them. 

And so we may hope that the current common schema may be superseded in the future by a more effective choice of delimiting characters, when the simple fact of keyboard layout or other input methods makes it easier for humans to express them. 

By defining the identifier primitives and comparison relations independent of any particular serialization method, the nomo standard allows humans to make different serialization choices over time while maintaining backwards compatibility so that serializations under differing or obsolete schemas are still easy to process.

#### 3.1.6 Platform independence
 
As a special case of the goal of durability, nomo identifiers are designed to be independent of any institutional or technical platform, or even from any physical medium. A QRN in the abstract has nothing to do with the internet, Unicode, or computers in general. For example, a glyph set can be defined as a set of audio tones (physical vibration frequencies), an audio-based schema could add certain tones or percussive sounds to be used as delimiters, and identifiers can then be constructed from those tones which can be produced (sung or played) and consumed (heard or recorded) by both humans and machines with high fidelity. Likewise with colors, with hand motions, or any other physical pattern which can be produced and consumed by interacting parties.

This makes nomo identifiers intentionally distinct from contemporary semantic identifiers such as domain names, URNs, or RDF, all of which are explicitly defined as embedded in a particular technical context - the contemporary internet, arbitrated by the IANA and other institutions, constrained and even defined by particulars of serialization. 

The common schema does provide practical decisions useful for applying nomo to contemporary computing contexts, making common-schema-encoded QRNs a practical alternative to URNs, or to myriad other domain- or platform-specific semantic identifier schemes.
 
### 3.2 Use cases

nomo is designed to be immediately useful in a number of contemporary distributed computing contexts:

- Identifying a security principal among all possible security principals in all possible systems
- Identifying an entity within a versioned data model from among all possible versions of all possible data models
- Identifying a configuration setting from among all possible named values
- Identifying a service or service node from among all possible services or nodes

nomo is intentionally designed to also be applicable to non-computing uses cases, such as:

- Identifying a physical asset
- Identifying a version of a section of a law, ordinance, or other rule as established or proposed in a jurisdiction
- Identifying a chemical, genome, or other well-defined scientific entity
- Identifying a version of a highly specific industry standard, such as a particular standard parameter set for a type of fastener

## 4. Identifier Primitives

nomo identifier primitives are abstract ontological or mathematical concepts. They do not imply or require anything with regards to implementation, and impose no constraints besides those explicitly noted. Practical orthographic and protocol decisions for an implementation of QRNs in distributed computing is provided in the [common schema](#6-common-schema).
 
nomo defines the following identifier primitives:

  - [**glyph type**](#41-glyphs) - A single unique symbolic datum
  - [**glyph set**](#41-glyphs) - A set of glyph types
  - [**glyph**](#41-glyphs) - A representation of a glyph type 
  - [**string**](#42-string) - A sequence of zero or more glyphs from a glyph set
  - [**name**](#43-name) - A sequence of zero or more strings
  - [**value**](#44-value) - A compound primitive
  - [**qualified resource name**](#45-qualified-resource-name) - A composition of names and values that constitutes a complete identifier

### 4.1 Glyphs

A nomo **glyph type** is a single symbolic datum which can be consistently represented and recognized. A **glyph set** is a set of one or more distinct glyph types. A **glyph** is an instance of a physical representation of a glyph type. 

All these definitions imply a means to determine first whether any given glyph corresponds to a glyph type within a particular set, and second whether any two glyphs correspond to the same glyph type.

#### 4.1.1 Characters

In most use cases immediately contemplated by the authors, a glyph type means either a specific integer or an orthographic datum: a shape that can be recognized and distinguished by some biological or synthetic visual system. A distinct orthographic shape is usually called a character.

Likewise in these use cases a glyph set means a range or finite set of integers, or a finite set of distinct orthographic shapes (characters).

Character encodings used in contemporary computing provide mappings between integers and orthographic shapes, so that in practice a glyph set is understood by a computer as a set of integers, while the same glyph set is understood by a human as a set of characters. The character encoding provides the mapping between the two sets.

#### 4.1.2 Alternative mediums

The term glyph implies a two-dimensional pattern in the manner of a character in a human natural writing system, but any pattern in any medium that can be consistently reproduced and recognized can be used as a glyph type. As glyphs are the atoms of which all nomo identifiers are built, nomo identifiers of any complexity can likewise be constructed or evaluated in any medium which can be used to express and recognize glyphs.

#### 4.1.3 Collation and comparison

Many natural writing systems have cultural rules about the ordering of written characters, or about equivalence between different representations of the "same" character. nomo recognizes no such rules. Each glyph type is strictly distinct from every other glyph type in a glyph set. The only meaningful evaluation between two glyphs types or glyphs is whether they are the same or different.

#### 4.1.4 Compatibility and equivalence

Two distinct glyph sets are **compatible** if there is defined an unambiguous mutual mapping between at least one glyph type in one set with a glyph type in the other set. Two distinct glyph sets are **fully compatible** if both sets have the same count of glyph types, and for every glyph type in one set there exists an unambiguous mutual mapping to one glyph in the other set.

Between compatible glyph sets, a mutually mapped glyph type is one set is **equivalent** to the glyph type in the other set to which it is mapped, and vice versa. 

When comparing two identifiers, where the respective glyph sets of the two identifiers are compatible, a particular glyph in one identifier is **equivalent** to a particular glyph in another identifier if the glyph type that the glyph in the first identifier represents is equivalent to the glyph type which the glyph in the other identifier represents.

### 4.2 String

A nomo **string** is a sequence of zero or more glyphs. This implies the selection of a particular glyph set from which the ordered glyphs of the string must be chosen.

The term "string" is chosen for agreement with common usage in computing, but again does not imply any constraint on the medium used to define a glyph set or compose as string. The only defining feature of a string is that it is a finite sequence of glyphs. An algorithm that produces a finite sequence is not a string, but the sequence it produces is. An empty string of zero glyphs is a valid nomo string. Serializations of such strings generally require delimiters for disambiguation, but the underlying string is defined as the (empty) sequence itself.

The only meaningful evaluation between two strings is whether they are the same or different. Two strings are the same if any only if:

 - The glyph sets of the two strings are the same or are compatible 
 - The two strings have the same number of glyphs
 - For all *n* from 1 to the length of the strings, the glyph at ordinal *n* in one string is the same or equivalent to the glyph at the same ordinal in the other string

All strings have the property of length, but length has no significance within nomo.

In the special case of zero-length strings, two strings are the same if and only if their respective glyphs sets are the same or compatible. Conversely, zero-length strings of two incompatible glyph sets are not the same.

### 4.3 Name

A nomo **name** is a sequence of zero or more strings, where all strings use the same glyph set. Each string within a name is called a **segment**. Names provide an additional dimension of semantic representation beyond the choice and ordering of glyphs within a single string.

The name concept itself does not include intrinsic meaning about the selection or ordering of strings within a name. It instead provides a primitive mechanical feature which may be used by humans to represent any number of meanings.

In other words, a name definitely specifies the ordering of its segments, but only humans or other parties have any opinion about what that ordering "means".

The only meaningful evaluation between two names is whether they are the same or different. Two names are the same if any only if:

 - The glyph sets of the two names are the same or are compatible 
 - The two names have the same number of segments
 - For all *n* from 1 to the count of segments, the string of segment *n* in one name is the same as the string of segment *n* is the other name, according to the rules described in [4.2 String](#42-string)

All names have the property of count (the number of constituent segments) and of total length (the sum of the lengths of the constituent segment strings). Neither of these properties has any significance within nomo.

Two names composed solely of zero-length segments are the same if and only if they have the same count of segments, and the glyph sets of the names are the same or compatible.

### 4.4 Value 

A value is a compound primitive datum composed of one of the following:

- **string** - A single [string](#42-string) as defined above
- **tuple**  - An sequence of values
- **map**    - An unordered set of key-value pairs
- **null**   - The absence of any value

The values of a tuple may themselves be string, tuple, map, or null values.

Within a map, the key of each key-value pair is a string, while the value may be a string, tuple, map, or null. The keys within a map must be unique. Uniqueness is strictly defined according to the string comparison rules described above (see [4.2 String](#42-string)).

Values provide broad extensibility to the qualified resource name concept by providing structures that humans may use to express a wide variety of meanings.

Two values are equal if and only if they are composed from the same or compatible glyph sets, they have the same type (string, tuple, map, or null), and the constituent parts of the value are also equal according the following rules:

#### 4.4.1 String equality
The sameness of two strings is defined in [4.2 String](#42-string)

#### 4.4.2 Tuple equality 
Two tuples are equal if and only if:

 - The glyph sets of the two tuples are the same or are compatible 
 - The two tuples have the same number of elements
 - For all *n* from 1 to the count of elements, the value of element *n* in one tuple is the same as the value of element *n* is the other tuple, according to the rules described in this specification.

A **name** therefore **is** a tuple where all the values are strings, and likewise a tuple where all the values are strings **is** a name. The null value is not a string, so a tuple which contains a null element is not a name, and likewise a name can contain an empty string segment but cannot contain a null segment.

#### 4.4.3 Map equality

Two maps are equal if and only if:

 - The glyph sets of the two maps are the same or are compatible 
 - The two maps have the same number of key-value pairs
 - For each key *k* in one map, the same key exists in the other map, and the value associate with *k* in the first map is the same as the value associated with *k* in the other map, according to the rules described in this specification.

#### 4.4.4 Null equality

Two null values are equal if and only if the glyph sets of the values are the same or equivalent. 

#### 4.4.5 Empty values

All values have a type - string, tuple, map, or null. The string, tuple, and map types each have an empty value - a string with zero glyphs, a tuple with zero values, or a map with zero key-value pairs. As noted above, for two values to be considered equal they must have the same type and the same or compatible glyph sets. Therefore, even for the same glyph set, the empty string, empty tuple, and empty map, and are three distinct values. In addition, the null value has a different type and is therefore a distinct value not equal to any of the empty values of the string, tuple, or map types.

### 4.5 Qualified Resource Name

A nomo **qualified resource name** (QRN) is a composition of other nomo primitives whose parts are chosen to correspond directly to concepts in set theory. 

A QRN is composed of the following parts, all of which are optional. All parts in a QRN must use the same glyph set:

|Part|Type|Description|
|-|-|-|
|**authority**|**string**|An arbitrary string identifying the universe of the set. In general, the principal which declares the identifier|
|**set name**|**name**|The identifier of the **set** itself|
|**set key**|**value**|A further qualifier on the identity of the **set** itself|
|**group name**|**name**|The identifier of a proper **subset** within the set|
|**element name**|**name**|The identifier for a specific **element** within the set|
|**element key**|**value**|A further qualifier on the identity of an **element** within the set|

#### 4.5.1 Authority

The authority is the root disambiguating context of a qualified resource name. nomo itself intentionally does not provide any opinion or mechanism for allocating authority strings. Assignment, agreement, or proof of ownership of some particular authority string is an authentication concept outside the scope of nomo.

#### 4.5.2 Set

The set name and key represent the identifier of a set itself. The primitive QRN concept does not require that a set name be present if a set key is present.

When both a set name and a set key are present, the QRN concept itself defines this to mean that the set name represents a set of sets which share some unifying character or attribute, while each unique key value appended to the set name represents a specific instance of such a set. 

A common intended usage is to use the set name to denote a software, data, or administrative concept domain, and the key to denote a specific version of that domain.

#### 4.5.3 Group

The group name represents the identifier of a proper subset within the set identified by the set name and/or key. A QRN containing only a group name expresses the concept of an identified subset independent of any particular set to which it may belong.

#### 4.5.4 Element

The element name and key represent the identifier of a specific element within the set identified by the set name and key or the subset identified by the group name. The primitive QRN concept does not require that an element name be present if an element key is present.

When both an element name and an element key are present, the QRN concept itself defines this to mean that the element name represents a set of elements which share some unifying character or attribute, while each unique key value appended to the element name represents a specific instance of such an element.

A QRN containing only an element name or key represents the concept of an identified element independent of any particular set or subset to which it may belong.

A common intended usage is to use the element name to denote a resource collection and element key to identify a specific resource within that collection: colloquially, to identify a table with the element name and a row within that table with the element key.

#### 4.5.5 Empty and Missing Parts

As section [4.4.5 Empty Values](#445-empty-values) describes, the null value is not the same as the empty value of string, tuple, or map. It follows that the empty value of a given part of a QRN is not the same as a missing value for the same part: a QRN may include an authority whose value is the empty string of the glyph set used by the QRN, and this is different from a QRN which uses the same glyph set but has no authority part.

An explicit null value for a set key or element key is defined to have the same meaning as a missing key part.

#### 4.5.6 Equality

Two QRNs are the same if and only if:

 - The glyph sets of the two QRNs are the same or are compatible 
 - The two maps have the same number of key-value pairs
 - For each of the six parts of a QRN, the part is undefined in both QRNs, OR the part is defined in both QRNs and the corresponding values are the same according to the rules defined in this specification

### 4.7 Relations

nomo does not assign any semantic meaning to the respective segments **within** a name, elements of tuple key, or named elements of a map key. 

For example, consider a domain name such as `mail.example.com` as represented by a nomo name with the ordered segments [`mail`, `example`, `com`]. The internet domain name system as centrally coordinated by IANA explicitly does define subset semantics such that `mail.example.com` is definitely a "subdomain" of `example.com`, which is itself a member of the "top level domain" `com`.

But nomo itself defines no relationship between the names [`mail`, `example`, `com`], [`example`, `com`], and [`com`]. It only concludes that they are different names.
 
nomo itself **does** define the following relationships between QRNs that share certain parts. For convenience QRNs are represented using the [common schema](#6-common-schema), but relations hold regardless of the medium or glyph sets used by two QRNs. The asterisk used below does not have a special meaning in the common schema itself, but is used here to indicate any non-empty part following the preceding defined part.

#### 4.7.1 Authority relations

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`A/`|`∩`|`B/`|`=`|`∅`|The domains of any two non-empty authorities are disjoint|
|`A/*`|`∈`|`A/`|||All identifiers relative to an authority are in the authority's domain| 

By definition, no possible identifier relative to authority `A` is in the set of possible identifiers relative to authority `B`. Conversely, all possible identifiers relative to a given authority string are considered in the same domain -- namely, the identifier domain denoted by that authority string.
  
#### 4.7.2 Set relations
  
##### 4.7.2.1 Unkeyed sets

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`x::`|`∩`|`y::`|`=`|`∅`|The domains of two set names are disjoint|
|`x::*`|`∈`|`x::`|||All subsets and elements relative to a set name without a key are in the set denoted by that unkeyed set name|
  
##### 4.7.2.2 Keyed sets

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`x[1]::`|`∩`|`x[2]::`|`=`|`∅`|The sets denoted by two different key values relative to the same set name are disjoint|
|`x[1]::*`|`∈`|`x[1]::`|||All subsets and elements relative to a set name with a key are in the set denoted by that keyed set name|
 
##### 4.7.2.3 Relation between keyed and unkeyed sets

The relation between a QRN with a keyed set name and a QRN with an unkeyed set name is more subtle, but is still well defined.

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`x[*]::`|`∈`|`x::`|||All set keys relative to the same set name are in the same set of sets denoted by the set name without a key|
|`x::*`|`∩`|`x[*]::`|`=`|`∅`|The subsets and elements relative to a set name without a key are disjoint the the set of keyed sets relative to that same set name|
|`x::*`|`∪`|`x[*]::`|`≡`|`x::`|The union of the subsets and elements relative to a set name without a key with the set of keyed sets relative to that same set name exactly equals the entire set of possible identifiers relative to the unkeyed set name.<br><br>In other words, the subsets and elements relative to an unkeyed set name along with the set of keyed sets relative to that set name form a partition over the possible identifiers relative to the unkeyed set name.|

#### 4.7.3 Group relations

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`g:`|`∩`|`h:`|`=`|`∅`|The domains of two group names are disjoint|
|`g:*`|`∈`|`g:`|||All identifiers relative to a group name are in the group's domain| 

#### 4.7.4 Element relations

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`e`|`∩`|`f`|`=`|`∅`|The domains of two element names are disjoint| 
|`e[1]`|`∩`|`e[2]`|`=`|`∅`|The domains of two element key values relative to the same element name are disjoint |
|`e[*]`|`∈`|`e`|||All element keys relative to the same element name are in the same set of elements denoted by the element name without a key|

### 4.8 User-defined QRN Semantics

nomo itself defines no semantics or relations between identifiers other than those described above. This does not prevent parties from agreeing on their own semantics for relations between identifiers that the underlying standard simply recognizes as not the same. 

A common use case here, for elements within keyed and unkeyed set names, is to express the identity of a concept in general in association or contrast with the identity of that "same" concept within one or more specific "versions" of a concept collection.

Example:

|||
|-|-|
|`ecma/es::types:object`|The `Object` type in general across all versions of ECMAScript (JavaScript)|
|`ecma/es[1]::types:object`|The `Object` type with features and APIs specifically as defined in the first edition (1997) spec|
|`ecma/es[11]::types:object`|The `Object` type with features and APIs specifically as defined in the eleventh edition (2020) spec|

nomo itself defines only that
- all three QRNs above are different from each other
- all three QRNs above are in the domain of possible identifiers relative to the unkeyed set `ecma/es::`
- the group and element parts of all three QRNs (`types:object`) are identical

Humans are free outside of nomo to recognize or even formally define a semantic equivalence or relatedness between the three identifiers as all relating to the concept of the `Object` type within JavaScript / ECMAScript.

## 5. Schema Primitives

[Section 4](#4-identifier-primitives) defines the abstract primitives from which any nomo identifier can be constructed and compared. Most practical uses of identifiers require two additional concepts: **Serialization** and **validation**. A set of associated serialization and/or validation rules is called a **schema**. 

### 5.1 Schema Members

This section defines the abstract parts of any schema.

#### 5.1.1 Identifier-strings

nomo defines the following schema compound string types, all of which include any delimiters or other annotation glyphs as required to characterize the underlying identifier which the string encodes. A string of any of these types can be called an identifier-string:

  - [**name-string**]() - A [**name**](#43-name) mapped to a single string
  - [**tuple-string**]() - A [**tuple**](#44-value) value mapped to a single string
  - [**map-string**]() - A [**map**](#44-value) value mapped to a single string
  - [**qrn-string**]() - A [**QRN**](#45-qualified-resource-name) mapped to a single string

#### 5.1.2 Schema Operations

In addition, nomo defines the following schema primitive operations:

  - [**encode**]() - Map a structured identifier to an equivalent representation as a single identifier-string
  - [**decode**]() - Map a single identifier-string to the one structured identifier it represents
  - [**validate**]() - A deterministic algorithm that can take any identifier primitive and determine whether it is valid or invalid according to some internal rule set

##### 5.1.2.1 Encoding Parameters

The encode operation may include parameters that affect how an identifier is mapped to an identifier-string. Examples could include parameters determining how aggressively escaping or delimiting is applied, or whether non-significant whitespace is included in the output. 

Any parameters defined must have a default value. All possible combinations of valid parameters must produce identifier-strings that decode back to the same input identifier. All possible combinations of valid parameters must be deterministic: the same input identifier plus the same parameters must always produce the same identifier-string.

The decode and validate algorithms may not define parameters.

### 5.2 Schema Composition

A **schema** is composed of the following:

- An **identifier glyph set**: The glyph set used for identifiers
- An **encoding glyph set**: The glyph set used by identifier-strings
- A **encode algorithm**: A deterministic algorithm that transforms each unique valid identifier to exactly one unique identifier-string
- A **decode algorithm**: A deterministic algorithm that transforms each valid identifier string to the the underlying identifier it represents
- An *optional* **validate algorithm**: A deterministic algorithm that accepts any identifier and judges whether it is valid or not. The rules for what is "valid" are provided by the validate algorithm itself, but the rules must be deterministic and the outcome must depend solely on the content of the input identifier.

If a schema includes no explicit **validate algorithm**, then all possible identifiers composed from the identifier glyph set are valid. Common schema validation rules might prohibit empty values or certain subsequences of otherwise allowed glyphs, or might require that certain parts of a QRN be either defined or undefined. Regardless, a validate algorithm must be deterministic and based solely on the input identifier.

#### 5.2.1 Identifier-string equivalence

Both the encode and decode algorithms must be deterministic. The rules defined in [section 4](#4-identifier-primitives) strictly define whether two identifiers are considered equal. The same strict rules of equality as defined in [4.2 Strings](#42-string) apply to identifier-strings as well.

None of these constraints prevents the existence of multiple valid encodings (identifier-strings) of the same identifier. Mechanisms such as *escape sequences* or allowance of for whitespace included in many practical schemas allow many distinct identifier-strings to deterministically decode to the same underlying identifier. As noted above, the encode algorithm for a schema may include parameters which intentionally yield different identifier-strings for the same input identifier. In addition, other parties or mechanisms may construct multiple distinct identifier-strings that will be decoded to the same identifier.

Regardless, the decode algorithm must be deterministic and may not define parameters. One identifier may map to many identifier-strings, but all those identifier strings must map back to the same single identifier.

Two identifier strings are therefore **equivalent** if they decode to the same identifier, even if the identifier-strings themselves are not equal. By definition, two identifier-strings that are equal are also equivalent.

#### 5.2.2 Identifier-string validity

The definition of a schema does not include an algorithm for validating an *identifier-string* directly, as this is a redundant. Any identifier-string is valid if it can be unambiguously decoded to an identifier, and the resulting identifier is valid according to the validate algorithm of the schema.

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

#### 5.2.4 Glyph set compatibility

There is no requirement that the two glyph sets for a schema (identifier glyph set and encoding glyph set) be compatible; they need not even be defined in the same medium.

Even for the usual case where both glyph sets are defined in the same medium and where there is partial compatibility (some glyph types in the identifier set are the same or equivalent to some glyph types in the encoding set), it is likely that the identifier glyph set will include glyph types that are not allowed in the encoding glyph set, and likewise the encoding glyph set may include delimiting glyph types that are not included in the identifier glyph set. 

Glyph types that are allowed only in the identifier set are generally decomposed or escaped to multiple glyphs in the resulting identifier-string, while delimiters in an identifier-string are always eliminated completely in translation to a structured identifier. Insignificant whitespace glyphs in an identifier-string would also be eliminated during decoding.

Finally, the prohibition on outside parameters for the decode algorithm does not prevent the inclusion of glyphs in an identifier-string itself that function as control features which determine how all or part of the identifier-string is interpreted during decoding. Image for example a schema that allows identifier-strings to begin with the sequence `L:`, which is omitted from the resulting identifier but which causes all glyphs in the source identifier-string to be decoded as the lower-case equivalent of the source glyph.

### 5.3 Semantic Standards

It is intended and expected that cooperating parties will also find it useful to agree on standard *semantics* to require for certain situations. Extending the JavaScript example from [4.8 User-defined QRN Semantics](#48-user-defined-qrn-semantics), one could imagine an inter-language working group deciding on a codified, QRN-based standard for identifying the components of different language specifications, for the purposes of facilitating human research, automated transpilation, or other goals.

To the extent that the resulting standards can be expressed as mechanical glyph sets and algorithms as described in [5.1 Schema](#51-schema), such a schema is a nomo concern. Any and all of the infinite range of possible administrative, mechanical, and semantic rules which could be layered on top are and shall remain outside the scope of nomo.
 
## 6. Common Schema

This section describes an instance of a [schema](#5-schema-primitives) intended for immediate use in distributed computing and general human communication. It is defined strictly in relation to the digital standard Unicode, but should also be functional for printed or even hand-written use cases.

The common schema is based on the [Unicode](https://home.unicode.org/) standard for its glyph sets. This is intentionally ambiguous with regards to Unicode version; the exact set of code points and characters recognized will depend on the version of Unicode used by interacting parties.

### 6.1 Identifier Glyph Set

The identifier glyph set of the common schema is all code points included in the Unicode character classes L (Letter), M (Mark), N (Number), P (Punctuation), and S (Symbol) which are preserved under Unicode [normalization form C](https://www.unicode.org/reports/tr15/tr15-53.html#Norm_Forms) (**c**omposition / NFC), plus the single simple space character (U+0020). 

### 6.2 Encoding Glyph Set

The encoding glyph set of the common schema is all code points included in the [Unicode](https://home.unicode.org/) character classes L (Letter), M (Mark), N (Number), P (Punctuation), and S (Symbol), plus the single simple space character (U+0020).

For digital encoding, all common schema identifier-strings must use UTF-8.

### 6.3 Encode

Any common schema identifier is encoded using the following general algorithm:

1. Sort any maps
2. Convert each string segment to its corresponding NFD form
3. Escape strings 
4. Delimit strings
5. Recursively encode structured values
6. Compose encoded parts

#### 6.3.1 Sort maps

Before performing any other operations, sort any map values contained in the identifier by sorting the keys in strict code-point order.

#### 6.3.2 Convert strings to NFD

All nomo identifiers are composed of strings. Compound structures such as tuples, maps, and names are ultimately composed solely of strings or null values. For each component string of an identifier, convert that string to its normalization form D, as defined in the Unicode standard.

#### 6.3.3 Escape strings

Insert a single backslash (`\`, `U+005C`) character before any existing instance of either an apostrophe (`'`, `U+0027`) or backslash (`\`, `U+005C`) and any string.

#### 6.3.4 Delimit strings

Enclose any string in a pair of single-quote / apostrophe characters (`'`, `U+0027`) if the string is empty (zero-length), or if it contains any of the following code points:

|Code||Description|
|-|-|-|
|U+0020|` `|Space|
|U+0022|`"`|Quotation|
|U+0027|`'`|Apostrophe|
|U+0028|`(`|Left parenthesis|
|U+0029|`)`|Right parenthesis|
|U+002C|`,`|Comma|
|U+002E|`.`|Period|
|U+002F|`/`|Slash / Solidus|
|U+003A|`:`|Colon|
|U+003C|`<`|Less-than sign|
|U+003D|`=`|Equal sign|
|U+003E|`>`|Greater-than sign|
|U+005B|`[`|Left square bracket|
|U+005C|`\`|Backslash|
|U+005D|`]`|Right square bracket|
|U+007B|`{`|Left curly brace|
|U+007D|`}`|Right curly brace|

#### 6.3.5 Encode structures

##### 6.3.5.1 Names

Encode each **name** value in the set name, group name, or element name by concatenating its parts in order, separated by a single period (`.`, `U+002E`) between each pair of segments. If the entire identifier is a name outside the context of a QRN, encode it the same way.

##### 6.3.5.2 Tuples

Encode each **tuple** value as follows (except for names as already encoded in the previous section):

 1. Recursively encode each of the tuples' elements per the rules in this [section 6.4](#64-encode-structures).
 2. Concatenate the elements in order, separated by a single comma (`,`, `U+002C`) between each pair of elements.
 3. Enclose the concatenated elements with a matching pair of parenthesis (`(`, `U+0028` and `)`, `U+0029`) unless the tuple has at least two values, and is the top-level value of a set or element key.

##### 6.3.5.3 Maps

Encode each **map** value as follows:

  1. Recursively encode the value of each key-value pair per the rules in this [section 6.4](#64-encode-structures).
  2. For each key-value pair, concatenate the pair into a single string consisting of the key, followed by the equal sign (`=`, `U+003D`), followed by the encoded value
  3. Concatenate the encoded key-value pairs in the order already set in step 1 of encoding, separating each pair of encoded key-value pairs with a single single comma (`,`, `U+002C`).
  4. Enclose the concatenated key-value pairs with a matching pair of curly braces (`{`, `U+007B` and `}`, `U+007D`) unless the map is the top-level value of a set or element key.

##### 6.3.5.4 Nulls

Null values are omitted from the encoded identifier-string. The presence of a null value as an element of a tuple, or value of a key-value pair of a map, is unambiguously denoted by the surrounding delimiters in the encoded identifier-string.

#### 6.3.6 Encode keyed names

If the identifier has a defined, non-null set key, enclose its encoded value with a matching pair of square brackets (`[`, `U+005B` and `]`, `U+005D`) and append it to the encoded set name, if any.

If the identifier has a defined, non-null element key, enclose its encoded value with a matching pair of square brackets (`[`, `U+005B` and `]`, `U+005D`) and append it to the encoded element name, if any.

#### 6.3.7 Compose

Finally, compose the completed identifier-string through the following operations:

1. If the authority part is defined, append a single slash (`/`, `U+002F`) to its encoded value
2. If the set part is defined, append two colons (`::`, `U+003A + U+003A`) to its encoded value
3. If the group name is defined, append a single colon  (`:`, `U+003A`) to its encoded value
4. Concatenate all parts in order: authority, set, group, element
5. If the entire encoded QRN is an empty string, because all parts of the QRN are undefined, then enclose the (empty) QRN in a matching pair of angle brackets (`<`, `U+003C` and `>`, `U+003E`). In this case the entire fully-encoded QRN is the value `<>`.

This concludes the encode algorithm.

#### 6.3.8 Manual encoding

Automated implementations of the common schema *must* follow the deterministic steps described above, applying enclosing or delimiting characters only when specified in the preceding steps. However, identifier-strings constructed directly may include the following valid alternatives forms that would not be produced by the encode algorithm:

- A string value *may* always be enclosed in single quotes / apostrophes, even if it does not contain any of the characters listed in [section 6.3.4](#634-delimit-strings)
- A tuple value *may* always be enclosed in parenthesis, even if it is the top-level value of a set or element key
- A map value *may* always be enclosed in curly braces, even if it is the top-level value of a set or element key
- An entire QRN value *may* always be enclosed in angle brackets, even if it has one or more defined parts

### 6.4 Decode

A common-schema identifier-string is decoded using the following general algorithm:

1. Tokenize the identifier-string
2. Validate and group structures
3. Assign structures to parts
4. Unquote strings
5. Unescape strings

More efficient streaming or stack-based algorithms can be defined, but are left to implementers.

#### 6.4.1 Tokenization

An input identifier-string can be naively tokenized as follows.

1. Identify all `delimited-string` tokens

   Scanning the characters of the complete identifier-string in order, an apostrophe (`'`, `U+0027`) denotes the beginning of a `delimited-string` and is included in the `delimited-string` token. All subsequent characters belong to the `delimited-string` until another apostrophe is encountered, unless that apostrophe is immediately preceded by a backslash (`\`, `U+005C`). The first subsequent *non-escaped* apostrophe encountered denotes the end of the `delimited-string`, and is included in the `delimited-string` token. If the end of the identifier-string is reached without encountering a non-escaped apostrophe, the identifier-string is invalid.

2. Identify remaining `string` and `symbol` tokens

   Re-scanning the characters of the complete identifier-string in order:
   
   - If the character is already part of a `delimited-string` token, ignore and continue
   - If the character is any character in the table in [section 6.3.4](#634-delimit-strings), it is a single-character `symbol` token
   - Otherwise, the character is the first character of a `string` token. The `string` token contains all contiguous subsequent characters that are not already part of a `delimited-string` token and are not in the table in [section 6.3.4](#634-delimit-strings)

The above simple algorithm will divide all characters in the input identifier-string into a series of `symbol`, `string`, and `delimited-string` tokens.

#### 6.4.2 Validate and group structures

The following naive algorithm gradually groups tokens into larger structures:
 
```
let state  := 'none'

foreach(token of tokens)
  switch(state)
    case 'none':
      if 
```

# Appendices

## A1. Theoretical Background

nomo is based on three theoretical concepts: finite sequences, discrete patterns, and perfect coherence.

A finite sequence is a well-defined mathematical concept that is also easy to intuit. Informally, it's an ordered list. 

Formally, it is a countable, finite set of zero values, exactly one value, *or* of multiple values where all possible pairs of values have an unambiguous relationship such that one of the pair comes *before* the other, there is a first value, and there is a last value.

Pattern and coherence have philosophically independent definitions, but for the practical application of nomo they are defined in mutual reference:
 
- A pattern is any physical phenomenon or configuration that can be distinguished as itself and as distinct from other potential patterns and from a lack of pattern
- Coherence is the degree to which a system which can recognize the sameness or difference of a given pattern, or the degree to which a system can produce a pattern which has a quality of sameness or difference to some reference pattern

Most concepts expressed in natural language are coherent but not perfectly so. The English word "bird" maps to some abstract pattern represented in neurons in both humans and other biological systems, in various synthetic information systems, and to words in other human languages. This pattern is coherent -- there is sufficient practical overlap between the infinitely varied representations of that "same" concept or abstraction to allow productive cooperation between parties. 

And yet no two brains have exactly the same representation of "bird", either as a phonetic word or as an abstract concept. There is no objective, agreed upon boundary between what range of sounds can be recognized as "bird" and where such sounds become meaningless noise, or some other know word ("bard?", "bored"? "beard"?, etc.). And there is no objective, agreed-upon boundary between which visual representation, which motion, even which physical thing marks the exact boundary of what can be described as "bird" and what cannot.




nomo is concerned only with patterns that can be reproduced with perfo, so that a pattern only exists to the extent it can be consistently produced or consumed, and correlation exists only to the extent a pattern being correlated can be identified.

### A1.1 Pattern
 
nomo is further concerned only with patterns that are discrete and communicable, and whose sole characteristic is their uniqueness -- the fact that they can be identified as "this one", "that one" or "not any of them". 

#### A1.1.1 Discreteness

A pattern is discrete if it is discontinuous and distinguishable from other potential patterns.

Natural colors both in human semantics and in physical reality are non-discrete. There is no discontinuous phase-boundary separation between "red" and "not-red" or between "exactly this wavelength" and "not exactly this wavelength", let alone to between various relative combinations of wavelength intensity that humans perceive as color.

In contrast, integers are inherently discrete. They are countably infinite, but each single integer is distinctly the same as itself and different from all other integers.

However, whether a pattern is discrete in practice depends on choices of constraint and implementation.

Color as physical measure of photon wavelength or of relative ratios of mixed photon wavelengths is non-discrete, but this does not prevent humans from choosing a discrete set of approximate colors such as "red", "green", and "blue", such that any wavelength or mixture of wavelengths can be consistently identified by photon-absorbing systems as belonging to one of these catagories or to none of them. We can make colors discrete in practice.

Likewise integers are intrinsically discrete, but the value of any given integer may be outside the range of some counting system implementation -- whether in the wetware of a human brain or in a mechanical system -- such that a sufficiently large integer cannot be reliably distinguished from one or more integers that are more or less. Integers become non-discrete if they exceed the precision or scale supported by a processing system.
 
#### A1.1.2 Communicability

nomo is a specification for identifiers: symbolic references to something else. They are only useful if the component patterns can be reproduced and recognized multiple times, usually by multiple pattern processing systems, including human brains. In other words, the components patterns must be communicable.

#### A1.1.3 Uniqueness

Any theoretical pattern could be defined or distinguished by any number of attributes. A letter could be bold or italic, large or small, written in one script or another. A spoken word can be loud or soft, bear any number of meaningful modulations, be spoken in one accent or another. All of these attributes are used in practice in human communication to distinguish between patterns which in turn distinguish between different meanings -- including identifiers.

nomo is instead exclusively concerned with whether an instance of some pattern can be identified as "this one", "that one", or "not any them". 

### A1.2 Correlation

Correlation is an emergent property of the interactions between a pattern and a pattern processing system. It is an abstract measure of how consistent the processing system is at recognizing or reproducing patterns.
 
Correlation is therefore a practical measure of communicability. 

#### A1.2.1 Perfection

Perfect correlation is a property of discrete patterns and associated pattern processing systems where exactly zero information is lost or changed through reproduction and recognition. It is analogous to superconductivity, where in some materials under certain conditions electrical resistance drops to exactly zero, allowing an electrical current to flow indefinitely with zero loss.

Perfect correlation is achievable with sufficiently distinct discrete patterns, such that the pattern can be reproduced and recognized an indefinite number of times with exactly zero information loss or corruption.

### A1.3 Implementation dependence

Whether and to what degree a choice of patterns or pattern processing systems fulfills the attributes above depends in practice on implementation choices. 





[Schemas](#5-schema-primitives) may include rules for mapping between serializations of an identifier and the identifier they encode, and those rules may allow for multiple distinct serializations of the same underlying identifier. In colloquial terms, a schema may allow the single glyph `A` to be serialized as either `A` or `a`.

Likewise mechanical implementations of any symbolic communication system include definitions or understandings of what ranges of physical manifestations constitute a correct and recognizable rendering of a glyph. 

Some of these may be describable analytically. For example, we could define the chromatic glyph "red" as any combination of photons as measured over some interval, discarding all photons with wavelengths greater than 750nm or less than 370nm, where at least 70% of the remaining photons have wavelengths between 680nm and 720±1nm.

Others may not be describable analytically. The characters used in human writing systems are almost impossible to describe analytically. Exactly how neat or complete does a set of markings have to be to still be recognized as "the letter A"? This is impossible to answer rationally or analytically. Despite this, wide phenomenological agreement between humans perceiving and producing these characters demonstrates that an objective, identifiable glyph exists.

All of this is outside the scope of nomo. nomo provides neither a definition nor a means of constructing a definition of a glyph, nor a means of distinguishing one glyph from another glyph from the absence of any glyph. nomo only defines primitives and compositions that constitute identifiers assembled from a set of glyphs provided as intrinsically undefined givens.


As noted [above](#46-relations) nomo defines no relationship between names, including when names are used as group names. [`com`, `sun`, `eng`] has no intrinsic relation to to [`com`, `sun`], but outside of nomo parties are free to [define such a relation](https://www.oracle.com/java/technologies/javase/codeconventions-namingconventions.html). Likewise [`eng`, `sun`, `com`] has no intrinsic relation to [`com`], but outside of nomo parties are free to [define such a relation](https://www.iana.org/domains).

---
##### Attribution

Author: Joshua Honig. Copyright 2022 Malva Open Technologies.