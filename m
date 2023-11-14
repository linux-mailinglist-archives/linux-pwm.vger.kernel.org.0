Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F227EAEBE
	for <lists+linux-pwm@lfdr.de>; Tue, 14 Nov 2023 12:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjKNLUf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 14 Nov 2023 06:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjKNLUe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 14 Nov 2023 06:20:34 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA45A12C
        for <linux-pwm@vger.kernel.org>; Tue, 14 Nov 2023 03:20:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rT3-0002vA-7J; Tue, 14 Nov 2023 12:20:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rT2-008yr7-RI; Tue, 14 Nov 2023 12:20:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r2rT2-001JwN-IL; Tue, 14 Nov 2023 12:20:28 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/3] pwm: Mention PWM chip ID in /sys/kernel/debug/pwm
Date:   Tue, 14 Nov 2023 12:20:13 +0100
Message-ID: <20231114112009.340168-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231114112009.340168-1-u.kleine-koenig@pengutronix.de>
References: <20231114112009.340168-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=998; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=VV233mSvCW+7P7Af7t3H/4RxhLOGiPxz/Q3UObfhpvs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlU1fsZsft65HNi0L30a9+V8EwUYZAfKaWapnkf 4+LKVDEC52JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVNX7AAKCRCPgPtYfRL+ TqNKB/kB7WXSjnLRLL/fCT2pQRtK5UWZn0oYsGt3kP/zg+ohn15pfGtRivZ2D26e7flUzV0neJP uuT+aWEGOln8DV4VY1aL551XgQwcxV7oxWg/fDoQ0yVw+Pv85LJ+v5HikrSU08IjDof8Sel5aDy /GWoYD6B2MVMOb1iv9gwU2/sWFm2ZYr3hJaGQnpzrCtn6E56oXBuzRXUpOf5vKKOSjJ/xyZXvyB 2VjJwkitOb7OygcquAU8jEpnT/UeZXgr0zcjHkgZ1941JI4I3eIEFRH+lbhqpmp6dMSR2Na+5uJ 7pse+wNXctSewTpwbYsmme6m1zhZBmBskjUFH4t6BKMYH9gm
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

While it's not hard to match the entries from /sys/kernel/debug/pwm to
the corresponding pwmchip in /sys/class/pwm, it's a bit simpler to have
the number mentioned in /sys/kernel/debug/pwm.

Link: https://lore.kernel.org/r/20230808165250.942396-3-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 586277c3eee4..58a9d3df73a1 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1062,7 +1062,8 @@ static int pwm_seq_show(struct seq_file *s, void *v)
 {
 	struct pwm_chip *chip = v;
 
-	seq_printf(s, "%s%s/%s, %d PWM device%s\n", (char *)s->private,
+	seq_printf(s, "%s%d: %s/%s, %d PWM device%s\n",
+		   (char *)s->private, chip->id,
 		   chip->dev->bus ? chip->dev->bus->name : "no-bus",
 		   dev_name(chip->dev), chip->npwm,
 		   (chip->npwm != 1) ? "s" : "");
-- 
2.42.0

