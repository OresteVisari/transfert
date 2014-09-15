namespace Transfert.Widgets {
	public class Window : Gtk.Window {
		ETorrent.Session session;
		Gtk.ListBox listbox;
		
		construct {
			session = new ETorrent.Session();
			session.init();
			
			set_size_request (400, 300);
			var bar = new HeaderBar();
			var menu = new Gtk.Menu();
			bar.button_menu.popup = menu;
			var item = new Gtk.MenuItem.with_label ("add");
			item.activate.connect (() => {
				var dialog = new UrlDialog();
				if (dialog.run() == (int)Gtk.ResponseType.OK) {
					add_uri (dialog.url);
				}
				dialog.destroy();
			});
			menu.append (item);
			item.show();
			set_titlebar (bar);
			
			const Gtk.TargetEntry[] targets = { {"text/uri-list",0,0} };
			Gtk.drag_dest_set (this, Gtk.DestDefaults.ALL, targets, Gdk.DragAction.COPY);
			drag_data_received.connect (on_drag_data_received);
			
			listbox = new Gtk.ListBox();
			add (listbox);
		}
		
		private void on_drag_data_received (Gdk.DragContext drag_context, int x, int y, Gtk.SelectionData data, uint info, uint time) {
			foreach(string uri in data.get_uris ())
				add_uri (uri);
			Gtk.drag_finish (drag_context, true, false, time);
		}
		
		int count = 0;
		
		void add_uri (string uri) throws GLib.Error {
			var row = new ListBoxRow(uri);
			listbox.prepend (row);
			if (row.downloadable.get_type().is_a (typeof (ETorrent.Torrent)))
				session.add ((ETorrent.Torrent)row.downloadable);
			listbox.show_all();
		}
	}
}
