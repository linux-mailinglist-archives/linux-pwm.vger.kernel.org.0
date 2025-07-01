Return-Path: <linux-pwm+bounces-6654-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B64CAEFC89
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 16:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E442E7A6EDA
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 14:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8E52797AF;
	Tue,  1 Jul 2025 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSsAMhla"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66C22749CF;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380311; cv=none; b=kZF2M4SWOrRwL8bAwIhwcNCdTGCFDHEsW369BqcXe3GiHy8Gx0iA3xoydVn1v9Zrqe67lXnz0ditPpFARwUCMH5X+Sm7v9xHBdOxOeVeNB6tKZB6PKaBd74Xc7TP8ivpD9iY+UM2OTtLE0siX1QjuqNNpKjf8ie9KmhYWLti6U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380311; c=relaxed/simple;
	bh=UA8ZRnneixw+HFszwl5T6ikg29x4Iqi1PbHF5yOpOgc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n/PD94nFZlzibkzAtmZ/hDX1CtCFq3IFRG8tndF0k6ZxUnBOvb1fAvmlP1z+AZ5hx/EtIhlQ3g9irIfUO4cG4bgl+jQADggVu0QloeXFGDuTm4egu04BMs7TQ07JXlqkOY5KnICkoUQXwJUlymo4esucqDukoRmXPvMIOa94LnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSsAMhla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C760C4CEEF;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751380311;
	bh=UA8ZRnneixw+HFszwl5T6ikg29x4Iqi1PbHF5yOpOgc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YSsAMhlaQTkSLa2HEniADnbJFszZvELWqa6b+dpE1oTSThuIL4JuhSVkoCC1fgkW/
	 nqfCZuG/Y4fvC6xS+kL2atAag23D+TgtTb29xyz5IX3ozBfjnF1exs/dHLNje7jr/K
	 TQTHtTaniQVdB7jZFmuMisxEXtm2PEgtisPoTFXwF/Ygxk0zYLH9fOcrXarBij8goC
	 TMpdxpl+d1XP8ryfs6VHARsusg030/W8LSb6pXKSA7gynI7qS28q0d35UOgjSc0llV
	 K8SBqgeWkDLHMuTPKtOhT0q1atoxxmztf5VoNSspFfBcUaL8b9IAUnT2nieeCV8hbd
	 cukIN1tOePecw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54993C7EE30;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 01 Jul 2025 15:32:09 +0100
Subject: [PATCH v7 14/20] mfd: adp5585: Add support for input devices
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-dev-adp5589-fw-v7-14-b1fcfe9e9826@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751380320; l=6706;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=IPhMnQj3mFzEobuEj1rJnJkmDQmlygfVu3q3tyD8Axw=;
 b=QO15WiPiLotzORqZECFtra0Z1KLsNsUBVJ5zaSVPuUDDWDCaSEeA5wVaGkKQKX3FyrJ/ydkL7
 rysY0SnomSNAG1GwRKpUHGU0XLZw9QvTn7oTgvPIyCp3uyhJu6m6bH6
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
 drivers/mfd/adp5585.c       | 31 +++++++++++++++++++++++++++++++
 include/linux/mfd/adp5585.h | 10 ++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 30014deee41fa9d0b0f663dccd2ecb24af999376..8f0fd737442611e00e61ea992dd6437dbaf31292 100644
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
@@ -172,6 +175,7 @@ static const struct adp5585_regs adp5585_regs = {
 	.reset_cfg = ADP5585_RESET_CFG,
 	.reset1_event_a = ADP5585_RESET1_EVENT_A,
 	.reset2_event_a = ADP5585_RESET2_EVENT_A,
+	.pin_cfg_a = ADP5585_PIN_CONFIG_A,
 };
 
 static const struct adp5585_regs adp5589_regs = {
@@ -182,6 +186,7 @@ static const struct adp5585_regs adp5589_regs = {
 	.reset_cfg = ADP5589_RESET_CFG,
 	.reset1_event_a = ADP5589_RESET1_EVENT_A,
 	.reset2_event_a = ADP5589_RESET2_EVENT_A,
+	.pin_cfg_a = ADP5589_PIN_CONFIG_A,
 };
 
 static int adp5585_validate_event(const struct adp5585_dev *adp5585, unsigned int ev)
@@ -239,6 +244,8 @@ static struct regmap_config *adp5585_fill_variant_config(struct adp5585_dev *adp
 	case ADP5585_04:
 		adp5585->id = ADP5585_MAN_ID_VALUE;
 		adp5585->regs = &adp5585_regs;
+		adp5585->n_pins = ADP5585_PIN_MAX;
+		adp5585->reset2_out = ADP5585_RESET2_OUT;
 		if (adp5585->variant == ADP5585_01)
 			adp5585->has_pin6 = true;
 		regmap_config = devm_kmemdup(adp5585->dev, &adp5585_regmap_config_template,
@@ -251,6 +258,8 @@ static struct regmap_config *adp5585_fill_variant_config(struct adp5585_dev *adp
 		adp5585->regs = &adp5589_regs;
 		adp5585->has_unlock = true;
 		adp5585->has_pin6 = true;
+		adp5585->n_pins = ADP5589_PIN_MAX;
+		adp5585->reset2_out = ADP5589_RESET2_OUT;
 		regmap_config = devm_kmemdup(adp5585->dev, &adp5589_regmap_config_template,
 					     sizeof(*regmap_config), GFP_KERNEL);
 		break;
@@ -439,6 +448,8 @@ static int adp5585_add_devices(const struct adp5585_dev *adp5585)
 		cells = adp5589_devs;
 
 	if (device_property_present(dev, "#pwm-cells")) {
+		/* Make sure the PWM output pin is not used by the GPIO or INPUT devices */
+		__set_bit(ADP5585_PWM_OUT, adp5585->pin_usage);
 		ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO,
 					   &cells[ADP5585_DEV_PWM], 1, NULL, 0, NULL);
 		if (ret)
@@ -452,6 +463,13 @@ static int adp5585_add_devices(const struct adp5585_dev *adp5585)
 			return dev_err_probe(dev, ret, "Failed to add GPIO device\n");
 	}
 
+	if (device_property_present(adp5585->dev, "adi,keypad-pins")) {
+		ret = devm_mfd_add_devices(adp5585->dev, PLATFORM_DEVID_AUTO,
+					   &cells[ADP5585_DEV_INPUT], 1, NULL, 0, NULL);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to add input device\n");
+	}
+
 	return 0;
 }
 
@@ -518,6 +536,10 @@ static int adp5585_setup(struct adp5585_dev *adp5585)
 	unsigned int reg_val = 0, i;
 	int ret;
 
+	/* If pin_6 (ROW5/GPI6) is not available, make sure to mark it as "busy" */
+	if (!adp5585->has_pin6)
+		__set_bit(ADP5585_ROW5, adp5585->pin_usage);
+
 	/* Configure the device with reset and unlock events */
 	for (i = 0; i < adp5585->nkeys_unlock; i++) {
 		ret = regmap_write(adp5585->regmap, ADP5589_UNLOCK1 + i,
@@ -542,6 +564,9 @@ static int adp5585_setup(struct adp5585_dev *adp5585)
 				   adp5585->reset1_keys[i] | ADP5585_RESET_EV_PRESS);
 		if (ret)
 			return ret;
+
+		/* Mark that pin as not usable for the INPUT and GPIO devices. */
+		__set_bit(ADP5585_RESET1_OUT, adp5585->pin_usage);
 	}
 
 	for (i = 0; i < adp5585->nkeys_reset2; i++) {
@@ -549,6 +574,8 @@ static int adp5585_setup(struct adp5585_dev *adp5585)
 				   adp5585->reset2_keys[i] | ADP5585_RESET_EV_PRESS);
 		if (ret)
 			return ret;
+
+		__set_bit(adp5585->reset2_out, adp5585->pin_usage);
 	}
 
 	if (adp5585->nkeys_reset1 || adp5585->nkeys_reset2) {
@@ -697,6 +724,10 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
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
index db483ef9693a41d29a36910952e7a0bc54f86631..41c5d2e1cc7ca40aa5192296ecc5ff8d737cb3e6 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -126,6 +126,10 @@
 #define ADP5585_GPI_EVENT_END		47
 #define ADP5585_ROW5_KEY_EVENT_START	1
 #define ADP5585_ROW5_KEY_EVENT_END	30
+#define ADP5585_PWM_OUT			3
+#define ADP5585_RESET1_OUT		4
+#define ADP5585_RESET2_OUT		9
+#define ADP5585_ROW5			5
 
 /* ADP5589 */
 #define		ADP5589_MAN_ID_VALUE		0x10
@@ -154,6 +158,7 @@
 #define ADP5589_PWM_ONT_LOW		0x40
 #define ADP5589_PWM_CFG			0x42
 #define ADP5589_POLL_PTIME_CFG		0x48
+#define ADP5589_PIN_CONFIG_A		0x49
 #define ADP5589_PIN_CONFIG_D		0x4C
 #define ADP5589_GENERAL_CFG		0x4d
 #define ADP5589_INT_EN			0x4e
@@ -165,6 +170,7 @@
 #define ADP5589_GPI_EVENT_START		97
 #define ADP5589_GPI_EVENT_END		115
 #define ADP5589_UNLOCK_WILDCARD		127
+#define ADP5589_RESET2_OUT		12
 
 struct regmap;
 
@@ -188,6 +194,7 @@ struct adp5585_regs {
 	unsigned int reset_cfg;
 	unsigned int reset1_event_a;
 	unsigned int reset2_event_a;
+	unsigned int pin_cfg_a;
 };
 
 struct adp5585_dev {
@@ -195,6 +202,9 @@ struct adp5585_dev {
 	struct regmap *regmap;
 	const struct adp5585_regs *regs;
 	struct blocking_notifier_head event_notifier;
+	unsigned long *pin_usage;
+	unsigned int n_pins;
+	unsigned int reset2_out;
 	enum adp5585_variant variant;
 	unsigned int id;
 	bool has_unlock;

-- 
2.50.0



