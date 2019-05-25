Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161BC2A649
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2019 20:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfEYSMd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 May 2019 14:12:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36244 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbfEYSL6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 May 2019 14:11:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id s17so12977614wru.3;
        Sat, 25 May 2019 11:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zy3igJq07cYQSMxFomj95OIsp+cg4RA7m3SIK+lG8bU=;
        b=RWIwPiKWpW+8hhJ064VFfHfgeJUrYzzyTSpEwMVt2y7w5U1LDQPlCjNTLk0z5GqVmX
         /SvB9jaw4CudwdT9ej5tHOVNWB+LrVGJmUHbuucV4a3Tzn5m5vh2p8+CsaSL65BEcMbp
         2zOonGmORz1V77vECNFInY1MgMO1n8324iCp8p3wCZJHICJnxGj9d8sdZUOcM08VRniZ
         5LTEf8MAGuJMQzDDMK9ajNTMPKeLiao+h94sBiV1W7mdtS9QoFylcrxArsri3ZIWScZd
         1SFi/Puqi0dTTk4wu0k/ujt+tbt3MPP90RZsZo2lYCdLFT04piE4G7jJW+ZJ49ofrv4A
         NIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zy3igJq07cYQSMxFomj95OIsp+cg4RA7m3SIK+lG8bU=;
        b=s0fS8H25i6bTbcvpC18KqWRGMR5eakyac58zQ8YN115cy818BzwZfxVxX/RW9XFnJu
         llHhx2Ib95SwKnVZFbp405tooJ2GfwT4oRgDTGJ5MNgJeG0cl4IP8or/Fpmp297vaY+9
         0hdk2xBadiG0fr+PB4ivPkawPBvW4WHB2SY91qDxjfwkWy8mJL7SwfSr+F6DzY+bJA79
         nVNORwEIzVXYsggSJyixREGm/N3iAF8UCfcEaMheVHQG+/vdHONcMeHD9F7opgZGe8Ms
         INH5bHQ3+6cmRZDE8xHX44w1wa7hTq9CNrGmv+93D2zU/rqNMV4iNY1j5y/Mi9Ssh88K
         hRFQ==
X-Gm-Message-State: APjAAAW1gJru7qvg2yO4LSzdamamQA6KKRknvM2NQHABSll9haCpDEsc
        g8rv8P1fI78JL1m+eA+WcR0=
X-Google-Smtp-Source: APXvYqyGLjQ0zfRugxJ+mFnXR75GhggtBiLimgCtvpXe9134qnfxnS/Gk3IRfijOU6tSHqUDc6AjyQ==
X-Received: by 2002:adf:e909:: with SMTP id f9mr3364863wrm.231.1558807915828;
        Sat, 25 May 2019 11:11:55 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:55 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 10/14] pwm: meson: simplify the calculation of the pre-divider and count
Date:   Sat, 25 May 2019 20:11:29 +0200
Message-Id: <20190525181133.4875-11-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Replace the loop to calculate the pre-divider and count with two
separate div64_u64() calculations. This makes the code easier to read
and improves the precision.

Two example cases:
1) 32.768kHz LPO clock for the SDIO wifi chip on Khadas VIM
   clock input: 500MHz (FCLK_DIV4)
   period: 30518ns
   duty cycle: 15259ns
old algorithm: pre_div=0, cnt=15259
new algorithm: pre_div=0, cnt=15259
(no difference in calculated values)

2) PWM LED on Khadas VIM
   clock input: 24MHz (XTAL)
   period: 7812500ns
   duty cycle: 7812500ns
old algorithm: pre_div=2, cnt=62004
new algorithm: pre_div=2, cnt=62500
Using a scope (24MHz sampling rate) shows the actual difference:
- old: 7753000ns, off by -59500ns (0.7616%)
- new: 7815000ns, off by +2500ns (0.032%)

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 27915d6475e3..9afa1e5aaebf 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -12,6 +12,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -145,7 +146,6 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	unsigned int duty, period, pre_div, cnt, duty_cnt;
 	unsigned long fin_freq = -1;
-	u64 fin_ps;
 
 	duty = state->duty_cycle;
 	period = state->period;
@@ -164,24 +164,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 	}
 
 	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
-	fin_ps = (u64)NSEC_PER_SEC * 1000;
-	do_div(fin_ps, fin_freq);
-
-	/* Calc pre_div with the period */
-	for (pre_div = 0; pre_div <= MISC_CLK_DIV_MASK; pre_div++) {
-		cnt = DIV_ROUND_CLOSEST_ULL((u64)period * 1000,
-					    fin_ps * (pre_div + 1));
-		dev_dbg(meson->chip.dev, "fin_ps=%llu pre_div=%u cnt=%u\n",
-			fin_ps, pre_div, cnt);
-		if (cnt <= 0xffff)
-			break;
-	}
 
+	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
 	if (pre_div > MISC_CLK_DIV_MASK) {
 		dev_err(meson->chip.dev, "unable to get period pre_div\n");
 		return -EINVAL;
 	}
 
+	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
+	if (cnt > 0xffff) {
+		dev_err(meson->chip.dev, "unable to get period cnt\n");
+		return -EINVAL;
+	}
+
 	dev_dbg(meson->chip.dev, "period=%u pre_div=%u cnt=%u\n", period,
 		pre_div, cnt);
 
@@ -195,8 +190,8 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 		channel->lo = cnt;
 	} else {
 		/* Then check is we can have the duty with the same pre_div */
-		duty_cnt = DIV_ROUND_CLOSEST_ULL((u64)duty * 1000,
-						 fin_ps * (pre_div + 1));
+		duty_cnt = div64_u64(fin_freq * (u64)duty,
+				     NSEC_PER_SEC * (pre_div + 1));
 		if (duty_cnt > 0xffff) {
 			dev_err(meson->chip.dev, "unable to get duty cycle\n");
 			return -EINVAL;
-- 
2.21.0

