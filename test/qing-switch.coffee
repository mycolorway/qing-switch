QingSwitch = require '../src/qing-switch'
expect = chai.expect

describe 'QingSwitch', ->

  $el = null
  qingSwitch = null

  beforeEach ->
    $el = $('<input class="test-el" type="checkbox"/>').appendTo 'body'
    qingSwitch = new QingSwitch
      el: '.test-el'

  afterEach ->
    qingSwitch.destroy()
    qingSwitch = null
    $el.remove()
    $el = null

  it 'should inherit from QingModule', ->
    expect(qingSwitch).to.be.instanceof QingModule
    expect(qingSwitch).to.be.instanceof QingSwitch

  it 'should throw error when element not found', ->
    spy = sinon.spy QingSwitch
    try
      new spy
        el: '.not-exists'
    catch e

    expect(spy.calledWithNew()).to.be.true
    expect(spy.threw()).to.be.true

  it 'should throw error when element is not a checkbox', ->
    spy = sinon.spy QingSwitch
    try
      new spy
        el: $('div')
    catch e

    expect(spy.calledWithNew()).to.be.true
    expect(spy.threw()).to.be.true

  it 'should switch off when checkbox is unchecked', ->
    expect(qingSwitch.checked).to.be.false

  it 'should switch on when checkbox is checked', ->
    qingSwitch.destroy()
    $el.prop 'checked', true
    qingSwitch = new QingSwitch
      el: '.test-el'
    $el.prop 'checked', true
    expect(qingSwitch.checked).to.be.true

  it 'should sync check state of original checkbox element', ->
    expect(qingSwitch.checked).to.be.false
    expect($el.is(':checked')).to.be.false

    $el.click()
    expect(qingSwitch.checked).to.be.true
    expect($el.is(':checked')).to.be.true

    qingSwitch.toggleState(false)
    expect(qingSwitch.checked).to.be.false
    expect($el.is(':checked')).to.be.false

    qingSwitch.toggleState(true)
    expect(qingSwitch.checked).to.be.true
    expect($el.is(':checked')).to.be.true


  it 'should change state when calling toggleState without params', ->
    expect(qingSwitch.checked).to.be.false
    expect($el.is(':checked')).to.be.false

    qingSwitch.toggleState()
    expect(qingSwitch.checked).to.be.true
    expect($el.is(':checked')).to.be.true

    qingSwitch.toggleState()
    expect(qingSwitch.checked).to.be.false
    expect($el.is(':checked')).to.be.false

  it 'should show original checkbox after calling destroy', ->
    expect($el.is(':hidden')).to.be.true
    expect($el.closest('.qing-switch').is(':visible')).to.be.true

    qingSwitch.destroy()
    expect($el.is(':visible')).to.be.true
    expect($el.closest('.qing-switch').length).to.be.equal 0

