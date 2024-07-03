Return-Path: <linux-pwm+bounces-2677-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4279259A3
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 12:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BFA32933A9
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 10:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E586181B80;
	Wed,  3 Jul 2024 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MG5/4/cp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FA181304;
	Wed,  3 Jul 2024 10:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003094; cv=none; b=eCemMZsLl9/FT6sq0ImDN5oct0L5D1Bc40YmInsXS0yb6SSl7VNE//pEaa4w5wNSsdEEzvzTNA78UgnG99qv6bSeqrh+7nxQYyWs0xaZLhdLUCQ17VGF09kCu7EQyKj6li1Lu7xnL2AkB4xJSKIiO+PZ4+f8S+NXnYr1VcH5SWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003094; c=relaxed/simple;
	bh=MWb3iKSy3KuhMAp3Fcz0XaJXmnFKQzA4tbf+M+qvL1I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KdS5omXaffs4dZVl0a00ihcyusx4BXU5nPSe+ILAAFbpYhREfknubFyGxz6C5yvozo9oL/thBeJU3Z11FmT/vnjlPkogNbgHQbEer8PQHDg3FzeuZ8YUT5NEhGGCm/w/YkuOBbjlJUwtjnNqi6dPndnX5HUIzZcMlWxI9i0GZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MG5/4/cp; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E6DCC4000C;
	Wed,  3 Jul 2024 10:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720003089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m4n9Na9c++gxwPPGLgqtYV2GyYYvNsA2Yt/HwrgABCM=;
	b=MG5/4/cpLUMYOoTYdFn5GEE4xSFBzFjdeyIQ7Ld1HS4jyQDwPVsZ+sRL0NZJG4V/L8kZmK
	AgucvPwKtMSRmVMMFP/pyy6BmAd8dH0RIR69LfAGutPOXk4KF/W3VXvSAyQduxnAUBUPwU
	l6wZER48jsIRJRKiz33tDEYUFGUJy6RCkV/TNP4d5b5SSy7IpASLaQ+r2nHReMZ3eLbjM2
	HGa18fhNeNscNVPKqWC9mUCVYrb5FfcvTdaf/U2NNGahQ78hr7yJ98q08+AVuSs0yLA1OB
	fumgPcFVsUlRIKMhXK5RBPsv4fND81CPBwB7KkNckBhTs8MkFV9Mxy1yBSsghg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 03 Jul 2024 12:36:55 +0200
Subject: [PATCH 11/20] irqchip/atmel-aic: convert to
 of_property_for_each_u32_new()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-of_property_for_each_u32-v1-11-42c1fc0b82aa@bootlin.com>
References: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
In-Reply-To: <20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com>
To: Miguel Ojeda <ojeda@kernel.org>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 =?utf-8?q?Emilio_L=C3=B3pez?= <emilio@elopez.com.ar>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Jonathan Cameron <jic23@kernel.org>, 
 Lee Jones <lee@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Richard Leitner <richard.leitner@linux.dev>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Damien Le Moal <dlemoal@kernel.org>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 llvm@lists.linux.dev, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-usb@vger.kernel.org, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: luca.ceresoli@bootlin.com

Simplify code using of_property_for_each_u32_new() as the two additional
parameters in of_property_for_each_u32() are not used here.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/irqchip/irq-atmel-aic-common.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic-common.c b/drivers/irqchip/irq-atmel-aic-common.c
index 072bd227b6c6..543ea249df53 100644
--- a/drivers/irqchip/irq-atmel-aic-common.c
+++ b/drivers/irqchip/irq-atmel-aic-common.c
@@ -111,8 +111,6 @@ static void __init aic_common_ext_irq_of_init(struct irq_domain *domain)
 	struct device_node *node = irq_domain_get_of_node(domain);
 	struct irq_chip_generic *gc;
 	struct aic_chip_data *aic;
-	struct property *prop;
-	const __be32 *p;
 	u32 hwirq;
 
 	gc = irq_get_domain_generic_chip(domain, 0);
@@ -120,7 +118,7 @@ static void __init aic_common_ext_irq_of_init(struct irq_domain *domain)
 	aic = gc->private;
 	aic->ext_irqs |= 1;
 
-	of_property_for_each_u32(node, "atmel,external-irqs", prop, p, hwirq) {
+	of_property_for_each_u32_new(node, "atmel,external-irqs", hwirq) {
 		gc = irq_get_domain_generic_chip(domain, hwirq);
 		if (!gc) {
 			pr_warn("AIC: external irq %d >= %d skip it\n",

-- 
2.34.1


