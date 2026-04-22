# Design System Document: The Curated Playground

## 1. Overview & Creative North Star
The Creative North Star for this design system is **"The Curated Playground."** 

Financial education often feels either overly sterile or condescendingly childish. This system rejects that binary. We are building a high-end editorial experience that treats younger users with intellectual respect while maintaining a sense of wonder. 

To break the "template" look, designers must embrace **Intentional Asymmetry**. Overlap elements across container boundaries, use high-contrast typography scales (pairing massive displays with tiny, precise labels), and leverage breathing room (whitespace) as a functional tool rather than a void. The goal is a layout that feels "assembled" by a curator, not "generated" by a grid.

---

## 2. Colors: Tonal Architecture
The palette is rooted in deep teals and aquatic blues, evoking stability and growth.

### The "No-Line" Rule
**Explicit Instruction:** Prohibit 1px solid borders for sectioning or containment. Boundaries must be defined solely through background color shifts. For example, a `surface-container-low` section sitting on a `background` provides all the definition needed. If you feel the need to "outline" something, you haven't used your surface tokens correctly.

### Surface Hierarchy & Nesting
Treat the UI as a series of physical layers—like stacked sheets of fine paper. 
- Use `surface-container-lowest` (#ffffff) for the primary interactive cards.
- Place these on a `surface-container` (#e7eeff) or `surface-container-low` (#f0f3ff) background.
- This creates a soft, natural depth that feels premium and tactile without the clutter of lines.

### The "Glass & Gradient" Rule
To move beyond a flat UI, use **Glassmorphism** for floating elements (e.g., navigation bars or "Achievement Unlocked" modals). Use semi-transparent versions of `surface` tokens with a `20px - 40px` backdrop-blur. 

### Signature Textures
Use subtle gradients for main CTAs or hero backgrounds. Transition from `primary` (#006184) to `primary-container` (#007ba7) at a 135-degree angle. This provides a "visual soul" and a sense of movement that flat fills cannot achieve.

---

## 3. Typography: Editorial Authority
We utilize two distinct typefaces to balance playfulness with professional financial education.

- **Display & Headlines (Plus Jakarta Sans):** Our "Voice." This geometric sans-serif should be used with generous letter-spacing (-0.02em) in larger sizes to feel modern and high-end. Use `display-lg` (3.5rem) for hero moments to command attention.
- **Body & Labels (Be Vietnam Pro):** Our "Information." This font provides exceptional legibility for financial terms. Use `body-md` (0.875rem) for most reading tasks to keep the interface feeling light and airy.

**Editorial Hierarchy:** Pair a `display-sm` headline with a `label-md` uppercase subheader (using `on-surface-variant`). This high-contrast pairing is a hallmark of premium editorial design.

---

## 4. Elevation & Depth: Tonal Layering
Traditional drop shadows are often a crutch for poor spatial design. In this system, we prioritize **Tonal Layering**.

- **The Layering Principle:** Depth is achieved by "stacking." A `surface-container-highest` (#d8e3fa) element should be the most prominent, while `surface` (#f9f9ff) acts as the base floor.
- **Ambient Shadows:** When an element must "float" (like a primary action button or a modal), use an extra-diffused shadow: `0px 20px 40px rgba(17, 28, 44, 0.06)`. The shadow color is a tinted version of `on-surface`, never pure black or grey.
- **The "Ghost Border" Fallback:** If a border is required for accessibility, it must be a "Ghost Border": use `outline-variant` at 15% opacity. 100% opaque borders are strictly forbidden.

---

## 5. Components: Tactile & Friendly

### Buttons
- **Primary:** Gradient fill (`primary` to `primary-container`), `full` rounded corners, and `title-sm` typography. 
- **Secondary:** `surface-container-highest` background with `primary` text. No border.
- **Interaction:** On hover, apply a subtle scale-up (1.02) and increase the ambient shadow spread.

### Cards & Progress
- **The Card Rule:** No dividers. Separate content using `1.5rem` (md) or `2rem` (lg) vertical whitespace. 
- **Progress Bars:** Use `secondary-container` (#76f4e0) for the track and a `secondary` (#006b5f) to `primary` gradient for the fill. The bar should have `xl` (3rem) rounded corners to feel friendly and "bubbly."

### Input Fields
- **Styling:** Use `surface-container-low` as the fill. 
- **States:** When focused, the background shifts to `surface-container-lowest` and a "Ghost Border" of `primary` (at 30% opacity) appears. This creates a "glow" rather than a hard edge.

### Achievement Badges (Custom Component)
For financial milestones, use a "Glass Orbit" style: a semi-transparent `tertiary-container` (#a06600) circle with a `backdrop-blur`. This highlights wealth/achievement using the warm gold tones of the `tertiary` palette.

---

## 6. Do's and Don'ts

### Do:
- **Do** use overlapping elements (e.g., an icon breaking the top edge of a card) to create a custom, non-boxed feel.
- **Do** use the `xl` and `full` roundedness tokens for interactive elements to keep the "friendly" brand promise.
- **Do** leverage the `tertiary` color tokens sparingly for "Aha!" moments and rewards.

### Don't:
- **Don't** use 1px solid borders. If the layout feels "bleeding together," increase the contrast between your `surface-container` tiers.
- **Don't** use standard "Material Design" blue. Always stick to the custom `primary` (#006184) teal-leaning blue for a signature look.
- **Don't** cramp the typography. If a screen feels busy, increase the whitespace before you decrease the font size. Editorial design lives and dies by its margins.