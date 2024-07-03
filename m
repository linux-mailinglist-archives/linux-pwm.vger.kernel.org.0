Return-Path: <linux-pwm+bounces-2686-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DA4925A18
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 12:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E632961D4
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 10:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB2D18FDB5;
	Wed,  3 Jul 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aLctC95x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA7D174EFC;
	Wed,  3 Jul 2024 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720003131; cv=none; b=r4/INWpD/I9EOj9UDIXdTMaNMby767ttIzrf3cMjwucmSYapYJCK2Z4Vnutd55U36A0crQEhWw8N9ZTKm1KYqR7JMVQWG1Wcxk3pqjGn4xdmsUCAYTZ75j41+OlV9XKKsxM00/KngC4Qd9VsLoNGB+ETHr7KD+YjWbC4+EEluuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720003131; c=relaxed/simple;
	bh=imYEkBXowZEctWnX7RSJaxD8kZRYLJFmccuWAyTSK7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hZ2gaGvWk4rLmnrliowh1iqj/3YZRPWUPmgcwqPFC7lNG/mQQtdUsPGiuur27Hhc8aJ2r1dE+Xh6ZTLqLibDuCYJTJFyOHCEKTEgesAWowM80FjkFiBoOvYGof5d9pIObXqkAEDjr3S4V0luWQ8L6V0ayVrIpMfdKmZAGcrFrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aLctC95x; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 42E2C40006;
	Wed,  3 Jul 2024 10:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720003126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Bx2CQCZLnvl2mGaHzoLhHeTCe30chHxVgbi6fu5d+s=;
	b=aLctC95xt2Q6rMLnoKMX3FJ/PPaRdMHQEBg8Yh4ab3FSY9cbwu/dUFTyd2apLZ20deWbHL
	p+IzkHN10jVZ1AG9Zn60wT53j8GY4YjZh45RcrSYSRiZO/UmHE3QPIVv0XvnhM2mXl2hWz
	VOJOVdL5ZPhpZJKh1jWQ96KV9qbUgn5W/5TTMt7H+C2eSDixGWwEKYYBbQX1xXqSkyGHz5
	91ju+rAKcnrwNcrolgluBFlh3QFO+/DQF5Wl+7Xbh+KtpnaGIUDYbYcsxewuu+9dpHQeok
	x6ehLSPvrF/uwBxNqrMB68JqQwCZNKNJ8SkpeUBfTvTBYcpghA0kpCr+80jVbg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 03 Jul 2024 12:37:04 +0200
Subject: [PATCH 20/20] of: deprecate and rename of_property_for_each_u32()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-of_property_for_each_u32-v1-20-42c1fc0b82aa@bootlin.com>
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

of_property_for_each_u32() is meant to disappear. All the call sites not
using the 3rd and 4th arguments have already been replaced by
of_property_for_each_u32_new().

Deprecate the old macro. Also rename it to minimize the number of new
usages and encourage conversion to the of_property_for_each_u32_new() macro
in not(-yet)-upstream code.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Notes:

 * The following files have not been build-tested simply because I haven't
   managed to have a config that enables them so far:

     drivers/irqchip/irq-pic32-evic.c
     drivers/pinctrl/pinctrl-k210.c

 * These have not been converted yet as they are not trivial, and they will
   need to use a more specific function that does the lookup they need and
   returns the result:

     drivers/clk/clk-si5351.c
     drivers/clk/clk.c
---
 .clang-format                    | 2 +-
 drivers/clk/clk-si5351.c         | 4 ++--
 drivers/clk/clk.c                | 2 +-
 drivers/irqchip/irq-pic32-evic.c | 2 +-
 drivers/pinctrl/pinctrl-k210.c   | 2 +-
 include/linux/of.h               | 3 ++-
 6 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/.clang-format b/.clang-format
index db25cde2651a..a91b9bb39d9b 100644
--- a/.clang-format
+++ b/.clang-format
@@ -569,8 +569,8 @@ ForEachMacros:
   - 'nr_node_for_each_safe'
   - 'of_for_each_phandle'
   - 'of_property_for_each_string'
-  - 'of_property_for_each_u32'
   - 'of_property_for_each_u32_new'
+  - 'of_property_for_each_u32_old'
   - 'pci_bus_for_each_resource'
   - 'pci_dev_for_each_resource'
   - 'pcl_for_each_chunk'
diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 4ce83c5265b8..ff990b15d616 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1191,7 +1191,7 @@ static int si5351_dt_parse(struct i2c_client *client,
 	 * property silabs,pll-source : <num src>, [<..>]
 	 * allow to selectively set pll source
 	 */
-	of_property_for_each_u32(np, "silabs,pll-source", prop, p, num) {
+	of_property_for_each_u32_old(np, "silabs,pll-source", prop, p, num) {
 		if (num >= 2) {
 			dev_err(&client->dev,
 				"invalid pll %d on pll-source prop\n", num);
@@ -1232,7 +1232,7 @@ static int si5351_dt_parse(struct i2c_client *client,
 	pdata->pll_reset[0] = true;
 	pdata->pll_reset[1] = true;
 
-	of_property_for_each_u32(np, "silabs,pll-reset-mode", prop, p, num) {
+	of_property_for_each_u32_old(np, "silabs,pll-reset-mode", prop, p, num) {
 		if (num >= 2) {
 			dev_err(&client->dev,
 				"invalid pll %d on pll-reset-mode prop\n", num);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8ea168c00997..aae940c18459 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5383,7 +5383,7 @@ const char *of_clk_get_parent_name(const struct device_node *np, int index)
 	/* if there is an indices property, use it to transfer the index
 	 * specified into an array offset for the clock-output-names property.
 	 */
-	of_property_for_each_u32(clkspec.np, "clock-indices", prop, vp, pv) {
+	of_property_for_each_u32_old(clkspec.np, "clock-indices", prop, vp, pv) {
 		if (index == pv) {
 			index = count;
 			break;
diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
index 1d9bb28d13e5..d9aec87f8b59 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -196,7 +196,7 @@ static void __init pic32_ext_irq_of_init(struct irq_domain *domain)
 	int i = 0;
 	const char *pname = "microchip,external-irqs";
 
-	of_property_for_each_u32(node, pname, prop, p, hwirq) {
+	of_property_for_each_u32_old(node, pname, prop, p, hwirq) {
 		if (i >= ARRAY_SIZE(priv->ext_irqs)) {
 			pr_warn("More than %d external irq, skip rest\n",
 				ARRAY_SIZE(priv->ext_irqs));
diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
index b6d1ed9ec9a3..03acca8b01ef 100644
--- a/drivers/pinctrl/pinctrl-k210.c
+++ b/drivers/pinctrl/pinctrl-k210.c
@@ -797,7 +797,7 @@ static int k210_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	if (ret < 0)
 		goto exit;
 
-	of_property_for_each_u32(np, "pinmux", prop, p, pinmux_group) {
+	of_property_for_each_u32_old(np, "pinmux", prop, p, pinmux_group) {
 		const char *group_name, *func_name;
 		u32 pin = FIELD_GET(K210_PG_PIN, pinmux_group);
 		u32 func = FIELD_GET(K210_PG_FUNC, pinmux_group);
diff --git a/include/linux/of.h b/include/linux/of.h
index 756847539384..15c291ab6e71 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1429,7 +1429,8 @@ static inline int of_property_read_s32(const struct device_node *np,
 	     err == 0;							\
 	     err = of_phandle_iterator_next(it))
 
-#define of_property_for_each_u32(np, propname, prop, p, u)	\
+/* deprecated - will be removed */
+#define of_property_for_each_u32_old(np, propname, prop, p, u)	\
 	for (prop = of_find_property(np, propname, NULL),	\
 		p = of_prop_next_u32(prop, NULL, &u);		\
 		p;						\

-- 
2.34.1


