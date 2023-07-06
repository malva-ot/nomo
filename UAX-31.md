- Exclude PATTERN_WHITE_SPACE
- Include PATTERN_SYNTAX --> but require quoting
- Allow ID_START, ID_NONSTART, PATTERN_SYNTAX


- SHOULD include variation selectors because they are important for use in maintaining cultural fidelity for historical names. There is an example in the variant identifiers spec itself showing that a certain japanese city name uses an archaic variant of a particular ideograph, and generally it is culturally expected to preserve that archaic variant for its use in naming the city, even in text for a single sentence that would include different variants for that same ideograph in any other context.
  - Variant selectors are one of the kinds of characters in Default_Ignorable_Code_Points

  - NOTE: That UAX 31-2.3

  > The recommendation is to permit them in identifiers only in special cases, listed below. The use of default-ignorable characters in identifiers is problematical, first because the effects they represent are stylistic or otherwise out of scope for identifiers, and second because the characters themselves often have no visible display. It is also possible to misapply these characters such that users can create strings that look the same but actually contain different characters, which can create security problems

  BUT:

  > While not all Default_Ignorable_Code_Points are in XID_Continue, the variation selectors are included in XID_Continue. These variation selectors are used in standardized variation sequences, sequences from the Ideographic Variation Database, and emoji variation sequences. However, they are subject to the same considerations as for other Default_Ignorable_Code_Points listed above. Because variation selectors request a difference in display but do not guarantee it, they do not work well in general-purpose identifiers. A profile should be used to remove them from general-purpose identifiers (along with other Default_Ignorable_Code_Points), unless their use is required in a particular domain, such as in a profile that includes emoji. For such a profile it may be useful to explicitly retain or even add certain Default_Ignorable_Code_Points in the identifier syntax.

  QUESTION: Should qrn-base allow display form to differ from compare form? For variation sequence example, this would say that a QRN may include the variation sequence so that that specific Japanese city name could be represented in a culturally faithful way, but that at the same time it would be *compared* to other QRNs by stripping out the variant selector.

  I don't like this as a principal for base QRN because it violates the simplicity of direct glyph-sequence comparison. It could be allowable for a QRN-string...  

  Q: Is it important to say that one case/variant version of a sequence of characters is DIFFERENT from a different case/variant version of the other wise same sequence of characters?


- See Stream-Safe Text Format in UAX #15: Unicode Normalization Forms for info on how to reduce potential amount of buffered memory needed to process / normalize. E.g. because worst case NFKC/NFKD can expand code point length by 32x.


"Symbol Class" / "Exemplar Character"
To describe groups of glyphs that are visually confusable, and the single character used to generally represent their shared visual shape

How to handle SignWriting, which depends on 2D layout?


Definite goal is in used for denoting historical records and concepts, which would very much use or want to use historical scripts, so would want to allow any script. How then to disambiguate confusables? 
  - Don't use extended / full QRN as a security mechanism!
  - Script annotation
  - Security identifiers / aliases (eg. schema alias, authority) have a more strict glyph set.


  qrn[ugrc]<>