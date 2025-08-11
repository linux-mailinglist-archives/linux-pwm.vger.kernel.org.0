Return-Path: <linux-pwm+bounces-6998-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B91B211D6
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 18:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386B8502370
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 16:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20172296BA5;
	Mon, 11 Aug 2025 16:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1W0q7ESI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8609F29BD84
	for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928092; cv=none; b=KjGKFLutHCPpV14EzAxsm+DGnvGPN7ETNwKLDHeQPl2GyfvdxWoEinfrEj+UC+ze4nfpS6f1oWrcGgKnTUGnHSSc1KFB37aERPZjISW/y55sBBSl6tN6m01x7Hucph1GlhMZsdrJSQFvioB4CNYjaBNu7GynHb+7Gsa5ggZromU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928092; c=relaxed/simple;
	bh=Gv2ehk+vC+rC2MbP68ztRvrswokm7vslTgyEDTmcSC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oJmg0gidvxrF2etx/b+hPakT2Ln+/QuufYYOSovgxa/ozDTDmEcOxsoQTeZ6jN9gqGa2Hc/2AiaSM8WfPPywXhX7tCbELwnewDICy1J/CTPhacH+Le4BjPnNCwpwITqEGk9EwWceSowQTcoeeOLIqvffkH0XL9SAzLLH+/l/aKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1W0q7ESI; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-459fdc391c6so18432875e9.3
        for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 09:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754928088; x=1755532888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzlcu36TtZjK3AeTaSB8vKUGOUsIyyNd92q4wwdvOR4=;
        b=1W0q7ESIEwXPGVbboHByufE7jGTuQeEu3mCCadAUjFhAR0SRLu3SgpKLA6+dr+/i26
         lgb6AtgaIKQ97ky2QiZifleAwup3CN7iUWwuaCHdCUJ1fQpfJ+No8jgx1DMzAs4ee8Jk
         qVBJ3wDwqiUgxVl/vMY337C9kQdr6oiMbadF0GUlP/3+1+SB2KcamcV/WJe0I8OALv9O
         pQ7IIf7N+v2kXAYzTNVB1vu2XpJnCbGwU5qVlBKrpic/pafPh/EybK7Qy31pbIciJyAP
         fUEA+GWU3iSikkRWFkR9p1HnrRKk/YCzaJjpSIyJ1jJisYHSb0RCjiUMI/3HXlugaXZU
         WtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754928088; x=1755532888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzlcu36TtZjK3AeTaSB8vKUGOUsIyyNd92q4wwdvOR4=;
        b=gJLq+FCk4yHd5O0vFeLTMV+WNQuLo9YQH9dvkrGxwotOBvYJxVCdAWVpCqgtM16B56
         zlKPl80Z9AMzfy8NwC9u03BL6/nFHyDb2Ex12eQLmmJ4HAGaDX81bEjwITCP5oBSsmqH
         ONrwRU4yHVH3Ojd7iu+V3Wm+/Ni2PGIahGipnAiR0XeK1eGZb5dKe2Vi0F07ixh8i9m+
         cxDkfJhEnEs5ZjHLWI1qdIvHEv7E0k5ZamCyYpYgaoKE3MM+ZGGW2BTkDtuE0jP/jPe5
         m5KWTAIER3o6YsLdRdj37NCwr0W9jAXYyf1Lyps4tPG4CLPWurxx0qTwHlsLdNd9eF3J
         wquQ==
X-Gm-Message-State: AOJu0Yz7V/pcNkQCnsqi4p3EX3WXx+S0ZNeJc/FzLP3apxhyfsTcHqty
	2QhGWFtIe82N2Sa1vk+LcOgr4O9Ei6o7N00/xTNZgIqz85hd3LzUKwWF2/h5NtUj6vwK9V0Qyr6
	anx6x
X-Gm-Gg: ASbGncu1Olp3IIgg+Ru61dnxfGdMRD9pSU13Ojp0OFd3OhhuUZOPjnrIWDRjw6uk2fC
	e+06Ot3ary5mfY4va57+OCaoeL0xooKDziacQ6XeAzpPyq/K14nek8aXH2opBDiRxUv7yQDPaHZ
	5OaAMzaksRWNig3PBND5GUrf+ps4tAYGpByj0RVbAxNTqL0Tkp558UM585MvfZ6HIOxrl8PWmqr
	lSoNutbhVR4rCDkSCrRJG2Ap5eqoF9HmrOy8us3nt81pu5sN3/+6El3e0H3e5SFooKEEAfWxHfZ
	w8i7BTpyBZv1e2GpyO3/7pnyuKZEP78dvJPnYOHvUqz2LklLPcdbaDNrmSqMArgEnjlBjqjg1gL
	xjXeeYDyA3bZFJoknfKx8sdHAoRQv//p+PuEbTOopON0AdclqMx6k5By2Q9Qj2PdY
X-Google-Smtp-Source: AGHT+IECnxZUUa/VJfinQES4I5f9s/Aa/1prtFkcVWijRASNQyRUtXXtyuD0iVJemkjG1PDQovvlIw==
X-Received: by 2002:a05:6000:220b:b0:3b7:bedd:d268 with SMTP id ffacd0b85a97d-3b911014c7cmr201051f8f.53.1754928087601;
        Mon, 11 Aug 2025 09:01:27 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c453333sm42541153f8f.45.2025.08.11.09.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 09:01:26 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: "Philip, Avinash" <avinashphilip@ti.com>,
	Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 3/4] pwm: tiehrpwm: Fix various off-by-one errors in duty-cycle calculation
Date: Mon, 11 Aug 2025 18:01:01 +0200
Message-ID:  <dc818c69b7cf05109ecda9ee6b0043a22de757c1.1754927682.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1754927682.git.u.kleine-koenig@baylibre.com>
References: <cover.1754927682.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8705; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Gv2ehk+vC+rC2MbP68ztRvrswokm7vslTgyEDTmcSC0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBomhPD6DrHXC+um7lAhEejdXPEYgCSr+Vay8gBc zU4pHoHxxGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaJoTwwAKCRCPgPtYfRL+ ToIPCACtWgzYjYwP7gVkcHTo+TzT90Y4t5t6aX/r9ZVKgOO8ilMVif+PqVNkF/ywDJBR+DtdK9Q tkPsB5HDp5B/7DRnF1yUGs9nm9LwXXYFCF69AP+LiCpJKM2R11PKJEH8a4ahWP4XfHI+mkMIDPw 1QWaMt33ejjmeB324O0OS42Ze9FNGcDDKx+s08ByDmsY3Dnhndn89evp/bN8/MgaMJt7f2gCY6v 1mriknBfqsJ4MbRnha3HD17WQa2aIUQirTjtubUevZh/FTIGiIRErKN3xooxAoAiRUEvBmL0owD heeSEnRw/CnI1mgckICWFM81yOOV1qFCQmmq0wGW6ypFCGLQ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

In Up-Count Mode the timer is reset to zero one tick after it reaches
TBPRD, so the period length is (TBPRD + 1) * T_TBCLK. This matches both
the documentation and measurements. So the value written to the TBPRD has
to be one less than the calculated period_cycles value.

A complication here is that for a 100% relative duty-cycle the value
written to the CMPx register has to be TBPRD + 1 which might overflow if
TBPRD is 0xffff. To handle that the calculation of the AQCTLx register
has to be moved to ehrpwm_pwm_config() and the edge at CTR = CMPx has to
be skipped.

Additionally the AQCTL_PRD register field has to be 0 because that defines
the hardware's action when the maximal counter value is reached, which is
(as above) one clock tick before the period's end. The period start edge
has to happen when the counter is reset and so is defined in the AQCTL_ZRO
field.

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 143 +++++++++++++++----------------------
 1 file changed, 58 insertions(+), 85 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index a94b1e387b92..a23e48b8523d 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -36,7 +36,7 @@
 
 #define CLKDIV_MAX		7
 #define HSPCLKDIV_MAX		7
-#define PERIOD_MAX		0xFFFF
+#define PERIOD_MAX		0x10000
 
 /* compare module registers */
 #define CMPA			0x12
@@ -65,14 +65,10 @@
 #define AQCTL_ZRO_FRCHIGH	BIT(1)
 #define AQCTL_ZRO_FRCTOGGLE	(BIT(1) | BIT(0))
 
-#define AQCTL_CHANA_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_PRD_FRCHIGH | \
-				AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANA_POLINVERSED	(AQCTL_CAU_FRCHIGH | AQCTL_PRD_FRCLOW | \
-				AQCTL_ZRO_FRCLOW)
-#define AQCTL_CHANB_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_PRD_FRCHIGH | \
-				AQCTL_ZRO_FRCHIGH)
-#define AQCTL_CHANB_POLINVERSED	(AQCTL_CBU_FRCHIGH | AQCTL_PRD_FRCLOW | \
-				AQCTL_ZRO_FRCLOW)
+#define AQCTL_CHANA_POLNORMAL	(AQCTL_CAU_FRCLOW | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHANA_POLINVERSED	(AQCTL_CAU_FRCHIGH | AQCTL_ZRO_FRCLOW)
+#define AQCTL_CHANB_POLNORMAL	(AQCTL_CBU_FRCLOW | AQCTL_ZRO_FRCHIGH)
+#define AQCTL_CHANB_POLINVERSED	(AQCTL_CBU_FRCHIGH | AQCTL_ZRO_FRCLOW)
 
 #define AQSFRC_RLDCSF_MASK	(BIT(7) | BIT(6))
 #define AQSFRC_RLDCSF_ZRO	0
@@ -108,7 +104,6 @@ struct ehrpwm_pwm_chip {
 	unsigned long clk_rate;
 	void __iomem *mmio_base;
 	unsigned long period_cycles[NUM_PWM_CHANNEL];
-	enum pwm_polarity polarity[NUM_PWM_CHANNEL];
 	struct clk *tbclk;
 	struct ehrpwm_context ctx;
 };
@@ -177,51 +172,20 @@ static int set_prescale_div(unsigned long rqst_prescaler, u16 *prescale_div,
 	return 1;
 }
 
-static void configure_polarity(struct ehrpwm_pwm_chip *pc, int chan)
-{
-	u16 aqctl_val, aqctl_mask;
-	unsigned int aqctl_reg;
-
-	/*
-	 * Configure PWM output to HIGH/LOW level on counter
-	 * reaches compare register value and LOW/HIGH level
-	 * on counter value reaches period register value and
-	 * zero value on counter
-	 */
-	if (chan == 1) {
-		aqctl_reg = AQCTLB;
-		aqctl_mask = AQCTL_CBU_MASK;
-
-		if (pc->polarity[chan] == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHANB_POLINVERSED;
-		else
-			aqctl_val = AQCTL_CHANB_POLNORMAL;
-	} else {
-		aqctl_reg = AQCTLA;
-		aqctl_mask = AQCTL_CAU_MASK;
-
-		if (pc->polarity[chan] == PWM_POLARITY_INVERSED)
-			aqctl_val = AQCTL_CHANA_POLINVERSED;
-		else
-			aqctl_val = AQCTL_CHANA_POLNORMAL;
-	}
-
-	aqctl_mask |= AQCTL_PRD_MASK | AQCTL_ZRO_MASK;
-	ehrpwm_modify(pc->mmio_base, aqctl_reg, aqctl_mask, aqctl_val);
-}
-
 /*
  * period_ns = 10^9 * (ps_divval * period_cycles) / PWM_CLK_RATE
  * duty_ns   = 10^9 * (ps_divval * duty_cycles) / PWM_CLK_RATE
  */
 static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			     u64 duty_ns, u64 period_ns)
+			     u64 duty_ns, u64 period_ns, enum pwm_polarity polarity)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 	u32 period_cycles, duty_cycles;
 	u16 ps_divval, tb_divval;
 	unsigned int i, cmp_reg;
 	unsigned long long c;
+	u16 aqctl_val, aqctl_mask;
+	unsigned int aqctl_reg;
 
 	if (period_ns > NSEC_PER_SEC)
 		return -ERANGE;
@@ -231,15 +195,10 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(c, NSEC_PER_SEC);
 	period_cycles = (unsigned long)c;
 
-	if (period_cycles < 1) {
-		period_cycles = 1;
-		duty_cycles = 1;
-	} else {
-		c = pc->clk_rate;
-		c = c * duty_ns;
-		do_div(c, NSEC_PER_SEC);
-		duty_cycles = (unsigned long)c;
-	}
+	c = pc->clk_rate;
+	c = c * duty_ns;
+	do_div(c, NSEC_PER_SEC);
+	duty_cycles = (unsigned long)c;
 
 	/*
 	 * Period values should be same for multiple PWM channels as IP uses
@@ -271,50 +230,71 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 	}
 
+	/* Update period & duty cycle with presacler division */
+	period_cycles = period_cycles / ps_divval;
+	duty_cycles = duty_cycles / ps_divval;
+
+	if (period_cycles < 1)
+		period_cycles = 1;
+
 	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	/* Update clock prescaler values */
 	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
 
-	/* Update period & duty cycle with presacler division */
-	period_cycles = period_cycles / ps_divval;
-	duty_cycles = duty_cycles / ps_divval;
+	if (pwm->hwpwm == 1) {
+		/* Channel 1 configured with compare B register */
+		cmp_reg = CMPB;
+
+		aqctl_reg = AQCTLB;
+		aqctl_mask = AQCTL_CBU_MASK;
+
+		if (polarity == PWM_POLARITY_INVERSED)
+			aqctl_val = AQCTL_CHANB_POLINVERSED;
+		else
+			aqctl_val = AQCTL_CHANB_POLNORMAL;
+
+		/* if duty_cycle is big, don't toggle on CBU */
+		if (duty_cycles > period_cycles)
+			aqctl_val &= ~AQCTL_CBU_MASK;
+
+	} else {
+		/* Channel 0 configured with compare A register */
+		cmp_reg = CMPA;
+
+		aqctl_reg = AQCTLA;
+		aqctl_mask = AQCTL_CAU_MASK;
+
+		if (polarity == PWM_POLARITY_INVERSED)
+			aqctl_val = AQCTL_CHANA_POLINVERSED;
+		else
+			aqctl_val = AQCTL_CHANA_POLNORMAL;
+
+		/* if duty_cycle is big, don't toggle on CAU */
+		if (duty_cycles > period_cycles)
+			aqctl_val &= ~AQCTL_CAU_MASK;
+	}
+
+	aqctl_mask |= AQCTL_PRD_MASK | AQCTL_ZRO_MASK;
+	ehrpwm_modify(pc->mmio_base, aqctl_reg, aqctl_mask, aqctl_val);
 
 	/* Configure shadow loading on Period register */
 	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_PRDLD_MASK, TBCTL_PRDLD_SHDW);
 
-	ehrpwm_write(pc->mmio_base, TBPRD, period_cycles);
+	ehrpwm_write(pc->mmio_base, TBPRD, period_cycles - 1);
 
 	/* Configure ehrpwm counter for up-count mode */
 	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CTRMODE_MASK,
 		      TBCTL_CTRMODE_UP);
 
-	if (pwm->hwpwm == 1)
-		/* Channel 1 configured with compare B register */
-		cmp_reg = CMPB;
-	else
-		/* Channel 0 configured with compare A register */
-		cmp_reg = CMPA;
-
-	ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
+	if (!(duty_cycles > period_cycles))
+		ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 
 	return 0;
 }
 
-static int ehrpwm_pwm_set_polarity(struct pwm_chip *chip,
-				   struct pwm_device *pwm,
-				   enum pwm_polarity polarity)
-{
-	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
-
-	/* Configuration of polarity in hardware delayed, do at enable */
-	pc->polarity[pwm->hwpwm] = polarity;
-
-	return 0;
-}
-
 static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
@@ -339,9 +319,6 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 
-	/* Channels polarity can be configured from action qualifier module */
-	configure_polarity(pc, pwm->hwpwm);
-
 	/* Enable TBCLK */
 	ret = clk_enable(pc->tbclk);
 	if (ret) {
@@ -406,10 +383,6 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			ehrpwm_pwm_disable(chip, pwm);
 			enabled = false;
 		}
-
-		err = ehrpwm_pwm_set_polarity(chip, pwm, state->polarity);
-		if (err)
-			return err;
 	}
 
 	if (!state->enabled) {
@@ -418,7 +391,7 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period, state->polarity);
 	if (err)
 		return err;
 
-- 
2.50.1


