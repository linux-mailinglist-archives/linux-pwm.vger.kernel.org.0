Return-Path: <linux-pwm+bounces-2667-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB329258E4
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 12:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91DC1F21B1D
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 10:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B6E172BB9;
	Wed,  3 Jul 2024 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SnP12D1w"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB2B157465;
	Wed,  3 Jul 2024 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003055; cv=none; b=tbYKqN8f4Frl7wbtyZgg11pfXVdDfoolsiJR9Sh2VPFe6xsKb35rHevJt/dgtDngEC7PHzUUJoHYUIi5dyOE93J3sX7zkNAKslG4VnEwepbPI0XXQ2pSCvVv4vw/KpQwQ9BQOj+rxJ1LayEZiEO+m7Ti8qvf2joIpYIOlkA4UQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003055; c=relaxed/simple;
	bh=JRlOqZSEo2CMRYS8IQRBKMPdUWAm5lV0kV/q8+AIns8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ElEMCJGNtjqR/jGAEdXBncuB2Hy9qIyEvhD3P1EMgWH409Kd7HQw0eAd/yW9q06LAMT4rOaG4f7aD/D1970kNo7FXDYxr7tiuc+KnL24TEcjs7slneeeza21iBVOvz9a+X+JcQvCDXpNcdU7k+csUqXsZwp8iEGay19VUaCkip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SnP12D1w; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73EE740003;
	Wed,  3 Jul 2024 10:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720003049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=moEPnxiSi/c1D9xrX6V2cKPTilxyr+PMhbb8iCAH8yw=;
	b=SnP12D1wMBqz1K2C4ZP0DkuGcdvpvaSCHDwQRfHVaIbo9cTSIG+C3GanMB3Dz8GR1iRJrd
	qnT046Tf39IN3CmQhaX95SRGYP2nBDEAM5tGTOWFgBSFQDsTd3m/dsrpRU3zhAPEsF5Fl3
	jkrXFwskrz4Gh0DqUXLrMHFmuKCKCVO7or2fBHpusUScb+WZVc0lnSMePPEIldt+2+ATel
	APU1p+k00hbC0js5s0PaqwB0P2+9N6XB0yVYAx/ctq0jtZTiTZeWeHTIt6iQc8ScOmGN8+
	/UnjLPcOgpoVK2LpsDsZC2GBUe7tZlqLk8QzpQNhH6KoJ167npVDF16CAtqTyQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 03 Jul 2024 12:36:45 +0200
Subject: [PATCH 01/20] of: add of_property_for_each_u32_new()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-of_property_for_each_u32-v1-1-42c1fc0b82aa@bootlin.com>
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

The of_property_for_each_u32() macro needs five parameters, two of which
are often only used internally by the macro itself (in the for()
clause).

Now that the kernel uses C11 to build these two parameters can be avoided
by declaring them internally. Add a new macro for that, which is meant to
eventually replace the existing one.

Since two variables cannot be declared in the for clause, declare one
struct that contain the two variables we actually need. Since the variables
inside this struct are not meant to be used by users of this macro, give
the struct instance the noticeable name "_it" so it is visible during code
reviews, helping to avoid new code to use it directly.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 .clang-format      |  1 +
 include/linux/of.h | 11 ++++++++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/.clang-format b/.clang-format
index ccc9b93972a9..db25cde2651a 100644
--- a/.clang-format
+++ b/.clang-format
@@ -570,6 +570,7 @@ ForEachMacros:
   - 'of_for_each_phandle'
   - 'of_property_for_each_string'
   - 'of_property_for_each_u32'
+  - 'of_property_for_each_u32_new'
   - 'pci_bus_for_each_resource'
   - 'pci_dev_for_each_resource'
   - 'pcl_for_each_chunk'
diff --git a/include/linux/of.h b/include/linux/of.h
index a0bedd038a05..756847539384 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -430,11 +430,9 @@ extern int of_detach_node(struct device_node *);
 #define of_match_ptr(_ptr)	(_ptr)
 
 /*
- * struct property *prop;
- * const __be32 *p;
  * u32 u;
  *
- * of_property_for_each_u32(np, "propname", prop, p, u)
+ * of_property_for_each_u32_new(np, "propname", u)
  *         printk("U32 value: %x\n", u);
  */
 const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
@@ -1437,6 +1435,13 @@ static inline int of_property_read_s32(const struct device_node *np,
 		p;						\
 		p = of_prop_next_u32(prop, p, &u))
 
+#define of_property_for_each_u32_new(np, propname, u)			\
+	for (struct {struct property *prop; const __be32 *item; } _it =	\
+		{of_find_property(np, propname, NULL),			\
+		 of_prop_next_u32(_it.prop, NULL, &u)};			\
+	     _it.item;							\
+	     _it.item = of_prop_next_u32(_it.prop, _it.item, &u))
+
 #define of_property_for_each_string(np, propname, prop, s)	\
 	for (prop = of_find_property(np, propname, NULL),	\
 		s = of_prop_next_string(prop, NULL);		\

-- 
2.34.1


