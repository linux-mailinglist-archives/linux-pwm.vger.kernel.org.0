Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22D3A43098
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 22:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389958AbfFLT7o (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 15:59:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35835 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389667AbfFLT7o (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 15:59:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so7785477wml.0;
        Wed, 12 Jun 2019 12:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdTVLAwNdb8owtGfmpMjHz1Rqh0e7CEJ+yms9qNEUEE=;
        b=ImFSiHawukgvGDKEkdVhtWjkNYpr3APrYMZTo5l+SYrYXqtCHHgdbiiMYiKzE+q+mZ
         H/+t6xmhBabAbGg1fgqQA5sB7gnazN4hiaMQGW92ZZ4EHnr2sORtUe+HaEJuBswrCeuQ
         AIJtevwzdrNPq1qjD3N76VM9UNBQmFUq32dbu5uucvo9xMC9NrhuiuRRB+dvUQxxME9O
         vxiSROhC3xxZuc1g98xZ3UqRPKi63v9g+P10L+HsKt1iau+QCP8SkL1BtnXoUb4QwJSL
         kbSgb795GiB7r7KV7eOQl87P1z9c0ZNTFHXPKNORoM43MvBy9adh2iEcFtUBs/12k90/
         QUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdTVLAwNdb8owtGfmpMjHz1Rqh0e7CEJ+yms9qNEUEE=;
        b=d2MeHebZ1lWzQbZh4g7TMweBoqsdy8Yk98uS2UhJtegaQM38/YG4QSNuO2RGG62BcK
         IPhtOhwGrQUi/em1VdCMUwbUWnZ5QcANDi9xNRzb9NofNy34oPu1T/aILn2EhSLtX7/B
         7e29RRgWEGboVdsI2BncC5DFZSAjQ1hbhLOO/vPYj4hFA5THghF/W8ViqyQbfANHQ7Oy
         x/1KhUG4pJaTEC8jsG7QJo1Fg8/NceTqKWphGbwUHRg/8RmmQByLe6FDnUTQCnU6JUcG
         1rXUTS0Llhb/R/cO8JHwgk16KmmsvY6C+urAwabCIebj84XtSVn8Vt3SLWVnDcDSTR56
         f5Ng==
X-Gm-Message-State: APjAAAWJrHqrJZhpp0zjXkMCeqSdnxNPycH9THeXMK2XGZp6rwq9FkHM
        sW+9umW/wPQ4Kw10fFfoZ2M=
X-Google-Smtp-Source: APXvYqx1euxXqWvm17uaq4OeXTaDLpI3mLzeZHlbR31M6tMSTIu+iCO+7X2+HMUU/IRX78KClQd3Kg==
X-Received: by 2002:a1c:7614:: with SMTP id r20mr661319wmc.142.1560369581619;
        Wed, 12 Jun 2019 12:59:41 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33dd:a400:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f10sm1026745wrg.24.2019.06.12.12.59.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:59:41 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        u.kleine-koenig@pengutronix.de, narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 10/14] pwm: meson: simplify the calculation of the pre-divider and count
Date:   Wed, 12 Jun 2019 21:59:07 +0200
Message-Id: <20190612195911.4442-11-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
References: <20190612195911.4442-1-martin.blumenstingl@googlemail.com>
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

Three example cases:
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

3) Theoretical case where pre_div is different
   clock input: 24MHz (XTAL)
   period: 2730624ns
   duty cycle: 1365312ns
old algorithm: pre_div=1, cnt=32768
new algorithm: pre_div=0, cnt=65534
Using a scope (24MHz sampling rate) shows the actual difference:
- old: 2731000ns
- new: 2731000ns
(my scope is not precise enough to measure the difference if there's
any)

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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
2.22.0

