# TostiBurguer — Design Spec

## 1. Project Context

**Brand:** TostiBurguer — hamburguesería artesanal moderna, especializada en burgers de pan tostado. Vibrante, calle, honesta, sin pretensiones.

**Mood:** Diner retro americano con twist latinoamericano. Calor, grasa, pan crujiente. "Comida rápida" elevada a comida callejera con orgullo.

**Audience:** Jóvenes 18–35 que quieren comer rico rápido sin perder el factor visual. Pedido en local + delivery.

**Voice:** Directa, con hambre, ligeramente canalla. Frases cortas, mayúsculas cuando gritan al mundo.

## 2. Hero Section

**Pattern:** Image-Led + Floating Type — una toma cenital de una burger smash con vapor, queso derritiéndose, maíz dorado como fondo. Texto gigante "TOSTI BURGUER" con badge circular flotando.

**Headline:** "HAMBRE BIEN RESUELTA."
**Subhead:** "Smash burgers, perros XL, papas crujientes y refrescos que matan la sed."

**Floating element:** Badge circular con logo en la esquina superior izquierda + botón CTA "VER EL MENÚ" sticky abajo en móvil.

## 3. Typography

| Token | Font | Weight | Use |
|---|---|---|---|
| `--font-display` | Anton (Google Fonts) | 400 | Headlines gigantes tipo poster |
| `--font-body` | Inter | 400/500/700 | Texto, botones, descripciones |
| `--font-mono` | JetBrains Mono | 500 | Precios, tags |

**Scale:**
- Hero: clamp(64px, 12vw, 220px)
- H2: clamp(40px, 6vw, 96px)
- H3: clamp(24px, 3vw, 40px)
- Body: 16–18px
- Price: 32–48px mono

## 4. Layout

- **Grid:** 12 columnas, gutter 24px, max-width 1280px.
- **Sections:**
  1. **Hero** (100vh) — bg image + headline + CTA scroll
  2. **Manifesto** (marquee ticker) — "HECHO A LA PLANCHA · DESDE 2018 · BARQUISIMETO"
  3. **El Menú Canvas** — filtro por categoría (Burger / Hot Dog / Papas / Refrescos) + grid de cards
  4. **Combos** — 3 paquetes combo destacados
  5. **Sobre Nosotros** — foto local + historia corta
  6. **Visítanos / Delivery** — info + CTA WhatsApp
  7. **Footer**

## 5. Motion

- **Hero:** imagen con `kenburns` (24s loop, scale 1.0→1.08).
- **Marquee:** infinite scroll horizontal 30s.
- **Cards:** IntersectionObserver fade+rise (translateY 24px → 0, opacity 0→1, 600ms).
- **Canvas menu:** hover lift + price pulse (scale 1→1.05).
- **CTA button:** hover fill slide-in.

## 6. Tech Strategy

- Single `index.html`, inline critical CSS.
- Google Fonts preconnect.
- No frameworks. Vanilla JS.
- HTML5 Canvas para **filtros y efectos** en el menú (no para reemplazar el grid).
- `loading="lazy"` + `onerror` en todas las `<img>`.

## 7. Color Palette (Strict — NO blue, NO purple, NO indigo)

| Token | Hex | Use |
|---|---|---|
| `--ink` | `#0e0a08` | Background principal, footer |
| `--charcoal` | `#1a1410` | Cards, surfaces oscuras |
| `--smoke` | `#2a201a` | Borders, dividers |
| `--cream` | `#f5ead3` | Texto claro sobre oscuro, fondo alternativo |
| `--paper` | `#faf5e8` | Fondo claro, secciones |
| `--mustard` | `#f5b524` | Acento principal, CTAs, highlights |
| `--mustard-deep` | `#c98c12` | Hover, sombra de acento |
| `--ketchup` | `#d8312a` | Categoría "Perros", badges, alertas |
| `--chili` | `#9a1d12` | Hover de ketchup, dark accents |
| `--lettuce` | `#7fa940` | Categoría saludable (refrescos, extras) |
| `--beef` | `#8b4a26` | Categoría "Burger", bordes cálidos |
| `--bone-dim` | `#8a7a66` | Texto secundario, captions |

**Background strategy:** Alternar `--ink` (secciones dramáticas) y `--paper` (secciones legibles) con la paleta de acento como chispa.

## 8. The Menu Canvas

**Estructura:**
- 4 categorías con filtro sticky: **🍔 Burgers** · **🌭 Perros** · **🍟 Papas** · **🥤 Refrescos**
- 12 productos total (3 por categoría mínimo).
- Cada card: imagen cuadrada, nombre, descripción corta (1 línea), precio en mono, botón "AGREGAR" simulado (no funcional, visual).
- Canvas overlay: cuando hover sobre una card, se pinta un highlight circular con el color de la categoría sobre un `<canvas>` que cubre la sección (efecto "spotlight" sutil).

**Lista del menú (referencia):**

### 🍔 Burgers (5)
1. **Tosti Clásica** — $4.50 — Pan brioche, smash 80g, queso cheddar, lechuga, tomate, salsa de la casa.
2. **Tosti Doble** — $6.80 — Doble smash, doble cheddar, cebolla caramelizada, bacon.
3. **Tosti BBQ** — $6.20 — Smash 120g, aros de cebolla, cheddar ahumado, bbq casera.
4. **Tosti Trufa** — $8.50 — Smash 120g, queso gruyere, rúcula, alioli de trufa.
5. **Tosti Picante** — $6.50 — Smash 100g, pepper jack, jalapeños, guacamole, chipotle mayo.

### 🌭 Perros (3)
6. **Perro Clásico** — $3.50 — Salchicha premium, pan suave, ketchup, mostaza, cebolla, papas hilo.
7. **Perro BBQ Bacon** — $4.80 — Salchicha XL, bacon, cheddar, cebolla crispy, bbq.
8. **Perro Picante** — $4.50 — Salchicha ahumada, pepper jack, jalapeños, chipotle, guacamole.

### 🍟 Papas (3)
9. **Papas Clásicas** — $2.50 — Corte grueso, sal marina.
10. **Papas con Queso y Bacon** — $4.20 — Cargadas con cheddar, bacon crispy, cebollín.
11. **Papas Tosti** — $4.80 — Con chili, queso, jalapeños, sour cream.

### 🥤 Refrescos (3)
12. **Coca-Cola / Pepsi** — $1.80 — 500ml botella.
13. **Limonada de la Casa** — $2.50 — Limón natural, menta, hielo.
14. **Malteada de Chocolate** — $3.80 — Con crema batida y galleta.

## 9. Quality Bar

- Cero azul, cero morado, cero indigo.
- Logo badge con hamburguesa + texto curvo.
- Imágenes de comida con vapor, brillo, ultra-llamativas.
- Tipografía bold, legible, con jerarquía clara.
- Animaciones suaves que sumen, no distraigan.
- Menú canvas debe sentirse táctil e interactivo.
