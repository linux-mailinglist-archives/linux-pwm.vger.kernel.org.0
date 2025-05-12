Return-Path: <linux-pwm+bounces-5906-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 859BAAB374E
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63FE188B729
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3FC2951A4;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4I30JH+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B751C6FF2;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=DKBk8nh/JHFgICimKJzJXqLk5Kd0NmaXePAD4xDvQautjFt+G+OdL0EPPf2P/UjZyGfBpLTd8w2H+gNv3Alpx2gVhj340sskhD8v0dvsmhEmcA56wgPW5iJ0B7OrvMl23GUoJPNklmOxLdyimB/ZPy3rzy83hR9ogoXNVI8PgZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=iSbyL5aCyfdkU83ShLQvi8VqiQuwKml/qssbbdW7fQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXcgKg9zD5ECeodGpaZ4mbDCfyHkcrVX/qYzTrZwCSdRUxM+PoEHs7bN3b5EZDvD1F+DkiZGy1jgL28DQ+uerxzcpX3+nBxi/aQ/sht0tWs92NTktNOBkAjjJCrpx3Oef6Lo3f6gYEGMhyX+/azsAImFsn7H8PhKQZYVd9e+vDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4I30JH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26E00C4CEEE;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053539;
	bh=iSbyL5aCyfdkU83ShLQvi8VqiQuwKml/qssbbdW7fQ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=A4I30JH+ATbjykaaDMdw72C3Irg793LSLFaUhdapF/BppPqsnuCBLyy0tQ3jtu/L5
	 cTIPoUUbX9aAqDRjt39cMao3EpHoQWTdylvYHSRAcEdDRyIzjYDD0QFcPNzM7JHTAw
	 KAeIAEX2NF8BByeB5B6Q2E790kkHYCZhX1n6sirCV8WOZyqaJuomYy8FbXBsWf5tz4
	 duifo08TRwsyLcvjIFOqXHRMvfUBJC0JgkrqXZ32zACeHN/MJwkYttQwzPW3Co+e/k
	 z4mOdM7z/2xHTbTPMYBS5ymMcjQZhKKwNzG9be84GEiqDA5DgccVeBfI5JGp8vfs8P
	 ooMmdNBoAYFdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E695C3ABCD;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:39:05 +0100
Subject: [PATCH v3 13/22] mfd: adp5585: add support for event handling
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-13-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=10622;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=MeWLxDc/qWT1TS13/L1b7fINguBMR9cAWEUHKjiYias=;
 b=1+5nqAYQf39ldroZKLtj6DySstfLpZO9NutfwZYjBB3q2F6WIbqE9Nz2VSbfvn8aJjJBvWxq+
 ylT65GmOPoeAg8Hr71ml9mUtPiIv96ma4T/C+Wzno4vxHbrmPIYR16j
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
 drivers/mfd/adp5585.c       | 180 ++++++++++++++++++++++++++++++++++++++++++--
 include/linux/mfd/adp5585.h |  48 ++++++++++++
 2 files changed, 223 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/adp5585.c b/drivers/mfd/adp5585.c
index 8be7a76842f639cbe90ad0eb956a7a3eef43fa3d..5851ad30e7323bbb891878167d0786bc60ef5d90 100644
--- a/drivers/mfd/adp5585.c
+++ b/drivers/mfd/adp5585.c
@@ -154,10 +154,16 @@ static const struct regmap_config adp5585_regmap_config_template = {
 
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
 
 static int adp5585_fill_chip_configs(struct adp5585_dev *adp5585,
@@ -214,6 +220,8 @@ static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
 {
 	unsigned int has_pwm = 0, has_gpio = 0, rc = 0;
 	const struct mfd_cell *cells;
+	unsigned int prop_val;
+	int ret;
 
 	if (device_property_present(dev, "#pwm-cells"))
 		has_pwm = 1;
@@ -224,6 +232,25 @@ static int adp5585_parse_fw(struct device *dev, struct adp5585_dev *adp5585,
 	if (!has_pwm && !has_gpio)
 		return -ENODEV;
 
+	ret = device_property_read_u32(dev, "poll-interval", &prop_val);
+	if (!ret) {
+		switch (prop_val) {
+		case 10:
+			fallthrough;
+		case 20:
+			fallthrough;
+		case 30:
+			fallthrough;
+		case 40:
+			adp5585->ev_poll_time = prop_val / 10 - 1;
+			break;
+		default:
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid value(%u) for poll-interval\n",
+					     prop_val);
+		}
+	}
+
 	*devs = devm_kcalloc(dev, has_pwm + has_gpio, sizeof(struct mfd_cell),
 			     GFP_KERNEL);
 	if (!*devs)
@@ -249,6 +276,135 @@ static void adp5585_osc_disable(void *data)
 	regmap_write(adp5585->regmap, ADP5585_GENERAL_CFG, 0);
 }
 
+static void adp5585_report_events(struct adp5585_dev *adp5585, int ev_cnt)
+{
+	struct adp5585_ev_handler *h;
+	unsigned int i;
+
+	guard(mutex)(&adp5585->ev_lock);
+
+	if (list_empty(&adp5585->ev_handlers)) {
+		dev_warn_ratelimited(adp5585->dev, "No event handlers registered\n");
+		return;
+	}
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
+		list_for_each_entry(h, &adp5585->ev_handlers, entry) {
+			ret = h->handler(h->dev, key_val, key_press);
+			if (!ret)
+				/* handled! */
+				break;
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
+static int adp5585_setup(struct adp5585_dev *adp5585)
+{
+	const struct adp5585_regs *regs = adp5585->info->regs;
+	unsigned int reg_val, i;
+	int ret;
+
+	for (i = 0; i < ADP5585_EV_MAX; i++) {
+		ret = regmap_read(adp5585->regmap, ADP5585_FIFO_1 + i, &reg_val);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_write(adp5585->regmap, regs->poll_ptime_cfg,
+			   adp5585->ev_poll_time);
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
 	struct regmap_config regmap_config;
@@ -282,16 +438,19 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(&i2c->dev, -ENODEV,
 				     "Invalid device ID 0x%02x\n", id);
 
+	adp5585->dev = &i2c->dev;
+	adp5585->irq = i2c->irq;
+	INIT_LIST_HEAD(&adp5585->ev_handlers);
+
 	n_devs = adp5585_parse_fw(&i2c->dev, adp5585, &devs);
 	if (n_devs < 0)
 		return n_devs;
 
-	ret = regmap_set_bits(adp5585->regmap, ADP5585_GENERAL_CFG,
-			      ADP5585_OSC_EN);
+	ret = adp5585_setup(adp5585);
 	if (ret)
 		return ret;
 
-	ret = devm_add_action_or_reset(&i2c->dev, adp5585_osc_disable, adp5585);
+	ret = devm_mutex_init(&i2c->dev, &adp5585->ev_lock);
 	if (ret)
 		return ret;
 
@@ -301,13 +460,16 @@ static int adp5585_i2c_probe(struct i2c_client *i2c)
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
@@ -316,11 +478,19 @@ static int adp5585_suspend(struct device *dev)
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
index 9a925a91c772722db559c9ec8ae334b2159ede79..218c56bed2e0304de8b81c7090386fb4e1b6c281 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -10,13 +10,23 @@
 #define __MFD_ADP5585_H_
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/list.h>
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
@@ -32,6 +42,7 @@
 #define ADP5585_FIFO_14			0x10
 #define ADP5585_FIFO_15			0x11
 #define ADP5585_FIFO_16			0x12
+#define		ADP5585_EV_MAX			(ADP5585_FIFO_16 - ADP5585_FIFO_1 + 1)
 #define ADP5585_GPI_INT_STAT_A		0x13
 #define ADP5585_GPI_INT_STAT_B		0x14
 #define ADP5585_GPI_STATUS_A		0x15
@@ -104,6 +115,8 @@
 #define		ADP5585_INT_CFG			BIT(1)
 #define		ADP5585_RST_CFG			BIT(0)
 #define ADP5585_INT_EN			0x3c
+#define		ADP5585_OVRFLOW_IEN		BIT(2)
+#define		ADP5585_EVENT_IEN		BIT(0)
 
 #define ADP5585_MAX_REG			ADP5585_INT_EN
 
@@ -121,7 +134,9 @@
 #define ADP5589_PWM_OFFT_LOW		0x3e
 #define ADP5589_PWM_ONT_LOW		0x40
 #define ADP5589_PWM_CFG			0x42
+#define ADP5589_POLL_PTIME_CFG		0x48
 #define ADP5589_PIN_CONFIG_D		0x4C
+#define ADP5589_GENERAL_CFG		0x4d
 #define ADP5589_INT_EN			0x4e
 #define ADP5589_MAX_REG			ADP5589_INT_EN
 
@@ -138,8 +153,18 @@ enum adp5585_regmap_type {
 	ADP5589_REGMAP_02,
 };
 
+struct adp5585_ev_handler {
+	struct list_head entry;
+	struct device *dev;
+	int (*handler)(struct device *dev, unsigned int key_val,
+		       unsigned int key_press);
+};
+
 struct adp5585_regs {
+	unsigned int gen_cfg;
 	unsigned int ext_cfg;
+	unsigned int int_en;
+	unsigned int poll_ptime_cfg;
 };
 
 struct adp5585_info {
@@ -150,7 +175,30 @@ struct adp5585_info {
 
 struct adp5585_dev {
 	struct regmap *regmap;
+	struct device *dev;
 	const struct adp5585_info *info;
+	/* Used to synchronize the availability of the event handlers */
+	struct mutex ev_lock;
+	struct list_head ev_handlers;
+	int irq;
+	unsigned int ev_poll_time;
 };
 
+static inline void adp5585_ev_handler_remove(void *data)
+{
+	struct adp5585_ev_handler *handler = data;
+	struct adp5585_dev *adp5585 = dev_get_drvdata(handler->dev->parent);
+
+	guard(mutex)(&adp5585->ev_lock);
+	list_del(&handler->entry);
+}
+
+static inline int devm_adp5585_ev_handler_add(struct adp5585_dev *adp5585,
+					      struct adp5585_ev_handler *handler)
+{
+	guard(mutex)(&adp5585->ev_lock);
+	list_add_tail(&handler->entry, &adp5585->ev_handlers);
+	return devm_add_action_or_reset(handler->dev, adp5585_ev_handler_remove,
+					handler);
+}
 #endif

-- 
2.49.0



