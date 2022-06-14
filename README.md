# nomo
 
#### versioning

|Part|Sections|Version|Date|
|-|-|-|-|
|Front matter|1-3| -- |2022-06-08|
|[Identifier primitives](#4-identifier-primitives)|4|`0.1.0`|2022-06-08|
|[Schema primitives](#5-schema-primitives)|5|`0.1.0`|2022-06-08|
|[Common schema](#6-common-schema)|6|`0.1.0`|2022-06-08|

## 1. Introduction

nomo is a standard for constructing identifiers that are unique, semantic, and mechanically easy to process. 

nomo describes identifiers that are not bound to any specific institutional or mechanical infrastructure, nor to any central authority. Disambiguation of the root `authority` string of any [qualified resource name](#45-qualified-resource-name) is intentionally not addressed by nomo.
 
The practical product of nomo is a suggested [common schema](#6-common-schema) for validating, parsing, and serializing [qualified resource names](#45-qualified-resource-name) and their component [primitives](#4-identifier-primitives). This schema is built on lower levels of specification which are described first.

nomo includes three modules of specification:

- [**Identifier primitives**](#4-identifier-primitives) - Abstract concepts that provide a mathematically complete description of an identifier
- [**Schema primitives**](#5-schema-primitives) - Abstract concepts that describe how identifier primitives may be validated, and may mapped to or from strings
- [**Common schema**](#6-common-schema) - An instance of a schema intended for general use in distributed computing

## 2. License
Unless explicitly identified otherwise in the contents of a file, the content in this repository is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license. As summarized in the [Commons Deed](https://creativecommons.org/licenses/by-sa/4.0/) and strictly defined in the [license](./LICENSE.md) itself: you may share or adapt this work, provided you give appropriate credit, provide a link to the license, and indicate if changes were made. In addition, you must preserve the original license. For the details and actual legal license, consult the [license](./LICENSE.md).

### 2.1 Source Code
The [license](#2-license) of this work is designed for cultural works, [not source code](https://creativecommons.org/faq/#can-i-apply-a-creative-commons-license-to-software). Any source code intended for more than an illustration should be distributed under an appropriate license by including that license in the applicable source code file, or by placing the source code file in another repository with an appropriate license.
 
## 3. Purpose 

nomo provides a consistent mechanism for constructing and evaluating identifiers, for the purpose of facilitating systematic cooperation between humans, and between humans and automated information systems.

nomo is designed to address situations where central allocation or arbitration of identifiers is impractical or undesirable, and yet it is useful or desirable that identifiers declared by unrelated parties be mutually intelligible and easy to disambiguate.

### 3.1 Characteristics 

In more detail, nomo identifiers are designed to achieve the following characteristics:
 
#### 3.1.1 Uniqueness

Uniqueness is an intrinsic goal of any identifier. nomo is designed to make it easy to construct identifiers that will not collide with other identifiers.

#### 3.1.2 Semantic clarity

Semantic clarity helps humans to compose, remember, and understand identifiers. 

The demand for semantic clarity precludes many contemporary unique identifier conventions such as [UUID / GUID](https://datatracker.ietf.org/doc/html/rfc4122), [Mongo ObjectId](https://www.mongodb.com/docs/manual/reference/method/ObjectId/), [XID](https://github.com/rs/xid), or similar constructions that are essentially serializations of a large random integer, with or without a time-based prefix.

#### 3.1.3 Mechanical clarity

Mechanical clarity helps both machines and humans to reliably determine whether or not two identifiers are equivalent or are related.

The demand for mechanical clarity precludes simply using unstructured natural language.

#### 3.1.4 Decentralization

nomo is designed to facilitate cooperation without the need for a central authority that arbitrates, authorizes, or allocates identifiers or identifier spaces.

To achieve mutual intelligibility, nomo defines identifier primitives along with deterministic rules for comparing them. 

To achieve decentralization, nomo provides two points where choice or implementation are left to cooperating parties to negotiate.

These two points of negotiation are the choice of [glyph set](#41-glyph-and-glyph-set), and authentication of the [authority string](#451-authority) of a [qualified resource name](#45-qualified-resource-name). 

The [common schema](#6-common-schema) specifies a well-known glyph set, and many methods exist for authenticating ownership of an identifier string.

##### 3.1.4.1 Negotiation - Glyph set

Two nomo identifiers declared by two different parties are mutually intelligible if and only if those two parties agree on the equivalence of or a mapping between the [glyph sets](#41-glyph-and-glyph-set) associated with the respective identifiers. 

Neither the identifier primitives nor schema primitives sections of the nomo standard provide any predefined glyph set, nor do they define any algorithm for establishing equivalence among potential glyph sets.

The [common schema](#6-common-schema) does specify a related pair of glyph sets: the widely used [Unicode standard](https://www.unicode.org/main.html). Unicode defines a set of positive integers, a set of visual shapes (characters), and a mapping between the two sets. For further detail, including rules for handling ambiguous mappings from characters to underlying code point integers, see [common schema](#6-common-schema).

##### 3.1.4.2 Negotiation - Authority string

The first level of qualification in a qualified resource name is the authority string. An authority string declared by one party is recognized by another party if and only if the recognizing party chooses to recognize it.

Even the [common schema](#6-common-schema) does not provide a mechanism for establishing or agreeing upon "ownership" of an authority string, which in the common schema is simply any valid sequence of one or more Unicode code points. The authors of this standard regard this as an authentication question which is delegated to any mechanism of authentication which cooperating parties agree to use. The name "authority" was chosen for concept equivalence to a forthcoming distributed authentication protocol described by the same authors of this standard, but nomo itself does not require or demand any particular choice of authentication system.

##### 3.1.4.3 Deterministic operations

**If** parties agree to recognize each other's respective glyph sets and authority strings, **then** nomo provides clear definitions so that the parties can understand the semantics of any identifier declared by any of the parties, and can deterministically answer whether any two identifiers are equivalent or are related in specific ways.

#### 3.1.5 Platform independence

#### 3.1.6 Durability

A second order goal of all the characteristics described above is that nomo identifiers may be durable over time and space. While the authors intend to solve some immediate problems in distributed computing, they also aim to provide a means of establishing identifiers that can be communicated, understood, and continuously used across changing cultural and political boundaries, over indefinitely long time spans. Prime examples here include identification of persons, properties, documents, or industry and scientific standards. 

Both for historical analysis and ongoing practical cooperation identifiers in those domains could be assigned to concepts that remain stable over many human lifetimes, amid changing political structures and natural languages.

Designing for durability is a key reason that the common schema included here is defined separately from the underlying primitives. One of the most important but also arbitrary decisions in that schema is the choice of characters used as delimiters between the serialized parts of a QRN, name, or key. The characters chosen (`/`, `:`, `,`, `.`, `=`, `[`, `]`) are a function of specific cultural and industrial conditions at the time of writing. Most importantly, these characters are available on the vast majority of computer keyboards in use at the time. From that limited set of potential glyphs, these were chosen for visual distinction such that human brains intuitively perceive segmentation between parts, and for analogy to existing symbolic uses of the same glyphs in computing, mathematics, and general use.

And yet these choices are not ideal. Mechanically and visually, it would be much preferable to use some of the hundreds of symbolic glyphs already defined in the Unicode standard, which are visually distinct and not widely used in other contexts, and so unlikely to be used within identifier segments themselves, or for other confounding purposes in data serialization and transfer. But at this time, these other characters would be culturally unfamiliar to most contemporary users and difficult for them to type even if they became familiar with them. 

And so we may hope that the current common schema may be superseded in the future by a more effective choice of delimiting characters, when the simple fact of keyboard layout or other input methods makes it easier for humans to express them. 

By defining the identifier primitives and comparison relations independent of any particular serialization method, the nomo standard allows humans to make different serialization choices over time while maintaining backwards compatibility so that serializations under differing or obsolete schemas are still easy to process.
 
### 3.2 Use cases

- Identifying a security principal among all possible security principals in all possible systems
- Identifying an entity within a versioned data model from among all possible versions of all possible data models
- Identifying a configuration setting from among all possible named values
- Identifying a service or service node from among all possible services or nodes

nomo is intentionally designed to also be applicable to non-computing uses cases, such as:

- Identifying a physical asset
- Identifying a version of a section of a law, ordinance, or other rule as established or proposed in a jurisdiction
- Identifying a version of a highly specific industry standard, such as a particular standard parameter set for a type of fastener

## 4. Identifier Primitives

nomo identifier primitives are abstract ontological or mathematical concepts. They do not imply or require anything with regards to implementation, and impose no constraints besides those explicitly noted. Practical orthographic and protocol decisions for an implementation of QRNs in distributed computing is provided in the [common schema](#6-common-schema).
 
nomo defines six identifier primitives:

  - [**glyph**](#41-glyph-and-glyph-set) - A single unique symbolic datum
  - [**glyph set**](#41-glyph-and-glyph-set) - A set of glyphs
  - [**string**]() - A sequence of zero or more glyphs from a glyph set
  - [**name**]() - A sequence of zero or more strings
  - [**key**]() - A compound primitive
  - [**qualified resource name**]() - A composition of names and keys that constitutes a complete identifier

### 4.1 Glyph and Glyph Set

A glyph is a single symbolic datum which can be consistently represented and recognized. A glyph set is a set of one or more distinct glyphs. Both definitions imply a means to determine first whether any given representation corresponds to a glyph within a particular set, and second whether any two representations correspond to the same glyph.

Glyphs are inherently abstract, while representations are tangible instances of "writing" or otherwise representing a particular glyph. The "latin capital letter A" is a singular idea, although it may be and has been represented countless times.

For convenience, throughout this specification the term "glyph" is used even where the meaning is a glyph representation. For example, "string" is defined above as "A sequence of zero or more glyphs". The meaning is that a string is a sequence of zero or more *glyph representations*, not a sequence of zero or more abstract concepts.

#### 4.1.1 Characters

In most use cases immediately contemplated by the authors, a glyph means either a specific integer or an orthographic datum: a shape that can be recognized and distinguished by some biological or synthetic visual system. A distinct orthographic shape is usually called a "character".

Likewise in practice a glyph set means a range or finite set of integers, or a finite set of distinct orthographic shapes (characters).

Character encodings used in contemporary computing provide mappings between integers and orthographic shapes, so that in a practice a glyph set is understood by a computer as a set of integers, while the same glyph set is understood by a human as a set of characters. The character encoding provides the mapping between the two sets.

#### 4.1.2 Alternative mediums

The term "glyph" implies a two-dimensional pattern in the manner of a "character" in a human natural writing system, but the nomo identifier primitives do not require that. Any pattern in any medium that can be consistently reproduced and recognized can be used as a glyph. As glyphs are the atoms of which all nomo identifiers are built, nomo identifiers of any complexity can likewise be constructed or evaluated in any medium which can be used to express and recognize glyphs. 

This does not guarantee that an identifier in one medium can be transcribed to any other medium, although in practice that can be accomplished with mappings between glyphs in one medium to glyphs in another. Humans routinely do this when verbally "spelling", which involves for one glyph at a time either visually recognizing a two dimensional pattern (a character) and then producing a physical waveform (speaking), or recognizing a physical waveform (hearing) and expressing a corresponding two dimensional pattern (a character) through a digital input device or manual writing instrument.

### 4.2 String

A nomo **string** is a sequence of zero or more glyph representations. This implies the selection of a particular glyph set from which the ordered elements of the string must be chosen.

### 4.3 Name

A nomo **name** is a sequence of zero or more strings. Names provide an additional dimension of semantic representation beyond the choice and ordering of glyphs within a single string.

The name concept itself does not include intrinsic meaning about the selection or ordering of strings within a name. It instead provides a primitive mechanical feature which may be used by humans to represent any number of meanings.

### 4.4 Key 

A key is a compound primitive datum composed of one of the following:

- **scalar** - A single value that can be represented as a string
- **tuple**  - An ordered set of values
- **map**    - An ordered set of key-value pairs

The values of a tuple key may themselves be scalar, tuple, or map values.

Within a map, the key of each key-value pair is a scalar, while the value may be a scalar, tuple, or map.

Keys provide broad extensibility to the qualified resource name concept by providing structures that humans may use to express a wide variety of meanings.

### 4.5 Qualified Resource Name

A nomo **qualified resource name** (QRN) is a composition of other nomo primitives whose parts are chosen to correspond directly to concepts in set theory. 

A QRN is composed of the following parts, all of which are conceptually optional:

|Part|Type|Description|
|-|-|-|
|**authority**|**string**|An arbitrary string identifying the universe of the set. In general, the principal which declares the identifier|
|**set name**|**name**|The identifier of the **set** itself|
|**set key**|**key**|A further qualifier on the identity of the **set** itself|
|**group name**|**name**|The identifier of a proper **subset** within the set|
|**element name**|**name**|The identifier for a specific **element** within the set|
|**element key**|**key**|A further qualifier on the identity of the **element** within the set|

#### 4.5.1 Authority

The authority is the root disambiguating context of a qualified resource name. nomo itself intentionally does not provide any opinion or mechanism for allocating authority strings. Assignment, agreement, or proof of "ownserhip" of some particular authority string is an authentication concept outside the scope of nomo.

#### 4.5.2 Set

The set name and key represent the identifier of a set itself. The primitive QRN concept does not require that a non-empty set name be present if a non-empty set key is present.

When both a set name and a set key are present, the QRN concept itself defines this to mean that the set name represents a set of sets which share some unifying character or attribute, while each unique key value appended to the set name represents a specific instance of such a set. 

#### 4.5.3 Group

The group name represents the identifier of a proper subset within the set identified by the set name and/or key. A QRN containing only a group name expresses the concept of an identified subset independent of any particular set to which it may belong.

#### 4.5.4 Element

The element name and key represent the identifier of a specific element within the set identified by the set name and key or the subset identified by the group name. The primitive QRN concept does not require that a non-empty element name be present if a non-empty element key is present.

When both an element name and an element key are present, the QRN concept itself defines this to mean that the element name represents a set of elements which share some unifying character or attribute, while each unique key value appended to the element name represents a specific instance of such an element. 

A QRN containing only an element name or key represents the concept of an identified element independent of any particular set or subset to which it may belong.

### 4.6 Relations

nomo does not assign any semantic meaning to the respective segments **within** a name, elements of tuple key, or named elements of a map key. 

For example, consider a domain name such as `mail.example.com` as represented by a nomo name with the ordered segments [`mail`, `example`, `com`]. The domain name system itself as centrally coordinated by IANA explicitly does define subset semantics such that `mail.example.com` is definitely a "subdomain" of `example.com`, which is itself a member of the "top level domain" `com`.

But nomo itself defines no relationship between the names [`mail`, `example`, `com`], [`example`, `com`], and [`com`]. It only concludes that they are different names. 
 
nomo itself **does** define the following relationships between QRNs that share certain parts. For convenience QRNs are represented using the [common schema](#6-common-schema). 

#### 4.6.1 Authority relations

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`A/`|`∩`|`B/`|`=`|`∅`|The domains of any two non-empty authorities are disjoint|
|`A/*`|`∈`|`A/`|||All identifiers relative to an authority are in the authority's domain| 

By definition, no possible identifier relative to authority `A` is in the set of possible identifiers relative to authority `B`. Conversely, all possible identifiers relative to a given authority string are considered in the same domain -- namely, the identifier domain denoted by that authority string.
  
#### 4.6.2 Set relations
  
##### 4.6.2.1 Unkeyed sets

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`A/x::`|`∩`|`A/y::`|`=`|`∅`|The domains of two set names are disjoint|
|`A/x::*`|`∈`|`A/x::`|||All subsets and elements relative to set name without a key are in the set denoted by that unkeyed set name|
  
##### 4.6.2.2 Keyed sets

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`A/x[1]::`|`∩`|`A/x[2]::`|`=`|`∅`|The sets denoted by two different key values relative to the same set name are disjoint|
|`A/x[1]::*`|`∈`|`A/x[1]::`|||All subsets and elements relative to set name with a key are in the set denoted by that keyed set name|
 
##### 4.6.2.3 Relation between keyed and unkeyed sets

The relation between a QRN with a keyed set name and a QRN with an unkeyed set name is more subtle, but is still well defined.

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`A/x[*]::`|`∈`|`A/x::`|||All set keys relative to the same set name are in the same set of sets denoted by the set name without a key|
|`A/x::*`|`∩`|`A/x[*]::`|`=`|`∅`|The subsets and elements relative to a set name without a key are disjoint the the set of keyed sets relative to that same set name|
|`A/x::*`|`∪`|`A/x[*]::`|`≡`|`A/x::`|The union of the subsets and elements relative to a set name without a key with the set of keyed sets relative to that same set name exactly equals the entire set of possible identifiers relative to the unkeyed set name.<br><br>In other words, the subsets and elements relative to an unkeyed set name along with the set of keyed sets relative to that set name form a partition over the possible identifiers relative to the unkeyed set name.|

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
- the group and element segments of all three QRNs (`types:object`) are identical

Humans are free outside of nomo to recognize or even formally define a semantic equivalence or relatedness between the three identifiers as all relating to the concept of the `Object` type within JavaScript / ECMAScript.

#### 4.6.3 Group relations

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`A/`|`∩`|`B/`|`=`|`∅`|The domains of two group names are disjoint|
|`A/*`|`∈`|`A/`|||All identifiers relative to a group name are in the group's domain| 

As noted [above](#46-relations) nomo defines no relationship between names, including when names are used as group names. [`com`, `sun`, `eng`] has no intrinsic relation to to [`com`, `sun`], but outside of nomo parties are free to [define such a relation](https://www.oracle.com/java/technologies/javase/codeconventions-namingconventions.html). Likewise [`eng`, `sun`, `com`] has no intrinsic relation to [`com`], but outside of nomo parties are free to [define such a relation](https://www.iana.org/domains).

#### 4.6.4 Element relations



## 5. Schema Primitives



## 6. Common Schema

---
##### Attribution

Author: Joshua Honig. Copyright 2022 Malva Open Technologies.