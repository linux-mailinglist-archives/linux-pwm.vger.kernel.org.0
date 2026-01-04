Return-Path: <linux-pwm+bounces-7841-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCF9CF143F
	for <lists+linux-pwm@lfdr.de>; Sun, 04 Jan 2026 20:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F125F3003F85
	for <lists+linux-pwm@lfdr.de>; Sun,  4 Jan 2026 19:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5376A222597;
	Sun,  4 Jan 2026 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Y4RlerGr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vTR4BvXK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6830E1F1932;
	Sun,  4 Jan 2026 19:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767555760; cv=none; b=H+pcv4hKgGatFWY/AWr9DJfVtRS28Q9wLVY54rmjkkOhk11FouF94kZJJ21moxD7yibfuFZsC2BxA4vBq2/28A2vfOLtmn9T1AwXNhC1pI6jks5ZvE5+/+F8w4wXgRBk9KfwNH9bUTfTFN/TqAorNMtFKisMsvsHQ4Jqd7qGQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767555760; c=relaxed/simple;
	bh=ZAWKQSm8yql79bOdfczpD0sUSJd9VM9averQaA9mDBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fh5sMFZ3ZyHanX35PJ09TaEY9ofFlGoekURIu+AZ+Ap0j3KO/+jFiSDSdRlL9T8pEuqPkOoPDJytFMidyHF7z7dfUrLlbl5kMr1cPu7f0r7uDPNWCURt4Mes2+z2q0vYAo+oLyClgWozEcKXq1e7i53J95nRIp+/Eoa/NMX5wQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Y4RlerGr; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vTR4BvXK; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dknrr2dvqz9tDp;
	Sun,  4 Jan 2026 20:42:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1767555756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hKT+kTolJMJjdOT8GZjDnB3jCt46N0hdL4sErLqKy3Y=;
	b=Y4RlerGrPluexgOh5itUh86qujRfQTXxfr++QL7m0rnsy/nnr/iWsc/Nsp159uqHnBlD3Z
	srEeLagEIidmERCQ+tyjZzNIwdNGGQc3XSMBuOOqhGL7UQxSg06XwY5SjWyYa0WOiskwYL
	toFzw33G8gNHLRCrAybZvV1DI70gepNEvUAwsTAevRZNAAt0whglraXFbzizoZeRtuTzBN
	Ou+jnISNjez/CBmW1mKYtZmhGua8e6TpPxL1OKzra/xUkAMgjJrESwXkTKm9xk530ypQG2
	wInSZdx0VZGWEGhxn3gyemBCgSDaPi80fOQXZa0tlUiNWmoJWnNIcegEMXuYvA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1767555754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hKT+kTolJMJjdOT8GZjDnB3jCt46N0hdL4sErLqKy3Y=;
	b=vTR4BvXKl2fMerGsdBUorU8ygJKBg2leGdCqD3fVcb9xok//qntG2mrGpVRB7unl8hHtgZ
	jkBBxBjy+b+vEyYZF/R2bUjWLgyDmEKkpb/sb7yeFqXoJQ7DkRPECPtIgr3Jg1rJwPM2rC
	JeOaQpxQqNlPqsMKBQwwCXTlFtEK0fz0Imd993ukguXpuepko+heST1f8sJszQEFonyrAc
	G0TBv+eStB3/mMprHoldeJS/dD7WJM7FBOiO7y6ig3WUmtznXHe4KbHFt67+rEnXDYp909
	ra/m1wn+Anq0+pAT+3ksBTnKhwoj3u8U8MWTutG+B/t476De3kWzJZd1Wju6xQ==
To: linux-pwm@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform ops
Date: Sun,  4 Jan 2026 20:41:43 +0100
Message-ID: <20260104194224.41245-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 20fa985a1b372f7d538
X-MBO-RS-META: fbuz9ifp5y6phtswqyarhi554tdoudfx

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
V3: - Use PWM_BL_MASK as the maximum period length
---
Note this now generates warnings:
pwm pwmchip5: Wrong rounding: requested 162/255 [+0], result 19000/31000 [+0]
---
 drivers/regulator/rpi-panel-v2-regulator.c | 53 +++++++++++++++++-----
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/rpi-panel-v2-regulator.c b/drivers/regulator/rpi-panel-v2-regulator.c
index 30b78aa75ee38..e5e12ff649804 100644
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
+		*wfhw = PWM_BL_MASK;
+	else
+		*wfhw = mul_u64_u64_div_u64(wf->duty_length_ns, PWM_BL_MASK, wf->period_length_ns);
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
+	wf->period_length_ns = PWM_BL_MASK * 1000;	/* 31 us ~= 30 kHz */
+	wf->duty_length_ns = *wfhw * 1000;		/* 0..31us */
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
2.51.0


