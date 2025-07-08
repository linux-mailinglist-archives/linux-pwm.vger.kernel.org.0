Return-Path: <linux-pwm+bounces-6785-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EEFAFD529
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 19:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DE8C481237
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1362E5403;
	Tue,  8 Jul 2025 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c4/c26eA"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703E5F9E8
	for <linux-pwm@vger.kernel.org>; Tue,  8 Jul 2025 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995155; cv=none; b=kXlxKgjJR+RM4ILgGAIG01Vj1TWIF/ftuRUvbBK/H/bgaKaQ7BvHLbT2UE3xtY4NO/Hf973CKAUxGxqSGFp8AFwYkb/oiUCf/IpmcxM+omhf4JIUXkqPIhTBfamlG5EyF0XLKNSTjj/cNCjjb9wAtfwZAP4Z/GRWendKT9saIv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995155; c=relaxed/simple;
	bh=W6WdSbzvS48ftjBDwU3bYtfZRujpdgm2n2YZsdJArLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dVfYWgmKqiPLPHBZUlWfcNtllMFaqVxd2Jsc5ilZA6BJDQVHyjiJ+qEGPsd7mOUm8v/+BYKEUJQNzy2L3uzB1CaqN4fo1VylHXtmrjj87ZAxqDj/NSY6svuz6i3WcEOpPhFhKyGBMseHqgrFXivmxIEVnvBeigvFG7O/5c7XuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c4/c26eA; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so9128110a12.3
        for <linux-pwm@vger.kernel.org>; Tue, 08 Jul 2025 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751995152; x=1752599952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l00T4JU8N3V0V/Zns06bf0Sn4mSnEv1+Ohzm+7LxqsE=;
        b=c4/c26eAUjMplLK7M1n/uL5BSeeDzpLhL0ziewN434LbIFb4whF3rMVha3eDXTxYJ/
         X5okPi261nJ9JQA5zY7VQzRB0y9ZN4cD6C1/Hsa/nPkoBAs/UF5Cf1cQ9N1gaoH3Ep7V
         JXdrBI41RAd7V5BufImTdNxm0PZXOb0E2DfpkMO1Dv2fGV5bP3o84nPINI7GbRglqvjf
         YBBLLLyuFlHpuRW100pVEzP6y3hm3ObM6H//WMeh1CZOrPf6hxAin8i7GhmFVCLUs6dy
         7RM1iQeYhMkvv46OjUE2FDjmq+5d+rPC97/otl7vB1gHMCxmFgrcjl8cvk8uqkUrPGF1
         DBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995152; x=1752599952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l00T4JU8N3V0V/Zns06bf0Sn4mSnEv1+Ohzm+7LxqsE=;
        b=fB4Rd+r72Y82SIvOCqCB6vLHW1SPR8aCNra+cJvjKbOZj4c/C04NgajlExm+/elnAP
         4QYK2SwS/LAbwLs0LmAkFsAJTuSgIvviFOan3U/jIpgEIodwfNeoNHmoGBbCVmM3/KRP
         zFqyxa6SLWhR1bUHn4LPOX6OSTZHo1qSwciw+FMCKlD7m0PSVQnE9ytYjdSCguurhBOg
         MZfQGEhq3nojH7kdy8OLzi/q+BTW8THGXblsFzWT/b3/B8uVkdqKCZHnBfo+BHXAl/27
         z+qNfdTMjQ1izhiMy+ID7wdmI1GqP8D1k3UKc0WtWuL+qKTYFvREhdhn0cOYlhENAdlX
         dpfA==
X-Gm-Message-State: AOJu0YwpvuqjhSnPVcxMqjhA7/UccUu+/xgoWPwpS8YjSr489bg+Cud/
	ORri53/54qVTLRVgQIcJp/WtZAmHzUCLGwj8TqfLnJFG+ukFTvgFm2vKA/WwAH/mZgw=
X-Gm-Gg: ASbGncuOZ1EB2BdPc3CzsFiHHBM4/xT0q+DCG51eQLE5IPV270lc50fbzC9Q9kbJtSh
	thYszxSb26swoQjqbfkB/lHjrANciUIjoHuZnRQ/JGUAcQ2DrnUfWziHazVmvUgkdyEunrKbJwM
	anJXO0hyJvR7ivQ5WHdJTebSikiTdc0toRygtlLN9b192D9A+StuJr18853o0GtAklD3boaanI7
	zP7nOCekbeuWrGXs0pIRAKCNhFP3vXaXXyDvoVME842PtPvdHNHbe1uDYsWI83OoMWr0FCn5cwW
	HWkoSe0VyIAr+KLOLJf92oky5acRPc2OwLe43Q8Qvh0ddOwUdSk6oDyByTL0eKmeHjR/reQ3SDE
	3ya1Ne01Arp+FtZwwphj6Biuv4s62
X-Google-Smtp-Source: AGHT+IFybbXITkV6I2i/0lElcb/f3RstZZsqcNMEjWoEBbgfS02aF9Kgwsi8Vybn4c+ONYLHYNK5pA==
X-Received: by 2002:a17:907:970c:b0:ae3:b85f:6eef with SMTP id a640c23a62f3a-ae3fbe06a1amr1755353266b.42.1751995151535;
        Tue, 08 Jul 2025 10:19:11 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ae3f692fbddsm933193866b.62.2025.07.08.10.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 10:19:11 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 6/8] pwm: mediatek: Fix various issues in the .apply() callback
Date: Tue,  8 Jul 2025 19:18:36 +0200
Message-ID:  <b57a7fa7a034c7827d5e4925912dade85904fa2a.1751994509.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
References: <cover.1751994509.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4214; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=W6WdSbzvS48ftjBDwU3bYtfZRujpdgm2n2YZsdJArLE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBobVL4gTmW0jf3X2vVmhtDK1k/hOnHy5nUMNgCM EDxk8pzCuCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaG1S+AAKCRCPgPtYfRL+ TloYCAC3doLO+7ul/buXbOS555EpffMkdfiF2+Q3mEnTIid7W1nt0SGj+mSrXtJRhFlrZeyFGWk m6US9pG+DA3aNVnvvmpfYxBUoRdNIPNhTqmh7dI/6m4ObR60UWWOhsLxDokZR3c1zUs/9JQOiu8 5DwnAeElXYHl19/ut9Mru+A2Wd18/pTYLyqwLaVD05X/cB5tHJm/Q/5YDMatIm2K3LMPqtyHMRD uUSq2B9tRldKC9H2zh8NfkkdT88iZZkI0uDZR+N5+/n6oeM9M0/pmd7lUsMS5BUsesRzEFPssQr aYYgmlrJW1wUE3HJiQJFK7gCvYl2hAMajwbKtic14AbIgsFC
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
 drivers/pwm/pwm-mediatek.c | 48 ++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 76b293f2b6c4..d7801e6df6ba 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -117,13 +117,13 @@ static inline u32 pwm_mediatek_readl(struct pwm_mediatek_chip *chip,
 }
 
 static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			       int duty_ns, int period_ns)
+			       u64 duty_ns, u64 period_ns)
 {
 	struct pwm_mediatek_chip *pc = to_pwm_mediatek_chip(chip);
-	u32 clkdiv = 0, cnt_period, cnt_duty, reg_width = PWMDWIDTH,
-	    reg_thres = PWMTHRES;
+	u32 clkdiv;
+	u32 reg_width = PWMDWIDTH, reg_thres = PWMTHRES;
+	u64 cnt_period, cnt_duty;
 	unsigned long clk_rate;
-	u64 resolution;
 	int ret;
 
 	ret = pwm_mediatek_clk_enable(pc, pwm->hwpwm);
@@ -131,7 +131,11 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -140,23 +144,28 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (pc->soc->pwm_ck_26m_sel_reg)
 		writel(0, pc->regs + pc->soc->pwm_ck_26m_sel_reg);
 
-	/* Using resolution in picosecond gets accuracy higher */
-	resolution = (u64)NSEC_PER_SEC * 1000;
-	do_div(resolution, clk_rate);
+	cnt_period = mul_u64_u64_div_u64(period_ns, clk_rate, NSEC_PER_SEC);
+	if (cnt_period == 0)
+		return -ERANGE;
 
-	cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000, resolution);
-	while (cnt_period > FIELD_MAX(PWMDWIDTH_PERIOD)) {
-		resolution *= 2;
-		clkdiv++;
-		cnt_period = DIV_ROUND_CLOSEST_ULL((u64)period_ns * 1000,
-						   resolution);
+	if (cnt_period > FIELD_MAX(PWMDWIDTH_PERIOD)) {
+		if (cnt_period >= (FIELD_MAX(PWMDWIDTH_PERIOD) << FIELD_MAX(PWMCON_CLKDIV))) {
+			clkdiv = FIELD_MAX(PWMCON_CLKDIV);
+			cnt_period = FIELD_MAX(PWMDWIDTH_PERIOD);
+		} else {
+			clkdiv = ilog2(cnt_period) - ilog2(FIELD_MAX(PWMDWIDTH_PERIOD));
+			cnt_period >>= clkdiv;
+		}
+	} else {
+		clkdiv = 0;
 	}
 
-	if (clkdiv > FIELD_MAX(PWMCON_CLKDIV)) {
-		dev_err(pwmchip_parent(chip), "period of %d ns not supported\n", period_ns);
-		ret = -EINVAL;
-		goto out;
-	}
+	cnt_duty = mul_u64_u64_div_u64(duty_ns, clk_rate, NSEC_PER_SEC) >> clkdiv;
+	if (cnt_duty > cnt_period)
+		cnt_duty = cnt_period;
+
+	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld @%lu -> CLKDIV: %x, PERIOD: %llx, DUTY: %llx\n",
+		pwm->hwpwm, duty_ns, period_ns, clk_rate, clkdiv, cnt_period, cnt_duty);
 
 	if (pc->soc->pwm45_fixup && pwm->hwpwm > 2) {
 		/*
@@ -167,7 +176,6 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		reg_thres = PWM45THRES_FIXUP;
 	}
 
-	cnt_duty = DIV_ROUND_CLOSEST_ULL((u64)duty_ns * 1000, resolution);
 	pwm_mediatek_writel(pc, pwm->hwpwm, PWMCON, BIT(15) | clkdiv);
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_width, cnt_period);
 	pwm_mediatek_writel(pc, pwm->hwpwm, reg_thres, cnt_duty);
-- 
2.49.0


