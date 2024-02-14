Return-Path: <linux-pwm+bounces-1380-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403D78545C1
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB559289D11
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F422912E73;
	Wed, 14 Feb 2024 09:34:38 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2EB17C6D
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903278; cv=none; b=jnIFTAyJ3OFfwFMfwbJ4jmLwV1ALssdXiJRKkRZU5kNKhlNURjGxB60r8x51a692koCQEJbAG/JKJRsB0KdKzsE2WMHb2cvoau0uuMcPUMP7nBSnO0zveOyLmXRN8wLmd/DLVjhv14ZPu6wOXyHFwOO33F+VmpRRSuc1Ib932Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903278; c=relaxed/simple;
	bh=nznIKwEERklBb4k0h0BWwYopUbH9um6rOZd4hcpdvBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k7HGCyT8SO4ybfAOP4xdvz9WGc3HwKIHjkgKXlyrf0XGU0TLZl39nttsD6wYq61VbtuWUDWA2IgpMO0vs+QOlgQbPJe4FvGrIHleMQ0RhWdBZ0If6t0m68mET8ABusVp0Lhz81n6Ylyl/Wt2CEHUiO8sbrs4g0Tfpqv61kkRZqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-00055O-EF; Wed, 14 Feb 2024 10:34:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-000fD6-Pq; Wed, 14 Feb 2024 10:34:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-004Y4V-2J;
	Wed, 14 Feb 2024 10:34:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-pwm@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 070/164] pwm: meson: Change prototype of a few helpers to prepare further changes
Date: Wed, 14 Feb 2024 10:31:57 +0100
Message-ID:  <157084e1dd464da0097edba880240868c1c0b27e.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5267; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=nznIKwEERklBb4k0h0BWwYopUbH9um6rOZd4hcpdvBU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIibWWdmu8Q5kvUUWYhyG+ileLxF6l3vdzMDq u/Wqi6F21GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyImwAKCRCPgPtYfRL+ TinEB/4xcfRCnc2talpzXOwvLODJTjeujAtEQebuBJzt55qg4FEDblt4tc7gPlSJNJeC3Ym2m7N 8WzwcVRazbk/Jwgn0IxYnKxegjWXQ6FP5wYfT98HJwDf3Gn6F0yX42PQyyES3/yazzWh0/UVP9j qBU9GvzFA9a8HlHj5Dqb7lE8itCsu+4ixOIciZ+PHUJB0GTj0kxuyfM9da0Ygdhk8o6S7JBmjVQ xMhf4yE0LYPC8SbHrNrZAhvkn8YqaszeH5rKCc+mwQMUJbYxLKAmEaxpj2S/XdwTfqH6VJHmoWA ItWZ4qlj0cPhUIR78wDVgjvJ0aGhTzicZm51GoxVap4TP1N2
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will make it harder to
determine the pwm_chip from a given meson_pwm. To just not have to do
that, rework meson_pwm_calc(), meson_pwm_enable(), meson_pwm_disable()
and meson_pwm_init_channels() to take a pwm_chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-meson.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 2971bbf3b5e7..7ce41811537d 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
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
+		dev_err(chip->dev, "invalid source clock frequency\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
+	dev_dbg(chip->dev, "fin_freq: %lu Hz\n", fin_freq);
 
 	cnt = div_u64(fin_freq * period, NSEC_PER_SEC);
 	if (cnt > 0xffff) {
-		dev_err(meson->chip.dev, "unable to get period cnt\n");
+		dev_err(chip->dev, "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "period=%llu cnt=%u\n", period, cnt);
+	dev_dbg(chip->dev, "period=%llu cnt=%u\n", period, cnt);
 
 	if (duty == period) {
 		channel->hi = cnt;
@@ -192,7 +193,7 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	} else {
 		duty_cnt = div_u64(fin_freq * duty, NSEC_PER_SEC);
 
-		dev_dbg(meson->chip.dev, "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
+		dev_dbg(chip->dev, "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
 
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
+		dev_err(chip->dev, "setting clock rate failed\n");
 
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
+	struct device *dev = chip->dev;
 	unsigned int i;
 	char name[255];
 	int err;
@@ -445,7 +449,7 @@ static int meson_pwm_init_channels(struct meson_pwm *meson)
 		mux_parent_data[i].name = meson->data->parent_names[i];
 	}
 
-	for (i = 0; i < meson->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
 		struct clk_parent_data div_parent = {}, gate_parent = {};
 		struct clk_init_data init = {};
@@ -543,7 +547,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
 
 	meson->data = of_device_get_match_data(&pdev->dev);
 
-	err = meson_pwm_init_channels(meson);
+	err = meson_pwm_init_channels(&meson->chip);
 	if (err < 0)
 		return err;
 
-- 
2.43.0


