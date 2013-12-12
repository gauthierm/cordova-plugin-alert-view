/**
  AlertView iOS Cordova Plugin

  Copyright (c) 2013 silverorange Inc.

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  THE SOFTWARE.

  @author    Michael Gauthier <mike@silverorange.com>
  @copyright 2012 silverorange Inc.
  @license   http://www.opensource.org/licenses/mit-license.html MIT License
*/
(function(cordova) {

	function AlertView() {}

	AlertView.prototype.create = function(options, callback) {
		options || (options = {});
		var scope = options.scope || null;

		var config = {
			title: options.title || '',
			items : options.items || ['Cancel'],
			destructiveButtonIndex : options.hasOwnProperty('destructiveButtonIndex') ? options.destructiveButtonIndex : undefined,
			cancelButtonIndex : options.hasOwnProperty('cancelButtonIndex') ? options.cancelButtonIndex : undefined
		};

		var _callback = function(result) {
			var buttonValue = false;
			var buttonIndex = result.buttonIndex;

			if (!config.cancelButtonIndex || buttonIndex !== config.cancelButtonIndex) {
				buttonValue = config.items[buttonIndex];
			}

			if (typeof callback === 'function') {
				callback.apply(
					scope, {
						value: buttonValue,
						index: buttonIndex
					}
				);
			}
		};

		return cordova.exec(_callback, _callback, 'AlertView', 'create', [config]);
	};

	module.exports = new AlertView();

})(window.cordova || window.Cordova);
