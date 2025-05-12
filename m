Return-Path: <linux-pwm+bounces-5909-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5922AB375A
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 368BF3AB4CB
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54372951D3;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWeEb2+S"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1BC294A0B;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=QB987qKIZ8F+78+PWZFX2n3xhwiSH9kRiTVl/QGjygRmKvWTCED4nXrnQ9VVZaLN3tn2U7BNp8LE2PbQEObupFAEtJdMNclbmqDhcPbtwrz7IJd5XYTKEm14g/0gfIP+9fohxr72xEf6rsRoQSVl5b2AHQSOJSY9PrsGvKD7pdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=Vl9re9iQ0dh49TQWZt/GBIgrhlsK4g3NrFcFQyfj31M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+D33DeYXzabDUzrT9gYkveRkrXvaC/OVfTQzgsclvLd4US59xjJTPQcmblPdDkw3uKxjRAXvhqqA+xR12hfmIhGLpBmSLa8vzGtRMyvkj3USwD2iT0rBChlsctzvlFIbV2bMMhquVf0Qgd0NEr0fzEn9aUhfuS43R0ZbnlRUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWeEb2+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 414AEC4CEF4;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053539;
	bh=Vl9re9iQ0dh49TQWZt/GBIgrhlsK4g3NrFcFQyfj31M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JWeEb2+SQC4aLc8CBi8ZUsk1C3rCxIkCI/+VcErA4JMgiNzDFwbQxYs2hJHbLtPGk
	 tiCFBa8g0bqWutcibdQigBFn/aFKaRkUzyBqfmRVFaupjKeaDJVnVxZ3bA9rK9qL1h
	 4vRLqVSxOMGqJn3LDlfTEBQYG/Hr0yc1lAmUFhG3Qk6yzH+V4B6cPmy8Et0iollb6U
	 dMhzhoXgEiV9dW8fUNH936F4G6luFRN0vlXq8ATBQjet2kew/iqa6Yp6nM9QwDLi9h
	 SLFCIDkf+MTrpsMty6jgfWS93Un7KHDX3RyND5IM/mRV06eM66WnU3nA8YipjI+hMJ
	 U2Iu9UfCTbEFw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3876EC3ABD5;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:39:07 +0100
Subject: [PATCH v3 15/22] mfd: adp5585: add support for input devices
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-15-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=7419;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Acf/SFtJuCm4ngLcUnCyKGNGIisJrBnN19rrm+oyrU0=;
 b=mhkzc6Rt+yTCopbOJmtn5MJ/e6npN/uIGbWyMRmJOntWnaKZNDaJ0i45bTOUUkO9PyrL4JYpt
 Wucb3Q7wuNuCEHpHgGC3r4otbN474MzrMY5wB5SpvF0FgnSE+7eCI9A
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
 drivers/mfd/adp5585.c       | 38 +++++++++++++++++++++++++++++++++-----
 include/linux/mfd/adp5585.h | 11 +++++++++++
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index b1227a390fe2f932ba8060b0d722f53f45ec3b4b..5a4a24593a83271e8a8df40022b73dfa9c15a114 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -21,17 +21,20 @@
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
@@ -160,6 +163,7 @@ static const struct adp5585_regs adp5585_regs = {
 	.reset_cfg = ADP5585_RESET_CFG,
 	.reset1_event_a = ADP5585_RESET1_EVENT_A,
 	.reset2_event_a = ADP5585_RESET2_EVENT_A,
+	.pin_cfg_a = ADP5585_PIN_CONFIG_A,
 };
 
 static const struct adp5585_regs adp5589_regs = {
@@ -170,6 +174,7 @@ static const struct adp5585_regs adp5589_regs = {
 	.reset_cfg = ADP5589_RESET_CFG,
 	.reset1_event_a = ADP5589_RESET1_EVENT_A,
 	.reset2_event_a = ADP5589_RESET2_EVENT_A,
+	.pin_cfg_a = ADP5589_PIN_CONFIG_A,
 };
 
 static int adp5585_validate_event(const struct adp5585_dev *adp5585,
@@ -228,12 +233,16 @@ static int adp5585_fill_chip_configs(struct adp5585_dev *adp5585,
 		*regmap_config = adp5585_regmap_config_template;
 		info->regs = &adp5585_regs;
 		info->validate_event = adp5585_validate_event;
+		info->n_pins = ADP5585_PIN_MAX;
+		info->reset2_out = ADP5585_RESET2_OUT;
 		break;
 	case ADP5589_MAN_ID_VALUE:
 		*regmap_config = adp5589_regmap_config_template;
 		info->regs = &adp5589_regs;
 		info->validate_event = adp5589_validate_event;
 		info->has_unlock = true;
+		info->n_pins = ADP5589_PIN_MAX;
+		info->reset2_out = ADP5589_RESET2_OUT;
 		break;
 	default:
 		return -ENODEV;
@@ -431,7 +440,7 @@ static int adp5585_reset_ev_parse(struct adp5585_dev *adp5585, bool has_pin5)
 static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
 			    struct mfd_cell **devs)
 {
-	unsigned int has_pwm = 0, has_gpio = 0, rc = 0;
+	unsigned int has_pwm = 0, has_gpio = 0, has_input = 0, rc = 0;
 	const struct mfd_cell *cells;
 	bool has_pin5 = false;
 	unsigned int prop_val;
@@ -443,11 +452,16 @@ static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
 	if (device_property_present(dev, "#gpio-cells"))
 		has_gpio = 1;
 
-	if (!has_pwm && !has_gpio)
+	if (device_property_present(dev, "adi,keypad-pins"))
+		has_input = 1;
+
+	if (!has_pwm && !has_gpio && !has_input)
 		return -ENODEV;
 
 	if (!device_property_present(dev, "gpio-reserved-ranges"))
 		has_pin5 = true;
+	else
+		__set_bit(5, adp5585->pin_usage);
 
 	ret = adp5585_unlock_ev_parse(adp5585, has_pin5);
 	if (ret)
@@ -476,8 +490,8 @@ static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
 		}
 	}
 
-	*devs = devm_kcalloc(dev, has_pwm + has_gpio, sizeof(struct mfd_cell),
-			     GFP_KERNEL);
+	*devs = devm_kcalloc(dev, has_pwm + has_gpio + has_input,
+			     sizeof(struct mfd_cell), GFP_KERNEL);
 	if (!*devs)
 		return -ENOMEM;
 
@@ -486,10 +500,14 @@ static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
 	else
 		cells = adp5589_devs;
 
-	if (has_pwm)
+	if (has_pwm) {
+		__set_bit(ADP5585_PWM_OUT, adp5585->pin_usage);
 		(*devs)[rc++] = cells[ADP5585_DEV_PWM];
+	}
 	if (has_gpio)
 		(*devs)[rc++] = cells[ADP5585_DEV_GPIO];
+	if (has_input)
+		(*devs)[rc++] = cells[ADP5585_DEV_INPUT];
 
 	return rc;
 }
@@ -594,6 +612,9 @@ static int adp5585_setup(struct adp5585_dev *adp5585)
 				   adp5585->reset1_keys[i] | ADP5585_RESET_EV_PRESS);
 		if (ret)
 			return ret;
+
+		/* mark that pin as not usable for the input and gpio devices */
+		__set_bit(ADP5585_RESET1_OUT, adp5585->pin_usage);
 	}
 
 	for (i = 0; i < adp5585->nkeys_reset2; i++) {
@@ -601,6 +622,8 @@ static int adp5585_setup(struct adp5585_dev *adp5585)
 				   adp5585->reset2_keys[i] | ADP5585_RESET_EV_PRESS);
 		if (ret)
 			return ret;
+
+		__set_bit(adp5585->info->reset2_out, adp5585->pin_usage);
 	}
 
 	if (adp5585->nkeys_reset1 || adp5585->nkeys_reset2) {
@@ -721,6 +744,11 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 	adp5585->irq = i2c->irq;
 	INIT_LIST_HEAD(&adp5585->ev_handlers);
 
+	adp5585->pin_usage = devm_bitmap_zalloc(&i2c->dev, adp5585->info->n_pins,
+						GFP_KERNEL);
+	if (!adp5585->pin_usage)
+		return -ENOMEM;
+
 	n_devs = adp5585_parse_fw(&i2c->dev, adp5585, &devs);
 	if (n_devs < 0)
 		return n_devs;
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index 034b7c18af83b1e801860ed4fca1755ff59faed1..1cec7f72781999ae81e179c7eefd4539de59bc97 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -129,12 +129,17 @@
 #define ADP5585_GPI_EVENT_END		47
 #define ADP5585_ROW5_KEY_EVENT_START	1
 #define ADP5585_ROW5_KEY_EVENT_END	30
+#define ADP5585_PWM_OUT			3
+#define ADP5585_RESET1_OUT		4
+#define ADP5585_RESET2_OUT		9
 
 /* ADP5589 */
 #define		ADP5589_MAN_ID_VALUE		0x10
 #define ADP5589_GPI_STATUS_A		0x16
 #define ADP5589_GPI_STATUS_C		0x18
 #define ADP5589_RPULL_CONFIG_A		0x19
+#define ADP5589_GPI_INT_LEVEL_A		0x1e
+#define ADP5589_GPI_EVENT_EN_A		0x21
 #define ADP5589_DEBOUNCE_DIS_A		0x27
 #define ADP5589_GPO_DATA_OUT_A		0x2a
 #define ADP5589_GPO_OUT_MODE_A		0x2d
@@ -157,6 +162,7 @@
 #define ADP5589_PWM_ONT_LOW		0x40
 #define ADP5589_PWM_CFG			0x42
 #define ADP5589_POLL_PTIME_CFG		0x48
+#define ADP5589_PIN_CONFIG_A		0x49
 #define ADP5589_PIN_CONFIG_D		0x4C
 #define ADP5589_GENERAL_CFG		0x4d
 #define ADP5589_INT_EN			0x4e
@@ -167,6 +173,7 @@
 #define ADP5589_KEY_EVENT_END		88
 #define ADP5589_GPI_EVENT_START		97
 #define ADP5589_GPI_EVENT_END		115
+#define ADP5589_RESET2_OUT		12
 
 struct regmap;
 struct adp5585_dev;
@@ -195,6 +202,7 @@ struct adp5585_regs {
 	unsigned int reset_cfg;
 	unsigned int reset1_event_a;
 	unsigned int reset2_event_a;
+	unsigned int pin_cfg_a;
 };
 
 struct adp5585_info {
@@ -203,6 +211,8 @@ struct adp5585_info {
 			      unsigned int ev, bool has_pin5);
 	enum adp5585_regmap_type regmap_type;
 	unsigned int id;
+	unsigned int n_pins;
+	unsigned int reset2_out;
 	bool has_unlock;
 };
 
@@ -210,6 +220,7 @@ struct adp5585_dev {
 	struct regmap *regmap;
 	struct device *dev;
 	const struct adp5585_info *info;
+	unsigned long *pin_usage;
 	/* Used to synchronize the availability of the event handlers */
 	struct mutex ev_lock;
 	struct list_head ev_handlers;

-- 
2.49.0



