Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF15E4E859
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Jun 2019 14:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFUMz4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Jun 2019 08:55:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33953 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfFUMzy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 21 Jun 2019 08:55:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so9101360wmd.1
        for <linux-pwm@vger.kernel.org>; Fri, 21 Jun 2019 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M5roWua+sE0QDauEpfxqdxQ5SjcRxbCv1Yw8mVidcLA=;
        b=aywzB083QiInYx90tUDlA2Hh05BuCQgZDjn3VehTjpIgCX6kvyryZZZgNltfKT70sB
         F3qwGoFmp+QHwoMASFBpXOXmDA1u8gDTK8lhy4rcKYOkH7C3zw31pA4Ry0alSD12QyUw
         sWCXF3q9POBLF4MF+qFQ7/lvznPucP59jYYrGzeHgpdAlrGWmBxYIA6VyiIu5uYy19OG
         cqp9xLMBxKSPdhdf1Rs3tLUMePHQS2EbUa5SEHdfEbu/x8gfulc3C2LuFmzcw/qoZx2A
         Cs10u5TDbwS8zfZG6G2laGy/B7THSa1636OwpHdLnAel6mH+6kdo1gA6nnE3ZMK0ftSS
         KTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M5roWua+sE0QDauEpfxqdxQ5SjcRxbCv1Yw8mVidcLA=;
        b=nzKQV/YwMZmpQt4MRFt0+GePrKZFRqnOHP7qYFW2CQWGCPZNjRyHuCeuS+iM+KiFln
         mrPrYgQTjB+nJ2oSvdTEpVVNFTNeGaslgKriYaR+Yp5J1s6sX00g+gyy1l9CFq2qHtnL
         RDTPU1nLoNQZm0kKZ2VhEmc+DFiELV9zfpONLkdEmFgwNcnUYtddOcdkxagTHA0272I6
         iqLDEm2wVPHBzCYD4wi97mJ5+6tfVp6FDt/+xVDkauY1BjUp/v5aHFaM5PcfpThZuN/F
         mV9HYjb8Tp5jpnRAUcYopjZ/nzjj6z1JczW6/DIDmYPVIvCej7DnowW3AAsCXDGiw0zT
         i2gg==
X-Gm-Message-State: APjAAAWoZyyDOhk8e0VXzdudlcIaBWeAHxgwDo2/7aGwE1Zp9+OVBYPR
        bWZvsfZC/HV83UclEx4/Z+Ik5w==
X-Google-Smtp-Source: APXvYqxZcpKELGpSFn7MYSlxt7hDPB3jHlFtAG02JXWV4XcyKO8TczsGU/6Wz4PKdda3LT09prXOdg==
X-Received: by 2002:a1c:b6d4:: with SMTP id g203mr4059348wmf.19.1561121751770;
        Fri, 21 Jun 2019 05:55:51 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.googlemail.com with ESMTPSA id l12sm1761640wmj.22.2019.06.21.05.55.50
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2019 05:55:51 -0700 (PDT)
Subject: Re: [PATCH 3/4] backlight: pwm_bl: Set scale type for CIE 1931 curves
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
 <20190613194326.180889-4-mka@chromium.org>
From:   Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <61ed137c-31bb-c695-4174-0484fe667d6c@linaro.org>
Date:   Fri, 21 Jun 2019 13:55:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613194326.180889-4-mka@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 13/06/2019 20:43, Matthias Kaehlcke wrote:
> For backlight curves calculated with the CIE 1931 algorithm set
> the brightness scale type property accordingly. This makes the
> scale type available to userspace via the 'scale' sysfs attribute.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

I'd like to keep discussion on patch 2 open a bit longer (it's not part 
of the thread below patch 2 but Pavel had concerns about the sysfs 
interface) so this ack won't really push things forward but FWIW:

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>   drivers/video/backlight/pwm_bl.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index fb45f866b923..f067fe7aa35d 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -553,6 +553,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   		goto err_alloc;
>   	}
>   
> +	memset(&props, 0, sizeof(struct backlight_properties));
> +
>   	if (data->levels) {
>   		/*
>   		 * For the DT case, only when brightness levels is defined
> @@ -591,6 +593,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   
>   			pb->levels = data->levels;
>   		}
> +
> +		props.scale = BACKLIGHT_SCALE_CIE1931;
>   	} else {
>   		/*
>   		 * That only happens for the non-DT case, where platform data
> @@ -601,7 +605,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>   
>   	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
>   
> -	memset(&props, 0, sizeof(struct backlight_properties));
>   	props.type = BACKLIGHT_RAW;
>   	props.max_brightness = data->max_brightness;
>   	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, pb,
> 

