Return-Path: <linux-pwm+bounces-5904-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB70AB374A
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FAE3AAE8E
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B573294A1D;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kC65T2hb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA752949E4;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=Zmw784xZCcGOHczPZ64degQlxDiuKv8wYTWWjSFClSqXqFcatC13ugWc0Aforsnb1aMsllRlwbIBdj9Q3u5gofgsJMkC/uONarAb1bIOSPE+0jnUBbLksCBgD9qHfVlBAz3mvTdL5Cd4c354OO9gNNlQ2fbUXrwHX8jx6lD1c74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=9NtJ1OM/RBDf5xD9xkAzuK0El/NoUXY50YBZSG9zebo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ha//yke6Y/G16wqARY+ex226BeYre5ikMryguqVKUIrIifwVN4DjqTLTWeSvnaKQcR5XUz+4mUsjLBvk/iXEfRBZ9FNgmInwcQokK6Nt8NlzlN8bZxjO/h5zPVRJHC/AMAHClop0k3CLbg5jIdyWVAvebdW1W48CIPnu0O3cZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kC65T2hb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B312C19423;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053539;
	bh=9NtJ1OM/RBDf5xD9xkAzuK0El/NoUXY50YBZSG9zebo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=kC65T2hbEmncqhvHi5Cd8GI19dsLr7iAWC4DKH1o0Ek29uEroSAGUt4QaI/GO4Xjn
	 e05eUhaihrUwu5BlPW/lLU5Z0e76Mq5R7hjrusnydj2tZx46m4TjzGpwY5lvRlVGRo
	 iN8wPmVSJ4bdPi6jifpPNa34rjx3BcrTLrmdo5gQqr2Jumb5muxI1B1CpwoW1da93R
	 A0wtN/5j5V1agXFoIZhkYMeUdKXdJ/d/ozI/JmXD8Lnlxfg6OLnyAatTP4Pt6rE8Uk
	 GkTrbio1jWIusEni0BvzFFAt1gGm9oraFV8biza1Nfoh0oxH6ir0nPIAxTVWeLKMa+
	 +x5SzK0q0pX1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A42C3ABD4;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:39:03 +0100
Subject: [PATCH v3 11/22] pwm: adp5585: add support for adp5589
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-11-092b14b79a88@analog.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
In-Reply-To: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
To: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=7020;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KlGAehF34LobsBKL0q/Km/3DXgTA81XFT2l80j9Lur0=;
 b=cdP/fcR7X81vTRuFtklSwqSJh/8Vu/1tMW4R+ilWk6MtAoGdAxP8TkbV2pIyxPdcDdeXSATSE
 DqcPGa2R0UaCkC1b6CPiKdx78+PFjLD2UB27Gtty+DVQnXxFivoxyvY
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Add support for the adp5589 I/O expander. From a PWM point of view it is
pretty similar to adp5585. Main difference is the address
of registers meaningful for configuring the PWM.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/pwm/pwm-adp5585.c   | 73 ++++++++++++++++++++++++++++++++++-----------
 include/linux/mfd/adp5585.h |  3 ++
 2 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
index c8821035b7c1412a55a642e6e8a46b66e693a5af..f26054c19c2e154d05780af09aee1b2431eba2eb 100644
--- a/drivers/pwm/pwm-adp5585.c
+++ b/drivers/pwm/pwm-adp5585.c
@@ -32,21 +32,33 @@
 #define ADP5585_PWM_MIN_PERIOD_NS	(2ULL * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
 #define ADP5585_PWM_MAX_PERIOD_NS	(2ULL * 0xffff * NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ)
 
+struct adp5585_pwm_chip {
+	unsigned int pwm_cfg;
+	unsigned int pwm_offt_low;
+	unsigned int pwm_ont_low;
+};
+
+struct adp5585_pwm {
+	const struct adp5585_pwm_chip *info;
+	struct regmap *regmap;
+	unsigned int ext_cfg;
+};
+
 static int pwm_adp5585_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct regmap *regmap = pwmchip_get_drvdata(chip);
+	struct adp5585_pwm *adp5585_pwm = pwmchip_get_drvdata(chip);
 
 	/* Configure the R3 pin as PWM output. */
-	return regmap_update_bits(regmap, ADP5585_PIN_CONFIG_C,
+	return regmap_update_bits(adp5585_pwm->regmap, adp5585_pwm->ext_cfg,
 				  ADP5585_R3_EXTEND_CFG_MASK,
 				  ADP5585_R3_EXTEND_CFG_PWM_OUT);
 }
 
 static void pwm_adp5585_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct regmap *regmap = pwmchip_get_drvdata(chip);
+	struct adp5585_pwm *adp5585_pwm = pwmchip_get_drvdata(chip);
 
-	regmap_update_bits(regmap, ADP5585_PIN_CONFIG_C,
+	regmap_update_bits(adp5585_pwm->regmap, adp5585_pwm->ext_cfg,
 			   ADP5585_R3_EXTEND_CFG_MASK,
 			   ADP5585_R3_EXTEND_CFG_GPIO4);
 }
@@ -55,14 +67,16 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
 			     struct pwm_device *pwm,
 			     const struct pwm_state *state)
 {
-	struct regmap *regmap = pwmchip_get_drvdata(chip);
+	struct adp5585_pwm *adp5585_pwm = pwmchip_get_drvdata(chip);
+	const struct adp5585_pwm_chip *info = adp5585_pwm->info;
+	struct regmap *regmap = adp5585_pwm->regmap;
 	u64 period, duty_cycle;
 	u32 on, off;
 	__le16 val;
 	int ret;
 
 	if (!state->enabled) {
-		regmap_clear_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
+		regmap_clear_bits(regmap, info->pwm_cfg, ADP5585_PWM_EN);
 		return 0;
 	}
 
@@ -83,41 +97,43 @@ static int pwm_adp5585_apply(struct pwm_chip *chip,
 	off = div_u64(period, NSEC_PER_SEC / ADP5585_PWM_OSC_FREQ_HZ) - on;
 
 	val = cpu_to_le16(off);
-	ret = regmap_bulk_write(regmap, ADP5585_PWM_OFFT_LOW, &val, 2);
+	ret = regmap_bulk_write(regmap, info->pwm_offt_low, &val, 2);
 	if (ret)
 		return ret;
 
 	val = cpu_to_le16(on);
-	ret = regmap_bulk_write(regmap, ADP5585_PWM_ONT_LOW, &val, 2);
+	ret = regmap_bulk_write(regmap, info->pwm_ont_low, &val, 2);
 	if (ret)
 		return ret;
 
 	/* Enable PWM in continuous mode and no external AND'ing. */
-	ret = regmap_update_bits(regmap, ADP5585_PWM_CFG,
+	ret = regmap_update_bits(regmap, info->pwm_cfg,
 				 ADP5585_PWM_IN_AND | ADP5585_PWM_MODE |
 				 ADP5585_PWM_EN, ADP5585_PWM_EN);
 	if (ret)
 		return ret;
 
-	return regmap_set_bits(regmap, ADP5585_PWM_CFG, ADP5585_PWM_EN);
+	return regmap_set_bits(regmap, info->pwm_cfg, ADP5585_PWM_EN);
 }
 
 static int pwm_adp5585_get_state(struct pwm_chip *chip,
 				 struct pwm_device *pwm,
 				 struct pwm_state *state)
 {
-	struct regmap *regmap = pwmchip_get_drvdata(chip);
+	struct adp5585_pwm *adp5585_pwm = pwmchip_get_drvdata(chip);
+	const struct adp5585_pwm_chip *info = adp5585_pwm->info;
+	struct regmap *regmap = adp5585_pwm->regmap;
 	unsigned int on, off;
 	unsigned int val;
 	__le16 on_off;
 	int ret;
 
-	ret = regmap_bulk_read(regmap, ADP5585_PWM_OFFT_LOW, &on_off, 2);
+	ret = regmap_bulk_read(regmap, info->pwm_offt_low, &on_off, 2);
 	if (ret)
 		return ret;
 	off = le16_to_cpu(on_off);
 
-	ret = regmap_bulk_read(regmap, ADP5585_PWM_ONT_LOW, &on_off, 2);
+	ret = regmap_bulk_read(regmap, info->pwm_ont_low, &on_off, 2);
 	if (ret)
 		return ret;
 	on = le16_to_cpu(on_off);
@@ -127,7 +143,7 @@ static int pwm_adp5585_get_state(struct pwm_chip *chip,
 
 	state->polarity = PWM_POLARITY_NORMAL;
 
-	regmap_read(regmap, ADP5585_PWM_CFG, &val);
+	regmap_read(regmap, info->pwm_cfg, &val);
 	state->enabled = !!(val & ADP5585_PWM_EN);
 
 	return 0;
@@ -142,18 +158,28 @@ static const struct pwm_ops adp5585_pwm_ops = {
 
 static int adp5585_pwm_probe(struct platform_device *pdev)
 {
+	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct device *dev = &pdev->dev;
 	struct adp5585_dev *adp5585 = dev_get_drvdata(dev->parent);
+	struct adp5585_pwm *adp5585_pwm;
 	struct pwm_chip *chip;
 	int ret;
 
-	chip = devm_pwmchip_alloc(dev, ADP5585_PWM_CHAN_NUM, 0);
+	chip = devm_pwmchip_alloc(dev, ADP5585_PWM_CHAN_NUM,
+				  sizeof(*adp5585_pwm));
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
 
+	adp5585_pwm = pwmchip_get_drvdata(chip);
+	adp5585_pwm->regmap = adp5585->regmap;
+	adp5585_pwm->ext_cfg = adp5585->info->regs->ext_cfg;
+
+	adp5585_pwm->info = (const struct adp5585_pwm_chip *)id->driver_data;
+	if (!adp5585_pwm->info)
+		return -ENODEV;
+
 	device_set_of_node_from_dev(dev, dev->parent);
 
-	pwmchip_set_drvdata(chip, adp5585->regmap);
 	chip->ops = &adp5585_pwm_ops;
 
 	ret = devm_pwmchip_add(dev, chip);
@@ -163,8 +189,21 @@ static int adp5585_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct adp5585_pwm_chip adp5589_pwm_chip_info = {
+	.pwm_cfg = ADP5585_PWM_CFG,
+	.pwm_offt_low = ADP5585_PWM_OFFT_LOW,
+	.pwm_ont_low = ADP5585_PWM_ONT_LOW,
+};
+
+static const struct adp5585_pwm_chip adp5585_pwm_chip_info = {
+	.pwm_cfg = ADP5589_PWM_CFG,
+	.pwm_offt_low = ADP5589_PWM_OFFT_LOW,
+	.pwm_ont_low = ADP5589_PWM_ONT_LOW,
+};
+
 static const struct platform_device_id adp5585_pwm_id_table[] = {
-	{ "adp5585-pwm" },
+	{ "adp5585-pwm", (kernel_ulong_t)&adp5585_pwm_chip_info },
+	{ "adp5589-pwm", (kernel_ulong_t)&adp5589_pwm_chip_info },
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(platform, adp5585_pwm_id_table);
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index 7865943e71ed17d63c1b9f30001bb93ab3aa6684..9a925a91c772722db559c9ec8ae334b2159ede79 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -118,6 +118,9 @@
 #define ADP5589_GPO_DATA_OUT_A		0x2a
 #define ADP5589_GPO_OUT_MODE_A		0x2d
 #define	ADP5589_GPIO_DIRECTION_A	0x30
+#define ADP5589_PWM_OFFT_LOW		0x3e
+#define ADP5589_PWM_ONT_LOW		0x40
+#define ADP5589_PWM_CFG			0x42
 #define ADP5589_PIN_CONFIG_D		0x4C
 #define ADP5589_INT_EN			0x4e
 #define ADP5589_MAX_REG			ADP5589_INT_EN

-- 
2.49.0



