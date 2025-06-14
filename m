Return-Path: <linux-pwm+bounces-6361-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38BAAD9DB0
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 16:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7941795D8
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 14:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935862E173E;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+vd4bvN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CA92E339B;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749911831; cv=none; b=IzpbfP5yCHIymP/BvWwfYf4hO8ikBZXjsn/UA65fk5Jq0/qyjmGX6sXhck61B0DIW0DFSd+9O7eM/Rz3g1Dy3BPJRI7mAT2a98FwXTwJucGcEH+/lMtuSEIKTAV5lrQwj3Fytbz9JLJbkRPj2yyI0nEe3VdzcqDSuxn5cH59xIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749911831; c=relaxed/simple;
	bh=HjR7/A4umUR2JstMAv+QZ9jqSoHwy9RvO68ibPU/2XI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mau7WhHTycSIpCdO+2zmLs+Q/xNOFXa/ENsvYTehw/Esn4/eQiAqXyHk96UqyuFQWMcl81s+e1u2rsSNjujFl5H/pso//vy1fsw2CCHSzBJP3uwL3NVUTNnQuuw5pCzBjVMaQiXRvR419sPYKWAqmUVgd5H6kbJ6b31lXVLoKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+vd4bvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 077B6C4AF54;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749911831;
	bh=HjR7/A4umUR2JstMAv+QZ9jqSoHwy9RvO68ibPU/2XI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g+vd4bvNbres7DuVIelWyegQYoPSSHtMPT2MmKT195GndIuwWb9WU99NgXN4c3HKa
	 TpLEfuWO86OkBDh/0SNVVHLy8nqqNI8EbqI7qzYp/s02hC6OcSkblviM4/pMnvrQpi
	 D9H/S0M1bTgjYdjq8H6v2y/cRcaUPvorSg3chGRDtB1roa54hedN3zp9Ot+MrzIHiL
	 DfdYiIBRdI/2Ftge++W4eOb148NNlhNR8r2YQ5LQc2EMwF8yvpxXi98MISn7oQ6XYV
	 8p5C8C0kTnl2HJ9oR/++k+bNonDvNr2pkWK6X7oNjY3u2X8m6VXPaDpKj+ayBlif4p
	 TgaKafwrr08gA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B3BC71153;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Sat, 14 Jun 2025 15:36:04 +0100
Subject: [PATCH v5 13/20] mfd: adp5585: support reset and unlock events
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250614-dev-adp5589-fw-v5-13-7e9d84906268@analog.com>
References: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
In-Reply-To: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749911835; l=14261;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=7sG5KRYWUQHFQTanRwpbSjYD1k9huJJ8Le8352zZpmw=;
 b=WgOUg4hUa+IuBJkub+Mev9Utyz/LU9YAeEhDOROTIGAw4NPV/JVrLqzbHTMuPf7frF5+ekW8P
 Tt/EsKd6QGtA+mhLOYrYZzv/emy3qLRffNCpYq6xzI8cDrXqstXAxoZ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

The ADP558x family of devices can be programmed to respond to some
especial events, In case of the unlock events, one can lock the keypad
and use KEYS or GPIs events to unlock it. For the reset events, one can
again use a combinations of GPIs/KEYs in order to generate an event that
will trigger the device to generate an output reset pulse.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c       | 274 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/adp5585.h |  40 +++++++
 2 files changed, 312 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index b70b0b86de7129fad0d38a3e2fdf96d2db1c8d0e..08ed35fbf7d39e16295d610cd995551b8e503132 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -170,6 +170,9 @@ static const struct adp5585_regs adp5585_regs = {
 	.int_en = ADP5585_INT_EN,
 	.gen_cfg = ADP5585_GENERAL_CFG,
 	.poll_ptime_cfg = ADP5585_POLL_PTIME_CFG,
+	.reset_cfg = ADP5585_RESET_CFG,
+	.reset1_event_a = ADP5585_RESET1_EVENT_A,
+	.reset2_event_a = ADP5585_RESET2_EVENT_A,
 };
 
 static const struct adp5585_regs adp5589_regs = {
@@ -177,8 +180,54 @@ static const struct adp5585_regs adp5589_regs = {
 	.int_en = ADP5589_INT_EN,
 	.gen_cfg = ADP5589_GENERAL_CFG,
 	.poll_ptime_cfg = ADP5589_POLL_PTIME_CFG,
+	.reset_cfg = ADP5589_RESET_CFG,
+	.reset1_event_a = ADP5589_RESET1_EVENT_A,
+	.reset2_event_a = ADP5589_RESET2_EVENT_A,
 };
 
+static int adp5585_validate_event(const struct adp5585_dev *adp5585, unsigned int ev)
+{
+	if (adp5585->has_pin6) {
+		if (ev >= ADP5585_ROW5_KEY_EVENT_START && ev <= ADP5585_ROW5_KEY_EVENT_END)
+			return 0;
+		if (ev >= ADP5585_GPI_EVENT_START && ev <= ADP5585_GPI_EVENT_END)
+			return 0;
+
+		return dev_err_probe(adp5585->dev, -EINVAL,
+				     "Invalid unlock/reset event(%u) for this device\n", ev);
+	}
+
+	if (ev >= ADP5585_KEY_EVENT_START && ev <= ADP5585_KEY_EVENT_END)
+		return 0;
+	if (ev >= ADP5585_GPI_EVENT_START && ev <= ADP5585_GPI_EVENT_END) {
+		/*
+		 * Some variants of the adp5585 do not have the Row 5
+		 * (meaning pin 6 or GPIO 6) available. Instead that pin serves
+		 * as a reset pin. So, we need to make sure no event is
+		 * configured for it.
+		 */
+		if (ev == (ADP5585_GPI_EVENT_START + 5))
+			return dev_err_probe(adp5585->dev, -EINVAL,
+					     "Invalid unlock/reset event(%u). R5 not available\n",
+					     ev);
+		return 0;
+	}
+
+	return dev_err_probe(adp5585->dev, -EINVAL,
+			     "Invalid unlock/reset event(%u) for this device\n", ev);
+}
+
+static int adp5589_validate_event(const struct adp5585_dev *adp5585, unsigned int ev)
+{
+	if (ev >= ADP5589_KEY_EVENT_START && ev <= ADP5589_KEY_EVENT_END)
+		return 0;
+	if (ev >= ADP5589_GPI_EVENT_START && ev <= ADP5589_GPI_EVENT_END)
+		return 0;
+
+	return dev_err_probe(adp5585->dev, -EINVAL,
+			     "Invalid unlock/reset event(%u) for this device\n", ev);
+}
+
 static struct regmap_config *adp5585_fill_variant_config(struct adp5585_dev *adp5585)
 {
 	struct regmap_config *regmap_config;
@@ -191,6 +240,8 @@ static struct regmap_config *adp5585_fill_variant_config(struct adp5585_dev *adp
 	case ADP5585_04:
 		adp5585->id = ADP5585_MAN_ID_VALUE;
 		adp5585->regs = &adp5585_regs;
+		if (adp5585->variant == ADP5585_01)
+			adp5585->has_pin6 = true;
 		regmap_config = devm_kmemdup(adp5585->dev, &adp5585_regmap_config_template,
 					     sizeof(struct regmap_config), GFP_KERNEL);
 		break;
@@ -199,6 +250,8 @@ static struct regmap_config *adp5585_fill_variant_config(struct adp5585_dev *adp
 	case ADP5589_02:
 		adp5585->id = ADP5589_MAN_ID_VALUE;
 		adp5585->regs = &adp5589_regs;
+		adp5585->has_unlock = true;
+		adp5585->has_pin6 = true;
 		regmap_config = devm_kmemdup(adp5585->dev, &adp5589_regmap_config_template,
 					     sizeof(struct regmap_config), GFP_KERNEL);
 		break;
@@ -214,6 +267,167 @@ static struct regmap_config *adp5585_fill_variant_config(struct adp5585_dev *adp
 	return regmap_config;
 }
 
+static int adp5585_parse_ev_array(const struct adp5585_dev *adp5585, const char *prop, u32 *events,
+				  u32 *n_events, u32 max_evs, bool reset_ev)
+{
+	struct device *dev = adp5585->dev;
+	unsigned int ev;
+	int ret;
+
+	/*
+	 * The device has the capability of handling special events through GPIs or a Keypad:
+	 *  unlock events: Unlock the keymap until one of the configured events is detected.
+	 *  reset events: Generate a reset pulse when one of the configured events is detected.
+	 */
+	ret = device_property_count_u32(dev, prop);
+	if (ret < 0)
+		return 0;
+
+	*n_events = ret;
+
+	if (!adp5585->has_unlock && !reset_ev)
+		return dev_err_probe(dev, -EOPNOTSUPP, "Unlock keys not supported\n");
+
+	if (*n_events > max_evs)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid number of keys(%u > %u) for %s\n",
+				     *n_events, max_evs, prop);
+
+	ret = device_property_read_u32_array(dev, prop, events, *n_events);
+	if (ret)
+		return ret;
+
+	for (ev = 0; ev < *n_events; ev++) {
+		if (!reset_ev && events[ev] == ADP5589_UNLOCK_WILDCARD)
+			continue;
+
+		if (adp5585->id == ADP5585_MAN_ID_VALUE)
+			ret = adp5585_validate_event(adp5585, events[ev]);
+		else
+			ret = adp5589_validate_event(adp5585, events[ev]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int adp5585_unlock_ev_parse(struct adp5585_dev *adp5585)
+{
+	struct device *dev = adp5585->dev;
+	int ret;
+
+	ret = adp5585_parse_ev_array(adp5585, "adi,unlock-events", adp5585->unlock_keys,
+				     &adp5585->nkeys_unlock, ARRAY_SIZE(adp5585->unlock_keys),
+				     false);
+	if (ret)
+		return ret;
+	if (!adp5585->nkeys_unlock)
+		return 0;
+
+	ret = device_property_read_u32(dev, "adi,unlock-trigger-sec", &adp5585->unlock_time);
+	if (!ret) {
+		if (adp5585->unlock_time > ADP5585_MAX_UNLOCK_TIME_SEC)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid unlock time(%u > %d)\n",
+					     adp5585->unlock_time,
+					     ADP5585_MAX_UNLOCK_TIME_SEC);
+	}
+
+	return 0;
+}
+
+static int adp5585_reset_ev_parse(struct adp5585_dev *adp5585)
+{
+	struct device *dev = adp5585->dev;
+	u32 prop_val;
+	int ret;
+
+	ret = adp5585_parse_ev_array(adp5585, "adi,reset1-events", adp5585->reset1_keys,
+				     &adp5585->nkeys_reset1,
+				     ARRAY_SIZE(adp5585->reset1_keys), true);
+	if (ret)
+		return ret;
+
+	ret = adp5585_parse_ev_array(adp5585, "adi,reset2-events",
+				     adp5585->reset2_keys,
+				     &adp5585->nkeys_reset2,
+				     ARRAY_SIZE(adp5585->reset2_keys), true);
+	if (ret)
+		return ret;
+
+	if (!adp5585->nkeys_reset1 && !adp5585->nkeys_reset2)
+		return 0;
+
+	if (adp5585->nkeys_reset1 && device_property_read_bool(dev, "adi,reset1-active-high"))
+		adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET1_POL, 1);
+
+	if (adp5585->nkeys_reset2 && device_property_read_bool(dev, "adi,reset2-active-high"))
+		adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET2_POL, 1);
+
+	if (device_property_read_bool(dev, "adi,rst-passthrough-enable"))
+		adp5585->reset_cfg |= FIELD_PREP(ADP5585_RST_PASSTHRU_EN, 1);
+
+	ret = device_property_read_u32(dev, "adi,reset-trigger-ms", &prop_val);
+	if (!ret) {
+		switch (prop_val) {
+		case 0:
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 0);
+			break;
+		case 1000:
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 1);
+			break;
+		case 1500:
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 2);
+			break;
+		case 2000:
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 3);
+			break;
+		case 2500:
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 4);
+			break;
+		case 3000:
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 5);
+			break;
+		case 3500:
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 6);
+			break;
+		case 4000:
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET_TRIG_TIME, 7);
+			break;
+		default:
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid value(%u) for adi,reset-trigger-ms\n",
+					     prop_val);
+		}
+	}
+
+	ret = device_property_read_u32(dev, "adi,reset-pulse-width-us", &prop_val);
+	if (!ret) {
+		switch (prop_val) {
+		case 500:
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_PULSE_WIDTH, 0);
+			break;
+		case 1000:
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_PULSE_WIDTH, 1);
+			break;
+		case 2000:
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_PULSE_WIDTH, 2);
+			break;
+		case 10000:
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_PULSE_WIDTH, 3);
+			break;
+		default:
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid value(%u) for adi,reset-pulse-width-us\n",
+					     prop_val);
+		}
+		return ret;
+	}
+
+	return 0;
+}
+
 static int adp5585_add_devices(const struct adp5585_dev *adp5585)
 {
 	struct device *dev = adp5585->dev;
@@ -302,9 +516,61 @@ static irqreturn_t adp5585_irq(int irq, void *data)
 static int adp5585_setup(struct adp5585_dev *adp5585)
 {
 	const struct adp5585_regs *regs = adp5585->regs;
-	unsigned int reg_val, i;
+	unsigned int reg_val = 0, i;
 	int ret;
 
+	/* Configure the device with reset and unlock events */
+	for (i = 0; i < adp5585->nkeys_unlock; i++) {
+		ret = regmap_write(adp5585->regmap, ADP5589_UNLOCK1 + i,
+				   adp5585->unlock_keys[i] | ADP5589_UNLOCK_EV_PRESS);
+		if (ret)
+			return ret;
+	}
+
+	if (adp5585->nkeys_unlock) {
+		ret = regmap_update_bits(adp5585->regmap, ADP5589_UNLOCK_TIMERS,
+					 ADP5589_UNLOCK_TIMER, adp5585->unlock_time);
+		if (ret)
+			return ret;
+
+		ret = regmap_set_bits(adp5585->regmap, ADP5589_LOCK_CFG, ADP5589_LOCK_EN);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < adp5585->nkeys_reset1; i++) {
+		ret = regmap_write(adp5585->regmap, regs->reset1_event_a + i,
+				   adp5585->reset1_keys[i] | ADP5585_RESET_EV_PRESS);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < adp5585->nkeys_reset2; i++) {
+		ret = regmap_write(adp5585->regmap, regs->reset2_event_a + i,
+				   adp5585->reset2_keys[i] | ADP5585_RESET_EV_PRESS);
+		if (ret)
+			return ret;
+	}
+
+	if (adp5585->nkeys_reset1 || adp5585->nkeys_reset2) {
+		ret = regmap_write(adp5585->regmap, regs->reset_cfg, adp5585->reset_cfg);
+		if (ret)
+			return ret;
+
+		/* If there's a reset1 event, then R4 is used as an output for the reset signal */
+		if (adp5585->nkeys_reset1)
+			reg_val = ADP5585_R4_EXTEND_CFG_RESET1;
+		/* If there's a reset2 event, then C4 is used as an output for the reset signal */
+		if (adp5585->nkeys_reset2)
+			reg_val |= ADP5585_C4_EXTEND_CFG_RESET2;
+
+		ret = regmap_update_bits(adp5585->regmap, regs->ext_cfg,
+					 ADP5585_C4_EXTEND_CFG_MASK | ADP5585_R4_EXTEND_CFG_MASK,
+					 reg_val);
+		if (ret)
+			return ret;
+	}
+
 	/* Clear any possible event by reading all the FIFO entries */
 	for (i = 0; i < ADP5585_EV_MAX; i++) {
 		ret = regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i, &reg_val);
@@ -345,7 +611,11 @@ static int adp5585_parse_fw(struct adp5585_dev *adp5585)
 					     "Invalid value(%u) for poll-interval\n", prop_val);
 	}
 
-	return 0;
+	ret = adp5585_unlock_ev_parse(adp5585);
+	if (ret)
+		return ret;
+
+	return adp5585_reset_ev_parse(adp5585);
 }
 
 static void adp5585_irq_disable(void *data)
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index 43a33a3d3f5a1b4fe3a9c46335d29dee6e9d60f5..db483ef9693a41d29a36910952e7a0bc54f86631 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -68,6 +68,7 @@
 #define ADP5585_GPIO_DIRECTION_A	0x27
 #define ADP5585_GPIO_DIRECTION_B	0x28
 #define ADP5585_RESET1_EVENT_A		0x29
+#define		ADP5585_RESET_EV_PRESS		BIT(7)
 #define ADP5585_RESET1_EVENT_B		0x2a
 #define ADP5585_RESET1_EVENT_C		0x2b
 #define ADP5585_RESET2_EVENT_A		0x2c
@@ -118,6 +119,13 @@
 #define ADP5585_MAX_REG			ADP5585_INT_EN
 
 #define ADP5585_PIN_MAX			11
+#define ADP5585_MAX_UNLOCK_TIME_SEC	7
+#define ADP5585_KEY_EVENT_START		1
+#define ADP5585_KEY_EVENT_END		25
+#define ADP5585_GPI_EVENT_START		37
+#define ADP5585_GPI_EVENT_END		47
+#define ADP5585_ROW5_KEY_EVENT_START	1
+#define ADP5585_ROW5_KEY_EVENT_END	30
 
 /* ADP5589 */
 #define		ADP5589_MAN_ID_VALUE		0x10
@@ -128,6 +136,20 @@
 #define ADP5589_GPO_DATA_OUT_A		0x2a
 #define ADP5589_GPO_OUT_MODE_A		0x2d
 #define		ADP5589_GPIO_DIRECTION_A	0x30
+#define ADP5589_UNLOCK1			0x33
+#define		ADP5589_UNLOCK_EV_PRESS		BIT(7)
+#define ADP5589_UNLOCK_TIMERS		0x36
+#define		ADP5589_UNLOCK_TIMER		GENMASK(2, 0)
+#define ADP5589_LOCK_CFG		0x37
+#define		ADP5589_LOCK_EN			BIT(0)
+#define ADP5589_RESET1_EVENT_A		0x38
+#define ADP5589_RESET2_EVENT_A		0x3B
+#define ADP5589_RESET_CFG		0x3D
+#define		ADP5585_RESET2_POL		BIT(7)
+#define		ADP5585_RESET1_POL		BIT(6)
+#define		ADP5585_RST_PASSTHRU_EN		BIT(5)
+#define		ADP5585_RESET_TRIG_TIME		GENMASK(4, 2)
+#define		ADP5585_PULSE_WIDTH		GENMASK(1, 0)
 #define ADP5589_PWM_OFFT_LOW		0x3e
 #define ADP5589_PWM_ONT_LOW		0x40
 #define ADP5589_PWM_CFG			0x42
@@ -138,6 +160,11 @@
 #define ADP5589_MAX_REG			ADP5589_INT_EN
 
 #define ADP5589_PIN_MAX			19
+#define ADP5589_KEY_EVENT_START		1
+#define ADP5589_KEY_EVENT_END		88
+#define ADP5589_GPI_EVENT_START		97
+#define ADP5589_GPI_EVENT_END		115
+#define ADP5589_UNLOCK_WILDCARD		127
 
 struct regmap;
 
@@ -158,6 +185,9 @@ struct adp5585_regs {
 	unsigned int ext_cfg;
 	unsigned int int_en;
 	unsigned int poll_ptime_cfg;
+	unsigned int reset_cfg;
+	unsigned int reset1_event_a;
+	unsigned int reset2_event_a;
 };
 
 struct adp5585_dev {
@@ -167,8 +197,18 @@ struct adp5585_dev {
 	struct blocking_notifier_head event_notifier;
 	enum adp5585_variant variant;
 	unsigned int id;
+	bool has_unlock;
+	bool has_pin6;
 	int irq;
 	unsigned int ev_poll_time;
+	unsigned int unlock_time;
+	unsigned int unlock_keys[2];
+	unsigned int nkeys_unlock;
+	unsigned int reset1_keys[3];
+	unsigned int nkeys_reset1;
+	unsigned int reset2_keys[2];
+	unsigned int nkeys_reset2;
+	u8 reset_cfg;
 };
 
 #endif

-- 
2.49.0



