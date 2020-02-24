Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 464FA169D7E
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2020 06:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgBXFWt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Feb 2020 00:22:49 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56678 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgBXFWs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Feb 2020 00:22:48 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01O5MfFx100141;
        Sun, 23 Feb 2020 23:22:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582521761;
        bh=c+TSU2VKsV1GOCyljmgSnVXQNNv9UK9i28iQ3u+0Znc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yO34SfAWzCPD8K/7Q5cYYtlRw5oXZYh1lplIHDBtgi2s61y3s4+USbIC6CZpWjBVX
         Tdn3idTRHpu6BqonP7DVh8NvYUydYvL0HNRZyEFqvc7HFE0bzprfY2miTa6Xx9wj+S
         NcdQ1UeCF2KTpH/8GMjD+UgVajCsPu46p3oToBEM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01O5Mfve089247
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Feb 2020 23:22:41 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 23
 Feb 2020 23:22:41 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 23 Feb 2020 23:22:41 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01O5MPN8012421;
        Sun, 23 Feb 2020 23:22:38 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 4/4] pwm: omap-dmtimer: Implement .apply callback
Date:   Mon, 24 Feb 2020 10:51:35 +0530
Message-ID: <20200224052135.17278-5-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200224052135.17278-1-lokeshvutla@ti.com>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Implement .apply callback and drop the legacy callbacks(enable, disable,
config, set_polarity).

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 141 +++++++++++++++++++--------------
 1 file changed, 80 insertions(+), 61 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 58c61559e72f..aeda4ab12385 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -31,8 +31,18 @@
 #define DM_TIMER_LOAD_MIN 0xfffffffe
 #define DM_TIMER_MAX      0xffffffff
 
+/**
+ * struct pwm_omap_dmtimer_chip - Structure representing a pwm chip
+ *				  corresponding to omap dmtimer.
+ * @chip:		PWM chip structure representing PWM controller
+ * @mutex:		Mutex to protect pwm apply state
+ * @dm_timer:		Pointer to omap dm timer.
+ * @pdata:		Pointer to omap dm timer ops.
+ * dm_timer_pdev:	Pointer to omap dm timer platform device
+ */
 struct pwm_omap_dmtimer_chip {
 	struct pwm_chip chip;
+	/* Mutex to protect pwm apply state */
 	struct mutex mutex;
 	struct omap_dm_timer *dm_timer;
 	const struct omap_dm_timer_ops *pdata;
@@ -45,11 +55,22 @@ to_pwm_omap_dmtimer_chip(struct pwm_chip *chip)
 	return container_of(chip, struct pwm_omap_dmtimer_chip, chip);
 }
 
+/**
+ * pwm_omap_dmtimer_get_clock_cycles() - Get clock cycles in a time frame
+ * @clk_rate:	pwm timer clock rate
+ * @ns:		time frame in nano seconds.
+ *
+ * Return number of clock cycles in a given period(ins ns).
+ */
 static u32 pwm_omap_dmtimer_get_clock_cycles(unsigned long clk_rate, int ns)
 {
 	return DIV_ROUND_CLOSEST_ULL((u64)clk_rate * ns, NSEC_PER_SEC);
 }
 
+/**
+ * pwm_omap_dmtimer_start() - Start the pwm omap dm timer in pwm mode
+ * @omap:	Pointer to pwm omap dm timer chip
+ */
 static void pwm_omap_dmtimer_start(struct pwm_omap_dmtimer_chip *omap)
 {
 	/*
@@ -67,32 +88,16 @@ static void pwm_omap_dmtimer_start(struct pwm_omap_dmtimer_chip *omap)
 	omap->pdata->start(omap->dm_timer);
 }
 
-static int pwm_omap_dmtimer_enable(struct pwm_chip *chip,
-				   struct pwm_device *pwm)
-{
-	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
-
-	mutex_lock(&omap->mutex);
-	omap->pdata->set_pwm(omap->dm_timer,
-			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
-			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
-
-	pwm_omap_dmtimer_start(omap);
-	mutex_unlock(&omap->mutex);
-
-	return 0;
-}
-
-static void pwm_omap_dmtimer_disable(struct pwm_chip *chip,
-				     struct pwm_device *pwm)
-{
-	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
-
-	mutex_lock(&omap->mutex);
-	omap->pdata->stop(omap->dm_timer);
-	mutex_unlock(&omap->mutex);
-}
-
+/**
+ * pwm_omap_dmtimer_config() - Update the configuration of pwm omap dm timer
+ * @chip:	Pointer to PWM controller
+ * @pwm:	Pointer to PWM channel
+ * @duty_ns:	New duty cycle in nano seconds
+ * @period_ns:	New period in nano seconds
+ *
+ * Return 0 if successfully changed the period/duty_cycle else appropriate
+ * error.
+ */
 static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 				   struct pwm_device *pwm,
 				   int duty_ns, int period_ns)
@@ -100,30 +105,26 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
 	u32 period_cycles, duty_cycles;
 	u32 load_value, match_value;
-	struct clk *fclk;
 	unsigned long clk_rate;
+	struct clk *fclk;
 
 	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
 		duty_ns, period_ns);
 
-	mutex_lock(&omap->mutex);
 	if (duty_ns == pwm_get_duty_cycle(pwm) &&
-	    period_ns == pwm_get_period(pwm)) {
-		/* No change - don't cause any transients. */
-		mutex_unlock(&omap->mutex);
+	    period_ns == pwm_get_period(pwm))
 		return 0;
-	}
 
 	fclk = omap->pdata->get_fclk(omap->dm_timer);
 	if (!fclk) {
 		dev_err(chip->dev, "invalid pmtimer fclk\n");
-		goto err_einval;
+		return -EINVAL;
 	}
 
 	clk_rate = clk_get_rate(fclk);
 	if (!clk_rate) {
 		dev_err(chip->dev, "invalid pmtimer fclk rate\n");
-		goto err_einval;
+		return -EINVAL;
 	}
 
 	dev_dbg(chip->dev, "clk rate: %luHz\n", clk_rate);
@@ -151,7 +152,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 		dev_info(chip->dev,
 			 "period %d ns too short for clock rate %lu Hz\n",
 			 period_ns, clk_rate);
-		goto err_einval;
+		return -EINVAL;
 	}
 
 	if (duty_cycles < 1) {
@@ -183,54 +184,72 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
 		load_value, load_value,	match_value, match_value);
 
-	mutex_unlock(&omap->mutex);
-
 	return 0;
-
-err_einval:
-	mutex_unlock(&omap->mutex);
-
-	return -EINVAL;
 }
 
-static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
-					 struct pwm_device *pwm,
-					 enum pwm_polarity polarity)
+/**
+ * pwm_omap_dmtimer_apply() - Changes the state of the pwm omap dm timer.
+ * @chip:	Pointer to PWM controller
+ * @pwm:	Pointer to PWM channel
+ * @state:	New sate to apply
+ *
+ * Return 0 if successfully changed the state else appropriate error.
+ */
+static int pwm_omap_dmtimer_apply(struct pwm_chip *chip,
+				  struct pwm_device *pwm,
+				  const struct pwm_state *state)
 {
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
+	int ret = 0;
 
-	/*
-	 * PWM core will not call set_polarity while PWM is enabled so it's
-	 * safe to reconfigure the timer here without stopping it first.
-	 */
 	mutex_lock(&omap->mutex);
-	omap->pdata->set_pwm(omap->dm_timer,
-			     polarity == PWM_POLARITY_INVERSED,
-			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+
+	if (pwm_is_enabled(pwm) && !state->enabled) {
+		omap->pdata->stop(omap->dm_timer);
+		goto unlock_mutex;
+	}
+
+	if (pwm_get_polarity(pwm) != state->polarity)
+		omap->pdata->set_pwm(omap->dm_timer,
+				     state->polarity == PWM_POLARITY_INVERSED,
+				     true,
+				     OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+
+	ret = pwm_omap_dmtimer_config(chip, pwm, state->duty_cycle,
+				      state->period);
+	if (ret)
+		goto unlock_mutex;
+
+	if (!pwm_is_enabled(pwm) && state->enabled) {
+		omap->pdata->set_pwm(omap->dm_timer,
+				     state->polarity == PWM_POLARITY_INVERSED,
+				     true,
+				     OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+		pwm_omap_dmtimer_start(omap);
+	}
+
+unlock_mutex:
 	mutex_unlock(&omap->mutex);
 
-	return 0;
+	return ret;
 }
 
 static const struct pwm_ops pwm_omap_dmtimer_ops = {
-	.enable	= pwm_omap_dmtimer_enable,
-	.disable = pwm_omap_dmtimer_disable,
-	.config	= pwm_omap_dmtimer_config,
-	.set_polarity = pwm_omap_dmtimer_set_polarity,
+	.apply = pwm_omap_dmtimer_apply,
 	.owner = THIS_MODULE,
 };
 
 static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct device_node *timer;
-	struct platform_device *timer_pdev;
-	struct pwm_omap_dmtimer_chip *omap;
 	struct dmtimer_platform_data *timer_pdata;
 	const struct omap_dm_timer_ops *pdata;
+	struct platform_device *timer_pdev;
+	struct pwm_omap_dmtimer_chip *omap;
 	struct omap_dm_timer *dm_timer;
-	u32 v;
+	struct device_node *timer;
 	int ret = 0;
+	u32 v;
 
 	timer = of_parse_phandle(np, "ti,timers", 0);
 	if (!timer)
-- 
2.23.0

