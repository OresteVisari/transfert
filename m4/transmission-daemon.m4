# ici on teste les macros.

AC_DEFUN([TEST_PROG],[
	AC_CHECK_PROG([var],[$1],[yes],[no])
	AM_CONDITIONAL([FOUND_PROG], [test "x$var" = xyes])
	AM_COND_IF([FOUND_PROG],,
	[AC_MSG_ERROR([required program '$1' not found.])])
])
