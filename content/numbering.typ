// Chapters I–IV; sections restart by chapter. Formula numbers run through
// each chapter. Numbered assertions form a separate series in each section.
// Bibliography entries restart at each author's name, as in the original.
#let family-depth = (
  prop: 2,
  th: 2,
  lem: 2,
  cor: 2,
  cond: 2,
  claim: 2,
  eq: 1,
  bib: 0,
  fig: 0,
)
#let family-counter(family) = counter("numbered:" + family)
#let place-key(location) = counter(heading).at(location)
#let restart-counters(level) = {
  for (family, depth) in family-depth {
    if depth >= level { family-counter(family).update(0) }
  }
}
#let object-number(
  family,
  location,
  starred: false,
  letter: false,
  format: none,
) = {
  let scope = place-key(location).slice(0, family-depth.at(family))
  let own = family-counter(family).at(location).first()
  (
    ..scope,
    if format != none { numbering(format, own) } else if letter {
      numbering("A", own)
    } else if starred {
      str(own) + "*"
    } else { own },
  )
}
#let record(family, ..flags) = context [#metadata((
  kind: "numbered",
  family: family,
  ..flags.named(),
  number: object-number(family, here(), ..flags.named()),
))<numbered>]
#let numbered-record(target) = {
  if query(target).len() != 1 { return none }
  query(selector(<numbered>).within(target)).at(0, default: none)
}
#let record-number(record) = {
  let value = record.value
  if value.family in ("case", "fn") { return value.number }
  if value.family == "heading" {
    if value.at("division-series", default: none) != none {
      return (
        counter("division:" + value.division-series)
          .at(
            record.location(),
          )
          .first(),
      )
    }
    return place-key(record.location()).slice(0, value.level)
  }
  object-number(
    value.family,
    record.location(),
    starred: value.at(
      "starred",
      default: false,
    ),
    letter: value.at("letter", default: false),
    format: value.at("format", default: none),
  )
}
