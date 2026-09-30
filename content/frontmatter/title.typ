#import "../main-defs.typ": source

#let french-title() = page(
  width: 140mm,
  height: 210mm,
  margin: (x: 15mm, top: 15mm, bottom: 15mm),
  numbering: none,
  header: none,
  footer: none,
)[
  #set align(center)
  #set par(first-line-indent: 0pt)
  #source(1)
  Ergebnisse der Mathematik\
  und ihrer Grenzgebiete Band 5

  #v(15mm)
  #text(size: 16pt)[Jean Dieudonné]

  #text(size: 19pt)[LA GÉOMÉTRIE\ DES GROUPES CLASSIQUES]

  #v(17mm)
  Troisième Édition

  #v(1fr)
  Springer-Verlag\
  Berlin Heidelberg New York 1971
]
