Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F94290819
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 17:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409911AbgJPPP7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Oct 2020 11:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409856AbgJPPP7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Oct 2020 11:15:59 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1A1921582;
        Fri, 16 Oct 2020 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602861358;
        bh=5zHH5crpiuq5wOZ5X5I6m2TeQbmRjeWaqwN6AFACj2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ab/Mnu0p1h9/T3YgRGjqOQV0YU/g74BnldmTeFVNIjT70DCUKgOZS7/9MfAXaokNQ
         84tMy2V2Ykt7QyDWm7r8WvMclXqyHV6ca3TVulexFV2NJQAg4SYSoJcfXfnwbcQLBI
         kByM8J2aB7y50srlQGeDdaXov0FbTeJqNGwFCLhM=
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
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: [PATCH 2/4] MAINTAINERS: move Kyungmin Park to credits
Date:   Fri, 16 Oct 2020 17:15:26 +0200
Message-Id: <20201016151528.7553-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201016151528.7553-1-krzk@kernel.org>
References: <20201016151528.7553-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Kyungmin Park maintained and contributed to some of the upstreamed
S5Pv210 and Exynos4210 machines - as described in commit 10ffa96407b2
("MAINTAINERS: add maintainer of Samsung Mobile Machine support").
However the entry in maintainers got slightly twisted by
commit 004bbd3c01d4 ("MAINTAINERS: remove non existent files") -
the directory matching pattern was changed from specific machines to
the entire S5Pv210.

Anyway since long time, all S5Pv210 maintenance is covered by the
Samsung ARM architectures maintainer entry and Krzysztof Kozlowski, so
move Kyungmin Park to the CREDITS.

There was also no activity on LKML regarding other maintained drivers:
https://lore.kernel.org/lkml/?q=f%3A%22Kyungmin+Park%22

Dear Kyungmin Park, thank you for all the effort you put in to the
upstream Samsung support.

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 CREDITS     |  4 ++++
 MAINTAINERS | 13 +------------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/CREDITS b/CREDITS
index 8dfd6a2fb3e8..f5c924a09b74 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2858,6 +2858,10 @@ D: IPX development and support
 N: Venkatesh Pallipadi (Venki)
 D: x86/HPET
 
+N: Kyungmin Park
+E: kyungmin.park@samsung.com
+D: Samsung S5Pv210 and Exynos4210 mobile platforms
+
 N: David Parsons
 E: orc@pell.chi.il.us
 D: improved memory detection code.
diff --git a/MAINTAINERS b/MAINTAINERS
index bb40bac8cf27..37329c6258f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2374,7 +2374,7 @@ F:	drivers/i2c/busses/i2c-rk3x.c
 F:	sound/soc/rockchip/
 N:	rockchip
 
-ARM/SAMSUNG EXYNOS ARM ARCHITECTURES
+ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org
@@ -2403,14 +2403,7 @@ N:	s3c2410
 N:	s3c64xx
 N:	s5pv210
 
-ARM/SAMSUNG MOBILE MACHINE SUPPORT
-M:	Kyungmin Park <kyungmin.park@samsung.com>
-L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-s5pv210/
-
 ARM/SAMSUNG S5P SERIES 2D GRAPHICS ACCELERATION (G2D) SUPPORT
-M:	Kyungmin Park <kyungmin.park@samsung.com>
 M:	Andrzej Hajda <a.hajda@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org
 L:	linux-media@vger.kernel.org
@@ -2435,7 +2428,6 @@ S:	Maintained
 F:	drivers/media/platform/s5p-jpeg/
 
 ARM/SAMSUNG S5P SERIES Multi Format Codec (MFC) SUPPORT
-M:	Kyungmin Park <kyungmin.park@samsung.com>
 M:	Jeongtae Park <jtp.park@samsung.com>
 M:	Andrzej Hajda <a.hajda@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org
@@ -15443,14 +15435,12 @@ F:	Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
 F:	drivers/nfc/s3fwrn5
 
 SAMSUNG S5C73M3 CAMERA DRIVER
-M:	Kyungmin Park <kyungmin.park@samsung.com>
 M:	Andrzej Hajda <a.hajda@samsung.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
 F:	drivers/media/i2c/s5c73m3/*
 
 SAMSUNG S5K5BAF CAMERA DRIVER
-M:	Kyungmin Park <kyungmin.park@samsung.com>
 M:	Andrzej Hajda <a.hajda@samsung.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
@@ -15468,7 +15458,6 @@ F:	Documentation/devicetree/bindings/crypto/samsung-sss.yaml
 F:	drivers/crypto/s5p-sss.c
 
 SAMSUNG S5P/EXYNOS4 SOC SERIES CAMERA SUBSYSTEM DRIVERS
-M:	Kyungmin Park <kyungmin.park@samsung.com>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	linux-media@vger.kernel.org
 S:	Supported
-- 
2.25.1

