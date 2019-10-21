Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD670DEA30
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 12:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfJUK5w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 06:57:52 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33500 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfJUK5w (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 06:57:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so4655732wro.0
        for <linux-pwm@vger.kernel.org>; Mon, 21 Oct 2019 03:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sfBsCyYhcxQv6g80SbodsZVoivSPnkYbuxxCNV6WrOg=;
        b=G6FjY87EMDcHJYaT+cftTzu8xRf6/ceFp+MxjvuNIrzkXHPf2xWlQph5TSO1d5K2es
         1Jr4kgaPeCKwBowXPcmpzrUxN2t2Y37OjRQwj31ORnHAHi5iAO4Xr0uG1YwqhWEeyeNB
         xeGmnFb4sPrh7aTWzsfa5M5bsHlh28xIlGuahaTRJf6nQxNYlSqukBo5Wnr+BGF0Q/ST
         eb9SdB33Z1n9wSTdA7W6S51ZD3NUbJVsLYV/VPmhaDy4QnqYKqwQR19oqRlPyL2AgnIB
         NBI/sag1rCCGQfI2ZyTFwf5AQoYHSpOWUqFpPUh+hoPNbN7BdeVa+DedFI7jA3npnIwD
         FEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfBsCyYhcxQv6g80SbodsZVoivSPnkYbuxxCNV6WrOg=;
        b=HwUWwKVIrLo1wfpDEsafpvdglxBzAfIpncUOfOvkUTOqyxpAZuKthVJeuOgbWZLfRm
         WBmFgJK7+JJj+nYOrw+B+DwpVrljgaGrMsDEjgBOtWbxZPvK3pu9y3uz0qhVZi2BKUdd
         mZeb1lHcwT4scJ6HR5yEZGPMdhfFJRU4h0ipKWo4ln3KEX35cmv7HVyvbOFqEdH3XQNz
         Tal2rGnJccWgxylKjpXFWolbsKeS58hPM0oOWsfrLcyCuxw79IcWp0lCKPwU4qBlLsih
         hnHeiEr+5ZBbJnEJxd/opQUbiFaUN/RWC2U0fGeOXmcJdJXxf1qQEEpLnB2C4534nLyD
         iqiA==
X-Gm-Message-State: APjAAAWOhZtWqguIAtY6KpdholuKbTSpMhhb2OWokCjRJQOmwvs8WVtL
        GxdI9Cy6tQ06J0Msr1e3B7A=
X-Google-Smtp-Source: APXvYqyecFRNIBJhTWhE0KTzKNVAcDWA3trlRhbM0CWPP0AYBTgTYfZgX/JBqApPb+EmIZTzAwukUQ==
X-Received: by 2002:a05:6000:12cd:: with SMTP id l13mr19247292wrx.181.1571655467978;
        Mon, 21 Oct 2019 03:57:47 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id p12sm938044wrt.7.2019.10.21.03.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:57:47 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH 4/4] pwm: imx27: Unconditionally write state to hardware
Date:   Mon, 21 Oct 2019 12:57:39 +0200
Message-Id: <20191021105739.1357629-4-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021105739.1357629-1-thierry.reding@gmail.com>
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The i.MX driver currently uses a shortcut and doesn't write all of the
state through to the hardware when the PWM is disabled. This causes an
inconsistent state to be read back by consumers with the result of them
malfunctioning.

Fix this by always writing the full state through to the hardware
registers so that the correct state can always be read back.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-imx27.c | 120 ++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 61 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 4113d5cd4c62..59d8b1289808 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -230,70 +230,68 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	pwm_get_state(pwm, &cstate);
 
-	if (state->enabled) {
-		c = clk_get_rate(imx->clk_per);
-		c *= state->period;
-
-		do_div(c, 1000000000);
-		period_cycles = c;
-
-		prescale = period_cycles / 0x10000 + 1;
-
-		period_cycles /= prescale;
-		c = (unsigned long long)period_cycles * state->duty_cycle;
-		do_div(c, state->period);
-		duty_cycles = c;
-
-		/*
-		 * according to imx pwm RM, the real period value should be
-		 * PERIOD value in PWMPR plus 2.
-		 */
-		if (period_cycles > 2)
-			period_cycles -= 2;
-		else
-			period_cycles = 0;
-
-		/*
-		 * Wait for a free FIFO slot if the PWM is already enabled, and
-		 * flush the FIFO if the PWM was disabled and is about to be
-		 * enabled.
-		 */
-		if (cstate.enabled) {
-			pwm_imx27_wait_fifo_slot(chip, pwm);
-		} else {
-			ret = pwm_imx27_clk_prepare_enable(chip);
-			if (ret)
-				return ret;
-
-			pwm_imx27_sw_reset(chip);
-		}
-
-		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
-		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
-
-		/*
-		 * Store the duty cycle for future reference in cases where
-		 * the MX3_PWMSAR register can't be read (i.e. when the PWM
-		 * is disabled).
-		 */
-		imx->duty_cycle = duty_cycles;
-
-		cr = MX3_PWMCR_PRESCALER_SET(prescale) |
-		     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
-		     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
-		     MX3_PWMCR_DBGEN | MX3_PWMCR_EN;
-
-		if (state->polarity == PWM_POLARITY_INVERSED)
-			cr |= FIELD_PREP(MX3_PWMCR_POUTC,
-					MX3_PWMCR_POUTC_INVERTED);
-
-		writel(cr, imx->mmio_base + MX3_PWMCR);
-	} else if (cstate.enabled) {
-		writel(0, imx->mmio_base + MX3_PWMCR);
+	c = clk_get_rate(imx->clk_per);
+	c *= state->period;
 
-		pwm_imx27_clk_disable_unprepare(chip);
+	do_div(c, 1000000000);
+	period_cycles = c;
+
+	prescale = period_cycles / 0x10000 + 1;
+
+	period_cycles /= prescale;
+	c = (unsigned long long)period_cycles * state->duty_cycle;
+	do_div(c, state->period);
+	duty_cycles = c;
+
+	/*
+	 * according to imx pwm RM, the real period value should be PERIOD
+	 * value in PWMPR plus 2.
+	 */
+	if (period_cycles > 2)
+		period_cycles -= 2;
+	else
+		period_cycles = 0;
+
+	/*
+	 * Wait for a free FIFO slot if the PWM is already enabled, and flush
+	 * the FIFO if the PWM was disabled and is about to be enabled.
+	 */
+	if (cstate.enabled) {
+		pwm_imx27_wait_fifo_slot(chip, pwm);
+	} else {
+		ret = pwm_imx27_clk_prepare_enable(chip);
+		if (ret)
+			return ret;
+
+		pwm_imx27_sw_reset(chip);
 	}
 
+	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
+
+	/*
+	 * Store the duty cycle for future reference in cases where the
+	 * MX3_PWMSAR register can't be read (i.e. when the PWM is disabled).
+	 */
+	imx->duty_cycle = duty_cycles;
+
+	cr = MX3_PWMCR_PRESCALER_SET(prescale) |
+	     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
+	     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
+	     MX3_PWMCR_DBGEN;
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		cr |= FIELD_PREP(MX3_PWMCR_POUTC,
+				MX3_PWMCR_POUTC_INVERTED);
+
+	if (state->enabled)
+		cr |= MX3_PWMCR_EN;
+
+	writel(cr, imx->mmio_base + MX3_PWMCR);
+
+	if (!state->enabled && cstate.enabled)
+		pwm_imx27_clk_disable_unprepare(chip);
+
 	return 0;
 }
 
-- 
2.23.0

