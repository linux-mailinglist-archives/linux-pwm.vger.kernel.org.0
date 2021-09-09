Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B525F4046C2
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Sep 2021 10:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhIIIK3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Sep 2021 04:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhIIIK3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Sep 2021 04:10:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C81C061575
        for <linux-pwm@vger.kernel.org>; Thu,  9 Sep 2021 01:09:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOF7Q-0004cP-7f; Thu, 09 Sep 2021 10:09:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOF7P-0007LH-Ef; Thu, 09 Sep 2021 10:09:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOF7P-0005ON-DL; Thu, 09 Sep 2021 10:09:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: atmel: drop unused header
Date:   Thu,  9 Sep 2021 10:09:03 +0200
Message-Id: <20210909080903.307314-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=+XVe2ilehV2T6QdGn1WmCrHWsiDAN/lZ0phCvXg3+m8=; m=A3EMNhwMGbWAnsExoNTrBU4AfxwwczDr66BcjZqCXMU=; p=WOirw57Oc9kl+JK0jd7QDN1mtl97MPOr3wRRT8O5xls=; g=5cedd229440ef353b405fdb70cdef2a18e8de871
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmE5wRwACgkQwfwUeK3K7AmtTgf5ASu J2R8KnI6QMEBkd89EtqimASp3qiR5xR9MAO5mA8ZMW39Gv/YrwKB1FeWClX9M9+gLWiyR3sTHdKCi quPhmjSvqfic22r77kZyS4TytMXyI57sZGLDvzGbbseddvOOWL2bOfT9GDcYhyLOZuwmEoQwFEd0y 4+mXPsc0PnFsDb4EY09QHlIwtrqc8oG7X2GBEkbcacgkKkfLxBkxw7iNTt8dax/xo2U0sN5nGhn8G dkfxsLsrbJIiLyWLCPU1nrLA510hrED9IV5N5lOCjlxOW2PmQGK/ebU2CihJFmLQcb+3hSF21TIk+ VE+w0+gq+PSKlKbOvmZm/y9nHSaQVxQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since commit 52eaba4cedbd ("pwm: atmel: Rework tracking updates pending
in hardware") the driver doesn't make use of mutexes any more, so the
header defining these doesn't need to be included.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index e748604403cc..98b34ea9f38e 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -24,7 +24,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-- 
2.30.2

