Return-Path: <linux-pwm+bounces-6099-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF80AC14CF
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 21:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BE87A4FCE
	for <lists+linux-pwm@lfdr.de>; Thu, 22 May 2025 19:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16A288C05;
	Thu, 22 May 2025 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="gkUZUsht"
X-Original-To: linux-pwm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01EF2036FA;
	Thu, 22 May 2025 19:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747942043; cv=pass; b=aiJ7O04yc8RWENkFVkn/79QdF1KG/Q+52wQb8uqymiJOV4aulKe1Ylq3VN4T8j8AGPBMEral75y+JxkabRVOca3aLDcNXhAO5JBKdwCjx7nHVb+0xAE61RL4aGuwIIJmWInZMJU3IBmRYMJZw5mE+oHu2TJAugjm4DG6498Wetw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747942043; c=relaxed/simple;
	bh=uTYOQyPePK9NBePWjUBS1H0sCndAGXIoJvcnIbmQ8v0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q1hSdDmIWDshuBJLNllsm22n2qkRsi6ERLLRkLgyUM6AbbSg71F0WNO3xa2UYKT3D9/dL7nwyucJxBfv6zBOgraj7BdsElxRIQEzI2ESEMYO08Ti7Ld5yiRKQhw5cICdckbRVUJYhM9gvMWO8q+MjOvMx1tC3ATCGjLkjGCyxV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=gkUZUsht; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1747942021; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l4Gg25EeLEA1PB0GOBF6OIyIQVjdmVFp92feHIxrVdW7lbgBKQzvzjxRTAvneGeZegExkv94EiRdssvKiZdSiaphcdTLf6ekcKhvW6wHiOKpYiLNum4TqhbnnOc39zhfs1weTC6+MzO1VRoU1W1l6ua5tPai6DsypM7NqfOI8WQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747942021; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AJzBv5LvwO9EFRe8OVUlb9OM9yAWwvged+nVh5RBniI=; 
	b=FvEiYz+Zk3Zx8Wjzj2Wj30/OkSKlahTbUJxZa7YzPE5u1YUvZiMCZXOc4Jc36LFnDLX/C8J1SwYBX9f9FrkmnAHgiMQ823Ot/b/OKoCTdH7fTi5leQIeyhBLFgMTLqEOXUDrUHUOEFDVm9uRBZxH0G4xo64R+noNyFkEnKDvgA0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747942021;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=AJzBv5LvwO9EFRe8OVUlb9OM9yAWwvged+nVh5RBniI=;
	b=gkUZUsht3DMKagUvyLNTwgLMsMMFHBh/eQHXKLF4AUveD1CrnwbuiGvyWIVw+4C/
	8zHMhEY9HMsCU49eeIjTjCDxF/aQ/7+68Q5Hr5+Y7Zk9gKi0T3gjcecgswUmQBM0kNQ
	EG2yk6IUwci2sucS8fKh6Bh/1cmhNpnjwzJAxxNk=
Received: by mx.zohomail.com with SMTPS id 1747942019407306.2477470606051;
	Thu, 22 May 2025 12:26:59 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 22 May 2025 21:26:44 +0200
Subject: [PATCH] pwm: rockchip: round period/duty down on apply, up on get
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-rockchip-pwm-rounding-fix-v1-1-b516ad76a25a@collabora.com>
X-B4-Tracking: v=1; b=H4sIAHN6L2gC/zWNywqDMBBFf0Vm3YGYYlF/pbhI41SHkkeTaAXx3
 ztUujwH7j07ZEpMGfpqh0QrZw5eoL5UYGfjJ0IehUEr3ahGa0zBvuzMEePHCSx+ZD/hkzfsWnO
 9KdspamuQfUwk+vd9H05O9F4kUU4JD5MJbXCOS1952gr+MzAcxxejJ93onAAAAA==
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

This is because the driver chooses ROUND_CLOSEST for idempotency
reasons. However, it's possible to keep idempotency while always
rounding down in .apply.

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
 drivers/pwm/pwm-rockchip.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index c5f50e5eaf41ac7539f59fa03f427eee6263ca90..983c7354becddd1d322a0b9c2947e0a4603c52dd 100644
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
+	u32 period, duty;
 	u32 ctrl;
 
 	clk_rate = clk_get_rate(pc->clk);
@@ -114,12 +118,15 @@ static void rockchip_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * bits, every possible input period can be obtained using the
 	 * default prescaler value for all practical clock rate values.
 	 */
-	div = clk_rate * state->period;
-	period = DIV_ROUND_CLOSEST_ULL(div,
-				       pc->data->prescaler * NSEC_PER_SEC);
-
-	div = clk_rate * state->duty_cycle;
-	duty = DIV_ROUND_CLOSEST_ULL(div, pc->data->prescaler * NSEC_PER_SEC);
+	tmp = mul_u64_u64_div_u64(clk_rate, state->period, prescaled_ns);
+	if (tmp > U32_MAX)
+		tmp = U32_MAX;
+	period = tmp;
+
+	tmp = mul_u64_u64_div_u64(clk_rate, state->duty_cycle, prescaled_ns);
+	if (tmp > U32_MAX)
+		tmp = U32_MAX;
+	duty = tmp;
 
 	/*
 	 * Lock the period and duty of previous configuration, then

---
base-commit: 6add743d2854d744c3037235b87c1c9d164fd132
change-id: 20250522-rockchip-pwm-rounding-fix-98a360c90e81

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


