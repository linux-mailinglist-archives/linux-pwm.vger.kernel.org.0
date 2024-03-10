Return-Path: <linux-pwm+bounces-1736-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D675787762A
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 12:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96466281791
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 11:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFBB1EB51;
	Sun, 10 Mar 2024 11:01:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C511EB3B
	for <linux-pwm@vger.kernel.org>; Sun, 10 Mar 2024 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710068475; cv=none; b=IpD8MjkrcTatrLy6iJeAvHl46d2ZWbWsqfKWfvWEngE/EdWsUUhoKmyS5XyJq5KY2Wzv19XEWKB2PJAMlh+3O8WPPRTUWG82P0g777RjNR2XFwdvjiPpR0Esomk06ByK47cbqNdV2aYxq0BoniDk73HLeN4mA8zUjgFjIyiZefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710068475; c=relaxed/simple;
	bh=JGzNLvh2sLqNnT4z1Qjx1WIsavXed54/MhbBrqfJTiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GYyTnlPpny6Pa5N/L6Kf7YJMTopCDc2e4avz57aS6ALcgOO7bLj7ZnZm2Z3jUH7YG9Wv77GptFBd9DbPGQJNLzUTaHQJbKQQ1me+Lp+BVMI/OolUYF/oOFjmLUpUFzn3yU7sy5A694qlP86MFmrSzkL6rcSTLiCdxLHrtopPljU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvW-0000pw-9m; Sun, 10 Mar 2024 12:01:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvV-005V0t-SN; Sun, 10 Mar 2024 12:01:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvV-003OFi-2Z;
	Sun, 10 Mar 2024 12:01:09 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Ajit Pal Singh <ajitpal.singh@st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Lee Jones <lee@kernel.org>,
	kernel@pengutronix.de
Subject: [PATCH 4/6] pwm: sti: Maintain all per-chip driver data in a single struct
Date: Sun, 10 Mar 2024 12:00:57 +0100
Message-ID:  <2788a421ec838ee8f63e76a78b04e1d48b49f959.1710068192.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710068192.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710068192.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6586; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JGzNLvh2sLqNnT4z1Qjx1WIsavXed54/MhbBrqfJTiM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7ZLsJt1nz2GkMZFA5DLb0SAUGfERWXCP+fVK4 F0DyiAdQneJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe2S7AAKCRCPgPtYfRL+ TvOJB/9XGNhfcV8ElXy+sx7WmVjLa1FyMfVc/S8Xo7jUc96G9yMPLih1mFMB1Y4H3Fd0gg3XP3c zaEqLUZFgnUURe05VVXWinI65+FEZUJO5mGwEx9wYrDEWe6w0kBMwE8HvxcpiG2IO6TWAEIxsGv SDcfzVH2iWSmxiYopLxLoRZZ1bOLkq7ai1UYZ3b4eWSHPUVKePXAW1i9fNIye2HJ6sI9RFJGOzp wtz7y7VsSjFxVo7yQ9yKKMFZA2Et7UnnwRmw56WcBVhJQH0rA8n3zTaUDSECuwF/couUQFW0Mir GZ3XCdi9rqnf/mabBVSmhMQW6Mz7sOde8caB7z7tMHHL53kC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Instead of (arbitrarily?) spliting the per-chip driver data into two
structures, put everything into struct sti_pwm_chip. This reduces memory
management overhead and a few pointer indirections.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sti.c | 58 ++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 36 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index fa86590a92a6..e8fdf96d8cc4 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -73,20 +73,16 @@ struct sti_cpt_ddata {
 	wait_queue_head_t wait;
 };
 
-struct sti_pwm_compat_data {
-	unsigned int pwm_num_devs;
-	unsigned int cpt_num_devs;
-	unsigned int max_pwm_cnt;
-	unsigned int max_prescale;
-	struct sti_cpt_ddata *ddata;
-};
-
 struct sti_pwm_chip {
 	struct device *dev;
 	struct clk *pwm_clk;
 	struct clk *cpt_clk;
 	struct regmap *regmap;
-	struct sti_pwm_compat_data *cdata;
+	unsigned int pwm_num_devs;
+	unsigned int cpt_num_devs;
+	unsigned int max_pwm_cnt;
+	unsigned int max_prescale;
+	struct sti_cpt_ddata *ddata;
 	struct regmap_field *prescale_low;
 	struct regmap_field *prescale_high;
 	struct regmap_field *pwm_out_en;
@@ -121,7 +117,6 @@ static inline struct sti_pwm_chip *to_sti_pwmchip(struct pwm_chip *chip)
 static int sti_pwm_get_prescale(struct sti_pwm_chip *pc, unsigned long period,
 				unsigned int *prescale)
 {
-	struct sti_pwm_compat_data *cdata = pc->cdata;
 	unsigned long clk_rate;
 	unsigned long value;
 	unsigned int ps;
@@ -136,13 +131,13 @@ static int sti_pwm_get_prescale(struct sti_pwm_chip *pc, unsigned long period,
 	 * prescale = ((period_ns * clk_rate) / (10^9 * (max_pwm_cnt + 1)) - 1
 	 */
 	value = NSEC_PER_SEC / clk_rate;
-	value *= cdata->max_pwm_cnt + 1;
+	value *= pc->max_pwm_cnt + 1;
 
 	if (period % value)
 		return -EINVAL;
 
 	ps  = period / value - 1;
-	if (ps > cdata->max_prescale)
+	if (ps > pc->max_prescale)
 		return -EINVAL;
 
 	*prescale = ps;
@@ -163,7 +158,6 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			  int duty_ns, int period_ns)
 {
 	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
-	struct sti_pwm_compat_data *cdata = pc->cdata;
 	unsigned int ncfg, value, prescale = 0;
 	struct pwm_device *cur = pc->cur;
 	struct device *dev = pc->dev;
@@ -223,7 +217,7 @@ static int sti_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		 * PWM pulse = (max_pwm_count + 1) local cycles,
 		 * that is continuous pulse: signal never goes low.
 		 */
-		value = cdata->max_pwm_cnt * duty_ns / period_ns;
+		value = pc->max_pwm_cnt * duty_ns / period_ns;
 
 		ret = regmap_write(pc->regmap, PWM_OUT_VAL(pwm->hwpwm), value);
 		if (ret)
@@ -312,14 +306,13 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 			   struct pwm_capture *result, unsigned long timeout)
 {
 	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
-	struct sti_pwm_compat_data *cdata = pc->cdata;
-	struct sti_cpt_ddata *ddata = &cdata->ddata[pwm->hwpwm];
+	struct sti_cpt_ddata *ddata = &pc->ddata[pwm->hwpwm];
 	struct device *dev = pc->dev;
 	unsigned int effective_ticks;
 	unsigned long long high, low;
 	int ret;
 
-	if (pwm->hwpwm >= cdata->cpt_num_devs) {
+	if (pwm->hwpwm >= pc->cpt_num_devs) {
 		dev_err(dev, "device %u is not valid\n", pwm->hwpwm);
 		return -EINVAL;
 	}
@@ -394,11 +387,10 @@ static int sti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
 	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
-	struct sti_pwm_compat_data *cdata = pc->cdata;
 	struct device *dev = pc->dev;
 	int err;
 
-	if (pwm->hwpwm >= cdata->pwm_num_devs) {
+	if (pwm->hwpwm >= pc->pwm_num_devs) {
 		dev_err(dev, "device %u is not valid for pwm mode\n",
 			pwm->hwpwm);
 		return -EINVAL;
@@ -447,7 +439,7 @@ static irqreturn_t sti_pwm_interrupt(int irq, void *data)
 	while (cpt_int_stat) {
 		devicenum = ffs(cpt_int_stat) - 1;
 
-		ddata = &pc->cdata->ddata[devicenum];
+		ddata = &pc->ddata[devicenum];
 
 		/*
 		 * Capture input:
@@ -551,7 +543,6 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	u32 num_devs;
 	unsigned int pwm_num_devs = 0;
 	unsigned int cpt_num_devs = 0;
-	struct sti_pwm_compat_data *cdata;
 	struct pwm_chip *chip;
 	struct sti_pwm_chip *pc;
 	unsigned int i;
@@ -573,10 +564,6 @@ static int sti_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip);
 	pc = to_sti_pwmchip(chip);
 
-	cdata = devm_kzalloc(dev, sizeof(*cdata), GFP_KERNEL);
-	if (!cdata)
-		return -ENOMEM;
-
 	pc->mmio = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio))
 		return PTR_ERR(pc->mmio);
@@ -600,12 +587,11 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	 * Setup PWM data with default values: some values could be replaced
 	 * with specific ones provided from Device Tree.
 	 */
-	cdata->max_prescale = 0xff;
-	cdata->max_pwm_cnt = 255;
-	cdata->pwm_num_devs = pwm_num_devs;
-	cdata->cpt_num_devs = cpt_num_devs;
+	pc->max_prescale = 0xff;
+	pc->max_pwm_cnt = 255;
+	pc->pwm_num_devs = pwm_num_devs;
+	pc->cpt_num_devs = cpt_num_devs;
 
-	pc->cdata = cdata;
 	pc->dev = dev;
 	pc->en_count = 0;
 	mutex_init(&pc->sti_pwm_lock);
@@ -614,28 +600,28 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to initialize regmap fields\n");
 
-	if (cdata->pwm_num_devs) {
+	if (pc->pwm_num_devs) {
 		pc->pwm_clk = devm_clk_get_prepared(dev, "pwm");
 		if (IS_ERR(pc->pwm_clk))
 			return dev_err_probe(dev, PTR_ERR(pc->pwm_clk),
 					     "failed to get PWM clock\n");
 	}
 
-	if (cdata->cpt_num_devs) {
+	if (pc->cpt_num_devs) {
 		pc->cpt_clk = devm_clk_get_prepared(dev, "capture");
 		if (IS_ERR(pc->cpt_clk))
 			return dev_err_probe(dev, PTR_ERR(pc->cpt_clk),
 					     "failed to get PWM capture clock\n");
 
-		cdata->ddata = devm_kzalloc(dev, cdata->cpt_num_devs * sizeof(*cdata->ddata), GFP_KERNEL);
-		if (!cdata->ddata)
+		pc->ddata = devm_kzalloc(dev, pc->cpt_num_devs * sizeof(*pc->ddata), GFP_KERNEL);
+		if (!pc->ddata)
 			return -ENOMEM;
 	}
 
 	chip->ops = &sti_pwm_ops;
 
-	for (i = 0; i < cdata->cpt_num_devs; i++) {
-		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
+	for (i = 0; i < pc->cpt_num_devs; i++) {
+		struct sti_cpt_ddata *ddata = &pc->ddata[i];
 
 		init_waitqueue_head(&ddata->wait);
 		mutex_init(&ddata->lock);
-- 
2.43.0


