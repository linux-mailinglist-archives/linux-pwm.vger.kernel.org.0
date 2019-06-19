Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1984B4C7
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jun 2019 11:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbfFSJRO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jun 2019 05:17:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39152 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730996AbfFSJRO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jun 2019 05:17:14 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2284B286272
Subject: Re: [PATCH 3/4] backlight: pwm_bl: Set scale type for CIE 1931 curves
To:     Matthias Kaehlcke <mka@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
References: <20190613194326.180889-1-mka@chromium.org>
 <20190613194326.180889-4-mka@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <3ef89251-146c-c4e4-91c8-19ae855824ac@collabora.com>
Date:   Wed, 19 Jun 2019 11:17:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190613194326.180889-4-mka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Matthias,

On 13/6/19 21:43, Matthias Kaehlcke wrote:
> For backlight curves calculated with the CIE 1931 algorithm set
> the brightness scale type property accordingly. This makes the
> scale type available to userspace via the 'scale' sysfs attribute.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Tested on Samsung Chromebook Plus which uses the CIE 1931 algorithm.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/video/backlight/pwm_bl.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index fb45f866b923..f067fe7aa35d 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -553,6 +553,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  		goto err_alloc;
>  	}
>  
> +	memset(&props, 0, sizeof(struct backlight_properties));
> +
>  	if (data->levels) {
>  		/*
>  		 * For the DT case, only when brightness levels is defined
> @@ -591,6 +593,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  
>  			pb->levels = data->levels;
>  		}
> +
> +		props.scale = BACKLIGHT_SCALE_CIE1931;
>  	} else {
>  		/*
>  		 * That only happens for the non-DT case, where platform data
> @@ -601,7 +605,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  
>  	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
>  
> -	memset(&props, 0, sizeof(struct backlight_properties));
>  	props.type = BACKLIGHT_RAW;
>  	props.max_brightness = data->max_brightness;
>  	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, pb,
> 
