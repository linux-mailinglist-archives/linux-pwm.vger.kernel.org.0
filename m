Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE0D6CBC10
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Mar 2023 12:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjC1KL0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Mar 2023 06:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbjC1KLU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Mar 2023 06:11:20 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C6EE7D9A;
        Tue, 28 Mar 2023 03:10:59 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,297,1673881200"; 
   d="scan'208";a="154049039"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Mar 2023 19:10:53 +0900
Received: from localhost.localdomain (unknown [10.226.92.2])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id DB69640071F7;
        Tue, 28 Mar 2023 19:10:50 +0900 (JST)
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
Subject: [DO NOT APPLY PATCH v7 10/10] tools/poeg: Add test app for poeg
Date:   Tue, 28 Mar 2023 11:10:11 +0100
Message-Id: <20230328101011.185594-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328101011.185594-1-biju.das.jz@bp.renesas.com>
References: <20230328101011.185594-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add test app for poeg

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 tools/poeg/Build      |   1 +
 tools/poeg/Makefile   |  53 ++++++++++++++++++++++
 tools/poeg/poeg_app.c | 102 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 156 insertions(+)
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
index 000000000000..669c914d9c98
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
+$(OUTPUT)include/linux/poeg.h: ../../include/linux/pinctrl/rzg2l-poeg.h
+	mkdir -p $(OUTPUT)include/linux 2>&1 || true
+	ln -sf $(CURDIR)/../../include/linux/pinctrl/rzg2l-poeg.h $@
+
+prepare: $(OUTPUT)include/linux/poeg.h
+
+POEG_EXAMPLE := $(OUTPUT)poeg_app.o
+$(POEG_EXAMPLE): prepare FORCE
+	$(Q)$(MAKE) $(build)=poeg_app
+$(OUTPUT)poeg_app: $(POEG_EXAMPLE)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
+
+clean:
+	rm -f $(ALL_PROGRAMS)
+	rm -rf $(OUTPUT)include/linux/poeg.h
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
index 000000000000..273ae1813e2f
--- /dev/null
+++ b/tools/poeg/poeg_app.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * POEG - example userspace application
+ * Copyright (C) 2023 Biju Das
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
+#define USER_CTRL	1
+#define GPT_CTRL	0
+#define EXT_PIN_CTRL	0
+
+int main(int argc, char *arg[])
+{
+	struct poeg_cmd cmd;
+	int ret, fd;
+#if GPT_CTRL
+	struct poeg_event event_data;
+	unsigned int val;
+	int i;
+#endif
+
+	fd = open("/dev/poeg3", O_RDWR);
+	if (fd < 0)
+		perror("open");
+	else
+		printf("[POEG]open\n");
+
+#if USER_CTRL
+	cmd.val = RZG2L_POEG_USR_CTRL_ENABLE_CMD;
+	cmd.channel = 4;
+	printf("[POEG] user control pin output disable enabled\n");
+	ret = write(fd, &cmd, sizeof(cmd));
+	if (ret == -1) {
+		perror("Failed to write cmd data");
+		return 1;
+	}
+	sleep(3);
+
+	printf("[POEG] user control pin output disable disabled\n");
+	cmd.val = RZG2L_POEG_USR_CTRL_DISABLE_CMD;
+	cmd.channel = 4;
+	ret = write(fd, &cmd, sizeof(cmd));
+	if (ret == -1) {
+		perror("Failed to write cmd data");
+		return 1;
+	}
+#endif
+
+#if GPT_CTRL
+	printf("[POEG] GPT control configure IRQ\n");
+	cmd.val = RZG2L_POEG_GPT_CFG_IRQ_CMD;
+	cmd.channel = 4;
+	ret = write(fd, &cmd, sizeof(cmd));
+	if (ret == -1) {
+		perror("Failed to write cmd data");
+		return 1;
+	}
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
+					cmd.val = RZG2L_POEG_GPT_FAULT_CLR_CMD;
+					cmd.channel = 4;
+					ret = write(fd, &cmd, sizeof(cmd));
+				}
+				val >>= 3;
+			}
+		}
+	}
+#endif
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

