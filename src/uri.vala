namespace Transfert {
	public errordomain UriError {
		NULL,
		BAD
	}
	
	// utility class which wraps GLib.Filename namespace.
	[Experimental]
	public class Uri {
		string _uri;
		
		public Uri (string str) throws UriError {
			scheme = GLib.Uri.parse_scheme (str);
			if (scheme == null) {
				try {
					_uri = Filename.to_uri (str);
					path = str;
				} catch {
					throw new UriError.BAD ("invalid path string.");
				}
			} else if (scheme == "file") {
				try {
					path = Filename.from_uri (str);
					_uri = str;
				} catch {
					throw new UriError.BAD ("invalid uri file string.");
				}
			} else {
				_uri = str;
				path = _uri.substring (scheme.length + 3);
			}
		}
		
		public string extension {
			owned get {
				return path.substring (path.last_index_of (".") + 1);
			}
		}
		
		public string scheme { get; private set; }
		
		public string path { get; private set; }
		
		public string[] segments {
			owned get {
				return path.split ("/");
			}
		}
		
		public string to_string() {
			return _uri;
		}
	}
}
