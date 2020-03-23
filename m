Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC1318F1B5
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2020 10:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgCWJYt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Mar 2020 05:24:49 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42109 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgCWJYt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Mar 2020 05:24:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id e1so662640plt.9
        for <linux-pwm@vger.kernel.org>; Mon, 23 Mar 2020 02:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C3DogahGC9+RykrmX70/1+RE3NkN/OINb0pWKE0oiy4=;
        b=KY4NTm1xU1uLWsixTz3NKCGR6EPu+Z2kNC/ShiFbEjkV+4fQIuniGYnVYTbdlyeB0U
         BRsww8PZH723mNWmelL0ybE4OPO5GnTtHGYMXxwKr41x9UaPBcttTER9W7dzwxYUr0Ma
         HByNd0+RMg8Gk/1IBidHXMtwssmwRJT4EhhT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C3DogahGC9+RykrmX70/1+RE3NkN/OINb0pWKE0oiy4=;
        b=FDAynV5+N4KE861Beh1vT2pkh5nMeGoh8am1LELc4W8e0swqQx9TEoWlILBRB8fkre
         4RUnNo0vkRxfvmhMguzm1qyQIOMFbp1lS6T/l2e+duSG5efXjFDSHfBqGqyOvytMMDf/
         Wkm1jMx+sykjqH9v5kjFZmfX7BPIlJfATFU0XRKsDkiXtVwsA33QF856Rx00ISFsXYwN
         mP5U6BKnpmKrXx1oxi7iXTFkDpgnaSsVrYZzreOIwcqOw252SUSkMocQ4h/VzSZg++1p
         ishwB995b5n/uP+52GGvrdM8gWUdi6L26Js6MPkkRCxjm8zkKGrqgnM0q8v1gG29A1Rg
         u4TQ==
X-Gm-Message-State: ANhLgQ2H2fClBslPm/AzFri98KG9ScKzMhlRkox/V1h6gEYnbmoGdN1Y
        TgMAg/bX/3RLkTjcols29fUiHQ==
X-Google-Smtp-Source: ADFU+vu3dwbnOc73Ub2kUbNVRr9hWwQpUgSWBw+ncuy5m5W1glqsH76QRsrnl5u0v4Ym8D/QV0KS2A==
X-Received: by 2002:a17:90a:9742:: with SMTP id i2mr2863545pjw.194.1584955488035;
        Mon, 23 Mar 2020 02:24:48 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t186sm1093068pgd.43.2020.03.23.02.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 02:24:47 -0700 (PDT)
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
Subject: [PATCH v2 1/2] pwm: bcm-iproc: handle clk_get_rate() return
Date:   Mon, 23 Mar 2020 14:54:23 +0530
Message-Id: <20200323092424.22664-2-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200323092424.22664-1-rayagonda.kokatanur@broadcom.com>
References: <20200323092424.22664-1-rayagonda.kokatanur@broadcom.com>
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

