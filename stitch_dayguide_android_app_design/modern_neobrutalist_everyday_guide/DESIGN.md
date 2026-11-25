---
name: Modern Neobrutalist Everyday Guide
colors:
  surface: '#fcf9f8'
  surface-dim: '#dcd9d9'
  surface-bright: '#fcf9f8'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f6f3f2'
  surface-container: '#f0eded'
  surface-container-high: '#eae7e7'
  surface-container-highest: '#e5e2e1'
  on-surface: '#1c1b1b'
  on-surface-variant: '#4d4634'
  inverse-surface: '#313030'
  inverse-on-surface: '#f3f0ef'
  outline: '#7e7662'
  outline-variant: '#d0c6ae'
  surface-tint: '#725c00'
  primary: '#725c00'
  on-primary: '#ffffff'
  primary-container: '#ffd84d'
  on-primary-container: '#735e00'
  inverse-primary: '#e9c339'
  secondary: '#166392'
  on-secondary: '#ffffff'
  secondary-container: '#8bcafe'
  on-secondary-container: '#005581'
  tertiary: '#a43c28'
  on-tertiary: '#ffffff'
  tertiary-container: '#ffd1c8'
  on-tertiary-container: '#a63e29'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffe07e'
  primary-fixed-dim: '#e9c339'
  on-primary-fixed: '#231b00'
  on-primary-fixed-variant: '#564500'
  secondary-fixed: '#cbe6ff'
  secondary-fixed-dim: '#90cdff'
  on-secondary-fixed: '#001e31'
  on-secondary-fixed-variant: '#004b72'
  tertiary-fixed: '#ffdad3'
  tertiary-fixed-dim: '#ffb4a5'
  on-tertiary-fixed: '#3e0500'
  on-tertiary-fixed-variant: '#842513'
  background: '#fcf9f8'
  on-background: '#1c1b1b'
  surface-variant: '#e5e2e1'
typography:
  headline-xl:
    fontFamily: Space Grotesk
    fontSize: 36px
    fontWeight: '700'
    lineHeight: 44px
    letterSpacing: -0.03em
  headline-xl-mobile:
    fontFamily: Space Grotesk
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 34px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Space Grotesk
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
    letterSpacing: -0.02em
  headline-lg-mobile:
    fontFamily: Space Grotesk
    fontSize: 24px
    fontWeight: '700'
    lineHeight: 30px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Space Grotesk
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 26px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Space Grotesk
    fontSize: 18px
    fontWeight: '600'
    lineHeight: 24px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '500'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 18px
  label-lg:
    fontFamily: Space Grotesk
    fontSize: 15px
    fontWeight: '700'
    lineHeight: 20px
    letterSpacing: 0.02em
  label-md:
    fontFamily: Space Grotesk
    fontSize: 13px
    fontWeight: '700'
    lineHeight: 18px
    letterSpacing: 0.02em
  label-sm:
    fontFamily: Space Grotesk
    fontSize: 11px
    fontWeight: '700'
    lineHeight: 14px
    letterSpacing: 0.04em
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  gutter: 1rem
  gutter-sm: 0.75rem
  margin: 1rem
  margin-tablet: 1.5rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2rem
---

## Brand & Style
The design system delivers a tactile, energetic, and unapologetically confident aesthetic built for high-utility daily learning and routines. Combining playful geometric discipline with the bold impact of Neobrutalism, it transforms mundane how-tos, life hacks, and practical daily knowledge into an engaging ritual.

### Target Audience & Personality
- **Audience:** Everyday active mobile learners, Indonesian youth, students, and young professionals seeking quick, actionable guides (tips harian, tutorial praktis, panduan esensial).
- **Personality:** Optimistic, spunky, reliable, structured, and vibrant.
- **Emotional Response:** Empowers users with a feeling of immediacy and clarity—stripping away corporate sterile monotony in favor of punchy, delightful physical cards.

### Aesthetic Principles
- **Controlled Neobrutalism:** Heavy black strokes and distinct hard-drop offset shadows paired with curved corners (12–16px) to keep the mobile interface friendly, approachable, and ergonomically tactile rather than harsh.
- **Vibrant Functional Utility:** Bold primary accents segment practical categories (e.g., Keuangan, Rumah Tangga, Karir, Tips Cepat) without cluttering reading comprehension.
- **Copy Tone:** Casual yet clear Indonesian phrasing (Bahasa Indonesia santai, praktis, dan lugas), emphasizing action verbs like *Mulai*, *Simpan*, *Pelajari*, and *Terapkan*.

## Colors
The color architecture relies on a warm canvas paired with high-voltage accent tones anchored by ink-black line work.

### Palette Architecture
- **Base Canvas:** `#FFF8E7` (Warm Cream). Replaces cold white to eliminate eye strain while giving physical paper-like warmth.
- **Surface Elevation:** `#FFFFFF` (Card White). Used on elevated action cards, sheets, and interactive dialogs.
- **Primary:** `#FFD84D` (Electric Sunshine Yellow). Primary buttons, highlighted key steps, active states, and focal tags.
- **Secondary:** `#8CCBFF` (Sky Blue). Informational banners, interactive steps, and secondary utilities.
- **Accent Coral:** `#FF8066`. Alerts, urgent daily tips, favorites, and streak counters.
- **Accent Mint:** `#6EE7B7`. Progress markers, success confirmations, and completed checkmarks.
- **Accent Lavender:** `#C4B5FD`. Deep-dive tags, bookmark badges, and auxiliary categories.
- **Outline & High-Contrast Ink:** `#171717` (Deep Obsidian Ink). Used for all borders, offset drop shadows, body text, and major structural boundaries.

### Accessibility & Contrast
All foreground text sits either on `#FFF8E7`, `#FFFFFF`, or tinted container surfaces with an enforced minimum contrast ratio of 4.5:1 against `#171717`. Interactive elements must not rely on color alone; borders and explicit iconography ensure color-blind legibility.

## Typography
Typography is expressive, readable, and structured for quick mobile scanning.

- **Headlines & Display (Space Grotesk):** Provides technological precision, quirky geometric hooks, and assertive visual stopping power. Titles, navigation headers, metric counters, and badge markers leverage bold and medium cuts.
- **Body & Reading Content (Inter):** Balances Neobrutalist loud points with supreme legibility at small sizes. Used for instructional paragraphs, bullet guides, tips steps, and system messages.
- **Labels & Tags (Space Grotesk):** Set with slight letter spacing and strong weights for badges like "TIPS HARI INI", "5 MENIT BACA", and category labels.
- **Indonesian Copy Standards:** Capitalization applies to main titles (*Panduan Cepat Tanggap Darurat*), while step descriptions maintain conversational sentence casing (*Bilas dengan air mengalir selama 10 menit*).

## Layout & Spacing
Built strictly around Android edge-to-edge constraints, touch target comfort, and modular stacking.

### Layout Philosophy
- **Fluid Single-Column Stack:** Mobile viewport is prioritized as a fluid vertical track with horizontal swiping pill racks and masonry tip cards.
- **Outer Canvas Margins:** 16px (`1rem`) on handheld Android form factors, scaling to 24px (`1.5rem`) on foldables and tablets.
- **8-Point Spacing Grid:** Component padding and internal card layouts conform strictly to multiples of 4px and 8px to guarantee crisp mathematical alignment with border thicknesses.
- **Touch Target Safeguards:** All interactive buttons, chips, and quick switches maintain a minimum bounding hit box of 48x48dp, even if the visible container is compact.

## Elevation & Depth
In alignment with modern Neobrutalism, this design system avoids blurred Gaussian drop-shadows or translucent frosted glass. Instead, depth is communicated through hard structural physical offset shadows and crisp framing.

### The Offset Shadow Language
- **Default Interactive Level (Cards, CTA Buttons, Dialogs):**
  - Border: `2.5px solid #171717`
  - Shadow: `box-shadow: 3px 3px 0px #171717` (Mobile) or `4px 4px 0px #171717` (Tablet/Desktop)
- **Active / Pressed State:**
  - On tap or press, the component translates down-right (`transform: translate(2px, 2px)`), reducing the offset shadow to `1px 1px 0px #171717` or `0px 0px 0px #171717`. This gives direct mechanical feedback reminiscent of a physical tactile click.
- **Resting / Static Container Level (Tags, Inset Panels, Text Inputs):**
  - Border: `2px solid #171717`
  - Shadow: `none` or subtle `2px 2px 0px #171717`
- **Floating Overlays & Sticky Actions (FAB, Bottom Sheet):**
  - Border: `3px solid #171717`
  - Shadow: `5px 5px 0px #171717`

## Shapes
Geometry is a defining pillar. Rather than zero-radius harsh raw brutalism, this system uses consistent, curved geometry to retain a friendly, approachable Android experience.

- **Primary Radius (`roundedness: 2`):** Standard components (Cards, Input Fields, Sheet Modals) feature a corner radius of `12px` to `16px` (`rounded-lg`).
- **Pill Badges (`rounded-full`):** Category tags, step indicators, and progress counters utilize a full circular pill radius combined with heavy outlines to balance rectangular content cards.
- **Geometric Stickers:** Accompanying graphical shapes (stars, flowers, bursts) retain hard 2.5px stroke weight boundaries.

## Components

### Buttons (Tombol Aksi)
- **Primary CTA:** Background `#FFD84D`, border `2.5px solid #171717`, offset `3px 3px 0px #171717`, font Space Grotesk Bold, text `#171717`. Corner radius 14px. Pressed state: `translate(2px, 2px)` with shadow `1px 1px 0px #171717`. Example: *"Mulai Praktikkan"*.
- **Secondary CTA:** Background `#8CCBFF` or `#FFFFFF`, border `2.5px solid #171717`, offset `3px 3px 0px #171717`. Example: *"Simpan ke Favorit"*.
- **Destructive:** Background `#FF8066`, border `2.5px solid #171717`, offset `3px 3px 0px #171717`.

### Cards (Kartu Panduan & Pengetahuan)
- **Knowledge Card:** Background `#FFFFFF`, border `2.5px solid #171717`, shadow `4px 4px 0px #171717`, padding `16px`. Header area features an expressive pill category badge (e.g., Lavender `#C4B5FD`), Space Grotesk heading, Inter body snippet, and bottom metadata row (e.g., "⏱ 3 Mnt Baca").
- **Daily Hero Card (Sorotan Hari Ini):** Background `#FFD84D` with contrast interior badge `#FFFFFF` and thick solid borders.

### Category Chips & Badges (Lencana Kategori)
- Height: 32px. Border: `2px solid #171717`. Radius: Full (`9999px`). 
- Default state: Background `#FFFFFF`, text `#171717`.
- Selected/Active state: Background `#171717`, text `#FFFFFF`, offset `2px 2px 0px #FFD84D`.
- Available tints: Mint (`#6EE7B7`), Blue (`#8CCBFF`), Coral (`#FF8066`), Lavender (`#C4B5FD`).

### Form Inputs & Search (Kolom Pencarian)
- Background: `#FFFFFF`, border `2.5px solid #171717`, shadow `2px 2px 0px #171717`, corner radius `12px`.
- Placeholder: `rgba(23, 23, 23, 0.5)` with sample text *"Cari tips masak, perbaikan rumah, gadget..."*
- Focus state: Outline remains `#171717`, shadow shifts to `4px 4px 0px #171717`.

### Selection Controls (Checkbox & Radio)
- Checkboxes: 22x22dp square, 4px corner radius, border `2.5px solid #171717`. Unchecked: `#FFFFFF`. Checked: `#6EE7B7` with a bold black checkmark icon and hard shadow `2px 2px 0px #171717`.
- Radio Buttons: 22x22dp circular, border `2.5px solid #171717`. Selected state displays an inner solid `#171717` circular pip.

### Lists & Steps (Daftar Langkah Praktis)
- Step containers: Sequential items numbered inside 32x32dp circular badges (`#FFD84D` or `#6EE7B7`, border `2px solid #171717`). 
- Divider lines between steps: `2px dashed #171717`.

### Navigation (Bilah Menu Android)
- Bottom Navigation Bar: Background `#FFFFFF`, top border `3px solid #171717`. Active tabs sit within a pill container styled in `#FFD84D` with `2px solid #171717` border. Labels: *Beranda*, *Kategori*, *Tersimpan*, *Profil*.