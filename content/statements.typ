// The author's assertions are local italic lists 1), 2), … . Their bodies
// are ordinary paragraphs, permitting natural page breaks in long proofs.
#import "numbering.typ": family-counter, object-number, record
#let proposition(body, italic: true) = {
  family-counter("prop").step()
  context {
    record("prop")
    let own = object-number("prop", here()).last()
    let shown = [#own) #body]
    if italic { emph(shown) } else { shown }
  }
}
// Named statements are unnumbered in the original. Their internal count
// identifies the semantic record; only the author's name is displayed.
#let named-statement(family, name, body, letter: false, format: none) = {
  family-counter(family).step()
  context v(0.5em, weak: true)
  record(family, letter: letter, format: format)
  if letter or format != none {
    context {
      let own = object-number(
        family,
        here(),
        letter: letter,
        format: format,
      ).last()
      emph[#own) #body]
    }
  } else if name == none { emph(body) } else {
    strong(name + [.]) + [ ] + emph(body)
  }
  context v(0.5em, weak: true)
}
#let theorem(body, name: [Теорема], letter: false) = named-statement(
  "th",
  name,
  body,
  letter: letter,
)
#let lemma(body, name: [Лемма]) = named-statement("lem", name, body)
#let corollary(body, name: [Следствие]) = named-statement("cor", name, body)
#let claim(body, format: "I") = named-statement(
  "claim",
  none,
  body,
  format: format,
)
#let proof(body) = [_Доказательство._ #body]
#let condition(body) = {
  family-counter("cond").step()
  context {
    record("cond")
    let own = numbering("A", object-number("cond", here()).last())
    [(#own) #body]
  }
}
#let numbered-display(it) = {
  family-counter("eq").step()
  context {
    record("eq")
    let own = object-number("eq", here()).last()
    math.equation(
      block: true,
      numbering: _ => text(font: "Libertinus Serif", style: "normal")[(#own)],
      number-align: end + horizon,
      it.body,
    )
  }
}
