Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E0443E53
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2019 17:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbfFMPsw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Jun 2019 11:48:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52428 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731710AbfFMJPD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Jun 2019 05:15:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 73D26260CB2
Subject: Re: [PATCH] backlight: pwm_bl: Fix heuristic to determine number of
 brightness levels
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
References: <20190612180003.161966-1-mka@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <fd554750-7ec6-73e1-be3a-5bac0749fa0b@collabora.com>
Date:   Thu, 13 Jun 2019 11:14:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612180003.161966-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Matthias,

On 12/6/19 20:00, Matthias Kaehlcke wrote:
> With commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of
> LED linearly to human eye") the number of set bits (aka hweight())
> in the PWM period is used in the heuristic to determine the number
> of brightness levels, when the brightness table isn't specified in
> the DT. The number of set bits doesn't provide a reliable clue about
> the length of the period, instead change the heuristic to:
> 
>  nlevels = period / fls(period)
> 
> Also limit the maximum number of brightness levels to 4096 to avoid
> excessively large tables.
> 
> With this the number of levels increases monotonically with the PWM
> period, until the maximum of 4096 levels is reached:
> 
> period (ns)    # levels
> 
> 100    	       16
> 500	       62
> 1000	       111
> 5000	       416
> 10000	       769
> 50000	       3333
> 100000	       4096
> 
> Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Tested on Samsung Chromebook Plus (16-bit pwm)

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>


> ---
>  drivers/video/backlight/pwm_bl.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index fb45f866b923..0b7152fa24f7 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -194,29 +194,17 @@ int pwm_backlight_brightness_default(struct device *dev,
>  				     struct platform_pwm_backlight_data *data,
>  				     unsigned int period)
>  {
> -	unsigned int counter = 0;
> -	unsigned int i, n;
> +	unsigned int i;
>  	u64 retval;
>  
>  	/*
> -	 * Count the number of bits needed to represent the period number. The
> -	 * number of bits is used to calculate the number of levels used for the
> -	 * brightness-levels table, the purpose of this calculation is have a
> -	 * pre-computed table with enough levels to get linear brightness
> -	 * perception. The period is divided by the number of bits so for a
> -	 * 8-bit PWM we have 255 / 8 = 32 brightness levels or for a 16-bit PWM
> -	 * we have 65535 / 16 = 4096 brightness levels.
> -	 *
> -	 * Note that this method is based on empirical testing on different
> -	 * devices with PWM of 8 and 16 bits of resolution.
> +	 * Once we have 4096 levels there's little point going much higher...
> +	 * neither interactive sliders nor animation benefits from having
> +	 * more values in the table.
>  	 */
> -	n = period;
> -	while (n) {
> -		counter += n % 2;
> -		n >>= 1;
> -	}
> +	data->max_brightness =
> +		min((int)DIV_ROUND_UP(period, fls(period)), 4096);
>  
> -	data->max_brightness = DIV_ROUND_UP(period, counter);
>  	data->levels = devm_kcalloc(dev, data->max_brightness,
>  				    sizeof(*data->levels), GFP_KERNEL);
>  	if (!data->levels)
> 
