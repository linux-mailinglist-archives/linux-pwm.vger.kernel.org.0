Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B401827BC
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 05:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387784AbgCLEXY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 00:23:24 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47594 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387756AbgCLEXW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 00:23:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02C4NGoK051601;
        Wed, 11 Mar 2020 23:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583986996;
        bh=pG4+G30Ueb63gIh4BE/jhpR2Dtnkqg0Kn3QyKIIkjhk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=x03tp4b0vNLjPPfgiSEirGJBFoFrWDJ40OjUjcqVklAP+KoGal88/aZ81nNqiTY3p
         dMYF80YATtpA3GthDA4MZgpWAzy+2ytF4a3NgSzVOQRBVKFGDv/Ww03Siq/oFOEvlZ
         UASqAkAaaLiwOQk/9K9Tmrj6xNGgpARnBg1j8VmY=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02C4NGcA080160
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Mar 2020 23:23:16 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Mar 2020 23:23:17 -0500
Received: from localhost.localdomain (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Mar 2020 23:23:16 -0500
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02C4Mvgl065984;
        Wed, 11 Mar 2020 23:23:13 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 5/5] pwm: omap-dmtimer: Implement .apply callback
Date:   Thu, 12 Mar 2020 09:52:10 +0530
Message-ID: <20200312042210.17344-6-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200312042210.17344-1-lokeshvutla@ti.com>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Implement .apply callback and drop the legacy callbacks(enable, disable,
config, set_polarity). In .apply() check for the current hardware status
before changing the pwm configuration.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 180 +++++++++++++++++++++++----------
 1 file changed, 129 insertions(+), 51 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index c56e7256e923..0d31833db2e2 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -26,6 +26,11 @@
  *   can get updated as below based on the current timer counter:
  *   	- period for current cycle =  current_period + new period
  *   	- duty_cycle for current period = current period + new duty_cycle.
+ * - PWM OMAP DM timer cannot change the polarity when pwm is active. When
+ *   user requests a change in polarity when in active state:
+ *	- PWM is stopped abruptly(without completing the current cycle)
+ *	- Polarity is changed
+ *	- A fresh cycle is started.
  */
 
 #include <linux/clk.h>
@@ -46,8 +51,18 @@
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
@@ -60,11 +75,22 @@ to_pwm_omap_dmtimer_chip(struct pwm_chip *chip)
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
@@ -82,33 +108,46 @@ static void pwm_omap_dmtimer_start(struct pwm_omap_dmtimer_chip *omap)
 	omap->pdata->start(omap->dm_timer);
 }
 
-static int pwm_omap_dmtimer_enable(struct pwm_chip *chip,
-				   struct pwm_device *pwm)
+/**
+ * pwm_omap_dmtimer_is_enabled() -  Detect if the pwm is enabled.
+ * @omap:	Pointer to pwm omap dm timer chip
+ *
+ * Return true if pwm is enabled else false.
+ */
+static bool pwm_omap_dmtimer_is_enabled(struct pwm_omap_dmtimer_chip *omap)
 {
-	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
+	u32 status;
 
-	mutex_lock(&omap->mutex);
-	omap->pdata->set_pwm(omap->dm_timer,
-			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
-			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
-			     true);
-
-	pwm_omap_dmtimer_start(omap);
-	mutex_unlock(&omap->mutex);
+	status = omap->pdata->get_pwm_status(omap->dm_timer);
 
-	return 0;
+	return !!(status & OMAP_TIMER_CTRL_ST);
 }
 
-static void pwm_omap_dmtimer_disable(struct pwm_chip *chip,
-				     struct pwm_device *pwm)
+/**
+ * pwm_omap_dmtimer_polarity() -  Detect the polarity of pwm.
+ * @omap:	Pointer to pwm omap dm timer chip
+ *
+ * Return the polarity of pwm.
+ */
+static int pwm_omap_dmtimer_polarity(struct pwm_omap_dmtimer_chip *omap)
 {
-	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
+	u32 status;
 
-	mutex_lock(&omap->mutex);
-	omap->pdata->stop(omap->dm_timer);
-	mutex_unlock(&omap->mutex);
+	status = omap->pdata->get_pwm_status(omap->dm_timer);
+
+	return !!(status & OMAP_TIMER_CTRL_SCPWM);
 }
 
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
@@ -116,30 +155,26 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
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
@@ -167,7 +202,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 		dev_info(chip->dev,
 			 "period %d ns too short for clock rate %lu Hz\n",
 			 period_ns, clk_rate);
-		goto err_einval;
+		return -EINVAL;
 	}
 
 	if (duty_cycles < 1) {
@@ -199,55 +234,97 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
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
+ * pwm_omap_dmtimer_set_polarity() - Changes the polarity of the pwm dm timer.
+ * @chip:	Pointer to PWM controller
+ * @pwm:	Pointer to PWM channel
+ * @polarity:	New pwm polarity to be set
+ */
+static void pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
+					  struct pwm_device *pwm,
+					  enum pwm_polarity polarity)
 {
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
+	bool enabled;
+
+	/* Disable the PWM before changing the polarity. */
+	enabled = pwm_omap_dmtimer_is_enabled(omap);
+	if (enabled)
+		omap->pdata->stop(omap->dm_timer);
 
-	/*
-	 * PWM core will not call set_polarity while PWM is enabled so it's
-	 * safe to reconfigure the timer here without stopping it first.
-	 */
-	mutex_lock(&omap->mutex);
 	omap->pdata->set_pwm(omap->dm_timer,
 			     polarity == PWM_POLARITY_INVERSED,
 			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
 			     true);
+
+	if (enabled)
+		pwm_omap_dmtimer_start(omap);
+}
+
+/**
+ * pwm_omap_dmtimer_apply() - Changes the state of the pwm omap dm timer.
+ * @chip:	Pointer to PWM controller
+ * @pwm:	Pointer to PWM channel
+ * @state:	New state to apply
+ *
+ * Return 0 if successfully changed the state else appropriate error.
+ */
+static int pwm_omap_dmtimer_apply(struct pwm_chip *chip,
+				  struct pwm_device *pwm,
+				  const struct pwm_state *state)
+{
+	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
+	int ret = 0;
+
+	mutex_lock(&omap->mutex);
+
+	if (pwm_omap_dmtimer_is_enabled(omap) && !state->enabled) {
+		omap->pdata->stop(omap->dm_timer);
+		goto unlock_mutex;
+	}
+
+	if (pwm_omap_dmtimer_polarity(omap) != state->polarity)
+		pwm_omap_dmtimer_set_polarity(chip, pwm, state->polarity);
+
+	ret = pwm_omap_dmtimer_config(chip, pwm, state->duty_cycle,
+				      state->period);
+	if (ret)
+		goto unlock_mutex;
+
+	if (!pwm_omap_dmtimer_is_enabled(omap) && state->enabled) {
+		omap->pdata->set_pwm(omap->dm_timer,
+				     state->polarity == PWM_POLARITY_INVERSED,
+				     true,
+				     OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
+				     true);
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
@@ -280,6 +357,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	    !pdata->set_load ||
 	    !pdata->set_match ||
 	    !pdata->set_pwm ||
+	    !pdata->get_pwm_status ||
 	    !pdata->set_prescaler ||
 	    !pdata->write_counter) {
 		dev_err(&pdev->dev, "Incomplete dmtimer pdata structure\n");
-- 
2.23.0

