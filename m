Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 290843954C8
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 06:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhEaEsM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 00:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhEaEsK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 31 May 2021 00:48:10 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD6AC061761
        for <linux-pwm@vger.kernel.org>; Sun, 30 May 2021 21:46:22 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id t3so11945640edc.7
        for <linux-pwm@vger.kernel.org>; Sun, 30 May 2021 21:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bJxASN9/VJ7juNYNTX4EX6mmIGaWh5aMZc7qgtuD+IU=;
        b=oqizCzkWKvZf15jO987l874C6oFmf+PpZfdo0bF1dGwoCiPP+xMcyjRvMa6l7ELvc1
         6Cbtz+m9iIJxpaZwVRMK6+ChJ3n5P7sgfdCJ/jvCwyJxa5JoKSRKP+nyWmLcGdlG9cub
         czyKvHvkeakh/Y25cl4sodc3AQjz4m9oADK5shjPcUtX7OEEwxWTAHX0l7aVfhiEjNoi
         Mzz2hA59kF31of4IpXdCBnxz0rEBbAkKAFByZVKuffbhNsS/3mk+J33vjT6hDC0WUpec
         IzCL42VsUCcNozdzaxSgNX7uruW2+PImiG08fYlJJYm6gYqfsmyA0ZXiMki29clDsvzY
         eftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bJxASN9/VJ7juNYNTX4EX6mmIGaWh5aMZc7qgtuD+IU=;
        b=eC2Mp3yv5gExiWHFXjRcT6Lk2xnMuX/hkoxj6xETuEwi8LJSNgYGwvCBhVL7iXV0YI
         qFontzdgHANAEumwuJX3BL+x0M78Zmg3rT4R2oVOXXnsFTCmtt0QimH5918F0kZFgLSK
         haWbX8aXNuLs81rGIYOQaqZyuLFbEq7U+w0RkWDbvb8dp64pR28Hq+z3ifkSnJjcsV2Y
         atKBhD1elmDyLTDaIAS2FwiosfzKQP2c4T9+jHD20EyIOgpb2jQjLyKRbl8JUHYnO3Fq
         rvx+WXZKHS6khcXFy4I6hiTk5+Ii/GbCHMCAKP3L8W9Xa9V09l8RpmCbLyuU9G89S6Gv
         pziQ==
X-Gm-Message-State: AOAM531gfyX8Ob4Xu/e4KEUlpf8YUB2eTMWY077ApTT21cEfwx/j0+1p
        mYxAf5SwW5ai4JsRRHpngYo6tA==
X-Google-Smtp-Source: ABdhPJw2frB/ZmhM9tgloeFhP25YeHOi7cT5JP2v2UeqpuGbPnO2vr6JcP4Q185T9pvonWQGT/hPiA==
X-Received: by 2002:aa7:cdd8:: with SMTP id h24mr23142258edw.276.1622436381298;
        Sun, 30 May 2021 21:46:21 -0700 (PDT)
Received: from zen.local (ip-89-103-215-157.net.upcbroadband.cz. [89.103.215.157])
        by smtp.gmail.com with ESMTPSA id h9sm6238376edt.18.2021.05.30.21.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 21:46:20 -0700 (PDT)
From:   Roman Beranek <roman.beranek@prusa3d.cz>
X-Google-Original-From: Roman Beranek <roman.beranek@prusa3d.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Emil Lenngren <emil.lenngren@gmail.com>,
        Pascal Roeleven <dev@pascalroeleven.nl>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com
Subject: [PATCH 4/6] pwm: sun4i: simplify calculation of the delay time
Date:   Mon, 31 May 2021 06:46:06 +0200
Message-Id: <20210531044608.1006024-5-roman.beranek@prusa3d.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
References: <20210531044608.1006024-1-roman.beranek@prusa3d.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There's no reason to expect a single jiffy has passed since writing
the CTRL register except if a preemption has occured in the meantime.
Avoid introducing unnecessary complexity and simply wait for the whole
period.

Signed-off-by: Roman Beranek <roman.beranek@prusa3d.com>
---
 drivers/pwm/pwm-sun4i.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index b3ec59a83d00..8218173ce3f6 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -14,7 +14,6 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/jiffies.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
@@ -89,7 +88,6 @@ struct sun4i_pwm_chip {
 	void __iomem *base;
 	struct mutex ctrl_lock;
 	const struct sun4i_pwm_data *data;
-	unsigned long next_period[2];
 };
 
 static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
@@ -242,8 +240,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_state cstate;
 	u32 ctrl, duty = 0, period = 0, val;
 	int ret;
-	unsigned int delay_us, prescaler = 0;
-	unsigned long now;
+	unsigned int prescaler = 0;
 	bool bypass;
 
 	pwm_get_state(pwm, &cstate);
@@ -291,8 +288,6 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
-	sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
-		nsecs_to_jiffies(cstate.period + 1000);
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
@@ -314,15 +309,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	/* We need a full period to elapse before disabling the channel. */
-	now = jiffies;
-	if (time_before(now, sun4i_pwm->next_period[pwm->hwpwm])) {
-		delay_us = jiffies_to_usecs(sun4i_pwm->next_period[pwm->hwpwm] -
-					   now);
-		if ((delay_us / 500) > MAX_UDELAY_MS)
-			msleep(delay_us / 1000 + 1);
-		else
-			usleep_range(delay_us, delay_us * 2);
-	}
+	fsleep(cstate.period / NSEC_PER_USEC + 1);
 
 	ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
-- 
2.31.1

