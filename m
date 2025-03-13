Return-Path: <linux-pwm+bounces-5170-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B14A5F7C4
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2AF420D9B
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD8926980A;
	Thu, 13 Mar 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYQXJMzK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1662690ED;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875559; cv=none; b=YkYI3Pg4XJUCVsWSFMbzBqz9PO29jxfAvm+xAv/YgV5fPEaQOM0uQnWCTSKdjNwcM9FjcDv0LYzI8W8QNYRUnkiPZtNKRoP4TpIsPipw81fgPJ2r9vf04oztOxVhXj/4FZfuXmve3psK/7Nrn6JYBDN3chaEsB4udh+dEI8sESU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875559; c=relaxed/simple;
	bh=ODQyyTC3KtS5yYHkwiErTaUxQgX/DDQHl9yIHI7uJ6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7C6U7Wo9R4wKJsPhKTT/DiAL9tYtdlerkhKz/xMAyoSq9hwjDbrPSRj+jmZtcA5qwFnYO+IgSoPDb4aDtRWbsX7e5i7zm309VG+ExyBKp51acmB/vfwex5LfrQg6pjku9w2/ddnRir3fPgxCV2FMpxabg8zn4c2QuPBDpDsgN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYQXJMzK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1F7F3C4CEEE;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875558;
	bh=ODQyyTC3KtS5yYHkwiErTaUxQgX/DDQHl9yIHI7uJ6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dYQXJMzKfFHPQisstOgeEpxjfb9R605tSkANbhyCq98zt0bWAFiqboydZ7S6u0miU
	 eY3ZkFUM37wIYLGZfaF1rjaK913SxFXjY5hRlCf6yARwWrUq6TXMUW36Fculpgq2Ub
	 Nsfvi677G+TrdkjJxmoFHXJYOMjxrNOZiMTroJLwIL5e7RuTQ/vN9WEYxC3Lgh/MzF
	 2ZVNJCL/Uqg7Se4nc+u8xWj6DS9Hw3omSMnG6QnUATfb74E0NojaWOh9IswcIhIZj2
	 dneTZD75tx4tD/EpakdCyf0/osIoQ4JGClzKdgZrKDzY0gQ7Hw8ULordOjCodwkLxg
	 uc4YpyTGM1uVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AE2C28B2E;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:27 +0000
Subject: [PATCH 10/18] mfd: adp5585: add support for key events
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-10-20e80d4bd4ea@analog.com>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
In-Reply-To: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875561; l=27152;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=u38RbMm5hL9EeT9hoC0FGy7iiATu4lyLXqcDrt0lYOs=;
 b=phgmFxhyZs2Wo04FXLEX4Xv/Bqt+bJmmrV+ZWrGBZLnVZCb+KeP3FJMmiqqXml08195tru4j0
 k/AZOBeBYvKB//mshReN+9nChMxbWa1Ykg5By3K7oZE6XAXEA0IXiVt
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

This adds support for key events. Basically, it adds support for all the
FW parsing and configuration of the keys (also making sure there's no
overlaps). They can either be part of a matrix keymap (in which case
events will be handled by an input device) or they can be gpi's (in which
case events will be handled by the gpiochip device via gpio_keys). There's
also support for unlock keys as for reset keys.

This patch adds all the foundation needed by subsequent changes where the
child devices (actually handling the events) can "register" a callback
to handle the event.

Also to note that enabling the internal oscillator in now done as part of
adp5585_setup().

We also enable/disable the IRQ (if present) in the corresponding PM
event.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c       | 550 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/adp5585.h |  96 ++++++++
 2 files changed, 641 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 2fedc1c7cd08a7b3a8c7188d3e7cdfdf3122a214..a96de4e6a3a12e2c91528835c2061795e6ff3ed0 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/mfd/adp5585.h>
 #include <linux/mfd/core.h>
+#include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
@@ -205,11 +206,19 @@ static const struct adp5585_regs adp5585_regs = {
 	.gpo_out_a = ADP5585_GPO_OUT_MODE_A,
 	.gpio_dir_a = ADP5585_GPIO_DIRECTION_A,
 	.gpi_stat_a = ADP5585_GPI_STATUS_A,
+	.gpi_ev_a = ADP5585_GPI_EVENT_EN_A,
+	.gpi_int_lvl_a = ADP5585_GPI_INT_LEVEL_A,
 	.pwm_cfg = ADP5585_PWM_CFG,
 	.pwm_offt_low = ADP5585_PWM_OFFT_LOW,
 	.pwm_ont_low = ADP5585_PWM_ONT_LOW,
+	.reset_cfg = ADP5585_RESET_CFG,
 	.gen_cfg = ADP5585_GENERAL_CFG,
 	.ext_cfg = ADP5585_PIN_CONFIG_C,
+	.pin_cfg_a = ADP5585_PIN_CONFIG_A,
+	.poll_ptime_cfg = ADP5585_POLL_PTIME_CFG,
+	.int_en = ADP5585_INT_EN,
+	.reset1_event_a = ADP5585_RESET1_EVENT_A,
+	.reset2_event_a = ADP5585_RESET2_EVENT_A,
 };
 
 static const struct adp5585_regs adp5589_regs = {
@@ -219,11 +228,19 @@ static const struct adp5585_regs adp5589_regs = {
 	.gpo_out_a = ADP5589_GPO_OUT_MODE_A,
 	.gpio_dir_a = ADP5589_GPIO_DIRECTION_A,
 	.gpi_stat_a = ADP5589_GPI_STATUS_A,
+	.gpi_ev_a = ADP5589_GPI_EVENT_EN_A,
+	.gpi_int_lvl_a = ADP5589_GPI_INT_LEVEL_A,
 	.pwm_cfg = ADP5589_PWM_CFG,
 	.pwm_offt_low = ADP5589_PWM_OFFT_LOW,
 	.pwm_ont_low = ADP5589_PWM_ONT_LOW,
+	.reset_cfg = ADP5589_RESET_CFG,
 	.gen_cfg = ADP5589_GENERAL_CFG,
 	.ext_cfg = ADP5589_PIN_CONFIG_D,
+	.pin_cfg_a = ADP5589_PIN_CONFIG_A,
+	.poll_ptime_cfg = ADP5589_POLL_PTIME_CFG,
+	.int_en = ADP5589_INT_EN,
+	.reset1_event_a = ADP5589_RESET1_EVENT_A,
+	.reset2_event_a = ADP5589_RESET2_EVENT_A,
 };
 
 static const struct adp5585_info adp5585_info = {
@@ -234,6 +251,8 @@ static const struct adp5585_info adp5585_info = {
 	.regs = &adp5585_regs,
 	.max_rows = ADP5585_MAX_ROW_NUM,
 	.max_cols = ADP5585_MAX_COL_NUM,
+	.gpi_ev_base = ADP5585_GPI_EVENT_START,
+	.gpi_ev_end = ADP5585_GPI_EVENT_END,
 };
 
 static const struct adp5585_info adp5585_01_info = {
@@ -241,9 +260,12 @@ static const struct adp5585_info adp5585_01_info = {
 	.regmap_config = &adp5585_regmap_configs[ADP5585_REGMAP_00],
 	.n_devs = ARRAY_SIZE(adp5585_devs),
 	.id = ADP5585_MAN_ID_VALUE,
+	.has_row5 = true,
 	.regs = &adp5585_regs,
 	.max_rows = ADP5585_MAX_ROW_NUM,
 	.max_cols = ADP5585_MAX_COL_NUM,
+	.gpi_ev_base = ADP5585_GPI_EVENT_START,
+	.gpi_ev_end = ADP5585_GPI_EVENT_END,
 };
 
 static const struct adp5585_info adp5585_02_info = {
@@ -254,6 +276,8 @@ static const struct adp5585_info adp5585_02_info = {
 	.regs = &adp5585_regs,
 	.max_rows = ADP5585_MAX_ROW_NUM,
 	.max_cols = ADP5585_MAX_COL_NUM,
+	.gpi_ev_base = ADP5585_GPI_EVENT_START,
+	.gpi_ev_end = ADP5585_GPI_EVENT_END,
 };
 
 static const struct adp5585_info adp5585_04_info = {
@@ -264,6 +288,8 @@ static const struct adp5585_info adp5585_04_info = {
 	.regs = &adp5585_regs,
 	.max_rows = ADP5585_MAX_ROW_NUM,
 	.max_cols = ADP5585_MAX_COL_NUM,
+	.gpi_ev_base = ADP5585_GPI_EVENT_START,
+	.gpi_ev_end = ADP5585_GPI_EVENT_END,
 };
 
 static const struct adp5585_info adp5589_info = {
@@ -271,9 +297,13 @@ static const struct adp5585_info adp5589_info = {
 	.regmap_config = &adp5585_regmap_configs[ADP5589_REGMAP_00],
 	.n_devs = ARRAY_SIZE(adp5589_devs),
 	.id = ADP5589_MAN_ID_VALUE,
+	.has_row5 = true,
+	.has_unlock = true,
 	.regs = &adp5589_regs,
 	.max_rows = ADP5589_MAX_ROW_NUM,
 	.max_cols = ADP5589_MAX_COL_NUM,
+	.gpi_ev_base = ADP5589_GPI_EVENT_START,
+	.gpi_ev_end = ADP5589_GPI_EVENT_END,
 };
 
 static const struct adp5585_info adp5589_01_info = {
@@ -281,9 +311,13 @@ static const struct adp5585_info adp5589_01_info = {
 	.regmap_config = &adp5585_regmap_configs[ADP5589_REGMAP_01],
 	.n_devs = ARRAY_SIZE(adp5589_devs),
 	.id = ADP5589_MAN_ID_VALUE,
+	.has_row5 = true,
+	.has_unlock = true,
 	.regs = &adp5589_regs,
 	.max_rows = ADP5589_MAX_ROW_NUM,
 	.max_cols = ADP5589_MAX_COL_NUM,
+	.gpi_ev_base = ADP5589_GPI_EVENT_START,
+	.gpi_ev_end = ADP5589_GPI_EVENT_END,
 };
 
 static const struct adp5585_info adp5589_02_info = {
@@ -291,11 +325,379 @@ static const struct adp5585_info adp5589_02_info = {
 	.regmap_config = &adp5585_regmap_configs[ADP5589_REGMAP_02],
 	.n_devs = ARRAY_SIZE(adp5589_devs),
 	.id = ADP5589_MAN_ID_VALUE,
+	.has_row5 = true,
+	.has_unlock = true,
 	.regs = &adp5589_regs,
 	.max_rows = ADP5589_MAX_ROW_NUM,
 	.max_cols = ADP5589_MAX_COL_NUM,
+	.gpi_ev_base = ADP5589_GPI_EVENT_START,
+	.gpi_ev_end = ADP5589_GPI_EVENT_END,
 };
 
+static int adp5585_keys_validate_key(const struct adp5585_dev *adp5585, u32 key,
+				     bool is_gpi)
+{
+	const struct adp5585_info *info = adp5585->info;
+	struct device *dev = adp5585->dev;
+	u32 row, col;
+
+	if (is_gpi) {
+		u32 gpi = key - adp5585->info->gpi_ev_base;
+
+		if (!info->has_row5 && gpi == ADP5585_ROW5)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid unlock/reset GPI(%u) not supported\n",
+					     gpi);
+
+		/* check if it's being used in the keypad */
+		if (test_bit(gpi, adp5585->keypad))
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid unlock/reset GPI(%u) being used in the keypad\n",
+					     gpi);
+
+		return 0;
+	}
+
+	row = (key - 1) / info->max_cols;
+	col = (key - 1) % info->max_cols;
+
+	/* both the row and col must be part of the keypad */
+	if (test_bit(row, adp5585->keypad) &&
+	    test_bit(col + info->max_rows, adp5585->keypad))
+		return 0;
+
+	return dev_err_probe(dev, -EINVAL,
+			     "Invalid unlock/reset key(%u) not used in the keypad\n", key);
+}
+
+static int adp5585_keys_parse_array(const struct adp5585_dev *adp5585,
+				    const char *prop, u32 *keys, u32 *n_keys,
+				    u32 max_keys, bool reset_key)
+{
+	const struct adp5585_info *info = adp5585->info;
+	struct device *dev = adp5585->dev;
+	unsigned int key, max_keypad;
+	int ret;
+
+	ret = device_property_count_u32(dev, prop);
+	if (ret < 0)
+		return 0;
+
+	*n_keys = ret;
+
+	if (!info->has_unlock && !reset_key)
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "Unlock keys not supported\n");
+
+	if (*n_keys > max_keys)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid number of keys(%u > %u) for %s\n",
+				     *n_keys, max_keys, prop);
+
+	ret = device_property_read_u32_array(dev, prop, keys, *n_keys);
+	if (ret)
+		return ret;
+
+	max_keypad = adp5585->info->max_rows * adp5585->info->max_cols;
+
+	for (key = 0; key < *n_keys; key++) {
+		/* part of the keypad... */
+		if (in_range(keys[key], 1, max_keypad)) {
+			/* is it part of the keypad?! */
+			ret = adp5585_keys_validate_key(adp5585, keys[key],
+							false);
+			if (ret)
+				return ret;
+
+			continue;
+		}
+
+		/* part of gpio-keys... */
+		if (in_range(keys[key], adp5585->info->gpi_ev_base,
+			     info->max_cols + info->max_rows)) {
+			/* is the GPI being used as part of the keypad?! */
+			ret = adp5585_keys_validate_key(adp5585, keys[key],
+							true);
+			if (ret)
+				return ret;
+
+			continue;
+		}
+
+		if (!reset_key && keys[key] == 127)
+			continue;
+
+		return dev_err_probe(dev, -EINVAL, "Invalid key(%u) for %s\n",
+				     keys[key], prop);
+	}
+
+	return 0;
+}
+
+static int adp5585_keys_unlock_parse(struct adp5585_dev *adp5585)
+{
+	struct device *dev = adp5585->dev;
+	int ret;
+
+	ret = adp5585_keys_parse_array(adp5585, "adi,unlock-keys",
+				       adp5585->unlock_keys,
+				       &adp5585->nkeys_unlock,
+				       ARRAY_SIZE(adp5585->unlock_keys), false);
+	if (ret)
+		return ret;
+	if (!adp5585->nkeys_unlock)
+		/* no unlock keys */
+		return 0;
+
+	ret = device_property_read_u32(dev, "adi,unlock-trigger-sec",
+				       &adp5585->unlock_time);
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
+static int adp5585_keys_reset_parse(struct adp5585_dev *adp5585)
+{
+	const struct adp5585_info *info = adp5585->info;
+	struct device *dev = adp5585->dev;
+	u32 prop_val;
+	int ret;
+
+	ret = adp5585_keys_parse_array(adp5585, "adi,reset1-keys",
+				       adp5585->reset1_keys,
+				       &adp5585->nkeys_reset1,
+				       ARRAY_SIZE(adp5585->reset1_keys), true);
+	if (ret)
+		return ret;
+
+	if (adp5585->nkeys_reset1 > 0) {
+		if (test_bit(ADP5585_ROW4, adp5585->keypad))
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid reset1 output(R4) being used in the keypad\n");
+
+		if (device_property_read_bool(dev, "adi,reset1-active-high"))
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET1_POL, 1);
+	}
+
+	ret = adp5585_keys_parse_array(adp5585, "adi,reset2-keys",
+				       adp5585->reset2_keys,
+				       &adp5585->nkeys_reset2,
+				       ARRAY_SIZE(adp5585->reset2_keys), true);
+	if (ret)
+		return ret;
+
+	if (adp5585->nkeys_reset2 > 0) {
+		if (test_bit(info->max_rows + ADP5585_COL4, adp5585->keypad))
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid reset2 output(C4) being used in the keypad\n");
+
+		if (device_property_read_bool(dev, "adi,reset2-active-high"))
+			adp5585->reset_cfg |= FIELD_PREP(ADP5585_RESET2_POL, 1);
+	}
+
+	if (!adp5585->nkeys_reset1 && !adp5585->nkeys_reset2)
+		return 0;
+
+	if (device_property_read_bool(dev, "adi,rst-passtrough-enable"))
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
+	ret = device_property_read_u32(dev, "adi,reset-pulse-width-us",
+				       &prop_val);
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
+	}
+
+	return 0;
+}
+
+static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585)
+{
+	const struct adp5585_info *info = adp5585->info;
+	unsigned int n_pins = info->max_cols + info->max_rows;
+	unsigned int *keypad_pins;
+	unsigned int prop_val;
+	int n_keys, key, ret;
+
+	adp5585->keypad = devm_bitmap_zalloc(dev, n_pins, GFP_KERNEL);
+	if (!adp5585->keypad)
+		return -ENOMEM;
+
+	if (device_property_present(dev, "#pwm-cells"))
+		adp5585->has_pwm = true;
+
+	n_keys = device_property_count_u32(dev, "adi,keypad-pins");
+	if (n_keys <= 0)
+		goto no_keypad;
+	if (n_keys > n_pins)
+		return -EINVAL;
+
+	keypad_pins = devm_kcalloc(dev, n_keys, sizeof(*keypad_pins),
+				   GFP_KERNEL);
+	if (!keypad_pins)
+		return -ENOMEM;
+
+	ret = device_property_read_u32_array(dev, "adi,keypad-pins",
+					     keypad_pins, n_keys);
+	if (ret)
+		return ret;
+
+	for (key = 0; key < n_keys; key++) {
+		if (keypad_pins[key] >= n_pins)
+			return -EINVAL;
+		if (adp5585->has_pwm && keypad_pins[key] == ADP5585_ROW3)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid PWM pin being used in the keypad\n");
+		if (!info->has_row5 && keypad_pins[key] == ADP5585_ROW5)
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid row5 being used in the keypad\n");
+		__set_bit(keypad_pins[key], adp5585->keypad);
+	}
+
+no_keypad:
+	ret = device_property_read_u32(dev, "adi,key-poll-ms", &prop_val);
+	if (!ret) {
+		switch (prop_val) {
+		case 10:
+			fallthrough;
+		case 20:
+			fallthrough;
+		case 30:
+			fallthrough;
+		case 40:
+			adp5585->key_poll_time = prop_val / 10 - 1;
+			break;
+		default:
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid value(%u) for adi,key-poll-ms\n",
+					     prop_val);
+		}
+	}
+
+	ret = adp5585_keys_unlock_parse(adp5585);
+	if (ret)
+		return ret;
+
+	return adp5585_keys_reset_parse(adp5585);
+}
+
+static void adp5585_report_events(struct adp5585_dev *adp5585, int ev_cnt)
+{
+	unsigned int i;
+
+	guard(mutex)(&adp5585->ev_lock);
+
+	for (i = 0; i < ev_cnt; i++) {
+		unsigned int key, key_val, key_press;
+		int ret;
+
+		ret = regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i, &key);
+		if (ret)
+			return;
+
+		key_val = FIELD_GET(ADP5585_KEY_EVENT_MASK, key);
+		key_press = FIELD_GET(ADP5585_KEV_EV_PRESS_MASK, key);
+
+		if (key_val >= adp5585->info->gpi_ev_base &&
+		    key_val <= adp5585->info->gpi_ev_end) {
+			unsigned int gpi = key_val - adp5585->info->gpi_ev_base;
+
+			if (adp5585->gpio_irq_handle)
+				adp5585->gpio_irq_handle(adp5585->gpio_dev, gpi,
+							 key_press);
+		} else if (adp5585->keys_irq_handle) {
+			adp5585->keys_irq_handle(adp5585->input_dev, key_val,
+						 key_press);
+		}
+	}
+}
+
+static irqreturn_t adp5585_irq(int irq, void *data)
+{
+	struct adp5585_dev *adp5585 = data;
+	unsigned int status, ev_cnt;
+	int ret;
+
+	ret = regmap_read(adp5585->regmap, ADP5585_INT_STATUS, &status);
+	if (ret)
+		return IRQ_HANDLED;
+
+	if (status & ADP5585_OVRFLOW_INT)
+		dev_err_ratelimited(adp5585->dev, "Event Overflow Error\n");
+
+	if (!(status & ADP5585_EVENT_INT))
+		goto out_irq;
+
+	ret = regmap_read(adp5585->regmap, ADP5585_STATUS, &ev_cnt);
+	if (ret)
+		goto out_irq;
+
+	ev_cnt = FIELD_GET(ADP5585_EC_MASK, ev_cnt);
+	if (!ev_cnt)
+		goto out_irq;
+
+	adp5585_report_events(adp5585, ev_cnt);
+out_irq:
+	regmap_write(adp5585->regmap, ADP5585_INT_STATUS, status);
+	return IRQ_HANDLED;
+}
+
 static void adp5585_osc_disable(void *data)
 {
 	const struct adp5585_dev *adp5585 = data;
@@ -303,6 +705,128 @@ static void adp5585_osc_disable(void *data)
 	regmap_write(adp5585->regmap, ADP5585_GENERAL_CFG, 0);
 }
 
+static int adp5585_setup(struct adp5585_dev *adp5585)
+{
+	const struct adp5585_regs *regs = adp5585->info->regs;
+	unsigned int reg_val, i;
+	int ret;
+
+	for (i = 0; i < adp5585->nkeys_unlock; i++) {
+		ret = regmap_write(adp5585->regmap, ADP5589_UNLOCK1 + i,
+				   adp5585->unlock_keys[i] | ADP5589_UNLOCK_EV_PRESS);
+		if (ret)
+			return ret;
+	}
+
+	if (adp5585->nkeys_unlock) {
+		ret = regmap_update_bits(adp5585->regmap, ADP5589_UNLOCK_TIMERS,
+					 ADP5589_UNLOCK_TIMER,
+					 adp5585->unlock_time);
+		if (ret)
+			return ret;
+
+		ret = regmap_set_bits(adp5585->regmap, ADP5589_LOCK_CFG,
+				      ADP5589_LOCK_EN);
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
+		ret = regmap_write(adp5585->regmap, regs->reset_cfg,
+				   adp5585->reset_cfg);
+		if (ret)
+			return ret;
+
+		reg_val = 0;
+		if (adp5585->nkeys_reset1)
+			reg_val = ADP5585_R4_EXTEND_CFG_RESET1;
+		if (adp5585->nkeys_reset2)
+			reg_val |= ADP5585_C4_EXTEND_CFG_RESET2;
+
+		ret = regmap_update_bits(adp5585->regmap, regs->ext_cfg,
+					 ADP5585_C4_EXTEND_CFG_MASK |
+						 ADP5585_R4_EXTEND_CFG_MASK,
+					 reg_val);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < ADP5585_EV_MAX; i++) {
+		ret = regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i,
+				  &reg_val);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_write(adp5585->regmap, regs->poll_ptime_cfg,
+			   adp5585->key_poll_time);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(adp5585->regmap, regs->gen_cfg,
+			   ADP5585_OSC_FREQ_500KHZ | ADP5585_INT_CFG |
+			   ADP5585_OSC_EN);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(adp5585->dev, adp5585_osc_disable,
+					adp5585);
+}
+
+static void adp5585_irq_disable(void *data)
+{
+	struct adp5585_dev *adp5585 = data;
+
+	regmap_write(adp5585->regmap, adp5585->info->regs->int_en, 0);
+}
+
+static int adp5585_irq_enable(struct i2c_client *i2c,
+			      struct adp5585_dev *adp5585)
+{
+	const struct adp5585_regs *regs = adp5585->info->regs;
+	unsigned int stat;
+	int ret;
+
+	if (i2c->irq <= 0)
+		return 0;
+
+	ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL, adp5585_irq,
+					IRQF_ONESHOT, i2c->name, adp5585);
+	if (ret)
+		return ret;
+
+	/* clear any possible outstanding interrupt before enabling them... */
+	ret = regmap_read(adp5585->regmap, ADP5585_INT_STATUS, &stat);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(adp5585->regmap, ADP5585_INT_STATUS, stat);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(adp5585->regmap, regs->int_en,
+			   ADP5585_OVRFLOW_IEN | ADP5585_EVENT_IEN);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(&i2c->dev, adp5585_irq_disable,
+					adp5585);
+}
+
 static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
 	const struct adp5585_info *info;
@@ -321,6 +845,8 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return -ENODEV;
 
 	adp5585->info = info;
+	adp5585->dev = &i2c->dev;
+	adp5585->irq = i2c->irq;
 
 	adp5585->regmap = devm_regmap_init_i2c(i2c, info->regmap_config);
 	if (IS_ERR(adp5585->regmap))
@@ -337,12 +863,15 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
-	ret = regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
-			      ADP5585_OSC_EN);
+	ret = adp5585_parse_fw(&i2c->dev, adp5585);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable, adp5585);
+	ret = adp5585_setup(adp5585);
+	if (ret)
+		return ret;
+
+	ret = devm_mutex_init(&i2c->dev, &adp5585->ev_lock);
 	if (ret)
 		return ret;
 
@@ -353,13 +882,16 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, ret,
 				     "Failed to add child devices\n");
 
-	return 0;
+	return adp5585_irq_enable(i2c, adp5585);
 }
 
 static int adp5585_suspend(struct device *dev)
 {
 	struct adp5585_dev *adp5585 = dev_get_drvdata(dev);
 
+	if (adp5585->irq)
+		disable_irq(adp5585->irq);
+
 	regcache_cache_only(adp5585->regmap, true);
 
 	return 0;
@@ -368,11 +900,19 @@ static int adp5585_suspend(struct device *dev)
 static int adp5585_resume(struct device *dev)
 {
 	struct adp5585_dev *adp5585 = dev_get_drvdata(dev);
+	int ret;
 
 	regcache_cache_only(adp5585->regmap, false);
 	regcache_mark_dirty(adp5585->regmap);
 
-	return regcache_sync(adp5585->regmap);
+	ret = regcache_sync(adp5585->regmap);
+	if (ret)
+		return ret;
+
+	if (adp5585->irq)
+		enable_irq(adp5585->irq);
+
+	return 0;
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(adp5585_pm, adp5585_suspend, adp5585_resume);
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index dffe1449de01dacf8fe78cf0e87d1f176d11f620..3ec542bed9c1c44899cc869d957557813e2d0aab 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -10,13 +10,21 @@
 #define __MFD_ADP5585_H_
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/mutex.h>
 
 #define ADP5585_ID			0x00
 #define		ADP5585_MAN_ID_VALUE		0x20
 #define		ADP5585_MAN_ID_MASK		GENMASK(7, 4)
+#define		ADP5585_REV_ID_MASK		GENMASK(3, 0)
 #define ADP5585_INT_STATUS		0x01
+#define		ADP5585_OVRFLOW_INT		BIT(2)
+#define		ADP5585_EVENT_INT		BIT(0)
 #define ADP5585_STATUS			0x02
+#define		ADP5585_EC_MASK			GENMASK(4, 0)
 #define ADP5585_FIFO_1			0x03
+#define		ADP5585_KEV_EV_PRESS_MASK	BIT(7)
+#define		ADP5585_KEY_EVENT_MASK		GENMASK(6, 0)
 #define ADP5585_FIFO_2			0x04
 #define ADP5585_FIFO_3			0x05
 #define ADP5585_FIFO_4			0x06
@@ -32,6 +40,7 @@
 #define ADP5585_FIFO_14			0x10
 #define ADP5585_FIFO_15			0x11
 #define ADP5585_FIFO_16			0x12
+#define		ADP5585_EV_MAX			(ADP5585_FIFO_16 - ADP5585_FIFO_1 + 1)
 #define ADP5585_GPI_INT_STAT_A		0x13
 #define ADP5585_GPI_INT_STAT_B		0x14
 #define ADP5585_GPI_STATUS_A		0x15
@@ -60,6 +69,7 @@
 #define ADP5585_GPIO_DIRECTION_A	0x27
 #define ADP5585_GPIO_DIRECTION_B	0x28
 #define ADP5585_RESET1_EVENT_A		0x29
+#define		ADP5585_RESET_EV_PRESS		BIT(7)
 #define ADP5585_RESET1_EVENT_B		0x2a
 #define ADP5585_RESET1_EVENT_C		0x2b
 #define ADP5585_RESET2_EVENT_A		0x2c
@@ -104,8 +114,17 @@
 #define		ADP5585_INT_CFG			BIT(1)
 #define		ADP5585_RST_CFG			BIT(0)
 #define ADP5585_INT_EN			0x3c
+#define		ADP5585_OVRFLOW_IEN		BIT(2)
+#define		ADP5585_EVENT_IEN		BIT(0)
 #define ADP5585_MAX_REG			ADP5585_INT_EN
 
+#define ADP5585_ROW3			3
+#define ADP5585_ROW4			4
+#define ADP5585_ROW5			5
+#define ADP5585_COL4			4
+#define ADP5585_MAX_UNLOCK_TIME_SEC	7
+#define ADP5585_GPI_EVENT_START		37
+#define ADP5585_GPI_EVENT_END		47
 #define ADP5585_MAX_ROW_NUM		6
 #define ADP5585_MAX_COL_NUM		5
 
@@ -124,18 +143,38 @@
 #define ADP5589_GPI_STATUS_A		0x16
 #define ADP5589_GPI_STATUS_C		0x18
 #define ADP5589_RPULL_CONFIG_A		0x19
+#define ADP5589_GPI_INT_LEVEL_A		0x1e
+#define ADP5589_GPI_EVENT_EN_A		0x21
 #define ADP5589_DEBOUNCE_DIS_A		0x27
 #define ADP5589_GPO_DATA_OUT_A		0x2a
 #define ADP5589_GPO_OUT_MODE_A		0x2d
 #define	ADP5589_GPIO_DIRECTION_A	0x30
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
+#define ADP5589_POLL_PTIME_CFG		0x48
+#define ADP5589_PIN_CONFIG_A		0x49
 #define ADP5589_PIN_CONFIG_D		0x4C
 #define ADP5589_GENERAL_CFG		0x4d
 #define ADP5589_INT_EN			0x4e
 #define ADP5589_MAX_REG			ADP5589_INT_EN
 
+#define ADP5589_GPI_EVENT_START		97
+#define ADP5589_GPI_EVENT_END		115
 #define ADP5589_MAX_ROW_NUM		8
 #define ADP5589_MAX_COL_NUM		11
 
@@ -154,11 +193,19 @@ struct adp5585_regs {
 	unsigned int gpo_out_a;
 	unsigned int gpio_dir_a;
 	unsigned int gpi_stat_a;
+	unsigned int gpi_ev_a;
+	unsigned int gpi_int_lvl_a;
 	unsigned int pwm_cfg;
 	unsigned int pwm_offt_low;
 	unsigned int pwm_ont_low;
+	unsigned int reset_cfg;
 	unsigned int gen_cfg;
 	unsigned int ext_cfg;
+	unsigned int pin_cfg_a;
+	unsigned int poll_ptime_cfg;
+	unsigned int int_en;
+	unsigned int reset1_event_a;
+	unsigned int reset2_event_a;
 };
 
 struct adp5585_info {
@@ -169,6 +216,10 @@ struct adp5585_info {
 	unsigned int id;
 	u8 max_rows;
 	u8 max_cols;
+	u8 gpi_ev_base;
+	u8 gpi_ev_end;
+	bool has_row5;
+	bool has_unlock;
 };
 
 struct regmap;
@@ -176,6 +227,51 @@ struct regmap;
 struct adp5585_dev {
 	struct regmap *regmap;
 	const struct adp5585_info *info;
+	struct device *dev;
+	unsigned long *keypad;
+	void (*gpio_irq_handle)(struct device *dev, unsigned int off,
+				bool key_press);
+	struct device *gpio_dev;
+	void (*keys_irq_handle)(struct device *dev, unsigned int off,
+				bool key_press);
+	struct device *input_dev;
+	/*
+	 * Used to synchronize usage (and availability) of gpio_irq_handle()
+	 * and keys_irq_handle().
+	 */
+	struct mutex ev_lock;
+	int irq;
+	u32 key_poll_time;
+	u32 unlock_time;
+	u32 unlock_keys[2];
+	u32 nkeys_unlock;
+	u32 reset1_keys[3];
+	u32 nkeys_reset1;
+	u32 reset2_keys[2];
+	u32 nkeys_reset2;
+	u8 reset_cfg;
+	bool has_pwm;
 };
 
+static inline void adp5585_gpio_ev_handle_set(struct adp5585_dev *adp5585,
+					      void (*handle)(struct device *dev,
+							     unsigned int off,
+							     bool key_press),
+					      struct device *gpio_dev)
+{
+	guard(mutex)(&adp5585->ev_lock);
+	adp5585->gpio_irq_handle = handle;
+	adp5585->gpio_dev = gpio_dev;
+}
+
+static inline void adp5585_keys_ev_handle_set(struct adp5585_dev *adp5585,
+					      void (*handle)(struct device *dev,
+							     unsigned int off,
+							     bool key_press),
+					      struct device *input_dev)
+{
+	guard(mutex)(&adp5585->ev_lock);
+	adp5585->keys_irq_handle = handle;
+	adp5585->input_dev = input_dev;
+}
 #endif

-- 
2.48.1



