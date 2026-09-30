// The subject index is generated solely from marks at passages in the text.
#import "main-defs.typ": source
// Every locator has the original structure: chapter, section, page.
#let sort-key(path) = {
  lower(path.join(" "))
    .replace("ё", "е")
    .replace(regex("\s*\([^)]*\)"), "")
    .replace(regex("[,’'.]"), "")
}
#let dashes(body) = body.split(" ").map(_ => "—").join(" ")
#let printed-path(path, previous) = {
  if previous == none { return path.join(", ") }
  let parts = ()
  let shared = true
  for (i, part) in path.enumerate() {
    if shared and i < previous.len() and previous.at(i) == part {
      parts.push(dashes(part))
    } else if (
      shared
        and i < previous.len()
        and part.split(" ").first() == previous.at(i).split(" ").first()
    ) {
      parts.push(("—", ..part.split(" ").slice(1)).join(" "))
      shared = false
    } else {
      parts.push(part)
      shared = false
    }
  }
  parts.join(", ")
}
#let locator-key(location) = (
  ..counter(heading).at(location).slice(0, 2),
  counter(page).at(location).first(),
)
#let locator(location) = box(context {
  let (chapter, section, page) = locator-key(location)
  metadata((
    kind: "cross-reference",
    target: "index-mark",
    resolved: true,
    target-location: location,
  ))
  link(location)[#numbering("I", chapter), #section, #page]
})
#let index-entries = context {
  let entries = (:)
  for mark in query(<index-mark>) {
    let key = mark.value.path.join("\u{1f}")
    let record = entries.at(key, default: (
      path: mark.value.path,
      sort: mark.value.at("sort", default: none),
      source-page: mark.value.at("source-page", default: none),
      at: (),
    ))
    if record.at.all(l => locator-key(l) != locator-key(mark.location())) {
      record.at.push(mark.location())
    }
    entries.insert(key, record)
  }
  let previous = none
  let initial = none
  for entry in entries
    .values()
    .sorted(key: e => (
      if e.sort == none { 0 } else { 1 },
      if e.sort == none { sort-key(e.path) } else { e.sort },
    )) {
    let letter = upper(sort-key(entry.path).first())
    if letter != initial {
      if initial != none { v(0.8em, weak: true) }
      initial = letter
      previous = none
    }
    let shown = printed-path(entry.path, previous)
    if entry.source-page != none { source(entry.source-page) }
    block(above: 0pt, below: 0.3em, par(hanging-indent: 1.2em)[
      #shown #entry.at.map(locator).join([; ])
    ])
    previous = entry.path
  }
}
#let subject-index() = {
  set par(first-line-indent: 0pt, justify: false, leading: 0.45em)
  set text(size: 9.5pt)
  columns(2, gutter: 7mm, index-entries)
}
#let symbol-index() = context {
  set text(size: 9.5pt)
  set par(first-line-indent: 0pt, leading: 0.45em, spacing: 0.2em)
  let marks = query(<symbol-mark>)
  let categories = (
    ("general", [Обозначения, использующиеся во всей книге:]),
    ("special", [Специальные обозначения для некоторых разделов книги:]),
  )
  let series = counter("symbol-category")
  let source-page = 197
  series.update(0)
  for (group, title) in categories {
    series.step()
    context block(sticky: true, above: 3mm, below: 2mm)[
      #strong[#series.display("A)") #title]
    ]
    let entries = marks
      .filter(m => m.value.group == group)
      .sorted(key: m => m.value.order)
    let keys = ()
    for mark in entries {
      assert(mark.value.key not in keys, message: "Duplicate notation entry")
      keys.push(mark.value.key)
      if (
        mark.value.source-page != none and mark.value.source-page != source-page
      ) {
        source-page = mark.value.source-page
        source(source-page)
      }
      block(above: 0pt, below: 0.2em, par(
        hanging-indent: 1.2em,
        mark.value.body,
      ))
    }
  }
}
