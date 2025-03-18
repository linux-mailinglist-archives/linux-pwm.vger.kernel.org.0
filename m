Return-Path: <linux-pwm+bounces-5223-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BE5A67994
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 17:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866933B7DB4
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 16:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DD0211A31;
	Tue, 18 Mar 2025 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OJK+li44"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C16221146D;
	Tue, 18 Mar 2025 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315215; cv=none; b=tBy1p0EnqckgsGjhCFdcf+u38XMrP/KRQFdXE+HzWeGhPK69/6CBfTVhp2+OMbvN3zcyQqQw5dIX2KPM/FgyBy7Ir1tBjeiN+qS6RhkfwEQghjQppxyA5XLVA5sadIVe7PxpzW8my3pmqRk3Xq+zsVDZqth4m/0+5o1YiJjf6nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315215; c=relaxed/simple;
	bh=3oglZ1WcrAkFOjzPKmjiyIHoshOfbF8DTD4cr10Dv4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VA1UpCQ3IKDVNY60TsyTmU9AaR3wZYra6JTSzOwUt72hZ6m3oZL1LdFLSrqNIdOQo7sdmZb86M+gudOyfxpdRrqwBDRPilMirWAjFOnMvjKh99VUXt1MmekgR8U2sATIjl5zstIzonEUTGaGfFowYUsxve2Oa2jGNNJrs6svka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OJK+li44; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8028C44287;
	Tue, 18 Mar 2025 16:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742315211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPkjTgOCZJS1bM/EURGwFROdDUSehZRqk1XwEprUU1c=;
	b=OJK+li44m2apRmH6I7lYzX7Le+P3U9g0AX0/srhrFfJ7J4V0RsV9ReO5FFZtocv2WrF71d
	qcn063MAq+EA/GoYD9nRMqWY2sI0tKZH1tinZFSRy01nNuWtgOl57uDhGSs2Ei423TgJ6F
	1jVeuM36WPuKIQB4zQWhEDNP/cLScFYJdN+OifGimxHlVYeYG47+Q8J5qwJvyL3dR4hSmN
	pqu1f+39PLCK2Yx1LPbvzze7xHfoGRSgDMBdP9wnRmDTQF3RfME009y6WYQdrUl7xSca++
	2h1v2+1zbIjlQTVRp7VpqirIABiirRurXBVZIllwDydeI2oYWggNf/q1h7J3kw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 18 Mar 2025 17:26:21 +0100
Subject: [PATCH v5 05/11] regmap: irq: Add support for chips without
 separate IRQ status
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-mdb-max7360-support-v5-5-fb20baf97da0@bootlin.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
In-Reply-To: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742315204; l=7187;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=3oglZ1WcrAkFOjzPKmjiyIHoshOfbF8DTD4cr10Dv4o=;
 b=M0pMGgyp7S1mQx2VIvMlI3nBkmhQpAO26ZZu08MCcAEHKaCJWeDyJXc6ggs82WB0dx8WC6JB3
 d9m0Sg1zFJjC3qbEfnUxwTziBhYTYt9CciOuT9GanhLKL/nRn7cj9WI
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlhesk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Some GPIO chips allow to rise an IRQ on GPIO level changes but do not
provide an IRQ status for each separate line: only the current gpio
level can be retrieved.

Add support for these chips, emulating IRQ status by comparing GPIO
levels with the levels during the previous interrupt.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/base/regmap/regmap-irq.c | 97 +++++++++++++++++++++++++++-------------
 include/linux/regmap.h           |  3 ++
 2 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 0bcd81389a29..0e53b64d028d 100644
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
@@ -379,10 +366,8 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 			reg = data->get_irq_reg(data, chip->main_status, i);
 			ret = regmap_read(map, reg, &data->main_status_buf[i]);
 			if (ret) {
-				dev_err(map->dev,
-					"Failed to read IRQ status %d\n",
-					ret);
-				goto exit;
+				dev_err(map->dev, "Failed to read IRQ status %d\n", ret);
+				return ret;
 			}
 		}
 
@@ -398,10 +383,8 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				ret = read_sub_irq_data(data, b);
 
 				if (ret != 0) {
-					dev_err(map->dev,
-						"Failed to read IRQ status %d\n",
-						ret);
-					goto exit;
+					dev_err(map->dev, "Failed to read IRQ status %d\n", ret);
+					return ret;
 				}
 			}
 
@@ -418,9 +401,8 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				       data->status_reg_buf,
 				       chip->num_regs);
 		if (ret != 0) {
-			dev_err(map->dev, "Failed to read IRQ status: %d\n",
-				ret);
-			goto exit;
+			dev_err(map->dev, "Failed to read IRQ status: %d\n", ret);
+			return ret;
 		}
 
 		for (i = 0; i < data->chip->num_regs; i++) {
@@ -436,7 +418,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				break;
 			default:
 				BUG();
-				goto exit;
+				return ret;
 			}
 		}
 
@@ -447,10 +429,8 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 			ret = regmap_read(map, reg, &data->status_buf[i]);
 
 			if (ret != 0) {
-				dev_err(map->dev,
-					"Failed to read IRQ status: %d\n",
-					ret);
-				goto exit;
+				dev_err(map->dev, "Failed to read IRQ status: %d\n", ret);
+				return ret;
 			}
 		}
 	}
@@ -459,6 +439,42 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
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
+			dev_err(map->dev, "IRQ thread failed to resume: %d\n", ret);
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
@@ -705,6 +721,13 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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
@@ -881,6 +904,16 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		}
 	}
 
+	/* Store current levels */
+	if (chip->status_is_level) {
+		ret = read_irq_data(d);
+		if (ret < 0)
+			goto err_alloc;
+
+		memcpy(d->prev_status_buf, d->status_buf,
+		       d->chip->num_regs * sizeof(d->prev_status_buf[0]));
+	}
+
 	ret = regmap_irq_create_domain(fwnode, irq_base, chip, d);
 	if (ret)
 		goto err_alloc;
@@ -907,6 +940,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	kfree(d->mask_buf_def);
 	kfree(d->mask_buf);
 	kfree(d->status_buf);
+	kfree(d->prev_status_buf);
 	kfree(d->status_reg_buf);
 	if (d->config_buf) {
 		for (i = 0; i < chip->num_config_bases; i++)
@@ -983,6 +1017,7 @@ void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
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


