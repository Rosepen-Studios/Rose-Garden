# Copilot instructions for Rose Garden

## Build, test, and lint commands

This repository does not currently define automated build, lint, or test commands (no CI workflows or language package manifests are present).

For local execution of the Godot project:

```bash
godot4 --path "Godot Dev Enviroment"
```

Use `Godot Dev Enviroment/test.tscn` as the manual validation scene when checking component behavior.

## High-level architecture

- The repo has two main tracks:
  - `Godot Dev Enviroment/`: the Godot plugin/runtime implementation of Rose Garden UI components.
  - `Website/design.md`: visual design-system guidance for web-facing work.
- `Godot Dev Enviroment/project.godot` is the integration point:
  - enables the editor plugin (`addons/RoseGarden/plugin.cfg`),
  - autoloads `RoseGarden`, `Icons`, and `Colors`.
- `addons/RoseGarden/plugin.gd` handles editor-time UX:
  - registers autoload singletons while plugin is active,
  - adds a toolbar button,
  - opens `editor/RGcomponent_dialogue.tscn`,
  - inserts selected components into the edited scene using `UndoRedo`.
- `addons/RoseGarden/globals/` contains shared runtime/editor services:
  - `RoseGarden.gd`: accessibility state + right-click menu creation/deletion helpers.
  - `RGmenu.gd`: menu data model used to build context menus.
  - `Colors.gd` and `Icons.gd`: central color/icon constants used by components.
- `addons/RoseGarden/components/` is component-centric:
  - one folder per component with scene/script/assets,
  - most controls are `@tool` scripts to keep editor preview and runtime behavior aligned.

## Key conventions

- **Component discovery convention is strict**: `editor/RGcomponent_dialogue.gd` scans `addons/RoseGarden/components/<Folder>/RG<Folder>.tscn`. New components must follow this naming to appear in the add-component dialog.
- **Descriptions are file-driven**: the editor dialog reads `components/<Folder>/description.txt` for per-component help text.
- **Global singletons are expected everywhere**: component scripts call `RoseGarden`, `Colors`, and `Icons` directly; preserve these autoload names when refactoring.
- **Public component APIs typically return Godot error codes** (`OK`, `ERR_DOES_NOT_EXIST`, `ERR_ALREADY_EXISTS`) rather than throwing; keep this pattern for new mutators.
- **Editor sync pattern**: many components use `@tool`, an `_update()` method, and `_process()` with `Engine.is_editor_hint()` to live-refresh inspector changes.
- **Shared color vocabulary**: exported color enums are aligned to `Colors.gd` constants and corresponding SVG asset names (`Base<Color>.svg`, etc.); keep enum values and asset filenames in sync.
- **Use undo-aware editor actions**: plugin scene edits should go through `get_undo_redo()` so added/removed nodes integrate with editor undo/redo.

## Source context to preserve

- `README.md` establishes scope and roadmap status (Figma-first design system with ongoing Godot port).
- `Website/design.md` is the authoritative style reference for web design direction.

## MCP server guidance

- **Playwright MCP** is the most relevant add-on for this repo when working on browser-rendered UI in `Website/` (layout checks, interaction debugging, visual regressions).
- When using Playwright MCP, treat `Website/design.md` as the style baseline for validating colors, typography, spacing, and component states.
