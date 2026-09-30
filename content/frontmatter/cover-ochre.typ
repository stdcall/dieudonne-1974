// Русский набор в геометрии охристой французской обложки.
#let ochre-cover() = {
  set page(
    width: 140mm,
    height: 210mm,
    margin: 0pt,
    fill: rgb("c69640"),
    numbering: none,
    header: none,
    footer: none,
  )
  set text(
    font: "Libertinus Serif",
    fill: black,
    lang: "ru",
    hyphenate: false,
  )
  set par(first-line-indent: 0pt, justify: false, spacing: 0pt)
  set align(left)
  place(top + left, dx: 16mm, dy: 8.5mm, text(size: 16pt)[Ж. ДЬЁДОННЕ])
  place(top + left, dx: 38.5mm, dy: 64.5mm, block(width: 96mm)[
    #set text(size: 20pt, weight: "semibold")
    #set par(leading: 4mm)
    ГЕОМЕТРИЯ \
    КЛАССИЧЕСКИХ ГРУПП
    #v(5mm)
    #text(size: 10.5pt, weight: "regular")[
      Перевод с третьего французского издания
    ]
  ])
  place(top + left, dx: 15.5mm, dy: 183mm, block(width: 112mm)[
    #set text(size: 11pt)
    #set par(leading: 2mm)
    Перевод с французского Э. Б. Винберга \
    Издательство «Мир» · Москва · 1974
  ])
}
