Return-Path: <linux-pwm+bounces-30-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724B27F2F66
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945141C215BF
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E955380C;
	Tue, 21 Nov 2023 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5922B10C1
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAL-00059i-LL; Tue, 21 Nov 2023 14:51:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAK-00AaxV-G7; Tue, 21 Nov 2023 14:51:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAK-004xbr-6m; Tue, 21 Nov 2023 14:51:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 018/108] pwm: meson: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:20 +0100
Message-ID: <20231121134901.208535-19-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5214; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=gl4J/Hz4wpcAixzFHayRO5eERffcWH6GG/bx1Ktak+I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVhHTUdnkCScnr16CkAD/kpCLZMzRtRHxIVM NN53JFgcjqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1YQAKCRCPgPtYfRL+ TjH9B/0d4LCOnk5bdQuG6DX50erZUjqV+eAUykeIi+5AzCOz5yRdPPzHV0yr8cqv6V0fm46l/bK bnQtqR3ALc2MS4nma/8iamoFNZ+d2LsARGXdakS23QALLCsYzVICoEC1dQCykpmcyKUAiAbnQk4 Ntd/ojIcH4NUaBD3FJeJ5Hk/cy0Xi9xyBis67mwssx7NNxt1yAgNRH593CDRdILdyJcojD73JUY vyJwGp8jf56TgQVLHgJ7f7iIKhcqLhtU4fEnZOHzF4c1ZvMtO/hcfdZMB//3LQ6M4NgO4CX/Tkk YpCSSWe/oIqJBs5qSIkleZfuCTP6KvZohW29KblCBQqr5zHh
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


