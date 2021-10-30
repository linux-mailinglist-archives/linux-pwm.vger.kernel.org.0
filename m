Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A837C440924
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Oct 2021 15:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhJ3Nho (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 30 Oct 2021 09:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbhJ3Nhm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 30 Oct 2021 09:37:42 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0246C061714
        for <linux-pwm@vger.kernel.org>; Sat, 30 Oct 2021 06:35:11 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id j6-20020a4aab46000000b002bb88bfb594so1786146oon.4
        for <linux-pwm@vger.kernel.org>; Sat, 30 Oct 2021 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=Nev+29M1Y1dwB8aNLPolRw0Uq6JykoAuwC6Ewa8Lyr0=;
        b=tNFwRZaatxKVz+oal5PP8bXPiWaWArv8l8l//iYUmI1e07rxYIh+AOmCklpCDd359F
         Nyo97MskPgcjPSiR5JYaJjW8B2GRH4Glr2gnWteoASulUpMxyxSV4wViJyG8v4zJ+R/Q
         ulq5j2//v4gpeiRRB3zAUAL/NtgOx+FzNJ7WEuiUVlLdz8IP0X9oW0WKUptbyonTRsXU
         Ey9+p6E7Ju5AoIcPWXtmAZGbFpr4eGGWyT6A98fLVz+ub//9rggqvBLMgjij9sBEQ/Hg
         vhU/u3h53AKVOQJxkjVS9E0TOjNl7sXB8TysTB1sUCb6KOPsaYwvS4MYYquJv1oiMqkC
         3upA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=Nev+29M1Y1dwB8aNLPolRw0Uq6JykoAuwC6Ewa8Lyr0=;
        b=MhlCgGDepUw3ovQCsxaqRDQB6ipOj/+qscoTieZVx1OSVKDtV19oZU1LaW72B3xYXe
         xbvX8ZJHbOEAZbQV15RyrcOfKH3cCDxpMibTcuFjqqB9TccujrWn36L4ofsH6U5JxqcE
         wOZa/B7YCAQJp/9sOEy0GILSA7aFdZog1dsbEPgPyagWfMVikqFhfirutU4eSDNykj9a
         FiAtZBv7taFTsxcEShyEb4LIyM4LB8pSZiCNKCFxY4tUKXJmPsBTOHb/+Mb+Z+G7Om75
         ATAgj7X2X6YtWJFWHPISozrSvyJ/1SPDH9E7fXlSjA6MDpDtg3c8sxJb+Y5bOfJhXeuO
         p6ZA==
X-Gm-Message-State: AOAM533GcuFKhMuP/fdQ+LqYwN4FQbN8NkvuBxYgik6freT+4Xfr5EjX
        onanAIqjwIVH+a2ffQM3AVv8sg==
X-Google-Smtp-Source: ABdhPJwjjpBHKPmKcM3z74OuzMIlzc4ezhVJZqYnZiGJnG1xoug8fjPSJXFIFEjPjxIBspnt8rzQqQ==
X-Received: by 2002:a4a:d51a:: with SMTP id m26mr11795989oos.84.1635600910990;
        Sat, 30 Oct 2021 06:35:10 -0700 (PDT)
Received: from fedora ([187.64.134.142])
        by smtp.gmail.com with ESMTPSA id u15sm2792185oon.35.2021.10.30.06.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 06:35:10 -0700 (PDT)
Date:   Sat, 30 Oct 2021 10:35:05 -0300
From:   =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v3] backlight: lp855x: Switch to atomic PWM API
Message-ID: <YX1KCclMB/HTZ22c@fedora>
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
V1 -> V2: Initialize variable and simply conditional loop
V2 -> V3: Fix assignment of NULL variable
---
 drivers/video/backlight/lp855x_bl.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index e94932c69f54..627a31d05691 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -233,9 +233,8 @@ static int lp855x_configure(struct lp855x *lp)
 
 static void lp855x_pwm_ctrl(struct lp855x *lp, int br, int max_br)
 {
-	unsigned int period = lp->pdata->period_ns;
-	unsigned int duty = br * period / max_br;
-	struct pwm_device *pwm;
+	struct pwm_device *pwm = NULL;
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
+		state.period = lp->pdata->period_ns;
 	}
 
-	pwm_config(lp->pwm, duty, period);
-	if (duty)
-		pwm_enable(lp->pwm);
-	else
-		pwm_disable(lp->pwm);
+	pwm_get_state(lp->pwm, &state);
+
+	state.duty_cycle = br * state.period / max_br;
+	state.enabled = state.duty_cycle;
+
+	pwm_apply_state(lp->pwm, &state);
 }
 
 static int lp855x_bl_update_status(struct backlight_device *bl)
-- 
2.31.1

