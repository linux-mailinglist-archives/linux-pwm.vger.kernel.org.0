Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3DDFBAF0D
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2019 10:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437193AbfIWIN5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Sep 2019 04:13:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38604 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406068AbfIWIN4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Sep 2019 04:13:56 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so9376934lfc.5
        for <linux-pwm@vger.kernel.org>; Mon, 23 Sep 2019 01:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lD0e8xFBv1AR2F4JhSacxWgoKrl7ntnXXGEiOwHJH74=;
        b=HgcQ1K4tr0a4wAHLWjvdmktJUM3BVu3dL17gzfeF3nAdsClcj6wJpQRG6DTVB1hHUz
         Ocxoxx1M7JSEGyy/x1h5RDBNGIkNUresJDZanlEHiG4f+3mLRDMjpRIMk4Ihi6/cdnfz
         LY3qlvifzD2By4oG01tO2WS6ZIhOkjr2PMAdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lD0e8xFBv1AR2F4JhSacxWgoKrl7ntnXXGEiOwHJH74=;
        b=OF5UFwVySMEUcLw1vWtNwrXEnj5E/d90AzgdZDZqk/EBEDXifn6FS3iXUrxC+gpGtC
         aRyPZBcRUPLkHAZRQGuLwxCKs1MyMhcd7X7HipBqrcmhT+T0Kn28oQmTht/0R5yfVgXL
         TaElHed4Kj7ud0g7hmEMpKoTMeuBo0dHr0aJSfY1G9LLEle64J4FNscis2+Bo/nmjADr
         nLZfizUsOdY2hViJ7XvRkH6N4k5Dq2I635usosxez2pCGkJnp49c7VXsIN0eBrGXp3nx
         q1rSnuCZ3xNKiIVn6xrkROHollDuHbS5Q/2xHA0CUXB8IotVvKl4zWB1tl2b8eHkAk4c
         1isQ==
X-Gm-Message-State: APjAAAVZRN3Oqlcgg7bIN2RSjkWPXbjsbOfOJ+Hz5ZSA1qEtoXQcuqNA
        Z+qlcIWZmqCMNaRjJhmok22Gqw==
X-Google-Smtp-Source: APXvYqw1MEjTQxg98Niosegmp9jqiu0UU9wKr4JajogIk6AZhpzsknKDrE5TkAC9EB5KWFhVZyxHSQ==
X-Received: by 2002:a19:6455:: with SMTP id b21mr16301336lfj.167.1569226434462;
        Mon, 23 Sep 2019 01:13:54 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id c21sm2054946lff.61.2019.09.23.01.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 01:13:54 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] pwm: mxs: remove legacy methods
Date:   Mon, 23 Sep 2019 10:13:46 +0200
Message-Id: <20190923081348.6843-3-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
References: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
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
index c70c26a9ff68..284107784dad 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -102,85 +102,8 @@ static int mxs_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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

