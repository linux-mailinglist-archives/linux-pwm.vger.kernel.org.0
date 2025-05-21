Return-Path: <linux-pwm+bounces-6059-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05C3FABF575
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FEC3BF35D
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E2A27979B;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxKNfi3c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D33272E52;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832589; cv=none; b=DyBrCqwJe68zpNQNzJa8WNlBjJeukg0jdvHTmmuHdP4QWXbRGTaPp3FAMBGpTJOQOVJfhcwyFf90Luvq8aGO93nzdTwVpommQmu1gfhiB4Ia1mMsNXdno/RqD2dAgiV4XvmLc5y9ws2eAiWHME3PiLlUYYjmIpSvgdi0AhXCqcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832589; c=relaxed/simple;
	bh=bKCT48Y4GlHQdQqBr8cuoy7nQdhujG1RHp4SCPDCwNA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ijnx4dgwdoItv0J0rCNKMTmFuRssbYIoTZW+9URvK99mQjqpJKtBrZRniD2bRPIvKs6Q9IX2ayIrEHMuwM4XZc3Z8N4oF6WQH5l+/JIBBEGgdEDG1S6Xcf5FvTZqe6bdkLti7N83PxeBfP6RJdu/Pg30GKZty9ZzA86ix9hVjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxKNfi3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F00C1C4CEE7;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747832589;
	bh=bKCT48Y4GlHQdQqBr8cuoy7nQdhujG1RHp4SCPDCwNA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=RxKNfi3cay+6paZnXMw/mecBKv8tESvc3WeYNz+SfYjWz4Ti7/FURt+pxXKxIf6AQ
	 Zmd01w9uCpdAbmNvbZm+pBfjIVpBR01n4xY6KXxnQx/J7BOlbgMBUE+3pEr1/18+le
	 cfIxgW6CGWWJODHZmdyATgWqVlehY9wtThmlOm9G64gYPaFRYSjkX/oIbD2bTs/Mry
	 jNmNxo2J2svS2bz0RE2fvkvlEzzc1QtArnOenuELIHKsjukKauOw2714XoV0DEViCB
	 IPIHMA6UyVgYFsTZ8vf6K9xegyuImOroE1Y3h1NMmuEvT4hcKC79yMPbcM8x/SfekN
	 L9DCmIIKjz79A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE61C2D0CD;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 May 2025 14:03:04 +0100
Subject: [PATCH v4 14/20] mfd: adp5585: add support for input devices
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250521-dev-adp5589-fw-v4-14-f2c988d7a7a0@analog.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
In-Reply-To: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747832589; l=6594;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=+g+x2K4NYHOTQoq+ZDcyZTEiYactL3azIZM9vUKzZjs=;
 b=6dv5NadJw2O6aSIUoWFCcN96qV3xqUtingsXzK2L8amQ6cd1JIriTuRkQGk7ah+rDaWfYT15x
 tvMVftXlTqHAV7650BTxCGhW6t0XGLE/lbnpa0IKf7zBFXNLIqcYrzv
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The ADP558x family supports a built in keypad matrix decoder which can
be added as an Input device. In order to both support the Input and the
GPIO device, we need to create a bitmap of the supported pins and track
their usage since they can either be used as GPIOs (GPIs) or as part of
the keymap.

We also need to mark special pins busy in case some features are being
used (ex: pwm or reset events).

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c       | 33 +++++++++++++++++++++++++++++++++
 include/linux/mfd/adp5585.h |  9 +++++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 6737d622a7ed9f280c439399f3709ca8162dee01..122e2c95385f8d5cbd7839db78dda77ad7ba4ae4 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -22,17 +22,20 @@
 enum {
 	ADP5585_DEV_GPIO,
 	ADP5585_DEV_PWM,
+	ADP5585_DEV_INPUT,
 	ADP5585_DEV_MAX
 };
 
 static const struct mfd_cell adp5585_devs[ADP5585_DEV_MAX] = {
 	MFD_CELL_NAME("adp5585-gpio"),
 	MFD_CELL_NAME("adp5585-pwm"),
+	MFD_CELL_NAME("adp5585-keys"),
 };
 
 static const struct mfd_cell adp5589_devs[] = {
 	MFD_CELL_NAME("adp5589-gpio"),
 	MFD_CELL_NAME("adp5589-pwm"),
+	MFD_CELL_NAME("adp5589-keys"),
 };
 
 static const struct regmap_range adp5585_volatile_ranges[] = {
@@ -173,6 +176,7 @@ static const struct adp5585_regs adp5585_regs = {
 	.reset_cfg = ADP5585_RESET_CFG,
 	.reset1_event_a = ADP5585_RESET1_EVENT_A,
 	.reset2_event_a = ADP5585_RESET2_EVENT_A,
+	.pin_cfg_a = ADP5585_PIN_CONFIG_A,
 };
 
 static const struct adp5585_regs adp5589_regs = {
@@ -183,6 +187,7 @@ static const struct adp5585_regs adp5589_regs = {
 	.reset_cfg = ADP5589_RESET_CFG,
 	.reset1_event_a = ADP5589_RESET1_EVENT_A,
 	.reset2_event_a = ADP5589_RESET2_EVENT_A,
+	.pin_cfg_a = ADP5589_PIN_CONFIG_A,
 };
 
 static int adp5585_validate_event(const struct adp5585_dev *adp5585, unsigned int ev)
@@ -236,6 +241,8 @@ static int adp5585_fill_variant_config(struct adp5585_dev *adp5585,
 		*regmap_config = adp5585_regmap_config_template;
 		adp5585->id = ADP5585_MAN_ID_VALUE;
 		adp5585->regs = &adp5585_regs;
+		adp5585->n_pins = ADP5585_PIN_MAX;
+		adp5585->reset2_out = ADP5585_RESET2_OUT;
 		if (adp5585->variant == ADP5585_01)
 			adp5585->has_pin6 = true;
 		break;
@@ -247,6 +254,8 @@ static int adp5585_fill_variant_config(struct adp5585_dev *adp5585,
 		adp5585->regs = &adp5589_regs;
 		adp5585->has_unlock = true;
 		adp5585->has_pin6 = true;
+		adp5585->n_pins = ADP5589_PIN_MAX;
+		adp5585->reset2_out = ADP5589_RESET2_OUT;
 		break;
 	default:
 		return -ENODEV;
@@ -434,6 +443,8 @@ static int adp5585_add_devices(const struct adp5585_dev *adp5585)
 		cells = adp5589_devs;
 
 	if (device_property_present(adp5585->dev, "#pwm-cells")) {
+		/* Make sure the PWM output pin is not used by the GPIO or INPUT  devices */
+		__set_bit(ADP5585_PWM_OUT, adp5585->pin_usage);
 		ret = mfd_add_devices(adp5585->dev, PLATFORM_DEVID_AUTO,
 				      &cells[ADP5585_DEV_PWM], 1, NULL, 0, NULL);
 		if (ret)
@@ -449,6 +460,15 @@ static int adp5585_add_devices(const struct adp5585_dev *adp5585)
 		}
 	}
 
+	if (device_property_present(adp5585->dev, "adi,keypad-pins")) {
+		ret = mfd_add_devices(adp5585->dev, PLATFORM_DEVID_AUTO,
+				      &cells[ADP5585_DEV_INPUT], 1, NULL, 0, NULL);
+		if (ret) {
+			ret = dev_err_probe(adp5585->dev, ret, "Failed to add input device\n");
+			goto out_error;
+		}
+	}
+
 	return devm_add_action_or_reset(adp5585->dev, adp5585_remove_devices, adp5585->dev);
 out_error:
 	mfd_remove_devices(adp5585->dev);
@@ -518,6 +538,10 @@ static int adp5585_setup(struct adp5585_dev *adp5585)
 	unsigned int reg_val, i;
 	int ret;
 
+	/* if pin_6 (ROW5/GPI6) is not available, make sure to mark it as "busy" */
+	if (!adp5585->has_pin6)
+		__set_bit(5, adp5585->pin_usage);
+
 	/* Configure the device with reset and unlock events */
 	for (i = 0; i < adp5585->nkeys_unlock; i++) {
 		ret = regmap_write(adp5585->regmap, ADP5589_UNLOCK1 + i,
@@ -542,6 +566,9 @@ static int adp5585_setup(struct adp5585_dev *adp5585)
 				   adp5585->reset1_keys[i] | ADP5585_RESET_EV_PRESS);
 		if (ret)
 			return ret;
+
+		/* mark that pin as not usable for the input and gpio devices */
+		__set_bit(ADP5585_RESET1_OUT, adp5585->pin_usage);
 	}
 
 	for (i = 0; i < adp5585->nkeys_reset2; i++) {
@@ -549,6 +576,8 @@ static int adp5585_setup(struct adp5585_dev *adp5585)
 				   adp5585->reset2_keys[i] | ADP5585_RESET_EV_PRESS);
 		if (ret)
 			return ret;
+
+		__set_bit(adp5585->reset2_out, adp5585->pin_usage);
 	}
 
 	if (adp5585->nkeys_reset1 || adp5585->nkeys_reset2) {
@@ -703,6 +732,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
+	adp5585->pin_usage = devm_bitmap_zalloc(&i2c->dev, adp5585->n_pins, GFP_KERNEL);
+	if (!adp5585->pin_usage)
+		return -ENOMEM;
+
 	ret = adp5585_parse_fw(adp5585);
 	if (ret)
 		return ret;
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index 5a1de5ae4bb144ed49a03a4e9e93eb614abe9fa3..5aa042a30c6e9eb2736fb5ab91b505324168d7b5 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -126,6 +126,9 @@
 #define ADP5585_GPI_EVENT_END		47
 #define ADP5585_ROW5_KEY_EVENT_START	1
 #define ADP5585_ROW5_KEY_EVENT_END	30
+#define ADP5585_PWM_OUT			3
+#define ADP5585_RESET1_OUT		4
+#define ADP5585_RESET2_OUT		9
 
 /* ADP5589 */
 #define		ADP5589_MAN_ID_VALUE		0x10
@@ -154,6 +157,7 @@
 #define ADP5589_PWM_ONT_LOW		0x40
 #define ADP5589_PWM_CFG			0x42
 #define ADP5589_POLL_PTIME_CFG		0x48
+#define ADP5589_PIN_CONFIG_A		0x49
 #define ADP5589_PIN_CONFIG_D		0x4C
 #define ADP5589_GENERAL_CFG		0x4d
 #define ADP5589_INT_EN			0x4e
@@ -164,6 +168,7 @@
 #define ADP5589_KEY_EVENT_END		88
 #define ADP5589_GPI_EVENT_START		97
 #define ADP5589_GPI_EVENT_END		115
+#define ADP5589_RESET2_OUT		12
 
 struct regmap;
 
@@ -187,6 +192,7 @@ struct adp5585_regs {
 	unsigned int reset_cfg;
 	unsigned int reset1_event_a;
 	unsigned int reset2_event_a;
+	unsigned int pin_cfg_a;
 };
 
 struct adp5585_dev {
@@ -194,6 +200,9 @@ struct adp5585_dev {
 	struct regmap *regmap;
 	struct device *dev;
 	struct blocking_notifier_head event_notifier;
+	unsigned long *pin_usage;
+	unsigned int n_pins;
+	unsigned int reset2_out;
 	enum adp5585_variant variant;
 	unsigned int id;
 	bool has_unlock;

-- 
2.49.0



