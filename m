Return-Path: <linux-pwm+bounces-6934-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD4CB197AA
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 02:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD24A1895BBC
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 00:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CA21A2C06;
	Mon,  4 Aug 2025 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSlbZz6l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B540184540;
	Mon,  4 Aug 2025 00:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267371; cv=none; b=ElAbmJL7UBWX1RSsCZSxBB3dNhamcR6XAimfay/EV8KTUA6n6IjD3hMLmRUKMa+PWLFjAFQ3nKen4xVCEFkzcCIHPG4DUQN5RQnPDZyYG7MyMxad9YKGDpJCgKY75cxbL2nQmkdH4i2TjFIOpjXGzq3T3hAuGexYTCW8784/P9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267371; c=relaxed/simple;
	bh=Bs4/OINydRglnxEUwlgHZgeJZiSHvx3ERL02s0xacnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eSC6U4rUyohoQ9xQjg0W1Ve3SZenJR+PxhC/fO0w1FNtc6f5UoWkZS5wc1WMrAv3KuXJKUeS9CsUJEkSPTScxBybS6b0DENpqfDHbevU+Wj6cP91OmlNCskmBoxOJdkLkcNPxArZ4iFPQXDIezk5+WrVqGoz903RDbo+4/thhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSlbZz6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C584C4CEF0;
	Mon,  4 Aug 2025 00:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267371;
	bh=Bs4/OINydRglnxEUwlgHZgeJZiSHvx3ERL02s0xacnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GSlbZz6laP6uI7ZfT7pxHLAhd+1BMcF47idq9mL4qw4ZeGAleplQJ94Iod047ImZt
	 TFkYbAMtvGsZxtucB2YfJlCTXFl+1Xe17y9MHRPuzvACfX5Jqwkh3E8brQAqyXZ1s1
	 oEDW7tNNmBoik+Lcj8V0QjeLFdSD8vGAkiAMJ9GEcvTJZLlSvYxHiGpe8GwuLviLGC
	 pmCxWmALzT82TjrH452nRLo7e1KW0zS9R++YEV/FOBSXXBCtmMtUvYyv8krElj/K/K
	 cWrL+cypeFqAFrB5zbrXB/kJBzRWdSyuemRa75giQEj1yXJyGovRoLH7VXY7pzdm+R
	 qghl/g/gVHC3g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Nylon Chen <nylon.chen@sifive.com>,
	Zong Li <zong.li@sifive.com>,
	Vincent Chen <vincent.chen@sifive.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH AUTOSEL 6.15 40/80] pwm: sifive: Fix PWM algorithm and clarify inverted compare behavior
Date: Sun,  3 Aug 2025 20:27:07 -0400
Message-Id: <20250804002747.3617039-40-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002747.3617039-1-sashal@kernel.org>
References: <20250804002747.3617039-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.9
Content-Transfer-Encoding: 8bit

From: Nylon Chen <nylon.chen@sifive.com>

[ Upstream commit 7dbc4432ea6bf9d709391eb57f1e9fb44e99845a ]

The `frac` variable represents the pulse inactive time, and the result
of this algorithm is the pulse active time. Therefore, we must reverse
the result.

Although the SiFive Reference Manual states "pwms >= pwmcmpX -> HIGH",
the hardware behavior is inverted due to a fixed XNOR with 0. As a result,
the pwmcmp register actually defines the low (inactive) portion of the pulse.

The reference is SiFive FU740-C000 Manual[0]

Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b16acba_fu740-c000-manual-v1p6.pdf [0]

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
Link: https://lore.kernel.org/r/20250529035341.51736-3-nylon.chen@sifive.com
Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
extensive analysis:

## Critical Bug Fix Analysis

1. **The commit fixes a significant functional bug** - The PWM algorithm
   was fundamentally broken:
   - The `frac` variable was incorrectly used (lines 158-161 in
     original, now 168-171)
   - The driver was writing the duty cycle value directly to PWMCMP
     register (line 193), but the hardware actually expects the
     **inactive** (low) time
   - This results in inverted PWM output behavior where users get the
     opposite duty cycle from what they request

2. **Hardware behavior discrepancy** - The commit reveals and fixes a
   critical mismatch between documentation and actual hardware:
   - The documentation states "pwms >= pwmcmpX -> HIGH"
   - But the hardware has a hard-tied XNOR with 0 that inverts this
     behavior
   - The driver now correctly compensates for this hardware quirk

3. **User-visible impact**:
   - **In `pwm_sifive_get_state()`**: The driver now correctly inverts
     the value read from hardware (lines 115->122-126)
   - **In `pwm_sifive_apply()`**: The driver now inverts the duty cycle
     before writing to hardware (lines 162->171)
   - **Polarity change**: Changed from `PWM_POLARITY_INVERSED` to
     `PWM_POLARITY_NORMAL` (lines 126->137, 142->152)
   - **Documentation fix**: Updated comment from "cannot generate 100%
     duty" to "cannot generate 0% duty" (lines 11->27, 160->170)

4. **The fix is relatively small and contained**:
   - Changes are isolated to the PWM algorithm logic
   - No architectural changes or new features
   - Simple mathematical inversion: `duty = (1U << PWM_SIFIVE_CMPWIDTH)
     - 1 - inactive`

5. **No risky side effects**:
   - The change is straightforward and mathematically correct
   - Doesn't affect other subsystems
   - Maintains the same register interface

6. **Affects all SiFive PWM users**:
   - Any system using SiFive FU540 or FU740 SoCs would have incorrect
     PWM output
   - This includes various RISC-V development boards and embedded
     systems
   - Users would get inverted duty cycles, potentially breaking motor
     controls, LED dimming, etc.

7. **Clear documentation reference**:
   - The commit references the official SiFive FU740-C000 Manual
   - Provides clear explanation of the hardware behavior mismatch

The bug causes PWM outputs to be inverted from user expectations, which
is a significant functional issue that would affect any system relying
on proper PWM behavior for motor control, LED dimming, or other PWM-
dependent functionality. The fix is clean, minimal, and addresses a
clear hardware/software mismatch that exists in production systems.

 drivers/pwm/pwm-sifive.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index d5b647e6be78..f3694801d3ee 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -4,11 +4,28 @@
  * For SiFive's PWM IP block documentation please refer Chapter 14 of
  * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pdf
  *
+ * PWM output inversion: According to the SiFive Reference manual
+ * the output of each comparator is high whenever the value of pwms is
+ * greater than or equal to the corresponding pwmcmpX[Reference Manual].
+ *
+ * Figure 29 in the same manual shows that the pwmcmpXcenter bit is
+ * hard-tied to 0 (XNOR), which effectively inverts the comparison so that
+ * the output goes HIGH when  `pwms < pwmcmpX`.
+ *
+ * In other words, each pwmcmp register actually defines the **inactive**
+ * (low) period of the pulse, not the active time exactly opposite to what
+ * the documentation text implies.
+ *
+ * To compensate, this driver always **inverts** the duty value when reading
+ * or writing pwmcmp registers , so that users interact with a conventional
+ * **active-high** PWM interface.
+ *
+ *
  * Limitations:
  * - When changing both duty cycle and period, we cannot prevent in
  *   software that the output might produce a period with mixed
  *   settings (new period length and old duty cycle).
- * - The hardware cannot generate a 100% duty cycle.
+ * - The hardware cannot generate a 0% duty cycle.
  * - The hardware generates only inverted output.
  */
 #include <linux/clk.h>
@@ -110,9 +127,14 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				struct pwm_state *state)
 {
 	struct pwm_sifive_ddata *ddata = pwm_sifive_chip_to_ddata(chip);
-	u32 duty, val;
+	u32 duty, val, inactive;
 
-	duty = readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	inactive = readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	/*
+	 * PWM hardware uses 'inactive' counts in pwmcmp, so invert to get actual duty.
+	 * Here, 'inactive' is the low time and we compute duty as max_count - inactive.
+	 */
+	duty = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - inactive;
 
 	state->enabled = duty > 0;
 
@@ -123,7 +145,7 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->period = ddata->real_period;
 	state->duty_cycle =
 		(u64)duty * ddata->real_period >> PWM_SIFIVE_CMPWIDTH;
-	state->polarity = PWM_POLARITY_INVERSED;
+	state->polarity = PWM_POLARITY_NORMAL;
 
 	return 0;
 }
@@ -137,9 +159,9 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long num;
 	bool enabled;
 	int ret = 0;
-	u32 frac;
+	u32 frac, inactive;
 
-	if (state->polarity != PWM_POLARITY_INVERSED)
+	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
 	cur_state = pwm->state;
@@ -157,8 +179,9 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
 	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
-	/* The hardware cannot generate a 100% duty cycle */
+	/* The hardware cannot generate a 0% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	inactive = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
 
 	mutex_lock(&ddata->lock);
 	if (state->period != ddata->approx_period) {
@@ -190,7 +213,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-	writel(frac, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	writel(inactive, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
 
 	if (!state->enabled)
 		clk_disable(ddata->clk);
-- 
2.39.5


