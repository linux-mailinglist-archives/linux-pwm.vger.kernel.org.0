Return-Path: <linux-pwm+bounces-21-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DCE7F2F5F
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F89C281D9D
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10216524CD;
	Tue, 21 Nov 2023 13:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F890D67
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:51 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAL-0005CH-Qv; Tue, 21 Nov 2023 14:51:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAK-00Aaxc-Vc; Tue, 21 Nov 2023 14:51:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAK-004xbz-Mg; Tue, 21 Nov 2023 14:51:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 020/108] pwm: omap: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:22 +0100
Message-ID: <20231121134901.208535-21-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3441; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=s6oCTfmYQc/DWAC27sB+Arl/RK9nuBeqnJaPhwxauRU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVjV52nxJvM2qYEoH3hdL/HIqSgj5b5Ct50a a01jDpQ+jmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1YwAKCRCPgPtYfRL+ TimICACc13dYVzcLyBzdh7g4ITSS1yBeKw2dCOyoIcHy5ODrEkFrxTNBmjZO9hNE00B4z3kNXoj UF2D4mMcd/yk4Walkv1NtP2Qy5u3g9rzuE3GRNw8c6PC2AT0Q5yomMWYBofzWiUPCI5oYNmu1T3 ceiI/RJaOEJZBs4iJGN+mV5ALNZW8mfU/CEN6siXx1zaW8wprYpZuVFIY2MdjIoFnzmNrwtxlBJ LYytZpAB5Rem7K/sraUHhTZ0T6aBKqVSok0TXHC6OxDH98wjgdbjMZtN4Zt+2JnOhB76sWdTSji dc+8ibsDfw6hhVAW67ej9+n6mHOPSH8SUpjJIp8HESGcKzz3
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

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


