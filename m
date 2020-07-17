Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC692246E4
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jul 2020 01:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGQXUG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 19:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgGQXUF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 19:20:05 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64879C0619D2
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 16:20:05 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dp18so12528190ejc.8
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 16:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IVJhKu+Gp3LFHGjQOw8PatWF56LYveANRBsfi3RUZ5Q=;
        b=OnhsRGNmVZDhGNNrNKkJ3qUL/Z4HPDbWsDxx1SWXQzR0Adyl8HZKMHTorIIGW9B+NP
         GdFUuANZ60TLcSe9p19DsazMK4Ni1GrYFMOzG36v/rMXPO5xErDoodh2uKDk56EXPbOF
         Cu9zDXABX/VVZxE2IOk+Wllt3voMXXqKHXhXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IVJhKu+Gp3LFHGjQOw8PatWF56LYveANRBsfi3RUZ5Q=;
        b=mUY2YGUI68+zoPb4OcMtezny9YO5+G79g8qkpsR/xfRXSMs2Nl3mWswT4tg9eTsYb8
         phtbbpN7UwwubCadvornG4pkyJzztadvNAINoP8iw9bNV90xm6ImcslBpw8IA4Ekk+Ca
         idtXyOzG80Yp8nmLr2rBRUrhtp50K9VNXHFzEXdZBoK8fnZbfKzIzG+dHy2A+g27LFAq
         yF8etiwnzQAeeOPtCAtu3uLW+tPau/iDyaonyaH66ILQOWMdkRrmroJ/9+a73t7iGPmT
         324RFAnTxlt6BbJmtquYfSYUYojozTb9rRkArTOeiMWiopVCI9+jHQMdumxiyPDC0NL6
         nY/g==
X-Gm-Message-State: AOAM5320nJ51HsjW0WsaGEGu5yRw8shK6rBZ5n+FiyDvqXfzx98gxDFJ
        +xMtcNJ9vsjyCE4n1v1t2Jtw6BFbC32dMw==
X-Google-Smtp-Source: ABdhPJwdBaBHYKfugz8zuvk0G6zHnB4TwuV69YU6wyOAEVVWulh+am5y0KaMTj8EfN6DKOnSFcXEDQ==
X-Received: by 2002:a17:906:fcba:: with SMTP id qw26mr10599993ejb.112.1595028003947;
        Fri, 17 Jul 2020 16:20:03 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id v11sm9074093eja.113.2020.07.17.16.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 16:20:03 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v3] pwm: bcm-iproc: handle clk_get_rate() return
Date:   Fri, 17 Jul 2020 16:19:54 -0700
Message-Id: <20200717231954.11695-1-scott.branden@broadcom.com>
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
Reviewed-off-by: Ray Jui <ray.jui@broadcom.com>

---
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

