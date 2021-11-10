Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE98144BD4C
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Nov 2021 09:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhKJIw7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 10 Nov 2021 03:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhKJIw5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Nov 2021 03:52:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BBBC061764
        for <linux-pwm@vger.kernel.org>; Wed, 10 Nov 2021 00:50:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkjJ2-0000J5-8O; Wed, 10 Nov 2021 09:50:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkjJ0-00034n-B5; Wed, 10 Nov 2021 09:50:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkjJ0-00079r-AE; Wed, 10 Nov 2021 09:50:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/3] pwm: lpc18xx-sct: Reduce number of devm memory allocations
Date:   Wed, 10 Nov 2021 09:49:49 +0100
Message-Id: <20211110084950.1053426-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211110084950.1053426-1-u.kleine-koenig@pengutronix.de>
References: <20211110084950.1053426-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=0TGTk8CUGRd3kbE2jV+Zauw4vlN6v2XR5EqzOPYegHc=; m=u6IEXr+k9UuYYhf5UGy5RYt6Cqe+w1vZWcxWD++O4rA=; p=gUR+lkSZPddCM+1983UynUusw6O3wSTS5Zf5Fgj8lFk=; g=e4cd3df5d3d5f2e22ad8a84954f3476b517e14d6
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGLh6YACgkQwfwUeK3K7AnTPwf/QU5 imv+n+f5zO6mw0h3ibe1Q+7GFnusuaTkUVUdoRh15CxX2yM9yF9MqBNHs14Vi2g1KTi9dUUg9++Oi reMcXdYcO/2wd3bDNjhwW9RtKqxl/94zeO4SdH+es7QbSzaK8G9Ju8Vxp3Z+xOJvSVsEcaCpPxqW3 hB/HgFkCynrYzSy1B+kyRZXVgLkCt6YijxDsw+fQfpXyVXpD6YDaIwXPNVuSXTTxs55N32d7QccRu K6RU82jNhf4dNYDtHqMxR321GbgecbxZi+1jhVEprxjardwE+nWf577Bwxr6APm8drmO0gPfFNU5a /sHV2u9DNWeNOILP/Piq0w+cqn0WhMw==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Each devm allocations has an overhead of 24 bytes to store the related
struct devres_node additionally to the fragmentation of the allocator.
So allocating 16 struct lpc18xx_pwm_data (which only hold a single int)
adds quite some overhead. Instead put the per-channel data into the
driver data struct and allocate it in one go.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 8cc8ae16553c..6cf02554066c 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -76,6 +76,8 @@
 #define LPC18XX_PWM_EVENT_PERIOD	0
 #define LPC18XX_PWM_EVENT_MAX		16
 
+#define LPC18XX_NUM_PWMS		16
+
 /* SCT conflict resolution */
 enum lpc18xx_pwm_res_action {
 	LPC18XX_PWM_RES_NONE,
@@ -101,6 +103,7 @@ struct lpc18xx_pwm_chip {
 	unsigned long event_map;
 	struct mutex res_lock;
 	struct mutex period_lock;
+	struct lpc18xx_pwm_data channeldata[LPC18XX_NUM_PWMS];
 };
 
 static inline struct lpc18xx_pwm_chip *
@@ -370,7 +373,7 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 
 	lpc18xx_pwm->chip.dev = &pdev->dev;
 	lpc18xx_pwm->chip.ops = &lpc18xx_pwm_ops;
-	lpc18xx_pwm->chip.npwm = 16;
+	lpc18xx_pwm->chip.npwm = LPC18XX_NUM_PWMS;
 
 	/* SCT counter must be in unify (32 bit) mode */
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CONFIG,
@@ -400,12 +403,7 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 
 		pwm = &lpc18xx_pwm->chip.pwms[i];
 
-		data = devm_kzalloc(lpc18xx_pwm->dev, sizeof(*data),
-				    GFP_KERNEL);
-		if (!data) {
-			ret = -ENOMEM;
-			goto disable_pwmclk;
-		}
+		data = &lpc18xx_pwm->channeldata[i];
 
 		pwm_set_chip_data(pwm, data);
 	}
-- 
2.30.2

