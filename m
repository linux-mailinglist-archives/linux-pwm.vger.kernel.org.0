Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F050F6EAD8C
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Apr 2023 16:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjDUO5q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Apr 2023 10:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjDUO5p (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Apr 2023 10:57:45 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272EC1703
        for <linux-pwm@vger.kernel.org>; Fri, 21 Apr 2023 07:57:28 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id C7F805FD2F;
        Fri, 21 Apr 2023 17:57:24 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1682089044;
        bh=kXc8+eTLHxscDSs+Gq31+KDprqZ81SYjJ4bIrlQstqc=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=bdiL/Zv4uiUe4gALoedKo5VShEWwZB8fa72p4Cg8TkMFzg4tQUPQtpiTWVXFWYfNo
         Ya5ic+IHfE/Q24a5IAsSRHXyrXzARRg3hV+dYRfp35pF82GfyXa1jxnoJJWJo5tk3P
         5rjoyJQYaU0R0qBsJjo98l8fmdtyljnvxs7jrelvhOzQxcvZ1XALx+GsmRzyVGg3TF
         hwaI0HFFOdq8efFlpv3FvfP4hMAshhT0OBrhcHBML5FOOXxAzrFZOXOzOHAUExW7+s
         cuPMkSP4cgGVKInX9SfTMUfH93TWSyOd6SgJb581ORlGMdUpILOVT831ZBDl3TJ9yD
         Rf4bViXE1Uzpg==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 21 Apr 2023 17:57:24 +0300 (MSK)
Date:   Fri, 21 Apr 2023 17:57:23 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Heiner Kallweit <hkallweit1@gmail.com>
CC:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        <linux-pwm@vger.kernel.org>, <kernel@sberdevices.ru>
Subject: Re: [PATCH] pwm: meson: simplify calculation in meson_pwm_get_state
Message-ID: <20230421145723.oq7zqbhhz4fhkmyj@CAB-WSD-L081021>
References: <5a5920db-4c32-25e8-d1e3-bd2f724dd242@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <5a5920db-4c32-25e8-d1e3-bd2f724dd242@gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/21 08:36:00 #21135550
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Heiner,

Thank you for the patch! Please find my comments below.

On Wed, Apr 19, 2023 at 11:30:55PM +0200, Heiner Kallweit wrote:
> I don't see a reason why we should treat the case lo < hi that
> different and return 0 as period and duty_cycle. Let's handle it as
> normal use case and also remove the optimization for lo == 0.
> I think the improved readability is worth it.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Inside this patch, in my opinion, you have not only simplified and
optimized but have also modified the logic. It is important to provide
more details on this modification. Previously, in cases where
(channel->lo != 0) && (channel->lo < channel->hi), period and duty_cycle
were not calculated. However, in your patchset, duty_cycle and polarity
are calculated and returned to the caller in such cases.
Can you please share the details of why this is the right solution?
Also, please rephrase the commit message using 'modify' instead of
'simplify'.

> ---
>  drivers/pwm/pwm-meson.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> index 5732300eb..3865538dd 100644
> --- a/drivers/pwm/pwm-meson.c
> +++ b/drivers/pwm/pwm-meson.c
> @@ -351,18 +351,8 @@ static int meson_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	channel->lo = FIELD_GET(PWM_LOW_MASK, value);
>  	channel->hi = FIELD_GET(PWM_HIGH_MASK, value);
>  
> -	if (channel->lo == 0) {
> -		state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
> -		state->duty_cycle = state->period;
> -	} else if (channel->lo >= channel->hi) {
> -		state->period = meson_pwm_cnt_to_ns(chip, pwm,
> -						    channel->lo + channel->hi);
> -		state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm,
> -							channel->hi);
> -	} else {
> -		state->period = 0;
> -		state->duty_cycle = 0;
> -	}
> +	state->period = meson_pwm_cnt_to_ns(chip, pwm, channel->lo + channel->hi);
> +	state->duty_cycle = meson_pwm_cnt_to_ns(chip, pwm, channel->hi);
>  
>  	state->polarity = PWM_POLARITY_NORMAL;
>  
> -- 
> 2.40.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Thank you,
Dmitry
