Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79B17C72B7
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379594AbjJLQbI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379596AbjJLQa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:58 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF37E6
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaN-0004q2-Fi; Thu, 12 Oct 2023 18:30:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaM-001C6a-Re; Thu, 12 Oct 2023 18:30:54 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaM-00F5NR-IS; Thu, 12 Oct 2023 18:30:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 021/109] pwm: omap: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:49 +0200
Message-ID: <20231012162827.1002444-132-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3441; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=s6oCTfmYQc/DWAC27sB+Arl/RK9nuBeqnJaPhwxauRU=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQNuSPhc5cfmX3m1jKWBbUPS/YfV1qyoH/aT657JZlrT XusAn5ZdjIaszAwcjHIiimy2DeuybSqkovsXPvvMswgViaQKQxcnAIwEaYg9n9W571nZzHuaxFX NvFzEHxgUXtp+zzbyNnynhoblryxE0/OD3XPU/3Jq6HFlbR5TojJ7Z3Jr/OVfA8t6ze+b8nCvnK Rj/E9oV2Lmq4I3188nZH7cq2Iec56tb35K7VcLlx8FPemqHp97JXedcpn5V3FjVO/1T97PeOiW/ 1lfwH5X3/4Kht+iur2Mp9lmJzf8XCl/vSbu5Yl1Bop/1dYW/O00NuufsL8+6lCioxpzVOELlow2 TU4hE4XS/uw/nDNrMXGV96KmqkHmqRaKxtNY/6k2WXwYUcqu+Lrz1I/XqaXH858wnCtOWOu+ZWt +93kEiuXt9o3MJ1mq4kNKX9QxWFZJrbQ+XdFVdapyDWrAQ==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-omap-dmtimer.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 13161e08dd6e..c7c7383f4b14 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -158,7 +158,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	unsigned long clk_rate;
 	struct clk *fclk;
 
-	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
+	dev_dbg(pwmchip_parent(chip), "requested duty cycle: %d ns, period: %d ns\n",
 		duty_ns, period_ns);
 
 	if (duty_ns == pwm_get_duty_cycle(pwm) &&
@@ -167,17 +167,17 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 
 	fclk = omap->pdata->get_fclk(omap->dm_timer);
 	if (!fclk) {
-		dev_err(chip->dev, "invalid pmtimer fclk\n");
+		dev_err(pwmchip_parent(chip), "invalid pmtimer fclk\n");
 		return -EINVAL;
 	}
 
 	clk_rate = clk_get_rate(fclk);
 	if (!clk_rate) {
-		dev_err(chip->dev, "invalid pmtimer fclk rate\n");
+		dev_err(pwmchip_parent(chip), "invalid pmtimer fclk rate\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(chip->dev, "clk rate: %luHz\n", clk_rate);
+	dev_dbg(pwmchip_parent(chip), "clk rate: %luHz\n", clk_rate);
 
 	/*
 	 * Calculate the appropriate load and match values based on the
@@ -199,27 +199,27 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	duty_cycles = pwm_omap_dmtimer_get_clock_cycles(clk_rate, duty_ns);
 
 	if (period_cycles < 2) {
-		dev_info(chip->dev,
+		dev_info(pwmchip_parent(chip),
 			 "period %d ns too short for clock rate %lu Hz\n",
 			 period_ns, clk_rate);
 		return -EINVAL;
 	}
 
 	if (duty_cycles < 1) {
-		dev_dbg(chip->dev,
+		dev_dbg(pwmchip_parent(chip),
 			"duty cycle %d ns is too short for clock rate %lu Hz\n",
 			duty_ns, clk_rate);
-		dev_dbg(chip->dev, "using minimum of 1 clock cycle\n");
+		dev_dbg(pwmchip_parent(chip), "using minimum of 1 clock cycle\n");
 		duty_cycles = 1;
 	} else if (duty_cycles >= period_cycles) {
-		dev_dbg(chip->dev,
+		dev_dbg(pwmchip_parent(chip),
 			"duty cycle %d ns is too long for period %d ns at clock rate %lu Hz\n",
 			duty_ns, period_ns, clk_rate);
-		dev_dbg(chip->dev, "using maximum of 1 clock cycle less than period\n");
+		dev_dbg(pwmchip_parent(chip), "using maximum of 1 clock cycle less than period\n");
 		duty_cycles = period_cycles - 1;
 	}
 
-	dev_dbg(chip->dev, "effective duty cycle: %lld ns, period: %lld ns\n",
+	dev_dbg(pwmchip_parent(chip), "effective duty cycle: %lld ns, period: %lld ns\n",
 		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * duty_cycles,
 				      clk_rate),
 		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * period_cycles,
@@ -231,7 +231,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	omap->pdata->set_load(omap->dm_timer, load_value);
 	omap->pdata->set_match(omap->dm_timer, true, match_value);
 
-	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
+	dev_dbg(pwmchip_parent(chip), "load value: %#08x (%d), match value: %#08x (%d)\n",
 		load_value, load_value,	match_value, match_value);
 
 	return 0;
-- 
2.42.0

