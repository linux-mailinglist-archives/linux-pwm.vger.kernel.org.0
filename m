Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5749C6AB924
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Mar 2023 10:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCFJBV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Mar 2023 04:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjCFJBU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Mar 2023 04:01:20 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51371227A8;
        Mon,  6 Mar 2023 01:01:09 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.98,236,1673881200"; 
   d="scan'208";a="151662877"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Mar 2023 18:01:08 +0900
Received: from localhost.localdomain (unknown [10.226.93.39])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 775C241C9E84;
        Mon,  6 Mar 2023 18:01:05 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-pwm@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [DO NOT APPLY PATCH v6 13/13] tools/poeg: Add test app for poeg
Date:   Mon,  6 Mar 2023 09:00:14 +0000
Message-Id: <20230306090014.128732-14-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
References: <20230306090014.128732-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add test app for poeg

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 tools/poeg/Build      |  1 +
 tools/poeg/Makefile   | 53 ++++++++++++++++++++++++++++++++++++++
 tools/poeg/poeg_app.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 tools/poeg/Build
 create mode 100644 tools/poeg/Makefile
 create mode 100644 tools/poeg/poeg_app.c

diff --git a/tools/poeg/Build b/tools/poeg/Build
new file mode 100644
index 000000000000..f960920a4afb
--- /dev/null
+++ b/tools/poeg/Build
@@ -0,0 +1 @@
+poeg_app-y += poeg_app.o
diff --git a/tools/poeg/Makefile b/tools/poeg/Makefile
new file mode 100644
index 000000000000..6946e6956215
--- /dev/null
+++ b/tools/poeg/Makefile
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+include ../scripts/Makefile.include
+
+bindir ?= /usr/bin
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+
+# Do not use make's built-in rules
+# (this improves performance and avoids hard-to-debug behaviour);
+MAKEFLAGS += -r
+
+override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+
+ALL_TARGETS := poeg_app
+ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
+
+all: $(ALL_PROGRAMS)
+
+export srctree OUTPUT CC LD CFLAGS
+include $(srctree)/tools/build/Makefile.include
+
+#
+# We need the following to be outside of kernel tree
+#
+$(OUTPUT)include/linux/poeg.h: ../../include/linux/soc/renesas/rzg2l-poeg.h
+	mkdir -p $(OUTPUT)include/linux 2>&1 || true
+	ln -sf $(CURDIR)/../../include/linux/soc/renesas/rzg2l-poeg.h $@
+
+prepare: $(OUTPUT)include/linux/poeg.h
+
+COUNTER_EXAMPLE := $(OUTPUT)poeg_app.o
+$(COUNTER_EXAMPLE): prepare FORCE
+	$(Q)$(MAKE) $(build)=poeg_app
+$(OUTPUT)poeg_app: $(COUNTER_EXAMPLE)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
+
+clean:
+	rm -f $(ALL_PROGRAMS)
+	rm -rf $(OUTPUT)include/linux/counter.h
+	find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
+
+install: $(ALL_PROGRAMS)
+	install -d -m 755 $(DESTDIR)$(bindir);		\
+	for program in $(ALL_PROGRAMS); do		\
+		install $$program $(DESTDIR)$(bindir);	\
+	done
+
+FORCE:
+
+.PHONY: all install clean FORCE prepare
diff --git a/tools/poeg/poeg_app.c b/tools/poeg/poeg_app.c
new file mode 100644
index 000000000000..79cacb8c60c5
--- /dev/null
+++ b/tools/poeg/poeg_app.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * POEG - example userspace application
+ * Copyright (C) 2022 Biju Das
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <errno.h>
+#include <sys/ioctl.h>
+#include <linux/ioctl.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/time.h>
+#include <sys/types.h>
+#include <poll.h>
+
+#include <linux/poeg.h>
+
+int main(int argc, char *arg[])
+{
+	struct poeg_event event_data;
+	unsigned int val;
+	int ret, fd, i;
+
+	fd = open("/dev/poeg3", O_RDWR);
+	if (fd < 0)
+		perror("open");
+	else
+		printf("[POEG]open\n");
+
+	for (;;) {
+		ret = read(fd, &event_data, sizeof(event_data));
+		if (ret == -1) {
+			perror("Failed to read event data");
+			return 1;
+		}
+
+		val = event_data.gpt_disable_irq_status;
+		if (val) {
+			/* emulate fault clearing condition by adding delay */
+			sleep(2);
+			for (i = 0; i < 8; i++) {
+				if (val & 7) {
+					printf("gpt ch:%u, irq=%x\n", i, val & 7);
+					ret = write(fd, &event_data, sizeof(event_data));
+				}
+				val >>= 3;
+			}
+		}
+	}
+
+	if (close(fd) != 0)
+		perror("close");
+	else
+		printf("[POEG]close\n");
+
+	return 0;
+}
-- 
2.25.1

