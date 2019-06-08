Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66593A10E
	for <lists+linux-pwm@lfdr.de>; Sat,  8 Jun 2019 20:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfFHSHI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 8 Jun 2019 14:07:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53059 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfFHSGq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 8 Jun 2019 14:06:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so4934695wms.2;
        Sat, 08 Jun 2019 11:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2ePKIZM3a5wh4lPG0Ppb3tJa/t/8p/W8m/D9X1owsTQ=;
        b=Y9O92NwlXSOI90yGc6Bd2VwrxCy+i9xulc3WGCWS5CXL4GS0LKERZF0PokmHXIIdfG
         i2h2CvJGMU6NZpGh1zhBEt9UUAAmiuHgf6Io9ckto9M13xLIJbZLoHXI2d6hCq4fh31v
         GygElivXyhYuClQ259oZce3CvWnpI75rkDcfYN+xfDnLBeejcKF6rd2nNBQUDHFfYZfN
         13zqIvODOVRkMLtgwYRbKb4rnjWjDjIRCIL7z2J/KHljxBRAzUqnQGtiIrJIJDr5jyMg
         HbqMBLz9SEZZqVUBA4WmxnS5CmhEM6GXBRsFot/ijZj+XG1wZKLpjTGpSARp9sf7ibhW
         9v/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2ePKIZM3a5wh4lPG0Ppb3tJa/t/8p/W8m/D9X1owsTQ=;
        b=rx/PIAFgkPy/yQhpeErVc+t6tKTPwognaabenT/sITezlWO7MPhX3BiKE0YPFOTFEl
         QgMkcs1aTyaIq56L6RmhbSoJL27XbRW3dpF/8EIGGdiwh+Ext85im0tyu3gJaHBt5tQ3
         cxKZR2JypxiCSJ3NZOmIdSmW11AYfYyprMvF1nsdGz/hddBWUwrF/uti60OSnmDSpwr2
         FuRCtnehxTkDvEZultfvCQKRGkYcb0h5aYPxSzlDfliZGPR7oogals+s0iIH4kiAGcUh
         zeffc/qu8Zw10HESg8YoDLOdGxMwze4QcTUUMOHJkr4SC7gliVA/aiglgeYwzqBs4k0a
         kYbA==
X-Gm-Message-State: APjAAAXRa6I7i7XkMEYzBsragv7m5PmcbhC6GidXTe5wllaYdNwSsX6p
        HUwdgGEo62kPC5xN3TpmKrM=
X-Google-Smtp-Source: APXvYqxbv/NeCKxrR0YfqhHFUUkHcwGnY64PiWza/hkJzJEYbBvx+QBL4fvOmg2j8osIXtSlnNKi1Q==
X-Received: by 2002:a7b:c444:: with SMTP id l4mr7641358wmi.15.1560017204346;
        Sat, 08 Jun 2019 11:06:44 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA400D12EFF43FED1E981.dip0.t-ipconnect.de. [2003:f1:33dd:a400:d12e:ff43:fed1:e981])
        by smtp.googlemail.com with ESMTPSA id c7sm5143345wrp.57.2019.06.08.11.06.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 08 Jun 2019 11:06:43 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com
Cc:     u.kleine-koenig@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 10/14] pwm: meson: simplify the calculation of the pre-divider and count
Date:   Sat,  8 Jun 2019 20:06:22 +0200
Message-Id: <20190608180626.30589-11-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
References: <20190608180626.30589-1-martin.blumenstingl@googlemail.com>
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
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
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

