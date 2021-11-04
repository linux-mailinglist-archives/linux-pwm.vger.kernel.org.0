Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6D9445924
	for <lists+linux-pwm@lfdr.de>; Thu,  4 Nov 2021 18:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhKDSBh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 4 Nov 2021 14:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbhKDSBY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 4 Nov 2021 14:01:24 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C22C061203
        for <linux-pwm@vger.kernel.org>; Thu,  4 Nov 2021 10:58:45 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id w4so3831766qtn.2
        for <linux-pwm@vger.kernel.org>; Thu, 04 Nov 2021 10:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=OBD4zrSh/ePkUnk6YwhNCFUdHCAqcEy6CNxm9jGbw1E=;
        b=efsmc+I8Gu0dvNcX1qm770XfceWiNa3/PjnuBuaj57Eve+m8Ihp2497SZvjhu0wk+I
         dBQdiRuVdsRdQ88zPoJo215J2XIWyysoq3/C4itTTagxytVynpgN3E3C01HBYpWcQzN5
         d651ofwEbdP+eJ9uYCa6p+0eOB7ZZz5wm2FnG6H2Ldln9MbupAOVrP+0UJ0s8ctCwkok
         60OXulTTh0i8LdggtkZJtDa7ImVwwg/Tal7donT2Z5PyyPMMA481LCl7tPK3lKCJ70hr
         V6V0S+cKLvqA04QNH/broFMTpoRi2uaIy4e+50su1yh6ZIePmaXw+RiEPMfOArYRdFDA
         qufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=OBD4zrSh/ePkUnk6YwhNCFUdHCAqcEy6CNxm9jGbw1E=;
        b=c4Mm+MPhFAGmZ8O2YOLFyjHlPdKjsQMrqyt/Z7+WjU7uPc+4W3lMnMe0BchSU9sT8V
         /P9OgTLf5JOx2qYSXXVHUvEp4Eha1G5DxPq8OGyaTPWOdz/21YM5R3ZdejiiO60tUA0z
         01+hu5GB+mpw9j167jvVk/wOZk8CorVsecyzxa3DwGnzq6bAuIodp0Cjegf7sOmNVSL0
         2AFJl9KaUg4K+Ssq8W+W1cTWtYWuOm3QTejyYwoIzwY278T7cXpuoNmrec2r6o4kBjq3
         992rSAiIJAP+tgRnlLGtsE6bZS4ntRkdFBdr9AKtjsSIq2HMqvw6GytWYjipjCb4BJU7
         +/5A==
X-Gm-Message-State: AOAM533tnjaT8Le/B5EWsXAAlPRTwpS1xDcBkSq3uEu64NQUq5iewQjy
        msm9ZtU2FWnaIBzT6OCGd0IxFg==
X-Google-Smtp-Source: ABdhPJz1exMNa5eZlL8wV3nYiOktH4b5Sb1c9IjsFUvBKk4Szp0YFYGCfYBishzhorgUT7jfV+ZwxQ==
X-Received: by 2002:a05:622a:606:: with SMTP id z6mr57105056qta.253.1636048724933;
        Thu, 04 Nov 2021 10:58:44 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id 13sm3937167qkc.40.2021.11.04.10.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 10:58:44 -0700 (PDT)
Date:   Thu, 4 Nov 2021 14:58:38 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     daniel.thompson@linaro.org, lee.jones@linaro.org,
        jingoohan1@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v6] backlight: lp855x: Switch to atomic PWM API
Message-ID: <YYQfThRqabp4A7Dz@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
replace it for the atomic PWM API.

Signed-off-by: Maíra Canal <maira.canal@usp.br>
---
V1 -> V2: Initialize variable and simplify conditional loop
V2 -> V3: Fix assignment of NULL variable
V3 -> V4: Replace division for pwm_set_relative_duty_cycle
V4 -> V5: Fix overwrite of state.period
V5 -> V6: Fix duty cycle rounding and set period outside conditional loop
---
 drivers/video/backlight/lp855x_bl.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index e94932c69f54..8f893cf0cfde 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -233,9 +233,8 @@ static int lp855x_configure(struct lp855x *lp)
 
 static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 {
-	unsigned int period = lp->pdata->period_ns;
-	unsigned int duty = br * period / max_br;
 	struct pwm_device *pwm;
+	struct pwm_state state;
 
 	/* request pwm device with the consumer name */
 	if (!lp->pwm) {
@@ -245,18 +244,16 @@ static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 
 		lp->pwm = pwm;
 
-		/*
-		 * FIXME: pwm_apply_args() should be removed when switching to
-		 * the atomic PWM API.
-		 */
-		pwm_apply_args(pwm);
+		pwm_init_state(lp->pwm, &state);
+	} else {
+		pwm_get_state(lp->pwm, &state);
 	}
 
-	pwm_config(lp->pwm, duty, period);
-	if (duty)
-		pwm_enable(lp->pwm);
-	else
-		pwm_disable(lp->pwm);
+	state.period = lp->pdata->period_ns;
+	state.duty_cycle = div_u64(br * state.period, max_br);
+	state.enabled = state.duty_cycle;
+
+	pwm_apply_state(lp->pwm, &state);
 }
 
 static int lp855x_bl_update_status(struct backlight_device *bl)
-- 
2.31.1

