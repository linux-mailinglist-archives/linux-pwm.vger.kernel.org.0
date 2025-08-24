Return-Path: <linux-pwm+bounces-7157-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEE6B32FCE
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Aug 2025 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CB4200B46
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Aug 2025 11:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A8F2D7DF1;
	Sun, 24 Aug 2025 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iFFu4LxO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E42D7385;
	Sun, 24 Aug 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756036698; cv=none; b=AwXOd+qXM3yTYWz4Hb1g9tpciBP+z4E2Js7JR1zOvYYf+Qk8osmfizyac7IFOMcq0lM7nNCNSB3dL6CW1TEbPelZCh4JH5QkEnHSY7qCKbgoR5DH4cA7VSWxV22vhBizakl5paJKX5lH3D+qFXag/QCtytrCoeLqwoKo/oy3ZdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756036698; c=relaxed/simple;
	bh=q1airdugxwHpSHZaquYOnigvKVWeL4MThI2AcUjshfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VZJ247f5c0U7LFAaafOUAIosMQ6ocnz089urPbbv324kYRxjIXfmDTOCXs7d3UkdrbBXIkqeYFos1RLVL2sq7adqUIcNyul9y0FkM8X+gQyKzVtHVDBO7fIofMAXXKir+HaAZrZNEJJvnWNAM1PVGU81jUcC2g3hh81J8ZglB7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iFFu4LxO; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 62C7C1A0DA2;
	Sun, 24 Aug 2025 11:58:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3BB25605F1;
	Sun, 24 Aug 2025 11:58:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CE0AF1C22D26C;
	Sun, 24 Aug 2025 13:58:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756036693; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qI7mJ5hYt2a9bdMcNUlHFLpCQX0FFw4F2X/vURBNFY8=;
	b=iFFu4LxObGgeJDS2wLViuRQSfFtDlUygOXNpcVt+L/gq0ExITANSz7MlTyAA2vGFtV08Oa
	htkZKhM595R/utOg5JE2RRGIYHIqINYQroPLOMmYedAWLORCmyabraQr7B2e2TvIPZw6s1
	clSpapvKNUhjK+YCGnuLfk9n+BqLeGINE+5K+orAggc6/g//IK//rclXcbHhS9rAyZHGIN
	8pjVuip/IrbCL+uoXyfkFr4oXwmlBKaC0OU3Kcq3s6CsaUIPehgcohyBJJcHOWrIvFGcae
	Y4kNQGF5EdWrlcBiYUUZBvznjzd2H61MCp/tzyGbmwLuneSp4SuOae5KnX45iQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Sun, 24 Aug 2025 13:57:25 +0200
Subject: [PATCH v14 06/10] gpio: regmap: Allow to provide init_valid_mask
 callback
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-mdb-max7360-support-v14-6-435cfda2b1ea@bootlin.com>
References: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
In-Reply-To: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
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
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756036647; l=2233;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=q1airdugxwHpSHZaquYOnigvKVWeL4MThI2AcUjshfs=;
 b=WqkzbUAN1dGCG9kc5w2kg9ayeK2ntKAoX0WXnpajrhuKoY4uuxmv441KKhpZM0qsT5tyqSnqs
 LFgvOvkgnM+AlFmD7zvFu7n2CPyb4FXbpy3ppH45NePDiHkUVrLOUUQ
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3

Allows to populate the gpio_regmap_config structure with
init_valid_mask() callback to set on the final gpio_chip structure.

Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/gpio/gpio-regmap.c  | 1 +
 include/linux/gpio/regmap.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index e1944931ee7c..d9d23853e032 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -261,6 +261,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	chip->names = config->names;
 	chip->label = config->label ?: dev_name(config->parent);
 	chip->can_sleep = regmap_might_sleep(config->regmap);
+	chip->init_valid_mask = config->init_valid_mask;
 
 	chip->request = gpiochip_generic_request;
 	chip->free = gpiochip_generic_free;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 19b52ac03a5d..622a2939ebe0 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -6,6 +6,7 @@
 struct device;
 struct fwnode_handle;
 struct gpio_regmap;
+struct gpio_chip;
 struct irq_domain;
 struct regmap;
 
@@ -40,6 +41,8 @@ struct regmap;
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
+ * @init_valid_mask:	(Optional) Routine to initialize @valid_mask, to be used
+ *			if not all GPIOs are valid.
  * @regmap_irq_chip:	(Optional) Pointer on an regmap_irq_chip structure. If
  *			set, a regmap-irq device will be created and the IRQ
  *			domain will be set accordingly.
@@ -93,6 +96,10 @@ struct gpio_regmap_config {
 			      unsigned int offset, unsigned int *reg,
 			      unsigned int *mask);
 
+	int (*init_valid_mask)(struct gpio_chip *gc,
+			       unsigned long *valid_mask,
+			       unsigned int ngpios);
+
 	void *drvdata;
 };
 

-- 
2.39.5


