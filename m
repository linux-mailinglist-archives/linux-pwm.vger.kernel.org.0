Return-Path: <linux-pwm+bounces-2679-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD58925968
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 12:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71CD31F29086
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 10:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C34F183079;
	Wed,  3 Jul 2024 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ib/PFCUF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4FA1822CC;
	Wed,  3 Jul 2024 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003102; cv=none; b=LgbOMrcPR9TorjqSNL1buhmqSEr32vKPHpOLHmoWDBopRpZ0s3l9hRN7LfZsEM2WqQ3w5OviJORoSsL9lXmqQdOfEcKWsKcc+ll/YGe/ZmY4F/1EseHwRPrD2jUBjGwcY5CMG4bsySz7mCMkz/Y8U5SHS2OgH2LZq3m3LfpTHk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003102; c=relaxed/simple;
	bh=8F+2pnZqcbzuv30oTMR83+vxjtItRaeqDfsbeU/W1U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mDvqhy33AZImbY4aP5Ez9RT0sMWZjU6+qtd+npqdap+Ff11NfXMccG3JLnhIXWPdVaJOULQ0vCHfMZ5rLOVJetVgLJWuVEzMRBSwz9+1DyPKneQR7wgikpXBVtN++dYHI0ipHwyO41wdgtBzD3Qp1h7mhgqgGx6WjjoZzYMVrHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ib/PFCUF; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D49E740006;
	Wed,  3 Jul 2024 10:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720003097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZPPBHSyI/+YbF/9TI9GwF+CUzeEA2RsST6wsDA28Y0=;
	b=Ib/PFCUFguJgExTJzeLBH/xgT815E4W6OuByXZJoKzK1jTZ0BKQ6yzzGZ+tFwqfA+nCZYT
	Nmi154RSR+0y3gE4okF0tI41PAeQtJ50AXcE2FBzGNCKJm0u904u7dys+Dc3UYYescC8Zz
	az7DlTYiLVXAhIJX13CFLr5t+nXUAObbnbENT/513x1OxOrNGXGFixyBZdKaOaECjwQu88
	JWAT+gu9maylMym9RKrd330DygX8qEP5aYKWm9bqPbP2r2J/O6+BKDQiocvcfc0vyNX3JR
	0Loom3v5nYdkLj1K0iaDilqc1db8vDYfnvgGOk0A6qwaJtrYHrYDqx3ld+tbwA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 03 Jul 2024 12:36:57 +0200
Subject: [PATCH 13/20] pwm: samsung: convert to
 of_property_for_each_u32_new()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-of_property_for_each_u32-v1-13-42c1fc0b82aa@bootlin.com>
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
 drivers/pwm/pwm-samsung.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index efb60c9f0cb3..fef02a0b023e 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -510,8 +510,6 @@ static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 	struct device_node *np = pwmchip_parent(chip)->of_node;
 	const struct of_device_id *match;
-	struct property *prop;
-	const __be32 *cur;
 	u32 val;
 
 	match = of_match_node(samsung_pwm_matches, np);
@@ -520,7 +518,7 @@ static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 
 	memcpy(&our_chip->variant, match->data, sizeof(our_chip->variant));
 
-	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
+	of_property_for_each_u32_new(np, "samsung,pwm-outputs", val) {
 		if (val >= SAMSUNG_PWM_NUM) {
 			dev_err(pwmchip_parent(chip),
 				"%s: invalid channel index in samsung,pwm-outputs property\n",

-- 
2.34.1


