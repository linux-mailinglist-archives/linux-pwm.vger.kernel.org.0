Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26596F31C6
	for <lists+linux-pwm@lfdr.de>; Mon,  1 May 2023 16:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjEAODZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 May 2023 10:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjEAODZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 May 2023 10:03:25 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4443E45
        for <linux-pwm@vger.kernel.org>; Mon,  1 May 2023 07:03:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f196e8e2c6so24839275e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 01 May 2023 07:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682949802; x=1685541802;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPKLIXENJWwnp6qccK2W7S+dB0m6Orv/h3gsSqIcq0o=;
        b=GBDrRMx/hWswUbeEHT9HXtvGsYYcp8hwfjkQw5wVAL7EknjfxsPOOlP/jCOr7rwLI5
         87RFr+y0D5MPOagJjxH2CbvxX3Ga79NezmJdQUsTAkwdgnJK32mDHlgTFPTJRgDs/7w2
         X+JLWhM4k214r0J5MbBZv/kLzKSb0XXiaoh4REGXWSgz56Q4Zqs8g6yZns5WgiCUjAlO
         PaGzUyumtNwWqqZDFGFFs7NJbHAbmkIfen/y21DLDrCysc5KxhBkw02pY5qq7yKYvbbO
         RVU+W0XjXoEq4zmB2BAkIeiLm7VAjhikGEieAxyRutBLAYKU8j3WVSBb10FJTk7e+EVb
         R7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682949802; x=1685541802;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yPKLIXENJWwnp6qccK2W7S+dB0m6Orv/h3gsSqIcq0o=;
        b=HqFx6ZNZlMgcpjEhud7UWHjRUBVuRHvG+hFcbCitthDX5eN1mbhZ7SNRPoUlUheJxC
         I9IBIPDQvxBzTTssxkPTC9/DO+DwpEqr3LZwKOg94/V2wzMwZeKtrPFO9hO19/U9oSHS
         mRBTgYWwev1tqnKwpcj5thHMdxUnrAIvBMht8YB3nmOAu5wA3cGMzdfwKsIX8QeCeOhP
         2GS4Vxf08jZJBRlzqFCtJGkXxPGgzab+/i9KLZyQJRDd+xW2jp/CTleplGvhx/slVulL
         ZRhAYPMdYXKH1Jqvpp2m5jk1wP3Bic/xW5LPqgShUsVMZipQ6Ekk2Pga4sy68xUDvkpK
         o9hg==
X-Gm-Message-State: AC+VfDxTgol/Z1inrBv8w2EhVXg7qjO6IQv9SV1ih2rdRXfv6H/3b7kg
        2dWrlQjVvGwnKmjlF60xW1uMrjajvtM=
X-Google-Smtp-Source: ACHHUZ6MPj9x4HSQDZyR5H3TnuNnERkVGEPbo4DKVB09sdN5x23YMfIs/BN0HTeGtDYUPTomX9+JAw==
X-Received: by 2002:a1c:7312:0:b0:3f3:2e4e:c738 with SMTP id d18-20020a1c7312000000b003f32e4ec738mr5839980wmb.3.1682949801869;
        Mon, 01 May 2023 07:03:21 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b9bd:5800:60ec:422b:628c:6ca5? (dynamic-2a01-0c23-b9bd-5800-60ec-422b-628c-6ca5.c23.pool.telefonica.de. [2a01:c23:b9bd:5800:60ec:422b:628c:6ca5])
        by smtp.googlemail.com with ESMTPSA id v9-20020a05600c444900b003f173be2ccfsm47610223wmn.2.2023.05.01.07.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 07:03:21 -0700 (PDT)
Message-ID: <f48f17a7-7f50-c5ef-cc8f-007d0cb302b0@gmail.com>
Date:   Mon, 1 May 2023 16:03:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
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
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] pwm: meson: modify and simplify calculation in
 meson_pwm_get_state
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- improve commit description
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
2.40.0
