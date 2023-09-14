# Nomo: Introduction
 
version `0.18.0` • 2023-09-14

## 1. Introduction

Nomo is a standard for constructing identifiers that are unique, semantic, and mechanically easy to process. Nomo describes identifiers that are not bound to any institutional or mechanical infrastructure, nor to any central authority. Its purpose is to facilitate systematic cooperation and distributed recordkeeping by providing a stable framework for producing and consuming identifiers that are mutually intelligible and stable across many cultures and contexts, over arbitrarily short or long time spans.
 
### 1.1 Contents
 
The immediate practical product of Nomo is a suggested [Unicode](https://www.unicode.org/standard/standard.html)-based [common schema](./nomo-common-schema.md) for validating, serializing, and parsing [qualified resource names](./nomo-id-structures.md.md#10-qualified-resource-name) and their component [primitives](./nomo-id-structures.md#11-identifier-primitives). See [Examples](#appendix-1-examples) at the end of this document for an intuitive introduction by example. 

The common schema is built on lower levels of specification which are described first. It is expected and intended that the common schema may change over time, while the underlying primitives which the schema encodes will remain stable indefinitely.

Nomo includes three modules of specification:

- [**Identifier Structures**](./nomo-id-structures.md) - Abstract concepts that provide a mathematically complete description of an identifier
- [**Schema primitives**](./nomo-schema-primitives.md) - Abstract concepts that describe how identifiers may be validated and mapped to or from strings
- [**Common schema**](./nomo-common-schema.md) - An instance of a schema intended for immediate general use in distributed computing and recordkeeping

### 1.2 Terms
 
- "This document" refers specifically to this specific document: "Nomo: Introduction", as distinct from any additional documents or other media which constitute the Nomo standard as a whole.
- "Specification" or "specification document" refers to any of the documents noted above that contain normative descriptions of the rules and mechanics of Nomo. This document (Nomo: Introduction) is not a specification.
- "This standard" or "the Nomo standard" refers to all documents and media which specify and describe Nomo.

### 1.3 Versioning

Each independent specification document of Nomo is versioned strictly according to semver 2.0. Nomo does not describe a software system, but it does describe a mechanical, verifiable contract of concepts and relations.

### 1.3.1 Versioning of this document

This document is not a normative specification, but does have a version. See [Appendix 2: Introduction versioning](#appendix-2-introduction-versioning) for details.

### 1.4 Status

This document is a draft. Language may be contradictory or vague, though by accident and not intent. Comments, corrections, and other contributions are welcome.

## 2. License
Unless explicitly identified otherwise in the contents of a file, the content in this repository is licensed under the [Creative Commons Attribution-ShareAlike 4.0 International](https://creativecommons.org/licenses/by-sa/4.0/legalcode) license. As summarized in the [Commons Deed](https://creativecommons.org/licenses/by-sa/4.0/) and strictly defined in the [license](./LICENSE.md) itself: you may share or adapt this work, provided you give appropriate credit, provide a link to the license, and indicate if changes were made. In addition, you must preserve the original license. For the details and actual legal license, consult the [license](./LICENSE.md).

### 2.1 Source Code
The [license](#2-license) of this work is designed for cultural works, [not source code](https://creativecommons.org/faq/#can-i-apply-a-creative-commons-license-to-software). Any source code intended for more than an illustration should be distributed under an appropriate license by including that license in the applicable source code file, or by placing the source code file in another repository with an appropriate license.
  
## 3. Purpose 

Nomo provides a consistent mechanism for constructing and evaluating semantic identifiers, for the purpose of facilitating systematic cooperation between humans, and between humans and automated information systems.

Nomo is designed to address situations where central allocation or arbitration of identifiers is impractical or undesirable, and yet it is useful that identifiers declared by unrelated parties be mutually intelligible and easy to disambiguate.

### 3.1 Characteristics 

In more detail, Nomo identifiers are designed to achieve the following characteristics:
 
#### 3.1.1 Uniqueness

Uniqueness is an intrinsic goal of any identifier. Nomo is designed to make it easy to construct identifiers that will not collide with other identifiers.

#### 3.1.2 Semantic clarity

"Semantic" means the content of the identifier has symbolic meaning to humans. Semantic clarity helps humans to compose, remember, and understand identifiers.

The demand for semantic clarity precludes many contemporary unique identifier conventions such as [UUID / GUID](https://datatracker.ietf.org/doc/html/rfc4122), [Mongo ObjectId](https://www.mongodb.com/docs/manual/reference/method/ObjectId/), [XID](https://github.com/rs/xid), or similar constructions that are essentially serializations of a large random integer, with or without a time-based prefix.

#### 3.1.3 Mechanical clarity

Mechanical clarity helps both machines and humans to reliably determine whether or not two identifiers are equivalent or are related.

The demand for mechanical clarity precludes simply using unstructured natural language.

#### 3.1.4 Decentralization

Nomo is designed to facilitate cooperation without the need for a central authority that arbitrates, authorizes, or allocates identifiers or identifier spaces.

To achieve mutual intelligibility, Nomo defines identifier structures along with deterministic rules for comparing them. 

To achieve decentralization, Nomo provides two points where choice or implementation are left to cooperating parties to negotiate.

These two points of negotiation are the choice of [glyph set](./nomo-id-structures.md#212-glyph-set) for an identifier, and authentication of the [authority string](./nomo-id-structures.md#101-authority) of a [qualified resource name](./nomo-id-structures.md#10-qualified-resource-name). 

##### 3.1.4.1 Negotiation - Glyph set

Two Nomo identifiers declared by two different parties are mutually intelligible if and only if those two parties agree on the equivalence of or a mapping between the [glyph sets](./nomo-id-structures.md#212-glyph-set) associated with the respective identifiers. 

Neither the [identifier structures](./nomo-id-structures.md) nor [schema primitives](./nomo-schema-primitives.md) sections of the Nomo standard provide any predefined glyph set, nor do they define any algorithm for establishing equivalence among potential glyph sets.

The [common schema](./nomo-common-schema.md) does specify a related pair of glyph sets: the widely used [Unicode standard](https://www.unicode.org/main.html). Unicode defines a set of positive integers, a set of two-dimensional shapes (characters), and a mapping between the two sets. For further detail, including rules for handling ambiguous mappings between characters and underlying code point integers, see [common schema](./nomo-common-schema.md).

##### 3.1.4.2 Negotiation - Authority string

The first level of qualification in a qualified resource name is the authority string. An authority string declared by one party is recognized by another party if and only if the recognizing party chooses to recognize it.

Even the [common schema](./nomo-common-schema.md) does not provide a mechanism for establishing or agreeing upon ownership of an authority string. The authors of this standard regard this as an authentication question which is delegated to any mechanism of authentication which cooperating parties agree to use. The name "authority" was chosen for concept equivalence to a forthcoming distributed authentication protocol described by the same authors of this standard, but Nomo itself does not require or demand any particular choice of authentication system.

##### 3.1.4.3 Deterministic operations

**If** parties agree to recognize each other's respective glyph sets and authority strings, **then** Nomo provides clear definitions so that the parties can understand the semantics of any identifier declared by any of the parties, and can deterministically answer whether any two identifiers are equivalent or are related in specific ways.

#### 3.1.5 Durability

A second order goal of all the characteristics described above is that Nomo identifiers may be durable over time and context. While the authors intend to solve some immediate problems in distributed computing, they also aim to provide a means of establishing identifiers that can be communicated, understood, and continuously used across changing cultural and political boundaries, over indefinitely long time spans, and in addition to provide a rational scheme for assigning identifiers to natural and historical concepts and artifacts. Prime examples here include identification of persons, properties, documents, or industry and scientific standards.

Designing for durability is a key reason that the common schema included here is defined separately from the underlying structures. One of the most important but also arbitrary decisions in that schema is the choice of characters used as delimiters between the serialized parts of an identifier. The characters chosen (including `/`, `:`, `,`, `.`, `=`, `[`, `]`) are a function of specific cultural and industrial conditions at the time of writing. Most importantly, these characters are available on the vast majority of computer keyboards in use at the time. From that limited set of potential glyphs, these were chosen for visual distinction such that human brains intuitively perceive segmentation between parts, and for analogy to existing symbolic uses of the same glyphs in computing, mathematics, and general use.

And yet these choices are not ideal. Mechanically and visually, it would be much preferable to use some of the hundreds of symbolic glyphs already defined in the Unicode standard, which are visually distinct and not widely used in other contexts, and so unlikely to be used within identifier segments themselves, or for other confounding purposes in data serialization and transfer. But at this time, these other characters would be culturally unfamiliar to most contemporary users and difficult for them to type even if they became familiar with them. 

And so we can hope that the current common schema may be superseded in the future by a more effective choice of delimiting characters, when the simple fact of keyboard layout or other input methods makes it easier for humans to express them.

By defining the identifier structures and comparison relations independent of any particular serialization method, the Nomo standard allows humans to make different serialization choices over time while maintaining backwards compatibility, or at least intelligibility, so that serializations under differing or obsolete schemas are still easy to process.

#### 3.1.6 Platform independence
 
As a special case of the goal of durability, Nomo identifiers are designed to be independent of any institutional or technical platform, or even from any physical medium. A QRN in the abstract has nothing to do with the internet, Unicode, or computers in general. For example, a glyph set can be defined as a set of audio tones (physical vibration frequencies), an audio-based schema could add certain tones or percussive sounds to be used as delimiters, and identifiers can then be constructed from those tones which can be produced (sung or played) and consumed (heard or recorded) by both humans and machines with high fidelity. Likewise with colors, with hand motions, or any other physical pattern which can be produced and consumed by interacting parties.

This makes Nomo identifiers intentionally distinct from contemporary semantic identifiers such as domain names, URNs, or RDF, all of which are explicitly defined as embedded in a particular technical context - the contemporary internet, arbitrated by the IANA and other institutions, constrained and even defined by particulars of serialization. Those standards are further constrained to an environment where all (or most) identifiable things are understood to be digital resources available on the internet.

The common schema does provide practical decisions useful for applying Nomo to contemporary computing contexts, making common-schema-encoded QRNs a practical alternative to URNs, or to myriad other domain- or platform-specific semantic identifier schemes.
 
### 3.2 Use cases

Nomo is designed to be immediately useful in a number of contemporary distributed computing contexts, such as:

- Identifying a security principal among all possible security principals in all possible systems
- Identifying an entity within a versioned data model from among all possible versions of all possible data models
- Identifying a configuration setting from among all possible named values
- Identifying a service or service node from among all possible services or nodes

Nomo is also intentionally designed to be applicable to non-computing uses cases, such as:

- Identifying a physical asset or artifact
- Identifying a version of a section of a law, ordinance, or other rule as established or proposed in a jurisdiction
- Identifying a chemical, genome, or other well-defined scientific entity
- Identifying a version of a highly specific industry standard, such as a particular standard parameter set for a type of fastener

## 4. Structural Principles

[**Nomo: Identifier Structures**](./nomo-id-structures.md) provides the exact descriptions of the mechanical concepts from which identifiers are composed. But all of Nomo is based on several intentional constraining choices about the possible structure of identifiers. Readers may realize that all of these constraints are in fact violated both in human writing systems and in natural objects to which users may want to assign unambiguous identifiers. This tension is addressed below in section 4.2.

### 4.1 Constraints

The goal of any semantic identifier is to express meaning (information) in some relatively compact way, so that the identifier itself bears some description of the thing denoted. Humans have invented myriad ways of expressing defacto identifiers (or names), most abundantly in natural language, but also in visual arts and designs in one, two, three, or four dimensions, and in sound waves produced with or without the aid of tools (instruments). 

Any of these mediums can in fact be used to construct an identifier consistent with the Nomo standard, but from all the possible ways of expressing information Nomo constrains itself to a stack of four concept layers. All four layers are strictly **discrete**, while each layer provides a distinct type of **structure**.

|Layer|Concepts|Structure|
|-|-|-|
|1|Glyphs|**atomic**|
|2|Strings|**sequential** (sequence of glyphs)|
|3|Values|**associative** (structures of strings)|
|4|Identifiers|**semantic** (labelling of values)|

At the base are the atomic **glyphs** of an identifier. Glyphs are in turn combined in sequences to form **strings**. Strings are arranged in a limited set of structures to form simple or compound **values**. Finally, two semantically defined **identifier** types ([names](./nomo-id-structures.md#4-name) and [QRNs](./nomo-id-structures.md#10-qualified-resource-name)) are composed of a collection of values.

The structures defined at the identifier layer provide a way to express both semantic and mechanical content in addition to the human meanings expressed in the component strings of an identifier. 

#### 4.1.1 Discrete

The most basic feature of any identifier or part is that it can be unambiguously determined to be the same or different as some other identifier or part.

A both intuitive and formal definition of discreteness notes the bijection between any set of discrete structures and the natural numbers. Put simply, any set of discrete things can be counted. This is true in the case of Nomo, but it should also be noted that any and all mappings are arbitrary with respect to numeric value. That is, the discreteness of Nomo identifiers and their parts has no association with quantity or order. Any glyph, string, or identifier can be mapped to *any* integer that is not already mapped to another glyph, string, or identifier.

This intentionally excludes any means of distinguishing a string or relating identifiers by any non-discrete (continuous) means or attribute. There is no possible evaluation of *how similar* or *how close* two glyphs are. Rationally, one can evaluate discrete measures of similarity between strings or identifiers through such trivia has how many glyphs are shared between two strings, or count the total number of glyphs or strings in an identifier. But these measures of similarity have no significance in Nomo -- they do not convey meaning.

Strictly limiting identifiers to discrete patterns eliminates an infinite range of information that is often important in reality, from human communication to fundamental physics, for the benefit of also eliminating an infinite range of ambiguity.

#### 4.1.2 Atomic

The discrete structures of Nomo are all ultimately composed of discrete atoms -- glyphs. The identity of each atom (glyph) is strictly local and invariant. That is, the identification of the pattern (glyph type) that a particular glyph matches is strictly determined by that single glyph, and in turn a glyph has no substructure that has any meaning within Nomo. The identification of a complete string is in turn solely determined by the identification of each respective glyph.

This intentionally excludes any means of evaluating a string by composition or derivation of multiple glyphs, apart from the basic structure as a sequence.

Once again, this eliminates an infinite range of emergent or compositional information which is important in both human communication and fundamental physics, for the benefit of also eliminating an infinite range of complexity.

#### 4.1.3 Sequential

The identification of "which atom" within a **string** is strictly determined by sequence. The only meaningful concept is the ordinal of a glyph within the sequence. While the mapping of a given glyph type to an integer is arbitrary, the ordinal of a particular glyph within a string is strictly defined and maps directly to the natural numbers. There is a first glyph, a second glyph, etc. through the nth glyph of a string.

This intentionally excludes any other means of distinguishing a string or relating strings by any other spatial, conceptual, or mathematical relationship. That is, there are many well-defined topologies which could be composed from discrete atoms. The only structure admitted in Nomo is a finite sequence.

This too eliminates an infinite range of potential structural information for the benefit of also eliminating an infinite range of both complexity and ambiguity. Note that a limited but powerful set of structural information **is** added through the definitions of composed identifiers, but those structures are compositions of strings, not of glyphs.

#### 4.1.4 Associative

The nature of the structures defined at the identifier layer are described in detail in [**Nomo: Identifier Structures**](./nomo-id-structures.md). Those structures provide a limited set of ways in which to **associate** multiple strings to form a larger identifier. Most importantly, a **name** is a simple sequence of strings, while a **qualified resource name** is a set of names and other structures, where each part is associated with a specific predefined concept related to authentication or set theory: A principal, a set, a subset, and an element.

#### 4.1.5 Context-free

All the above attributes, and likely other related ideas, can be summarized to say that both the atoms (glyphs) and sequences (strings) of a Nomo identifier are context-free. The interpretation of a string is strictly determined by the interpretation of each glyph within the string, and the interpretation of each glyph is independent of any other possible context, including its ordinal within the string. An `A` is always an `A`, regardless of where in a string it appears.

##### 4.1.5.1 Unordered evaluation

One illustration of this is that, while the ordinal assigned to each glyph within a string is significant, the order in which the glyphs is evaluated cannot matter:

Given two Nomo strings:

`Seq 1: ( ■ , ■ , ● , ◆ )`

`Seq 2: ( ■ , ◆ , ● , ◆ )`

Both sequences of glyphs have the natural sequence of *ordinals* `( 1, 2, 3, 4 )`. The two strings are defined to be the same if and only if, for each `i` in the sequence of ordinals, the glyph at ordinal `i` in sequence 1 is the same as the glyph at `i` in sequence 2. So, evaluating in the natural ordering of `i`:

```
SameString(Seq1, Seq2) := (
      SameGlyph(Seq1[1], Seq2[1]) 
  AND SameGlyph(Seq1[2], Seq2[2]) 
  AND SameGlyph(Seq1[3], Seq2[3]) 
  AND SameGlyph(Seq1[4], Seq2[4])
)
```

The additional point here is that the sequence of ordinals `( 1, 2, 3, 4 )` can also be treated as an unordered set of ordinals `{ 1, 2, 3, 4 }`, which is equivalent to `{ 2, 4, 1, 3 }`, or `{ 4, 3, 1, 2 }`, or any other permutation. The result of `SameString(Seq1, Seq2)` likewise **must** be the same regardless of the order in which the individual glyphs are compared:

```
SameString(Seq1, Seq2) := (
      SameGlyph(Seq1[1], Seq2[1]) 
  AND SameGlyph(Seq1[2], Seq2[2]) 
  AND SameGlyph(Seq1[3], Seq2[3])
  AND SameGlyph(Seq1[4], Seq2[4])
) = (
      SameGlyph(Seq1[2], Seq2[2]) 
  AND SameGlyph(Seq1[4], Seq2[4]) 
  AND SameGlyph(Seq1[1], Seq2[1]) 
  AND SameGlyph(Seq1[3], Seq2[3])
) = (
      SameGlyph(Seq1[4], Seq2[4]) 
  AND SameGlyph(Seq1[3], Seq2[3]) 
  AND SameGlyph(Seq1[1], Seq2[1]) 
  AND SameGlyph(Seq1[2], Seq2[2])
) ... etc
```

Any system of pattern recognition that yields a different answer for the sameness of two strings depending on the order in which the glyphs is evaluated is incompatible with Nomo.

##### 4.1.5.2 Indistinguishable permutations

A second illustration emphasizes that the identity of a glyph is independent of where it is found within a string. 

Imagine a sequence of index cards. On the bottom of each card, a different symbol is printed. On the top a glyph is printed.

```
Glyph    A     A     A     A
------  ---   ---   ---   ---
Card     ♠     ♥     ♦     ♣
```

Understanding the glyphs as a Nomo string, we have the sequence `( A, A, A, A )`, or four consecutive capital Latin letter "A"s.

The cards themselves can be reordered in any of `4!` = 24 permutations. Regardless, because the same glyph is printed on each card, the resulting string of glyphs remains `( A, A, A, A )`.

By definition, all 24 of these sequences are in Nomo the **same** string. The additional context denoted by the symbol on the bottom of each card, which does allow us to distinguish one card from another, is strictly out of scope for evaluating the glyphs themselves. Any system of pattern recognition that recognizes that `A` is the only glyph used, but somehow also distinguishes `A-on-♥` from `A-on-♦`, is incompatible with Nomo.

### 4.2 Violations and resolutions

The combination of context-free atomic glyphs and simple sequential strings is essential to the simplicity and non-ambiguity of Nomo identifiers. This in turn serves the above noted purposes of both mechanical clarity and uniqueness. 

And yet, many of the world's scripts include compound constructions that on the surface violate the atomicity of glyphs, the strictly sequential nature of strings, or both. It is very much intended that humans will use natural language in many different scripts to compose the component strings of identifiers, so this needs to be addressed.

In addition, it is an intended and supported use case to sometimes embed limited structured data into an identifier itself, including some data that is not intrinsically sequential.

While both situations present a challenge to Nomo's spartan design, they are fully addressed.

#### 4.2.1 Compound glyphs

In any of the mediums contemplated by the authors, including of course natural writing systems as encoded in Unicode, it is common for non-sequential clusters of information to be embedded in an otherwise sequential structure. 

A musical composition may contain overlapping sustained sounds from multiple instruments, or multiple tones from the same instrument. Military service ribbons are generally a one-dimensional sequence of colors encoded as a piece of ribbon, but occasionally contain two dimensional features such as angled bars or small pictograms. And writing systems often contain compound glyphs that either visually or even conceptually are a combination of other glyphs or annotations that may or may not appear independently in a sequence.

In all these examples, there is a well defined sequence in time or space for the pattern as a whole, but at each location in that sequence there might be multiple overlapping values which are discrete and identifiable not ordered in relation to each other.

These features of extant identifiers and writing systems present a challenge to the intentionally strict constraints in Nomo of atomic glyphs and context-free sequences. Nomo strictly prohibits glyph-specific attributes or multi-glyph rules, such as to express that the single glyph `ß` is equivalent to the two glyphs `ss` in some contexts, or to express that some base glyph plus multiple combining diacritic glyphs are equivalent regardless of the ordering of the trailing combining diacritic glyphs, which are in turn all equivalent to a single composed glyph, such as in the following Unicode sequences:

```
  ṩ   =   s  +   ̣   +   ̇   =   s   +   ̇    +   ̣  
1E69    0073   0323   0307   0073    0307    0323
``` 

If the above Unicode code points are to be treated as glyphs in a Nomo string, then all three sequences above are unambiguously different. As Unicode makes the mapping of discrete patterns to integers explicit, the above sequences are, in decimal:

```
(7785)
(115, 803, 771)
(115, 771, 803)
```

The additional cultural context which causes these sequences to be regarded as or visually appear to be equivalent when mapped with Unicode and rendered in a digital font *cannot* be considered in the context of a valid Nomo string.

Nomo resolves this by distinguishing between abstract identifier values themselves and their encoded representations. For the usual case where the encoding of an identifier is itself a one-dimensional sequence of glyphs, [Nomo: Schema Primitives](./nomo-schema-primitives.md) provides a formal description of how encoding, decoding, and validation algorithms can be combined to specify a **schema**. The algorithms in a schema can be used to resolve ambiguities in encoded identifier strings so that the evaluated strings of the identifier itself are truly context free and can always be considered a sequence of glyphs (or mapped integers) with no exceptions or qualifications.

For the specific and intended case of digitized identifiers based on human writing systems, [Nomo: Common Schema](./nomo-common-schema.md) provides a fully specified instance of a schema that relies heavily on the Unicode standard. In particular, the schema relies on normalization forms and on the existing work done to address confusable code points and sequences.

#### 4.2.2 Associative attributes

A common use case the authors anticipate is to construct an identifier that embeds a small map of named attributes. For example, this can be very useful for identifying a particular record in some record set by its unique key-value pairs. Many systems may provide a single value that can uniquely identify a record, such as an `id`, `rowid` or similar user- or system-specified attribute. But this is not always the case.

Imagine a situation where the only way--or the semantically preferable way--to uniquely identify a particular record is to note the values of each of four fields `domain`, `set`, `key`, and `version`. In this case we have four key-value pairs, which have no intrinsic ordering relative to each other. This yields `4!` = 24 possible orderings of the key-value pairs in an identifier which contains them, an apparent ambiguity when considering the strictly sequential, context-free evaluation of Nomo identifiers.

This is resolved by the fact that Nomo natively describes an [associative array (map) structure](./nomo-id-structures.md#7-map) which may be included in the value of some identifiers, and again distinguishes between the values of an identifier itself and the one or many ways in which an identifier may be serialized.

In this example we could use the common schema to *write down* one of these row identifiers in any number of ways that would all be valid:

```
big-db:row[domain=mz,key=xy86,set=bc-34,version=23]
big-db:row[domain=mz,version=23,key=xy86,set=bc-34]
big-db:row[set=bc-34,key=xy86,domain=mz,version=23]
big-db:row[key=xy86,domain=mz,version=23,set=bc-34]
... etc ...
```

However, none of the above *serializations* is a Nomo identifier itself. Instead, they are equivalent encodings of a QRN with a group name `big-db`, an element name `row`, and an element key containing a map with four entries:

|key|value|
|-|-|
|domain|mz|
|set|bc-34|
|key|xy86|
|version|23|

The key-value pairs in a primitive Nomo map structure are by definition unordered, and two maps are compared to each other by matching the respective keys through the same exact simple glyph-sequence comparison. The ambiguity in forcing an unordered map into a single ordered string encoding does not exist in the identifier itself.

Note there are no `:` ,`[`, `,`, or `=` glyphs at all in the identifier itself in this example. As with key-value ordering, those are artifacts of the serialization process which is specific to the common schema.

## Appendix 1: Examples

To the point, here are several examples of [qualified resource names](./nomo-id-structures.md#10-qualified-resource-name) rendered in the [common schema](./nomo-common-schema.md). These have not been published by the organizations cited, but are instead included as examples of how QRNs could be used in context.

### X1.1 Computing and digital recordkeeping

The immediate use cases for Nomo include computing and digital record keeping. The following examples illustrate possible uses of QRNs in this domain, while also illustrating the general purpose and semantic intent of the parts of a QRN.

#### X1.1.1 ECMAScript Object.prototype.toString

```
ecma/es[11]::api:Object.prototype.toString
```

- `ecma` is the [authority](#451-authority), indicating that the organization [Ecma International](https://www.ecma-international.org/) declares this identifier
- `es` is the [set name](#452-set), denoting here the set of concepts described in the [ECMAScript language specification](https://tc39.es/ecma262/)
- `[11]` is the [set key](#452-set), denoting here the [11th version of the language spec (ECMAScript 2020)](https://262.ecma-international.org/11.0/)
- `api` is the [group name](#453-group), denoting a group of identifiers which represent the global API, as defined in [Section 18 - The Global Object](https://262.ecma-international.org/11.0/#sec-global-object)
- `Object.prototype.toString` is the three-part [element name](#454-element) [`object`, `prototype`, `toString`], denoting here the `toString` prototype method of the `Object` type, described in [19.1.3.6 Object.prototype.toString()](https://262.ecma-international.org/11.0/#sec-object.prototype.tostring).

#### X1.1.2 IRS Form 1040

```
US-IRS/forms[1982]::1040
```

- `US-IRS` is the authority, indicating that this identifier is declared by the United States Internal Revenue Service
- `forms` is the set name, denoting here the set of forms published by the IRS
- `1982` is the set key, denoting here the set of forms specifically as published in 1982
- `1040` is the element name, denoting form 1040

#### X1.1.3 Caffeine

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


## Appendix 2: Introduction versioning

This appendix describes the versioning policy for this document alone.

### X2.1 Draft versioning

#### X2.1.1 Major version 0

Major version 0 represents the initial draft form of this document. Changes to content and structure should increment the minor version and reset the patch version to 0. The patch version may be incremented if the only changes are cosmetic, such as correcting typos or punctuation. 

Major version 0 provides no guarantees on structure or content. 

#### X2.1.2 Major version 1

This document shall be updated to major version 1 only when its status is regarded as no longer a draft. At the minimum, all normative documents referenced by this introduction have been published with a major version 1.

### X2.2 Contract

#### X2.2.1 Major version

Excluding [major version 0](#major-version-0), any major version of this document guarantees stability in the location and general topic of each numbered section. 

Within a major version, a numbered section may be struck but must still be physically present with appropriate annotation so that references to that section remain valid.

Reassignment of an existing section number to a new topic requires a new major version of the document.

#### X2.2.2 Minor version

The minor version of this document must be incremented with any meaningful change to the content or presentation of any numbered section, including the section title. Numbered sections may be struck via annotation, and new numbered sections may be added, but the general topic of each existing numbered section may not be changed from one minor version to the next.

#### X2.2.3 Patch version

The patch version of this document may be incremented if the only changes are cosmetic, such as correcting typos or punctuation, or changing presentation annotations such as for print layout.

### X2.3 References to this document

References to this document should generally be cited by major and minor version, excluding a patch version. Starting with major version 1, some references may appropriately refer to only the major version of this document.

References to specific parts of this document should use a section number, not a page number. 

### X2.4 Pagination

Any version of this document may or may not include pagination or other physical layout annotations. These are not guaranteed to be stable between any version, and should not be relied on in references.