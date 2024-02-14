Return-Path: <linux-pwm+bounces-1376-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FFC8545BF
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88DD31C26D90
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC4218C38;
	Wed, 14 Feb 2024 09:34:37 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA98F12E5E
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903277; cv=none; b=I7FHvvOulqEBQdabKFUzRUh8eF6RJ3YUtVRrWsF7zuHg9pA+t9PZOIn3su4Tz3jVIka01rYKJvpPUZ1DVn2CtHXT9K1H5+stems4JlVO0YRFievhfpDp0S61X00yHZXFIWPUbA1NhY7V+W7x8hxnNSJcDtTm2LEht1o3C/5qSuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903277; c=relaxed/simple;
	bh=lGUecNCwBfcrdR1yv/aBSypKpDhhdu1IeSjEpVahTX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3c0fpRQHQKv79iiip5/4+QmQUPQDJRCkxDI6yKvO744d+09lG5DLi/iI2l+Xz28JLa7k/3KluPCO1ZZgw819YGpj9pLup9HkSQwwH2PhmmsDw9MEnHROH36WkYlvQvGFRKCg5izotU1y1XQU9jUqtYEAw5d029KDkYBg+XXr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-00056v-Pb; Wed, 14 Feb 2024 10:34:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-000fDA-V0; Wed, 14 Feb 2024 10:34:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-004Y4Z-2p;
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
Subject: [PATCH v6 071/164] pwm: meson: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:58 +0100
Message-ID:  <02d5f32001c4d0817fa79f5831cfd16b7e345f00.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=lGUecNCwBfcrdR1yv/aBSypKpDhhdu1IeSjEpVahTX8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIicu0Qm2x0kESKafacDQMOK2tGhj6by91QPQ 8xM4An/CGiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyInAAKCRCPgPtYfRL+ TtQaCACrgQRjkPmjo63SZIBLq/BColLa6bOlmKXmO3Lu+7q7KYKjyFJ23MJYIwb0GFMM0tTThqx lKmYG3szeg8npTWTEkLza2H8WSoRxztqcaa06BjuN4EzK4IZ39BvSIzTsMkjshGEyJpQL5JV1Lr ENynJWyjfdzNZR4HU1gxESxp77P5g1dmZU5cKA9nX1l80ZkzuweNlfpYcIRCKIOLYsh+8phmrfM +wWe33LvwP1mDIBbq6InqTfCfuZVRzXwT/fum4MnFpy21ikeki2Vl9GRfIOEcxHWLSxRE29G2qj Hpet/6aqXEfxAEKKulkzRBk5QNMgGtcCu/I4c7Lxdmmo5Y7j
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the accessor
function provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-meson.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 7ce41811537d..8f67d6ba443d 100644
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
@@ -170,19 +170,19 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	fin_freq = clk_round_rate(channel->clk, freq);
 	if (fin_freq == 0) {
-		dev_err(chip->dev, "invalid source clock frequency\n");
+		dev_err(pwmchip_parent(chip), "invalid source clock frequency\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(chip->dev, "fin_freq: %lu Hz\n", fin_freq);
+	dev_dbg(pwmchip_parent(chip), "fin_freq: %lu Hz\n", fin_freq);
 
 	cnt = div_u64(fin_freq * period, NSEC_PER_SEC);
 	if (cnt > 0xffff) {
-		dev_err(chip->dev, "unable to get period cnt\n");
+		dev_err(pwmchip_parent(chip), "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(chip->dev, "period=%llu cnt=%u\n", period, cnt);
+	dev_dbg(pwmchip_parent(chip), "period=%llu cnt=%u\n", period, cnt);
 
 	if (duty == period) {
 		channel->hi = cnt;
@@ -193,7 +193,7 @@ static int meson_pwm_calc(struct pwm_chip *chip, struct pwm_device *pwm,
 	} else {
 		duty_cnt = div_u64(fin_freq * duty, NSEC_PER_SEC);
 
-		dev_dbg(chip->dev, "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
+		dev_dbg(pwmchip_parent(chip), "duty=%llu duty_cnt=%u\n", duty, duty_cnt);
 
 		channel->hi = duty_cnt;
 		channel->lo = cnt - duty_cnt;
@@ -217,7 +217,7 @@ static void meson_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	err = clk_set_rate(channel->clk, channel->rate);
 	if (err)
-		dev_err(chip->dev, "setting clock rate failed\n");
+		dev_err(pwmchip_parent(chip), "setting clock rate failed\n");
 
 	spin_lock_irqsave(&meson->lock, flags);
 
@@ -439,7 +439,7 @@ static int meson_pwm_init_channels(struct pwm_chip *chip)
 {
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	struct clk_parent_data mux_parent_data[MESON_MAX_MUX_PARENTS] = {};
-	struct device *dev = chip->dev;
+	struct device *dev = pwmchip_parent(chip);
 	unsigned int i;
 	char name[255];
 	int err;
-- 
2.43.0


