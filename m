Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467786FFBB0
	for <lists+linux-pwm@lfdr.de>; Thu, 11 May 2023 23:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239310AbjEKVIH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 11 May 2023 17:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239308AbjEKVIF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 11 May 2023 17:08:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5321D8A6D
        for <linux-pwm@vger.kernel.org>; Thu, 11 May 2023 14:08:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64384c6797eso7406020b3a.2
        for <linux-pwm@vger.kernel.org>; Thu, 11 May 2023 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683839283; x=1686431283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X2DjvEwzCEEnywtsV4bRPruC6T+leR5KJTbFUvFCUwM=;
        b=VjhYw4+yf83no8SnggFo9y3QOUUD11ApawgaEWjSoIwpvwSOiJjbyPHq2qa83RhgJ1
         g/IYE4xLkS5++Ye9Vhj+kJxt+HEFVgPhdERzce4cOe9gaRyG79MdhMN4ylPEZcrgFOE6
         taoXxbiMPvnTAzu+YxxoTN8PTUNW/lQa69uvE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683839283; x=1686431283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X2DjvEwzCEEnywtsV4bRPruC6T+leR5KJTbFUvFCUwM=;
        b=QfmflV4hVaIazajRoYX22dqTtjvN7bq1IRR0rOYCJFVTFn0QV8P/0Ig9IlAYh7Xl3+
         itljoTKKpwfxq/oHl6J2noerc+oBdssekhpalfuKcRTEjyYDhqnGppe6s+sHh9NZixV1
         1OybiL7hxAES7mO1iLcIAC/X7rVoY2rtfXAdFUgsDOe8yYfVJbflneFQSF4+ke81z6+1
         xB6l8BFs52D42No+tcZi38wAkolt9dDCj6QusTXJaHu57YibW3DcDy2docyeakfW+Ksv
         l+q07hBR6gmZtBgMNY2B7ZEjDVzQPyUQCobrhJf0XvH8D6hlXdEZEHy5qjnmBQuoEF1v
         wQOw==
X-Gm-Message-State: AC+VfDzjYfsN8rkM4uffSVWDntnKiaihlAOL5HKaEx/p7UzPUt3u3r9g
        s2K2SOdfNwDF0nwLjApkBDqd+A==
X-Google-Smtp-Source: ACHHUZ6xdEYUz5zwu0V0AcbG5lYh6nYjw/ovGKKjNlhrb2lHVfovyF8rUg8Eo1awaymEUt4fzxNm0g==
X-Received: by 2002:a17:903:185:b0:1a9:6bd4:236a with SMTP id z5-20020a170903018500b001a96bd4236amr28538269plg.69.1683839282820;
        Thu, 11 May 2023 14:08:02 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5c55:153c:a26f:d30f])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902e88300b001aaffe15f39sm6383918plg.30.2023.05.11.14.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 14:08:02 -0700 (PDT)
Date:   Thu, 11 May 2023 14:08:00 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Marek Vasut <marex@denx.de>
Cc:     linux-pwm@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH] pwm: core: Permit unset period when applying
 configuration of disabled PWMs
Message-ID: <ZF1ZMNBMxLqNI0zh@google.com>
References: <20230511181853.185685-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511181853.185685-1-marex@denx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Thu, May 11, 2023 at 08:18:53PM +0200, Marek Vasut wrote:
> In case the PWM is not enabled, the period can still be left unconfigured,
> i.e. zero . Currently the pwm_class_apply_state() errors out in such a case.
> This e.g. makes suspend fail on systems where pwmchip has been exported via
> sysfs interface, but left unconfigured before suspend occurred.
> 
> Failing case:
> "
> $ echo 1 > /sys/class/pwm/pwmchip4/export
> $ echo mem > /sys/power/state
> ...
> pwm pwmchip4: PM: dpm_run_callback(): pwm_class_suspend+0x1/0xa8 returns -22
> pwm pwmchip4: PM: failed to suspend: error -22
> PM: Some devices failed to suspend, or early wake event detected
> "
> 
> Working case:
> "
> $ echo 1 > /sys/class/pwm/pwmchip4/export
> $ echo 100 > /sys/class/pwm/pwmchip4/pwm1/period
> $ echo 10 > /sys/class/pwm/pwmchip4/pwm1/duty_cycle
> $ echo mem > /sys/power/state
> ...
> "
> 
> Permit unset period in pwm_class_apply_state() in case the PWM is disabled
> to fix this issue.
> 
> Fixes: ef2bf4997f7d ("pwm: Improve args checking in pwm_apply_state()")
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-pwm@vger.kernel.org
> ---
>  drivers/pwm/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index 3dacceaef4a9b..87252b70f1c81 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -510,8 +510,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
>  	 */
>  	might_sleep();
>  
> -	if (!pwm || !state || !state->period ||
> -	    state->duty_cycle > state->period)
> +	if (!pwm || !state || (state->enabled &&
> +	    (!state->period || state->duty_cycle > state->period)))
>  		return -EINVAL;
>  
>  	chip = pwm->chip;

By making the period assertions conditional, you're allowing people to
write garbage period values via sysfs. However you fix the (legitimate)
bug you point out, you shouldn't regress that. (Now, that's sounding
like we could use some unit tests for the PWM framework...)

You could, for example, also add the bounds checks to
drviers/pwm/sysfs.c's period_store().

Or perhaps you could teach the suspend/resume functions to not bother
calling pwm_apply_state() on a disabled PWM.

Brian
