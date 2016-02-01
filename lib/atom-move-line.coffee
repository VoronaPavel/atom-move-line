{CompositeDisposable} = require 'atom'

module.exports = MoveLine =
  activate: ->
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-text-editor', subscriptions

  deactivate: ->
    @subscriptions.dispose()

subscriptions =
  'editor:move-line-up'  : => withActiveEditor preservingSelections moveUp
  'editor:move-line-down': => withActiveEditor preservingSelections moveDown

withActiveEditor = (action) ->
  action(atom.workspace.getActiveTextEditor())

preservingSelections = (action) -> (editor) ->
  selections = editor.getSelectedBufferRanges()
  action(editor)
  editor.setSelectedBufferRanges(selections)

lastLine = (prevLine, lastLine) ->
  prevLine.endsWith(',') and not lastLine.endsWith(',')

declaration = (line) ->
  line.endsWith('{') or line.endsWith('[')

atTheEndOfLine = (line, action) -> (editor) ->
  editor.setCursorBufferPosition([line])
  editor.moveToEndOfLine()
  action()

moveLines = (prevRow, lastRow) -> (editor) ->
  [prevLineText, lastLineText] = [editor.lineTextForBufferRow(prevRow), editor.lineTextForBufferRow(lastRow)]
  return if not lastLine(prevLineText, lastLineText) or declaration(lastLineText)
  atTheEndOfLine(lastRow, => editor.insertText(','))(editor)
  atTheEndOfLine(prevRow, => editor.backspace())(editor)

moveUp = (editor) ->
  editor.getCursorBufferPositions().forEach(({row}) -> moveLines(row + 1, row)(editor))

moveDown = (editor) ->
  editor.getCursorBufferPositions().reverse().forEach(({row}) -> moveLines(row, row - 1)(editor))
