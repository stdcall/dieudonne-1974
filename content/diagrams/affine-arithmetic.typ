#import "@preview/cetz:0.5.2"

// An oblique affine frame. Every constructed point is an affine
// combination of e1 and e2; a-value and b-value determine the construction.
#let arithmetic-construction(product: false) = cetz.canvas(length: 10mm, {
  import cetz.draw: *
  set-style(stroke: (thickness: 0.65pt), content: (padding: 2pt))
  let e1 = (2.5, 0)
  let e2 = (0.7, 1.7)
  let a-value = if product { 0.5 } else { 1.7 }
  let b-value = if product { 2.8 } else { 0.65 }
  let scale-point(p, a) = (p.at(0) * a, p.at(1) * a)
  let add(p, q) = (p.at(0) + q.at(0), p.at(1) + q.at(1))
  let zero = (0, 0)
  let result = scale-point(e1, if product { a-value * b-value } else {
    a-value + b-value
  })
  let upper = if product { scale-point(e2, b-value) } else {
    add(scale-point(e1, a-value), e2)
  }
  let right = if product { scale-point(e1, b-value) } else { result }
  line((-0.15, 0), add(right, (0.22, 0)))
  line(zero, scale-point(e2, if product { b-value + 0.2 } else { 1.2 }))
  if product {
    line(e2, e1)
    line(e2, scale-point(e1, a-value))
    line(upper, right)
    line(upper, result)
    content(e2, $e_2$, anchor: "east")
    content(upper, $e_2 beta$, anchor: "east")
    content(result, $e_1 alpha beta$, anchor: "north")
    content(right, $e_1 beta$, anchor: "north")
  } else {
    line(add(e2, (-0.15, 0)), add(upper, (0.22, 0)))
    line(e2, scale-point(e1, b-value))
    line(scale-point(e1, a-value), add(upper, scale-point(e2, 0.2)))
    line(upper, result)
    content(e2, $e_2$, anchor: "east")
    content(scale-point(e1, b-value), $e_1 beta$, anchor: "north")
    content(scale-point(e1, a-value), $e_1 alpha$, anchor: "north")
    content(result, $e_1(alpha + beta)$, anchor: "north")
  }
  line(e1, add(e1, (0, 0.06)))
  content(zero, $0$, anchor: "north")
  content(e1, $e_1$, anchor: "north")
  if product { content(scale-point(e1, a-value), $e_1 alpha$, anchor: "north") }
})

