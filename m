Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 324492A645
	for <lists+linux-pwm@lfdr.de>; Sat, 25 May 2019 20:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfEYSMU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 May 2019 14:12:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37898 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727603AbfEYSMA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 May 2019 14:12:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id t5so12065327wmh.3;
        Sat, 25 May 2019 11:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6S6JiWbeadjUYysdt7Ty07UEhlqvmUYPEJBP3QF3hM=;
        b=lx8XVhGvLDMQjYEVrJPEmnwBBTQehcGtinH8oHdm/4miWFMb8wceXX8jL1uQYSvHcn
         WuKaflyXnEtIhg2pb3HvjEHGZrBrUpSa2yhsxgjaKiWKSgL5Rw0/Jk7rIb4u0KkSjdcM
         VfaXAwToMcOK6e3zFaqaC9ZoZN9tcQocVlAruqFfiZfiyrfxekfd5H6SW3c4tZbU55ku
         +jDmmH5/3loeJ50a/RXvt6ZtHzsnVS875Y5NwvkRZlDSg6Asum8PIcjEq3JhMVx1Btik
         OPE7MyUPTE4MmRiwg21SEH7/i3MZ+oxxLJCsH1z4wZs+8adtDUihlT2hCcPL4ownOz60
         pK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6S6JiWbeadjUYysdt7Ty07UEhlqvmUYPEJBP3QF3hM=;
        b=JT8jLQ8lmS7F9ALkOr1SfmN+SzAlDeHZG+KoUFSVc38hOCp+Xa6eG5c1q2LAzDu4hS
         7RJ57TLNL8qXdP9Br1wUNjqOUyN6Wk3yi7mDxgqLu0K33H/l1H1MPqQpEcpsnTog+vvz
         k28SslDtXLCZjUo7isq2x3bgcTGo6/wyFbQOxq6H//bWDgx3tibm5ad26vpvrqP44y4l
         z2yOrjMgBI2ZohAcx1fjox+Q3OkY2ZUA1ISfrZU5zypx0IK9XMuChmK2K96AvRFy1orl
         yLpopXdOb8MShtu9xsZkPMz0G8//99gTVz6OUnIjFkpD3YBgX0lKkiyKLMfEf/2qV1U1
         dHyg==
X-Gm-Message-State: APjAAAX/VUS+BKSasIqBmWTSPrgIUVie/FsnYvuNGzbDZCs+FJayGjPv
        C/HRO/2w110JQgflV8aRfqs=
X-Google-Smtp-Source: APXvYqx6kFreg3BLEOIWbXJYIuM1mGpx/LBYClCrw3+XYYRGohma4/peBmcQ0YcSmgi2Lq7OJuGEiQ==
X-Received: by 2002:a1c:7001:: with SMTP id l1mr7127484wmc.40.1558807919098;
        Sat, 25 May 2019 11:11:59 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133DDA4007CB8841254CD64FD.dip0.t-ipconnect.de. [2003:f1:33dd:a400:7cb8:8412:54cd:64fd])
        by smtp.googlemail.com with ESMTPSA id o8sm12794540wra.4.2019.05.25.11.11.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 11:11:58 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 13/14] pwm: meson: add support PWM_POLARITY_INVERSED when disabling
Date:   Sat, 25 May 2019 20:11:32 +0200
Message-Id: <20190525181133.4875-14-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
References: <20190525181133.4875-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

meson_pwm_apply() has to consider the PWM polarity when disabling the
output.
With enabled=false and polarity=PWM_POLARITY_NORMAL the output needs to
be LOW. The driver already supports this.
With enabled=false and polarity=PWM_POLARITY_INVERSED the output needs
to be HIGH. Implement this in the driver by internally enabling the
output with the same settings that we already use for "period == duty".

This fixes a PWM API violation which expects that the driver honors the
polarity also for enabled=false. Due to the IP block not supporting this
natively we only get "an as close as possible" to 100% HIGH signal (in
my test setup with input clock of 24MHz and measuring the output with a
logic analyzer at 24MHz sampling rate I got a duty cycle of 99.998475%
on a Khadas VIM).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pwm/pwm-meson.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 900d362ec3c9..bb48ba85f756 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -245,6 +245,7 @@ static void meson_pwm_disable(struct meson_pwm *meson, struct pwm_device *pwm)
 static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   struct pwm_state *state)
 {
+	struct meson_pwm_channel *channel = pwm_get_chip_data(pwm);
 	struct meson_pwm *meson = to_meson_pwm(chip);
 	int err = 0;
 
@@ -252,7 +253,27 @@ static int meson_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 
 	if (!state->enabled) {
-		meson_pwm_disable(meson, pwm);
+		if (state->polarity == PWM_POLARITY_INVERSED) {
+			/*
+			 * This IP block revision doesn't have an "always high"
+			 * setting which we can use for "inverted disabled".
+			 * Instead we achieve this using the same settings
+			 * that we use a pre_div of 0 (to get the shortest
+			 * possible duration for one "count") and
+			 * "period == duty_cycle". This results in a signal
+			 * which is LOW for one "count", while being HIGH for
+			 * the rest of the (so the signal is HIGH for slightly
+			 * less than 100% of the period, but this is the best
+			 * we can achieve).
+			 */
+			channel->pre_div = 0;
+			channel->hi = ~0;
+			channel->lo = 0;
+
+			meson_pwm_enable(meson, pwm);
+		} else {
+			meson_pwm_disable(meson, pwm);
+		}
 	} else {
 		err = meson_pwm_calc(meson, pwm, state);
 		if (err < 0)
-- 
2.21.0

