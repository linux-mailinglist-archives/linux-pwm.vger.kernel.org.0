Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7686770FEC1
	for <lists+linux-pwm@lfdr.de>; Wed, 24 May 2023 21:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjEXTwm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 24 May 2023 15:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEXTwl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 24 May 2023 15:52:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83EA5BB
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 12:52:40 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51426347bd2so1806846a12.2
        for <linux-pwm@vger.kernel.org>; Wed, 24 May 2023 12:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684957959; x=1687549959;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FfpJcXgNC9r2DJpgp6E9iGBv/JmFVRlvC0D1pq4re0k=;
        b=RyeyFUci0Xkt3P2B6mgdNQYs5srDXC6YVdvztLyA0HhBmXkdEzPioa6aoT2CbHeCCh
         vwrKMEXZA9hWTdO2IW4nQQSn2NLYjjSzx01lJoQtVMzyQ2QrvDnpjIQ9S/L/oau1bhtG
         ouY/95M7IpRpLWExR8yefpbOoekwlXHa6YG4UKzOFu+l0AJ9FdjKkd/72CNYM/GhbLsd
         EVwW+IN+x8sUJEBFovKYJMD51o0/a7f0C1U0BQLr+kJi0r8Rv/oqrPcS+mvd6Q/A+R5O
         9SetGwMTAlbUWxAqwwaGtL5DEMwy/z/yRIKOHvbff+rA04BMj//G47ihP2NvpfKq1Kpx
         z6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684957959; x=1687549959;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FfpJcXgNC9r2DJpgp6E9iGBv/JmFVRlvC0D1pq4re0k=;
        b=lTv59yAF8A6FQApOkKIBm3Ngr0SYugxji4IdcPKQ1RXFfOzXNXbfkGiMalmq8Bn/lQ
         rIqTuP77bpCAsWa0tB0b/ZERKGC0T4tFgUZwljjiW4FCkmW9nNJd6t+TcsnTMY0UHzfg
         UiHYYb5Mkls6R4k7mTMsaEcWcMY09TX5tPh13jYb3pnzbk7C81YwO54CHc1mGRo+tO9i
         85CEiYbjHTi0YP4wDvJUwvIGxx1jXpd3FLnf3FzB+5nBtLVTfAGmhA4Kx4ht0rZ9TinT
         TcqRS+ki9BEgkwd8x+Ow/BsccxJPHMN8dKw3h9gulRSEE0kkBKwCr93rYy8DeO60yQLi
         IS7Q==
X-Gm-Message-State: AC+VfDyxUR/0n7hZI3SYSTEZIBkBerUaaq8V/QxzRoVDmdlX5MHGfMMv
        BM8+K5eGLyX0ODRL6L4if3jfspfXZhw=
X-Google-Smtp-Source: ACHHUZ5LNXTyD94Y8CVwqrQrbJL9IGSs2sEcAr6YfOqlSGqos84mpbqvuYMAKymvzgVdMu1Hx9bW2g==
X-Received: by 2002:a05:6402:187:b0:4fd:2b04:6e8b with SMTP id r7-20020a056402018700b004fd2b046e8bmr2979484edv.29.1684957958850;
        Wed, 24 May 2023 12:52:38 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c519:9c00:cd4b:d130:35c7:5e08? (dynamic-2a01-0c23-c519-9c00-cd4b-d130-35c7-5e08.c23.pool.telefonica.de. [2a01:c23:c519:9c00:cd4b:d130:35c7:5e08])
        by smtp.googlemail.com with ESMTPSA id bq2-20020a056402214200b00510d7152dc7sm249605edb.30.2023.05.24.12.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 12:52:38 -0700 (PDT)
Message-ID: <2f376c8b-32a9-a3a7-3454-4a864ab8ab44@gmail.com>
Date:   Wed, 24 May 2023 21:47:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: [PATCH v5 RESEND 1/6] pwm: meson: modify and simplify calculation in
 meson_pwm_get_state
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

I don't see a reason why we should treat the case lo < hi differently
and return 0 as period and duty_cycle. The current logic was added with
c375bcbaabdb ("pwm: meson: Read the full hardware state in
meson_pwm_get_state()"), Martin as original author doesn't remember why
it was implemented this way back then.
So let's handle it as normal use case and also remove the optimization
for lo == 0. I think the improved readability is worth it.

Fixes: c375bcbaabdb ("pwm: meson: Read the full hardware state in meson_pwm_get_state()")
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pwm/pwm-meson.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 5732300eb..3865538dd 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -351,18 +351,8 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
 	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
 
-	if (channel->lo == 0) {
-		state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
-		state->duty_cycle = state->period;
-	} else if (channel->lo >= channel->hi) {
-		state->period = meson_pwm_cnt_to_ns(chip, pwm,
-						    channel->lo + channel->hi);
-		state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm,
-							channel->hi);
-	} else {
-		state->period = 0;
-		state->duty_cycle = 0;
-	}
+	state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel->hi);
+	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
 
 	state->polarity = PWM_POLARITY_NORMAL;
 
-- 
2.40.1


