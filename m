Return-Path: <linux-pwm+bounces-4886-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B189AA35D0C
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 12:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1D9A16E3A7
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 11:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B28263F20;
	Fri, 14 Feb 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kGlgWfl5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C13275412;
	Fri, 14 Feb 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533821; cv=none; b=Yo4UKaCtGilsa/UWgwYOCkGL6eOyBIem6SJDILH8RUxd7Ir1/7xOGbVFCRbAB5D8GpZphpeP6wMto6ky6px4K1+jgr8rNEuY0VYZOcIryjtuMoZaZk04bt0mgCdog/w5lQVq2sprzzKHnd/VcC7nzYOispYAmYM/Bnjch0OTXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533821; c=relaxed/simple;
	bh=ZnQLFD2EL5I4hMAOBZqIup0nFRbw4KAr5qzEHr5tnmI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ke2HYsRb/ZKmQKGTwioOa0Z37pX66I7lS10jzju7t4uNChj9PBNGybLJJC9u3GRG0f5XqvNb238cRrv63K45BokGFzi18ItnOHIOl2Su6ICbP3+IQn558+kq7xhDgAQDbAClmb/L9dTOCmeiYW64QhtUxkxK3PwsUGzkpD77CdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kGlgWfl5; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9F908442E3;
	Fri, 14 Feb 2025 11:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739533816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eP+uWWSmBatI5PtAbRnJ86dfP7uUp+WPw6KeqKtV4Kk=;
	b=kGlgWfl5bbImlCXMAzxyJkAx1Hs4ZhS6sb335Ra4I/LSc2G420rT6DpXhvakCFoPl29Ifm
	q6l2a+I7M3klvq3tKdwq+/4wIIs/wXfvkiWWSqvWr7j/57knM3f/zYXIPoZVfmxeP9pqlZ
	e0d54pXaMPwThs8fRrsa8n1J8LeI/sczJPh0TlBEi0ZvY74S40FFf9ycWIH47bmkCqOERn
	D9a10cNSZXesV4HrtZd5St23FvDBQBTQpLUABBANijcTVVdMZPUuUc2Ga61My/GVwTNqs+
	ZEbzvw2QE/Ch/fkCUd6h2RoMTMsKuUI9erWNeO5AoayOFBmOfOqNytiRU5rEoA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 14 Feb 2025 12:49:56 +0100
Subject: [PATCH v4 06/10] regmap: irq: Add support for chips without
 separate IRQ status
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-mdb-max7360-support-v4-6-8a35c6dbb966@bootlin.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
In-Reply-To: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739533806; l=6569;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=ZnQLFD2EL5I4hMAOBZqIup0nFRbw4KAr5qzEHr5tnmI=;
 b=mTCtWXr3vYzOays92P3osmlH3QHOJUR0DDL/RRCNh7PM0ULiKn2ji11HWG/PcXhqVW1VneR3Q
 wm4JOSejM3ZBJMui4Ds5Q4diQezfhU/eVP9VX9vT086WamAEUV8PcxB
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrt
 ghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Some GPIO chips allow to rise an IRQ on GPIO level changes but do not
provide an IRQ status for each separate line: only the current gpio
level can be retrieved.

Add support for these chips, emulating IRQ status by comparing GPIO
levels with the levels during the previous interrupt.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/base/regmap/regmap-irq.c | 83 ++++++++++++++++++++++++++++++----------
 include/linux/regmap.h           |  3 ++
 2 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 0bcd81389a29..531ea799383b 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -33,6 +33,7 @@ struct regmap_irq_chip_data {
 	void *status_reg_buf;
 	unsigned int *main_status_buf;
 	unsigned int *status_buf;
+	unsigned int *prev_status_buf;
 	unsigned int *mask_buf;
 	unsigned int *mask_buf_def;
 	unsigned int *wake_buf;
@@ -332,27 +333,13 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
 	return ret;
 }
 
-static irqreturn_t regmap_irq_thread(int irq, void *d)
+static int read_irq_data(struct regmap_irq_chip_data *data)
 {
-	struct regmap_irq_chip_data *data = d;
 	const struct regmap_irq_chip *chip = data->chip;
 	struct regmap *map = data->map;
 	int ret, i;
-	bool handled = false;
 	u32 reg;
 
-	if (chip->handle_pre_irq)
-		chip->handle_pre_irq(chip->irq_drv_data);
-
-	if (chip->runtime_pm) {
-		ret = pm_runtime_get_sync(map->dev);
-		if (ret < 0) {
-			dev_err(map->dev, "IRQ thread failed to resume: %d\n",
-				ret);
-			goto exit;
-		}
-	}
-
 	/*
 	 * Read only registers with active IRQs if the chip has 'main status
 	 * register'. Else read in the statuses, using a single bulk read if
@@ -382,7 +369,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				dev_err(map->dev,
 					"Failed to read IRQ status %d\n",
 					ret);
-				goto exit;
+				return ret;
 			}
 		}
 
@@ -401,7 +388,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 					dev_err(map->dev,
 						"Failed to read IRQ status %d\n",
 						ret);
-					goto exit;
+					return ret;
 				}
 			}
 
@@ -420,7 +407,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		if (ret != 0) {
 			dev_err(map->dev, "Failed to read IRQ status: %d\n",
 				ret);
-			goto exit;
+			return ret;
 		}
 
 		for (i = 0; i < data->chip->num_regs; i++) {
@@ -436,7 +423,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				break;
 			default:
 				BUG();
-				goto exit;
+				return ret;
 			}
 		}
 
@@ -450,7 +437,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				dev_err(map->dev,
 					"Failed to read IRQ status: %d\n",
 					ret);
-				goto exit;
+				return ret;
 			}
 		}
 	}
@@ -459,6 +446,43 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 		for (i = 0; i < data->chip->num_regs; i++)
 			data->status_buf[i] = ~data->status_buf[i];
 
+	return 0;
+}
+
+static irqreturn_t regmap_irq_thread(int irq, void *d)
+{
+	struct regmap_irq_chip_data *data = d;
+	const struct regmap_irq_chip *chip = data->chip;
+	struct regmap *map = data->map;
+	int ret, i;
+	bool handled = false;
+	u32 reg;
+
+	if (chip->handle_pre_irq)
+		chip->handle_pre_irq(chip->irq_drv_data);
+
+	if (chip->runtime_pm) {
+		ret = pm_runtime_get_sync(map->dev);
+		if (ret < 0) {
+			dev_err(map->dev, "IRQ thread failed to resume: %d\n",
+				ret);
+			goto exit;
+		}
+	}
+
+	ret = read_irq_data(data);
+	if (ret < 0)
+		goto exit;
+
+	if (chip->status_is_level) {
+		for (i = 0; i < data->chip->num_regs; i++) {
+			unsigned int val = data->status_buf[i];
+
+			data->status_buf[i] ^= data->prev_status_buf[i];
+			data->prev_status_buf[i] = val;
+		}
+	}
+
 	/*
 	 * Ignore masked IRQs and ack if we need to; we ack early so
 	 * there is no race between handling and acknowledging the
@@ -705,6 +729,13 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	if (!d->status_buf)
 		goto err_alloc;
 
+	if (chip->status_is_level) {
+		d->prev_status_buf = kcalloc(chip->num_regs, sizeof(*d->prev_status_buf),
+					     GFP_KERNEL);
+		if (!d->prev_status_buf)
+			goto err_alloc;
+	}
+
 	d->mask_buf = kcalloc(chip->num_regs, sizeof(*d->mask_buf),
 			      GFP_KERNEL);
 	if (!d->mask_buf)
@@ -881,6 +912,16 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		}
 	}
 
+	/* Store current levels */
+	if (chip->status_is_level) {
+		ret = read_irq_data(d);
+		if (ret < 0)
+			goto err_alloc;
+
+		for (i = 0; i < d->chip->num_regs; i++)
+			d->prev_status_buf[i] = d->status_buf[i];
+	}
+
 	ret = regmap_irq_create_domain(fwnode, irq_base, chip, d);
 	if (ret)
 		goto err_alloc;
@@ -907,6 +948,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
 	kfree(d->status_buf);
+	kfree(d->prev_status_buf);
 	kfree(d->status_reg_buf);
 	if (d->config_buf) {
 		for (i = 0; i < chip->num_config_bases; i++)
@@ -983,6 +1025,7 @@ void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
 	kfree(d->mask_buf);
 	kfree(d->status_reg_buf);
 	kfree(d->status_buf);
+	kfree(d->prev_status_buf);
 	if (d->config_buf) {
 		for (i = 0; i < d->chip->num_config_bases; i++)
 			kfree(d->config_buf[i]);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 3a96d068915f..159527e97f00 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1640,6 +1640,8 @@ struct regmap_irq_chip_data;
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupts.
  * @status_invert: Inverted status register: cleared bits are active interrupts.
+ * @status_is_level: Status register is actuall signal level: Xor status
+ *		     register with previous value to get active interrupts.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
  * @type_in_mask: Use the mask registers for controlling irq type. Use this if
  *		  the hardware provides separate bits for rising/falling edge
@@ -1703,6 +1705,7 @@ struct regmap_irq_chip {
 	unsigned int ack_invert:1;
 	unsigned int clear_ack:1;
 	unsigned int status_invert:1;
+	unsigned int status_is_level:1;
 	unsigned int wake_invert:1;
 	unsigned int type_in_mask:1;
 	unsigned int clear_on_unmask:1;

-- 
2.39.5


