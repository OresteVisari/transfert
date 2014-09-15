AM_CPPFLAGS = $(TRANSFERT_CFLAGS)

AM_CFLAGS = -I../libetorrent `pkg-config --cflags gtk+-3.0` \
	-w

bin_PROGRAMS = transfert

transfert_SOURCES = main.vala uri.vala downloadable.vala \
	widgets/dialogs.vala widgets/listboxrow.vala widgets/window.vala widgets/headerbar.vala widgets/closemenu.vala
transfert_LDADD = ../libetorrent/libetorrent.la $(TRANSFERT_LIBS)
transfert_VALAFLAGS = ../libetorrent/etorrent-0.1.vapi --pkg gtk+-3.0

CLEANFILES = widgets/*.c widgets/*.o *.c *.o *.stamp transfert

DISTCLEANFILES = $(CLEANFILES) Makefile.in
