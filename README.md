# nomo
 
#### versioning

|Part|Sections|Version|Date|
|-|-|-|-|
|Introduction and Purpose|1-3| -- |2022-12-29|
|[Identifier primitives](#4-identifier-primitives)|4|`0.1.0`|2022-12-29|
|[Schema primitives](#5-schema-primitives)|5|`0.1.0`|2022-12-29|
|[Common schema](#6-common-schema)|6|`0.1.0`|2022-12-29|
|[Theoretical Background](#a1-theoretical-background)|Appx 1| -- |2022-11-21|

## 1. Introduction

nomo is a standard for constructing identifiers that are unique, semantic, and mechanically easy to process. nomo describes identifiers that are not bound to any institutional or mechanical infrastructure, nor to any central authority.

### 1.1 Examples

To the point, here are several examples of [qualified resource names](#45-qualified-resource-name) rendered in the [common schema](#6-common-schema). These have not been published by the organizations cited, but are instead included as examples of how QRNs could be used in context.

#### 1.1.1 ECMAScript Object.prototype.toString

```
ecma/es[11]::api:Object.prototype.toString
```

- `ecma` is the [authority](#451-authority), indicating that the organization [Ecma International](https://www.ecma-international.org/) declares this identifier
- `es` is the [set name](#452-set), denoting here the set of concepts described in the [ECMAScript language specification](https://tc39.es/ecma262/)
- `[11]` is the [set key](#452-set), denoting the [11th version of the language spec (ECMAScript 2020)](https://262.ecma-international.org/11.0/)
- `api` is the [group name](#453-group), denoting a group of identifiers which represent the global API, as defined in [Section 18 - The Global Object](https://262.ecma-international.org/11.0/#sec-global-object)
- `Object.prototype.toString` is the three-part [element name](#454-element) [`object`, `prototype`, `toString`], denoting here the `toString` prototype method of the `Object` type, described in [19.1.3.6 Object.prototype.toString()](https://262.ecma-international.org/11.0/#sec-object.prototype.tostring).

#### 1.1.2 IRS Form 1040

```
US-IRS/forms[1982]::1040
```

- `US-IRS` is the authority, indicating that this identifier is declared by the United States Internal Revenue Service
- `forms` is the set name, denoting here the set of forms published by the IRS
- `1982` is the set key, denoting here the set of forms specifically as published in 1982
- `1040` is the element name, denoting form 1040

#### 1.1.3 Caffeine

Many organizations have published identifiers for the common chemical caffeine. These can be rendered as QRNs to quickly embed the context required to understand the respective identifiers in reference to the publications which declare them:

```
acs/cas::58-08-2
```

- Authority: [American Chemical Society](https://www.acs.org/)
- Set: [CAS Registry](https://www.cas.org/cas-data/cas-registry)
- Element: [58-08-02](https://commonchemistry.cas.org/detail?cas_rn=58-08-2)

```
rsc/spider::2424
```

- Authority: [Royal Society of Chemistry](https://www.rsc.org/)
- Set: [ChemSpider](http://www.chemspider.com/Default.aspx)
- Element: [2424](https://www.chemspider.com/Chemical-Structure.2424.html)

```
カネヒサ/kegg::compound:C07481
```

- Authority: [Kanehisa Laboratories](https://www.kanehisa.jp)
- Set: [KEGG](https://www.kegg.jp/)
- Group: [Compounds](https://www.kegg.jp/kegg/compound/)
- Element: [C07481](https://www.kegg.jp/entry/C07481)

```
kanehisa/kegg::drug:D00528
```

- Authority: [Kanehisa Laboratories](https://www.kanehisa.jp)
- Set: [KEGG](https://www.kegg.jp/)
- Group: [Drugs](https://www.kegg.jp/kegg/drug/)
- Element: [D00528](https://www.kegg.jp/entry/D00528)


### 1.2 Contents
 
The practical product of nomo is a suggested [common schema](#6-common-schema) for validating, serializing, and parsing [qualified resource names](#45-qualified-resource-name) and their component [primitives](#4-identifier-primitives). This schema is built on lower levels of specification which are described first. It is expected and intended that the common schema may change over time, while the underlying primitives which the schema encodes will remain stable indefinitely.

nomo includes three modules of specification:

- [**Identifier primitives**](#4-identifier-primitives) - Abstract concepts that provide a mathematically complete description of an identifier
- [**Schema primitives**](#5-schema-primitives) - Abstract concepts that describe how identifier primitives may be validated and mapped to or from strings
- [**Common schema**](#6-common-schema) - An instance of a schema intended for general use in distributed computing and recordkeeping

### 1.3 Status

This specification is a draft. Language may be contradictory or vague, though by accident and not intent. Comments, corrections, and contributions are welcome.

## 2. License
Unless explicitly identified otherwise in the contents of a file, the content in this repository is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license. As summarized in the [Commons Deed](https://creativecommons.org/licenses/by-sa/4.0/) and strictly defined in the [license](./LICENSE.md) itself: you may share or adapt this work, provided you give appropriate credit, provide a link to the license, and indicate if changes were made. In addition, you must preserve the original license. For the details and actual legal license, consult the [license](./LICENSE.md).

### 2.1 Source Code
The [license](#2-license) of this work is designed for cultural works, [not source code](https://creativecommons.org/faq/#can-i-apply-a-creative-commons-license-to-software). Any source code intended for more than an illustration should be distributed under an appropriate license by including that license in the applicable source code file, or by placing the source code file in another repository with an appropriate license.
 
## 3. Purpose 

nomo provides a consistent mechanism for constructing and evaluating semantic identifiers, for the purpose of facilitating systematic cooperation between humans, and between humans and automated information systems.

nomo is designed to address situations where central allocation or arbitration of identifiers is impractical or undesirable, and yet it is useful that identifiers declared by unrelated parties be mutually intelligible and easy to disambiguate.

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

Even the [common schema](#6-common-schema) does not provide a mechanism for establishing or agreeing upon ownership of an authority string. The authors of this standard regard this as an authentication question which is delegated to any mechanism of authentication which cooperating parties agree to use. The name "authority" was chosen for concept equivalence to a forthcoming distributed authentication protocol described by the same authors of this standard, but nomo itself does not require or demand any particular choice of authentication system.

##### 3.1.4.3 Deterministic operations

**If** parties agree to recognize each other's respective glyph sets and authority strings, **then** nomo provides clear definitions so that the parties can understand the semantics of any identifier declared by any of the parties, and can deterministically answer whether any two identifiers are equivalent or are related in specific ways.

#### 3.1.5 Durability

A second order goal of all the characteristics described above is that nomo identifiers may be durable over time and context. While the authors intend to solve some immediate problems in distributed computing, they also aim to provide a means of establishing identifiers that can be communicated, understood, and continuously used across changing cultural and political boundaries, over indefinitely long time spans. Prime examples here include identification of persons, properties, documents, or industry and scientific standards.

Designing for durability is a key reason that the common schema included here is defined separately from the underlying primitives. One of the most important but also arbitrary decisions in that schema is the choice of characters used as delimiters between the serialized parts of an identifier. The characters chosen (including `/`, `:`, `,`, `.`, `=`, `[`, `]`) are a function of specific cultural and industrial conditions at the time of writing. Most importantly, these characters are available on the vast majority of computer keyboards in use at the time. From that limited set of potential glyphs, these were chosen for visual distinction such that human brains intuitively perceive segmentation between parts, and for analogy to existing symbolic uses of the same glyphs in computing, mathematics, and general use.

And yet these choices are not ideal. Mechanically and visually, it would be much preferable to use some of the hundreds of symbolic glyphs already defined in the Unicode standard, which are visually distinct and not widely used in other contexts, and so unlikely to be used within identifier segments themselves, or for other confounding purposes in data serialization and transfer. But at this time, these other characters would be culturally unfamiliar to most contemporary users and difficult for them to type even if they became familiar with them. 

And so we can hope that the current common schema may be superseded in the future by a more effective choice of delimiting characters, when the simple fact of keyboard layout or other input methods makes it easier for humans to express them. 

By defining the identifier primitives and comparison relations independent of any particular serialization method, the nomo standard allows humans to make different serialization choices over time while maintaining backwards compatibility, or at least intelligibility, so that serializations under differing or obsolete schemas are still easy to process.

#### 3.1.6 Platform independence
 
As a special case of the goal of durability, nomo identifiers are designed to be independent of any institutional or technical platform, or even from any physical medium. A QRN in the abstract has nothing to do with the internet, Unicode, or computers in general. For example, a glyph set can be defined as a set of audio tones (physical vibration frequencies), an audio-based schema could add certain tones or percussive sounds to be used as delimiters, and identifiers can then be constructed from those tones which can be produced (sung or played) and consumed (heard or recorded) by both humans and machines with high fidelity. Likewise with colors, with hand motions, or any other physical pattern which can be produced and consumed by interacting parties.

This makes nomo identifiers intentionally distinct from contemporary semantic identifiers such as domain names, URNs, or RDF, all of which are explicitly defined as embedded in a particular technical context - the contemporary internet, arbitrated by the IANA and other institutions, constrained and even defined by particulars of serialization. 

The common schema does provide practical decisions useful for applying nomo to contemporary computing contexts, making common-schema-encoded QRNs a practical alternative to URNs, or to myriad other domain- or platform-specific semantic identifier schemes.
 
### 3.2 Use cases

nomo is designed to be immediately useful in a number of contemporary distributed computing contexts, such as:

- Identifying a security principal among all possible security principals in all possible systems
- Identifying an entity within a versioned data model from among all possible versions of all possible data models
- Identifying a configuration setting from among all possible named values
- Identifying a service or service node from among all possible services or nodes

nomo is also intentionally designed to be applicable to non-computing uses cases, such as:

- Identifying a physical asset or artifact
- Identifying a version of a section of a law, ordinance, or other rule as established or proposed in a jurisdiction
- Identifying a chemical, genome, or other well-defined scientific entity
- Identifying a version of a highly specific industry standard, such as a particular standard parameter set for a type of fastener

## 4. Identifier Primitives

nomo identifier primitives are abstract ontological or mathematical concepts. They do not imply or require anything with regards to implementation, and impose no constraints besides those explicitly noted. Practical orthographic and protocol decisions for an implementation of QRNs in distributed record keeping is provided in the [common schema](#6-common-schema).
 
nomo defines the following identifier primitives:

  - [**glyph type**](#41-glyphs) - A single unique symbolic datum
  - [**glyph set**](#41-glyphs) - A set of glyph types
  - [**glyph**](#41-glyphs) - A representation of a glyph type 
  - [**string**](#42-string) - A sequence of zero or more glyphs from a glyph set
  - [**name**](#43-name) - A sequence of zero or more strings
  - [**value**](#44-value) - A compound primitive
  - [**qualified resource name**](#45-qualified-resource-name) - A composition of names and values that constitutes a complete identifier

### 4.1 Glyphs

A nomo **glyph type** is a single symbolic datum which can be consistently represented and recognized. A **glyph set** is a set of one or more distinct glyph types. A **glyph** is an instance of a glyph type. 

All these definitions imply a means to determine whether any given glyph corresponds to a glyph type within a particular set. Such an implementation is not defined in this section, rather it is an assumed precondition.

#### 4.1.1 Characters

In most use cases immediately contemplated by the authors, a glyph type means either a specific integer or an orthographic datum: a shape that can be recognized and distinguished by some biological or synthetic visual system. A distinct orthographic shape is usually called a character.

Likewise in these use cases a glyph set means a finite set of integers, or a finite set of distinct orthographic shapes (characters).

Character encodings used in contemporary computing provide mappings between integers and orthographic shapes, so that in practice a glyph set is understood by a computer as a set of integers, while the same glyph set is understood by a human as a set of characters. The character encoding provides the mapping between the two sets. 

#### 4.1.2 Alternative mediums

The term glyph implies a two-dimensional pattern in the manner of a character in a human natural writing system, but any pattern in any medium that can be consistently reproduced and recognized can be used as a glyph type. As glyphs are the atoms of which all nomo identifiers are built, nomo identifiers of any complexity can likewise be constructed or evaluated in any medium which can be used to express and recognize glyphs.

#### 4.1.3 Collation and comparison

Many natural writing systems have cultural rules about the ordering of written characters, or about equivalence between different representations of the "same" character. nomo recognizes no such rules. Each glyph type is strictly distinct from every other glyph type in a glyph set. The only meaningful evaluation between two glyphs types or glyphs is whether they are the same or different.

#### 4.1.4 Compatibility and equivalence

Two distinct glyph sets are **compatible** if there is defined an unambiguous mutual mapping between at least one glyph type in one set with a glyph type in the other set. Two distinct glyph sets are **fully compatible** if both sets have the same count of glyph types, and for every glyph type in one set there exists an unambiguous mutual mapping to one glyph in the other set.

Between compatible glyph sets, a mutually mapped glyph type in one set is **equivalent** to the glyph type in the other set to which it is mapped, and vice versa. 

When comparing two identifiers, where the respective glyph sets of the two identifiers are compatible, a particular glyph in one identifier is **equivalent** to a particular glyph in another identifier if the glyph type that the glyph in the first identifier represents is equivalent to the glyph type which the glyph in the other identifier represents.

### 4.2 String

A nomo **string** is a sequence of zero or more glyphs from the same glyph set.

The term "string" is chosen for agreement with common usage in computing, but again does not imply any constraint on the medium used to define a glyph set or compose as string. The only defining feature of a string is that it is a finite sequence of glyphs. An algorithm that produces a finite sequence is not a string, but the sequence it produces is. An empty string of zero glyphs is a valid nomo string. Serializations of such strings generally require delimiters for disambiguation, but the underlying string is defined as the (empty) sequence itself.

The only meaningful evaluation between two strings is whether they are the same or different. Two strings are the same if any only if:

 - The glyph sets of the two strings are the same or are compatible 
 - The two strings have the same number of glyphs
 - For all *n* from 1 to the length of the strings, the glyph at ordinal *n* in one string is the same or equivalent to the glyph at the same ordinal in the other string

All strings have the property of length, but length has no significance within nomo.

In the special case of zero-length strings, two strings are the same if and only if their respective glyphs sets are the same or are compatible. Conversely, zero-length strings of two incompatible glyph sets are not the same.

### 4.3 Name

A nomo **name** is a sequence of zero or more strings, where all strings use the same glyph set. Each string within a name is called a **segment**. Names provide an additional dimension of semantic representation beyond the choice and ordering of glyphs within a single string.

The name concept itself does not define intrinsic meaning about the selection or ordering of strings within a name. It instead provides a primitive mechanical feature which may be used by humans to represent any number of meanings.

In other words, a name definitely specifies the ordering of its segments, but only humans or other parties have any opinion about what that ordering "means".

The only meaningful evaluation between two names is whether they are the same or different. Two names are the same if any only if:

 - The glyph sets of the two names are the same or are compatible 
 - The two names have the same number of segments
 - For all *n* from 1 to the count of segments, the string of segment *n* in one name is the same as the string of segment *n* is the other name, according to the rules described in [4.2 String](#42-string)

It follows that:
 - Two names composed solely of zero-length segments are the same if and only if they have the same count of segments, and the glyph sets of the names are the same or compatible
 - Two names that have zero segments are the same if and only if the glyph sets of the names are the same or compatible

All names have the property of count (the number of constituent segments) and of length (the sum of the lengths of the constituent segments). Neither of these properties has any significance within nomo.

### 4.4 Value 

A value is a compound primitive datum composed of one of the following:

 - **string** - A single [string](#42-string) as defined above
 - **tuple**  - A sequence of values
 - **map**    - An unordered set of key-value pairs
 - **null**   - The absence of any value

The values of a tuple may themselves be string, tuple, map, or null values.

Within a map, the key of each key-value pair is a string, while the value may be a string, tuple, map, or null. The keys within a map must be unique. Uniqueness is strictly defined according to the string comparison rules described above (see [4.2 String](#42-string)).

Values provide extensibility to the qualified resource name concept by providing structures that humans may use to express a wide variety of meanings.

Two values are equal if and only if they are composed from the same or compatible glyph sets, they have the same type (string, tuple, map, or null), and the constituent parts of the value are also equal according the following rules:

#### 4.4.1 String equality
The sameness of two strings is defined in [4.2 String](#42-string)

#### 4.4.2 Tuple equality 
Two tuples are the same if and only if:

 - The glyph sets of the two tuples are the same or are compatible 
 - The two tuples have the same number of elements
 - For all *n* from 1 to the count of elements, the value of element *n* in one tuple is the same as the value of element *n* is the other tuple, according to the rules described in this specification.

A **name** therefore **is** a tuple where all the values are strings, and likewise a tuple where all the values are strings **is** a name. The null value is not a string, so a tuple which contains a null element is not a name, and likewise a name can contain an empty string segment but cannot contain a null segment.

#### 4.4.3 Map equality

Two maps are the same if and only if:

 - The glyph sets of the two maps are the same or are compatible 
 - The two maps have the same number of key-value pairs
 - For each key *k* in one map, the same key exists in the other map, and the value associated with *k* in the first map is the same as the value associated with *k* in the other map, according to the rules described in this specification.

#### 4.4.4 Null equality

Two null values are the same if and only if the glyph sets of the values are the same or compatible.

#### 4.4.5 Empty values

All values have a type - string, tuple, map, or null. The string, tuple, and map types each have an empty value - a string with zero glyphs, a tuple with zero values, or a map with zero key-value pairs. As noted above, for two values to be considered equal they must have the same type and the same or compatible glyph sets. Therefore, even for the same glyph set, the empty string, empty tuple, and empty map are three distinct values. In addition, the null value has a different type and is therefore a distinct value not equal to any of the empty values of the string, tuple, or map types.

### 4.5 Qualified Resource Name

A nomo **qualified resource name** (QRN) is a composition of other nomo primitives whose parts are chosen to correspond directly to concepts in set theory. 

A QRN is composed of the following parts, all of which are optional. All parts in a QRN must use the same glyph set:

|Part|Type|Description|
|-|-|-|
|**authority**|**string**|An arbitrary string identifying the universe of a set. In general, the principal which declares the identifier|
|**set name**|**name**|The identifier of a **set** itself|
|**set key**|**value**|A further qualifier on the identity of a **set** itself|
|**group name**|**name**|The identifier of a proper **subset** within a set|
|**element name**|**name**|The identifier for a specific **element** within a set|
|**element key**|**value**|A further qualifier on the identity of an **element** within a set|

#### 4.5.1 Authority

The authority is the root disambiguating context of a qualified resource name. nomo itself intentionally does not provide any opinion or mechanism for allocating authority strings. Assignment, agreement, or proof of ownership of some particular authority string is an authentication concept outside the scope of nomo.

#### 4.5.2 Set

The set name and key represent the identifier of a set itself. The primitive QRN concept does not require that a set name be present if a set key is present. The set name and key are collectively called the set identifier.

When both a set name and a set key are present, the QRN concept itself defines this to mean that the set name represents a set of sets which share some unifying character or attribute, while each unique key value appended to the set name represents a specific instance of such a set.

A common intended usage is to use the set name to denote a software, data, or administrative concept domain, and the key to denote a specific version of that domain.

#### 4.5.3 Group

The group name represents the identifier of a proper subset within the set identified by the set identifier. A QRN containing only a group name expresses the concept of an identified subset independent of any particular set to which it may belong.

#### 4.5.4 Element

The element name and key represent the identifier of a specific element within the set identified by the set identifier or the subset identified by the group name. The primitive QRN concept does not require that an element name be present if an element key is present. The set name and key are collectively called the element identifier.

When both an element name and an element key are present, the QRN concept itself defines this to mean that the element name represents a set of elements which share some unifying character or attribute, while each unique key value appended to the element name represents a specific instance of such an element.

A QRN containing only an element name or key represents the concept of an identified element independent of any particular set or subset to which it may belong.

A common intended usage is to use the element name to denote a resource collection and element key to identify a specific resource within that collection: colloquially, to identify a table with the element name and a row within that table with the element key.

#### 4.5.5 Empty and Missing Parts

As section [4.4.5 Empty Values](#445-empty-values) describes, the null value is not the same as the empty value of string, tuple, or map. It follows that the empty value of a given part of a QRN is not the same as a missing value for the same part: a QRN may include an authority whose value is the empty string of the glyph set used by the QRN, and this is different from a QRN which uses the same glyph set but has no authority part.

An explicit null value for a set key or element key is defined to have the same meaning as a missing key part.

#### 4.5.6 Equality

Two QRNs are the same if and only if:

 - The glyph sets of the two QRNs are the same or are compatible 
 - For each of the six parts of a QRN, the part is undefined in both QRNs, OR the part is defined in both QRNs and the corresponding values are the same according to the rules defined in this specification

### 4.6 Relations

#### 4.6.1 Value relations

As noted in the sections above, nomo does not define any relationship or comparison between values of any type except for sameness. The term **equal** may be used as a synonym, but "same" is preferred to avoid any implication of quantity or ordering associated with glyph types or identifiers.

As an illustration, consider a domain name such as `mail.example.com` as represented by a nomo name with the ordered segments [`mail`, `example`, `com`]. The internet domain name system as centrally coordinated by IANA explicitly does define subset semantics such that `mail.example.com` is definitely a "subdomain" of `example.com`, which is itself a member of the "top level domain" `com`.

But nomo itself defines no relationship between the names [`mail`, `example`, `com`], [`example`, `com`], and [`com`]. It only concludes that they are different names.

#### 4.6.2 QRN relations

In addition to sameness, nomo itself **does** define one additional boolean complementary comparison relationship between QRNs. This comparison is called **in** or **contains**. One formulation expresses whether a QRN is **in** the domain of possible identifiers denoted by a second QRN. The complementary formulation expresses whether the domain of possible identifiers denoted by a QRN **contains** another QRN.

##### 4.6.2.1 Operators

In summary, three operators are defined between two QRNs, with similar meanings as in standard set theory:

||Name|Example|Description|
|-|-|-|-|
|`=`|same|`A = B`|A is the same as B|
|`∈`|in|`A ∈ B`|A is in B|
|`∋`|contains|`B ∋ A`|B contains A|

Further:

 - All three operators are boolean and binary: They accept a left and right operand, and definitely evaluate to `true` or `false`. 
 - nomo also asserts that all three operators are mutually exclusive: Given any left operand `A` and right operand `B`, if one operator applied to these operands evaluates to true, then the other two operators definitely evaluate to false.
 - **same** is complementary to itself, i.e. it is commutative
 - **in** is complementary to **contains** and vice versa

##### 4.6.2.2 Corollaries

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

##### 4.6.2.3 Subset relations

Readers familiar with set theory may note that additional set relationships could be expressed, and that it may seem to make more sense if, for example, one QRN contains a group name but no element identifier. In this case would it not make more sense to say the following, for example?:

```
ecma/es[11]::types ⊂ ecma/es[11]
```

And **not**

```
ecma/es[11]::types ∈ ecma/es[11]
```

Which is to say, according the the semantics defined for QRNs, isn't the first identifier above (`ecma/es[11]::types`) a **subset** rather than **element of** of the second identifier (`ecma/es[11]`)?

The answer is that nomo is strictly concerned with relationships between identifiers, not between things or concepts which those identifiers may denote. Further, nomo limits itself to defining binary relations -- relations between exactly one identifier and exactly one other identifier. In this context, `ecma/es[11]::types` *denotes* a subset, but the identifier itself is a single element, a single defined entity. 

According to the relations further described below, the identifier `ecma/es[11]::types` is in the domain of possible identifiers relative to `ecma/es[11]`, therefore `ecma/es[11]::types` is **in** `ecma/es[11]`, and by complement `ecma/es[11]` **contains** `ecma/es[11]::types`. We use the symbols `∈` and `∋` to describe this. Whether this constitutes the "same" usage of these symbols as in set theory in general, is merely an analogy, or is in fact a misuse of the symbols is a philosophical question we leave to readers to debate.

The descriptions below do use the union `∪` and intersection `∩` symbols to illustrate relationships. The intended result is still to define the outcome of applying the **in** (`∈`) or **contains** (`∋`) operator to two identifiers.

##### 4.6.2.4 Notation

For convenience, the following descriptions represent QRNs using [common schema](#6-common-schema) notation. The relationships hold regardless of the medium or glyph sets used for two identifiers.

The asterisk is used to stand for *any or all identifiers* with at least one defined part in the position indicated by the asterisk. This symbolic meaning is not part of the common schema, and is only used here to illustrate the relationships described.

#### 4.6.3 Authority relations

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`A/*`|`∩`|`B/*`|`=`|`∅`|The domains of any two authorities are disjoint|
|`A/*`|`∈`|`A/`|||All identifiers relative to an authority are in the authority's domain| 

By definition, no possible identifier relative to authority `A` is in the set of possible identifiers relative to authority `B`. Conversely, all possible identifiers relative to a given authority string are considered in the same domain -- namely, the identifier domain denoted by that authority string.
  
#### 4.6.4 Set relations
  
##### 4.6.4.1 Unkeyed sets

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`x::*`|`∩`|`y::*`|`=`|`∅`|The domains of two set names are disjoint|
|`x::*`|`∈`|`x::`|||All subsets and elements relative to a set name without a key are in the set denoted by that unkeyed set name|
  
##### 4.6.4.2 Keyed sets

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`x[1]::*`|`∩`|`x[2]::*`|`=`|`∅`|The sets denoted by two different key values relative to the same set name are disjoint|
|`x[1]::*`|`∈`|`x[1]::`|||All subsets and elements relative to a set name with a key are in the set denoted by that keyed set name|
 
##### 4.6.4.3 Relation between keyed and unkeyed sets

The relation between a QRN with a keyed set name and a QRN with an unkeyed set name is more subtle, but is still well defined.

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`x[*]::*`|`∈`|`x::`|||All set keys relative to the same set name are in the same set of sets denoted by the set name without a key|
|`x::*`|`∩`|`x[*]::`|`=`|`∅`|The subsets and elements relative to a set name without a key are disjoint the the set of keyed sets relative to that same set name|
|`x::*`|`∪`|`x[*]::`|`≡`|`x::`|The union of the subsets and elements relative to a set name without a key with the set of keyed sets relative to that same set name exactly equals the entire set of possible identifiers relative to the unkeyed set name.<br><br>In other words, the subsets and elements relative to an unkeyed set name along with the set of keyed sets relative to that set name form a partition over the possible identifiers relative to the unkeyed set name.|

#### 4.6.5 Group relations

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`g:*`|`∩`|`h:*`|`=`|`∅`|The domains of two group names are disjoint|
|`g:*`|`∈`|`g:`|||All identifiers relative to a group name are in the group's domain| 

#### 4.6.6 Element relations

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`e`|`∩`|`f`|`=`|`∅`|The domains of two element names are disjoint| 
|`e[1]`|`∩`|`e[2]`|`=`|`∅`|The domains of two element key values relative to the same element name are disjoint |
|`e[*]`|`∈`|`e`|||All element keys relative to the same element name are in the same set of elements denoted by the element name without a key|

### 4.7 User-defined QRN Semantics

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
 
### 5.1 Identifier-strings

nomo defines the following compound string types, all of which include any delimiters or other annotation glyphs as required to describe the underlying identifier which the string encodes. A string of any of these types can be called an identifier-string:

  - **name-string** - A [**name**](#43-name) encoded as a single string
  - **tuple-string** - A [**tuple**](#44-value) value encoded as a single string
  - **map-string** - A [**map**](#44-value) value encoded as a single string
  - **qrn-string** - A [**QRN**](#45-qualified-resource-name) encoded as a single string
  - **null-string** - A placeholder string which explicitly indicates a [null value](#44-value)

#### 5.1.1 Identifier-string equivalence

The rules defined in [section 4](#4-identifier-primitives) strictly define whether two identifiers are considered equal. The same strict rules of equality as defined in [4.2 Strings](#42-string) apply to identifier-strings as well.

In addition, two identifier strings are **equivalent** if they [decode](#52-schema-operations) to the same identifier, even if the identifier-strings themselves are not the same. By definition, two identifier-strings that are the same are also equivalent.

identifier-strings that are equivalent but not the same are valid and allowed, as described further under [5.2 Schema Operations](#52-schema-operations). Mechanisms such as *escape sequences* or allowance of for whitespace included in many practical schemas allow many distinct identifier-strings to deterministically decode to the same underlying identifier.

#### 5.1.2 Identifier-string support

Any valid schema must be able to represent name-strings and qrn-strings. 

Schemas that allow tuple values must be able to represent tuple-strings, and likewise schemas that allow map values must be able to represent map-strings. 

##### 5.1.2.1 null-strings

No schema is required to represent non-empty null-strings, if other delimiters or punctuation unambiguously encode where null values would be. For example, the common schema tuple-string `(,,)` unambiguously encodes a tuple with three null values, even though the actual values are not represented by any glyphs at all. Instead, the tuple is encoded entirely by delimiting characters. 

null-strings are instead defined above as a valid concept that schema designers may choose to use if desired, where a non-empty sequence of glyphs in a tuple-string or map-string is used to explicitly note a null value. Imagine for example a schema that requires all string values to be delimited with single quotes, and then also allows the literal glyph sequence `null` to denote a null value. The same tuple of three null values could be encoded even without surrounding parentheses as `null,null,null`. And this would be unambiguously different from the encoding of a sequence of three string values where the actual contents of each string are the literal characters n-u-l-l: `'null','null','null'`.

### 5.2 Schema Operations

nomo defines three schema operations:

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

nomo does not define a schema operation for testing the validity of an *identifier-string* directly, as this is a redundant. Any identifier-string is valid if it can be unambiguously decoded to an identifier, and the resulting identifier is valid according to the validate algorithm of the schema.

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

It remains meaningless within nomo to ask whether one identifier or even identifier-string "comes before" another, or whether one identifier-string is some transformation of another.

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

To the extent that the resulting standards can be expressed as mechanical glyph sets and algorithms as described in this [section 5](#5-schema-primitives), such standards are part of a schema and are therefore a nomo concern. Any and all of the infinite range of possible administrative, mechanical, and semantic rules which could be layered on top are and shall remain outside the scope of nomo.
 
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

Ultimately, such aliases are merely a matter of technical communication between humans. The actual mechanics of identifiers and schemas do not depend on what humans choose to call the identifier types or the parts of a QRN. Take this section then as explicit encouragement to other authors to be creative and pragmatic with how they build on nomo concepts. The usefulness of all these ideas is enhanced by creativity in semantics on the one hand with conservation of mechanics on the other. 

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

## 6. Common Schema

This section describes an instance of a [schema](#53-schema-composition) intended for immediate use in distributed computing and general record keeping. It is defined strictly in relation to the digital standard Unicode, but should also be functional for printed or even hand-written use cases.

The common schema uses the [Unicode](https://home.unicode.org/) standard for its glyph sets. This is intentionally ambiguous with regards to Unicode version; the exact set of code points and characters recognized will depend on the version of Unicode used by interacting parties.

SEE https://www.unicode.org/reports/tr31/

### 6.1 Glyph sets

#### 6.1.1 Identifier Glyph Set

The identifier glyph set of the common schema is all code points included in the Unicode character classes L (Letter), M (Mark), N (Number), P (Punctuation), and S (Symbol) which are preserved under Unicode [normalization form C](https://www.unicode.org/reports/tr15/tr15-53.html#Norm_Forms) (**c**omposition / NFC), plus the single simple space character (U+0020).

#### 6.1.2 Encoding Glyph Set

The encoding glyph set of the common schema is all code points included in the [Unicode](https://home.unicode.org/) character classes L (Letter), M (Mark), N (Number), P (Punctuation), and S (Symbol), plus the single simple space character (U+0020). 

For digital encoding, all common schema identifier-strings must use UTF-8.

The [encode operation](#63-encode) defined next will always produce identifier-strings that only contain code points preserved under normalization form D, but alternative constructions that are converged through string normalization are also allowed. Per the definitions in [section 5](#5-schema-primitives), these alternative forms are all **equivalent** identifier-string encodings of the same underlying identifier.

Note the slight difference between the identifier and encoding glyph sets: Both glyph sets allow the same character classes plus the space character (U+0020), but the identifier glyph set allows only characters / code points which are preserved under normalization form C.

#### 6.1.3 Space

The common schema explicitly excludes all white space characters, except for the simple `SPACE` `U+0020` (`' '`) character, which may be included in string values.

#### 6.1.4 Delimiters

The common schema uses a variety of delimiter characters to identify the parts of serialized identifier-strings. To avoid ambiguity in identifier-strings, source strings that contain delimiter characters must be escaped and quoted. 

##### 6.1.4.1 Explicit Delimiters

The following 16 code points are defined as **explicit delimiter** characters in the common schema:

|Code||Description|
|-|-|-|
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

##### 6.1.4.2 Implicit Delimiters

In addition, any code point that decomposes to one of the explicit delimiters through normalization form NFKD (Compatibility Decomposition) is an **implicit delimiter**. For example, the following code points all decompose to `LEFT PARENTHESIS` `(` `U+002B` via NFKD:

|Code||Description|
|-|-|-|
|U+207D|`⁽`|SUPERSCRIPT LEFT PARENTHESIS|
|U+208D|`₍`|SUBSCRIPT LEFT PARENTHESIS| 
|U+FE59|`﹙`|SMALL LEFT PARENTHESIS| 
|U+FF08|`（`|FULLWIDTH LEFT PARENTHESIS|

###### 6.1.4.2.1 Rationale for Implicit Identifiers

Implicit delimiters are defined as delimiters for the sake of the encoding operation to avoid visual confusion for humans. 

Implicit identifiers that are preserved under normalization forms NFC and NFD need no special handling for a computer. A computer processing a string as a series of code points (really, integers), there is no perceived relation or collision between the integer 8317 (`SUPERSCRIPT LEFT PARENTHESIS` `⁽` `U+207D`) and the integer 43 (`LEFT PARENTHESIS` `(` `U+002B`).

But nomo identifiers are intended to facilitate cooperation with and between humans as much as with machines, so the common schema requires that string values containing implicit delimiters also be quoted, to avoid confusion for humans reading identifier-strings.

##### 6.1.4.3 Additional Psuedo-Delimiters

Defining implicit delimiters in terms of NFKD decomposition is still not a fool-proof way of preventing visual confusion, as there are many other punctuation and symbol characters in Unicode that do not have a defined decomposition rule even though they are also visually similar to an explicit delimiter character. As an example, `MEDIUM LEFT PARENTHESIS ORNAMENT` `❨` `U+2768` visually appears just as similar to `LEFT PARENTHESIS` `(` `U+002B` as the four other characters above, but as of this writing it does not have a decomposition rule to `LEFT PARENTHESIS`, and so is not defined as a delimiter for this specification.

### 6.2 Algorithms

#### 6.2.1 Validate

The common schema validate algorithm includes just two rules: empty names are disallowed, and all strings must be in Unicode normalization form C.

##### 6.2.1.1 Empty names

The common schema allows all possible identifiers constructed from the [identifier glyph set](#61-identifier-glyph-set) according to the defined nomo [identifier primitives](#4-identifier-primitives), with the following exception:

 - **Defined name parts may not be empty**. Empty names have zero segments. Names composed of at least one empty string are allowed.

All parts of a QRN are still optional. The above constraints just express that *if* a name part is defined, it cannot be an empty name. The difference between these three situations may best be represented with a short snippet of JavaScript for an imaginary QRN object, where names are represented as arrays of strings:

```js
qrn.setName = null     // OK: No set name at all
qrn.setName = [ '' ]   // OK: Defined set name with one segment which is an empty string
qrn.setName = []       // NOT OK: Defined set name which has no segments
```

This still does not require that a set name be present for a set key to be present, nor for an element name to be present for an element key to be present. Restated in the positive: The common schema allows a set key to be defined even if the set name is missing, and allows an element key to be defined even if the element name is missing.
 
Note that the definition of the QRN itself already specifies that a set or element key value of `null` has the same meaning as a missing/undefined key value. In other words, saying that a QRN has no element key means the same thing as saying that a QRN has an element key with the value `null`. See [4.5.5 Empty and Missing Parts](#455-empty-and-missing-parts).

##### 6.2.1.2 Normalization Form C

A common schema identifier is valid if and only if processing each string in the identifier following the Unicode normalization algorithm for normalization form C yields exactly zero changes in the code points of each respective string.

##### 6.2.1.3 Other rules

The common schema itself is defined primarily as a foundation for serialization and mutual intelligibility in distributed recordkeeping, and particularly (but not exclusively) distributed computing. It is entirely expected that cooperating parties may define their own more restrictive validation rules in derived schemas, in the same way they may define [their own QRN semantics](#47-user-defined-qrn-semantics), while still leveraging the underlying encoding and decoding algorithms defined here in the common schema. 

For example, it would likely be desired to disallow empty name segments, as empty segments provide little semantic value, even if the common schema can safely encode them:

```
''.''/''::''['',]
```

_Valid but unhelpful common schema QRN composed entirely of empty strings and null values_ 

##### 6.2.1.4 Identifier-string support

As the common schema is meant to be as broadly useful as possible, it allows identifier-strings that are not associated with a QRN. The decode algorithm includes deterministic rules for interpreting an input identifier-string as one of the following:

- tuple-string: A bare encoded tuple value, not associated with a QRN part
- map-string: A bare encoded map value, not associated with a QRN part
- name-string: A bare encoded name value, not associated with a QRN part
- qrn-string: A encoded QRN, with none, any, or all parts defined
- null-string: An encoded atomic null value

###### 6.2.1.4.1 null-string

A valid null-string is any sequence of exactly four code points, where the possible code points at each position are shown below:

|Position|Code Points||
|-|-|-|
|1|`N (U+004E)`|`n (U+006E)`|
|2|`U (U+0055)`|`u (U+0075)`|
|3|`L (U+004C)`|`l (U+006C)`|
|4|`L (U+004C)`|`l (U+006C)`|

#### 6.2.2 Encode

Any common schema identifier is encoded using the following general algorithm:

1. Convert each string segment to its corresponding [Unicode NFD form](https://www.unicode.org/reports/tr15/tr15-53.html#Norm_Forms)
2. Sort any maps
3. Escape strings 
4. Delimit strings
5. Recursively encode structured values
6. Compose encoded parts

##### 6.2.2.1 Convert strings to NFD

All nomo identifiers are composed of strings. Compound structures such as tuples, maps, and names are ultimately composed solely of strings or null values. For each component string of an identifier, convert that string to its normalization form D, as defined in the Unicode standard.

##### 6.2.2.2 Sort maps

Before performing any other operations, sort any map key-value pairs contained in the identifier by sorting the keys in strict code-point order. Per the previous step, all map keys should already be in Unicode NFD form.

##### 6.2.2.3 Escape strings

Insert a single backslash (`\`, `U+005C`) character before any existing instance of either an apostrophe (`'`, `U+0027`) or backslash (`\`, `U+005C`) in any string.

##### 6.2.2.4 Delimit strings

Enclose any string in a pair of single-quote / apostrophe characters (`'`, `U+0027`) if the string is empty (zero-length), or if it contains a **delimiter**, as defined in [section 6.1.4](#614-delimiters), or if the entire string is a valid null-string

##### 6.2.2.5 Encode structures

###### 6.2.2.5.1 Names

Encode each **name** value in the set name, group name, or element name by concatenating its parts in order, separated by a single period (`.`, `U+002E`) between each pair of segments. If the entire identifier is a name outside the context of a QRN, encode it the same way.

###### 6.2.2.5.2 Tuples

Encode each **tuple** value as follows (except for names as already encoded in the previous section):

 1. Recursively encode each of the tuple's elements per the rules in this [section 6.3.5](#635-encode-structures).
 2. Concatenate the elements in order, separated by a single comma (`,`, `U+002C`) between each pair of elements.
 3. Enclose the concatenated elements with a matching pair of parenthesis (`(`, `U+0028` and `)`, `U+0029`) unless the tuple has at least two values, and is the top-level value of a set or element key.

###### 6.2.2.5.3 Maps

Encode each **map** value as follows:

  1. Recursively encode the value of each key-value pair per the rules in this [section 6.3.5](#635-encode-structures).
  2. For each key-value pair, concatenate the pair into a single string consisting of the key, followed by the equal sign (`=`, `U+003D`), followed by the encoded value
  3. Concatenate the encoded key-value pairs in the order already set in step 1 of encoding, separating each pair of encoded key-value pairs with a single comma (`,`, `U+002C`).
  4. Enclose the concatenated key-value pairs with a matching pair of curly braces (`{`, `U+007B` and `}`, `U+007D`) unless the map has at least one key-value pair and is the top-level value of a set or element key.

###### 6.2.2.5.4 Nulls

Null values are omitted from the encoded identifier-string. The presence of a null value as an element of a tuple, or value of a key-value pair of a map, is unambiguously denoted by the surrounding delimiters in the encoded identifier-string.

###### 6.2.2.5.5 Encode keyed names

If the identifier has a defined, non-null set key, enclose its encoded value with a matching pair of square brackets (`[`, `U+005B` and `]`, `U+005D`) and append it to the encoded set name, if any.

If the identifier has a defined, non-null element key, enclose its encoded value with a matching pair of square brackets (`[`, `U+005B` and `]`, `U+005D`) and append it to the encoded element name, if any.

##### 6.2.2.6 Compose

Finally, compose the completed identifier-string through the following operations:

1. If the authority part is defined, append a single slash (`/`, `U+002F`) to its encoded value
2. If the set part is defined, append two colons (`::`, `U+003A + U+003A`) to its encoded value
3. If the group name is defined, append a single colon  (`:`, `U+003A`) to its encoded value
4. Concatenate all parts in order: authority, set, group, element
5. If the entire encoded QRN is an empty string, because all parts of the QRN are undefined, then enclose the (empty) QRN in a matching pair of angle brackets (`<`, `U+003C` and `>`, `U+003E`). In this case the entire fully-encoded QRN is the value `<>`.

This concludes the encode algorithm.

##### 6.2.2.7 Manual encoding

Automated implementations of the common schema *must* follow the deterministic steps described above, applying enclosing or delimiting characters only when specified in the preceding steps. However, identifier-strings constructed directly may include the following valid alternatives forms that would not be produced by the encode algorithm:

- A string value *may* always be enclosed in single quotes / apostrophes, even if it does not contain any of the characters listed in [section 6.3.4](#634-delimit-strings)
- A tuple value *may* always be enclosed in parenthesis, even if it is the top-level value of a set or element key
- A map value *may* always be enclosed in curly braces, even if it is the top-level value of a set or element key
- An entire QRN value *may* always be enclosed in angle brackets, even if it has one or more defined parts
- Strings may contain code point sequences that would be transformed through string normalization to normalization form D

#### 6.2.3 Decode

A common-schema identifier-string is decoded using the following general algorithm:

1. Tokenize the identifier-string
2. Validate and group structures
3. Assign structures to parts
4. Unquote strings
5. Unescape strings
6. Normalize to NFC

More efficient streaming or stack-based algorithms can be defined, but are left to implementers.

##### 6.2.3.1 Syntax Errors

For consistency between implementations, the common schema defines the following syntax error types. The verbal descriptions of the decode process below indicate when decoding should fail, and with which error type.

|Error|Description|
|-|-|
|UNCLOSED_STRING|A quoted string value has no closing quote character|
|UNCLOSED_QRN_|A bracketed QRN is missing the closing bracket|


##### 6.2.3.1 Tokenization

An input identifier-string can be naively tokenized as follows.

1. Identify all `delimited-string` tokens

   Scanning the characters of the complete identifier-string in order, an apostrophe (`'`, `U+0027`) denotes the beginning of a new `delimited-string` token and is included as the first character of the token. All subsequent characters belong to the `delimited-string` until another apostrophe is encountered, unless that apostrophe is immediately preceded by a backslash (`\`, `U+005C`). The first subsequent *non-escaped* apostrophe encountered denotes the end of the `delimited-string` token, and is included as the last character of the token. If the end of the identifier-string is reached without encountering a non-escaped apostrophe, the decoding fails with `UNCLOSED_STRING` error.

2. Identify remaining `string` and `delimiter` tokens

   Re-scanning the characters of the complete identifier-string in order:
   
   - If the character is already part of a `delimited-string` token, ignore and continue
   - If the character is an **explicit delimiter** [section 6.1.4.1](#6141-explicit-delimiters), it is a single-character `delimiter` token
   - Otherwise, the character is the first character of a new `string` token. The `string` token contains all contiguous subsequent characters that are not already part of a `delimited-string` token and are not an explicit delimiter.

The above simple algorithm will divide all characters in the input identifier-string into a series of `delimiter`, `string`, and `delimited-string` tokens.

##### 6.2.3.2 Validate and group structures

A complete and efficient algorithm for parsing and validating the tokens from the previous step is a standard enough exercise but tiresome to include here. Instead, we provide a description of a valid identifier-string token sequence as a EBNF grammar as follows:

```ebnf
backslash   = ? \ ?
delimiter           = '"' | "'" | "(" | ")" | "," | "." | "/" | ":" 
                    | "<" | "=" | ">" | "[" | backslash | "]" | "{" | "}" ;
space               = " ";
letter              = ? Any Unicode code point with general category L (Letter) ?;
mark                = ? Any Unicode code point with general category M (Mark) ?;
number              = ? Any Unicode code point with general category N (Number) ?;
punctuation         = ? Any Unicode code point with general category P (Punctuation) ?;
symbol              = ? Any Unicode code point with general category S (Symbol) ?;

any_glyph           = letter | mark | symbol | number | punctuation | symbol | space;
escaped_slash       = backslash, backslash;
escaped_quote       = backslash, "'";
bare_glyph          = any_glyph - ( delimiter | space );
glyph               = any_glyph - ( backslash | "'" );

bare_string         = bare_glyph , { bare_glyph }; (* A bare string with at least one character *)
quoted_string       = "'" , { glyph | escaped_quote | escaped_slash } , "'";
string              = bare_string | quoted_string;

value               = null | string | tuple | map;

null                = "";

bare_tuple          = value , "," , value ,  { "," , value }; (* A tuple with at least two values *)
tuple               = "(" , [ value , { "," , value } ] , ")";

key_value_pair      = string , "=" , value;
bare_map            = key_value_pair , { "," , key_value_pair}; (* A map with at least one entry*) 
map                 = "{" , [ key_value_pair , { "," , key_value_pair } ] , "}";

name                = string , { "." , string };
name_key            = "[" , ( string | bare_tuple | tuple | bare_map | map ) , "]";
keyed_name          = name , name_key;

authority           = string , "/";
set_identifier      = ( name | name_key | keyed_name ) , "::";
group_name          = name , ":";
element_identifier  = ( name | name_key | keyed_name );

(* non_empty_qrn has at least one of its parts defined *)
non_empty_qrn       = ( authority  , [set_identifier] , [group_name] , [element_identifier])
                    | ([authority] ,  set_identifier  , [group_name] , [element_identifier])
                    | ([authority] , [set_identifier] ,  group_name  , [element_identifier])
                    | ([authority] , [set_identifier] , [group_name] ,  element_identifier );
 
(* All parts of a bracketed_qrn are optional *)
bracketed_qrn       = "<" , [authority] , [set_identifier] , [group_name] , [element_identifier] , ">";

qualified_resource_name = non_empty_qrn | bracketed_qrn;
```

# Appendices

## A1. Theoretical Background

nomo is based on three theoretical concepts: finite sequences, discrete patterns, and perfect coherence.

A finite sequence is a well-defined mathematical concept that is also easy to intuit. Informally, it is an ordered list. 

Formally, it is a countable, finite set of zero values, exactly one value, *or* of multiple values where all possible pairs of values have an unambiguous relationship such that one of the pair comes *before* the other, there is a first value, and there is a last value.

Pattern and coherence have philosophically independent definitions, but for the practical application of nomo they are defined in mutual reference:
 
- A pattern is any physical phenomenon or configuration that can be distinguished as itself and as distinct from other potential patterns and from a lack of pattern
- Coherence is the degree to which a system which can recognize the sameness or difference of a given pattern, or the degree to which a system can produce a pattern which has a quality of sameness or difference to some reference pattern

Most concepts expressed in natural language are coherent but not perfectly so. The English word "bird" maps to some abstract pattern represented in neurons in both humans and other biological systems, in various synthetic information systems, and to words in other human languages. This pattern is coherent -- there is sufficient practical overlap between the infinitely varied representations of that "same" concept or abstraction to allow productive cooperation between parties. 

And yet no two brains have exactly the same representation of "bird", either as a phonetic word or as an abstract concept. There is no objective, agreed upon boundary between what range of sounds can be recognized as "bird" and where such sounds become meaningless noise, or some other know word ("bard?", "bored"? "beard"?, etc.). And there is no objective, agreed-upon boundary between which visual representation, which motion, even which physical thing marks the exact boundary of what can be described as "bird" and what cannot.




nomo is concerned only with patterns that can be reproduced with perfo, so that a pattern only exists to the extent it can be consistently produced or consumed, and coherence exists only to the extent a pattern being correlated can be identified.

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

nomo is a specification for identifiers: symbolic references to something else. They are only useful if the component patterns can be reproduced and recognized multiple times, usually by multiple pattern processing systems, including human brains. In other words, the component patterns must be communicable.

#### A1.1.3 Uniqueness

Any theoretical pattern could be defined or distinguished by any number of attributes. A letter could be bold or italic, large or small, written in one script or another. A spoken word can be loud or soft, bear any number of meaningful modulations, be spoken in one accent or another. All of these attributes are used in practice in human communication to distinguish between patterns which in turn distinguish between different meanings -- including identifiers.

nomo is instead exclusively concerned with whether an instance of some pattern can be identified as "this one", "that one", or "not any them". 

### A1.2 Coherence

Coherence is an emergent property of the interactions between a pattern and a pattern processing system. It is an abstract measure of how consistent the processing system is at recognizing or reproducing patterns.
 
Coherence is therefore a practical measure of communicability. 

#### A1.2.1 Perfection

Perfect coherence is a property of discrete patterns and associated pattern processing systems where exactly zero information is lost or changed through reproduction and recognition. It is analogous to superconductivity, where in some materials under certain conditions electrical resistance drops to exactly zero, allowing an electrical current to flow indefinitely with zero loss.

Perfect coherence is achievable with sufficiently distinct discrete patterns, such that the pattern can be reproduced and recognized an indefinite number of times with exactly zero information loss or corruption.

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