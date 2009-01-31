/**
 * Appcelerator Titanium - licensed under the Apache Public License 2
 * see LICENSE in the root folder for details on the license.
 * Copyright (c) 2009 Appcelerator, Inc. All Rights Reserved.
 */


#ifndef _GTK_MENU_ITEM_IMPL_H_
#define _GTK_MENU_ITEM_IMPL_H_

namespace ti
{

	class GtkMenuItemImpl : public MenuItem
	{

	public:
		GtkMenuItemImpl();

		void DeleteWidget(GtkWidget*);
		void SetParent(GtkMenuItemImpl* parent);
		GtkMenuItemImpl* GetParent();

		SharedValue AddSeparator();
		SharedValue AddItem(SharedValue label,
		                    SharedValue callback,
		                    SharedValue icon_url);
		SharedValue AddSubMenu(SharedValue label,
		                       SharedValue icon_url);

		SharedValue AppendItem(GtkMenuItemImpl* item);

		GtkWidget* GetMenu();
		GtkWidget* GetMenuBar();
		void ClearRealization(GtkWidget *parent_menu);

		void Enable();
		void Disable();

		struct MenuPieces
		{
			MenuPieces()
				 : item(NULL),
				   menu(NULL),
				   callback(NULL),
				   parent_menu(NULL) { }
			GtkWidget* item; // This item's widget
			GtkWidget* menu; // This item's submenu
			SharedBoundMethod callback; // This item's callback
			GtkWidget* parent_menu; // This item's parent's widget
		};

	private:
		GtkMenuItemImpl *parent; // NULL parent means this is top-level menu.
		std::vector<GtkMenuItemImpl*> children;
		std::vector<MenuPieces*> instances;
		std::vector<GtkWidget*> widget_menus;

		MenuPieces* Realize(bool is_menu_bar);
		void MakeMenuPieces(MenuPieces& pieces);


	};

}

#endif