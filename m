Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484826F4B6B
	for <lists+linux-pwm@lfdr.de>; Tue,  2 May 2023 22:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjEBUdv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 May 2023 16:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjEBUdu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 May 2023 16:33:50 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96EF19A2
        for <linux-pwm@vger.kernel.org>; Tue,  2 May 2023 13:33:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94ef8b88a5bso665143566b.2
        for <linux-pwm@vger.kernel.org>; Tue, 02 May 2023 13:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683059627; x=1685651627;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqHoRnIi56y0Eq3HCEEwB6zOQFkWe+lN+qtxHiWOfIo=;
        b=phKn5u/TpxfWZCCcLmERJjvTvteJbMzujNbodrPcubv/qRW1vTv/VeX/UslvCfav9f
         wvOzzHXIJ22a1IWgUq1c/c8HiQMbDuachoSGoAJvriCqC3L/AL8jdgw+xmSJTfwRYSBB
         QX1fJRe2av5Tu5yEfer8B4Z1kOHZgEt1EFVKHibM8AHGcT021+E6BVYu8ecsm4dn/O3n
         RkAzWa/DK2nZYS1HTd27JjxHjAQhIZYgZIcLm88qdhfWUTOhohgm5CVT/zL5WYCnOgWU
         1xXDv4I1Ssxpw4eEoRRvYdMmyj4oxyzUHerRLBTDRX9PXB1vCz0haGWlIUPJCpnS43Mi
         srag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683059627; x=1685651627;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BqHoRnIi56y0Eq3HCEEwB6zOQFkWe+lN+qtxHiWOfIo=;
        b=LC7ewSOu9P5wQUM+MUuwYZpfc0Yf53PmUkBXVn7HhrQiIyTHKS93EFMp5iAoAxeYqq
         mZumxE4DdBFIKBp2SGY3kvwkyM0TfzhguuAyv0LOkTmF70fOUDLQAD4HJyy4Fbi86Ymk
         d3QsRDDwEPcOSZ3PQBo0zRQScg1faRKrZ5Ujrn52xsBS2hXk8K83FvB069alCBxvlG1s
         wKqFCv9YdnOX6PMuQQ28wtYuecgsYbZ/xvm5gVp1ew8RanXrfwKpJ2nZrShZMktvfzel
         PTISBlaFoiG94tH/o4kwuIZ6PXS0gMtjVzir1rSltq2gb3O5AR0vw4+CS0Lc2/1a4bCW
         Ga4Q==
X-Gm-Message-State: AC+VfDy8xySUzuGmYUztX7o2vU6pdModhY3souSHWiUkVC5EATgchuQ5
        e7q73x6XTT4gcYhCKbTFbUo=
X-Google-Smtp-Source: ACHHUZ7CpHN6a9lznliOqn1nanEQFGERN1R9MhRwy+t7+nNLrxSwICk5kKcVFMCPWPweRKH8bmA+dA==
X-Received: by 2002:a17:907:7e8d:b0:94d:a2c2:9aeb with SMTP id qb13-20020a1709077e8d00b0094da2c29aebmr1512829ejc.49.1683059627094;
        Tue, 02 May 2023 13:33:47 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9545:b300:8dc9:588b:ac03:5082? (dynamic-2a02-3100-9545-b300-8dc9-588b-ac03-5082.310.pool.telefonica.de. [2a02:3100:9545:b300:8dc9:588b:ac03:5082])
        by smtp.googlemail.com with ESMTPSA id la5-20020a170906ad8500b0094e877ec197sm16727262ejb.148.2023.05.02.13.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 13:33:46 -0700 (PDT)
Message-ID: <23fe625e-dc23-4db8-3dce-83167cd3b206@gmail.com>
Date:   Tue, 2 May 2023 22:33:42 +0200
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
Subject: [PATCH v3] pwm: meson: modify and simplify calculation in
 meson_pwm_get_state
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
Cc: stable@vger.kernel.org
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- improve commit description
v3:
- make patch a fix
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
