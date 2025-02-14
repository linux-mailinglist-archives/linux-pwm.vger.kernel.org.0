Return-Path: <linux-pwm+bounces-4891-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF992A35D0D
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 12:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7BE1894C9C
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 11:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF00D264FB1;
	Fri, 14 Feb 2025 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QPP1kn/O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE26263F2E;
	Fri, 14 Feb 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533824; cv=none; b=DJaAl0vqHO+A/RB7gVlz2qUtKOCVk8WksqHpIAa4WpBgji5Uyv/+oABB4PUlL54hwr9GWBiKk/FcK3YFNjzj3Rt1jjTqVPHdrB/VuBXRFPEsSt8TIQWnhMu1ouR51ZSU4KjFFmxP4sOZ3JjWoypa/eaI1r8RXx5HADbhDmyRINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533824; c=relaxed/simple;
	bh=RACglYSaKk38UOV2H+jm6GJa3jpL0WJBtuPusm0yxSg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlG8MNRJ7SvI9HrUB1lWK2axlLmLIN3XmXRozfuGOls+YVFOcAKbWWjZhKxpnilzzfO5f84Y58/fLzVRP8/f2xswuEoe5vps4/5YxmMdTcRMQOdBfeKcKGP/Ze4MJfrJAxVlJfz26enXVpQj7TJ2IO3gWa39Iy3fjfztsK4l8fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QPP1kn/O; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97427442E0;
	Fri, 14 Feb 2025 11:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739533814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOp6v2Ru6Y06CuRpAEPXOFL6ll0w0HhqmA5LgQKfTVU=;
	b=QPP1kn/OkSeUFxayYEB6SsGSDpzdTyUG3yO3yFj7BnNuUSqgiWF9Phl8qZD0IV6cmF6sGn
	fHSIhtIJkyRmOha1MQtLO8zEGAUBee9Kcc6yk5ye814Zza5dRKARr3seA+e/ypS4PkMiTZ
	EptJFEcBiSb8uHXq1GNtD2xSNzjEjTjWx99e40lNVnXEOoerlTLV1cPGlKxsqC2cBxA0Jv
	JsXmdNwg7FveYOei3rLwog0Cl1Elhzl2H4UsO+tV+U2CmeF8oSIouSWb/6jPbyqojP7+qw
	PKQF1gBnH4fdd8/OEEGv9ULKDohLLr6bnQc77hqXTbS6zlCPxUXFOpdj99lDJA==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 14 Feb 2025 12:49:54 +0100
Subject: [PATCH v4 04/10] gpio: regmap: Allow to provide request and free
 callbacks
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-mdb-max7360-support-v4-4-8a35c6dbb966@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739533806; l=2131;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=RACglYSaKk38UOV2H+jm6GJa3jpL0WJBtuPusm0yxSg=;
 b=oje7y82KnEsmMhMkE2XtUgZhcjWPi5QYw/4g0u1gfSdllShmhkXWjcw+5uJrxvsV/6ax3sixB
 GjL7vy3dz3uCD5aLzXB6V+kKBEc/GnP+AuMt+dJyxXzIIL3mLrC9GHG
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnheptdfhgeetvddvheejieehheehueetjeelkedtfeehhefgfeeglefhteegtddthfetnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrt
 ghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

Allows to populate the gpio_regmap_config structure with request() and
free() callbacks to set on the final gpio_chip structure.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/gpio/gpio-regmap.c  | 2 ++
 include/linux/gpio/regmap.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 05f8781b5204..ba72c23bcf97 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -261,6 +261,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	chip->names = config->names;
 	chip->label = config->label ?: dev_name(config->parent);
 	chip->can_sleep = regmap_might_sleep(config->regmap);
+	chip->request = config->request;
+	chip->free = config->free;
 
 	chip->request = gpiochip_generic_request;
 	chip->free = gpiochip_generic_free;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index a9f7b7faf57b..16f0c33df75d 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -6,6 +6,7 @@
 struct device;
 struct fwnode_handle;
 struct gpio_regmap;
+struct gpio_chip;
 struct irq_domain;
 struct regmap;
 
@@ -40,6 +41,10 @@ struct regmap;
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
+ * @request:		(Optional) Hook for chip-specific activation, such as
+ *			enabling module power and clock
+ * @free:		(Optional) Hook for chip-specific deactivation, such as
+ *			disabling module power and clock
  *
  * The ->reg_mask_xlate translates a given base address and GPIO offset to
  * register and mask pair. The base address is one of the given register
@@ -83,6 +88,8 @@ struct gpio_regmap_config {
 			      unsigned int *mask);
 
 	void *drvdata;
+	int (*request)(struct gpio_chip *gc, unsigned int offset);
+	void (*free)(struct gpio_chip *gc, unsigned int offset);
 };
 
 struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config);

-- 
2.39.5


