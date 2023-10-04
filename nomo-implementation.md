# Nomo: Software Implementations
 
version `0.0.1` • 2023-10-04

## Appendix 1: Implementation notes

The specification above describes abstract concepts, not software. That said, the authors intend and expect there to be many implementations of these concepts in software. This appendix includes further notes and some normative requirements for software implementations of the Nomo identifier structures.

### X1.1 Immutability

This appendix defines a variety of structures and functions that should be used to implement this standard in software. One consistent requirement is that many of the structures must be immutable. A programmatic reference to any of these structures must provide the implicit guarantee that the content of the structure referenced will never change. This applies both to context data such as glyph sets and mappings and to identifier structures themselves. 

Structures are therefore built up using initializing functions, or through incremental builder functions which accept an existing structure plus data representing some incremental change, and return a new structure which contains both the input structure and the incremental change. 

This specification uses names for structures and functions for clarity. Implementers do not need to use the names, but do need to provide implementations of the denoted concepts.

Likewise, implementers could choose to implement composed or derived versions of functions as long as the functionality described here is supported. For example, an implementation could support adding multiple reference entries at once, as this is just a composition of applying the WithReference function defined here multiple times.

### X1.2 Glyphs

Implementations may either explicitly represent glyphs, glyph sets, and compatibility mappings, OR may implicitly support exactly one glyph set.

### X1.3 Context

All implementations should ensure a context is explicitly represented, and that any context instance is immutable. 

#### X1.3.1 Structure

A context contains a collection of **glyph sets**, **compatibility mappings**, and **reference entries**. 

Implementations that support only one implicit glyph set do not need to represent glyph sets or compatibility mappings.

#### X1.3.2 Functions

Because context instances must be immutable, context must be built up by taking an existing context and adding an item, using the three functions described below. These functions could be implemented as functions that accept a base context as an argument, or as methods defined on a context instance in languages that support it. 

The three context building functions all require an existing input context. Implementations must therefore provide either a single predefined instance of an empty base context, or provide a means to create a new empty context.
 
##### X1.3.2.1 WithGlyphSet

WithGlyphSet accepts a base context and a glyph set, returning a new context that contains the glyph set.

Implementations that support only one implicit glyph set can omit this function.

##### X1.3.2.2 WithMapping

WithMapping accepts a base context and a compatibility mapping and returns a new context that contains the additional mapping.

Implementations that support only one implicit glyph set can omit this function.

Implementations that support multiple glyph sets may choose to allow or not allow multiple mappings between each unique pair of glyph sets. If implementations allow multiple mappings between a pair of glyph sets, then the mappings must be checked in reverse order.

##### X1.3.2.3 WithReference

WithReference accepts a base context, a string reference key, and any identifier structure for the reference target value. Implementations must allow reference keys to be redefined in derived contexts.

The collection of reference entries in a context must be ordered. When expanding references, the reference entries must be checked in reverse order of their definition.

Implementations that support multiple glyph sets must enforce that the key and value of a reference entry use the same glyph set, but must allow each entry in the set of reference entries to use a different glyph set.

### X1.2 Comparison

  
Any identifier that includes a reference requires a context to understand. Likewise, comparison of any two identifier structures that do not have the same glyph set requires context. This means that, although the `same`, `in`, and `contains` comparisons are described as binary operators in the specification above, they could be considered functions which require three arguments: a left operand a right operand, and a context.

