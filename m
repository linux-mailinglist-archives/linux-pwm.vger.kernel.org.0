Return-Path: <linux-pwm+bounces-7255-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8186DB4480B
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Sep 2025 23:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FBEAA07729
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Sep 2025 21:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA893291C11;
	Thu,  4 Sep 2025 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dtE+EwhA";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="J/tRw8Gi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18371285CB2;
	Thu,  4 Sep 2025 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757019991; cv=none; b=uXlccpUZ6GDRhtP/e0u6Htrf5JB5reFD8PfZs6A1k2NmjsnFoQNNN8ALNchGfcqNhX5SqosPJudNvrDah3Q2ZpkKRmrOuUzOpJSA1tNQllrM9Ra4N75tablhUKUQ8U9YSys8lZRR1sKTvnGtjnZFmsyFtCfnq1VGr8HQLft9bsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757019991; c=relaxed/simple;
	bh=nyU7+lGQwCRieqtSL+lpyu2HNP+Tk/ReBcmS7Z5N4WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NnhJ8ybnafzKH86Y+8he0lLxSU/CrIkDuhgn5ZVzHuHRhYY9Tp+rt51fUM7IjZmZeGFG40As+RxfQkLlwbUXkYRgs4gI1s5J97Lr696N6bYjFpf97E7YsoY0zqxS5Cy+V99EeFW3T4qCovuc1hBV0+AdVDBUys03SrZ+rTxlrtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=dtE+EwhA; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=J/tRw8Gi; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cHsTt6B09z9t1V;
	Thu,  4 Sep 2025 23:06:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757019986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z4tAV2a7c/vV1Y3jhutyUas+YMo3CMGhRMVMXiHHS4k=;
	b=dtE+EwhA8JUV9LpWhV9I/OfkXaLM55Te+prX0GxewkczWjRSE7g/GIvoFIoAeukoOtFP+S
	kSKSgaLXpNhUb2l+cuuFVIEZmp+6J0H0qVKzm08BYg5WkikDo0sgVaxNzkZYt7Eb87G2VJ
	yIosYQV9RfPkIEyaHfYcHtwtqklgZ1TTmfIdyf3+WmO+T1rwpWZUz/w/aqD3+xnMyZPESJ
	hSuAWYqfoaCRlMs2sB8h1+tWT1YfYVQyLIHjMeJlVngu01zS3WVHLNp3+ZRd4GAdnlNKpi
	l2EFoqoyjTUAANVsZIJqXiD4jTp/7vDuyof6xJVZmG8sx2bdlut6QUINnMB/4A==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="J/tRw8Gi";
	spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757019984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z4tAV2a7c/vV1Y3jhutyUas+YMo3CMGhRMVMXiHHS4k=;
	b=J/tRw8GiInWydz8EFd1FRRu7uN6YFMy+AUgE8dUX4KIs9AXLCA/BnB/6YsgHZShKkdASaI
	2zAlJIIr/yLbubCC+/mwJe8yS8GqTmutFkoIdK3QZQptYbwH4lvoZ1nGNQ2X3QlxYxkjQp
	DrdwJ1RSj0AvvvsCGGJpULNQZCMyrCc+8/wM0XmaKgCIhmho/r0gMoXSXPNcO5qVIAJ8gR
	I4/e56B9nKMeaDmdVx12+Vw78Hex2snmipX4qlOsQE0dMiP24om0oXfR4uP+BsoL/eH1fs
	BnE0eZ5r+xaWLGvfM8VKV04IRTArMiVbLYw/TOa8gDKUt4n+/rw+nKK+O/BCig==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] regulator: rpi-panel-v2: Convert to new PWM waveform ops
Date: Thu,  4 Sep 2025 23:05:28 +0200
Message-ID: <20250904210604.186893-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: pyet1wbbighin5f9o3pjuz3e6io6odkk
X-MBO-RS-ID: e39fd8850014df4df79
X-Rspamd-Queue-Id: 4cHsTt6B09z9t1V

Convert the driver from legacy PWM apply ops to modern waveform ops.
There is no functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-pwm@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
V2: - Safeguard against wf->duty_length_ns > wf->period_length_ns
---
 drivers/regulator/rpi-panel-v2-regulator.c | 53 +++++++++++++++++-----
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/rpi-panel-v2-regulator.c b/drivers/regulator/rpi-panel-v2-regulator.c
index 30b78aa75ee38..eb4c4e3ead364 100644
--- a/drivers/regulator/rpi-panel-v2-regulator.c
+++ b/drivers/regulator/rpi-panel-v2-regulator.c
@@ -35,24 +35,55 @@ static const struct regmap_config rpi_panel_regmap_config = {
 	.can_sleep = true,
 };
 
-static int rpi_panel_v2_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-				  const struct pwm_state *state)
+static int rpi_panel_v2_pwm_round_waveform_tohw(struct pwm_chip *chip,
+						struct pwm_device *pwm,
+						const struct pwm_waveform *wf,
+						void *_wfhw)
 {
-	struct regmap *regmap = pwmchip_get_drvdata(chip);
-	unsigned int duty;
+	u8 *wfhw = _wfhw;
+
+	if (wf->duty_length_ns > wf->period_length_ns)
+		*wfhw = 100;
+	else
+		*wfhw = mul_u64_u64_div_u64(wf->duty_length_ns, 100, wf->period_length_ns);
+
+	return 0;
+}
 
-	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -EINVAL;
+static int rpi_panel_v2_pwm_round_waveform_fromhw(struct pwm_chip *chip,
+						  struct pwm_device *pwm,
+						  const void *_wfhw,
+						  struct pwm_waveform *wf)
+{
+	const u8 *wfhw = _wfhw;
+
+	/*
+	 * These numbers here are utter fabrications, the device is sealed
+	 * in metal casing and difficult to take apart and measure, so we
+	 * pick some arbitrary values here, values which fit nicely.
+	 */
+	wf->period_length_ns = 100 * 1000;	/* 100 us ~= 10 kHz */
+	wf->duty_length_ns = *wfhw * 1000;	/* 0..100us */
+	wf->duty_offset_ns = 0;
+
+	return 0;
+}
 
-	if (!state->enabled)
-		return regmap_write(regmap, REG_PWM, 0);
+static int rpi_panel_v2_pwm_write_waveform(struct pwm_chip *chip,
+					   struct pwm_device *pwm,
+					   const void *_wfhw)
+{
+	struct regmap *regmap = pwmchip_get_drvdata(chip);
+	const u8 *wfhw = _wfhw;
 
-	duty = pwm_get_relative_duty_cycle(state, PWM_BL_MASK);
-	return regmap_write(regmap, REG_PWM, duty | PWM_BL_ENABLE);
+	return regmap_write(regmap, REG_PWM, *wfhw | (*wfhw ? PWM_BL_ENABLE : 0));
 }
 
 static const struct pwm_ops rpi_panel_v2_pwm_ops = {
-	.apply = rpi_panel_v2_pwm_apply,
+	.sizeof_wfhw		= sizeof(u8),
+	.round_waveform_fromhw	= rpi_panel_v2_pwm_round_waveform_fromhw,
+	.round_waveform_tohw	= rpi_panel_v2_pwm_round_waveform_tohw,
+	.write_waveform		= rpi_panel_v2_pwm_write_waveform,
 };
 
 /*
-- 
2.50.1


