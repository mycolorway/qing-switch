/**
 * qing-switch v0.0.1
 * http://mycolorway.github.io/qing-switch
 *
 * Copyright Mycolorway Design
 * Released under the MIT license
 * http://mycolorway.github.io/qing-switch/license.html
 *
 * Date: 2017-02-10
 */
;(function(root, factory) {
  if (typeof module === 'object' && module.exports) {
    module.exports = factory(require('jquery'),require('qing-module'));
  } else {
    root.QingSwitch = factory(root.jQuery,root.QingModule);
  }
}(this, function ($,QingModule) {
var define, module, exports;
var b = require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"qing-switch":[function(require,module,exports){
var QingSwitch,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

QingSwitch = (function(superClass) {
  extend(QingSwitch, superClass);

  QingSwitch.opts = {
    el: null,
    cls: ""
  };

  function QingSwitch(opts) {
    this.toggleState = bind(this.toggleState, this);
    var initialized;
    QingSwitch.__super__.constructor.apply(this, arguments);
    this.opts = $.extend({}, QingSwitch.opts, this.opts);
    this.el = $(this.opts.el);
    if (!$(this.opts.el).is(':checkbox')) {
      throw new Error("QingSwitch: el should be a checkbox");
    }
    if ((initialized = this.el.data('qingSwitch'))) {
      return initialized;
    }
    this._render();
    this._bind();
    if (this.el.is(':disabled')) {
      this.disable();
    }
    this.toggleState(this.el.is(':checked'));
  }

  QingSwitch.prototype._render = function() {
    this.wrapper = $("<label class=\"qing-switch\">\n  <div class=\"switch\" tabindex=\"0\">\n    <span class=\"switch-toggle\"></span>\n  </div>\n</label>").data('qingSwitch', this).addClass(this.opts.cls).insertBefore(this.el).prepend(this.el);
    this["switch"] = this.wrapper.find('.switch');
    if (this.el.is(':disabled')) {
      this["switch"].removeAttr('tabindex');
    }
    return this.el.hide().data('qingSwitch', this);
  };

  QingSwitch.prototype._bind = function() {
    this.wrapper.on('keydown.qingSwitch', (function(_this) {
      return function(e) {
        if (e.keyCode !== 13) {
          return;
        }
        return _this.toggleState();
      };
    })(this));
    this["switch"].on('click', (function(_this) {
      return function() {
        if (_this.el.is(':disabled')) {
          return;
        }
        _this.toggleState();
        return false;
      };
    })(this));
    return this.el.on('change', (function(_this) {
      return function(e) {
        return _this.trigger('change', _this.el.prop('checked'));
      };
    })(this));
  };

  QingSwitch.prototype.toggleState = function(state) {
    if (state == null) {
      state = !this.el.is(':checked');
    }
    this.el.prop('checked', state);
    return this.el.trigger('change');
  };

  QingSwitch.prototype.disable = function() {
    this.el.attr('disabled', true);
    return this["switch"].removeAttr('tabindex');
  };

  QingSwitch.prototype.enable = function() {
    this.el.removeAttr('disabled');
    return this["switch"].attr('tabindex', '0');
  };

  QingSwitch.prototype.destroy = function() {
    this.el.show().insertBefore(this.wrapper).removeData('qingSwitch').off('.qingSwitch');
    return this.wrapper.remove();
  };

  return QingSwitch;

})(QingModule);

module.exports = QingSwitch;

},{}]},{},[]);

return b('qing-switch');
}));
