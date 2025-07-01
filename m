Return-Path: <linux-pwm+bounces-6651-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFEFAEFC79
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 16:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8543516519D
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 14:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7BD278E6A;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfl3FMmX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80042277CAE;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380311; cv=none; b=TByC8eCJ9v2bIseIyvJgwoOHjE9AHzSvD+xFvKxMp0GHa5SEH829exVtgwGL+ZKWiWYGeh37FJefyEskW1Lh6l9B8ngpvE40HVbQFbrTDKPPX2qNZNpkDhhGEcLuT/wN/AMYm6HCHROyfVvULyfSC8gUQahTbh+pVVr9lbzNrfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380311; c=relaxed/simple;
	bh=XIYWDHMrJMIcGc2z2tYDWEeapBLwE9aBSHs3eLJOfGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vll905id6dXNGryu+FYF46iTxzgWdOjli1KeoreYzaraRDy9e4sXNl8d5G/vJa/zHN54ktlDB7Orpq2Kv91VFPwmQqeWq+IFybThyL0InpQkTPKxX+e1eXcCUnMq+yRO62zfMUXK/Q8x2cIcqT5ckRGPdCGPTpKXbbmSGJj44Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfl3FMmX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2601EC4CEFD;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751380311;
	bh=XIYWDHMrJMIcGc2z2tYDWEeapBLwE9aBSHs3eLJOfGM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jfl3FMmXZ4/0UQmWRlfVWBMrIB+4tlTCfPE4MO1Yksc4nbCBPMUQMMTgAx9riie7O
	 0bHnGjWEsUWJr0CKF//gTKfowQ1S8arzbCF+PkqbkXJ398f/YG0D4GZ1tTCx2Vo8FP
	 pHOQMizpnLuxhGnXQfZ6xB8a3DNuZpyedMdqv/3sBArlMT9H+2N2+sXDTbpd7+b6tE
	 2Uvix9c+9yS2s9BcZtpf4KIycvTzANiTNQsDQBO4MgDL1RTVtlruyJ+23VsQrpSqQ0
	 6jG3ZC/YmGIBxlHBEHeKqzyRmXQ6RN+GJHy7M8BG+BTrwYTyNmxAeaUfA6pM3dyfW/
	 zdr/VwXI6p5/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE47C7EE30;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 01 Jul 2025 15:32:05 +0100
Subject: [PATCH v7 10/20] pwm: adp5585: add support for adp5589
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-dev-adp5589-fw-v7-10-b1fcfe9e9826@analog.com>
References: <20250701-dev-adp5589-fw-v7-0-b1fcfe9e9826@analog.com>
In-Reply-To: <20250701-dev-adp5589-fw-v7-0-b1fcfe9e9826@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751380320; l=7066;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=KuRHbVmO1SuSI8rNZ3bXgb/zNm0dDfhMaJxWnBHc7wA=;
 b=QrWGiSrAqcUl+knQrNCeq03usWeHNGPjTNArq9N4lUARfMyfxh3Bm5+Y8t5oNWWNOVdVk/x9/
 xtoochG4DdAA0N0ds9WtZ6WnVLZ6+oztSw2in2PwWnixML/qPIKVYy0
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

Acked-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/pwm/pwm-adp5585.c   | 73 ++++++++++++++++++++++++++++++++++-----------
 include/linux/mfd/adp5585.h |  3 ++
 2 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
index c8821035b7c1412a55a642e6e8a46b66e693a5af..58f83f16134c0bb66f5a20c041622bf4e3905668 100644
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
+	adp5585_pwm->ext_cfg = adp5585->regs->ext_cfg;
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
index d26f722cf31af5416eefecab5e542e66b01321f6..77f7c74f084dde01e11816fb7ed099721b6ed78d 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -118,6 +118,9 @@
 #define ADP5589_GPO_DATA_OUT_A		0x2a
 #define ADP5589_GPO_OUT_MODE_A		0x2d
 #define		ADP5589_GPIO_DIRECTION_A	0x30
+#define ADP5589_PWM_OFFT_LOW		0x3e
+#define ADP5589_PWM_ONT_LOW		0x40
+#define ADP5589_PWM_CFG			0x42
 #define ADP5589_PIN_CONFIG_D		0x4C
 #define ADP5589_INT_EN			0x4e
 #define ADP5589_MAX_REG			ADP5589_INT_EN

-- 
2.50.0



