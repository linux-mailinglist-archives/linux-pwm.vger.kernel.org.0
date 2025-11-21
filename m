Return-Path: <linux-pwm+bounces-7654-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA3CC7ABFD
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 17:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 663B136691B
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 16:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA5434FF64;
	Fri, 21 Nov 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJp0x6Oc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E738831328B
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741336; cv=none; b=GHWJ4kgf87BSbwvxHjpALjIRHPdMNZdPwGXmfpWqN+E9y/+3ph5L6ZJAvtdo8yLuw71PO/XD/WVQ6M8D8cCQgMcfHtVzU40Gv2g2I7LIp5yzhxXl4cxEbpcNwwr7wRZdp1Qo0ipVPnkCcs5KMlBX+Fo5rvbAItAiU8P0rxBKP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741336; c=relaxed/simple;
	bh=+t6QRXttRpX5nce6uZuXOYAkO7xTEcrDg1qTPVsuBuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RI8u1Z4O4/7x5uIaUEpQoLPfllSjxZiTQ4WcvwCuesdv3s1nDRTJucr9DqIm/764rtMXARZgn8sc/9FNUsTLB/qpTZ7fTt1xYrltMcrjCdHsSiqG/eO0QgKaQzZP5KtbE7KlwjCRZQkzKJhk7vOIvK2nygfEsrnrN+f6I9gtyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJp0x6Oc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so23647225e9.3
        for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 08:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763741331; x=1764346131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8o2eYAk4+T2MvJcophYUy9RZhVssXZ1GeiS/j2h3xk8=;
        b=IJp0x6Oc2nW+PGonCRDevst2Z7j9C/SyOawKu2FLVDmPzGB7Etga9VuaUHR/haegKf
         xk/6KPNA9aWEknSLoOPxgMiP6eYrV2FBjBfJ2baJYG0kC9sGmw289C9k24N1roL+t2kQ
         d/aKB3yoEo86TKptUUoWzCSv1z8t5hnu8cZWXd0mln+F/9GtDxd0ciIECxJuOgtIch2S
         KG+1LYIJneal4YxKikQJ7jiD7PHIl9bkrBEyUsZ0Yos+YuRYf1WBmfCji+FAH+sn8bC2
         g4k1rrH5DEBTT1TQ/pfznyigL5NqOR6qM3mF4cHB+puGggqoQC+hvCYIC+H4KFMkKvgQ
         3a8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741331; x=1764346131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8o2eYAk4+T2MvJcophYUy9RZhVssXZ1GeiS/j2h3xk8=;
        b=HZZE1gMQYKW3jb+tQfo1W1m7F1RLy/rx0ZJQeF1nXizNs15AaQBQZGLc3M6OOcUmML
         4R41gt3yO6+HrjpyVMutSqbzzcPcoQodnRT6J6cdlWKDv04ij45dXASizOsGCg63wMfR
         Enl/a5JRaxn5yx1XPVpLzN12oq7p2hz6rZJcA6iWam4ahEuWmdBk8KGZ4ilOUSNM2jMZ
         CWGRQZ3quXWUW6ffVL1T5mQJxbLNft9zUWqBuB1/g1TUj3WlVrqEsd5kCRUf9lKCoLd/
         3Xvn3RpXFPFHKWSHUY5uEwXa7psgOTkV1qPGy/2Q3rqER4aUCeSigsFGDz2v5d596Lbv
         yyTw==
X-Forwarded-Encrypted: i=1; AJvYcCVqAyRFKRJFnqcClrwoF19pVHglN1bitbRgvpf9Ur2RoTiDTFquJmQ5HfvVHj6UvNPwyNBqmQI8mAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoI8LP5ZSTdeN/SGL+MSLlEC2nRGvHGVD6YyXNVLmjHHd8aR15
	5jAV8G2EFV2PeDB7+TeJcolmM2kN5o3KL4vl/iHw8QvaK1hgdy/nFM7B
X-Gm-Gg: ASbGncs2q11Y+rMv70IGCM1FebvuX9IzsQ/KJj1X6eJi9MswOvRBv5O5izKQeQ9pZ9f
	tYhZupvgJZQmL4jEYSDkspB7wGwloAS/8vZH/ZXk0gninX1+9FtVfCLpTJH1+nwQl1dLai31msU
	4iIc2seNSW9kq669RarfK2HLCv7Y37bhLoj9G+rJvDA4ZPCR6RygXLphaDPjCSOPFvg6NX29lYR
	AsApfFjZ9mJe1yLypm3/piv3B1iXy0l7FARR2enpVpxdh9tnirzjhFzIQWJzug2P1XhdBjhLWdF
	Moh0pxXiINeRF0WS/n3dVi6943Y+MF44jPmYYe/j+pP9bgC66QKPFZ/EHJd7u6yib5u+L8sgv1w
	ET6iHEqBAC5n2ZqS4/ePT7f2JXTI6gJVX+0jp6C1Yv/0BnHTuqOgGjbudSKqEhH0OKJBO17qct5
	do9K7UYlcdV/8TdnbaWectkP33NijDHSgepaNhb6uV7qeblY/k3eHkaFXMdWXIJoLgIaHIU6MHY
	6RqT8AS8Q==
X-Google-Smtp-Source: AGHT+IEJXgXSUSmmo2SsXVmfT6DnwKWByn13rXM7axdiuHfSioFwEpENFf28kMwD6HAfy6nncBRDDA==
X-Received: by 2002:a05:600c:3b01:b0:477:54cd:200a with SMTP id 5b1f17b1804b1-477c110325dmr23471945e9.6.1763741330953;
        Fri, 21 Nov 2025 08:08:50 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm89496195e9.8.2025.11.21.08.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:08:50 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: [DO NOT APPLY PATCH v8 08/15] tools/poeg: Add test app for poeg
Date: Fri, 21 Nov 2025 16:08:15 +0000
Message-ID: <20251121160842.371922-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
References: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add test app for poeg for controlling output disable through
user space.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 tools/poeg/Build      |  1 +
 tools/poeg/Makefile   | 53 +++++++++++++++++++++++++++++++++++++++
 tools/poeg/poeg_app.c | 58 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
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
index 000000000000..4ff8e5c007dc
--- /dev/null
+++ b/tools/poeg/poeg_app.c
@@ -0,0 +1,58 @@
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
+int main(int argc, char *argv[])
+{
+	struct poeg_cmd cmd;
+	unsigned int val;
+	long cmd_val;
+	char *p;
+	int i;
+
+	cmd_val = strtol(argv[1], &p, 10);
+	if (*p != '\0' || errno != 0)
+		return 1; // In main(), returning non-zero means failure
+
+	fd = open("/dev/poeg3", O_RDWR);
+	if (fd < 0)
+		perror("open");
+	else
+		printf("[POEG]open\n");
+
+	cmd.val = cmd_val;
+	cmd.channel = 4;
+	if (cmd.val == RZG2L_POEG_OUTPUT_DISABLE_USR_ENABLE_CMD)
+		printf("[POEG] user control pin output disable enabled\n");
+	else
+		printf("[POEG] user control pin output disable disabled\n");
+
+	ret = write(fd, &cmd, sizeof(cmd));
+	if (ret == -1) {
+		perror("Failed to write cmd data");
+		return 1;
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
2.43.0


