namespace Transfert {
	namespace Widgets {
		public class HeaderBar : Gtk.HeaderBar {
			public Gtk.MenuButton button_menu { get; private set; }
			
			construct {
				title = "Transfert";
				button_menu = new Gtk.MenuButton();
				button_menu.add (new Gtk.Image.from_icon_name ("applications-system", Gtk.IconSize.BUTTON));
				button_menu.label = "test";
				
				pack_start (button_menu);
				show_close_button = true;
			}
		}
	}
}
