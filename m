Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAED224317
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jul 2020 20:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGQSZ2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 14:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgGQSZ1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 14:25:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99F2C0619D3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 11:25:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n5so7075055pgf.7
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=gfp8TD0TK5ywr5xVIQqXt4UYUBwsLiLq5aLmh/fWgMc=;
        b=NpK8ZB0bdMbxWzl/pq5VT8a0z5qKaNdaPRH3iPx1izQuG7KZYGuCrOn0OChRrsqiBj
         NkTGh1GSEJ6LAqS6Kc82gI4caz6SMeMYuVQ8L9dOG5PC13mv2aKQCsu8jcR57u5f2VS/
         xm6sLguFQeBqRolXBBSzNxA/YEcTdC6Qv9iUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gfp8TD0TK5ywr5xVIQqXt4UYUBwsLiLq5aLmh/fWgMc=;
        b=UWuvT5P7lHyzofRebAFZO1AUb/uNOZNBGX7V1IWVo0DbahQxVokxFJLNrkhx1UV0sb
         Q9ajlxjCjpbUcFi3kEUueHWnTXMMSd1be9wPh15Zc2T3pfMYGIK4OpbeowyMhafGj3dM
         ewZKYEBU2uaGrt/2cMrztwN4uHoJ8GtmwZ6lCqTbYuiu/xg9Kno+rEtBQoATUm6rTK/N
         XkAWlDp9Ruc/gu/TZhAql0bx5sLaZ8M4LSDXh6lg4z86MOR/0XoYvd1gFelYLjEmBpx2
         E7+KBt8Io64w3qRtSfSl4EQjdEaTiddaiSdqq4VaI1VusZwrZ8Rj6ucy7ndEc+8hcXl2
         pU6g==
X-Gm-Message-State: AOAM53346c8SJDSlpN/4dPG1svj+QCTimEPI1jOcn6QTIyDFT2bI7pmd
        diBQmRfWPx5zmtslFgOTBfkytw==
X-Google-Smtp-Source: ABdhPJwZQAZQ+VC4KmggFqf57W1uimgfpchQ5C/usQb8ZksJ+7N3YyoL1HAWPxDbNvBojkwQlzbILQ==
X-Received: by 2002:aa7:9e0e:: with SMTP id y14mr8590826pfq.77.1595010327276;
        Fri, 17 Jul 2020 11:25:27 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x8sm8374708pfn.61.2020.07.17.11.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:25:26 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v2] pwm: bcm-iproc: handle clk_get_rate() return
Date:   Fri, 17 Jul 2020 11:25:12 -0700
Message-Id: <20200717182512.26001-1-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Handle clk_get_rate() returning <= 0 condition to avoid
possible division by zero.

Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>

---
Changes from v1: ensure  'polarity' and 'enabled' are populated
when clk_get_rate is 0.
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

