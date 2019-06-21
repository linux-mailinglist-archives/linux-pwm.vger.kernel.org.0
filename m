Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2CB4E842
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2019 14:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfFUMtg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Jun 2019 08:49:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35471 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfFUMtg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Jun 2019 08:49:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so6518995wml.0
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2019 05:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1W2WjOrHyAQxbAms+0lUtVAz8eLCNhjimYeSWnn2kxY=;
        b=g6dZCD+0BKGgFTxVXquMah27DBoxfovfxxX56Mb73a05HlB2qIrrf8g+SEftMtzlhD
         t2ZmeKQkKEqdJoh0k840zL94hKMkX2Cr3jFPzhyXuuPzIuzZI8n2v6V0CKpcvkP3onEG
         ANAjEFLKx38eZ1JlUKG0zzImhRZGY/9GTpMJoEH/sA2yxdJIOMeW8oxUvpI5N4uQG9z6
         QyZAwFS7+whdd+jEHONQAhNRAf2v7RIJGmv718aiN3zc9iGCiJgcdOe4+qpfp5BgUMEI
         lI9onn9PFGeLpa7SJ99NelRtcQQrUG1r2rMHjx38oPYsVjwX/6soInLmMx6HSHceYYpI
         7Jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1W2WjOrHyAQxbAms+0lUtVAz8eLCNhjimYeSWnn2kxY=;
        b=r6Zfm4JI0n3h4DEyPvdd0xC3AJlxtfSzFy6rPfP7X8imzR5t4iZ9IM486V3lU/jIVj
         C/hYQODKtoq4OksjUsnIhnc8zq2UtiIFLvsk4+b+I+XSvEvel13Ts3mv3HJpq7w6CdQg
         ISR+yjAsXjxwot9gydN8QJm8jJeMTadKGlgiJk5KZRbjylBug1cLe31dEe/GWO87dMNn
         8fNl+FvDcsad45sUPCW2KJIS3yPsTxmdcrvnK8NwjIkz/umOZWLvm+BPj9FZ1EzpiiNd
         +D4OQA7YCdve4RfmCtjXBpSNgN+kevkWQ/5RBEQp+HfpgvBMvjgYazvn9UTAhw5tM/e+
         8MEA==
X-Gm-Message-State: APjAAAXA5lH/wFJ/gch2KirP6ZlWPssNh2iw1Q4RND7YM+6LfxNdgYxX
        dBZ6sH0rQzM5ud1fGXJa5tSWkg==
X-Google-Smtp-Source: APXvYqzzAFNVEwfP98oYEgpzs3sVfqEHFy4Wk/kg/CY26BKqOzSTI2d+xIIWa5QU568W7TC2Lndjqg==
X-Received: by 2002:a05:600c:2388:: with SMTP id m8mr3862455wma.23.1561121374405;
        Fri, 21 Jun 2019 05:49:34 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id j32sm5690957wrj.43.2019.06.21.05.49.33
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 05:49:33 -0700 (PDT)
Subject: Re: [PATCH] backlight: pwm_bl: Fix heuristic to determine number of
 brightness levels
To:     Matthias Kaehlcke <mka@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
References: <20190612180003.161966-1-mka@chromium.org>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <bf229b34-2b76-90f7-3e48-102f473b3b52@linaro.org>
Date:   Fri, 21 Jun 2019 13:49:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612180003.161966-1-mka@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/06/2019 19:00, Matthias Kaehlcke wrote:
> With commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of
> LED linearly to human eye") the number of set bits (aka hweight())
> in the PWM period is used in the heuristic to determine the number
> of brightness levels, when the brightness table isn't specified in
> the DT. The number of set bits doesn't provide a reliable clue about
> the length of the period, instead change the heuristic to:
> 
>   nlevels = period / fls(period)
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

As I understand it we can't determine the PWM quantization without 
actually programming it so the table could still be oversized after this 
patch (e.g. multiple entries end up with same physical brightness) but 
since it should always be monotonic and the table size will cap out at a 
sane value then:

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>   drivers/video/backlight/pwm_bl.c | 24 ++++++------------------
>   1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index fb45f866b923..0b7152fa24f7 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -194,29 +194,17 @@ int pwm_backlight_brightness_default(struct device *dev,
>   				     struct platform_pwm_backlight_data *data,
>   				     unsigned int period)
>   {
> -	unsigned int counter = 0;
> -	unsigned int i, n;
> +	unsigned int i;
>   	u64 retval;
>   
>   	/*
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
>   	 */
> -	n = period;
> -	while (n) {
> -		counter += n % 2;
> -		n >>= 1;
> -	}
> +	data->max_brightness =
> +		min((int)DIV_ROUND_UP(period, fls(period)), 4096);
>   
> -	data->max_brightness = DIV_ROUND_UP(period, counter);
>   	data->levels = devm_kcalloc(dev, data->max_brightness,
>   				    sizeof(*data->levels), GFP_KERNEL);
>   	if (!data->levels)
> 

