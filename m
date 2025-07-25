Return-Path: <linux-pwm+bounces-6890-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144A4B1212B
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 17:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC2E0175016
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Jul 2025 15:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BD21A262D;
	Fri, 25 Jul 2025 15:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WeBma9hb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D924677E
	for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 15:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753458352; cv=none; b=DA+zqrWKJYoKNGDtuonYjoHNB/l1QeKWZUZLTKh8IVqwF5l7MVRSLBoUJLT1+7XY55JMWlkPTilxN0J6WcY4kWLOR3lUk8iq9eaRiulehzNaeW1IU+NSKQvPcpWZ3nkIx/3r7EsSkb39VwcDZZeuJ6WTS8ddnvmw2JD6yvDeM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753458352; c=relaxed/simple;
	bh=90XfpnWAvKrAD7iR4HpWYRpLi0zHbPGui3cdslYcXUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRHA0Zg26qQYWuwcS5QKhXfoCihF2WyqvQE++nXCPae7s2Bad2rOwCKPjrKbkeBjob8JSaGFsuD9rF6VNb9BkcixH9XQZqwiL+/GJV6x3pCJyjsRQwXGA8NDa+WZhKfb7IZbmWv+KeL8zHZZi2IVeJWnnz8hGYYks9o0AUc/Slo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WeBma9hb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45629703011so18118065e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 25 Jul 2025 08:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753458348; x=1754063148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Imtw8Gx4ry64i1JxbY02DQ6xhqBG4Z3YKMzGCpocp7k=;
        b=WeBma9hbiKR1fyfoQ8MrzH6C8SfGZ52JqP2FSlIR0Y4do24LUVZ+CdmKgmRsrig0jZ
         zDFeYVyCovIL3nc10x6L4YuSZVL1s67rAJp8kjU8CroUpFawAAGOM7jpw/dk1KJ4hFnn
         YaNJpwTpEy4t/cwYlOOnsfxxgPwcVDVdzPSMM05SYEoSWNvsSnTSv158Ie6hTB2NpeRs
         N3rLbyinyx0yIax/qqElXkudxV4npBmFkTpgq9VJnIXG9qcoG8x2weI9aKvbHcQYsG3f
         FbUuHI8Gop9uDfrtbcrx5A+aKCOeQJZTwcXi+swsIS6dXQydJL76zAwGnepkcXVg3SLs
         FnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753458348; x=1754063148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Imtw8Gx4ry64i1JxbY02DQ6xhqBG4Z3YKMzGCpocp7k=;
        b=emjh6NaOXyJa4ONA4iJLQDQlo+WPkvbU/t+rQR8SpoyRFxVGgBj1M9uZqr8o3MmtPp
         j2+4d474qAko946bNlAH7a8nuuIzeC6f2EThckbqXlsSiuUCKJLBBjfIF9gZ0YCHqBlt
         pVj38LYz3VltbxBkkbUw5DYGUnxuUBmm5r9WJbAGWdRRXFAz/ELGKRYxLSViD3jO0V1X
         AYm/d2brjKaf7UOOkM+mctlVnDh4j5wvzIjVPY711XiHdiIzLyQwU5TAlfDZGVG9Dd6x
         PLTvde9hp8bGNv6ceea5PV5ditnCDM6m2Rtql8wWBPes113qoDU7+YwnvZH5XsiazPel
         TgeQ==
X-Gm-Message-State: AOJu0YyJ7tw0ESwj36Mbz0hGl5xzZuo2bBQhKGNwroxnqEPSWhcDbesV
	sQraXnOhzDSskoEfRxhpGyWpK60J4+9tHawJy1Cgk6F3Z9bTh+QA5b8E5rgRLA1tGK0=
X-Gm-Gg: ASbGncsA4zYkdfriRwWree3SrA3eA4rHElJzYPHAtiU+g+pBF0I5AmduNljv6eY1wv9
	f/v+dQ91zlydqSmTNtDCxSBH2r+hLIusyUm6gVJXzuvZpKaq4bdOpJ/EMlGdEutQGV1GfbuX11R
	LtwNp3VrdQvFUs5EgHeQtx/LvXzcGk4zcwbXLPnr+mug8X/ZGQstLQ0DlhFbt0e1hJL5EEPDzfZ
	azjO6ek6EX/54OazL7Xh3hM4lp/+nMg07GIsKGkXQJDhm0R40dUXDdAuSLq7L0evLIfkQMOmGK4
	zm5ls1Ha1sTVpI0xiHelbgObGgOCbsSHQrVglgcMBQlYR1tZHQ5qJ5JcCI0dMskmTaZlf6Cevb+
	Hiqw/tdLCKa7OHX0+aVdbSlRxjA1xWsRPeJFZcFVh5CxTmKhHneaMZjue0GG8BPtT
X-Google-Smtp-Source: AGHT+IGU/MNEg3WQWls2DntpgirfB//jbj9l1ObldWRxzEwSfkXxYeLeZrDkB6W9KV/qLzu1Pm1RFA==
X-Received: by 2002:a05:600c:3585:b0:456:24aa:958e with SMTP id 5b1f17b1804b1-4587b16ef91mr660575e9.0.1753458348394;
        Fri, 25 Jul 2025 08:45:48 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4587ac58162sm1157495e9.18.2025.07.25.08.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 08:45:47 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2 6/8] pwm: mediatek: Fix various issues in the .apply() callback
Date: Fri, 25 Jul 2025 17:45:10 +0200
Message-ID: <20250725154506.2610172-16-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
References: <20250725154506.2610172-10-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4756; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=90XfpnWAvKrAD7iR4HpWYRpLi0zHbPGui3cdslYcXUo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBog6aT3OoVnQuD9g/ceDdq/4tPDMudwzFZfPofd LeBmA30bhuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaIOmkwAKCRCPgPtYfRL+ TvGdCACmyBIsMq9Y9fW2D5e/i9qHdd9zN3CsSE4ORC6OwTZh6yXFBCu78dTIEhc+6gVtbvvBesr TXizV3MZc08MY7Z3Ep4BXQ24fyl1sEhmqRA2toImZj08PJrfjFqFLaKymM2KWeHP2j5WAHRcLr7 8a9gONV35IRJTL652Kxbp4ZnY+N7MmJnDtlwpFUreKNptSJ5KvDnxW3HfxmP05rLrOOqV1nPcgh jqoLWHCu6wRIEsmJbmhR2z/KUmRZW3gzCCOrjtpCp7bCnissukSKRl1UgzsmDM7MP7WzZD8tZTO wRFs7LcI+2gksawcw5VgMMexo8y40gp4lzH180habHpxIEub
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

duty_cycle and period were silently cast from u64 to int losing
relevant bits. Dividing by the result of a division (resolution) looses
precision. clkdiv was determined using a loop while it can be done
without one. Also too low period values were not catched.

Improve all these issues. Handling period and duty_cycle being u64 now
requires a bit more care to prevent overflows, so mul_u64_u64_div_u64()
is used.

The changes implemented in this change also align the chosen hardware
settings to match the usual PWM rules (i.e. round down instead round
nearest) and so .apply() also matches .get_state() silencing several
warnings with PWM_DEBUG=y. While this probably doesn't result in
problems, this aspect makes this change---though it might be considered
a fix---unsuitable for backporting.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 71 +++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 05263a17d55d..c0a97d18e673 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -137,13 +137,13 @@ static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			       int duty_ns, int period_ns)
+			       u64 duty_ns, u64 period_ns)
 {
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
-	    reg_thres = PWMTHRES;
+	u32 clkdiv, enable;
+	u32 reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
+	u64 cnt_period, cnt_duty;
 	unsigned long clk_rate;
-	u64 resolution;
 	int ret;
 
 	ret = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
@@ -151,7 +151,11 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 
 	clk_rate = clk_get_rate(pc->clk_pwms[pwm->hwpwm]);
-	if (!clk_rate) {
+	/*
+	 * With the clk running with not more than 1 GHz the calculations below
+	 * won't overflow
+	 */
+	if (!clk_rate || clk_rate > 1000000000) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -160,27 +164,40 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (pc->soc->pwm_ck_26m_sel_reg)
 		writel(0, pc->regs + pc->soc->pwm_ck_26m_sel_reg);
 
-	/* Using resolution in picosecond gets accuracy higher */
-	resolution = (u64)NSEC_PER_SEC * 1000;
-	do_div(resolution, clk_rate);
-
-	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
-	if (!cnt_period)
-		return -EINVAL;
-
-	while (cnt_period - 1 > FIELD_MAX(PWMDWIDTH_PERIOD)) {
-		resolution *= 2;
-		clkdiv++;
-		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
-						   resolution);
-	}
-
-	if (clkdiv > FIELD_MAX(PWMCON_CLKDIV)) {
-		dev_err(pwmchip_parent(chip), "period of %d ns not supported\n", period_ns);
-		ret = -EINVAL;
+	cnt_period = mul_u64_u64_div_u64(period_ns, clk_rate, NSEC_PER_SEC);
+	if (cnt_period == 0) {
+		ret = -ERANGE;
 		goto out;
 	}
 
+	if (cnt_period > FIELD_MAX(PWMDWIDTH_PERIOD) + 1) {
+		if (cnt_period >= ((FIELD_MAX(PWMDWIDTH_PERIOD) + 1) << FIELD_MAX(PWMCON_CLKDIV))) {
+			clkdiv = FIELD_MAX(PWMCON_CLKDIV);
+			cnt_period = FIELD_MAX(PWMDWIDTH_PERIOD) + 1;
+		} else {
+			clkdiv = ilog2(cnt_period) - ilog2(FIELD_MAX(PWMDWIDTH_PERIOD));
+			cnt_period >>= clkdiv;
+		}
+	} else {
+		clkdiv = 0;
+	}
+
+	cnt_duty = mul_u64_u64_div_u64(duty_ns, clk_rate, NSEC_PER_SEC) >> clkdiv;
+	if (cnt_duty > cnt_period)
+		cnt_duty = cnt_period;
+
+	if (cnt_duty) {
+		cnt_duty -= 1;
+		enable = BIT(pwm->hwpwm);
+	} else {
+		enable = 0;
+	}
+
+	cnt_period -= 1;
+
+	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld @%lu -> CON: %x, PERIOD: %llx, DUTY: %llx\n",
+		pwm->hwpwm, duty_ns, period_ns, clk_rate, clkdiv, cnt_period, cnt_duty);
+
 	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
 		/*
 		 * PWM[4,5] has distinct offset for PWMDWIDTH and PWMTHRES
@@ -190,13 +207,11 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		reg_thres = PWM45THRES_FIXUP;
 	}
 
-	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
-
 	pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
-	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period - 1);
+	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
 
-	if (cnt_duty) {
-		pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty - 1);
+	if (enable) {
+		pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
 		pwm_mediatek_enable(chip, pwm);
 	} else {
 		pwm_mediatek_disable(chip, pwm);
-- 
2.50.0


