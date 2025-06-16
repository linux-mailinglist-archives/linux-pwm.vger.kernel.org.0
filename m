Return-Path: <linux-pwm+bounces-6383-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE45ADB512
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 17:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC91616FEB3
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Jun 2025 15:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF186220F26;
	Mon, 16 Jun 2025 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="cWd0mtWm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A121B1DE3DB;
	Mon, 16 Jun 2025 15:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750086893; cv=pass; b=OlwgeJi8pDaCzPyaFe/05cvPl8WHrDyMcHV2DjbSHy8rvee1jrkKMRCX5jdh2lfG3xM5MZU0Eut7QVpyag6BJWLO5ZD+v3+a0fd/ABtrNSDfVbfR6XyEqJk5d0EKMSLPNBXLGlilc9B3XwD/8vznnZBnqHexmGcDfN6ifpa9b9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750086893; c=relaxed/simple;
	bh=aqsRFdFMPRIP1+Gnx2TjQFvGRQJiWaL73aLSzeyzaOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=XqVVouVuOHVV4cQfT7etRcT4g4H6CV3zRRDTiXYAaVOW7kLWIgwm9i/5BpFHcjyl3dvBzML/jOIef8ianAiGaVfxhfez/PGEEQNjJ5GMb+lHvdUu1g5Q7fB1Y69dpKZhaYGFylSHwZNrzwC92kePEnBoGhNsOyXuXLXYiRzMBWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=cWd0mtWm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750086872; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=EvU5d9TIxEm+JTfOsqIQGCWFN48GYRO4qI9vxqtfzku9NXfP+NJQtipldDMLMRyyrI6hB2BIn/BZst5A5A8V34I6mkRqneV8vqnfDEacGvrgzJnfy+ZKPz1yVvjdYocOGtA+QnmdURRPLn3/kNqf3nFi7XFubUzf5/Jvzdlqfk0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750086872; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tQv5+pAc4L4C91UEGWLn8BUX0WiW4pl4M8ey8WEjjO4=; 
	b=hdesGNgliCkoICR0FlF/XaOZd31CUpqr1r95kW5mgm6GFIWKJM4fUwNpz8faMJ8ZoR8GFwW3BskHe7BlXkHy9wqAHPLdRrfi1skB+dh2eBDwLWILqbqlJbyC4zv+hcboJOrKAYQMhWSpAGX1txVHYYrOi7Dk4lA6Las2nLBmsdQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750086872;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=tQv5+pAc4L4C91UEGWLn8BUX0WiW4pl4M8ey8WEjjO4=;
	b=cWd0mtWm0NDl0awihGP9/lf5IfA27beVvuEe1KbSF2KWuz3wAqFAAswkp39qcSH2
	O1Ul+PJqaxw7nUp4ITeWFuhLguGOqoSjiek89cQLU3uBfQ1keYeqS6X8o4MvTQljcCP
	vtgC+Zx7pTbksuz25YjuXWe3ekTL42GN1aIbFKDY=
Received: by mx.zohomail.com with SMTPS id 1750086870650857.0304431538276;
	Mon, 16 Jun 2025 08:14:30 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 16 Jun 2025 17:14:17 +0200
Subject: [PATCH v2] pwm: rockchip: round period/duty down on apply, up on
 get
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-rockchip-pwm-rounding-fix-v2-1-a9c65acad7b6@collabora.com>
X-B4-Tracking: v=1; b=H4sIAMg0UGgC/42OTQ6CMBCFr0Jm7Zi2pvVn5T2Mi1JGmCgttogYw
 t2tcAGX30ve+94EiSJTglMxQaSBEwefQW0KcI31NSFXmUEJpYVWCmNwd9dwh927zfDyFfsabzz
 i8WB3RrijoIOE3O8i5XjZvlxXjvR8ZUW/hlDaROhC23J/KjyNPS4aIw38Cg2nPsTP8m2QS+OPG
 4NEiaWWxlZ7Y5W2ZxceD1uGaLfZBdd5nr9jf1WW9wAAAA==
X-Change-ID: 20250522-rockchip-pwm-rounding-fix-98a360c90e81
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Brian Norris <briannorris@chromium.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@collabora.com, linux-pwm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

With CONFIG_PWM_DEBUG=y, the rockchip PWM driver produces warnings like
this:

  rockchip-pwm fd8b0010.pwm: .apply is supposed to round down
  duty_cycle (requested: 23529/50000, applied: 23542/50000)

This is because the driver chooses ROUND_CLOSEST for purported
idempotency reasons. However, it's possible to keep idempotency while
always rounding down in .apply.

Do this by making get_state always round up, and making apply always
round down. This is done with u64 maths, and setting both period and
duty to U32_MAX (the biggest the hardware can support) if they would
exceed their 32 bits confines.

Fixes: 12f9ce4a5198 ("pwm: rockchip: Fix period and duty cycle approximation")
Fixes: 1ebb74cf3537 ("pwm: rockchip: Add support for hardware readout")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
This fix may need some careful testing from others before definitely
being applied and backported. While I did test it myself of course,
making sure to try a combination of periods and duty cycles, I really
don't want to accidentally undo someone else's fix.

Some of the u64 math is a bit overkill, but I don't want to assume
prescalers will never get larger than 4, which is where we start needing
the 64-bit prescaled NSECS_PER_SEC value. clk_rate could also
comfortably fit within u32 for any expected clock rate, but unsigned
long can fit more depending on architecture, even if nobody is running
the PWM hardware at 4.294967296 GHz.
---
Changes in v2:
- rename "period" and "duty" to "period_ticks" and "duty_ticks" as per
  ukleinek's review
- slightly modify commit message to add "purported", in order to make it
  clearer that ROUND_CLOSEST and idempotency are orthogonal things and
  that it worked out in this case was happenstance
- Link to v1: https://lore.kernel.org/r/20250522-rockchip-pwm-rounding-fix-v1-1-b516ad76a25a@collabora.com
---
 drivers/pwm/pwm-rockchip.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index c5f50e5eaf41ac7539f59fa03f427eee6263ca90..67b85bdb491b13cedb67c52de614f4ad9be427c5 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -8,6 +8,8 @@
 
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/limits.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -61,6 +63,7 @@ static int rockchip_pwm_get_state(struct pwm_chip *chip,
 				  struct pwm_state *state)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
+	u64 prescaled_ns = (u64)pc->data->prescaler * NSEC_PER_SEC;
 	u32 enable_conf = pc->data->enable_conf;
 	unsigned long clk_rate;
 	u64 tmp;
@@ -78,12 +81,12 @@ static int rockchip_pwm_get_state(struct pwm_chip *chip,
 	clk_rate = clk_get_rate(pc->clk);
 
 	tmp = readl_relaxed(pc->base + pc->data->regs.period);
-	tmp *= pc->data->prescaler * NSEC_PER_SEC;
-	state->period = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
+	tmp *= prescaled_ns;
+	state->period = DIV_U64_ROUND_UP(tmp, clk_rate);
 
 	tmp = readl_relaxed(pc->base + pc->data->regs.duty);
-	tmp *= pc->data->prescaler * NSEC_PER_SEC;
-	state->duty_cycle =  DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
+	tmp *= prescaled_ns;
+	state->duty_cycle =  DIV_U64_ROUND_UP(tmp, clk_rate);
 
 	val = readl_relaxed(pc->base + pc->data->regs.ctrl);
 	state->enabled = (val & enable_conf) == enable_conf;
@@ -103,8 +106,9 @@ static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			       const struct pwm_state *state)
 {
 	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
-	unsigned long period, duty;
-	u64 clk_rate, div;
+	u64 prescaled_ns = (u64)pc->data->prescaler * NSEC_PER_SEC;
+	u64 clk_rate, tmp;
+	u32 period_ticks, duty_ticks;
 	u32 ctrl;
 
 	clk_rate = clk_get_rate(pc->clk);
@@ -114,12 +118,15 @@ static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * bits, every possible input period can be obtained using the
 	 * default prescaler value for all practical clock rate values.
 	 */
-	div = clk_rate * state->period;
-	period = DIV_ROUND_CLOSEST_ULL(div,
-				       pc->data->prescaler * NSEC_PER_SEC);
+	tmp = mul_u64_u64_div_u64(clk_rate, state->period, prescaled_ns);
+	if (tmp > U32_MAX)
+		tmp = U32_MAX;
+	period_ticks = tmp;
 
-	div = clk_rate * state->duty_cycle;
-	duty = DIV_ROUND_CLOSEST_ULL(div, pc->data->prescaler * NSEC_PER_SEC);
+	tmp = mul_u64_u64_div_u64(clk_rate, state->duty_cycle, prescaled_ns);
+	if (tmp > U32_MAX)
+		tmp = U32_MAX;
+	duty_ticks = tmp;
 
 	/*
 	 * Lock the period and duty of previous configuration, then
@@ -131,8 +138,8 @@ static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		writel_relaxed(ctrl, pc->base + pc->data->regs.ctrl);
 	}
 
-	writel(period, pc->base + pc->data->regs.period);
-	writel(duty, pc->base + pc->data->regs.duty);
+	writel(period_ticks, pc->base + pc->data->regs.period);
+	writel(duty_ticks, pc->base + pc->data->regs.duty);
 
 	if (pc->data->supports_polarity) {
 		ctrl &= ~PWM_POLARITY_MASK;

---
base-commit: 67a08d8299798b4748f0194002566abc14c0cb23
change-id: 20250522-rockchip-pwm-rounding-fix-98a360c90e81

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


