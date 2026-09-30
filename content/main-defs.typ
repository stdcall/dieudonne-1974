// Shared semantic anchors and references. Printed numbers are counted,
// while every target has a literal, stable label in the chapter source.
#import "numbering.typ": family-counter, numbered-record, record, record-number
#let source(n, printed: none) = context [#metadata((
  kind: "source",
  file-page: n,
  printed-page: if printed == none { str(n + 1) } else { printed },
))]
// Author's Roman subdivisions can continue through successive sections.
// A semantic series owns its native counter independently of § numbering.
#let division(body, series: none, continued: false) = {
  assert(series != none, message: "A division needs a semantic series key")
  let own = counter("division:" + series)
  if not continued { own.step() }
  context {
    let prefix = numbering("I.", own.get().first())
    block(sticky: true, above: 4mm, below: 3mm)[
      #metadata((
        kind: "numbered",
        family: "heading",
        level: 3,
        division-series: series,
        number: (own.get().first(),),
      ))<numbered>
      #heading(level: 3, numbering: none)[#prefix #body]
    ]
  }
}
#let case-label(series: none, format: "A)", parent: none, qualified: true) = {
  assert(series != none, message: "A case needs a semantic series key")
  let own = counter("case:" + series)
  own.step()
  context {
    let base = if parent == none { "" } else {
      state("case-path:" + parent, "").get()
    }
    let part = numbering(format, own.get().first())
    let shown = base + part
    let name = shown.replace(
      regex("[.) ]+$"),
      "",
    )
    state("case-path:" + series, "").update(name)
    box[#metadata((
        kind: "numbered",
        family: "case",
        series: series,
        number: (name,),
      ))<numbered>#if qualified { shown } else { part }]
  }
}
#let book-figure(body, caption: []) = {
  family-counter("fig").step()
  figure(
    kind: image,
    numbering: "1",
    supplement: [Рис.],
    caption: caption,
  )[#record("fig")#body]
}
#let number-text(body) = text(weight: "semibold", style: "normal", body)
#let reference-body(it, caption, bare: false) = context {
  let prefix = str(it.target).split(":").first()
  let found = if it.element != none { numbered-record(it.target) }
  let pending = it.element == none
  let numbers = if found != none { record-number(found) } else { () }
  let own = if numbers.len() > 0 { str(numbers.last()) } else { "?" }
  let printed = if it.form == "page" and not pending {
    str(counter(page).at(it.element.location()).first())
  } else if prefix == "ch" and numbers.len() > 0 {
    numbering("I", numbers.first())
  } else if (
    prefix == "ss"
      and found != none
      and (
        found.value.at("division-series", default: none) != none
      )
  ) {
    numbering("I", numbers.last())
  } else if prefix == "cond" and numbers.len() > 0 {
    numbering("A", numbers.last())
  } else { own }
  let shown = if caption { it.supplement } else if bare {
    number-text(printed)
  } else if prefix in ("eq", "cond") {
    [(#number-text(printed))]
  } else if prefix == "prop" { [#number-text(printed))] } else {
    number-text(printed)
  }
  let destination = if pending { none } else if found != none {
    found.location()
  } else { it.element.location() }
  metadata((
    kind: "cross-reference",
    target: str(it.target),
    resolved: not pending,
    printed: printed,
    target-location: destination,
  ))
  if pending { shown } else { link(destination, shown) }
}
#let reference-rules(body) = {
  show ref: it => {
    let caption = it.supplement not in (auto, none, [])
    let shown = reference-body(it, caption)
    if caption { shown } else { box(shown) }
  }
  body
}
#let bare-refs(body) = {
  show ref: it => {
    let caption = it.supplement not in (auto, none, [])
    let shown = reference-body(it, caption, bare: true)
    if caption { shown } else { box(shown) }
  }
  body
}
#let page-refs(body) = {
  set ref(form: "page")
  body
}
#let idx(..path) = [#metadata((
  kind: "index-mark",
  path: path.pos(),
  sort: path.named().at("sort", default: none),
  source-page: path.named().at("source-page", default: none),
))<index-mark>]
// The notation index has the author's two groups and order. Its complete
// entries live only at the passages that introduce their symbols.
#let sidx(key, body, group: "general", order: none, source-page: none) = {
  assert(group in ("general", "special"))
  assert(type(order) == int)
  [#metadata((
    kind: "symbol-mark",
    key: key,
    group: group,
    order: order,
    source-page: source-page,
    body: body,
  ))<symbol-mark>]
}
#let editorial-notes = sys.inputs.at("editorial-notes", default: "on") != "off"
#let editorial-counter = counter("editorial-note")
#let ed-note(body) = if editorial-notes {
  editorial-counter.step()
  context {
    let mark = "*" + str(editorial-counter.get().first()) + ")"
    footnote(numbering: _ => mark)[#body~— _Прим. ред._]
    counter(footnote).update(n => n - 1)
  }
}
#let author-signature(author, date: none) = block(
  width: 100%,
  above: 0.7em,
)[
  #if date != none { align(left, text(size: 9pt, date)) }
  #align(right, emph(author))
]
#let group-name(name) = math.class("normal", math.upright(name))
#let GL = group-name("GL")
#let SL = group-name("SL")
#let PGL = group-name("PGL")
#let PSL = group-name("PSL")
#let GammaL = group-name("ΓL")
#let PGammaL = group-name("PΓL")
#let Sp = group-name("Sp")
#let PSp = group-name("PSp")
#let GSp = group-name("GSp")
#let GammaSp = group-name("ΓSp")
#let PGammaSp = group-name("PΓSp")
#let PGSp = group-name("PGSp")
#let U = group-name("U")
#let GU = group-name("GU")
#let GammaU = group-name("ΓU")
#let PU = group-name("PU")
#let PGU = group-name("PGU")
#let PGammaU = group-name("PΓU")
#let O = group-name("O")
#let GO = group-name("GO")
#let GammaO = group-name("ΓO")
#let PGammaO = group-name("PΓO")
#let PGO = group-name("PGO")
#let PO = group-name("PO")
#let POmega = group-name("PΩ")
#let SO = group-name("SO")
#let SU = group-name("SU")
#let Spin = group-name("Spin")
#let Aut = math.op("Aut")
#let char = math.op("char")
#let Hom = math.op("Hom")
#let End = math.op("End")
#let Ker = math.op("Ker")
#let Im = math.op("Im")
#let id = math.italic("id")
#let diag = math.op("diag")
#let tr = math.op("tr")
#let dim = math.op("dim")
// A separate hypothesis line belongs to its section's introductory text.
#let section-condition(body) = block(sticky: true, body)

// The bibliography has one local counter for each successive author block.
#let bib-author(body) = {
  family-counter("bib").update(0)
  block(above: 0.9em, below: 0.25em, sticky: true, body)
}
#let bib-item(body, starred: false) = {
  family-counter("bib").step()
  context {
    record("bib", starred: starred)
    let own = family-counter("bib").get().first()
    block(above: 0pt, below: 0.3em, par(hanging-indent: 1.3em)[#own#if starred {
        text("*")
      }. #body])
  }
}
