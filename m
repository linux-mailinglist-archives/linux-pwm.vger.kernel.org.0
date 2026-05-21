Return-Path: <linux-pwm+bounces-9040-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNjWKRTDDmrXBwYAu9opvQ
	(envelope-from <linux-pwm+bounces-9040-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 10:32:20 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 140125A1144
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 10:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92BA73037EEC
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2026 08:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF91355F46;
	Thu, 21 May 2026 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsbs/SCa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B4B261B91;
	Thu, 21 May 2026 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352028; cv=none; b=F8AWqCZ1xyxYAzutVgM1mMfH1WoFqD2fQm/0ml14TXNDwUtWK9QbkBncZDl3digOk7VpOONiJfMBVavU9RV/8CUwZOjAUj9OD0EsOQX+id1u9eS6NQIUF+HdzQQo10SxT8EFVRCRKbVa0l3SI3ctg5xIJVsTLaBeyF9nvaZN+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352028; c=relaxed/simple;
	bh=nrmg3HWgO9uceNXtSgM/Z0gIFOwywmG6C/cjZ3MQNRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqtduBRdOmaw80E+nx0UFpY38uMpK4E0grpk4RPoJ9VkBm+4E5DkJ+BDPV/tEGMbvt6XKNl7gKiHkZ7KDRTNCIfOQ3/EHK/+hgyNAt1BS2CJ1Uiy5nm1OxtHkFSBk2PMFQDGhBSO6jH3UrqQrug6e5HTXfldNZ+Jh6k1ZIkfY64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsbs/SCa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D278AC4AF0C;
	Thu, 21 May 2026 08:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779352027;
	bh=nrmg3HWgO9uceNXtSgM/Z0gIFOwywmG6C/cjZ3MQNRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lsbs/SCa6p3fbOzxKPf34ToX+DYsBS5QxvDLoTNHqWIRdx14VpoHl0McLsd9Cmf5F
	 Ca7WXCX7Uh68tuyMhLF8/OeeVIWZ3EUGKMNgAZwFRFmsHDClBs/ATGXRLXPppTzMt9
	 ZLobIdIPV0q8aZjX0npQFH2hAzCzFZEsjafiBSmkC9krjvHAaTYa0ZqyfSJ8PkSy6k
	 LywhsXikY28TB3eW2Ko612L2KZ6gK+KyJXg739OA/TkEXmrU5QOXMVxiudW74ddPCJ
	 Vvb15xvM3g2dO2lPY+t8N2Fs+LC46tj1mne3UulrO8LaNMIevGYawA4z23D5f4oioP
	 PyLXYwhMHUyrg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0881CD5BAF;
	Thu, 21 May 2026 08:27:07 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Thu, 21 May 2026 08:26:59 +0000
Subject: [PATCH v3 2/2] pwm: meson: Add support for Amlogic S7
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-s6-s7-pwm-v3-2-57b073fbafef@amlogic.com>
References: <20260521-s6-s7-pwm-v3-0-57b073fbafef@amlogic.com>
In-Reply-To: <20260521-s6-s7-pwm-v3-0-57b073fbafef@amlogic.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779352023; l=5104;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=ee7S/9E5/xxvFyHNx3kYA681vl0XgvW4Y8eFZhpoo0U=;
 b=TXiAdEYbw/KybAgqyonbV6T/exp3oQ74Da0C919cp5Yin7jK9EMw1J+LofGU2rmIBRHa/Yom2
 qGwM9+P1ScGAT1BFgu9YEEYa3gT6jpNbGBiMxyO/URz5UFU2L/CFeJe
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9040-lists,linux-pwm=lfdr.de,xianwei.zhao.amlogic.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linaro.org,baylibre.com,googlemail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amlogic.com:replyto,amlogic.com:mid,amlogic.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 140125A1144
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add support for Amlogic S7 PWM. Amlogic S7 different from the
previous SoCs, a controller includes one pwm, at the same time,
the controller has only one input clock source.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/pwm/pwm-meson.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 8c6bf3d49753..66c41bf036de 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -113,6 +113,7 @@ struct meson_pwm_data {
 	int (*channels_init)(struct pwm_chip *chip);
 	bool has_constant;
 	bool has_polarity;
+	u8 npwm;
 };
 
 struct meson_pwm {
@@ -503,6 +504,18 @@ static void meson_pwm_s4_put_clk(void *data)
 	clk_put(clk);
 }
 
+static int meson_pwm_init_channels_s7(struct pwm_chip *chip)
+{
+	struct device *dev = pwmchip_parent(chip);
+	struct meson_pwm *meson = to_meson_pwm(chip);
+
+	meson->channels[0].clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(meson->channels[0].clk))
+		return dev_err_probe(dev, PTR_ERR(meson->channels[0].clk),
+				     "Failed to get clk\n");
+	return 0;
+}
+
 static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
 {
 	struct device *dev = pwmchip_parent(chip);
@@ -530,6 +543,7 @@ static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
 static const struct meson_pwm_data pwm_meson8b_data = {
 	.parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
+	.npwm = MESON_NUM_PWMS,
 };
 
 /*
@@ -539,6 +553,7 @@ static const struct meson_pwm_data pwm_meson8b_data = {
 static const struct meson_pwm_data pwm_gxbb_ao_data = {
 	.parent_names = { "xtal", "clk81", NULL, NULL },
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
+	.npwm = MESON_NUM_PWMS,
 };
 
 static const struct meson_pwm_data pwm_axg_ee_data = {
@@ -546,6 +561,7 @@ static const struct meson_pwm_data pwm_axg_ee_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
 	.has_constant = true,
 	.has_polarity = true,
+	.npwm = MESON_NUM_PWMS,
 };
 
 static const struct meson_pwm_data pwm_axg_ao_data = {
@@ -553,6 +569,7 @@ static const struct meson_pwm_data pwm_axg_ao_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
 	.has_constant = true,
 	.has_polarity = true,
+	.npwm = MESON_NUM_PWMS,
 };
 
 static const struct meson_pwm_data pwm_g12a_ee_data = {
@@ -560,6 +577,7 @@ static const struct meson_pwm_data pwm_g12a_ee_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
 	.has_constant = true,
 	.has_polarity = true,
+	.npwm = MESON_NUM_PWMS,
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
@@ -567,6 +585,7 @@ static const struct meson_pwm_data pwm_g12a_ao_ab_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
 	.has_constant = true,
 	.has_polarity = true,
+	.npwm = MESON_NUM_PWMS,
 };
 
 static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
@@ -574,22 +593,33 @@ static const struct meson_pwm_data pwm_g12a_ao_cd_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_legacy,
 	.has_constant = true,
 	.has_polarity = true,
+	.npwm = MESON_NUM_PWMS,
 };
 
 static const struct meson_pwm_data pwm_meson8_v2_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_v2,
+	.npwm = MESON_NUM_PWMS,
 };
 
 static const struct meson_pwm_data pwm_meson_axg_v2_data = {
 	.channels_init = meson_pwm_init_channels_meson8b_v2,
 	.has_constant = true,
 	.has_polarity = true,
+	.npwm = MESON_NUM_PWMS,
 };
 
 static const struct meson_pwm_data pwm_s4_data = {
 	.channels_init = meson_pwm_init_channels_s4,
 	.has_constant = true,
 	.has_polarity = true,
+	.npwm = MESON_NUM_PWMS,
+};
+
+static const struct meson_pwm_data pwm_s7_data = {
+	.channels_init = meson_pwm_init_channels_s7,
+	.has_constant = true,
+	.has_polarity = true,
+	.npwm = 1,
 };
 
 static const struct of_device_id meson_pwm_matches[] = {
@@ -642,7 +672,11 @@ static const struct of_device_id meson_pwm_matches[] = {
 		.compatible = "amlogic,meson-s4-pwm",
 		.data = &pwm_s4_data
 	},
-	{},
+	{
+		.compatible = "amlogic,s7-pwm",
+		.data = &pwm_s7_data
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, meson_pwm_matches);
 
@@ -650,9 +684,10 @@ static int meson_pwm_probe(struct platform_device *pdev)
 {
 	struct pwm_chip *chip;
 	struct meson_pwm *meson;
+	const struct meson_pwm_data *pdata = of_device_get_match_data(&pdev->dev);
 	int err;
 
-	chip = devm_pwmchip_alloc(&pdev->dev, MESON_NUM_PWMS, sizeof(*meson));
+	chip = devm_pwmchip_alloc(&pdev->dev, pdata->npwm, sizeof(*meson));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 	meson = to_meson_pwm(chip);
@@ -664,7 +699,7 @@ static int meson_pwm_probe(struct platform_device *pdev)
 	spin_lock_init(&meson->lock);
 	chip->ops = &meson_pwm_ops;
 
-	meson->data = of_device_get_match_data(&pdev->dev);
+	meson->data = pdata;
 
 	err = meson->data->channels_init(chip);
 	if (err < 0)

-- 
2.52.0



