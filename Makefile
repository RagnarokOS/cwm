# Makefile for cwm
# $Ragnarok: Makefile,v 1.8 2024/03/25 16:47:50 lecorbeau Exp $

CC=		clang

PROG=		cwm

PREFIX?=	/usr
X11BASE =	/usr

SRCS=		calmwm.c screen.c xmalloc.c client.c menu.c \
		search.c util.c xutil.c conf.c xevents.c group.c \
		kbfunc.c parse.y

OBJS=		calmwm.o screen.o xmalloc.o client.o menu.o \
		search.o util.o xutil.o conf.o xevents.o group.o \
		kbfunc.o strlcpy.o strlcat.o parse.o \
		strtonum.o reallocarray.o
		
CPPFLAGS+=	-I${X11BASE}/include -I${X11BASE}/include/freetype2 \
		-D_FORTIFY_SOURCE=2

CFLAGS?=	-Wall -O2 -D_GNU_SOURCE -flto=thin -Wformat -Wformat-security \
		-fstack-clash-protection -fstack-protector-strong -fcf-protection

LDFLAGS+=	-flto=thin -Wl,-O2 -Wl,-z,relro,-z,now -Wl,--as-needed -L${X11BASE}/lib \
		-lXft -lfreetype -lX11-xcb -lX11 -lxcb -lXau -lXdmcp -lfontconfig -lexpat \
		-lfreetype -lz -lXrandr -lXext

MANPREFIX?=	${PREFIX}/share/man

all: ${PROG}

clean:
	rm -f ${OBJS} ${PROG} parse.c

${PROG}: ${OBJS}
	${CC} ${OBJS} ${LDFLAGS} -o ${PROG}

.c.o:
	${CC} -c ${CFLAGS} ${CPPFLAGS} $<

install: ${PROG}
	install -d ${DESTDIR}${PREFIX}/bin ${DESTDIR}${MANPREFIX}/man1 ${DESTDIR}${MANPREFIX}/man5
	install -m 755 cwm ${DESTDIR}${PREFIX}/bin
	install -m 644 cwm.1 ${DESTDIR}${MANPREFIX}/man1
	install -m 644 cwmrc.5 ${DESTDIR}${MANPREFIX}/man5

deb: all
	/usr/bin/equivs-build cwm.pkg

.PRECIOUS: parse.c
