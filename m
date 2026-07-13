Return-Path: <linux-pwm+bounces-9698-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xO/oGo+pVGofpAMAu9opvQ
	(envelope-from <linux-pwm+bounces-9698-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2026 11:02:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E797490DD
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2026 11:02:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=N+L02ROx;
	dmarc=pass (policy=none) header.from=samsung.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9698-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9698-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE0603008797
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jul 2026 08:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9550A3B47CA;
	Mon, 13 Jul 2026 08:57:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4683C819C
	for <linux-pwm@vger.kernel.org>; Mon, 13 Jul 2026 08:57:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933030; cv=none; b=SLzd2UpqiRyf07l7Ji85SU0AyoTomV7qCT9Yqr25mBRyEHghyul/gwMTXqp9/K679IrGmeiAn1b1vBUexKuIsIbocZqzG7195mXBIGMndPlmVeBsvwbvZvm6LNAbNb+XE0RehH2d9cBucXqxF0s1RJlGP6BDNHnoQ8lPCNcUGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933030; c=relaxed/simple;
	bh=7xdo47OoInW9CFilMjOfyuyIlabmP2wDft7mnsavMts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=cQpeaUetmLVB5IeJoFtaYXH4QbTBg9oT3zPZWVjhu+2p9HGUNZkLudoRVche5qwmL6h3AgFxa12A7yEx8jQk/HiU1K9ESaVnrmT2B3KvJeJEOKaqPjsM6lHtM0Zpx9b5B0MxBeqE9sVooxaMafLPWbXObwsH+9YrL4FmO3lNSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=N+L02ROx; arc=none smtp.client-ip=210.118.77.12
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260713085705euoutp02ec9245f7400e85297fe4a491c28fb276~BzaKdwsvm1905119051euoutp02T
	for <linux-pwm@vger.kernel.org>; Mon, 13 Jul 2026 08:57:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260713085705euoutp02ec9245f7400e85297fe4a491c28fb276~BzaKdwsvm1905119051euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783933025;
	bh=/3QXJR6EryD6qCplDBbOa7whllutEv/MeK2RFO/oll0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=N+L02ROxh6NWIg53hsla2SvNv64cIZ8ptLZdIz9QklnX+tsnIUM1hxE9HfjnGv+FH
	 4BHJIKJvIhQflduFCEHbz18Y0Df+GDNVxwfVCe4N8Vj4UWFqEpPLn0bUEf4w7ijhHp
	 XLXFCP8cHS+OaYyDmcGAaxQoU64YZ6pGswjZyQ4o=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260713085705eucas1p26616e64d55f903a6f87dd67e8f8da1a9~BzaKNI_l93222832228eucas1p2u;
	Mon, 13 Jul 2026 08:57:05 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260713085704eusmtip2f61d98d941075c01f20836c909385f5c~BzaJoZvgx3237032370eusmtip2f;
	Mon, 13 Jul 2026 08:57:04 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: 
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Alim Akhtar
	<alim.akhtar@samsung.com>, Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, "Uwe Kleine-K.nig" <ukleinek@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: [PATCH] clocksource/drivers/samsung_pwm: switch to raw_spinlock_t
 type
Date: Mon, 13 Jul 2026 10:56:53 +0200
Message-Id: <20260713085653.1145015-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260713085705eucas1p26616e64d55f903a6f87dd67e8f8da1a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260713085705eucas1p26616e64d55f903a6f87dd67e8f8da1a9
X-EPHeader: CA
X-CMS-RootMailID: 20260713085705eucas1p26616e64d55f903a6f87dd67e8f8da1a9
References: <CGME20260713085705eucas1p26616e64d55f903a6f87dd67e8f8da1a9@eucas1p2.samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9698-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[m.szyprowski@samsung.com,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:m.szyprowski@samsung.com,m:krzk@kernel.org,m:peter.griffin@linaro.org,m:alim.akhtar@samsung.com,m:daniel.lezcano@kernel.org,m:tglx@kernel.org,m:ukleinek@kernel.org,m:bigeasy@linutronix.de,m:linux-arm-kernel@lists.infradead.org,m:linux-samsung-soc@vger.kernel.org,m:linux-pwm@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m.szyprowski@samsung.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[samsung.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,pwm.base:url,samsung.com:from_mime,samsung.com:email,samsung.com:mid,samsung.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2E797490DD

Samsung PWM timer might be used as a clock source on some legacy systems.
When PREEMPT_RT is enabled on ARM, regular spinlock is converted to a
sleeping lock (mutex-based), which must not be used in atomic context
such as hard interrupt handlers. Switch the samsung_pwm_lock to the
raw_spinlock, which remains a true non-sleeping spinlock even
under PREEMPT_RT.

Fixes: 7aac482e6290 ("clocksource: samsung_pwm_timer: Make PWM spinlock global")
Fixes: f11899894c0a ("clocksource: add samsung pwm timer driver")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
This fixes the following warning observed during boot, when
CONFIG_PROVE_RAW_LOCK_NESTING is set:

 clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
 Exynos4210 clocks: sclk_apll = 800000000, sclk_mpll = 800000000
  sclk_epll = 96000000, sclk_vpll = 108000000, arm_clk = 800000000
 
 =============================
 [ BUG: Invalid wait context ]
 7.2.0-rc1 #13178 Not tainted
 -----------------------------
 swapper/0/0 is trying to lock:
 c1640e90 (samsung_pwm_lock){....}-{3:3}, at: samsung_time_stop+0x28/0x58
 other info that might help us debug this:
 context-{5:5}
 1 lock held by swapper/0/0:
  #0: c15856f0 (clockevents_lock){....}-{2:2}, at: clockevents_register_device+0x44/0x15c
 stack backtrace:
 CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-rc1 #13178 PREEMPT 
 Hardware name: Samsung Exynos (Flattened Device Tree)
 Call trace: 
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x68/0x88
  dump_stack_lvl from __lock_acquire+0xb44/0x2a58
  __lock_acquire from lock_acquire+0x134/0x3dc
  lock_acquire from _raw_spin_lock_irqsave+0x50/0x6c
  _raw_spin_lock_irqsave from samsung_time_stop+0x28/0x58
  samsung_time_stop from samsung_shutdown+0x14/0x1c
  samsung_shutdown from clockevents_exchange_device+0x90/0xf4
  clockevents_exchange_device from tick_check_new_device+0x6c/0xc8
  tick_check_new_device from clockevents_register_device+0x6c/0x15c
  clockevents_register_device from _samsung_pwm_clocksource_init+0x148/0x2a4
  _samsung_pwm_clocksource_init from samsung_pwm_alloc+0x13c/0x18c
  samsung_pwm_alloc from timer_probe+0x70/0xec
  timer_probe from time_init+0x28/0x30
  time_init from start_kernel+0x620/0x7a4
  start_kernel from 0x0
 sched_clock: 32 bits at 50MHz, resolution 20ns, wraps every 42949672950ns
 clocksource: samsung_clocksource_timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 38225208935 ns

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
 drivers/clocksource/samsung_pwm_timer.c | 22 +++++++++++-----------
 drivers/pwm/pwm-samsung.c               | 22 +++++++++++-----------
 include/clocksource/samsung_pwm.h       |  2 +-
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index b9561e3f196c..0544124cf5ce 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -56,7 +56,7 @@
 #define TCON_AUTORELOAD(chan)		\
 	((chan < 5) ? _TCON_AUTORELOAD(chan) : _TCON_AUTORELOAD4(chan))
 
-DEFINE_SPINLOCK(samsung_pwm_lock);
+DEFINE_RAW_SPINLOCK(samsung_pwm_lock);
 EXPORT_SYMBOL(samsung_pwm_lock);
 
 struct samsung_pwm_clocksource {
@@ -87,14 +87,14 @@ static void samsung_timer_set_prescale(unsigned int channel, u16 prescale)
 	if (channel >= 2)
 		shift = TCFG0_PRESCALER1_SHIFT;
 
-	spin_lock_irqsave(&samsung_pwm_lock, flags);
+	raw_spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	reg = readl(pwm.base + REG_TCFG0);
 	reg &= ~(TCFG0_PRESCALER_MASK << shift);
 	reg |= (prescale - 1) << shift;
 	writel(reg, pwm.base + REG_TCFG0);
 
-	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
+	raw_spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static void samsung_timer_set_divisor(unsigned int channel, u8 divisor)
@@ -106,14 +106,14 @@ static void samsung_timer_set_divisor(unsigned int channel, u8 divisor)
 
 	bits = (fls(divisor) - 1) - pwm.variant.div_base;
 
-	spin_lock_irqsave(&samsung_pwm_lock, flags);
+	raw_spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	reg = readl(pwm.base + REG_TCFG1);
 	reg &= ~(TCFG1_MUX_MASK << shift);
 	reg |= bits << shift;
 	writel(reg, pwm.base + REG_TCFG1);
 
-	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
+	raw_spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static void samsung_time_stop(unsigned int channel)
@@ -124,13 +124,13 @@ static void samsung_time_stop(unsigned int channel)
 	if (channel > 0)
 		++channel;
 
-	spin_lock_irqsave(&samsung_pwm_lock, flags);
+	raw_spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	tcon = readl_relaxed(pwm.base + REG_TCON);
 	tcon &= ~TCON_START(channel);
 	writel_relaxed(tcon, pwm.base + REG_TCON);
 
-	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
+	raw_spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static void samsung_time_setup(unsigned int channel, unsigned long tcnt)
@@ -142,7 +142,7 @@ static void samsung_time_setup(unsigned int channel, unsigned long tcnt)
 	if (tcon_chan > 0)
 		++tcon_chan;
 
-	spin_lock_irqsave(&samsung_pwm_lock, flags);
+	raw_spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	tcon = readl_relaxed(pwm.base + REG_TCON);
 
@@ -153,7 +153,7 @@ static void samsung_time_setup(unsigned int channel, unsigned long tcnt)
 	writel_relaxed(tcnt, pwm.base + REG_TCMPB(channel));
 	writel_relaxed(tcon, pwm.base + REG_TCON);
 
-	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
+	raw_spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static void samsung_time_start(unsigned int channel, bool periodic)
@@ -164,7 +164,7 @@ static void samsung_time_start(unsigned int channel, bool periodic)
 	if (channel > 0)
 		++channel;
 
-	spin_lock_irqsave(&samsung_pwm_lock, flags);
+	raw_spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	tcon = readl_relaxed(pwm.base + REG_TCON);
 
@@ -178,7 +178,7 @@ static void samsung_time_start(unsigned int channel, bool periodic)
 
 	writel_relaxed(tcon, pwm.base + REG_TCON);
 
-	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
+	raw_spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static int samsung_set_next_event(unsigned long cycles,
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 331e81f1594a..a30bd7c305ee 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -102,7 +102,7 @@ struct samsung_pwm_chip {
  * IP. Should this change, both drivers will need to be modified to
  * properly synchronize accesses to particular instances.
  */
-static DEFINE_SPINLOCK(samsung_pwm_lock);
+static DEFINE_RAW_SPINLOCK(samsung_pwm_lock);
 #endif
 
 static inline
@@ -141,14 +141,14 @@ static void pwm_samsung_set_divisor(struct samsung_pwm_chip *our_chip,
 
 	bits = (fls(divisor) - 1) - our_chip->variant.div_base;
 
-	spin_lock_irqsave(&samsung_pwm_lock, flags);
+	raw_spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	reg = readl(our_chip->base + REG_TCFG1);
 	reg &= ~(TCFG1_MUX_MASK << shift);
 	reg |= bits << shift;
 	writel(reg, our_chip->base + REG_TCFG1);
 
-	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
+	raw_spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static int pwm_samsung_is_tdiv(struct samsung_pwm_chip *our_chip, unsigned int chan)
@@ -249,7 +249,7 @@ static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	unsigned long flags;
 	u32 tcon;
 
-	spin_lock_irqsave(&samsung_pwm_lock, flags);
+	raw_spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	tcon = readl(our_chip->base + REG_TCON);
 
@@ -263,7 +263,7 @@ static int pwm_samsung_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	our_chip->disabled_mask &= ~BIT(pwm->hwpwm);
 
-	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
+	raw_spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 
 	return 0;
 }
@@ -275,7 +275,7 @@ static void pwm_samsung_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	unsigned long flags;
 	u32 tcon;
 
-	spin_lock_irqsave(&samsung_pwm_lock, flags);
+	raw_spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	tcon = readl(our_chip->base + REG_TCON);
 	tcon &= ~TCON_AUTORELOAD(tcon_chan);
@@ -290,7 +290,7 @@ static void pwm_samsung_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	our_chip->disabled_mask |= BIT(pwm->hwpwm);
 
-	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
+	raw_spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static void pwm_samsung_manual_update(struct samsung_pwm_chip *our_chip,
@@ -298,11 +298,11 @@ static void pwm_samsung_manual_update(struct samsung_pwm_chip *our_chip,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&samsung_pwm_lock, flags);
+	raw_spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	__pwm_samsung_manual_update(our_chip, pwm);
 
-	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
+	raw_spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -390,7 +390,7 @@ static void pwm_samsung_set_invert(struct samsung_pwm_chip *our_chip,
 	unsigned long flags;
 	u32 tcon;
 
-	spin_lock_irqsave(&samsung_pwm_lock, flags);
+	raw_spin_lock_irqsave(&samsung_pwm_lock, flags);
 
 	tcon = readl(our_chip->base + REG_TCON);
 
@@ -404,7 +404,7 @@ static void pwm_samsung_set_invert(struct samsung_pwm_chip *our_chip,
 
 	writel(tcon, our_chip->base + REG_TCON);
 
-	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
+	raw_spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
 static int pwm_samsung_set_polarity(struct pwm_chip *chip,
diff --git a/include/clocksource/samsung_pwm.h b/include/clocksource/samsung_pwm.h
index 9b435caa95fe..36f6f246e559 100644
--- a/include/clocksource/samsung_pwm.h
+++ b/include/clocksource/samsung_pwm.h
@@ -15,7 +15,7 @@
  * spinlock is not shared between both drivers.
  */
 #ifdef CONFIG_CLKSRC_SAMSUNG_PWM
-extern spinlock_t samsung_pwm_lock;
+extern raw_spinlock_t samsung_pwm_lock;
 #endif
 
 struct samsung_pwm_variant {
-- 
2.34.1


