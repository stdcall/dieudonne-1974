#import "main-defs.typ": *

== Полуинволюции в унитарных группах и их централизаторы. Первый случай
<sec:unitary-semiinvolutions-one>

Пусть $u$ — некоторая полуинволюция в группе $GammaU_n (K, f)$ относительно
автоморфизма $sigma$ тела $K$. Пусть $u^2(x) = x gamma$ и
$f(u(x), u(y)) = e(f(x, y))^sigma$. Перепишем в этом случае соотношения
@eq:semiinvolution-fixed-scalar, @eq:semiinvolution-automorphism-square,
@eq:unitary-similitude-automorphisms и
@eq:unitary-similitude-symmetric-multiplier:

$
  gamma^sigma = gamma, quad xi^(sigma^2) = gamma^(-1) xi gamma,
  quad xi^(sigma J) = e xi^(J sigma) e^(-1), quad e^J = e.
$
<eq:unitary-semiinvolution-relations>

Кроме того, вычисляя $f(u^2(x), u^2(y))$ двумя способами, находим, что

$ gamma^J gamma = e e^sigma. $ <eq:unitary-semiinvolution-multiplier>

Мы будем предполагать в этом параграфе, что $gamma$ _не представляется в виде_
$lambda lambda^sigma$ (случай @case:semiinvolution-nonnorm-scalar) §
@sec:involutions-semiinvolutions). Образуем квадратичное расширение
$K_0 = K(rho)$ тела $K$, в котором $rho^2 = gamma$ и $eta rho = rho eta^sigma$
при $eta in K$, и превратим пространство $E$ в векторное пространство
размерности $n slash 2$ над $K_0$, полагая $x zeta = x xi + u(x) eta$ при
$zeta = xi + rho eta in K_0$ и $x in E$. Полученное векторное пространство
обозначим через $E_0$. Легко видеть, что существует взаимно однозначное
соответствие $x' arrow.l.r x'_0$ между пространством $E^*$, двойственным к $E$,
и пространством $E_0^*$, двойственным к $E_0$, при котором

$
  chevron.l x'_0, x chevron.r = chevron.l x', x chevron.r
  + rho chevron.l x', u(x) chevron.r^sigma gamma^(-1)
$
<eq:quadratic-extension-dual-correspondence>

для всякого $x in E$. Кроме того, при помощи формул
@eq:unitary-semiinvolution-relations и @eq:unitary-semiinvolution-multiplier
можно показать, что инволюция $J$ может быть распространена на $K_0$ таким
образом, что $rho^J = rho e^sigma gamma^(-1)$. В соответствии с формулой
@eq:quadratic-extension-dual-correspondence, корреляции
#source(45)
$phi$ (ассоциированной с формой $f$) отвечает отображение $phi_0$ пространства
$E_0$ в $E_0^*$, определяемое формулой

$
  chevron.l phi_0(x), y chevron.r = chevron.l phi(x), y chevron.r
  + rho chevron.l phi(x), u(y) chevron.r^sigma gamma^(-1).
$
<eq:quadratic-extension-correlation>

Из @eq:unitary-semiinvolution-relations и @eq:unitary-semiinvolution-multiplier
выводится, что $phi_0(x zeta) = zeta^J phi_0(x)$ при любом $zeta in K_0$; иначе
говоря, $phi_0$ есть _корреляция_. Далее, если
$attach(phi, tl: t) = epsilon phi$, $epsilon = plus.minus 1$, то и
$attach(phi_0, tl: t) = epsilon phi_0$. В самом деле, из формулы
@eq:quadratic-extension-correlation следует, что

$
  chevron.l phi_0(x), y chevron.r^J - epsilon chevron.l phi_0(y), x chevron.r
  in rho K
$

при любых $x, y in E_0$; однако это выражение является линейной функцией от $x$
(над $K_0$) и не может принимать значения только в $rho K$, не будучи
тождественно равным нулю.

Из @eq:quadratic-extension-correlation получаем следующую формулу для
рефлексивной формы $f_0(x, y)$, ассоциированной с корреляцией $phi_0$:

$ f_0(x, y) = f(x, y) + rho(f(x, u(y)))^sigma gamma^(-1). $
<eq:quadratic-extension-reflexive-form>

Найдем теперь группу $H$ полуподобий, _проективно перестановочных_ с
полуинволюцией $u$. Это равносильно изучению _централизатора_ инволюции
$overline(u) in PGammaU_n$ в проективной группе $PGammaU_n$ (см. §
@sec:projective-involution-centralizer). Преобразование $v in H$,
соответствующее автоморфизму $tau$, удовлетворяет условию $v u = u v dot a$
($a in K$), из которого вытекают соотношения
@eq:projective-commutation-automorphisms и @eq:projective-commutation-scalar;
кроме того, $phi(v(x)) = h caron(v)(phi(x))$, где $h$ — симметричный элемент
тела $K$. Известно (см. § @sec:projective-involution-centralizer), что можно
распространить автоморфизм $tau$ на тело $K_0$ таким образом, что $v$ будет
коллинеацией пространства $E_0$ относительно полученного автоморфизма. Если это
сделать, то из формулы @eq:quadratic-extension-reflexive-form будет следовать,
что $f_0(v(x), v(y)) - h(f_0(x, y))^tau in rho K$ при любых $x in E_0$,
$y in E_0$; но так как это выражение при фиксированном $x$ полулинейно по $y$,
все его значения могут лежать в $rho K$, только если оно тождественно равно
нулю. Следовательно, $v$ принадлежит группе $GammaU_(n slash 2) (K_0, f_0)$.
Обратно, элемент $v$ этой группы проективно перестановочен с $u$, если
соответствующий ему автоморфизм $tau$ тела $K_0$ сохраняет (в целом) $K$ и
удовлетворяет условию $rho^tau = rho a$ (где $a in K$) и его множитель
принадлежит $K$. Заметим#source(46), что подгруппа $H$ группы
$GammaU_(n slash 2) (K_0, f_0)$, определенная этим условием, содержит в качестве
нормального делителя _унитарную группу_ $U_(n slash 2) (K_0, f_0)$.
