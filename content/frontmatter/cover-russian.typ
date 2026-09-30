// Геометрия обложки русского издания: круг и набор без фактуры бумаги.
#let russian-cover() = {
  set page(
    width: 140mm,
    height: 210mm,
    margin: 0pt,
    fill: rgb("a93416"),
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
  place(top + center, dy: 12mm, text(
    size: 43pt,
    fill: rgb("fff8df"),
  )[Ж. ДЬЁДОННЕ])
  place(top + left, dx: 29.5mm, dy: 56mm, circle(
    radius: 36mm,
    fill: rgb("fff8df"),
    stroke: none,
  ))
  place(top + left, dx: 29.5mm, dy: 72mm, block(width: 72mm)[
    #set align(center)
    #set text(size: 22pt, weight: "semibold")
    #set par(leading: 8mm)
    ГЕОМЕТРИЯ \
    КЛАССИЧЕСКИХ \
    ГРУПП
  ])
}
