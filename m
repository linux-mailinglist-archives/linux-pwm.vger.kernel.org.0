Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548CC2AFE5A
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 06:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgKLFhR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 00:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729576AbgKLBq1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Nov 2020 20:46:27 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD36C0613D1;
        Wed, 11 Nov 2020 17:45:47 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id g7so3039246pfc.2;
        Wed, 11 Nov 2020 17:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nOQD+47l1Vj9tZi/oOhEDued5DuJRPNMgWRyqUdj0hA=;
        b=RMJgpf9aRvHsm7kXTPn6A4QHZjITSTMgFpSPAsMIDsD9Vq2FGlymCQ2Uy9WLTcLgud
         qcvZWqtPn4jtyWomXgZOZuaGMlO2WRVM66OJ58RyU+8tB4/Z6t+5kyb1la/bFNvIQPNy
         +gfGfVHSsGC88lwyTHYBVOldd5dkmJ8zNnfGN4wdGKkvtA5U/ZgbYHYAtXazC6yUv6G6
         18AKV5PhQRuc9McMOPXFn4enN6RsZ6bzrUeznvRv50DulrL8Df1nad3nFKi4ygo6hi1F
         vr6MAnGzpjH0q2duju6VUxCCWNB57QbzNbWKojxTfKCMb8p803FeYeAomZ9dfOGjw0HX
         nzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nOQD+47l1Vj9tZi/oOhEDued5DuJRPNMgWRyqUdj0hA=;
        b=jYx9+7oQNHxjIczMKy+rlhs69F/hQVvDHWD3hcQLkKyTda97o7M6xeuCDi47Uns4CY
         0RNu+bafh24ndLckrf7ZHqyzQwvGD/UV4Q9b6t+9w8ODtbk+lU1UCEjOjlMD81ZbXz34
         CnoTAcPQE8D72kX+VIzn4SNNEBYI/qLfsEL4iAVJX6ZjN+XSNfixOhcLiNWl7QD6dTrl
         ug6lEEue1pByYaowcQGVBm3It4Z5Y4QIADeFfr6UAxwNxYTDcWxDWblQTUVmKxFPhjHG
         MigEfXb/XyjOrdBI+y9uuB7ckRmIKUFFr1FCF2nv5fihJX7PKp6fu+FMjP1QVOctnb/z
         BEVw==
X-Gm-Message-State: AOAM532kZ7itmJKepXN7HHXIh+SSxMGn8UbmRztJoL4iQO9/Tf2bUcRx
        wtXzAhtqTL1s++PNDEjjQsI=
X-Google-Smtp-Source: ABdhPJw49jebosLeBcZ1ZsqKR3LnVI8Mxnm8v5sWdo+ropNNGLFnXAlwpDz5nWxUdwGFQZE5kJbwXQ==
X-Received: by 2002:a17:90a:fd0d:: with SMTP id cv13mr4600504pjb.124.1605145546448;
        Wed, 11 Nov 2020 17:45:46 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id d11sm3944079pjm.18.2020.11.11.17.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 17:45:45 -0800 (PST)
Date:   Wed, 11 Nov 2020 17:45:42 -0800
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
Subject: Re: [PATCH v3 07/11] input: raspberrypi-ts: Release firmware handle
 when not needed
Message-ID: <20201112014542.GA1003057@dtor-ws>
References: <20201104103938.1286-1-nsaenzjulienne@suse.de>
 <20201104103938.1286-8-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104103938.1286-8-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Nicolas,

On Wed, Nov 04, 2020 at 11:39:33AM +0100, Nicolas Saenz Julienne wrote:
> Use devm_rpi_firmware_get() so as to make sure we release RPi's firmware
> interface when unbinding the device.

Unless I am mistaken this driver does not really need the firmware
structure past rpi_ts_probe(), and will be fine if it disappears earlier
than unbind time.

Thanks.

> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Changes since v2:
>  - Use devm_rpi_firmware_get(), instead of remove function
> 
>  drivers/input/touchscreen/raspberrypi-ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
> index ef6aaed217cf..efed0efa91d9 100644
> --- a/drivers/input/touchscreen/raspberrypi-ts.c
> +++ b/drivers/input/touchscreen/raspberrypi-ts.c
> @@ -134,7 +134,7 @@ static int rpi_ts_probe(struct platform_device *pdev)
>  		return -ENOENT;
>  	}
>  
> -	fw = rpi_firmware_get(fw_node);
> +	fw = devm_rpi_firmware_get(&pdev->dev, fw_node);
>  	of_node_put(fw_node);
>  	if (!fw)
>  		return -EPROBE_DEFER;
> -- 
> 2.29.1
> 

-- 
Dmitry
