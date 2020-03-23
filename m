Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA1518EFF8
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 07:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgCWGxl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Mar 2020 02:53:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40879 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbgCWGxl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 02:53:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id a81so7646956wmf.5
        for <linux-pwm@vger.kernel.org>; Sun, 22 Mar 2020 23:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C3DogahGC9+RykrmX70/1+RE3NkN/OINb0pWKE0oiy4=;
        b=g3ks5wvh67hKay0usPtxla8zP4/ICys2eEZE2K2tUDUgQQl7Th+BDUgKXXp1AChHqM
         Hrc9Jfbt1PO3FMGfvF8dFCofuxtqQqRaXbCoBBKdeU0XQEczUdsuxO/1CHUN2yOD74SX
         bnUREGRRB5d9rtVwRNdRfZgeKXv2Vw81fQkig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C3DogahGC9+RykrmX70/1+RE3NkN/OINb0pWKE0oiy4=;
        b=sQonk0CsRx9tSnpgRKYBvMZ1zhEQgm5KLthEDCdf0NsZhehtUkvKgwvmSB/WCBncIr
         TgP6KTDMR/CWHeDTEid17ydpK4iDBUp1P7kEw7hvjmo9c8ZFuJjKYvePjn8Kd/qGC1U5
         TyKohC47SpJXhZgihsHUa5NnwoAMwXYhmxKhFbNyvNY8e7UzusVxmMKGMKprGYYNNBkE
         oic5npZAh481oGkDqwfYDuw/GN03L4EKVikxvz67w5p9+VQQyDxLvNQWBLeH954EBNss
         dMpK7S6rhHrGgFfVGD2Xfw3ZLC1Z2upHVrPuzuU8uXsbDQx9GRa+Tvht2AcE6borThQl
         cEfA==
X-Gm-Message-State: ANhLgQ3+fhzhGCVZdtHdOpnwJ2pQRp2BKj2JAcMSo+Sxzqy7m68N5R3s
        QAgFv84PcduasrUQD4boN8kMzA==
X-Google-Smtp-Source: ADFU+vtUdIK/nmJ5km4kTi10jFNj5bmdEnLO9j2fB7uf9CpemLLpupJmfYE4Pun9FHYO8c9rMSa6kg==
X-Received: by 2002:a05:600c:4013:: with SMTP id i19mr10552720wmm.17.1584946419207;
        Sun, 22 Mar 2020 23:53:39 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g128sm21127453wmf.27.2020.03.22.23.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 23:53:38 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/2] pwm: bcm-iproc: handle clk_get_rate() return
Date:   Mon, 23 Mar 2020 12:23:17 +0530
Message-Id: <20200323065318.16533-2-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
References: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Handle clk_get_rate() returning <= 0 condition to avoid
possible division by zero.

Fixes: daa5abc41c80 ("pwm: Add support for Broadcom iProc PWM controller")
Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 drivers/pwm/pwm-bcm-iproc.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 1f829edd8ee7..8bbd2a04fead 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -99,19 +99,25 @@ static void iproc_pwmc_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		state->polarity = PWM_POLARITY_INVERSED;
 
-	value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
-	prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
-	prescale &= IPROC_PWM_PRESCALE_MAX;
-
-	multi = NSEC_PER_SEC * (prescale + 1);
-
-	value = readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->hwpwm));
-	tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
-	state->period = div64_u64(tmp, rate);
-
-	value = readl(ip->base + IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm));
-	tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
-	state->duty_cycle = div64_u64(tmp, rate);
+	if (rate == 0) {
+		state->period = 0;
+		state->duty_cycle = 0;
+	} else {
+		value = readl(ip->base + IPROC_PWM_PRESCALE_OFFSET);
+		prescale = value >> IPROC_PWM_PRESCALE_SHIFT(pwm->hwpwm);
+		prescale &= IPROC_PWM_PRESCALE_MAX;
+
+		multi = NSEC_PER_SEC * (prescale + 1);
+
+		value = readl(ip->base + IPROC_PWM_PERIOD_OFFSET(pwm->hwpwm));
+		tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
+		state->period = div64_u64(tmp, rate);
+
+		value = readl(ip->base +
+			      IPROC_PWM_DUTY_CYCLE_OFFSET(pwm->hwpwm));
+		tmp = (value & IPROC_PWM_PERIOD_MAX) * multi;
+		state->duty_cycle = div64_u64(tmp, rate);
+	}
 }
 
 static int iproc_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.17.1

