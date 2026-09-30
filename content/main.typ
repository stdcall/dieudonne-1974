// Change this one flag: true = the Russian red cover, false = ochre.
#let use-russian-cover = false
#set document(
  title: "Геометрия классических групп",
  author: "Ж. Дьёдонне",
  date: none,
)
#import "frontmatter/cover-russian.typ": russian-cover
#import "frontmatter/cover-ochre.typ": ochre-cover
#if use-russian-cover { russian-cover() } else { ochre-cover() }
#pagebreak()
#import "book-style.typ": book-style
#show: book-style
#counter(page).update(2)
#import "frontmatter/title.typ": french-title
#french-title()
#import "frontmatter/publication.typ": publication-page, russian-title
#russian-title()
#publication-page()
#include "00-prefaces.typ"
#pagebreak()
#counter(page).update(9)
#include "11-linear-semilinear.typ"
#include "12-dilatations-transvections.typ"
#include "13-involutions-semiinvolutions.typ"
#include "14-projective-involution-centralizer.typ"
#include "15-correlations.typ"
#include "16-reflexive-correlations.typ"
#include "17-orthogonality.typ"
#include "18-equivalence-of-forms.typ"
#include "19-unitary-group.typ"
#include "20-t-forms.typ"
#include "21-t-form-properties.typ"
#include "22-quasireflections.typ"
#include "23-unitary-semiinvolutions-one.typ"
#include "24-unitary-semiinvolutions-two.typ"
#include "25-commuting-correlations.typ"
#include "26-quadratic-forms-characteristic-two.typ"
#include "27-classical-group-generalizations.typ"
#include "31-linear-group-structure.typ"
#include "32-special-linear-structure.typ"
#include "33-unitary-generators.typ"
#include "34-unitary-t-subgroup.typ"
#include "35-unitary-quotient.typ"
#include "36-orthogonal-commutator.typ"
#include "37-clifford-algebra.typ"
#include "38-orthogonal-structure-one.typ"
#include "39-orthogonal-structure-two.typ"
#include "40-orthogonal-characteristic-two.typ"
#include "41-orthogonal-defective.typ"
#include "42-anisotropic-unitary-groups.typ"
#include "43-unitary-similitude-structure.typ"
#include "51-projective-geometry.typ"
#include "52-grassmann-adjacency.typ"
#include "53-isotropic-adjacency.typ"
#include "54-isotropic-adjacency-continuation.typ"
#include "55-other-characterizations.typ"
#include "61-general-linear-automorphisms.typ"
#include "62-special-linear-automorphisms.typ"
#include "63-symplectic-automorphisms.typ"
#include "64-unitary-automorphisms.typ"
#include "65-orthogonal-automorphisms.typ"
#include "66-projective-linear-symplectic-automorphisms.typ"
#include "67-projective-classical-automorphisms.typ"
#include "68-classical-isomorphisms.typ"
#include "69-classical-isomorphisms-continuation.typ"
#include "71-appendix.typ"
#include "80-bibliography.typ"
#include "88-symbol-index.typ"
#include "89-subject-index.typ"
#include "90-contents.typ"
#include "91-publisher-message.typ"
#include "92-colophon.typ"
#include "93-publisher-announcement.typ"
