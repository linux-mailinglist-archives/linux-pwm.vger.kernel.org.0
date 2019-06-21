Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 034834E82F
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2019 14:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfFUMlt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Jun 2019 08:41:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41198 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfFUMlt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Jun 2019 08:41:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id c2so6434059wrm.8
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2019 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UyII8E/E3mshPHrIMsqTxjJtV2uC2oH9mjOQblUJ9/o=;
        b=JrgRZGiBTmjujp1DAceFMwZAzGMDtr8E0Ek2p5PEfVsS473YGQb4eZz/hSfRCUa4PT
         PCL/0VmmsvC3bwMDGBcwLtoEV3CsVenV3I9cy9JAgXOfRedFJHPzAJH14pTHhhmRhJuH
         zSIgviNgNjnQ3q+QyY+x7yM/+irnqrLXG54A9xvJR793m0llXVeuC9hc/QtscAlcp2uC
         qjQ2GkqaHziMVeJ3Ci94+48IV1FaLhgc0tWBdIIHeAoHYeSifPU45Fuu/dX1MKphi8Jp
         jHCcbZrHc4m9hYCz01MRC6bnnKjkjoypabgBcEunqnOnVoFRUlq3mS6ZA+911H28wTVE
         WBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UyII8E/E3mshPHrIMsqTxjJtV2uC2oH9mjOQblUJ9/o=;
        b=AisoPZx7GYjt0RnutDR7VWTPqrOuc3NrcQvXmREz4oTRM/dCIHsjA+fGjaKo1w/u1A
         p72e8ceQfZe82NZXTWzVeaK4AZhcwqBvpuIX4w9LDDkpEQ9kulKciK98jZSx57hjtx+x
         a7cXxaffbEhZgGhe4XRulz8OYsTiwY0Rhn5GJWD6eU2mm79VF6l/+NikBC3fY3A6Ai5e
         LXQUe1AoXmk/+dU5Q2wmkFDgM7jzJAqTKSqtVVgdWbi1tZxen1Kp02HrQfxoF055Wwwx
         pTqynw0IjRq0tLn7V/TzTzzGEjYHc9FGv9ddXFPx/E37BL8W/fFwV+IelhQX2UVx2YwR
         3SEg==
X-Gm-Message-State: APjAAAXfbMGs1JU6VMn9oYXu6lBPqfsvtvDytD64dpol+Yvdtj7g2ELt
        LRresr8wQvCsqepHN4hW4LYzxw==
X-Google-Smtp-Source: APXvYqx7sEWjAoCocqkTEAccH5DTaTuYTnicvzBiGr/LTPl3+FpUS7jIbDEbXYD+xr2QoDp98s9PmQ==
X-Received: by 2002:a5d:4708:: with SMTP id y8mr1982160wrq.85.1561120907035;
        Fri, 21 Jun 2019 05:41:47 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id o20sm6964907wrh.8.2019.06.21.05.41.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 05:41:46 -0700 (PDT)
Subject: Re: [PATCH] backlight: pwm_bl: Set pin to sleep state when powered
 down
To:     Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190522163428.7078-1-paul@crapouillou.net>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <5b0f8bb3-e7b0-52c1-1f2f-9709992b76fc@linaro.org>
Date:   Fri, 21 Jun 2019 13:41:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190522163428.7078-1-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 22/05/2019 17:34, Paul Cercueil wrote:
> When the driver probes, the PWM pin is automatically configured to its
> default state, which should be the "pwm" function.

At which point in the probe... and by who?

> However, at this
> point we don't know the actual level of the pin, which may be active or
> inactive. As a result, if the driver probes without enabling the
> backlight, the PWM pin might be active, and the backlight would be
> lit way before being officially enabled.
> 
> To work around this, if the probe function doesn't enable the backlight,
> the pin is set to its sleep state instead of the default one, until the
> backlight is enabled. Whenk the backlight is disabled, the pin is reset
> to its sleep state.
Doesn't this workaround result in a backlight flash between whatever 
enables it and the new code turning it off again?

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net> > ---
>   drivers/video/backlight/pwm_bl.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index fb45f866b923..422f7903b382 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -16,6 +16,7 @@
>   #include <linux/module.h>
>   #include <linux/kernel.h>
>   #include <linux/init.h>
> +#include <linux/pinctrl/consumer.h>
>   #include <linux/platform_device.h>
>   #include <linux/fb.h>
>   #include <linux/backlight.h>
> @@ -50,6 +51,8 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
>   	struct pwm_state state;
>   	int err;
>   
> +	pinctrl_pm_select_default_state(pb->dev);
> +
>   	pwm_get_state(pb->pwm, &state);
>   	if (pb->enabled)
>   		return;
> @@ -90,6 +93,8 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
>   
>   	regulator_disable(pb->power_supply);
>   	pb->enabled = false;
> +
> +	pinctrl_pm_select_sleep_state(pb->dev);
>   }
>   
>   static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
> @@ -626,6 +631,10 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   	backlight_update_status(bl);
>   
>   	platform_set_drvdata(pdev, bl);
> +
> +	if (bl->props.power == FB_BLANK_POWERDOWN)
> +		pinctrl_pm_select_sleep_state(&pdev->dev);

Didn't backlight_update_status(bl) already do this?


Daniel.


> +
>   	return 0;
>   
>   err_alloc:
> 

