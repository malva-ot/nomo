# Nomo: Identifier Structures
 
version `0.18.0` • 2023-09-14

## 1. Introduction

Nomo is a standard for constructing identifiers that are unique, semantic, and mechanically easy to process. Nomo describes identifiers that are not bound to any institutional or mechanical infrastructure, nor to any central authority. Its purpose is to facilitate systematic cooperation and distributed recordkeeping by providing a stable framework for producing and consuming identifiers that are mutually intelligible and stable across many cultures and contexts, over arbitrarily short or long time spans.

For an extended introduction to the Nomo standard, see [Nomo: Introduction](./nomo-intro.md).

### 1.1 Identifiers

This document contains the first layer of the formal specification of Nomo: the **identifier structures**. The identifier structures form the theoretical and mechanical foundation of Nomo. They are designed and intended to be normative and permanent.

Nomo identifier structures are abstract ontological or mathematical concepts. They do not imply or require anything with regards to implementation, and impose no constraints besides those explicitly noted. Practical orthographic and protocol decisions for an implementation of QRNs in distributed record keeping is provided in the [common schema](./nomo-common-schema.md).
 
### 1.2 Layers

Nomo defines the identifier structures is four incremental layers. For additional conceptual background, see [Nomo: Introduction - Structural Principles](./nomo-intro.md#4-structural-principles). In addition, [references](#9-reference) constitute a fifth layer that facilitate communication and processing of identifiers and structures.

#### 1.2.1 Atomic (Glyphs)
 
All Nomo structures are ultimately composed from atomic glyphs:

  - [**glyph type**](#211-glyph-type) - A single unique reproducible pattern unit
  - [**glyph set**](#212-glyph-set) - A set of glyph types
  - [**glyph**](#213-glyph) - A representation of a glyph type

#### 1.2.2 Sequential (Strings)

Glyphs are assembled in sequences called strings:

  - [**string**](#3-string) - A sequence of zero or more glyphs from a glyph set

#### 1.2.3 Associative (Values)

Strings can in turn be assembled in sequences called **tuples** or in associative **maps**. These more general structures are recursive, and can also contain **null** values or even full **QRNs**. Collectively, these structures are called **values**. 

The definition of "value" is intrinsically circular to the definitions of "map", "tuple", and "QRN", because a value **is** a placeholder for a string, tuple, map, null, reference or QRN, while at the same time tuples, maps, and QRNs are compound and potentially recursive arrangements of values. 

Although the exact definition of **value** allows QRNs and references, the following four types are described as the incremental **associative** structure layer:

  - [**value**](#5-value) - A compound structure
  - [**tuple**](#6-tuple) - A sequence of values
  - [**map**](#7-map) - An unordered map of string keys to values
  - [**null**](#8-null) - The absence of any value

#### 1.2.4 Semantic (Identifiers)

Nomo is after all a standard for identifiers, and two semantic structures are defined for use directly as identifiers: 

  - [**name**](#4-name) - A simple sequence of zero or more strings
  - [**qualified resource name**](#10-qualified-resource-name) - A composition of names and values that constitutes a complete identifier

#### 1.2.5 Processing (References)

This specification does introduce one final concept which is not an identifier value per se, but a well-defined means of incrementally composing structures and identifiers through substitution. 

  - [**reference**](#9-reference) - A simple string key which maps to a full value previously defined. Reference values themselves a strings, composed of glyphs as any other string, but their meaning is context-dependent.

#### 1.2.6 Identifier Terminology

The Nomo standard, including this specification, distinguishes between data structures in general and "identifiers" proper. 

When used without qualification, the word "identifier" always means either a name or a QRN. This reflects the design that only names and QRNs are intended to be used as identifiers themselves. 

But this specification also defines a variety of other structures and values. The terms "structure", "value", and "identifier structure" are used interchangeably to mean any of the structures defined in this specification, including names and QRNs.

### 1.3 Content and Context

All Nomo structures have both content and context. 

#### 1.3.1 Content

As described in detail below, the content of a [**glyph**](#2-glyphs) is a single atomic pattern value. The content of a [**string**](#3-string) is a sequence of glyphs. The content of all other types is a set of strings in defined structures.

#### 1.3.2 Context

All Nomo structures have as their context a glyph set. It is categorically prohibited to construct a single value whose constituent parts use different glyph sets.

In addition to the glyph set, the compound types [**tuple**](#6-tuple), [**map**](#7-map), and [**QRN**](#10-qualified-resource-name) may include embedded [**references**](#9-reference). Reference definition and expansion occurs within a single immutable graph. This reference graph is the required additional context to evaluate any reference.

Finally, for situations where more than one identifier are being compared -- including when evaluating references to expand them -- the context may include one or more [compatibility mappings](#25-compatibility-and-equivalence) between different glyph sets.
 
### 1.4 Terms

- "This document" refers to this specific document: "Nomo: Identifier Structures", as distinct from the additional documents or other media which constitute the Nomo standard as a whole.
- "This specification" refers to the normative sections of this document.

#### 1.4.1 Comparison terms

The most basic task when evaluating identifiers is to determine whether two identifiers are the same. Some [other relations](#10-relations) may also be determined due to the semantic structure of [qualified resource names](#10-qualified-resource-name). This specification takes care to use or not use the following terms to describe comparisons: 

##### 1.4.1.1 Same

This specification includes many descriptions of how two given structures or identifiers may evaluated to be the **same** or not.

##### 1.4.1.2 Equivalent

**Equivalent** is a conceptual synonym for "same", but in this specification that term is reserved to describe a formal mapping between a single glyph type in one set with a single glyph type in another set, as described in [2.5 Glyphs: Compatibility and equivalence](#25-compatibility-and-equivalence). 

##### 1.4.1.3 Compatible

**Compatible** is an adjacent term to "same", but in this specification is reserved to describe the formal injective mapping between two glyph sets, as described in [2.5 Glyphs: Compatibility and equivalence](#25-compatibility-and-equivalence). 

##### 1.4.1.4 Equal

**Equal** is also a conceptual synonym for "same", but is absolutely excluded from this specification in favor of "same". "Same" is preferred over "equal" to avoid any implication of quantity or ordering associated with glyph types or identifiers.  

Likewise, "sameness" is also used where "equality" would be conceptually synonymous.

### 1.5 Versioning

Each independent specification document of Nomo is versioned strictly according to semver 2.0. Nomo does not describe a software system, but it does describe a mechanical, verifiable contract of concepts and relations.

## 2. Glyphs

### 2.1 Definitions

The atoms of any Nomo identifier are the glyphs from which it is assembled. The following definitions imply a means to determine whether any given glyph corresponds to a glyph type within a particular set. Such an implementation is not defined in this specification, rather it is an assumed precondition.

#### 2.1.1 Glyph type
A **glyph type** is a single discrete pattern which can be consistently represented and recognized. 

#### 2.1.2 Glyph set
A **glyph set** is a set of one or more distinct glyph types. 

#### 2.1.3 Glyph
A **glyph** is an instance of a representation a glyph type. 

### 2.2 Characters

In most use cases immediately contemplated by the authors, a glyph type means either a specific integer or an orthographic pattern: a shape that can be recognized and distinguished by some biological or synthetic visual system. A distinct orthographic shape is usually called a character.

Likewise in these use cases a glyph set means a finite set of integers, or a finite set of distinct orthographic shapes (characters).

Character encodings used in contemporary computing provide mappings between integers and orthographic shapes, so that in practice a glyph set is understood by a computer as a set of integers, while the same glyph set is understood by a human as a set of characters. The character encoding provides the mapping between the two sets. 

### 2.3 Alternative mediums

The term glyph implies a two-dimensional pattern in the manner of a character in a human natural writing system, but any discrete pattern in any medium that can be consistently reproduced and recognized can be used as a glyph type. As glyphs are the atoms of which all Nomo identifiers are built, Nomo identifiers of any complexity can likewise be constructed or evaluated in any medium which can be used to express and recognize glyphs.

### 2.4 Collation and comparison

Many natural writing systems have cultural rules about the ordering (collation) of written characters, or about equivalence between different representations of the "same" character. Nomo recognizes no such rules. Each glyph type is strictly distinct from every other glyph type in a glyph set. The only meaningful evaluation between two glyphs types or glyphs is whether they are the same or different.

### 2.5 Compatibility and equivalence

Two distinct glyph sets are **compatible** if there is defined an unambiguous (injective) mutual mapping between at least one glyph type in one set with a glyph type in the other set. Two distinct glyph sets are **fully compatible** if both sets have the same count of glyph types, and for every glyph type in one set there exists an unambiguous mutual mapping to one glyph type in the other set. In other words, two glyph sets are fully compatible if there is a bijective mapping between them.

Between compatible glyph sets, a mutually mapped glyph type in one set is **equivalent** to the glyph type in the other set to which it is mapped, and vice versa.

When comparing two identifiers, where the respective glyph sets of the two identifiers are compatible, a particular glyph in one identifier is **equivalent** to a particular glyph in another identifier if the glyph type that the glyph in the first identifier represents is equivalent to the glyph type which the glyph in the other identifier represents.

## 3. String

### 3.1 Definition 

A Nomo **string** is a sequence of zero or more glyphs from the same glyph set.

The term "string" is chosen for agreement with common usage in computing, but again does not imply any constraint on the medium used to define a glyph set or compose as string. The only defining feature of a string is that it is a finite sequence of glyphs. An algorithm that produces a finite sequence is not a string, but the sequence it produces is. 

An empty string of zero glyphs is a conceptually valid Nomo string, though some schemas may include rules which prohibit empty strings in some or all cases. Serializations of such strings usually require delimiters for disambiguation, but the underlying string is defined as the empty sequence itself.

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
  
A name is the first of two Nomo structures which is also considered an **identifier** itself. Names provide an additional dimension of semantic representation beyond the choice and ordering of glyphs within a single string. 

The name concept itself does not define intrinsic meaning about the selection or ordering of strings within a name. It instead provides a primitive mechanical feature which may be used by humans to represent any number of meanings.

In other words, a name definitely specifies the ordering of its segments, but only humans or other parties have any opinion about what that ordering "means".

An empty name with zero segments is conceptually valid. Likewise a name may have a non-zero count of segments where one or all segments are themselves empty strings. 

Names may *not* contain null segments. All segments of a name are strings, and Nomo defines the null value to have a different type than string values. 

### 4.3 Properties

All names have the property of count (the number of constituent segments) and of length (the sum of the lengths of the constituent segments). Neither of these properties has any significance within Nomo.

### 4.4 Comparison

The only meaningful evaluation between two Nomo names is whether they are the same or different. Two names are the same if any only if:

 - The glyph sets of the two names are the same or are compatible 
 - The two names have the same count of segments
 - For all *n* from 1 to the count of segments, the string of segment *n* in one name is the same as the string of segment *n* in the other name, according to the rules described in [3. String](#3-string).

It follows that:
 - Two names composed solely of zero-length segments are the same if and only if they have the same count of segments, and the glyph sets of the names are the same or compatible
 - Two names that have zero segments are the same if and only if the glyph sets of the names are the same or compatible

## 5. Value 

### 5.1 Definitions

A **value** is a compound identifier part composed of one of the following:

 - **string**    - A single string as defined above
 - **tuple**     - A sequence of values
 - **map**       - An unordered set of key-value pairs
 - **null**      - The absence of any value
 - **reference** - A single, non-empty string whose literal value maps to an expanded value in the local context of a QRN 
 - **QRN**       - A QRN may itself be used as a value in a tuple or map

Strings are described above, while the remaining value types are described in the sections that follow.

### 5.2 Semantics

Values provide extensibility to the qualified resource name concept by providing structures that humans may use to express a wide variety of meanings.

### 5.3 Type and Comparison
 
All values have a type: string, tuple, map, null, reference, or QRN. The possible values of each type are strictly non-overlapping. As described in [6: Tuple](#64-equivalence-to-name-concept), names are in fact a special case of tuples, so names are also valid values with type tuple.
 
Two values are the same if and only if they are composed from the same or compatible glyph sets, they have the same type (with limited exceptions noted immediately below), and the constituent parts of the value are also the same according the rules in this specification:
 
  - [3.3 String: Comparison](#33-comparison)
  - [6.3 Tuple: Comparison](#63-comparison)
  - [7.3 Map: Comparison](#73-comparison)
  - [8.1 Null: Comparison](#81-comparison)
  - [9.4 Reference: Comparison](#94-comparison)
  - [10.6 QRN: Comparison](#106-comparison)

To emphasize, this means that the `same` operand is fully defined for any two operands of any of the six value types. Applying `same` to two operands of different types is fully valid and usually just returns a result of false. The two partial exceptions are for [string/name lifting](#531-lifting) and for [reference expansion](#95-expansion-and-validity). In both those cases one or both operands is first transformed.

#### 5.3.1 Lifting

Nomo defines three implicit and directional **lifting** operations which allow comparison between values of different types. 

- A **string** can be lifted to a **name**, where the resulting name contains a single segment whose value is the original string.
- A **name** can be lifted to a **QRN**, where the resulting QRN contains only an element name whose value is the original name.
- By composition, a **string** can be lifted to a **QRN**, where the resulting QRN contains only an element name, which has a single segment whose value is the original string.

Lifting implicitly occurs when a string is compared to a name, a name is compared to a QRN, or a string is compared to a QRN. It does not matter if the more primitive value is the left or right operand.

While reference values have string content, they are not themselves strings and so are not lifted. If the fully expanded result of a reference is a string or name, that result would be lifted as needed according to the same rules here.

### 5.4 Empty values

The string, tuple, map, and QRN types each have an empty value - a string with zero glyphs, a tuple with zero values, a map with zero key-value pairs, and a QRN with no defined parts. References do not allow an empty value (a reference key cannot be an empty string), although the target of a reference may be a null or empty value.

As noted above, for two values to be considered the same they must have the same type and the same or compatible glyph sets. Therefore, even for the same glyph set, the empty string, empty tuple, and empty map are three distinct values. In addition, the null value has a different type and is therefore a distinct value which is not the same as any of the empty values of the string, tuple, or map types.

### 5.5 Root values

In a free evaluation context any type of [**value**](#5-value) can be used as a root value by itself.

Nomo **does** specifically define **names** and **QRNs** as the two value types that are intended to be used as identifiers. So when a root value is a QRN or a name, then Nomo defines this to represent an identifier -- a symbolic datum used to denote some other thing.

When a root value is any other type, Nomo has no opinion about what this *means*. Nomo simply asserts that all six types of value are well defined and that it is mechanically valid to use or evaluate any of the six types by themselves.
 
### 5.6 Numeric or other value semantics

The tuple and map types allow for values that resemble general purpose data structures used in digital data storage, processing and exchange. That is not their purpose, and Nomo is not designed to be a universal data structure representation standard.

Specifically, Nomo values are exclusively composed of strings - of sequences of atomic pattern types (glyph types) that have no intrinsic meaning or comparison besides whether they are the same or different. Considering the additional numeric-symbolic meaning of the glyph "9", let alone the collective numeric interpretation of the string "-3.1415", is strictly outside the scope of Nomo. It follows that there are no multi-glyph types besides "string".

All other types and identifiers (name, tuple, map, QRN) are in turn simply logical arrangements of strings. Nomo does not and will never define numeric, chronological, or any other data type whose meaning depends on the symbolic human ideas associated with a glyph or string. 

Put yet another way, there are no *data types* in Nomo, just a handful of string arrangements.

## 6. Tuple

### 6.1 Definition

A **tuple** is a sequence of zero or more values. The values of a tuple may themselves be string, tuple, map, null, reference, or QRN values.

### 6.2 Properties

Tuples have the property of count (the number of elements), but this property has no significance within Nomo.

### 6.3 Comparison

Two tuples are the same if and only if:

- The glyph sets of the two tuples are the same or are compatible 
- The two tuples have the same count of elements
- All references contained in either tuple can be fully expanded
- For all *n* from 1 to the count of elements, the fully expanded value of element *n* in one tuple is the same as the value of element *n* in the other tuple, according to the rules described in this specification.

### 6.4 Equivalence to Name concept

As defined above, a name is a sequence of string segments. Likewise, a tuple is a sequence of values which might all be strings. 

A **name** therefore **is** a tuple where all the values are strings, and likewise a tuple where all the values are strings **is** a name. 

Note that the null value is not a string, so a tuple which contains a null element is not a name, and likewise a name can contain an empty string segment but cannot contain a null segment.

The identity relation between a name and a tuple of strings has no meaningful implication for QRNs, which are the ultimate purpose of this specification. However, where software implementations or logical analyses of Nomo allow or execute comparisons between arbitrary identifiers, they must evaluate a "tuple" value to be the same as a "name" value if the underlying sequences of strings of the respective values would be evaluated as the same.

This identity also applies to [lifting](#531-lifting): If `same` is applied to two operands, where one is a QRN and one is a tuple, and the tuple is also a name (all segments are strings), then the tuple is lifted to a QRN before comparison.

## 7. Map

### 7.1 Definition

A **map** is an unordered set of key-value pairs, where each key is a string and each value is a string, tuple, map, null, reference, or QRN.

The keys within a map must be unique. Uniqueness is strictly defined according to the string comparison rules described above (see [3.3 String:  Comparison](#33-comparison)).
 
### 7.2 Properties

Maps have the property of count (the number of key-value pairs), but this property has no significance within Nomo.

### 7.3 Comparison

Two maps are the same if and only if:

 - The glyph sets of the two maps are the same or are compatible 
 - The two maps have the same count of key-value pairs
 - All references contained in either map can be fully expanded
 - For each key *k* in one map, the same key exists in the other map, and the fully expanded value associated with *k* in the first map is the same as the fully expanded value associated with *k* in the other map, according to the rules described in this specification.

### 7.4 Subset relations

According to the definitions above, any given pair of maps can also be evaluated to determine if there is a strict subset or superset relation between the two maps. Although well-defined, such relations have no particular meaning or significance within Nomo. 

## 8. Null

A **null** value is the absence of any value. Although the null value does not contain any glyphs, it is still defined in reference to an associated glyph set.

### 8.1 Comparison

Two null values are the same if and only if the glyph sets of the values are the same or compatible. 

As noted above, a null value is not the same as an empty string, map, or tuple value, even if the respective glyph sets are the same or compatible.

## 9. Reference

### 9.1 Definition

A reference is a simple placeholder string value mapped to another value.

### 9.2 Properties

A reference has the property **value**, which is the literal string value of the placeholder.

### 9.3 Terms
 
For clarity in discussion of references, the following terms are used:

- **reference context** or **reference map** is the map of defined reference entries
- **reference key** is the string key of a defined reference entry
- **reference target** is the value of a defined reference entry
- **reference value** or just **reference** is the string literal placeholder used as a value in an unexpanded host structure
- **host structure** is the identifier or structure that contains the reference value

### 9.4 Context Reference Map

The definition of a reference implies a context map which contains the defined references. 

A context reference map is an ordered list of key-value entries. The key of each entry is a non-empty string, while the value is any value type. The key and the value of a single entry must use the same glyph set, but each entry in the map may use a different glyph set. 

The context reference map is called a "map" because of its key-associative character, but structurally it guarantees order but not uniqueness. Digital programs and logical evaluations of references **must** explicitly identify which specific entry in the list of reference entries should be used to evaluate (expand) a given reference value, such that subsequent additional definitions of reference entries cannot alter the expanded value of a previously stated identifier or structure.
 
Reference values are matched to reference keys per the usual [string comparison rules](#33-comparison), which can consider two strings to be the same even if they have different glyph sets, under the condition that there are mappings between each necessary glyph type from the two glyph sets. It follows that a reference value may use a different glyph set than the reference entry it is intended to match, provided the necessary mappings between the two glyph sets.
 
### 9.5 Expansion and Validity

For all meaningful comparison and evaluation operations, references must be **expanded**. This means that the literal string value of the reference is replaced by the associated reference target from the context reference map. As this expanded value may itself be a structure which contains a reference, expansion is recursive. A reference whose value has been recursively expanded until there are no remaining references is **fully expanded**.

As noted above, expansion requires identifying a specific entry in the context reference map against which to evaluate the reference. 

Starting at that entry, the reference value is compared to the key of the reference entry to determine if they are the same. If they are the same, then the target value of that entry is used. If not, evaluation moves to the previous entry in the list. 

If the beginning of the list is reached and no matching key is found, the reference is **invalid**.

When a matching entry is found, the target value must then be substituted into the structure at the location of the reference value. If the type of the target value is not allowed at the location of the reference value, such as due to schema rules which must be satisfied by the expanded value, then the reference is **invalid**. 

If the reference target value has a different glyph set than the host structure, then each glyph in the target value must be mapped to the associated ([equivalent](#25-compatibility-and-equivalence)) glyph in the glyph set of the host structure. If there are any glyphs in the reference target value that do not have a mapping to an equivalent glyph in the glyph set of the host structure, then the reference is **invalid**.

### 9.6 Comparison
 
Asking whether two reference values are the same is defined to mean asking whether their fully expanded values are the same. The answer may be false even if the literal strings of the respective reference values are the same, and may be true even if the literal strings of the respective reference values are not the same.

All **invalid references** are non-comparable. When either or both operands of the `same` operator are an invalid reference, the result is always false, even if both operands are references with the same glyph set and the same literal string values.

### 9.7 Limitations

#### 9.7.1 Merging

Reference expansion does not represent or allow merging of compound structures. 

A tuple which contains a reference, where the target is itself a tuple, will become a nested tuple when expanded. The elements of the reference target are not merged or flattened into the host tuple.

Likewise a map which contains a value that is a reference, where the reference target is itself a map, will become a nested map when expanded. This is doubly true, because it is not possible to define a reference target value that is a single disembodied map entry, nor is it possible to use a reference as a placeholder for a key-value *entry* in an host map.

#### 9.7.2 Substitution

The keys of a map are defined to be **strings**. Likewise, the authority part of a QRN is a plain **string**, and the set name, group name, and element name parts of a QRN are all **names**. A reference value is a different type that is not a string or a name, even if the matching reference target in a given context reference map is a string or name. 

Therefore, references cannot be used as the key of a map, nor for the authority, set name, group name, or element name parts of QRN.

Note that in many implementations the authority string of a QRN may essentially serve as a context-specific reference to a principal defined and authenticated elsewhere. Because this authentication process is explicitly outside the scope of Nomo, Nomo does not treat authority strings as references -- they are neither expanded nor validated.

## 10. Qualified Resource Name

A Nomo **qualified resource name** (QRN) is a composition of other Nomo structures whose parts are chosen to correspond directly to concepts in authentication and set theory. A QRN represents a fully qualified identifier, and is the ultimate purpose of this specification.
 
A QRN is composed of one optional *annotation* (schema) and six optional *parts*. All elements in a QRN must use the same glyph set:

|Part|Type|Description|
|-|-|-|
|**schema**|**value**|An arbitrary value identifying a deterministic algorithm for validating the QRN|
|**authority**|**string**|An arbitrary string identifying the universe of a set. In general, the principal which declares the identifier|
|**set name**|**name**|The identifier of a **set** itself|
|**set key**|**value**|A further qualifier on the identity of a **set** itself|
|**group name**|**name**|The identifier of a proper **subset** within a set|
|**element name**|**name**|The identifier for a specific **element** within a set|
|**element key**|**value**|A further qualifier on the identity of an **element** within a set|
 
### 10.1 Schema

If present, the schema annotation denotes an algorithm which can be applied to the QRN to determine if it is valid according to some arbitrary but deterministic rule set. This specification provides no further details about the actual existence or implementation of any such algorithm, but [Nomo: Schemas](./nomo-schemas.md) describes such algorithms in detail.

Consistent with the rest of this specification, a schema cannot alter the *meaning* of the content of the QRN, it simply denotes the existence of an additional unary boolean operator `valid`. The result of applying that operator has no effect on the [comparison operators](#11-relations) (`same`, `in`, `contains`).

As such, the content of the schema value is not part of the QRN content itself, and so is excluded in all discussions of relations and comparison.

#### 10.1.1 Bound Identifier

When a QRN does include a schema annotation, the QRN is said to be **bound**. 

#### 10.1.2 Structure

The schema annotation is a generic [value](#5-value). It can therefore contain a reference value, and that reference may be expanded to any concrete type, including a full QRN. In fact, it is the general intent that schema annotations contain references which map to full QRNs which in turn unambiguously identify some well-defined schema.

### 10.2 Authority

The authority is the root disambiguating context of a qualified resource name. Nomo itself intentionally does not provide any opinion or mechanism for allocating authority strings. Assignment, agreement, or proof of ownership of some particular authority string is an authentication concept outside the scope of Nomo.

### 10.3 Set

The set name and key represent the identifier of a set itself. The QRN concept itself as defined in this specification does not require that a set name be present if a set key is present. The set name and key are collectively called the set identifier.

When both a set name and a set key are present, this specification defines this to mean that the set name represents a set of sets which share some unifying character or attribute, while each unique key value appended to the set name represents a specific instance of such a set.

A common intended usage is to use the set name to denote a software, data, or administrative concept domain, and the key to denote a specific version of that domain.

### 10.4 Group

The group name represents the identifier of a proper subset within the set identified by the set identifier. A QRN containing only a group name expresses the concept of an identified subset independent of any particular set to which it may belong.

### 10.5 Element

The element name and element key represent the identifier of a specific element within the set identified by the set identifier or the subset identified by the group name. The QRN concept itself as defined in this specification does not require that an element name be present if an element key is present. The element name and element key are collectively called the element identifier.

When both an element name and an element key are present, this specification defines this to mean that the element name represents a set of elements which share some unifying character or attribute, while each unique key value appended to the element name represents a specific instance of such an element.

A QRN containing only an element name or key represents the concept of an identified element independent of any particular set or subset to which it may belong.

A common intended usage is to use the element name to denote a resource collection and element key to identify a specific resource within that collection: colloquially, to identify a table with the element name and a row within that table with the element key.

### 10.6 Empty and Missing Parts

As section [5.4 Empty Values](#54-empty-values) describes, the null value is not the same as the empty value of string, tuple, or map. It follows that the empty value of a given part of a QRN is not the same as a missing value for the same part: a QRN may include an authority whose value is the empty string of the glyph set used by the QRN, and this is different from a QRN which uses the same glyph set but has no authority part.

An explicit null value for a set key or element key is defined to have the same meaning as a missing key part. In addition, while neither string nor name values may themselves be null, a QRN may have a *missing* authority, set name, group name, or element name. It is conceptually equivalent to say that any of these parts is "null" or "undefined". 

To reiterate, all of the following statements are valid and equivalent:

- "This QRN does not have an authority part"
- "The authority part of this QRN is missing"
- "The authority part of this QRN is null"
- "The authority part of this QRN is undefined"

### 10.7 Comparison

Two QRNs are the same if and only if:

- The glyph sets of the two QRNs are the same or are compatible
- All references contained in any of the six parts of either QRN can be fully expanded
- For each of the six parts of a QRN, the part is undefined in both QRNs, OR the part is defined in both QRNs and the corresponding fully expanded values are the same according to the rules defined in this specification

Note that the schema *annotation* is irrelevant to comparison, both here for the `same` operator and below for the `in` / `contains` operators. Specifically, QRNs remain comparable (`same`, `in`, or `contains` *may* return true) even if the `valid` operator denoted by the QRN's schema annotation evaluates the QRN to be invalid. 

As with tuples and maps, it follows that any QRN that contains a referentially invalid reference is not the same as any other QRN, even another QRN with an invalid reference at the same location with the same literal string value. However, this restriction does not apply to an invalid reference in a schema annotation. 

To reiterate, the schema annotation of a QRN has no effect at all on any of the comparison operators, even if the schema annotation contains an invalid reference, or the schema does identify a known validation algorithm and that algorithm evaluates to false on the applicable QRN.
 
## 11. Relations

### 11.1 Value relations

As noted in the sections above, Nomo does not define any relationship or comparison between string, tuple, map, null, or reference values except for sameness. One can make mathematically objective observations such as that all values within one tuple also appear in another tuple, or that two strings are the same length, but these mathematical relationships have no semantic meaning or significance in Nomo.

As an contrasting illustration, consider an internet domain name such as `mail.example.com` as represented by a Nomo name with the ordered segments (`mail`, `example`, `com`). The internet domain name system as centrally coordinated by IANA explicitly does define subset semantics such that `mail.example.com` is definitely a "subdomain" of `example.com`, which is itself a member of the "top level domain" `com`.

But Nomo itself defines no semantic relationship between the names (`mail`, `example`, `com`), (`example`, `com`), and (`com`). It only concludes that they are different names.

### 11.2 QRN relations

In addition to sameness, Nomo itself **does** define one additional boolean complementary comparison relationship between QRNs. This comparison is called **in** or **contains**. One formulation expresses whether a QRN is **in** the domain of possible identifiers denoted by a second QRN. The complementary formulation expresses whether the domain of possible identifiers denoted by a QRN **contains** another QRN.

#### 11.2.1 Operators

In summary, three operators are defined between two QRNs, with similar meanings as in standard set theory:

||Name|Example|Description|
|-|-|-|-|
|`=`|same|`A = B`|A is the same as B|
|`∈`|in|`A ∈ B`|A is in B|
|`∋`|contains|`B ∋ A`|B contains A|

Further:

 - All three operators are boolean and binary: They accept a left and right operand, and definitely evaluate to `true` or `false`. 
 - **same** is complementary to itself, i.e. it is commutative
 - **in** is complementary to **contains** and vice versa
 - All three operators are mutually exclusive: Given any left operand `A` and right operand `B`, if one operator applied to these operands evaluates to true, then the other two operators definitely evaluate to false. The converse is not implied, however: if two operators are evaluated to false it does not imply that the third operator will be true. Stated yet another way: given two operands, *at most* one of the operators may evaluate to true.

#### 11.2.2 Corollaries

The above implies the following corollaries regarding these operators:

|||
|-|-|
|`A = B ⇒ B = A`|If A is the **same** as B, then B is the **same** as A|
|`A ∈ B ⇒ B ∋ A`|If A is **in** B, then B **contains** A|
|`A ∋ B ⇒ B ∈ A`|If A **contains** B, then B is **in** A|
|`A = B ⇒ !(A ∈ B)`|If A is the **same** as B, then A is **not in** B|
|`A = B ⇒ !(A ∋ B)`|If A is the **same** as B, then A does **not contain** B|
|`A ∈ B ⇒ !(A = B)`|If A is **in** B, then A is **not the same** as B|
|`A ∈ B ⇒ !(A ∋ B)`|If A is **in** B, then A is **does not contain** B|
|`A ∋ B ⇒ !(A = B)`|If A **contains** B, then A is **not the same** as B|
|`A ∋ B ⇒ !(A ∈ B)`|If A **contains** B, then A is **not in** B|

#### 11.2.3 Subset relations

Readers familiar with set theory may note that the `∈` operator generally means "is an **element** of". This is distinct from the `⊂` operator, which means "is a **subset** of". By definition a subset is itself a set, while an element is not a set. 

The parts of a QRN by definition also express subset relations. A set name relative to some authority implies a subset of all possible identifiers relative to that same authority. The group name part by definition denotes a subset.

Given this, it could be argued that `⊂` is a more appropriate operator than `∈` unless one of the operands has a defined element name.

For two reasons Nomo intentionally chooses the `∈` / `∋` operators only. First is practical simplicity, restricting the complexity of relation concepts defined for Nomo. Second is the conceptual distinction between an identifier itself (a Nomo structure) and whatever thing that identifier *denotes*. In other words, there is a difference between the structure of an identifier, which Nomo is very much concerned with, and the *meaning* of an identifier, which Nomo has no opinion about.

Restricting this focus to identifier structure, Nomo defines the following general principal:

*For any QRN that does not contain an element key, there is exists a set of **more qualified** QRNs.*

Every QRN in this more-qualified set is an element of that set of identifiers. The QRN `ecma/es[11]::types:` may be defined to *denote* a subset, but the identifier structure itself a single element (a distinct identifier) that is in the set of more qualified identifiers relative to `ecma/es[11]::`.

In the discussion of relationships below the word "domain" is used as a synonym for "the set of more-qualified identifiers". Likewise "relative to" is used as a synonym for "**in** the set of more-qualified identifiers".

#### 11.2.4 Notation

For convenience, the following descriptions represent QRNs using [common schema](./nomo-common-schema.md) notation. The relationships hold regardless of the medium or glyph sets used for two identifiers.

The asterisk (`*`) is used to stand for *any or all identifiers* with at least one defined part in the position indicated by the asterisk. This symbolic meaning is not part of the common schema, and is only used here to illustrate the relationships described.
 
The descriptions below do use several other set relation symbols including union `∪`, intersection `∩`, strict equality `≡`, and disjoint `∅`. These are used to define the outcome of applying the **in** (`∈`) or **contains** (`∋`) operator to two identifiers. They do not imply additional formally defined comparison operations between QRNs.

### 11.3 Authority relations

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`A/*`|`∩`|`B/*`|`=`|`∅`|The domains of any two authorities are disjoint|
|`A/*`|`∈`|`A/`|||All identifiers relative to an authority are in the authority's domain| 
  
### 11.4 Set relations
  
#### 11.4.1 Unkeyed sets

An unkeyed set is a QRN with a set name but no set key.

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`x::*`|`∩`|`y::*`|`=`|`∅`|The domains of two set names are disjoint|
|`x::*`|`∈`|`x::`|||All subsets and elements relative to a set name without a key are in the domain of that unkeyed set name|
  
#### 11.4.2 Keyed sets

A keyed set is a QRN with a both a set name and a set key.

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`x[1]::*`|`∩`|`x[2]::*`|`=`|`∅`|The sets denoted by two different key values relative to the same set name are disjoint|
|`x[1]::*`|`∈`|`x[1]::`|||All subsets and elements relative to a set name with a key are in the domain of that keyed set name|
 
#### 11.4.3 Relation between keyed and unkeyed sets

The relation between a QRN with a keyed set name and a QRN with an unkeyed set name is more subtle, but is still well defined.

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`x[*]::*`|`∈`|`x::`|||All set keys relative to the same set name are in the domain of the set name without a key|
|`x::*`|`∩`|`x[*]::`|`=`|`∅`|The subsets and elements relative to a set name without a key are disjoint the the set of keyed sets relative to that same set name|
|`x::*`|`∪`|`x[*]::`|`≡`|`x::`|The union of the subsets and elements relative to a set name without a key with the set of keyed sets relative to that same set name exactly equals the entire set of possible identifiers relative to the unkeyed set name.<br><br>In other words, the subsets and elements relative to an unkeyed set name along with the set of keyed sets relative to that set name form a partition over the identifier domain of the unkeyed set name.|

#### 11.4.4 Anonymous set key

An anonymous set key is a QRN with a set key but no set name. While many schemas may define rules to disallow such QRNs, they are mechanically valid with respect to this specification.

However, Nomo defines the domains of any anonymous set to be non-comparable for the in/contains operator. The same operator is still defined and may return true when all parts of a QRN containing an anonymous set key are the same, per the rules described in this specification.

|Relation|||Description|
|-|:-:|:-|-|
|`[1]::*`|`∉`|`[1]::`|A QRN with an anonymous set key and additional parts defined is not in the domain of any other QRN, even a QRN with the same anonymous set key|

### 11.5 Group relations

|Relation|||||Description|
|-|:-:|:-|:-:|:-|-|
|`g:*`|`∩`|`h:*`|`=`|`∅`|The domains of two group names are disjoint|
|`g:*`|`∈`|`g:`|||All identifiers relative to a group name are in the group's domain| 

### 11.6 Element relations

#### 11.6.1 Unkeyed elements

Given two QRNs which contain an element name but no element key, the in/contains operators applied to these QRNs will never evaluate to true. There is no further qualification possible without an element key.

|Relation|||Description|
|-|-|-|-|
|`e*`|`=`|`∅`|The set of more qualified QRNs relative to an unkeyed element (excluding element keys) is the empty set. I.e. it is not possible to construct a more qualified QRN with an unkeyed element name relative to any other QRN with an unkeyed element name|

#### 11.6.2 Keyed elements

Given two QRNs which both contain an element name and an element key,  the in/contains operators applied to these QRNs will never evaluate to true. There is no further qualification possible.

|Relation|||Description|
|-|-|-|-|
|`e[1]*`|`=`|`∅`|The set of more qualified QRNs relative to an keyed element is the empty set. I.e. it is not possible to construct a more qualified QRN relative to any QRN with a keyed element name|
 
#### 11.6.3 Relation between keyed and unkeyed elements

|Relation|||Description|
|-|:-:|:-|-|
|`e[*]`|`∈`|`e`|All element keys relative to the same element name are in the domain of the element name without a key|

#### 11.6.4 Anonymous element keys

An anonymous element key is a QRN with an element key but no element name. While many schemas may define rules to disallow such QRNs, they are mechanically valid with respect to this specification.
 
Because it is not possible to further qualify a QRN beyond the element key, not QRN with an element key is in the domain of any other QRN with an element key, including when there is no element name defined.

|Relation|||Description|
|-|-|-|-|
|`[1]*`|`=`|`∅`|The set of more qualified QRNs relative to an anonymous element key is the empty set. I.e. it is not possible to construct a more qualified QRN relative to any QRN with an anonymous element key|

### 11.7 Lifting in subset comparisons

[Section 5.3.1](#531-lifting) above describes how string and name values can be lifted to QRNs when comparing for sameness. 

Lifting is also mechanically valid for the `in` / `contains` operators, but the result will always be false. This is because strings and names will always be lifted to QRNs with only a unkeyed element name, and per [11.6.2](#1162-keyed-elements) above, any two different QRNs with unkeyed element names are disjoint: an `in` / `contains` comparison will always return false.

The lifted values may be the same, but in that case too, by definition, `in` / `contains` would return false for any two operands where `same` evaluates to true.

In summary, it is valid to apply the `in` and `contains` operators to string and name operands, but the result will always be false.

It is *not* valid to apply the `in` and `contains` operators to values of any other type besides string, name, or QRN. The result is not a definite false as when comparing two strings lifted to QRNs, but is instead nonsense, or undefined. Implementations and logical evaluations may choose to treat an attempt to apply `in` / `contains` to anything other than a string, name, or QRN as an error condition, or may choose to return null/undefined/nothing, but should never treat the result as a definite false.

### 11.8 User-defined QRN Semantics

Nomo itself defines no semantics or relations between identifiers other than those described above. This does not prevent parties from agreeing on their own semantics for relations between identifiers that the underlying standard simply recognizes as not the same. 

A common use case here for elements within keyed and unkeyed set names is to express the identity of a concept in general in association or contrast with the identity of that "same" concept within one or more specific "versions" of a concept collection.

Example:

|||
|-|-|
|`ecma/es::api:Object`|The `Object` class in general across all versions of ECMAScript (JavaScript)|
|`ecma/es[1]::api:Object`|The `Object` class with features and APIs specifically as defined in the first edition (1997) spec|
|`ecma/es[11]::api:Object`|The `Object` class with features and APIs specifically as defined in the eleventh edition (2020) spec|

Nomo itself defines only that
- all three QRNs above are different from each other
- all three QRNs above are in the domain of possible identifiers relative to the unkeyed set `ecma/es::`
- the group and element parts of all three QRNs (`api:Object`) are the same

Humans are free outside of Nomo to recognize or even formally define a semantic equivalence or relatedness between the three identifiers as all relating to the concept of the `Object` type within JavaScript / ECMAScript. These semantics are just not part of Nomo itself.
 

