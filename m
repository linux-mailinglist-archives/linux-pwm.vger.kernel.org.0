Return-Path: <linux-pwm+bounces-6052-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1784AABF537
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 636414A1C57
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684692741CC;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awbFIWoo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B7A270576;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832589; cv=none; b=L1jxHdw1W4zeByVWs2b7ibjbblwDyuJBnX+5UjfJYz/oqtZjNk3I28uwZ7lgVPgJsNpZs0gIz23oX3LEIrVySD+ofYgXD67ouEb0L+LXrRb+vvR6Yf57S35TL4p9dTrXN+YKT/Gn6CUVMEjuFSNnTprxKcyZsYZpCUTYfcRSJxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832589; c=relaxed/simple;
	bh=DXccv+t/axUCs8SFNQjfpxVvuN5sOCv2vr9keKmGTHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GSbP127+7pw3/1wrKnXgMBmwnn9pBCdhmocTWEVTIOICf/iZ8MNubCVJM7amTD3raXcvUxelY7Fx6cBvY2b+1aYE6J/kXxWHk7lUpIdr494t24h8V65bi8DDioOPZzv9zsgBeYyywvySs60r4FB7II36Lwc0BhfvLrB+0qr9hp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awbFIWoo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDC27C4CEF2;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747832588;
	bh=DXccv+t/axUCs8SFNQjfpxVvuN5sOCv2vr9keKmGTHk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=awbFIWooTHQ45svYw3FOphw43k1z48Z0WRuZp+omQSYC3DaFch+DEwc6K+a5ioDQ6
	 MAtNjwdtH9Xg/rbfyRtiTqF9ACcoJ3WSkoyysgrqofOYhmMWcopano3xP9TBsDuL5/
	 gx6lcuPTQpng4uHIcoW4zIVLiYQYTczHZMxlhNtzpo/gQ/c4zN4KttYVEUt/sRK6PY
	 zhlFktJNOAY6JpD0Y/Y82I/bH6WAvdXSQUgZ7l5FaKKJ1lDahdJkKKzWO0RA376CUG
	 5k/tvY2CLCXmd0laFPINoAN18RVOI0uqX+cO0+S+uWbWKgWz3vCQa/IU7zu4XP8CbS
	 BRykZ5IbL1B1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EAFC54E92;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 May 2025 14:03:02 +0100
Subject: [PATCH v4 12/20] mfd: adp5585: add support for event handling
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250521-dev-adp5589-fw-v4-12-f2c988d7a7a0@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747832589; l=9847;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=OH3cb+s5s6nC8r9SLxz1p0RU29Bie9GtCh9YIfu3nK4=;
 b=vymSoINkNmnB8zFp6T8wXY7Kf8Nx+BIsPO68pf7geY3T/3YYi90EBb3gv6JcG/zSuYqKuRb3s
 IYBG4VvP+g5DosfNr34uDCVcSTt5kIKRNik80qyqtkqabQi6pNJlX2T
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

These devices are capable of generate FIFO based events based on KEY or
GPI presses. Add support for handling these events. This is in
preparation of adding full support for keymap and gpis based events.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/mfd/adp5585.c       | 184 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/mfd/adp5585.h |  18 +++++
 2 files changed, 190 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index e90d16389732f3d8790eb910acd82be2033eaa7e..dcc09c898dd7990b39e21cb2324fa66ae171a802 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -166,10 +167,16 @@ static const struct regmap_config adp5589_regmap_config_template = {
 
 static const struct adp5585_regs adp5585_regs = {
 	.ext_cfg = ADP5585_PIN_CONFIG_C,
+	.int_en = ADP5585_INT_EN,
+	.gen_cfg = ADP5585_GENERAL_CFG,
+	.poll_ptime_cfg = ADP5585_POLL_PTIME_CFG,
 };
 
 static const struct adp5585_regs adp5589_regs = {
 	.ext_cfg = ADP5589_PIN_CONFIG_D,
+	.int_en = ADP5589_INT_EN,
+	.gen_cfg = ADP5589_GENERAL_CFG,
+	.poll_ptime_cfg = ADP5589_POLL_PTIME_CFG,
 };
 
 static int adp5585_fill_variant_config(struct adp5585_dev *adp5585,
@@ -244,6 +251,150 @@ static void adp5585_osc_disable(void *data)
 	regmap_write(adp5585->regmap, ADP5585_GENERAL_CFG, 0);
 }
 
+static void adp5585_report_events(struct adp5585_dev *adp5585, int ev_cnt)
+{
+	unsigned int i;
+
+	for (i = 0; i < ev_cnt; i++) {
+		unsigned long key_val, key_press;
+		unsigned int key;
+		int ret;
+
+		ret = regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i, &key);
+		if (ret)
+			return;
+
+		key_val = FIELD_GET(ADP5585_KEY_EVENT_MASK, key);
+		key_press = FIELD_GET(ADP5585_KEV_EV_PRESS_MASK, key);
+
+		blocking_notifier_call_chain(&adp5585->event_notifier, key_val, (void *)key_press);
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
+		dev_err_ratelimited(adp5585->dev, "Event overflow error\n");
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
+static int adp5585_setup(struct adp5585_dev *adp5585)
+{
+	const struct adp5585_regs *regs = adp5585->regs;
+	unsigned int reg_val, i;
+	int ret;
+
+	/* Clear any possible event by reading all the FIFO entries */
+	for (i = 0; i < ADP5585_EV_MAX; i++) {
+		ret = regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i, &reg_val);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_write(adp5585->regmap, regs->poll_ptime_cfg, adp5585->ev_poll_time);
+	if (ret)
+		return ret;
+
+	/*
+	 * Enable the internal oscillator, as it's shared between multiple
+	 * functions.
+	 *
+	 * As a future improvement, power consumption could possibly be
+	 * decreased in some use cases by enabling and disabling the oscillator
+	 * dynamically based on the needs of the child drivers.
+	 */
+	ret = regmap_write(adp5585->regmap, regs->gen_cfg,
+			   ADP5585_OSC_FREQ_500KHZ | ADP5585_INT_CFG | ADP5585_OSC_EN);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(adp5585->dev, adp5585_osc_disable, adp5585);
+}
+
+static int adp5585_parse_fw(struct adp5585_dev *adp5585)
+{
+	unsigned int prop_val;
+	int ret;
+
+	ret = device_property_read_u32(adp5585->dev, "poll-interval", &prop_val);
+	if (!ret) {
+		adp5585->ev_poll_time = prop_val / 10 - 1;
+		/*
+		 * ev_poll_time is the raw value to be written on the register and 0 to 3 are the
+		 * valid values.
+		 */
+		if (adp5585->ev_poll_time > 3)
+			return dev_err_probe(adp5585->dev, -EINVAL,
+					     "Invalid value(%u) for poll-interval\n", prop_val);
+	}
+
+	return 0;
+}
+
+static void adp5585_irq_disable(void *data)
+{
+	struct adp5585_dev *adp5585 = data;
+
+	regmap_write(adp5585->regmap, adp5585->regs->int_en, 0);
+}
+
+static int adp5585_irq_enable(struct i2c_client *i2c,
+			      struct adp5585_dev *adp5585)
+{
+	const struct adp5585_regs *regs = adp5585->regs;
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
+	/*
+	 * Clear any possible outstanding interrupt before enabling them. We do that by reading
+	 * the status register and writing back the same value.
+	 */
+	ret = regmap_read(adp5585->regmap, ADP5585_INT_STATUS, &stat);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(adp5585->regmap, ADP5585_INT_STATUS, stat);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(adp5585->regmap, regs->int_en, ADP5585_OVRFLOW_IEN | ADP5585_EVENT_IEN);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(&i2c->dev, adp5585_irq_disable, adp5585);
+}
+
 static int adp5585_i2c_probe(struct i2c_client *i2c)
 {
 	struct regmap_config regmap_config;
@@ -271,6 +422,8 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 				     "Failed to initialize register map\n");
 
 	adp5585->dev = &i2c->dev;
+	adp5585->irq = i2c->irq;
+	BLOCKING_INIT_NOTIFIER_HEAD(&adp5585->event_notifier);
 
 	ret = regmap_read(adp5585->regmap, ADP5585_ID, &id);
 	if (ret)
@@ -282,29 +435,28 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
-	/*
-	 * Enable the internal oscillator, as it's shared between multiple
-	 * functions.
-	 *
-	 * As a future improvement, power consumption could possibly be
-	 * decreased in some use cases by enabling and disabling the oscillator
-	 * dynamically based on the needs of the child drivers.
-	 */
-	ret = regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG, ADP5585_OSC_EN);
+	ret = adp5585_parse_fw(adp5585);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable, adp5585);
+	ret = adp5585_setup(adp5585);
 	if (ret)
 		return ret;
 
-	return adp5585_add_devices(adp5585);
+	ret = adp5585_add_devices(adp5585);
+	if (ret)
+		return ret;
+
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
@@ -313,11 +465,19 @@ static int adp5585_suspend(struct device *dev)
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
index 2a2bccccaa6ca5cba8ff5716c0d3b82d9541432c..b6baf87907a567fe975f8b24f3c36753e6145066 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -10,13 +10,20 @@
 #define __MFD_ADP5585_H_
 
 #include <linux/bits.h>
+#include <linux/notifier.h>
 
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
@@ -32,6 +39,7 @@
 #define ADP5585_FIFO_14			0x10
 #define ADP5585_FIFO_15			0x11
 #define ADP5585_FIFO_16			0x12
+#define		ADP5585_EV_MAX			(ADP5585_FIFO_16 - ADP5585_FIFO_1 + 1)
 #define ADP5585_GPI_INT_STAT_A		0x13
 #define ADP5585_GPI_INT_STAT_B		0x14
 #define ADP5585_GPI_STATUS_A		0x15
@@ -104,6 +112,8 @@
 #define		ADP5585_INT_CFG			BIT(1)
 #define		ADP5585_RST_CFG			BIT(0)
 #define ADP5585_INT_EN			0x3c
+#define		ADP5585_OVRFLOW_IEN		BIT(2)
+#define		ADP5585_EVENT_IEN		BIT(0)
 
 #define ADP5585_MAX_REG			ADP5585_INT_EN
 
@@ -121,7 +131,9 @@
 #define ADP5589_PWM_OFFT_LOW		0x3e
 #define ADP5589_PWM_ONT_LOW		0x40
 #define ADP5589_PWM_CFG			0x42
+#define ADP5589_POLL_PTIME_CFG		0x48
 #define ADP5589_PIN_CONFIG_D		0x4C
+#define ADP5589_GENERAL_CFG		0x4d
 #define ADP5589_INT_EN			0x4e
 #define ADP5589_MAX_REG			ADP5589_INT_EN
 
@@ -142,15 +154,21 @@ enum adp5585_variant {
 };
 
 struct adp5585_regs {
+	unsigned int gen_cfg;
 	unsigned int ext_cfg;
+	unsigned int int_en;
+	unsigned int poll_ptime_cfg;
 };
 
 struct adp5585_dev {
 	const struct adp5585_regs *regs;
 	struct regmap *regmap;
 	struct device *dev;
+	struct blocking_notifier_head event_notifier;
 	enum adp5585_variant variant;
 	unsigned int id;
+	int irq;
+	unsigned int ev_poll_time;
 };
 
 #endif

-- 
2.49.0



