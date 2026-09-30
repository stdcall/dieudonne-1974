# Сборка и исходники

`just build` собирает книгу, `just check` проверяет формат, семантические
метки и PDF. Требуются Typst 0.15.1, Typstyle 0.15.1 и Tinymist 0.15.8.
Шрифты с лицензиями лежат в assets/fonts. Главный файл — content/main.typ.

Обложка выбирается в начале главного файла:
`use-russian-cover = true` — красная русская; `false` — охристая адаптация.
Обе обложки построены средствами Typst, растров в издании нет.

## Нумерация

Главы — `=` (I–IV), параграфы — `==` (§ 1…), без номера в названии.
Формулы с меткой `<eq:смысл>` считаются внутри главы; выключные формулы
без метки не нумеруются. `#proposition[тело] <prop:смысл>` — курсивное
утверждение локальной серии 1), 2)… внутри параграфа. Леммы и теоремы
`#lemma`, `#theorem` имеют тело; их ненумерованные названия сохраняются.
Метки пишутся буквальным именем после цели; ссылки — только `@метка`.
Префиксы: ch, sec, eq, prop, th, lem, cor, bib, fig. В формулах ссылки
пишутся `#[@метка]`. Описательная ссылка — `@метка[текст]`.

Литература: `#bib-author[Имя]` сбрасывает счёт, затем
`#bib-item[Запись] <bib:SurnameYear>`; `starred: true` для звёздочки
переводчика. Номера работ локальны по автору. BibLaTeX — references.bib,
ключи не меняются; переводы и сложные примечания сохраняются в записи.

## Разметка

Текст главы — обычная разметка под include, без обёртки или preview-кода.
Вёрстка — глобально в book-style.typ; без ручных отступов, #h, локальных
set-правил, переносов/масштабирования ради одной формулы. Ширина исходника
80 знаков, отступ 2, форматтер Typstyle. Имена групп берутся из main-defs.
Невидимая #source(N) отмечает границу страницы экземпляра; #idx("термин",
"подстатья") ставится рядом с соответствующим определением и служит
единственным источником указателя. Редакционные примечания — #ed-note;
все отключаются --input editorial-notes=off.

Сохранять авторскую прозу буквально. Ошибки оригинала исправляются
минимально с исходным чтением, исправлением и обоснованием в corrections.json.
Ошибки собственного набора в этот журнал не входят. Авторские исправления
не требуют примечаний. Собственная крупная правка требует полезного
объяснения читателю со ссылкой на проверенную печатную литературу.

## Имена целей между частями

Метки не угадывать: они должны совпадать с целью в другой части.

| Место | Метка |
|---|---|
| I §9 | `sec:unitary-group` |
| I §10 | `sec:t-forms` |
| I §11 | `sec:t-form-properties` |
| I §12 | `sec:quasireflections` |
| I §13 | `sec:unitary-semiinvolutions-one` |
| I §14 | `sec:unitary-semiinvolutions-two` |
| I §15 | `sec:commuting-correlations` |
| I §16 | `sec:quadratic-forms-characteristic-two` |
| I §17 | `sec:classical-group-generalizations` |
| Глава II | `ch:classical-group-structure` |
| II §1 | `sec:linear-group-center-commutator` |
| II §2 | `sec:special-linear-structure` |
| II §3 | `sec:unitary-generators-center` |
| II §4 | `sec:unitary-t-subgroup` |
| II §5 | `sec:unitary-quotient` |
| II §6 | `sec:orthogonal-commutator` |
| II §7 | `sec:clifford-algebra` |
| II §8 | `sec:orthogonal-structure-one` |
| II §9 | `sec:orthogonal-structure-two` |
| II §10 | `sec:orthogonal-characteristic-two` |
| II §11 | `sec:orthogonal-defective` |
| II §12 | `sec:anisotropic-unitary-groups` |
| II §13 | `sec:unitary-similitude-structure` |
| Глава III | `ch:classical-group-geometric-characterization` |
| III §1 | `sec:projective-geometry-theorem` |
| III §2 | `sec:grassmann-adjacency` |
| III §3 | `sec:isotropic-adjacency` |
| III §4 | `sec:isotropic-adjacency-continuation` |
| III §5 | `sec:other-classical-group-characterizations` |
| Глава IV | `ch:classical-group-automorphisms` |
| IV §1 | `sec:general-linear-automorphisms` |
| IV §2 | `sec:special-linear-automorphisms` |
| IV §3 | `sec:symplectic-automorphisms` |
| IV §4 | `sec:unitary-automorphisms` |
| IV §5 | `sec:orthogonal-automorphisms` |
| IV §6 | `sec:projective-linear-symplectic-automorphisms` |
| IV §7 | `sec:projective-classical-automorphisms` |
| IV §8 | `sec:classical-group-isomorphisms` |
| IV §9 | `sec:classical-group-isomorphisms-continuation` |

Буквенные теоремы: `#theorem(letter: true)[тело] <th:…>` считает A, B…
внутри параграфа. Условия `(A)` — `#condition[тело] <cond:…>` с отдельным
счётчиком букв. `name: none` у леммы или теоремы сохраняет структуру без
добавленного названия; `italic: false` у proposition позволяет передать
смешанное авторское выделение в теле.

Римские части, продолжающиеся через соседние параграфы, —
`#division(series: "unitary-structure")[Группа …] <ss:…>`.
Ключ серии смысловой; номер I, II… вычисляется штатным счётчиком.
`continued: true` повторяет номер части, продолжаемой в новом параграфе
(например, II в III §§3–4), без шага счётчика.
Случаи — `#case-label(series: "…", format: "A)")`; для A1), A1α)
задать отдельную серию и `parent: "ключ родительской серии"`.
Каждая серия получает свой счётчик; `parent` добавляет вычисленную метку
родительского случая без завершающей скобки.
`qualified: false` показывает только локальную букву α), сохраняя
полную вычисленную метку B2α для ссылки `@case:…`.
Отдельные курсивные утверждения I), II) — `#claim[тело] <claim:…>`,
со своим счётчиком, который не смешивается с A), B), C) теорем.
Рисунки — `#book-figure[тело] <fig:…>`; подпись «Рис. 1.» считается
автоматически. Геометрический код строит точки из исходных данных.

Метка переводческой сноски — `<fn:…>` после `#footnote[тело]`.
`@fn:…` считает её действующий номер. Номер страницы печатается
`#page-refs[@fn:…]`: внутри остаётся буквальная ссылка `@`.

Список обозначений генерируется из `#sidx("смысловой ключ", [полная
авторская строка], group: "general", order: 1)` рядом с определением.
Группы general/special сохраняют авторские A/B, order — порядок строк
оригинального списка. Математика и нативные ссылки на главы/§ находятся
в теле отметки; отдельного ручного списка строк нет.

У `#idx` именованные параметры `sort` и `source-page` задают особый
авторский порядок и границу страницы указателя соответственно.
Параметр `source-page` не определяет печатный номер ссылки: он вычисляется
по месту отметки в тексте. Оглавление также строится из заголовков;
невидимые границы его печатных страниц привязаны к соответствующим статьям.

Начальные условия параграфа в скобках оформляются
`#section-condition[тело]`: общий стиль удерживает их вместе с первым
абзацем. Издательские страницы используют `publisher-style` без
колонтитулов и печатного номера.
