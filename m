Return-Path: <linux-pwm+bounces-5860-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FB2AB0E8C
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 11:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87CE4E2D4D
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 09:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154427A918;
	Fri,  9 May 2025 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Pi2cPusQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C9A274FE5;
	Fri,  9 May 2025 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782094; cv=none; b=eEik5HUSm9bTlsqTDzRy5hnKvaelb9JnvnIDBycRCoYyfMba3xz7UAbpH6P6Ehw55AOzMch0zAFmsFNRngfSVn6tF3hVjUBgWovX8NaSEKcQ2IEB0Fnxo7hqDh5lgmn3ZTgiceXbDoFtwsuFSWAVOIb72kNj0GzyyXCmOix/SqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782094; c=relaxed/simple;
	bh=bnqDDSUw67uMCw0TA2I9vpvFQ2UMJGa2QZAL3Fzcc2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXy1hNDIsKi5INWOax/UvLtfAxgk6vS2YKY8Al4HpY4WkKs2CNi6Ow06wGsXDq6QmmgSbAVzrZ0+BAL+iLyObJoFxw1lT8jlsq+I1MJvTRTdxjXKC/KPBSpyW8oWtYBIMmKGI8d3ua5yk1pnDbnZr9ZpJubp9fWgpgN3j44wHPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Pi2cPusQ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8B171FD50;
	Fri,  9 May 2025 09:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746782090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxO9n7kzYqDZ1mf4RDLfXt3OXq/5RzLLZD0JQyoUnmY=;
	b=Pi2cPusQb88K9ZbmeZTPuocdFi2MnYXsfCytMlB55pLrrHlvPiiwFaS5CdvfYpKILBD0c5
	BrXST8DqYTt0WrEeCPpUnPXd1HgV1mGYXAZ/wyNd6AeRveNCLOjs8cFVCXic8y1xONep+0
	8NDdI3R6ude60bm5P0hu8uUreOBXl5ARLYx1XYgJl90O47pNe/xn5bdtdkjD+EIDWqkKuW
	uuPdogrZnK1A1h56mVYK8PBuQLzLI9HAGg1agDN1AS3Heal//uOvuI1TyTPlCWysFKpe2j
	bMbKGOzqNbqN4FbeDVt9DPdDUdO2bzZEhaqLwimq97Uqir8kaLGDp4T8kLijhw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 09 May 2025 11:14:41 +0200
Subject: [PATCH v8 07/11] gpio: regmap: Allow to provide init_valid_mask
 callback
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-mdb-max7360-support-v8-7-bbe486f6bcb7@bootlin.com>
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
In-Reply-To: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746782082; l=2166;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=bnqDDSUw67uMCw0TA2I9vpvFQ2UMJGa2QZAL3Fzcc2I=;
 b=TL5SA9oEE/XaqZulppxnBIE5OWDKyZoSjR90Dqfb/qyDZ6miSXxjq3mckfL+QMxVesyv/A9x3
 5M+b7VP/GxrAH+y6nk56CfxwY/idwem0oW+qM6Z8X37w59hgiGxrIoq
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqs
 ghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhpfihmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Allows to populate the gpio_regmap_config structure with
init_valid_mask() callback to set on the final gpio_chip structure.

Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/gpio/gpio-regmap.c  | 1 +
 include/linux/gpio/regmap.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 9cbbbaf82609..3d6a37be6411 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -256,6 +256,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
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


