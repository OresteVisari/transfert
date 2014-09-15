namespace Transfert.Widgets {
	public class UrlDialog : Gtk.Dialog {
		Gtk.Entry entry;
		
		public UrlDialog () {
			Object (use_header_bar: 1);
			title = "Add uri";
			add_button ("cancel", Gtk.ResponseType.CANCEL);
			add_button ("ok", Gtk.ResponseType.OK);
			entry = new Gtk.Entry();
			get_content_area().pack_start (entry);
			entry.show();
		}
		
		public string url {
			owned get {
				return entry.text;
			}
		}
	}
}
