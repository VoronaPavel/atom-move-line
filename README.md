# atom-move-line package

This package takes care of trailing commas when moving lines in json with 'editor:move-line-up' and 'editor:move-line-down'.

![demo](https://raw.githubusercontent.com/pvorona/atom-move-line/master/images/demo.gif)

**Features**
- Support of multiple cursors
- Support of multiline selections
- Works for multiline objects **and** arrays
- Moving comma is collapsed in undo/redo history with move-line command
- Cursors and selections are preserved

**Todo**
- Currently package cannot handle trailing whitespaces and line comments after commas, I'm working on it
- Add autoinsert commas (not only swapping)

*This functionality is inspired by JetBrains products.*

Please, [report](https://github.com/pvorona/atom-move-line/issues/new) any bug You find.
