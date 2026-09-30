// Global page and text design. Source chapters contain no layout patches.
#import "numbering.typ": restart-counters
#import "statements.typ": numbered-display
#import "main-defs.typ": reference-rules, source
#let running-chapter = state("running-chapter", none)
#let running-section = state("running-section", none)
#let chapter-number(it) = numbering(
  "I",
  counter(heading).at(it.location()).first(),
)
#let section-title(it) = [§ #counter(heading).at(it.location()).at(1). #it.body]
#let opening-page() = {
  query(heading.where(level: 1)).any(it => (
    it.location().page() == here().page()
  ))
}
#let header = context {
  counter(footnote).update(0)
  if opening-page() { return }
  let folio = counter(page).display()
  let head = text.with(size: 9pt, style: "italic")
  let number = counter(page).get().first()
  let title = if calc.even(number) { running-chapter.get() } else {
    let starts = query(heading.where(level: 2)).filter(it => (
      it.numbering != none and it.location().page() == here().page()
    ))
    if starts.len() > 0 { section-title(starts.first()) } else {
      let section = running-section.get()
      if section == none { running-chapter.get() } else { section }
    }
  }
  if title == none { return }
  stack(
    dir: ttb,
    spacing: 1.5mm,
    grid(
      columns: (1.5em, 1fr, 1.5em),
      align: (left, center, right),
      if calc.even(number) { folio } else { [] },
      head(title),
      if calc.odd(number) { folio } else { [] },
    ),
    line(length: 100%, stroke: 0.45pt),
  )
}
#let heading-anchor(it) = {
  if it.numbering != none { restart-counters(it.level) }
  [#metadata((
    kind: "numbered",
    family: "heading",
    level: it.level,
    number: if it.numbering != none {
      counter(heading).at(it.location())
    } else { none },
  ))<numbered>]
}
#let book-style(body) = {
  set page(
    width: 140mm,
    height: 210mm,
    margin: (x: 15mm, top: 17mm, bottom: 15mm),
    fill: white,
    numbering: "1",
    header: header,
    footer: none,
  )
  set text(
    font: "Libertinus Serif",
    size: 11pt,
    lang: "ru",
    fill: rgb("202020"),
  )
  show link: set text(fill: rgb("202020"))
  show regex("^-\p{L}+"): it => sym.wj + box(it)
  show "–": it => sym.wj + it + sym.wj
  set par(
    justify: true,
    first-line-indent: 1em,
    leading: 0.52em,
    spacing: 0.65em,
  )
  set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 { "Глава " + numbering("I", n.first()) } else {
      "§ " + str(n.last()) + "."
    }
  })
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    let title = if it.numbering != none {
      [Гл. #chapter-number(it). #it.body]
    } else { it.body }
    running-chapter.update(title)
    running-section.update(none)
    heading-anchor(it)
    block(width: 100%, above: 5mm, below: 12mm, sticky: true, align(center, {
      if it.numbering != none {
        text(size: 12pt)[Глава #chapter-number(it)]
        linebreak()
        v(5mm)
      }
      text(size: 13pt, weight: "semibold", upper(it.body))
    }))
  }
  show heading.where(level: 2): it => {
    heading-anchor(it)
    let title = if it.numbering == none { it.body } else { section-title(it) }
    running-section.update(title)
    block(width: 100%, above: 5mm, below: 4mm, sticky: true, align(center, text(
      weight: "semibold",
      title,
    )))
  }
  show heading.where(level: 3): it => block(
    width: 100%,
    above: 0pt,
    below: 0pt,
    sticky: true,
    align(center, text(weight: "semibold", it.body)),
  )
  show outline: set par(first-line-indent: 0pt)
  show outline.entry: set block(breakable: false)
  show outline.entry: it => {
    // Provenance boundaries follow the native entries of the source TOC.
    if it.element.has("label") {
      if it.element.label == <sec:unitary-quotient> { source(202) }
      if it.element.label == <sec:classical-group-isomorphisms> { source(203) }
    }
    if it.element.has("label") and it.element.label == <ch:contents> {
      []
    } else { it }
  }
  show outline.entry.where(level: 1): set block(above: 0.8em)
  set math.equation(numbering: none, supplement: none)
  show math.equation: set text(font: "STIX Two Math")
  show math.equation: it => {
    show ":": math.class("punctuation", ":")
    show "≥": sym.gt.eq.slant
    show "≤": sym.lt.eq.slant
    it
  }
  show math.equation.where(block: true): it => {
    if it.has("label") and str(it.label).starts-with("eq:") {
      numbered-display(it)
    } else { it }
  }
  set math.cases(gap: 0.5em)
  set footnote(numbering: "1)")
  show footnote: it => {
    if it.has("label") and str(it.label).starts-with("fn:") {
      context [#metadata((
          kind: "numbered",
          family: "fn",
          number: counter(footnote).at(it.location()),
        ))<numbered>#it]
    } else { it }
  }
  show footnote.entry: set text(size: 9pt)
  show footnote.entry: it => block(breakable: false, it)
  set figure(gap: 2mm)
  show figure.caption: set text(size: 9.5pt)
  show table: set text(size: 9pt)
  show table: set par(justify: false, first-line-indent: 0pt)
  set table.cell(breakable: false)
  reference-rules(body)
}
