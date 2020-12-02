Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29EBC2CB4CE
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Dec 2020 07:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgLBGEi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Dec 2020 01:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLBGEh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Dec 2020 01:04:37 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937CCC0613CF;
        Tue,  1 Dec 2020 22:03:51 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id r20so407280pjp.1;
        Tue, 01 Dec 2020 22:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sdg6m13JCDegZRe+NmQ9epCCrqdVuQ58ZPfdb2g7nwk=;
        b=pCJA7Ta3XJljluS9z7yOcbr2jUsDThZD9M6lRMzlsYVGvFOkg0wP3wWBlshqdNcCUj
         5uZvn95iyp309exveaPBLaEodgH692I7dBiok0BwlFyBzxW+KxVBKBsaJ3YAqmT67zP+
         vT7IV6YGmGZXgrQL1P+KbMMk6BkHeNmyXgmsLs8wEBYPoHSWIIV0zS+oIMq3EZ18VhHl
         v/jVjHYd64fR99K99JDgwRDqJ8llL6f+7U5Vea88QnSVhKT9CDR5uMs8nAOZPE5v31wN
         8E6sSyJ5FNYSKCxnTg66FyMyGZaitBT0IHC39PlWgV35Rae1pxdg2a75c0p5lOK7kqV3
         FibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sdg6m13JCDegZRe+NmQ9epCCrqdVuQ58ZPfdb2g7nwk=;
        b=fM4ZfHjlYLSJvqgn+MI/+HFIt0ZTkuSvt7EE28og0HyZ4fOyXRROAQoE6JvcT9ksrb
         sjg8AqbLUWmxLR5Gom1XpDyjEwe3EpZ9Adh1SS7dqlkV4Ula/bPCCLENMEAlLZUwoWEu
         dL7KGguMY9aNBs20FR+upv0OG66xch8IrIIX7oawJ7NS2VgchFu602XD/5Bpv1bv6iqw
         Rsg3bW9dhhMm7vkSRVhOSyoItyrsw3jhKILAMNxbXZg7Sd2tvTbLlwuqQctEM55jrVBB
         jf16YFy7Aljif0/EvMCjVyp9X79WSw/4VNFdrgFpAAqvjH/0pz8hG+FVgMFcAKMa5GDz
         TT9A==
X-Gm-Message-State: AOAM531lHwWxtXeTMx30wykALfrm6zeyH+hBA7jjNerH7ekpk41Ec4/C
        HtSnc7MsbnwVbA9PwKQZfzs=
X-Google-Smtp-Source: ABdhPJzZ+izHWO3gM6iPbafcGZ1JHYrclBHjBVqhKWL05Il/SE7A6c1xDfh20W3Ydj+C/+H6a3Wb5g==
X-Received: by 2002:a17:902:bf0b:b029:d8:f677:30f2 with SMTP id bi11-20020a170902bf0bb02900d8f67730f2mr1209361plb.25.1606889030866;
        Tue, 01 Dec 2020 22:03:50 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id x16sm600470pjh.39.2020.12.01.22.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 22:03:50 -0800 (PST)
Date:   Tue, 1 Dec 2020 22:03:47 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, linux-rpi-kernel@lists.infradead.org,
        bgolaszewski@baylibre.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH v5 08/11] input: raspberrypi-ts: Release firmware handle
 when not needed
Message-ID: <20201202060347.GA2034289@dtor-ws>
References: <20201123183833.18750-1-nsaenzjulienne@suse.de>
 <20201123183833.18750-9-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123183833.18750-9-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Nicolas,

On Mon, Nov 23, 2020 at 07:38:29PM +0100, Nicolas Saenz Julienne wrote:
> Use devm_rpi_firmware_get() so as to make sure we release RPi's firmware
> interface when unbinding the device.

I do not believe this comment is correct any longer. Otherwise:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Changes since v3:
>  - Release firmware handle in probe function
> 
> Changes since v2:
>  - Use devm_rpi_firmware_get(), instead of remove function
> 
>  drivers/input/touchscreen/raspberrypi-ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
> index ef6aaed217cf..5000f5fd9ec3 100644
> --- a/drivers/input/touchscreen/raspberrypi-ts.c
> +++ b/drivers/input/touchscreen/raspberrypi-ts.c
> @@ -160,7 +160,7 @@ static int rpi_ts_probe(struct platform_device *pdev)
>  	touchbuf = (u32)ts->fw_regs_phys;
>  	error = rpi_firmware_property(fw, RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF,
>  				      &touchbuf, sizeof(touchbuf));
> -
> +	rpi_firmware_put(fw);
>  	if (error || touchbuf != 0) {
>  		dev_warn(dev, "Failed to set touchbuf, %d\n", error);
>  		return error;
> -- 
> 2.29.2
> 

-- 
Dmitry
