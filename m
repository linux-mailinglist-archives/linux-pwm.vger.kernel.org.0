Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF59CCBBCA
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2019 15:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388545AbfJDNdD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 4 Oct 2019 09:33:03 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41575 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388555AbfJDNdC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 4 Oct 2019 09:33:02 -0400
Received: by mail-lf1-f65.google.com with SMTP id r2so4489074lfn.8
        for <linux-pwm@vger.kernel.org>; Fri, 04 Oct 2019 06:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1OQAE57/CgK569gxX6I56M38ksMNygkjEmF6P3qjzis=;
        b=PbMZgn+B0Hr1ICWKuBiRjOj8UTS2Y+vMUyvS6z4bjDoc+6BlUbcFkmaZ36miTfWRij
         CAZ+zhVUI7ZF8Bilvydqep8UJoFtdGbRhxshN+PZASkatEMrVKqHEPzoFvxC5+Eu7C8L
         gkcIP07xJoVkwqZ1+SrYYKVfmpaWoTn1ulcag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1OQAE57/CgK569gxX6I56M38ksMNygkjEmF6P3qjzis=;
        b=N05P4Gpso7PeGEjiD/RuLXbctCkmzzf0mcltXMnFfmzVLsirrS23PkTo+tcH7OLund
         Ia2N0THv773eVKzfbDXjma/9b5j6Ejw+SuAkj1BVQSJO/59UYl05HWt2o4Gg2JZzK3ho
         llDt/wRJcvwBKE/NNa7qbGwKfCjUE+WmXy4yyZlkfk4jY0okriUyfFB5hFj01G4K0R10
         S1iEusUAegKt6itLMLfR4h2c7xA5YGEmzlLI4cq2hLChPEwqX/qmVblxlLtPe34+PEhF
         Ue/4YmXQCmb46kIuYG6U7H37eHaiTiHZRl5b84dtLMR0HyThcoAT6Vrh6VF+1tasC2zb
         8Qww==
X-Gm-Message-State: APjAAAXlQibZEQiLe5OkMOjs6rk2D2kYvHLOq1IcsqLhlLs0mtdLIOFp
        U2UOjuIrUIqqNjDgFgMBm98C0Q==
X-Google-Smtp-Source: APXvYqzE/7G06PEqAijCPxhGp3iO3G3UFBOnYRhZM+k3WGz1SKXbxv6e+QegMQXJuE7Pq/qA8KX19A==
X-Received: by 2002:ac2:5326:: with SMTP id f6mr9224821lfh.33.1570195980792;
        Fri, 04 Oct 2019 06:33:00 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y26sm1534991ljj.90.2019.10.04.06.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 06:33:00 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] pwm: mxs: remove legacy methods
Date:   Fri,  4 Oct 2019 15:32:03 +0200
Message-Id: <20191004133207.6663-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
References: <20191004133207.6663-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since we now have ->apply, these are no longer relevant.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/pwm/pwm-mxs.c | 77 -------------------------------------------
 1 file changed, 77 deletions(-)

diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 10efd3de0bb3..5a6835e18fc6 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -110,85 +110,8 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
-static int mxs_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			  int duty_ns, int period_ns)
-{
-	struct mxs_pwm_chip *mxs = to_mxs_pwm_chip(chip);
-	int ret, div = 0;
-	unsigned int period_cycles, duty_cycles;
-	unsigned long rate;
-	unsigned long long c;
-
-	rate = clk_get_rate(mxs->clk);
-	while (1) {
-		c = rate / cdiv[div];
-		c = c * period_ns;
-		do_div(c, 1000000000);
-		if (c < PERIOD_PERIOD_MAX)
-			break;
-		div++;
-		if (div >= PERIOD_CDIV_MAX)
-			return -EINVAL;
-	}
-
-	period_cycles = c;
-	c *= duty_ns;
-	do_div(c, period_ns);
-	duty_cycles = c;
-
-	/*
-	 * If the PWM channel is disabled, make sure to turn on the clock
-	 * before writing the register. Otherwise, keep it enabled.
-	 */
-	if (!pwm_is_enabled(pwm)) {
-		ret = clk_prepare_enable(mxs->clk);
-		if (ret)
-			return ret;
-	}
-
-	writel(duty_cycles << 16,
-			mxs->base + PWM_ACTIVE0 + pwm->hwpwm * 0x20);
-	writel(PERIOD_PERIOD(period_cycles) | PERIOD_ACTIVE_HIGH |
-	       PERIOD_INACTIVE_LOW | PERIOD_CDIV(div),
-			mxs->base + PWM_PERIOD0 + pwm->hwpwm * 0x20);
-
-	/*
-	 * If the PWM is not enabled, turn the clock off again to save power.
-	 */
-	if (!pwm_is_enabled(pwm))
-		clk_disable_unprepare(mxs->clk);
-
-	return 0;
-}
-
-static int mxs_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct mxs_pwm_chip *mxs = to_mxs_pwm_chip(chip);
-	int ret;
-
-	ret = clk_prepare_enable(mxs->clk);
-	if (ret)
-		return ret;
-
-	writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + SET);
-
-	return 0;
-}
-
-static void mxs_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct mxs_pwm_chip *mxs = to_mxs_pwm_chip(chip);
-
-	writel(1 << pwm->hwpwm, mxs->base + PWM_CTRL + CLR);
-
-	clk_disable_unprepare(mxs->clk);
-}
-
 static const struct pwm_ops mxs_pwm_ops = {
 	.apply = mxs_pwm_apply,
-	.config = mxs_pwm_config,
-	.enable = mxs_pwm_enable,
-	.disable = mxs_pwm_disable,
 	.owner = THIS_MODULE,
 };
 
-- 
2.20.1

