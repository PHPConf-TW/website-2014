assert = require("assert")
fs = require('fs')

describe 'html5 template generator test', ->
  it 'creates expected files', ->
    expected = [
      'dist/favicon.ico'
      'dist/index.html'
      'dist/404.html'
      'dist/robots.txt'
    ]
    for item in expected
      assert.equal(true, fs.existsSync(item))

  it 'delete expected files', ->
    not_expected = [
      'dist/assets/vendor/'
    ]
    for item in not_expected
      assert.equal(false, fs.existsSync(item))
  null
