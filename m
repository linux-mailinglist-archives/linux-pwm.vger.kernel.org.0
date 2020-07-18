Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7132248C9
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jul 2020 06:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGREqV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 18 Jul 2020 00:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgGREqU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 18 Jul 2020 00:46:20 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840AFC0619D2
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 21:46:20 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dp18so12961047ejc.8
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 21:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6XtgaMcVkuKZN6Vqx9za29ZMiqRwMaKdWv8eAb+N9vg=;
        b=bY/0au6WAL+u8vh4fua/qFVLuU47TL1PTMEtiMXHJM49ItyD0NffJ8wZiiwrOGWaTD
         eBswM0qBkTmIt+JunE0pptyKPWhBHOu+L7miR1ny6lkFWsjiMicvX/VTfHfxfO7Afb7r
         b4wYNVuoxS+gyaOXlmDxE90qT2T3znv3d3m14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6XtgaMcVkuKZN6Vqx9za29ZMiqRwMaKdWv8eAb+N9vg=;
        b=QxgY0ZDmbWetLbLmh4CYGgFLjHE1k9QvtmAxZ1lqXi7tOXszxJIXL4WIVkwhfbVETO
         LVjqYowaeQevoUlxBRyneyNh8iFecpPWeE3eAhPRMqOsFB35ZTCroSBa/Y/9vMRwa/P6
         n3m7GtFYghSx4It2DYD/fp1uJXyrH8Vgi7+bMt4l8HyFwLZMNNrFvul8zZwtPic9URVa
         BsCI+r7hakQYL4SluzeaseAppibCb1wC95ROMkDaWxAikHsD/xdU9yKZ0R/YMecZxEeo
         vtXdVYzAEvuomXBoz2XsqOIKpxtgz8eDcvffx4FoA62P42w5zl3b5yZFx5eUJUdt5Bq1
         gA9g==
X-Gm-Message-State: AOAM532bqJGtI8ksSISycpr6jr5hJyCkn1IX49Um92Fx9yKckrrggODI
        CAL2lDLuGXmOUvPOlEt65iZKOw==
X-Google-Smtp-Source: ABdhPJy1oAFtDdH08tlydsMUGH/N2FrHzxaMP3ualaq1GVbB+RmhdCMIkpJOIZUQjDN/KFBT7tG6vw==
X-Received: by 2002:a17:906:3945:: with SMTP id g5mr12271263eje.549.1595047579113;
        Fri, 17 Jul 2020 21:46:19 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id u13sm9680553ejx.3.2020.07.17.21.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 21:46:18 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v4] pwm: bcm-iproc: handle clk_get_rate() return
Date:   Fri, 17 Jul 2020 21:46:06 -0700
Message-Id: <20200718044606.18739-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Handle clk_get_rate() returning 0 to avoid possible division by zero.

Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>

---
Changes from v3: fixed typo in commit message: Reviewed-off-by.
Hopefully everything clean now.
Changes from v2: update commit message to remove <= condition
as clk_get_rate only returns value >= 0
---
 drivers/pwm/pwm-bcm-iproc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 1f829edd8ee7..d392a828fc49 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -85,8 +85,6 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	u64 tmp, multi, rate;
 	u32 value, prescale;
 
-	rate = clk_get_rate(ip->clk);
-
 	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
 
 	if (value & BIT(IPROC_PWM_CTRL_EN_SHIFT(pwm->hwpwm)))
@@ -99,6 +97,13 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		state->polarity = PWM_POLARITY_INVERSED;
 
+	rate = clk_get_rate(ip->clk);
+	if (rate == 0) {
+		state->period = 0;
+		state->duty_cycle = 0;
+		return;
+	}
+
 	value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
 	prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
 	prescale &= IPROC_PWM_PRESCALE_MAX;
-- 
2.17.1

