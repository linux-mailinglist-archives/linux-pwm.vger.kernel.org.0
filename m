Return-Path: <linux-pwm+bounces-5747-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3B3A9F018
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 13:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C28617E5A9
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 11:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD7426A0AF;
	Mon, 28 Apr 2025 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TArQRk+z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDEC267B1B;
	Mon, 28 Apr 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841474; cv=none; b=iIo4YyW/DAUCKo0GALYtULaoR4Eqi1F/bzKscoaVAgj6+W3KreyN8f6S7oxSxgM778ZhNbVk4IiXZKfIowLwdqxiFKJNNnaqYcKhyOSGXN2c9+r7bxb3zwu3yav/TsDHkAkdS6QSsg+pyxuH4uIOsxIVufiIePTOIKeaMi8hJxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841474; c=relaxed/simple;
	bh=ybgSWHgWZ4VKpqIsz4Pgop6pV1Fj4Uq0Uc3EapEIeKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJCKKAfSqrVISl2bUGacIF8K6fW0zXrcORmduVv/ksjSFsW5UP/JssCNv1Zi3V7z1gptYvoIUbk6xCCVTJS3XQmsrReU+xp26hdvf67/qSvs8/LokDbp1VhTlxCU7yjJzP+ZtujltZzjQawT+A9dPoox3hnIZtyPVlldcdBTx6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TArQRk+z; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 24EEE43A14;
	Mon, 28 Apr 2025 11:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745841463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y20oB8KlBm5WGWEpzHDlN78OfEOa84/mn1pZsBszXv8=;
	b=TArQRk+zp9F5u1p/QD7G0cBT+4p2dGOKosteM+L+KrRSoGIJH+MqK5PIY9I2p6oVdsJEdo
	Cadj0NsCg/KD1iWLsRajn81pqQvQv1IVeKDYdWo9aiHybndMd8RLmb4fT3ho7J/bcXWwHy
	zdnbxgHOv1G9WBfyefVFg+I1LhcatWWXc9Y37KKP2Rurk0AAV9gJj3xoOUU5loVdaAC7Q6
	TbnN1fF7M1KgWe+otWmnOy/3uM0MGksowSsbTmsndfM+2PP3tvvvzq5KKHo4gyLbK0Q7M6
	S1K8ndavEfB5kyLoU11fALKiTEl7oToig1kYjFGJ1jIP0BLWGQUpe/kKIAEZyQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 28 Apr 2025 13:57:23 +0200
Subject: [PATCH v7 05/11] regmap: irq: Add support for chips without
 separate IRQ status
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-mdb-max7360-support-v7-5-4e0608d0a7ff@bootlin.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
In-Reply-To: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
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
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745841456; l=7440;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=ybgSWHgWZ4VKpqIsz4Pgop6pV1Fj4Uq0Uc3EapEIeKM=;
 b=BoHX3YTWvGGrag5vgjWFkQ2VLvEUlLHOq8ueY0L9W0zjXt9goq1+H9kgX4MNIK0JZpjUT4l9A
 D6cYpdoAycxCu3oWk8cX3n7rO+39M/48txmP81QSH7sk2X67T9b2qF9
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhko
 heslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopegumhhithhrhidrthhorhhokhhhohhvsehgmhgrihhlrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Some GPIO chips allow to rise an IRQ on GPIO level changes but do not
provide an IRQ status for each separate line: only the current gpio
level can be retrieved.

Add support for these chips, emulating IRQ status by comparing GPIO
levels with the levels during the previous interrupt.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-irq.c | 97 +++++++++++++++++++++++++++-------------
 include/linux/regmap.h           |  3 ++
 2 files changed, 69 insertions(+), 31 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 6c6869188c31..c1b0dcd7280f 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -6,6 +6,7 @@
 //
 // Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
+#include <linux/array_size.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
@@ -33,6 +34,7 @@ struct regmap_irq_chip_data {
 	void *status_reg_buf;
 	unsigned int *main_status_buf;
 	unsigned int *status_buf;
+	unsigned int *prev_status_buf;
 	unsigned int *mask_buf;
 	unsigned int *mask_buf_def;
 	unsigned int *wake_buf;
@@ -332,27 +334,13 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
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
@@ -379,10 +367,8 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
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
 
@@ -398,10 +384,8 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
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
 
@@ -418,9 +402,8 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
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
@@ -436,7 +419,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				break;
 			default:
 				BUG();
-				goto exit;
+				return -EIO;
 			}
 		}
 
@@ -447,10 +430,8 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
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
@@ -459,6 +440,42 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
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
@@ -705,6 +722,13 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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
@@ -881,6 +905,15 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		}
 	}
 
+	/* Store current levels */
+	if (chip->status_is_level) {
+		ret = read_irq_data(d);
+		if (ret < 0)
+			goto err_alloc;
+
+		memcpy(d->prev_status_buf, d->status_buf, array_size(d->prev_status_buf));
+	}
+
 	ret = regmap_irq_create_domain(fwnode, irq_base, chip, d);
 	if (ret)
 		goto err_alloc;
@@ -908,6 +941,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	kfree(d->mask_buf);
 	kfree(d->main_status_buf);
 	kfree(d->status_buf);
+	kfree(d->prev_status_buf);
 	kfree(d->status_reg_buf);
 	if (d->config_buf) {
 		for (i = 0; i < chip->num_config_bases; i++)
@@ -985,6 +1019,7 @@ void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
 	kfree(d->main_status_buf);
 	kfree(d->status_reg_buf);
 	kfree(d->status_buf);
+	kfree(d->prev_status_buf);
 	if (d->config_buf) {
 		for (i = 0; i < d->chip->num_config_bases; i++)
 			kfree(d->config_buf[i]);
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index d17c5ea3d55d..02b83f5499b8 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1641,6 +1641,8 @@ struct regmap_irq_chip_data;
  * @ack_invert:  Inverted ack register: cleared bits for ack.
  * @clear_ack:  Use this to set 1 and 0 or vice-versa to clear interrupts.
  * @status_invert: Inverted status register: cleared bits are active interrupts.
+ * @status_is_level: Status register is actuall signal level: Xor status
+ *		     register with previous value to get active interrupts.
  * @wake_invert: Inverted wake register: cleared bits are wake enabled.
  * @type_in_mask: Use the mask registers for controlling irq type. Use this if
  *		  the hardware provides separate bits for rising/falling edge
@@ -1704,6 +1706,7 @@ struct regmap_irq_chip {
 	unsigned int ack_invert:1;
 	unsigned int clear_ack:1;
 	unsigned int status_invert:1;
+	unsigned int status_is_level:1;
 	unsigned int wake_invert:1;
 	unsigned int type_in_mask:1;
 	unsigned int clear_on_unmask:1;

-- 
2.39.5


