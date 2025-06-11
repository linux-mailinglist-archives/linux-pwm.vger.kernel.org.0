Return-Path: <linux-pwm+bounces-6291-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9060BAD5267
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 12:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02EE61777A0
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Jun 2025 10:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BA327816E;
	Wed, 11 Jun 2025 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myxu4jh3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29719278161;
	Wed, 11 Jun 2025 10:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638646; cv=none; b=IgjRjqd1yBuNjk4bgXVP1rYPndEnOkDL1TjKhzAqRLPA+4LMgW2Kp+3qJhhC+ksdpJYpYsBaxrsET2i9rlgceNDxK4kWhxR2dY0+PLAiMstuNu9oC8XrDo/52UdSdNZaoBHNe1ARkXQ/f8tHLmL3v1xEGPMtmbVBgGWwLPtTTL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638646; c=relaxed/simple;
	bh=tf+84qkD49mkgiTqaqohWtZ45kGhgnANEz56Oy08bFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHQ7Io2HuMy1Zvv7KcIRVXeG8kWVrBys25Xp6wWE49ax8NpuL+I5zFIZy8jYbCw3+ht3BTTNP9orhu1T3BnCg9TkOGTodqF8TwsCyTD73Snb0UkYxRQZdAsaoDaGG+Ab6Hjr8IQxmqq/LvqRm19+ZcKf4UPhIfwzea4frJxQa+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myxu4jh3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27880C4CEF5;
	Wed, 11 Jun 2025 10:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749638645;
	bh=tf+84qkD49mkgiTqaqohWtZ45kGhgnANEz56Oy08bFU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=myxu4jh3MOSHqF23dezEr7MYgL/yz1DGpqFQHtAi319lLeFQHJ3EV0br9Iz81FvA/
	 9IlcvSxsosQFAFMWbkQu5gsTzgRRZs7SdayUMm3qEBIRYTgOQ4ABko6xCSsxNeFepg
	 hw0YSfJCnz7rGVI0JSUUKmcIkyw8tlZodZXJezw1iiXlxlIxN3PXnBjnt6RZxAXVzt
	 npmtX2X2BfrBtt/iO2uaF86b4mqR0F5Us4E7JdxDNDNOGyzW2BbYOGmyQrYMmH0I2E
	 QMq6BmluIml5+k12aaCxsaJpGfRrrcv8/ifZm//dLuujnXs0i+ItiPdat41yYd4cc8
	 GRkAElb271Cgw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Keerthy <j-keerthy@ti.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Heiko Stuebner <heiko@sntech.de>,
	Andy Shevchenko <andy@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-rockchip@lists.infradead.org
Subject: [PATCH] gpio: Use dev_fwnode()
Date: Wed, 11 Jun 2025 12:43:34 +0200
Message-ID: <20250611104348.192092-6-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611104348.192092-1-jirislaby@kernel.org>
References: <20250611104348.192092-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

irq_domain_create_simple() takes fwnode as the first argument. It can be
extracted from the struct device using dev_fwnode() helper instead of
using of_node with of_fwnode_handle().

So use the dev_fwnode() helper.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>

---
Cc: Doug Berger <opendmb@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: "Uwe Kleine-König" <ukleinek@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-gpio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-pwm@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-rockchip@lists.infradead.org
---
 drivers/gpio/gpio-brcmstb.c   | 6 ++----
 drivers/gpio/gpio-davinci.c   | 2 +-
 drivers/gpio/gpio-em.c        | 3 +--
 drivers/gpio/gpio-grgpio.c    | 5 ++---
 drivers/gpio/gpio-lpc18xx.c   | 4 ++--
 drivers/gpio/gpio-mvebu.c     | 4 ++--
 drivers/gpio/gpio-mxc.c       | 4 ++--
 drivers/gpio/gpio-mxs.c       | 2 +-
 drivers/gpio/gpio-pxa.c       | 5 ++---
 drivers/gpio/gpio-rockchip.c  | 4 ++--
 drivers/gpio/gpio-sodaville.c | 4 ++--
 drivers/gpio/gpio-tb10x.c     | 5 ++---
 drivers/gpio/gpio-twl4030.c   | 2 +-
 13 files changed, 22 insertions(+), 28 deletions(-)

diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index e7671bcd5c07..e29a9589b3cc 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -436,10 +436,8 @@ static int brcmstb_gpio_irq_setup(struct platform_device *pdev,
 	struct device_node *np = dev->of_node;
 	int err;
 
-	priv->irq_domain =
-		irq_domain_create_linear(of_fwnode_handle(np), priv->num_gpios,
-				      &brcmstb_gpio_irq_domain_ops,
-				      priv);
+	priv->irq_domain = irq_domain_create_linear(dev_fwnode(dev), priv->num_gpios,
+						    &brcmstb_gpio_irq_domain_ops, priv);
 	if (!priv->irq_domain) {
 		dev_err(dev, "Couldn't allocate IRQ domain\n");
 		return -ENXIO;
diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 80a82492171e..8f3a36d0191d 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -478,7 +478,7 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 			return irq;
 		}
 
-		irq_domain = irq_domain_create_legacy(of_fwnode_handle(dev->of_node), ngpio, irq, 0,
+		irq_domain = irq_domain_create_legacy(dev_fwnode(dev), ngpio, irq, 0,
 						      &davinci_gpio_irq_ops, chips);
 		if (!irq_domain) {
 			dev_err(dev, "Couldn't register an IRQ domain\n");
diff --git a/drivers/gpio/gpio-em.c b/drivers/gpio/gpio-em.c
index a5e6e446f39c..015f1ac32dd9 100644
--- a/drivers/gpio/gpio-em.c
+++ b/drivers/gpio/gpio-em.c
@@ -325,8 +325,7 @@ static int em_gio_probe(struct platform_device *pdev)
 	irq_chip->irq_release_resources = em_gio_irq_relres;
 	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
 
-	p->irq_domain = irq_domain_create_simple(of_fwnode_handle(dev->of_node),
-						 ngpios, 0,
+	p->irq_domain = irq_domain_create_simple(dev_fwnode(dev), ngpios, 0,
 						 &em_gio_irq_domain_ops, p);
 	if (!p->irq_domain) {
 		dev_err(dev, "cannot initialize irq domain\n");
diff --git a/drivers/gpio/gpio-grgpio.c b/drivers/gpio/gpio-grgpio.c
index d38a2d9854ca..f3f8bab62f94 100644
--- a/drivers/gpio/gpio-grgpio.c
+++ b/drivers/gpio/gpio-grgpio.c
@@ -402,9 +402,8 @@ static int grgpio_probe(struct platform_device *ofdev)
 			return -EINVAL;
 		}
 
-		priv->domain = irq_domain_create_linear(of_fwnode_handle(np), gc->ngpio,
-						     &grgpio_irq_domain_ops,
-						     priv);
+		priv->domain = irq_domain_create_linear(dev_fwnode(&ofdev->dev), gc->ngpio,
+							&grgpio_irq_domain_ops, priv);
 		if (!priv->domain) {
 			dev_err(dev, "Could not add irq domain\n");
 			return -EINVAL;
diff --git a/drivers/gpio/gpio-lpc18xx.c b/drivers/gpio/gpio-lpc18xx.c
index b0a8da5c058d..2dbfbf90176c 100644
--- a/drivers/gpio/gpio-lpc18xx.c
+++ b/drivers/gpio/gpio-lpc18xx.c
@@ -249,8 +249,8 @@ static int lpc18xx_gpio_pin_ic_probe(struct lpc18xx_gpio_chip *gc)
 	raw_spin_lock_init(&ic->lock);
 
 	ic->domain = irq_domain_create_hierarchy(parent_domain, 0, NR_LPC18XX_GPIO_PIN_IC_IRQS,
-						 of_fwnode_handle(dev->of_node),
-						 &lpc18xx_gpio_pin_ic_domain_ops, ic);
+						 dev_fwnode(dev), &lpc18xx_gpio_pin_ic_domain_ops,
+						 ic);
 	if (!ic->domain) {
 		pr_err("unable to add irq domain\n");
 		ret = -ENODEV;
diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 57633a7b4270..24792b8eb083 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -1236,8 +1236,8 @@ static int mvebu_gpio_probe(struct platform_device *pdev)
 	if (!have_irqs)
 		return 0;
 
-	mvchip->domain =
-	    irq_domain_create_linear(of_fwnode_handle(np), ngpios, &irq_generic_chip_ops, NULL);
+	mvchip->domain = irq_domain_create_linear(dev_fwnode(&pdev->dev), ngpios,
+						  &irq_generic_chip_ops, NULL);
 	if (!mvchip->domain) {
 		dev_err(&pdev->dev, "couldn't allocate irq domain %s (DT).\n",
 			mvchip->chip.label);
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index fae1a30f8ae6..4af5a2972d12 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -509,8 +509,8 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 		goto out_bgio;
 	}
 
-	port->domain = irq_domain_create_legacy(of_fwnode_handle(np), 32, irq_base, 0,
-					     &irq_domain_simple_ops, NULL);
+	port->domain = irq_domain_create_legacy(dev_fwnode(&pdev->dev), 32, irq_base, 0,
+						&irq_domain_simple_ops, NULL);
 	if (!port->domain) {
 		err = -ENODEV;
 		goto out_bgio;
diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
index b418fbccb26c..0ea46f3d04e1 100644
--- a/drivers/gpio/gpio-mxs.c
+++ b/drivers/gpio/gpio-mxs.c
@@ -303,7 +303,7 @@ static int mxs_gpio_probe(struct platform_device *pdev)
 		goto out_iounmap;
 	}
 
-	port->domain = irq_domain_create_legacy(of_fwnode_handle(np), 32, irq_base, 0,
+	port->domain = irq_domain_create_legacy(dev_fwnode(&pdev->dev), 32, irq_base, 0,
 						&irq_domain_simple_ops, NULL);
 	if (!port->domain) {
 		err = -ENODEV;
diff --git a/drivers/gpio/gpio-pxa.c b/drivers/gpio/gpio-pxa.c
index aead35ea090e..131ab79ebce7 100644
--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -642,9 +642,8 @@ static int pxa_gpio_probe(struct platform_device *pdev)
 	if (!pxa_last_gpio)
 		return -EINVAL;
 
-	pchip->irqdomain = irq_domain_create_legacy(of_fwnode_handle(pdev->dev.of_node),
-						    pxa_last_gpio + 1, irq_base, 0,
-						    &pxa_irq_domain_ops, pchip);
+	pchip->irqdomain = irq_domain_create_legacy(dev_fwnode(&pdev->dev), pxa_last_gpio + 1,
+						    irq_base, 0, &pxa_irq_domain_ops, pchip);
 	if (!pchip->irqdomain)
 		return -ENOMEM;
 
diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index c63352f2f1ec..64700a003f9a 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -521,8 +521,8 @@ static int rockchip_interrupts_register(struct rockchip_pin_bank *bank)
 	struct irq_chip_generic *gc;
 	int ret;
 
-	bank->domain = irq_domain_create_linear(of_fwnode_handle(bank->of_node), 32,
-					&irq_generic_chip_ops, NULL);
+	bank->domain = irq_domain_create_linear(dev_fwnode(bank->dev), 32, &irq_generic_chip_ops,
+						NULL);
 	if (!bank->domain) {
 		dev_warn(bank->dev, "could not init irq domain for bank %s\n",
 			 bank->name);
diff --git a/drivers/gpio/gpio-sodaville.c b/drivers/gpio/gpio-sodaville.c
index 6a3c4c625138..abd13c79ace0 100644
--- a/drivers/gpio/gpio-sodaville.c
+++ b/drivers/gpio/gpio-sodaville.c
@@ -169,8 +169,8 @@ static int sdv_register_irqsupport(struct sdv_gpio_chip_data *sd,
 			IRQ_GC_INIT_MASK_CACHE, IRQ_NOREQUEST,
 			IRQ_LEVEL | IRQ_NOPROBE);
 
-	sd->id = irq_domain_create_legacy(of_fwnode_handle(pdev->dev.of_node), SDV_NUM_PUB_GPIOS,
-				sd->irq_base, 0, &irq_domain_sdv_ops, sd);
+	sd->id = irq_domain_create_legacy(dev_fwnode(&pdev->dev), SDV_NUM_PUB_GPIOS, sd->irq_base,
+					  0, &irq_domain_sdv_ops, sd);
 	if (!sd->id)
 		return -ENODEV;
 
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index 8cf676fd0a0b..1869ee7f9423 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -183,9 +183,8 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 		if (ret != 0)
 			return ret;
 
-		tb10x_gpio->domain = irq_domain_create_linear(of_fwnode_handle(np),
-						tb10x_gpio->gc.ngpio,
-						&irq_generic_chip_ops, NULL);
+		tb10x_gpio->domain = irq_domain_create_linear(dev_fwnode(dev), tb10x_gpio->gc.ngpio,
+							      &irq_generic_chip_ops, NULL);
 		if (!tb10x_gpio->domain) {
 			return -ENOMEM;
 		}
diff --git a/drivers/gpio/gpio-twl4030.c b/drivers/gpio/gpio-twl4030.c
index 0d17985a5fdc..c5d7825f19c1 100644
--- a/drivers/gpio/gpio-twl4030.c
+++ b/drivers/gpio/gpio-twl4030.c
@@ -523,7 +523,7 @@ static int gpio_twl4030_probe(struct platform_device *pdev)
 		return irq_base;
 	}
 
-	irq_domain_create_legacy(of_fwnode_handle(pdev->dev.of_node), TWL4030_GPIO_MAX, irq_base, 0,
+	irq_domain_create_legacy(dev_fwnode(&pdev->dev), TWL4030_GPIO_MAX, irq_base, 0,
 				 &irq_domain_simple_ops, NULL);
 
 	ret = twl4030_sih_setup(&pdev->dev, TWL4030_MODULE_GPIO, irq_base);
-- 
2.49.0


