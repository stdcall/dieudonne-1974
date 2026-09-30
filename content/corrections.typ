// Confirmed corrections, with the reading and justification of each change.
#import "main-defs.typ" as defs
#let scope = dictionary(defs)
#let entries = json("../corrections.json").entries
#let markup(value) = eval(value, mode: "markup", scope: scope)
#set document(
  title: "Дьёдонне. Геометрия классических групп. Исправления",
  author: "Ж. Дьёдонне",
  date: none,
)
#set page(
  width: 140mm,
  height: 210mm,
  margin: 15mm,
  numbering: "1",
  footer: context align(center, counter(page).display()),
)
#set text(font: "Libertinus Serif", size: 11pt, lang: "ru")
#set par(justify: true, leading: 0.5em)
#show math.equation: set text(font: "STIX Two Math")
#align(center, text(size: 14pt)[Исправления])

Ж. Дьёдонне. _Геометрия классических групп_. Перевод Э. Б. Винберга. Москва:
Мир, 1974. Номера страниц ниже относятся к печатному изданию.

#if entries.len() == 0 [Подтверждённых исправлений пока нет.] else {
  let section = none
  for entry in entries {
    if entry.section != section {
      section = entry.section
      heading(level: 1, section)
    }
    block(above: 1em, breakable: false)[
      #metadata((correction: entry.id))
      *#entry.id* · с. #entry.printed_page, #entry.place

      В издании: #markup(entry.original)

      Исправлено: #markup(entry.corrected)

      #markup(entry.reason)
    ]
  }
}
