Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B85F34E89C
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2019 15:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbfFUNKX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Jun 2019 09:10:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37254 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfFUNKX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Jun 2019 09:10:23 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so6564158wme.2
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2019 06:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zWWuR+34CKSqeHNm3DAPIfBogtgjv1yPdEZeTsKzETc=;
        b=sYlMGLg6ofrBMB6etYJLvDsNE5GKSrdcKhDZuMxtsWNYhzpHM6Uy+v9WkmTMKC9TuH
         1BgOvayYHCsQ3pSt95VOMUAD69bfUn5Hf0vJ44o+ofRUSzCZPeO+QfbDh5fPsROQ3HBo
         y5iBhArohMB4DGOLR+RH8I1mXpsm2L+hfGSQ+k1wx/vLYpq4o3U7snuZuSkGlinhlmDl
         z4cb29V1wDixND0F3ai2WMCO5MGx0E09t400/uCxSYi+U1rmXTdett8MgyCzGRNIwzkc
         mQuXyWXkFWeIpz3epAvNkd/D3gGUreOjHWwFCpIfilLjZ8TykTObi5CN5gmQIiUa8fw0
         YuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zWWuR+34CKSqeHNm3DAPIfBogtgjv1yPdEZeTsKzETc=;
        b=NH47rMn8pe2OxddgZiRWEsK8ECGY5DpSefqm+1x2Kdvsd7L9vJKP9AR3l569URG8e5
         K7/G2TgRpUMRWrZoHQ4JiuSWUNJ4/7SYagftJSuZPxmB+ewqPL5VXsB8iiYQ3WeFHOml
         xXJEC15xqFJo65sXgjgyR+6LmdZa0W6esgr7/zx+Si38ZmBcchTdDp0iGOHAKNh/dvA1
         Zg/Aktpg5OKc+bi/WjJEKl7nKMiujFSTPehviLoOCnhOxN08EM1ioPDNq69Cj/wUOfXA
         CFfnFg2QORlD9NEvjfFg+GChl+YM4jp2HCmi0i1u6kbEa4AOME1Pk5vGnNNuLFbrfHFT
         OhZA==
X-Gm-Message-State: APjAAAXseDUES/AEaxjV3JkWoUFasnpAfpQs1WneDJzVJi0/AOrWaa6X
        8Mpaf0OsCRjtPGWsz89vhkRv+A==
X-Google-Smtp-Source: APXvYqxugcFhasT6oqykCSfSXIx0XEa8A82CS0oO38cZlbubwFnhNoEfk4Ul2IhYgZbeXiAhzedHNg==
X-Received: by 2002:a1c:e0c4:: with SMTP id x187mr3959660wmg.177.1561122621229;
        Fri, 21 Jun 2019 06:10:21 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id 5sm4910909wrc.76.2019.06.21.06.10.19
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 06:10:20 -0700 (PDT)
Subject: Re: [PATCH 4/4] backlight: pwm_bl: Set scale type for brightness
 curves specified in the DT
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
References: <20190613194326.180889-1-mka@chromium.org>
 <20190613194326.180889-5-mka@chromium.org>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <9ea1bb40-95a6-7a67-a8a6-ecc77a70e547@linaro.org>
Date:   Fri, 21 Jun 2019 14:10:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613194326.180889-5-mka@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 13/06/2019 20:43, Matthias Kaehlcke wrote:
> Check if a brightness curve specified in the device tree is linear or
> not and set the corresponding property accordingly. This makes the
> scale type available to userspace via the 'scale' sysfs attribute.
> 
> To determine if a curve is linear it is compared to a interpolated linear
> curve between min and max brightness. The curve is considered linear if
> no value deviates more than +/-5% of ${brightness_range} from their
> interpolated value.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>   drivers/video/backlight/pwm_bl.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index f067fe7aa35d..912407b6d67f 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -404,6 +404,26 @@ int pwm_backlight_brightness_default(struct device *dev,
>   }
>   #endif
>   
> +static bool pwm_backlight_is_linear(struct platform_pwm_backlight_data *data)
> +{
> +	unsigned int nlevels = data->max_brightness + 1;
> +	unsigned int min_val = data->levels[0];
> +	unsigned int max_val = data->levels[nlevels - 1];
> +	unsigned int slope = (100 * (max_val - min_val)) / nlevels;

Why 100 (rather than a power of 2)?

It would also be good to have a comment here saying what the maximum 
quantization error is. Doesn't have to be over complex just mentioning 
something like the following (assuming you agree that its true ;-) ):

   Multiplying by XXX means that even in pathalogical cases such as
   (max_val - min_val) == nlevels then the error at max_val is less than
   1%.

With a suitable comment in the fixed point code:
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.


> +	unsigned int margin = (max_val - min_val) / 20; /* 5% */
> +	int i;
> +
> +	for (i = 1; i < nlevels; i++) {
> +		unsigned int linear_value = min_val + ((i * slope) / 100);
> +		unsigned int delta = abs(linear_value - data->levels[i]);
> +
> +		if (delta > margin)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>   static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
>   {
>   	struct device_node *node = pb->dev->of_node;
> @@ -567,6 +587,11 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   
>   			pb->levels = data->levels;
>   		}
> +
> +		if (pwm_backlight_is_linear(data))
> +			props.scale = BACKLIGHT_SCALE_LINEAR;
> +		else
> +			props.scale = BACKLIGHT_SCALE_NON_LINEAR;
>   	} else if (!data->max_brightness) {
>   		/*
>   		 * If no brightness levels are provided and max_brightness is
> 

