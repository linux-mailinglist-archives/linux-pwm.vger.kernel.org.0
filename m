Return-Path: <linux-pwm+bounces-2846-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAB7934045
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 18:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12C82B21C18
	for <lists+linux-pwm@lfdr.de>; Wed, 17 Jul 2024 16:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C991822D8;
	Wed, 17 Jul 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GorqDi92"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8904181CF6;
	Wed, 17 Jul 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233043; cv=none; b=g5pK8YWDZSWZnWkPstCjZxdaKM7RNxxDTKwKtYpZVqQcr0wGw9t8tVRWEHWq2YtVChTvG+hPCXhiU/E75dXaTYtRogoXk9Ooy+saaCc3qqHn2nKWHeIyH/5BUCr5x4VhtVibEuiYFfUc4ze3RhHmFvfALkVBantIyYRllsidtyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233043; c=relaxed/simple;
	bh=ienXvcMqPHxZWQYhp7MXslxSPCGLUrOlrmktDJN0z/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mSHijIUtk0atd19EoZ0snWQxiilPi8b9ImMM2TD/5zd60BL6HdPLBOl+PYaJsVj7yGX1zqcECvi+yYDOxi9x9uq6bAkPAUaAfPK3A4eBSCPDREkS/b3D+SCmneBBZZsV/0snGZ3lpp+geuNPU7RGZdIVLFXNekxF9HGFHub9frs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GorqDi92; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD85E40004;
	Wed, 17 Jul 2024 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721233030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SrYaoQxLask0o8StbX9HhWadPqjnC7PpqwbN4cFX15c=;
	b=GorqDi92lvAAQDKv2ACZwgRsZbMDh294JilFejrzm5j+hx4GRcFOXBDDPbXwRpspX5gfMN
	eF5YEq4j2KSalPUCUiwNYEGS0EPzolmzQmqT/RpOv4ADHvb26aCs0p34qUAe8DSUGuXHaY
	ZZzouYgAN6oWK1q/MlQWMhKn8lS3+LUldan1BF46JGT08iUPICUIa7K0KeBjy1yx0aBgix
	EmmdoZZXlOdR3bPtf3zuCdmyEatXod6RjQwc6HzXBmG1iKhsX9/LXsDnVd7ZEAh6tRdcM8
	ploGaekznUupUjnBeaYHGXMSDNo8wRw7qI9t2EOUE2ENH/Qbv+6qzjLaPXZeqw==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 17 Jul 2024 18:16:32 +0200
Subject: [PATCH v2] of: remove internal arguments from
 of_property_for_each_u32()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240717-of_property_for_each_u32-v2-1-4060990f49c9@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAF/ul2YC/3WNywqDMBBFf0Vm3ZTJaB901f8oEmJMaqB1ZGKlI
 v57U6HLLs+Be+4CyUv0CS7FAuKnmCL3GWhXgOtsf/cqtpmBkCo8oVYczCA8eBlnE1iMt64zr5J
 UdcTQItlDiw7yfBAf4ntL3+rMXUwjy7w9Tfprf9Hyf3TSClVFTgeHzZmsvTbM4yP2e8dPqNd1/
 QAlIdM0wgAAAA==
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
 Damien Le Moal <dlemoal@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Doug Berger <opendmb@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Jacky Bai <ping.bai@nxp.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
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
 linux-riscv@lists.infradead.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: luca.ceresoli@bootlin.com

The of_property_for_each_u32() macro needs five parameters, two of which
are primarily meant as internal variables for the macro itself (in the
for() clause). Yet these two parameters are used by a few drivers, and this
can be considered misuse or at least bad practice.

Now that the kernel uses C11 to build, these two parameters can be avoided
by declaring them internally, thus changing this pattern:

  struct property *prop;
  const __be32 *p;
  u32 val;

  of_property_for_each_u32(np, "xyz", prop, p, val) { ... }

to this:

  u32 val;

  of_property_for_each_u32(np, "xyz", val) { ... }

However two variables cannot be declared in the for clause even with C11,
so declare one struct that contain the two variables we actually need. As
the variables inside this struct are not meant to be used by users of this
macro, give the struct instance the noticeable name "_it" so it is visible
during code reviews, helping to avoid new code to use it directly.

Most usages are trivially converted as they do not use those two
parameters, as expected. The non-trivial cases are:

 - drivers/clk/clk.c, of_clk_get_parent_name(): easily doable anyway
 - drivers/clk/clk-si5351.c, si5351_dt_parse(): this is more complex as the
   checks had to be replicated in a different way, making code more verbose
   and somewhat uglier, but I refrained from a full rework to keep as much
   of the original code untouched having no hardware to test my changes

All the changes have been build tested. The few for which I have the
hardware have been runtime-tested too.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com> # drivers/clk/sunxi/clk-simple-gates.c, drivers/clk/sunxi/clk-sun8i-bus-gates.c
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org> # drivers/gpio/gpio-brcmstb.c
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com> # drivers/irqchip/irq-atmel-aic-common.c
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # drivers/iio/adc/ti_am335x_adc.c
Acked-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com> # drivers/pwm/pwm-samsung.c
Acked-by: Richard Leitner <richard.leitner@linux.dev> # drivers/usb/misc/usb251xb.c
Acked-by: Mark Brown <broonie@kernel.org> # sound/soc/codecs/arizona.c
Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com> # sound/soc/codecs/arizona.c
Acked-by: Michael Ellerman <mpe@ellerman.id.au> # arch/powerpc/sysdev/xive/spapr.c
---
[Note: to reduce the noise I have trimmed the get_maintainers list
manually. Should you want to be removed, or someone else added, to future
versions, just tell me. Sorry for the noise.]

This series aims at simplifying of_property_for_each_u32() as well as
making it more difficult to misuse it in the future.

The long-term goal is changing this pattern:

  struct property *prop;
  const __be32 *p;
  u32 val;
 
  of_property_for_each_u32(np, "xyz", prop, p, val) { ... }

to this:

  u32 val;

  of_property_for_each_u32(np, "xyz", val) { ... }

So, removing the 3rd and 4th arguments which are typically meant to be
internal. Those two parameters used to be unavoidable until the kernel
moved to building with the C11 standard unconditionally. Since then, it is
now possible to get rid of them. However a few users of
of_property_for_each_u32() do actually use those arguments, which
complicates the transition. For this reason this series does the following:

 * Add of_property_for_each_u32_new(), which does not have those two
   arguments (patch 1)
 * Convert _almost_ every usage to of_property_for_each_u32_new()
 * Rename of_property_for_each_u32() to of_property_for_each_u32_old() and
   deprecate it, as a incentive to code not (yet) in mainline to upgrade
   to the *_new() version (last patch)

The plan for the next series is to additionally:

 * Convert the few remaining of_property_for_each_u32_old() instantes to
   of_property_for_each_u32_new()
 * Remove of_property_for_each_u32_old()
 * Rename of_property_for_each_u32_new() to of_property_for_each_u32()
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com
---

Note! I have carried the ack/review tags received on v1, but since those
were on individual, per-driver patches I cannot claim the approve the whole
work. So I have added the specific file that was acked. For those who
reviewed v1 (thanks!), I'll assume that's OK unless you tell otherwise.

Changed in v2:
 - squashed into a single patch as suggested by Rob
   - so _new and _old macros do not appear anymore
   - added to To/Cc all names reported by get_maintainers instead of
     trimming as I did for v1
 - converted the few users not yet converted in v1
 - improve commit message
 - Link to v1: https://lore.kernel.org/r/20240703-of_property_for_each_u32-v1-0-42c1fc0b82aa@bootlin.com
---
 arch/powerpc/sysdev/xive/native.c       |  4 +--
 arch/powerpc/sysdev/xive/spapr.c        |  3 +--
 drivers/bus/ti-sysc.c                   |  4 +--
 drivers/clk/clk-conf.c                  |  4 +--
 drivers/clk/clk-si5351.c                | 43 ++++++++++++++++++++-------------
 drivers/clk/clk.c                       | 12 ++++-----
 drivers/clk/qcom/common.c               |  4 +--
 drivers/clk/sunxi/clk-simple-gates.c    |  4 +--
 drivers/clk/sunxi/clk-sun8i-bus-gates.c |  4 +--
 drivers/clocksource/samsung_pwm_timer.c |  4 +--
 drivers/gpio/gpio-brcmstb.c             |  5 +---
 drivers/iio/adc/ti_am335x_adc.c         |  4 +--
 drivers/irqchip/irq-atmel-aic-common.c  |  4 +--
 drivers/irqchip/irq-pic32-evic.c        |  4 +--
 drivers/mfd/ti_am335x_tscadc.c          |  4 +--
 drivers/pinctrl/nxp/pinctrl-s32cc.c     |  4 +--
 drivers/pinctrl/pinctrl-k210.c          |  4 +--
 drivers/pwm/pwm-samsung.c               |  4 +--
 drivers/tty/sysrq.c                     |  4 +--
 drivers/usb/misc/usb251xb.c             |  4 +--
 include/linux/of.h                      | 15 ++++++------
 sound/soc/codecs/arizona.c              | 12 ++++-----
 22 files changed, 61 insertions(+), 93 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
index 517b963e3e6a..a0934b516933 100644
--- a/arch/powerpc/sysdev/xive/native.c
+++ b/arch/powerpc/sysdev/xive/native.c
@@ -559,9 +559,7 @@ bool __init xive_native_init(void)
 	struct device_node *np;
 	struct resource r;
 	void __iomem *tima;
-	struct property *prop;
 	u8 max_prio = 7;
-	const __be32 *p;
 	u32 val, cpu;
 	s64 rc;
 
@@ -592,7 +590,7 @@ bool __init xive_native_init(void)
 		max_prio = val - 1;
 
 	/* Iterate the EQ sizes and pick one */
-	of_property_for_each_u32(np, "ibm,xive-eq-sizes", prop, p, val) {
+	of_property_for_each_u32(np, "ibm,xive-eq-sizes", val) {
 		xive_queue_shift = val;
 		if (val == PAGE_SHIFT)
 			break;
diff --git a/arch/powerpc/sysdev/xive/spapr.c b/arch/powerpc/sysdev/xive/spapr.c
index e45419264391..f2fa985a2c77 100644
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
+	of_property_for_each_u32(np, "ibm,xive-eq-sizes", val) {
 		xive_queue_shift = val;
 		if (val == PAGE_SHIFT)
 			break;
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 8767e04d6c89..2b59ef61dda2 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -2291,11 +2291,9 @@ static int sysc_init_idlemode(struct sysc *ddata, u8 *idlemodes,
 			      const char *name)
 {
 	struct device_node *np = ddata->dev->of_node;
-	struct property *prop;
-	const __be32 *p;
 	u32 val;
 
-	of_property_for_each_u32(np, name, prop, p, val) {
+	of_property_for_each_u32(np, name, val) {
 		if (val >= SYSC_NR_IDLEMODES) {
 			dev_err(ddata->dev, "invalid idlemode: %i\n", val);
 			return -EINVAL;
diff --git a/drivers/clk/clk-conf.c b/drivers/clk/clk-conf.c
index 1a4e6340f95c..058420562020 100644
--- a/drivers/clk/clk-conf.c
+++ b/drivers/clk/clk-conf.c
@@ -81,13 +81,11 @@ static int __set_clk_parents(struct device_node *node, bool clk_supplier)
 static int __set_clk_rates(struct device_node *node, bool clk_supplier)
 {
 	struct of_phandle_args clkspec;
-	struct property	*prop;
-	const __be32 *cur;
 	int rc, index = 0;
 	struct clk *clk;
 	u32 rate;
 
-	of_property_for_each_u32(node, "assigned-clock-rates", prop, cur, rate) {
+	of_property_for_each_u32(node, "assigned-clock-rates", rate) {
 		if (rate) {
 			rc = of_parse_phandle_with_args(node, "assigned-clocks",
 					"#clock-cells",	index, &clkspec);
diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 4ce83c5265b8..d4904f59f83f 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -1175,8 +1175,8 @@ static int si5351_dt_parse(struct i2c_client *client,
 {
 	struct device_node *child, *np = client->dev.of_node;
 	struct si5351_platform_data *pdata;
-	struct property *prop;
-	const __be32 *p;
+	u32 array[4];
+	int sz, i;
 	int num = 0;
 	u32 val;
 
@@ -1191,20 +1191,24 @@ static int si5351_dt_parse(struct i2c_client *client,
 	 * property silabs,pll-source : <num src>, [<..>]
 	 * allow to selectively set pll source
 	 */
-	of_property_for_each_u32(np, "silabs,pll-source", prop, p, num) {
+	sz = of_property_read_variable_u32_array(np, "silabs,pll-source", array, 2, 4);
+	sz = (sz == -EINVAL) ? 0 : sz; /* Missing property is OK */
+	if (sz < 0)
+		return dev_err_probe(&client->dev, sz, "invalid pll-source");
+	if (sz % 2)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "missing pll-source for pll %d\n", array[sz - 1]);
+
+	for (i = 0; i < sz; i += 2) {
+		num = array[i];
+		val = array[i + 1];
+
 		if (num >= 2) {
 			dev_err(&client->dev,
 				"invalid pll %d on pll-source prop\n", num);
 			return -EINVAL;
 		}
 
-		p = of_prop_next_u32(prop, p, &val);
-		if (!p) {
-			dev_err(&client->dev,
-				"missing pll-source for pll %d\n", num);
-			return -EINVAL;
-		}
-
 		switch (val) {
 		case 0:
 			pdata->pll_src[num] = SI5351_PLL_SRC_XTAL;
@@ -1232,19 +1236,24 @@ static int si5351_dt_parse(struct i2c_client *client,
 	pdata->pll_reset[0] = true;
 	pdata->pll_reset[1] = true;
 
-	of_property_for_each_u32(np, "silabs,pll-reset-mode", prop, p, num) {
+	sz = of_property_read_variable_u32_array(np, "silabs,pll-reset-mode", array, 2, 4);
+	sz = (sz == -EINVAL) ? 0 : sz; /* Missing property is OK */
+	if (sz < 0)
+		return dev_err_probe(&client->dev, sz, "invalid pll-reset-mode");
+	if (sz % 2)
+		return dev_err_probe(&client->dev, -EINVAL,
+				     "missing pll-reset-mode for pll %d\n", array[sz - 1]);
+
+	for (i = 0; i < sz; i += 2) {
+		num = array[i];
+		val = array[i + 1];
+
 		if (num >= 2) {
 			dev_err(&client->dev,
 				"invalid pll %d on pll-reset-mode prop\n", num);
 			return -EINVAL;
 		}
 
-		p = of_prop_next_u32(prop, p, &val);
-		if (!p) {
-			dev_err(&client->dev,
-				"missing pll-reset-mode for pll %d\n", num);
-			return -EINVAL;
-		}
 
 		switch (val) {
 		case 0:
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 8cca52be993f..285ed1ad8a37 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5364,9 +5364,8 @@ EXPORT_SYMBOL_GPL(of_clk_get_parent_count);
 const char *of_clk_get_parent_name(const struct device_node *np, int index)
 {
 	struct of_phandle_args clkspec;
-	struct property *prop;
 	const char *clk_name;
-	const __be32 *vp;
+	bool found = false;
 	u32 pv;
 	int rc;
 	int count;
@@ -5383,15 +5382,16 @@ const char *of_clk_get_parent_name(const struct device_node *np, int index)
 	/* if there is an indices property, use it to transfer the index
 	 * specified into an array offset for the clock-output-names property.
 	 */
-	of_property_for_each_u32(clkspec.np, "clock-indices", prop, vp, pv) {
+	of_property_for_each_u32(clkspec.np, "clock-indices", pv) {
 		if (index == pv) {
 			index = count;
+			found = true;
 			break;
 		}
 		count++;
 	}
 	/* We went off the end of 'clock-indices' without finding it */
-	if (prop && !vp)
+	if (of_property_present(clkspec.np, "clock-indices") && !found)
 		return NULL;
 
 	if (of_property_read_string_index(clkspec.np, "clock-output-names",
@@ -5504,14 +5504,12 @@ static int parent_ready(struct device_node *np)
 int of_clk_detect_critical(struct device_node *np, int index,
 			   unsigned long *flags)
 {
-	struct property *prop;
-	const __be32 *cur;
 	uint32_t idx;
 
 	if (!np || !flags)
 		return -EINVAL;
 
-	of_property_for_each_u32(np, "clock-critical", prop, cur, idx)
+	of_property_for_each_u32(np, "clock-critical", idx)
 		if (index == idx)
 			*flags |= CLK_IS_CRITICAL;
 
diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
index 48f81e3a5e80..5aff92bf5913 100644
--- a/drivers/clk/qcom/common.c
+++ b/drivers/clk/qcom/common.c
@@ -226,11 +226,9 @@ EXPORT_SYMBOL_GPL(qcom_cc_register_sleep_clk);
 static void qcom_cc_drop_protected(struct device *dev, struct qcom_cc *cc)
 {
 	struct device_node *np = dev->of_node;
-	struct property *prop;
-	const __be32 *p;
 	u32 i;
 
-	of_property_for_each_u32(np, "protected-clocks", prop, p, i) {
+	of_property_for_each_u32(np, "protected-clocks", i) {
 		if (i >= cc->num_rclks)
 			continue;
 
diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
index 0399627c226a..845efc1ec800 100644
--- a/drivers/clk/sunxi/clk-simple-gates.c
+++ b/drivers/clk/sunxi/clk-simple-gates.c
@@ -21,11 +21,9 @@ static void __init sunxi_simple_gates_setup(struct device_node *node,
 {
 	struct clk_onecell_data *clk_data;
 	const char *clk_parent, *clk_name;
-	struct property *prop;
 	struct resource res;
 	void __iomem *clk_reg;
 	void __iomem *reg;
-	const __be32 *p;
 	int number, i = 0, j;
 	u8 clk_bit;
 	u32 index;
@@ -47,7 +45,7 @@ static void __init sunxi_simple_gates_setup(struct device_node *node,
 	if (!clk_data->clks)
 		goto err_free_data;
 
-	of_property_for_each_u32(node, "clock-indices", prop, p, index) {
+	of_property_for_each_u32(node, "clock-indices", index) {
 		of_property_read_string_index(node, "clock-output-names",
 					      i, &clk_name);
 
diff --git a/drivers/clk/sunxi/clk-sun8i-bus-gates.c b/drivers/clk/sunxi/clk-sun8i-bus-gates.c
index b87f331f63c9..8482ac8e5898 100644
--- a/drivers/clk/sunxi/clk-sun8i-bus-gates.c
+++ b/drivers/clk/sunxi/clk-sun8i-bus-gates.c
@@ -24,11 +24,9 @@ static void __init sun8i_h3_bus_gates_init(struct device_node *node)
 	const char *parents[PARENT_MAX];
 	struct clk_onecell_data *clk_data;
 	const char *clk_name;
-	struct property *prop;
 	struct resource res;
 	void __iomem *clk_reg;
 	void __iomem *reg;
-	const __be32 *p;
 	int number, i;
 	u8 clk_bit;
 	int index;
@@ -58,7 +56,7 @@ static void __init sun8i_h3_bus_gates_init(struct device_node *node)
 		goto err_free_data;
 
 	i = 0;
-	of_property_for_each_u32(node, "clock-indices", prop, p, index) {
+	of_property_for_each_u32(node, "clock-indices", index) {
 		of_property_read_string_index(node, "clock-output-names",
 					      i, &clk_name);
 
diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 6e46781bc9ac..b9561e3f196c 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -418,8 +418,6 @@ void __init samsung_pwm_clocksource_init(void __iomem *base,
 static int __init samsung_pwm_alloc(struct device_node *np,
 				    const struct samsung_pwm_variant *variant)
 {
-	struct property *prop;
-	const __be32 *cur;
 	u32 val;
 	int i, ret;
 
@@ -427,7 +425,7 @@ static int __init samsung_pwm_alloc(struct device_node *np,
 	for (i = 0; i < SAMSUNG_PWM_NUM; ++i)
 		pwm.irq[i] = irq_of_parse_and_map(np, i);
 
-	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
+	of_property_for_each_u32(np, "samsung,pwm-outputs", val) {
 		if (val >= SAMSUNG_PWM_NUM) {
 			pr_warn("%s: invalid channel index in samsung,pwm-outputs property\n", __func__);
 			continue;
diff --git a/drivers/gpio/gpio-brcmstb.c b/drivers/gpio/gpio-brcmstb.c
index 8dce78ea7139..5762e517338e 100644
--- a/drivers/gpio/gpio-brcmstb.c
+++ b/drivers/gpio/gpio-brcmstb.c
@@ -591,8 +591,6 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	void __iomem *reg_base;
 	struct brcmstb_gpio_priv *priv;
 	struct resource *res;
-	struct property *prop;
-	const __be32 *p;
 	u32 bank_width;
 	int num_banks = 0;
 	int num_gpios = 0;
@@ -636,8 +634,7 @@ static int brcmstb_gpio_probe(struct platform_device *pdev)
 	flags = BGPIOF_BIG_ENDIAN_BYTE_ORDER;
 #endif
 
-	of_property_for_each_u32(np, "brcm,gpio-bank-widths", prop, p,
-			bank_width) {
+	of_property_for_each_u32(np, "brcm,gpio-bank-widths", bank_width) {
 		struct brcmstb_gpio_bank *bank;
 		struct gpio_chip *gc;
 
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 95fa857e8aad..426e3c9f88a1 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -564,13 +564,11 @@ static int tiadc_parse_dt(struct platform_device *pdev,
 			  struct tiadc_device *adc_dev)
 {
 	struct device_node *node = pdev->dev.of_node;
-	struct property *prop;
-	const __be32 *cur;
 	int channels = 0;
 	u32 val;
 	int i;
 
-	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
+	of_property_for_each_u32(node, "ti,adc-channels", val) {
 		adc_dev->channel_line[channels] = val;
 
 		/* Set Default values for optional DT parameters */
diff --git a/drivers/irqchip/irq-atmel-aic-common.c b/drivers/irqchip/irq-atmel-aic-common.c
index 072bd227b6c6..4525366d16d6 100644
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
+	of_property_for_each_u32(node, "atmel,external-irqs", hwirq) {
 		gc = irq_get_domain_generic_chip(domain, hwirq);
 		if (!gc) {
 			pr_warn("AIC: external irq %d >= %d skip it\n",
diff --git a/drivers/irqchip/irq-pic32-evic.c b/drivers/irqchip/irq-pic32-evic.c
index 277240325cbc..eb6ca516a166 100644
--- a/drivers/irqchip/irq-pic32-evic.c
+++ b/drivers/irqchip/irq-pic32-evic.c
@@ -190,13 +190,11 @@ static void __init pic32_ext_irq_of_init(struct irq_domain *domain)
 {
 	struct device_node *node = irq_domain_get_of_node(domain);
 	struct evic_chip_data *priv = domain->host_data;
-	struct property *prop;
-	const __le32 *p;
 	u32 hwirq;
 	int i = 0;
 	const char *pname = "microchip,external-irqs";
 
-	of_property_for_each_u32(node, pname, prop, p, hwirq) {
+	of_property_for_each_u32(node, pname, hwirq) {
 		if (i >= ARRAY_SIZE(priv->ext_irqs)) {
 			pr_warn("More than %d external irq, skip rest\n",
 				ARRAY_SIZE(priv->ext_irqs));
diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 4bbd542d753e..0c1364d88469 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -119,8 +119,6 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	struct clk *clk;
 	struct device_node *node;
 	struct mfd_cell *cell;
-	struct property *prop;
-	const __be32 *cur;
 	bool use_tsc = false, use_mag = false;
 	u32 val;
 	int err;
@@ -167,7 +165,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
 	}
 
 	node = of_get_child_by_name(pdev->dev.of_node, "adc");
-	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
+	of_property_for_each_u32(node, "ti,adc-channels", val) {
 		adc_channels++;
 		if (val > 7) {
 			dev_err(&pdev->dev, " PIN numbers are 0..7 (not %d)\n",
diff --git a/drivers/pinctrl/nxp/pinctrl-s32cc.c b/drivers/pinctrl/nxp/pinctrl-s32cc.c
index f0cad2c501f7..08d80fb935b3 100644
--- a/drivers/pinctrl/nxp/pinctrl-s32cc.c
+++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
@@ -735,9 +735,7 @@ static int s32_pinctrl_parse_groups(struct device_node *np,
 				     struct s32_pin_group *grp,
 				     struct s32_pinctrl_soc_info *info)
 {
-	const __be32 *p;
 	struct device *dev;
-	struct property *prop;
 	unsigned int *pins, *sss;
 	int i, npins;
 	u32 pinmux;
@@ -768,7 +766,7 @@ static int s32_pinctrl_parse_groups(struct device_node *np,
 		return -ENOMEM;
 
 	i = 0;
-	of_property_for_each_u32(np, "pinmux", prop, p, pinmux) {
+	of_property_for_each_u32(np, "pinmux", pinmux) {
 		pins[i] = get_pin_no(pinmux);
 		sss[i] = get_pin_func(pinmux);
 
diff --git a/drivers/pinctrl/pinctrl-k210.c b/drivers/pinctrl/pinctrl-k210.c
index b6d1ed9ec9a3..f4dcfa56c9e5 100644
--- a/drivers/pinctrl/pinctrl-k210.c
+++ b/drivers/pinctrl/pinctrl-k210.c
@@ -763,8 +763,6 @@ static int k210_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 					  unsigned int *reserved_maps,
 					  unsigned int *num_maps)
 {
-	struct property *prop;
-	const __be32 *p;
 	int ret, pinmux_groups;
 	u32 pinmux_group;
 	unsigned long *configs = NULL;
@@ -797,7 +795,7 @@ static int k210_pinctrl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
 	if (ret < 0)
 		goto exit;
 
-	of_property_for_each_u32(np, "pinmux", prop, p, pinmux_group) {
+	of_property_for_each_u32(np, "pinmux", pinmux_group) {
 		const char *group_name, *func_name;
 		u32 pin = FIELD_GET(K210_PG_PIN, pinmux_group);
 		u32 func = FIELD_GET(K210_PG_FUNC, pinmux_group);
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index efb60c9f0cb3..20734e7a216d 100644
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
+	of_property_for_each_u32(np, "samsung,pwm-outputs", val) {
 		if (val >= SAMSUNG_PWM_NUM) {
 			dev_err(pwmchip_parent(chip),
 				"%s: invalid channel index in samsung,pwm-outputs property\n",
diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index e5974b8239c9..dab332681036 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -770,8 +770,6 @@ static void sysrq_of_get_keyreset_config(void)
 {
 	u32 key;
 	struct device_node *np;
-	struct property *prop;
-	const __be32 *p;
 
 	np = of_find_node_by_path("/chosen/linux,sysrq-reset-seq");
 	if (!np) {
@@ -782,7 +780,7 @@ static void sysrq_of_get_keyreset_config(void)
 	/* Reset in case a __weak definition was present */
 	sysrq_reset_seq_len = 0;
 
-	of_property_for_each_u32(np, "keyset", prop, p, key) {
+	of_property_for_each_u32(np, "keyset", key) {
 		if (key == KEY_RESERVED || key > KEY_MAX ||
 		    sysrq_reset_seq_len == SYSRQ_KEY_RESET_MAX)
 			break;
diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 7da404f55a6d..3970bf9ca818 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -382,11 +382,9 @@ static void usb251xb_get_ports_field(struct usb251xb *hub,
 				    bool ds_only, u8 *fld)
 {
 	struct device *dev = hub->dev;
-	struct property *prop;
-	const __be32 *p;
 	u32 port;
 
-	of_property_for_each_u32(dev->of_node, prop_name, prop, p, port) {
+	of_property_for_each_u32(dev->of_node, prop_name, port) {
 		if ((port >= ds_only ? 1 : 0) && (port <= port_cnt))
 			*fld |= BIT(port);
 		else
diff --git a/include/linux/of.h b/include/linux/of.h
index a0bedd038a05..13ad808bb8f7 100644
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
+ * of_property_for_each_u32(np, "propname", u)
  *         printk("U32 value: %x\n", u);
  */
 const __be32 *of_prop_next_u32(struct property *prop, const __be32 *cur,
@@ -1431,11 +1429,12 @@ static inline int of_property_read_s32(const struct device_node *np,
 	     err == 0;							\
 	     err = of_phandle_iterator_next(it))
 
-#define of_property_for_each_u32(np, propname, prop, p, u)	\
-	for (prop = of_find_property(np, propname, NULL),	\
-		p = of_prop_next_u32(prop, NULL, &u);		\
-		p;						\
-		p = of_prop_next_u32(prop, p, &u))
+#define of_property_for_each_u32(np, propname, u)			\
+	for (struct {struct property *prop; const __be32 *item; } _it =	\
+		{of_find_property(np, propname, NULL),			\
+		 of_prop_next_u32(_it.prop, NULL, &u)};			\
+	     _it.item;							\
+	     _it.item = of_prop_next_u32(_it.prop, _it.item, &u))
 
 #define of_property_for_each_string(np, propname, prop, s)	\
 	for (prop = of_find_property(np, propname, NULL),	\
diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 7434aeeda292..402b9a2ff024 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -2786,15 +2786,13 @@ int arizona_of_get_audio_pdata(struct arizona *arizona)
 {
 	struct arizona_pdata *pdata = &arizona->pdata;
 	struct device_node *np = arizona->dev->of_node;
-	struct property *prop;
-	const __be32 *cur;
 	u32 val;
 	u32 pdm_val[ARIZONA_MAX_PDM_SPK];
 	int ret;
 	int count = 0;
 
 	count = 0;
-	of_property_for_each_u32(np, "wlf,inmode", prop, cur, val) {
+	of_property_for_each_u32(np, "wlf,inmode", val) {
 		if (count == ARRAY_SIZE(pdata->inmode))
 			break;
 
@@ -2803,7 +2801,7 @@ int arizona_of_get_audio_pdata(struct arizona *arizona)
 	}
 
 	count = 0;
-	of_property_for_each_u32(np, "wlf,dmic-ref", prop, cur, val) {
+	of_property_for_each_u32(np, "wlf,dmic-ref", val) {
 		if (count == ARRAY_SIZE(pdata->dmic_ref))
 			break;
 
@@ -2812,7 +2810,7 @@ int arizona_of_get_audio_pdata(struct arizona *arizona)
 	}
 
 	count = 0;
-	of_property_for_each_u32(np, "wlf,out-mono", prop, cur, val) {
+	of_property_for_each_u32(np, "wlf,out-mono", val) {
 		if (count == ARRAY_SIZE(pdata->out_mono))
 			break;
 
@@ -2821,7 +2819,7 @@ int arizona_of_get_audio_pdata(struct arizona *arizona)
 	}
 
 	count = 0;
-	of_property_for_each_u32(np, "wlf,max-channels-clocked", prop, cur, val) {
+	of_property_for_each_u32(np, "wlf,max-channels-clocked", val) {
 		if (count == ARRAY_SIZE(pdata->max_channels_clocked))
 			break;
 
@@ -2830,7 +2828,7 @@ int arizona_of_get_audio_pdata(struct arizona *arizona)
 	}
 
 	count = 0;
-	of_property_for_each_u32(np, "wlf,out-volume-limit", prop, cur, val) {
+	of_property_for_each_u32(np, "wlf,out-volume-limit", val) {
 		if (count == ARRAY_SIZE(pdata->out_vol_limit))
 			break;
 

---
base-commit: d2f2d929511d092e52f9e50371f8da76d8979a82
change-id: 20240701-of_property_for_each_u32-460fd02a5d0c

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


