namespace Transfert {
	public interface Downloadable : Object {
		public abstract double progress { get; }
		public abstract int64 size { get; }
		public abstract string title { owned get; }
	}
	
	public class Torrent : ETorrent.Torrent, Downloadable {
		string _title;
		
		public Torrent (string path, string save_path = Environment.get_home_dir()) {
			base (path, save_path);
			added.connect (() => {
				_title = name;
			});
		}
		
		public Torrent.from_uri (string uri, string save_path = Environment.get_home_dir()) {
			base.from_uri (uri, save_path);
			added.connect (() => {
				_title = name;
			});
		}
		
		public double progress {
			get {
				return percent_done;
			}
		}
		
		public int64 size {
			get {
				return size_when_done;
			}
		}
		
		public string title {
			owned get {
				return _title;
			}
		}
	}

	public class DirectDownload : Object, Downloadable {
		double d;
		string _title;
		int64 _size;
		
		public DirectDownload (string uri, string save_path = Environment.get_home_dir()) {
			var file = File.new_for_uri (uri);
			var info = file.query_info ("standard::*", FileQueryInfoFlags.NOFOLLOW_SYMLINKS);
			print ("size: %lld\n", info.get_size());
			_size = 0;
			_title = uri.split ("/")[uri.split ("/").length - 1];
			var save = File.new_for_path (save_path + "/" + _title);
			file.copy_async.begin (save, FileCopyFlags.OVERWRITE, Priority.DEFAULT, null, (current, total) => {
				print ("current: %lld, total: %lld\n", current, total);
			}, (obj, res) => {
				file.copy_async.end (res);
			});
		}
		
		public double progress {
			get {
				return d;
			}
		}
		
		public int64 size {
			get {
				return _size;
			}
		}
		
		public string title {
			owned get {
				return _title;
			}
		}
	}
}
