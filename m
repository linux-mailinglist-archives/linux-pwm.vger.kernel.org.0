Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172D52237C6
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jul 2020 11:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgGQJHB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 05:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQJHA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 05:07:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE434C08C5C0
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 02:07:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so13890887wmi.3
        for <linux-pwm@vger.kernel.org>; Fri, 17 Jul 2020 02:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pTJD2ese6K2dNt2vdiLR06YU7WVcQu8Yel1U2q7XjxE=;
        b=RdncPW1lDg4IpKF2/cfz2mxyZGwH70KBaBrCHlAamsL4R/bAvK/rxM+IWlU7qIyuan
         xelunPXzbnc4+mXnnIHQzV2Q7I4VLS07NC6FMJctbAWgk/gPiV3DFh6FOAWO6wBP5n1W
         CBPMe9ut3SIiMskcvMWaFgVY0Jsx32ZIvN1gBt6+fVgyK2uL7mCW7+CtaniJn3xckqrX
         mZAknbz3eKXhxSkDrzdJeP5pO6L3DJIPsYa+LtmXApSGgwyAFdQBLpMPomp9c+Dd75j7
         IEfa26GW1uAFTPFBNzcDH2QJE9d4E3UfGS95nHTVqMXYwEUwvQfxFD06YcbXHpuTrTKP
         zUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pTJD2ese6K2dNt2vdiLR06YU7WVcQu8Yel1U2q7XjxE=;
        b=HBMe5RTHIcCd9T0oeISQ9y+MIYz1gVZdTNK98gJJOxfS59ZEagqicx80d840XKCNlI
         l5RQET8Q7BOKhmUUPrca/geyHUGqsR1DHJdkbHHUEn4fGL1IJIAfWSpkOr3udLJT4Ljy
         o3dqTgkGW0O687zvkAWTGvxImfm+D3GyTPPG68wZCewye2J7F75NwNNAvwRENeL09VCv
         qK0/YMmE56+0AHblNP4+7F1uryeh+sGmUZeZRZ3U2MGdrxxAmV5EVn+w5S0QQIjC1hqV
         l2t4eWBkIVujEFQie/30ok2KA/s6k8ZTa1toGRRKIa1bZt7t3kk5Vlo/iUO36HifIamk
         XRIA==
X-Gm-Message-State: AOAM5327zybCHYGHgmgGW3AfDOjDsn7onfVxJ2o3s0P47/1TYGugfBjc
        d3MYJWGwZ5zpx3Tn08gKAJVVIQ==
X-Google-Smtp-Source: ABdhPJzFwUFlTuHxJh9CJGSq2MTaZ8h+vLXDbC5cvbKZoxFQ53eDgLDHJN2B9P6MWQGOIdMYC9QPUQ==
X-Received: by 2002:a1c:5982:: with SMTP id n124mr8364770wmb.77.1594976819379;
        Fri, 17 Jul 2020 02:06:59 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id a123sm12657865wmd.28.2020.07.17.02.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 02:06:58 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:06:56 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v5 02/13] mfd: add simple regmap based I2C driver
Message-ID: <20200717090656.GF3165313@dell>
References: <20200706175353.16404-1-michael@walle.cc>
 <20200706175353.16404-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200706175353.16404-3-michael@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 06 Jul 2020, Michael Walle wrote:

> There are I2C devices which contain several different functions but
> doesn't require any special access functions. For these kind of drivers
> an I2C regmap should be enough.
> 
> Create an I2C driver which creates an I2C regmap and enumerates its
> children. If a device wants to use this as its MFD core driver, it has
> to add an individual compatible string. It may provide its own regmap
> configuration.
> 
> Subdevices can use dev_get_regmap() on the parent to get their regmap
> instance.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v4:
>  - new patch. Lee, please bear with me. I didn't want to delay the
>    new version (where a lot of remarks on the other patches were
>    addressed) even more, just because we haven't figured out how
>    to deal with the MFD part. So for now, I've included this one.
> 
>  drivers/mfd/Kconfig          |  9 +++++++
>  drivers/mfd/Makefile         |  1 +
>  drivers/mfd/simple-mfd-i2c.c | 50 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 60 insertions(+)
>  create mode 100644 drivers/mfd/simple-mfd-i2c.c
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 33df0837ab41..f1536a710aca 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1162,6 +1162,15 @@ config MFD_SI476X_CORE
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called si476x-core.
>  
> +config MFD_SIMPLE_MFD_I2C
> +	tristate "Simple regmap based I2C devices"

Doesn't look like tristate to me.

Haven't you made this builtin only?

> +	depends on I2C
> +	select MFD_CORE

Why?

> +	select REGMAP_I2C
> +	help
> +	  This is a consolidated driver for all MFD devices which are
> +	  basically just a regmap bus driver.

Please expand on this.  I think it deserves greater explanation.

>  config MFD_SM501
>  	tristate "Silicon Motion SM501"
>  	depends on HAS_DMA

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
