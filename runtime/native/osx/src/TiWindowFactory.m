/**
 * This file is part of Appcelerator's Titanium project.
 *
 * Copyright 2008 Appcelerator, Inc.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *    http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License. 
 */

#import "TiWindowFactory.h"
#import "TiController.h"

@implementation TiWindowFactory

@synthesize mainWindow;
@synthesize currentWindow;

- (id)initWithWindow:(TiWindow *)win 
{
	self = [super init];
	TRACE(@"TiWindowFactory::initWithWindow: %x",self);
	if (self != nil)  
	{
		// don't retain any of these
		window = win;
		windows = [[NSMutableArray alloc] init];
		webView = [TiController getWebView:window];
		mainWindow = [[TiController getDocument:win] userWindow];
		currentWindow = [[TiController getDocument:win] userWindow];
	}
	return self;
}

- (void)dealloc
{
	TRACE(@"TiWindowFactory::dealloc: %x",self);
	webView = nil;
	currentWindow = nil;
	mainWindow = nil;
	window = nil;
	[windows removeAllObjects];
	[windows release];
	windows = nil;
	[super dealloc];
}

- (void)addWindow:(TiUserWindow*)awindow
{
	[windows addObject:awindow];
}

- (void)removeWindow:(TiUserWindow*)awindow
{
	[windows removeObject:awindow];
}

- (TiUserWindow *)getWindow:(NSString*)windowid
{
	NSEnumerator *enumerator = [windows objectEnumerator];
	TiUserWindow* anObject = nil;
	
	while (anObject = [enumerator nextObject]) 
	{
		if ([[anObject getID] isEqualToString:windowid])
		{
			return anObject;
		}
	}
	return nil;
}

- (void)setProperty:(NSString *)name sel:(SEL)sel script:(WebScriptObject*)script win:(TiUserWindow*)win
{
	@try
	{
		id value = [script valueForKey:name];
		[win performSelector:sel withObject:value];
	}
	@catch(NSException *exception)
	{
		// weird thing is that valueForKey throws exception if the property doesn't exist
		// in the object - seems like it should return webundefined or nil
	}
}

- (TiUserWindow *)createWindow:(id)arg1 chrome:(BOOL)chrome
{
	TiDocument *doc = [TiController getDocument:window];
	TiUserWindow *win = [[TiUserWindow alloc] initWithWebview:webView];

	if (arg1 != nil)
	{
		if ([arg1 isKindOfClass:[NSString class]])
		{
			// first arg is a string, it's an id
			[win setID:arg1];
			[win setUsingChrome:chrome];
		}
		else if ([arg1 isKindOfClass:[WebScriptObject class]])
		{
			WebScriptObject *ws = (WebScriptObject*)arg1;
			[self setProperty:@"id" sel:@selector(setID:) script:ws win:win];
			[self setProperty:@"content" sel:@selector(setContent:) script:ws win:win];
			[self setProperty:@"url" sel:@selector(setURL:) script:ws win:win];
			[self setProperty:@"x" sel:@selector(setX:) script:ws win:win];
			[self setProperty:@"y" sel:@selector(setY:) script:ws win:win];
			[self setProperty:@"icon" sel:@selector(setIcon:) script:ws win:win];
			[self setProperty:@"title" sel:@selector(setTitle:) script:ws win:win];
			[self setProperty:@"transparency" sel:@selector(setTransparency:) script:ws win:win];
			[self setProperty:@"chrome" sel:@selector(setUsingChrome:) script:ws win:win];
			[self setProperty:@"width" sel:@selector(setWidth:) script:ws win:win];
			[self setProperty:@"height" sel:@selector(setHeight:) script:ws win:win];
			[self setProperty:@"resizable" sel:@selector(setResizable:) script:ws win:win];
			[self setProperty:@"fullscreen" sel:@selector(setFullscreen:) script:ws win:win];
			[self setProperty:@"scrollbars" sel:@selector(setUsingScrollbars:) script:ws win:win];
			[self setProperty:@"maximizable" sel:@selector(setMaximizable:) script:ws win:win];
			[self setProperty:@"minimizable" sel:@selector(setMinimizable:) script:ws win:win];
			[self setProperty:@"closeable" sel:@selector(setCloseable:) script:ws win:win];
			[self setProperty:@"visible" sel:@selector(setVisible:) script:ws win:win];
		}
	}	
	[win setParent:doc];
	[doc addChildWindow:win];
	[self addWindow:win];
	TRACE(@"TiWindowFactory::createWindow - created: %x, parent: %x",win,doc);
	return win;
}

#pragma mark -
#pragma mark WebScripting

+ (NSString *)webScriptNameForSelector:(SEL)sel 
{
	if (sel == @selector(createWindow:chrome:)) {
		return @"createWindow";
	}
	else if (sel == @selector(getWindow:)) {
		return @"getWindow";
	}
	return nil;
}

+ (BOOL)isSelectorExcludedFromWebScript:(SEL)sel {
	return (nil == [self webScriptNameForSelector:sel]);
}

+ (NSString *)webScriptNameForKey:(const char *)name {
	if (strcmp(name, "mainWindow") == 0) {
		return @"mainWindow";
	}
	else if (strcmp(name, "currentWindow") == 0) {
		return @"currentWindow";
	}
	return nil;
}

+ (BOOL)isKeyExcludedFromWebScript:(const char*)key {
	return (nil == [self webScriptNameForKey:key]);
}

@end
