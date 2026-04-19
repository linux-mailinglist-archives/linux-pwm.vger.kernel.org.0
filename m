Return-Path: <linux-pwm+bounces-8632-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Yhj5OpuN5GnXWgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8632-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Apr 2026 10:08:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 018204235F1
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Apr 2026 10:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 450963016488
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Apr 2026 08:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452FE33CEA8;
	Sun, 19 Apr 2026 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="jNa41cP5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BE930F53C
	for <linux-pwm@vger.kernel.org>; Sun, 19 Apr 2026 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776586133; cv=none; b=f0cyy+/JoR3Tm8eCEk4ldMkSq9FhHCARm+hvecfFYAlMRbKqDaVdRIDaVJeEL/uXZw9Cmc4KQDFx1eU5z11mNrDyVhDRgWmB0rzKo821/4USOOaJZt2w3G/LW7xccVYJ8IzkBsfLHZreOhnoT1LRrYgMJCmSqSlJCn4WLvoog5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776586133; c=relaxed/simple;
	bh=OCi9nDDPRNt+0Tt22m27NOerlt18eeVeDVdbhOVkDFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbFoUVuOosWtsqWqOKO24xNcFGrvp0rnMGoccwEd1oNN41gDbW/p7B6AWFo6OhOdzygLpgDGBiDwhs97MTX8jyoxf42Pv6mEQblySI5EuMcDdtqXoQMu2hKh+bfaB6r29IuUpQcDxr/YLoQ5kUAjfFlbqhPq19XQGQf8xiAMizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=jNa41cP5; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c7973bbc16dso1385261a12.0
        for <linux-pwm@vger.kernel.org>; Sun, 19 Apr 2026 01:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776586128; x=1777190928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xkh8bldvZTdSRdXrrl3UK2Fj0kWohJXGFNjSq2Nw4w4=;
        b=jNa41cP57MoEmdvofah+K481ZlzR6vLBJz0my5/u3LDfngebYioiBeCprDCpq1YC9n
         rT+bV2dUTMnJQzJJYLRVKOcEr00H8hJeMSpEDUTWvYJ2OUg5VXtDU5eJpj8JLVWsF4KW
         0WLLj9bqOf39JvfKngcPL4DhjPwvVBHlKes30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776586128; x=1777190928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xkh8bldvZTdSRdXrrl3UK2Fj0kWohJXGFNjSq2Nw4w4=;
        b=RK4SjjC7XTOg6fx9p2EbEtU69z1/0saO6+ReQt1nXHz5bx/SnC40yBPjW5gy/M1QFx
         8tx5ByBQmwIGZFyOP6nbp+N8FJagqli9ShVbCqB8HaUFTildnhIssm9S278fj2AvL5h8
         L6gGKVLYo07Y1rf2nucOxsq6A2sCZ44oU4zbykj3lJQquRdt9+XDJ6fd1QPN+wnGcHMM
         E4/OmjqGtpmik09htzFEThdCnuYwpb3E+I4NyXH+ecSb0+TMM3gN7aMdjT3e277HQfga
         FUYn+QrCczDeougdOSqOIjzhhAOXCgqQGPcBrSLlVZLLq7aifDIHQiZkOo6LbKDaP1Ud
         5d2g==
X-Forwarded-Encrypted: i=1; AFNElJ+Cgp4SjV3tAWGpEj3VF6o1r2EE2PeFal9WJYTKLcNKo9158+mJU6+9Me+KDlJaikJVwUkyzWhGZME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn8mI6rnvS1Kx4KPTUFt4V4zK+/hFB+EJK8Yr4WiiBdhBCejPb
	RJKwuZ5z0f0hfW9uBILfN1GkhJLtKcy0gzE0Ek642qdkLExhG/63kyVKFFgeb2gln+I=
X-Gm-Gg: AeBDietyBbIENZDf2kToMoQJkAybIClbLI9zPdEIYWNsp+sNVJiWUA7ewgYQOI0W3P4
	mJXVNEqq/t48Ck/ddfaunWr1ofz05XF7J5y0rNxEwUSbps4uOwZwmhAbPMOGIxtueMA6MopbhvV
	t7/c9STOxX3o2rVQjePyusuxPdbKj6oyZeZiSb8UPjzymgNs1oWb36n5HK02FVgrGVX6E0A93+4
	SL9anUXNz9CzJSqKz56q5BjiBUAfRIaNkDQUwWGe3TxwkMrtMr6F4ODP/obFF7l9I0hYYEnOJe2
	Fxylu0bfMOxrbtE2Q3bt18mPnRR7fSdlG+M5MHRVDOAXBN+esFDNE++ceLzt67golTHukLvuVGT
	Ccg7oS+TVTfwf0Ae8DcOJkZ7PXHqcgVT9dEs8MpWWgdkdYQpXlrqBRdWVP6I/HsCdL6W8PkSMGg
	udWMK2tUKlTn5lAN7jkOifpimsUvH6dpnE9mKx5LiJNctzkxe198jUimF4P/x9HXa1EKzuQg==
X-Received: by 2002:a05:6a20:6a20:b0:39f:24ad:ad00 with SMTP id adf61e73a8af0-3a08d68d780mr10535341637.7.1776586128576;
        Sun, 19 Apr 2026 01:08:48 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3f31sm8583735b3a.37.2026.04.19.01.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 01:08:48 -0700 (PDT)
From: Sangyun Kim <sangyun.kim@snu.ac.kr>
To: ukleinek@kernel.org
Cc: nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] pwm: atmel-tcb: Cache clock rates and mark chip as atomic
Date: Sun, 19 Apr 2026 17:08:38 +0900
Message-Id: <20260419080838.3192357-1-sangyun.kim@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260415093433.2359955-1-sangyun.kim@snu.ac.kr>
References: <20260415093433.2359955-1-sangyun.kim@snu.ac.kr>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8632-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sangyun.kim@snu.ac.kr,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,snu.ac.kr:email,snu.ac.kr:dkim,snu.ac.kr:mid]
X-Rspamd-Queue-Id: 018204235F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

atmel_tcb_pwm_apply() holds tcbpwmc->lock as a spinlock via
guard(spinlock)() and then calls atmel_tcb_pwm_config(), which calls
clk_get_rate() twice. clk_get_rate() acquires clk_prepare_lock (a
mutex), so this is a sleep-in-atomic-context violation.

On CONFIG_DEBUG_ATOMIC_SLEEP kernels every pwm_apply_state() that
enables or reconfigures the PWM triggers a "BUG: sleeping function
called from invalid context" warning.

Acquire exclusive control over the clock rates with
clk_rate_exclusive_get() at probe time and cache the rates in struct
atmel_tcb_pwm_chip, then read the cached rates from
atmel_tcb_pwm_config(). This keeps the spinlock-based mutual exclusion
introduced in commit 37f7707077f5 ("pwm: atmel-tcb: Fix race condition
and convert to guards") and removes the sleeping calls from the atomic
section.

With no sleeping calls left in .apply() and the regmap-mmio bus already
running with fast_io=true, also mark the chip as atomic so consumers
can use pwm_apply_atomic() from atomic context.

Fixes: 37f7707077f5 ("pwm: atmel-tcb: Fix race condition and convert to guards")
Signed-off-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
---
Hi Uwe,

Thanks for the review! "Sangyun" is the right form to address me, no
worries.

Changes in v2:
 - Keep the spinlock instead of converting tcbpwmc->lock to a mutex.
 - Cache clk and slow_clk rates at probe via clk_rate_exclusive_get()
   so the .apply() path no longer calls clk_get_rate() under the
   spinlock.
 - Mark the chip as atomic now that .apply() has no sleeping calls.

Thanks,
Sangyun

 drivers/pwm/pwm-atmel-tcb.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index f9a9c12cbcdd..8d46ce28f736 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -50,6 +50,8 @@ struct atmel_tcb_pwm_chip {
 	spinlock_t lock;
 	u8 channel;
 	u8 width;
+	unsigned long rate;
+	unsigned long slow_rate;
 	struct regmap *regmap;
 	struct clk *clk;
 	struct clk *gclk;
@@ -266,7 +268,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	int slowclk = 0;
 	unsigned period;
 	unsigned duty;
-	unsigned rate = clk_get_rate(tcbpwmc->clk);
+	unsigned long rate = tcbpwmc->rate;
 	unsigned long long min;
 	unsigned long long max;
 
@@ -294,7 +296,7 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (i == ARRAY_SIZE(atmel_tcb_divisors)) {
 		i = slowclk;
-		rate = clk_get_rate(tcbpwmc->slow_clk);
+		rate = tcbpwmc->slow_rate;
 		min = div_u64(NSEC_PER_SEC, rate);
 		max = min << tcbpwmc->width;
 
@@ -431,6 +433,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	}
 
 	chip->ops = &atmel_tcb_pwm_ops;
+	chip->atomic = true;
 	tcbpwmc->channel = channel;
 	tcbpwmc->width = config->counter_width;
 
@@ -438,16 +441,33 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	if (err)
 		goto err_gclk;
 
+	err = clk_rate_exclusive_get(tcbpwmc->clk);
+	if (err)
+		goto err_disable_clk;
+
+	err = clk_rate_exclusive_get(tcbpwmc->slow_clk);
+	if (err)
+		goto err_clk_unlock;
+
+	tcbpwmc->rate = clk_get_rate(tcbpwmc->clk);
+	tcbpwmc->slow_rate = clk_get_rate(tcbpwmc->slow_clk);
+
 	spin_lock_init(&tcbpwmc->lock);
 
 	err = pwmchip_add(chip);
 	if (err < 0)
-		goto err_disable_clk;
+		goto err_slow_clk_unlock;
 
 	platform_set_drvdata(pdev, chip);
 
 	return 0;
 
+err_slow_clk_unlock:
+	clk_rate_exclusive_put(tcbpwmc->slow_clk);
+
+err_clk_unlock:
+	clk_rate_exclusive_put(tcbpwmc->clk);
+
 err_disable_clk:
 	clk_disable_unprepare(tcbpwmc->slow_clk);
 
@@ -470,6 +490,8 @@ static void atmel_tcb_pwm_remove(struct platform_device *pdev)
 
 	pwmchip_remove(chip);
 
+	clk_rate_exclusive_put(tcbpwmc->slow_clk);
+	clk_rate_exclusive_put(tcbpwmc->clk);
 	clk_disable_unprepare(tcbpwmc->slow_clk);
 	clk_put(tcbpwmc->gclk);
 	clk_put(tcbpwmc->clk);
-- 
2.34.1


