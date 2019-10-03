Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB196C9B8C
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Oct 2019 12:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfJCKCN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Oct 2019 06:02:13 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37920 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727849AbfJCKCL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Oct 2019 06:02:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id w12so2276518wro.5
        for <linux-pwm@vger.kernel.org>; Thu, 03 Oct 2019 03:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xbihRq/Slo3PYnJ3Dz7r1d50po3jOI3cDT0TFE0FHsY=;
        b=P3u6I6k9FG6wGcenAZdZUkqFpKCkLJ5BrfZdAQNV1t/3dHsDMQyM8r2XrM+wD6sgYK
         faa6vzUIukLSr1lEXgXbE6ovU+sLWZMq/C9uGiEL7uvb3ULew1rOoYLgvUAnVfHfKPT0
         gT4fThu51hUT4jGN5Fe+CQEcOpAjpUZR2rlU0a7BJF0h1tw36yytfE5SRyas8yy+/GnG
         bxsQv8nqpVvV5l+aZP2TqENOWdnwyQ+cqyGq2zqOYW06tb/Mmr1CQdtbmiX4wBh+r9Ly
         7RIIXb6ZOyk4xtXIDKP0HzMq5J8FgsMFMVlDhVd2zWfFlrO2jea9qrD9uiPxUbk3lS0w
         KNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xbihRq/Slo3PYnJ3Dz7r1d50po3jOI3cDT0TFE0FHsY=;
        b=N8YpfpQUC2WuWRSi0o9f24V34jMJ+RSpO4vWOlErT0wrQw8/mUA9fPpXC5f6dfG5eX
         KQxPLiQT0AbXbhZ6g9mzEm9t4a3y/0nko9TbAXbo2LuUZ7iWwuzOZCF4F03y0AHMLqGP
         3JwZpRwKtbkFAYc11udqpQMQEcYv7+KU6fQPhlXSIzlkbjRFZFUA0PYCui4bNRhFcfsi
         8DpQuHYPPWsOjCRwbEUHOIIPnkg6C2NzAVDZnXN+1bzOS05/mCbtjPilHpeZpu/SlodM
         GcQ7KE1shBhhj/vqIMSrsmsTgp46CK8rgqteE7VnMrRACt52cb37knyBPoUu6FRk79Vu
         BpUA==
X-Gm-Message-State: APjAAAXJBtgeZhhxRvalRDFJ4zxudCPeTRaXYMLeZFsE0EqBk3ykgOBY
        wuxxw1iPxvGrRlE8HclxjxIhdw==
X-Google-Smtp-Source: APXvYqzXFwNjg21UC+vD/IXHxOJFRXUta5uNXiTTkdPFWBNH8Vus6TTdVG1q7oc8ZNLY0TQzsVeKTw==
X-Received: by 2002:adf:e60d:: with SMTP id p13mr5980140wrm.298.1570096929136;
        Thu, 03 Oct 2019 03:02:09 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v6sm1894952wrn.50.2019.10.03.03.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 03:02:08 -0700 (PDT)
Date:   Thu, 3 Oct 2019 11:02:06 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] backlight: pwm_bl: Don't assign levels table
 repeatedly
Message-ID: <20191003100206.ws35dbgifjwjicuv@holly.lan>
References: <20191002095541.v2.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002095541.v2.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
User-Agent: NeoMutt/20180716
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Oct 02, 2019 at 09:56:01AM -0700, Matthias Kaehlcke wrote:
> pwm_backlight_probe() re-assigns pb->levels for every brightness
> level. This is not needed and was likely not intended, since
> neither side of the assignment changes during the loop. Assign
> the field only once.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
> 
> Changes in v2:
> - removed curly braces from for loop
> 
>  drivers/video/backlight/pwm_bl.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
> index 746eebc411df..05d3b3802658 100644
> --- a/drivers/video/backlight/pwm_bl.c
> +++ b/drivers/video/backlight/pwm_bl.c
> @@ -564,18 +564,17 @@ static int pwm_backlight_probe(struct platform_device *pdev)
>  	memset(&props, 0, sizeof(struct backlight_properties));
>  
>  	if (data->levels) {
> +		pb->levels = data->levels;
> +
>  		/*
>  		 * For the DT case, only when brightness levels is defined
>  		 * data->levels is filled. For the non-DT case, data->levels
>  		 * can come from platform data, however is not usual.
>  		 */
> -		for (i = 0; i <= data->max_brightness; i++) {
> +		for (i = 0; i <= data->max_brightness; i++)
>  			if (data->levels[i] > pb->scale)
>  				pb->scale = data->levels[i];
>  
> -			pb->levels = data->levels;
> -		}
> -
>  		if (pwm_backlight_is_linear(data))
>  			props.scale = BACKLIGHT_SCALE_LINEAR;
>  		else
> -- 
> 2.23.0.444.g18eeb5a265-goog
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
