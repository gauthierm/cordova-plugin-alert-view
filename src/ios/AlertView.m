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
#import "AlertView.h"

@implementation AlertView

@synthesize callbackId = _callbackId;

- (void)create:(CDVInvokedUrlCommand*)command {

	self.callbackId = command.callbackId;
	NSDictionary *options = [command.arguments objectAtIndex:0];

	// compiling options with defaults
	NSString *title = [options objectForKey:@"title"] ?: @"";
	NSString *message = [options objectForKey:@"message"] ?: @"";
	NSArray *items = [options objectForKey:@"items"];
	NSInteger cancelButtonIndex = [[options objectForKey:@"cancelButtonIndex"] intValue] ?: false;
	NSInteger destructiveButtonIndex = [[options objectForKey:@"destructiveButtonIndex"] intValue] ?: false;

	// create AlertView
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
	                                              message:message
	                                              delegate:self
	                                              cancelButtonTitle:nil
	                                              destructiveButtonTitle:nil
	                                              otherButtonTitles:nil
	];

	// fill with elements
	for (int i = 0; i < [items count]; i++) {
		[alertView addButtonWithTitle:[items objectAtIndex:i]];
	}

	// handle cancelButtonIndex
	if ([options objectForKey:@"cancelButtonIndex"]) {
		alertView.cancelButtonIndex = cancelButtonIndex;
	}
	// handle destructiveButtonIndex
	if ([options objectForKey:@"destructiveButtonIndex"]) {
		alertView.destructiveButtonIndex = destructiveButtonIndex;
	}

	[alertView show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {

	// build returned result
	NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
	[result setObject:[NSNumber numberWithInteger:buttonIndex] forKey:@"buttonIndex"];

	// create plugin result
	CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];

	// call success or fail callback
	if (buttonIndex == alertView.cancelButtonIndex) {
		[self writeJavascript: [pluginResult toErrorCallbackString:self.callbackId]];
	} else {
		[self writeJavascript: [pluginResult toSuccessCallbackString:self.callbackId]];
	}
}

@end
