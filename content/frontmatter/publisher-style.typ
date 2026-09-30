// The three historical publisher pages have no running heads or folios.
#import "../book-style.typ": heading-anchor
#let publisher-page(body, size: 10pt) = {
  set text(size: size)
  show heading.where(level: 1): it => {
    heading-anchor(it)
    block(sticky: true, above: 1em, below: 8mm, align(center, text(
      weight: "semibold",
      upper(it.body),
    )))
  }
  page(numbering: none, header: none, footer: none, align(horizon, body))
}
#let colophon(body) = {
  set par(first-line-indent: 0pt, justify: false)
  publisher-page(align(center, body), size: 9pt)
}
