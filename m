Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C8E290814
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 17:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409896AbgJPPPw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Oct 2020 11:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409856AbgJPPPw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Oct 2020 11:15:52 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D3820897;
        Fri, 16 Oct 2020 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602861351;
        bh=4OJOxhlwL10+hIzc3OR9WXy5yLt7RM+8bC7enpcS2dg=;
        h=From:To:Cc:Subject:Date:From;
        b=SWX5cJfU8mdmrvgiur8vBB1juDQuMAN326gUaFyUMgbDet9z1wUCApkZyS8gzFQ49
         D88379d/cjY2Tv7JOem0ufX+1krTMYPPkulPd18C/O2TNgcO1pubsDdNg93YPT5Xyg
         HgOR+gJjib+xTQb5Ij7Z+mRnwICq5KRoGN9iGQ1c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     Kamil Debski <kamil@wypas.org>
Subject: [PATCH 1/4] MAINTAINERS: move Kamil Debski to credits
Date:   Fri, 16 Oct 2020 17:15:25 +0200
Message-Id: <20201016151528.7553-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Kamil Debski has not been active on LKML since 2017:
https://lore.kernel.org/lkml/?q=f%3A%22Kamil+Debski%22

Move Kamil Debski to the CREDITS file.  Thank you for the effort you put
in to the upstream Linux kernel work.

Cc: Kamil Debski <kamil@wypas.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 CREDITS     | 6 ++++++
 MAINTAINERS | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/CREDITS b/CREDITS
index 8592e45e3932..8dfd6a2fb3e8 100644
--- a/CREDITS
+++ b/CREDITS
@@ -849,6 +849,12 @@ D: trivial hack to add variable address length routing to Rose.
 D: AX25-HOWTO, HAM-HOWTO, IPX-HOWTO, NET-2-HOWTO
 D: ax25-utils maintainer.
 
+N: Kamil Debski
+E: kamil@wypas.org
+D: Samsung S5P 2D graphics acceleration and Multi Format Codec drivers
+D: Samsung USB2 phy drivers
+D: PWM fan driver
+
 N: Helge Deller
 E: deller@gmx.de
 W: http://www.parisc-linux.org/
diff --git a/MAINTAINERS b/MAINTAINERS
index aa46cb3ce6e6..bb40bac8cf27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2411,7 +2411,6 @@ F:	arch/arm/mach-s5pv210/
 
 ARM/SAMSUNG S5P SERIES 2D GRAPHICS ACCELERATION (G2D) SUPPORT
 M:	Kyungmin Park <kyungmin.park@samsung.com>
-M:	Kamil Debski <kamil@wypas.org>
 M:	Andrzej Hajda <a.hajda@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org
 L:	linux-media@vger.kernel.org
@@ -2437,7 +2436,6 @@ F:	drivers/media/platform/s5p-jpeg/
 
 ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT
 M:	Kyungmin Park <kyungmin.park@samsung.com>
-M:	Kamil Debski <kamil@wypas.org>
 M:	Jeongtae Park <jtp.park@samsung.com>
 M:	Andrzej Hajda <a.hajda@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org
@@ -14237,7 +14235,6 @@ F:	drivers/media/usb/pwc/*
 F:	include/trace/events/pwc.h
 
 PWM FAN DRIVER
-M:	Kamil Debski <kamil@wypas.org>
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-hwmon@vger.kernel.org
 S:	Supported
@@ -15519,7 +15516,6 @@ T:	git https://github.com/lmajewski/linux-samsung-thermal.git
 F:	drivers/thermal/samsung/
 
 SAMSUNG USB2 PHY DRIVER
-M:	Kamil Debski <kamil@wypas.org>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-- 
2.25.1

