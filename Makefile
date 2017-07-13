DEST ?=
DATADIR ?= /usr/share/cockpit/

PLUGINS := about

ifeq ($(V),1)
  Q =
else
  Q = @
endif

install-%:
	$(Q)install -d $(DEST)$(DATADIR)$*
	$(Q)install -m 0644 $(wildcard $*/*) $(DEST)$(DATADIR)$*/

install: $(addprefix install-,$(PLUGINS))
