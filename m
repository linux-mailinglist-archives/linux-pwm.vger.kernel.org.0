Return-Path: <linux-pwm+bounces-331-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B45D4806E6A
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F271F215A2
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC513589C;
	Wed,  6 Dec 2023 11:48:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9DB12B
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO9-0006Fd-3t; Wed, 06 Dec 2023 12:48:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO8-00Dwsn-E7; Wed, 06 Dec 2023 12:48:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO8-00FQxv-53; Wed, 06 Dec 2023 12:48:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH v4 023/115] pwm: meson: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:37 +0100
Message-ID:  <52b4ea8c74ef274832b06bfc57c9706c140dd329.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5214; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=gl4J/Hz4wpcAixzFHayRO5eERffcWH6GG/bx1Ktak+I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF57zBfmOXtqgnsu6rmh7y4uItsBLTYxqe0zz +gQUqbeSCSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeewAKCRCPgPtYfRL+ TrkSB/48akha5jjCIMXBiezxe7ii+RiCMx2OI7hv+rR09a5abAK+V1gE1jDxYyTr0iKQITEuRQ4 swVfpATNmkf6xjwx/d8YB/2Vdu7AXALeOgyh8op7yPHfFfMYu3vmo/8iJej5yfWkQ1YR9W9argK Air1TCQASfWT7cXd0qm/421Qe886/pXGPmpt8auLGlplbyvqiSlxCry/qNnPIqT2o+XrXBdPkG7 purfZ6+Y8XVEeUjMZq9Qh6QADpK9F3rNKQdzg6JFZqDPg/D5Cn7+9CTuQO2ee/mKhiwiO2lgvXP IhX/B3qBeE9GuZEw5xHWtz3SkB3GJefRxzCY4zatT82DZ88S
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
 drivers/pwm/pwm-meson.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5bea53243ed2..640d6fe63799 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -122,7 +122,7 @@ static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	int err;
 
 	err = clk_prepare_enable(channel->clk);
@@ -143,9 +143,10 @@ static void meson_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(channel->clk);
 }
 
-static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
+static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
+	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	unsigned int cnt, duty_cnt;
 	unsigned long fin_freq;
@@ -169,19 +170,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 	fin_freq = clk_round_rate(channel->clk, freq);
 	if (fin_freq == 0) {
-		dev_err(meson->chip.dev, "invalid source clock frequency\n");
+		dev_err(pwmchip_parent(chip), "invalid source clock frequency\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
+	dev_dbg(pwmchip_parent(chip), "fin_freq: %lu Hz\n", fin_freq);
 
 	cnt = div_u64(fin_freq * period, NSEC_PER_SEC);
 	if (cnt > 0xffff) {
-		dev_err(meson->chip.dev, "unable to get period cnt\n");
+		dev_err(pwmchip_parent(chip), "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "period=%llu cnt=%u\n", period, cnt);
+	dev_dbg(pwmchip_parent(chip), "period=%llu cnt=%u\n", period, cnt);
 
 	if (duty == period) {
 		channel->hi = cnt;
@@ -192,7 +193,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	} else {
 		duty_cnt = div_u64(fin_freq * duty, NSEC_PER_SEC);
 
-		dev_dbg(meson->chip.dev, "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
+		dev_dbg(pwmchip_parent(chip), "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
 
 		channel->hi = duty_cnt;
 		channel->lo = cnt - duty_cnt;
@@ -203,8 +204,9 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	return 0;
 }
 
-static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
+static void meson_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
 	struct meson_pwm_channel_data *channel_data;
 	unsigned long flags;
@@ -215,7 +217,7 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 
 	err = clk_set_rate(channel->clk, channel->rate);
 	if (err)
-		dev_err(meson->chip.dev, "setting clock rate failed\n");
+		dev_err(pwmchip_parent(chip), "setting clock rate failed\n");
 
 	spin_lock_irqsave(&meson->lock, flags);
 
@@ -230,8 +232,9 @@ static void meson_pwm_enable(struct meson_pwm *meson, struct pwm_device *pwm)
 	spin_unlock_irqrestore(&meson->lock, flags);
 }
 
-static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
+static void meson_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct meson_pwm *meson = to_meson_pwm(chip);
 	unsigned long flags;
 	u32 value;
 
@@ -269,16 +272,16 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			channel->hi = ~0;
 			channel->lo = 0;
 
-			meson_pwm_enable(meson, pwm);
+			meson_pwm_enable(chip, pwm);
 		} else {
-			meson_pwm_disable(meson, pwm);
+			meson_pwm_disable(chip, pwm);
 		}
 	} else {
-		err = meson_pwm_calc(meson, pwm, state);
+		err = meson_pwm_calc(chip, pwm, state);
 		if (err < 0)
 			return err;
 
-		meson_pwm_enable(meson, pwm);
+		meson_pwm_enable(chip, pwm);
 	}
 
 	return 0;
@@ -432,10 +435,11 @@ static const struct of_device_id meson_pwm_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
 
-static int meson_pwm_init_channels(struct meson_pwm *meson)
+static int meson_pwm_init_channels(struct pwm_chip *chip)
 {
+	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct clk_parent_data mux_parent_data[MESON_MAX_MUX_PARENTS] = {};
-	struct device *dev = meson->chip.dev;
+	struct device *dev = pwmchip_parent(chip);
 	unsigned int i;
 	char name[255];
 	int err;
@@ -549,7 +553,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
 
 	meson->data = of_device_get_match_data(&pdev->dev);
 
-	err = meson_pwm_init_channels(meson);
+	err = meson_pwm_init_channels(&meson->chip);
 	if (err < 0)
 		return err;
 
-- 
2.42.0


