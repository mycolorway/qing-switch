class QingSwitch extends QingModule

  @opts:
    el: null
    cls: ""

  constructor: (opts) ->
    super
    @opts = $.extend {}, QingSwitch.opts, @opts

    @el = $ @opts.el
    unless $(@opts.el).is(':checkbox')
      throw new Error "QingSwitch: el should be a checkbox"
    if (initialized = @el.data('qingSwitch'))
      return initialized

    @_render()
    @_bind()

    @toggleState(@el.is(':checked'))

  _render: ->
    @wrapper = $("""
      <label class="qing-switch">
        <div class="switch" tabindex="0">
          <span class="switch-toggle"></span>
        </div>
      </label>
    """)
      .data 'qingSwitch', @
      .addClass @opts.cls
      .insertBefore @el
      .prepend(@el)

    @switch = @wrapper.find('.switch')
    @switch.removeAttr 'tabindex' if @el.is ':disabled'
    @el.hide().data 'qingSwitch', @

  _bind: ->
    @wrapper.on 'keydown.qingSwitch', (e)=>
      return unless e.keyCode == 13
      @toggleState()

    @el.on 'change', (e) =>
      @trigger 'change', @el.prop('checked')

  toggleState: (state = !@el.is(':checked')) =>
    @el.prop 'checked', state
    @el.trigger 'change'

  disable: ->
    @el.attr 'disabled', true
    @switch.removeAttr 'tabindex'

  enable: ->
    @el.removeAttr 'disabled'
    @switch.attr 'tabindex', '0'

  destroy: ->
    @el.show()
      .insertBefore(@wrapper)
      .removeData 'qingSwitch'
      .off '.qingSwitch'
    @wrapper.remove()

module.exports = QingSwitch
