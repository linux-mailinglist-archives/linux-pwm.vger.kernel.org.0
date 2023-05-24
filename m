Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13D70FEC2
	for <lists+linux-pwm@lfdr.de>; Wed, 24 May 2023 21:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjEXTwo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 May 2023 15:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEXTwn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 May 2023 15:52:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE417BB
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 12:52:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-96f8d485ef3so200519466b.0
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684957960; x=1687549960;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cQt4vB+zOkte7n2X6CmDlExagU5OjizdoI8k0JY4EOQ=;
        b=VLVIYvlc3xdaG9fQAmq0qTM3/d1XkHI3Dy98zU6LPqU4j5jkVLj8I0l/QfJ7fopq98
         Y7udraFpDOT4vT7TH7YRfIGNbH+0QmXBCVX2c8K5/ts1UEuHJwJcwBh8F5nRiCqnmu7z
         64PwJNGolisTqhQv51c9N+U5tgIiGUcNEi17zZAc1zvKnN/CYHpWc8L/7QE/KjYta1ew
         xDlfRkAn+LD8+6awh1IWOSRb2KBGHzdBJ6X6MD0Dd1NuxloSv54VIxiByoAtQPWzP57T
         w1qrMJvK4K7conyQxYAGkGqWpGMN3bV3R4GVwYOACNWGCQeMU+P8aYtAISWeLYpMcUQz
         mrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957960; x=1687549960;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQt4vB+zOkte7n2X6CmDlExagU5OjizdoI8k0JY4EOQ=;
        b=frjY2zTj1Via2hC4gYadkEKHQiwL9l4bWX8Ebx49Oup1Ks+IJ0lJpe40gK5l1D5Uad
         RAd2phi4Aud3ydF3NcHBirfQSzX5wcFz1B8L5I3FP9hC4roW2LPFBxDe4rv8FFwyoZin
         btxjnGsiJmtQPvTxKRpquUS7JlLH3eLpBo3aO+V2Zi3yVjiRCXDrpl18gJ3Lvx94ppPd
         gNMaA9a2iDPeRcUUyieJWEXLtR42PhO4wsQWSK6Xc+9VptgIEf+LEdBvRZ6rh+GV3ReL
         G1dx4afS0O4UlytSfA+ksRuuDFXG4bz7UglXaGFEVVl35nYHAZ7S7asDKXPv8vBYBSA2
         UmFg==
X-Gm-Message-State: AC+VfDwhNjIiMJKrvxTn+mLhoc0VyvI7wiNTWlbYgs42JbZXT8NmUCTO
        lNaDkJ0q0wQvmnS40Ixew8w=
X-Google-Smtp-Source: ACHHUZ6dOxNjjb/xWU+h6RMte8RHv9yjBTI+rcetpEsrC+chSNhcbvNnj6piReqjqfzJg4MSRSPQtA==
X-Received: by 2002:a17:907:9449:b0:969:cbf4:98fa with SMTP id dl9-20020a170907944900b00969cbf498famr17499502ejc.65.1684957960342;
        Wed, 24 May 2023 12:52:40 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c519:9c00:cd4b:d130:35c7:5e08? (dynamic-2a01-0c23-c519-9c00-cd4b-d130-35c7-5e08.c23.pool.telefonica.de. [2a01:c23:c519:9c00:cd4b:d130:35c7:5e08])
        by smtp.googlemail.com with ESMTPSA id jy2-20020a170907762200b0096f689848desm6160383ejc.195.2023.05.24.12.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 12:52:40 -0700 (PDT)
Message-ID: <404a7747-298c-683f-e32c-5f009fff744f@gmail.com>
Date:   Wed, 24 May 2023 21:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: [PATCH v5 RESEND 2/6] pwm: meson: fix handling of period/duty if
 greater than UINT_MAX
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        linux-pwm@vger.kernel.org,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>
References: <aa498590-261c-4ada-63ff-8d7aaeec0932@gmail.com>
In-Reply-To: <aa498590-261c-4ada-63ff-8d7aaeec0932@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

state->period/duty are of type u64, and if their value is greater than
UINT_MAX, then the cast to uint will cause problems. Fix this by
changing the type of the respective local variables to u64.

Fixes: b79c3670e120 ("pwm: meson: Don't duplicate the polarity internally")
Cc: stable@vger.kernel.org
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 3865538dd..33107204a 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -156,8 +156,9 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
 	struct meson_pwm_channel *channel = &meson->channels[pwm->hwpwm];
-	unsigned int duty, period, pre_div, cnt, duty_cnt;
+	unsigned int pre_div, cnt, duty_cnt;
 	unsigned long fin_freq;
+	u64 duty, period;
 
 	duty = state->duty_cycle;
 	period = state->period;
@@ -179,19 +180,19 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 
 	dev_dbg(meson->chip.dev, "fin_freq: %lu Hz\n", fin_freq);
 
-	pre_div = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * 0xffffLL);
+	pre_div = div64_u64(fin_freq * period, NSEC_PER_SEC * 0xffffLL);
 	if (pre_div > MISC_CLK_DIV_MASK) {
 		dev_err(meson->chip.dev, "unable to get period pre_div\n");
 		return -EINVAL;
 	}
 
-	cnt = div64_u64(fin_freq * (u64)period, NSEC_PER_SEC * (pre_div + 1));
+	cnt = div64_u64(fin_freq * period, NSEC_PER_SEC * (pre_div + 1));
 	if (cnt > 0xffff) {
 		dev_err(meson->chip.dev, "unable to get period cnt\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(meson->chip.dev, "period=%u pre_div=%u cnt=%u\n", period,
+	dev_dbg(meson->chip.dev, "period=%llu pre_div=%u cnt=%u\n", period,
 		pre_div, cnt);
 
 	if (duty == period) {
@@ -204,14 +205,13 @@ static int meson_pwm_calc(struct meson_pwm *meson, struct pwm_device *pwm,
 		channel->lo = cnt;
 	} else {
 		/* Then check is we can have the duty with the same pre_div */
-		duty_cnt = div64_u64(fin_freq * (u64)duty,
-				     NSEC_PER_SEC * (pre_div + 1));
+		duty_cnt = div64_u64(fin_freq * duty, NSEC_PER_SEC * (pre_div + 1));
 		if (duty_cnt > 0xffff) {
 			dev_err(meson->chip.dev, "unable to get duty cycle\n");
 			return -EINVAL;
 		}
 
-		dev_dbg(meson->chip.dev, "duty=%u pre_div=%u duty_cnt=%u\n",
+		dev_dbg(meson->chip.dev, "duty=%llu pre_div=%u duty_cnt=%u\n",
 			duty, pre_div, duty_cnt);
 
 		channel->pre_div = pre_div;
-- 
2.40.1


