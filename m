Return-Path: <linux-pwm+bounces-2685-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407A69259D8
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 12:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701EA293347
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 10:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638018E75D;
	Wed,  3 Jul 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="krq9F3d5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F861891D1;
	Wed,  3 Jul 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003127; cv=none; b=OY9XgVrULktQh2Qo3v7uQSgRjNPEREBq2uZhgMNvj4kZA/ODbWflCSXGL5x1VZjf6dZduqy4nZgSjb5/ChyCw35uNfw5gnuYLVmKLZVhxFprVOp8Nq9GD2XDTa+tq+xpITrhFXcYi/hHPR4uOkYqz2RPOpLiIHvK1DlhDC02wRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003127; c=relaxed/simple;
	bh=bG0q0ufmJP2yodDDmvE7NDm00PnuvAQBPFd/AHfsIKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IrjFi/k9qXGlwibpOurCLDhQ+EQDZ9SS7skpTERuksWvk9x5z59T8AIuStSS3L1CLsPhunmSLBq5IaQxA9FbZDBxlFG2Wp0fuh7SSpR6GbS5YeGLTwKByn0K1476Xot7MW+uG+hyXrOSLSLQ5EaI5OkWwseU0E0ldw1HHMLeOQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=krq9F3d5; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 41D1340003;
	Wed,  3 Jul 2024 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720003122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hUMVYtBkjPdiTzE0TuzO7cuagNMWqN2g5DCdgBLSEk=;
	b=krq9F3d5fBd6bfy6FrrQ002RWueFPpkeVNZCRwuTg00aWfcsCAo+TqJP4lQX1lNb1wnXx8
	8EFt540AMIJBMaxeUFLkQZT4IJffE+hEjvm/KC8c7bvRPvQNpTIO2EjrMZkQXl6020l+ii
	3JJCVUB6s9ma44O0w2gRu+DYyEwnCB7wKWEP232QtvdGIGUIWZVUgNnTWwPDH9ook3kbME
	D1peSErXCT5Jkj8vWWwbbj3NsFjOLFQHq2H5LTJRhcGEPUiywAMdZa3b2WOwjNwo07rHbL
	UCHQQH7s337h9dfyUpfbcNeOaTH9uKaERBtKoDjD94zwX+pk5NZ396JKb9qCGQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 03 Jul 2024 12:37:03 +0200
Subject: [PATCH 19/20] powerpc/xive: convert to
 of_property_for_each_u32_new()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-of_property_for_each_u32-v1-19-42c1fc0b82aa@bootlin.com>
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

In this case only the 'prop' variable can be removed and not 'reg',
because 'reg' is used in _previous_ lines of the same function. There
is no side effect because the of_property_for_each_u32() macro being
removed would anyway write 'reg' bwfore reading its value, and 'reg'
is not used in _following_ lines.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 arch/powerpc/sysdev/xive/spapr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index e45419264391..ffa6ca5db183 100644
--- a/arch/powerpc/sysdev/xive/spapr.c
+++ b/arch/powerpc/sysdev/xive/spapr.c
@@ -814,7 +814,6 @@ bool __init xive_spapr_init(void)
 	struct device_node *np;
 	struct resource r;
 	void __iomem *tima;
-	struct property *prop;
 	u8 max_prio;
 	u32 val;
 	u32 len;
@@ -866,7 +865,7 @@ bool __init xive_spapr_init(void)
 	}
 
 	/* Iterate the EQ sizes and pick one */
-	of_property_for_each_u32(np, "ibm,xive-eq-sizes", prop, reg, val) {
+	of_property_for_each_u32_new(np, "ibm,xive-eq-sizes", val) {
 		xive_queue_shift = val;
 		if (val == PAGE_SHIFT)
 			break;

-- 
2.34.1


