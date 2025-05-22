Return-Path: <linux-pwm+bounces-6080-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B9CAC0B36
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 14:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E8BE1BC7104
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 12:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4368A28B519;
	Thu, 22 May 2025 12:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KFoXqKGT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503A28A715;
	Thu, 22 May 2025 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747915613; cv=none; b=DxCcD5RBM61s/ZFgYy5kq4+I4KLJrbUJBcc3IV8WtiN/rFuF9AlFRzUBnDlNUF964x1A65JX2AwA+Oe2dED2ifTUaDik75QnbQcsESYPsMQrLr72zwTL6+d8O2ZRxpFwz3Zk9nFtJ1Q9fhPcIP193VwHHBx1Kbp/wDiURa81XSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747915613; c=relaxed/simple;
	bh=4L9hpmaLOpRRn8v3HK8FFwF4ksgoZFdcvIRZvr15JLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M0TP1czRwP6cHKjftOWLIWcHHdhFb4jS/e915qbYrvEj4ba1SiE8+RsD3lTrHitEzwxMFHbNczs81tixGUZXOHj8tN8qfFfKHVh5SEmJbYqOCU4IjBxLAXhWLAY6yYFVc+9j7pg1x+9pXVweUt6X+R+EKZyr7vRB6mRKkWGY9/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KFoXqKGT; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 972A31FD49;
	Thu, 22 May 2025 12:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747915608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C07v46ZJ6NLIc5kB8z+YwuK7NIbUJJo3tiPSKaS9zbw=;
	b=KFoXqKGTbIabQPeqUFFSRsojQlzJjOByxTjsq/NXv+89PsJ77Opl8H58ZyYG1qmh7ARwRO
	VabHVhsnXH3w8QRJ5XZ8LJuf7qddRmJunpB5DGQnYJ9hQLtsje4+SCfTvf6vg24NaCR/A5
	9GD7XUOM3BL6mGEqa2KD6/0TRwBIUIYKmFcE4RLbjwYAWmygvJ19h4Ij/2GHBZR0oDgT+Z
	M7ye9/IwBdxZ6GoAGyTTE6JlGSmx9/SOom9V+M7uuHuUIHIXBNz6cqz1lY4bhCn4XWSpgp
	HaF1RnJYtF5l3JrPevzTtuOBBqA4SSYujN602JcVpNopPthR2CVgssdAr5cDjw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Thu, 22 May 2025 14:06:20 +0200
Subject: [PATCH v9 05/11] regmap: irq: Add support for chips without
 separate IRQ status
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-mdb-max7360-support-v9-5-74fc03517e41@bootlin.com>
References: <20250522-mdb-max7360-support-v9-0-74fc03517e41@bootlin.com>
In-Reply-To: <20250522-mdb-max7360-support-v9-0-74fc03517e41@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747915601; l=7655;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=4L9hpmaLOpRRn8v3HK8FFwF4ksgoZFdcvIRZvr15JLA=;
 b=/ePaQe48XFpPTeOIbKHqSP/qoZmdXjyCS7gjq7dkVPbQGSlr9q8aygs4xsEaJP5Egx7/w0P2v
 5+hZs41oQrLBFRpbOUBa5cP7tko/ZClAwr+eKrOjwmTx33AC/huyjIf
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdehleduucdltddurdegfedvrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtoheps
 ghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopegumhhithhrhidrthhorhhokhhhohhvsehgmhgrihhlrdgtohhm
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Some GPIO chips allow to rise an IRQ on GPIO level changes but do not
provide an IRQ status for each separate line: only the current gpio
level can be retrieved.

Add support for these chips, emulating IRQ status by comparing GPIO
levels with the levels during the previous interrupt.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/regmap-irq.c | 99 +++++++++++++++++++++++++++-------------
 include/linux/regmap.h           |  3 ++
 2 files changed, 71 insertions(+), 31 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 6c6869188c31..45299d29fd0b 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -6,11 +6,13 @@
 //
 // Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
+#include <linux/array_size.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/overflow.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -33,6 +35,7 @@ struct regmap_irq_chip_data {
 	void *status_reg_buf;
 	unsigned int *main_status_buf;
 	unsigned int *status_buf;
+	unsigned int *prev_status_buf;
 	unsigned int *mask_buf;
 	unsigned int *mask_buf_def;
 	unsigned int *wake_buf;
@@ -332,27 +335,13 @@ static inline int read_sub_irq_data(struct regmap_irq_chip_data *data,
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
@@ -379,10 +368,8 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
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
 
@@ -398,10 +385,8 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
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
 
@@ -418,9 +403,8 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
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
@@ -436,7 +420,7 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
 				break;
 			default:
 				BUG();
-				goto exit;
+				return -EIO;
 			}
 		}
 
@@ -447,10 +431,8 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
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
@@ -459,6 +441,42 @@ static irqreturn_t regmap_irq_thread(int irq, void *d)
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
@@ -705,6 +723,13 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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
@@ -881,6 +906,16 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		}
 	}
 
+	/* Store current levels */
+	if (chip->status_is_level) {
+		ret = read_irq_data(d);
+		if (ret < 0)
+			goto err_alloc;
+
+		memcpy(d->prev_status_buf, d->status_buf,
+		       array_size(d->chip->num_regs, sizeof(d->prev_status_buf[0])));
+	}
+
 	ret = regmap_irq_create_domain(fwnode, irq_base, chip, d);
 	if (ret)
 		goto err_alloc;
@@ -908,6 +943,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	kfree(d->mask_buf);
 	kfree(d->main_status_buf);
 	kfree(d->status_buf);
+	kfree(d->prev_status_buf);
 	kfree(d->status_reg_buf);
 	if (d->config_buf) {
 		for (i = 0; i < chip->num_config_bases; i++)
@@ -985,6 +1021,7 @@ void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
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


