/**
 * Appcelerator Titanium - licensed under the Apache Public License 2
 * see LICENSE in the root folder for details on the license.
 * Copyright (c) 2008 Appcelerator, Inc. All Rights Reserved.
 */
#import "preinclude.h"
#import "../window_module.h"
#import <WebKit/WebKit.h>
#import "native_window.h"

namespace ti
{
	class OSXUserWindow : public UserWindow {

		public:
			OSXUserWindow(Host *host, WindowConfig *config);
		protected:
			~OSXUserWindow();
		public:
			void Hide();
			void Show();
			bool IsUsingChrome();
			bool IsUsingScrollbars();
			bool IsFullScreen();
			std::string GetId();
			void Open();
			void Close();
			double GetX();
			void SetX(double x);
			double GetY();
			void SetY(double y);
			double GetWidth();
			void SetWidth(double width);
			double GetHeight();
			void SetHeight(double height);
			Bounds GetBounds();
			void SetBounds(Bounds bounds);
			std::string GetTitle();
			void SetTitle(std::string& title);
			std::string GetUrl();
			void SetUrl(std::string& url);
			bool IsResizable();
			void SetResizable(bool resizable);
			bool IsMaximizable();
			void SetMaximizable(bool maximizable);
			bool IsMinimizable();
			void SetMinimizable(bool minimizable);
			bool IsCloseable();
			void SetCloseable(bool closeable);
			bool IsVisible();
			void SetVisible(bool visible);
			double GetTransparency();
			void SetTransparency(double transparency);
			void SetFullScreen(bool fullscreen);

			const NativeWindow* GetNative() const { return window; }

		private:
			NativeWindow *window;
			
			DISALLOW_EVIL_CONSTRUCTORS(OSXUserWindow);
	};
}
