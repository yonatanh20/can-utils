#
#  Copyright (c) 2002-2005 Volkswagen Group Electronic Research
#  All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions, the following disclaimer and
#     the referenced file 'COPYING'.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#  3. Neither the name of Volkswagen nor the names of its contributors
#     may be used to endorse or promote products derived from this software
#     without specific prior written permission.
#
#  Alternatively, provided that this notice is retained in full, this
#  software may be distributed under the terms of the GNU General
#  Public License ("GPL") version 2 as distributed in the 'COPYING'
#  file from the main directory of the linux kernel source.
#
#  The provided data structures and external interfaces from this code
#  are not restricted to be used by modules with a GPL compatible license.
#
#  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
#  "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
#  LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
#  A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
#  OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
#  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
#  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
#  THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
#  DAMAGE.
#
#  Send feedback to <linux-can@vger.kernel.org>

DESTDIR ?=
PREFIX ?= /usr/local

MAKEFLAGS := -k

CFLAGS := -O2 -Wall -Wno-parentheses

CPPFLAGS += \
	-Iinclude \
	-DAF_CAN=PF_CAN \
	-DPF_CAN=29 \
	-DSO_RXQ_OVFL=40 \
	-DSCM_TIMESTAMPING_OPT_STATS=54 \
	-D_FILE_OFFSET_BITS=64 \
	-D_GNU_SOURCE

PROGRAMS_CANGW := \
	cangw

PROGRAMS_ISOTP := \
	isotpdump \
	isotpperf \
	isotprecv \
	isotpsend \
	isotpserver \
	isotpsniffer \
	isotptun

PROGRAMS_J1939 := \
	j1939acd \
	j1939cat \
	j1939spy \
	j1939sr \
	testj1939

PROGRAMS_SLCAN := \
	slcan_attach \
	slcand

PROGRAMS := \
	$(PROGRAMS_CANGW) \
	$(PROGRAMS_ISOTP) \
	$(PROGRAMS_J1939) \
	$(PROGRAMS_SLCAN) \
	asc2log \
	bcmserver \
	can-calc-bit-timing \
	canbusload \
	candump \
	canfdtest \
	cangen \
	cansequence \
	canlogserver \
	canplayer \
	cansend \
	cansniffer \
	canstream \
	log2asc \
	log2long \
	mcp251xfd-dump \
	slcanpty

all: $(PROGRAMS)

clean:
	rm -f $(PROGRAMS) *.o mcp251xfd/*.o

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f $(PROGRAMS) $(DESTDIR)$(PREFIX)/bin

distclean: clean
	rm -f $(PROGRAMS) $(LIBRARIES) *~

asc2log.o:	lib.h
candump.o:	lib.h
cangen.o:	lib.h
canlogserver.o:	lib.h
canplayer.o:	lib.h
cansend.o:	lib.h
canstream.o:	lib.h
log2asc.o:	lib.h
log2long.o:	lib.h
j1939acd.o:	libj1939.h
j1939cat.o:	libj1939.h
j1939spy.o:	libj1939.h
j1939sr.o:	libj1939.h
testj1939.o:	libj1939.h
canframelen.o:  canframelen.h

asc2log:	asc2log.o	lib.o
candump:	candump.o	lib.o
cangen:		cangen.o	lib.o
canlogserver:	canlogserver.o	lib.o
canplayer:	canplayer.o	lib.o
cansend:	cansend.o	lib.o
cansequence:	cansequence.o	lib.o
canstream:	canstream.o	lib.o
log2asc:	log2asc.o	lib.o
log2long:	log2long.o	lib.o
j1939acd:	j1939acd.o	libj1939.o
j1939cat:	j1939cat.o	libj1939.o
j1939spy:	j1939spy.o	libj1939.o
j1939sr:	j1939sr.o	libj1939.o
testj1939:	testj1939.o	libj1939.o
canbusload:	canbusload.o	canframelen.o

mcp251xfd-dump:	mcp251xfd/mcp251xfd-dev-coredump.o mcp251xfd/mcp251xfd-dump.o mcp251xfd/mcp251xfd-main.o mcp251xfd/mcp251xfd-regmap.o
	$(CC) $(LDFLAGS) $^ $(LDLIBS) -o $@
