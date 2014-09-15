namespace Transfert.Widgets {
	public class ListBoxRow : Gtk.ListBoxRow {
		public ListBoxRow (string uri) {
			var turi = new Transfert.Uri (uri);
			if (strcmp (turi.extension, "torrent") == 0) {
				if (strcmp (turi.scheme, "file") == 0)
					downloadable = new Transfert.Torrent (turi.path);
				else
					downloadable = new Transfert.Torrent.from_uri (turi.to_string());
			}
			else
				downloadable = new Transfert.DirectDownload (turi.to_string());
			activatable = true;
			selectable = true;
			title = new Gtk.Label (downloadable.title);
			status = new Gtk.Label ("");
			var pb = new Gtk.ProgressBar();
			pb.fraction = 0.5;
			var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
			box.pack_start (title);
			box.pack_start (pb);
			box.pack_start (status);
			child = box;
			Timeout.add (100, () => {
				title.label = downloadable.title;
				status.label = "downloaded: %f%".printf (downloadable.progress * 100);
				pb.fraction = downloadable.progress;
				return true;
			});
		}
		
		public Transfert.Downloadable downloadable { get; private set; }
		
		Gtk.Label title;
		Gtk.Label status;
	}
}
