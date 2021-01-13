Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8202F45AF
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Jan 2021 09:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbhAMIEM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Jan 2021 03:04:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbhAMIEM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Jan 2021 03:04:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC80C061795
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jan 2021 00:03:31 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c124so670349wma.5
        for <linux-pwm@vger.kernel.org>; Wed, 13 Jan 2021 00:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=x/0jlx5sSaKGGvb82wT8NsfZQdjIWktlt2hn75IM74U=;
        b=UOSU3aE4iuyQkGOW+qRrl9/F6PrWS+AL3kvnJ6uiz+kv99SwWb/xGubQERauz2hPwy
         G3j5vLn3i4ZU1FME8RQHcOH8vsT235Xq5WVVsOUj5H8jQSnawcM+w4sWsDBKgRaBMRRZ
         wjHmeBk0IP1np7qyCxkcTMJ8so2OLtf+KJ1YVebD6A+Va6GkpO55SqyL9FW0XBidcd7H
         H/QYGlcEd3L6nFQalTRd3ZwO4cx1uXbENOO4bS4oKG+NcUztO89pQ8z3veYXCDQigzY0
         477bwjCXj6xfANnOv9MrPvNQ+3OXFXrJ0ae1lz9MuRdscRW9DgKfuSF8+q1UZEHrSqIQ
         qwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=x/0jlx5sSaKGGvb82wT8NsfZQdjIWktlt2hn75IM74U=;
        b=jl3hQFCwsCfH2bZfj8pTKikIjDhXsw/fuHUopopXn+watABL68E0GpIuTWy7laaW+L
         erHEMXz2WUVx5TvIn4r1LMX9z5pfCtiA2N5XLBysk99JPK0j1Vw6v/uHM5FPUr7CSx3l
         QRQGATLw1B7O9OpQ/wd6SE04BbcmmU5BEpPoUTHPMgWMU7UXLhr/8IFms+WodtjCYVHT
         iphGhZK3rRRLl1wLWpZkwUdcyLwcEnaEQeyZoiyX3LvhiG3rOgzmL44zV4KEZUnRHVSl
         KJLPuoK+8sJOMqBwdpwjw2jSS/CjO5DuVk0tmBUVZln8dypujOHhtB2wc7zVsp/Ql4Kd
         m0iA==
X-Gm-Message-State: AOAM530B8cH91i6NptbkNCc0W5LuBwoTrZsaGu8xfksk4lN+OCDyrDQ7
        4Xfml6SSMzg3gnCqvSLcEp+aYA==
X-Google-Smtp-Source: ABdhPJxpCDBiFWnjkppzs22ouEjB8n2LOdUBFP8RAquah+kSxU4xDjx22C+43u1cMHh/poxxgAVVpg==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr944114wmj.61.1610525010138;
        Wed, 13 Jan 2021 00:03:30 -0800 (PST)
Received: from dell ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id y68sm1844813wmc.0.2021.01.13.00.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:03:29 -0800 (PST)
Date:   Wed, 13 Jan 2021 08:03:27 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Palmer <daniel@0x0f.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v7 3/7] mfd: Add base driver for Netronix embedded
 controller
Message-ID: <20210113080327.GB3975472@dell>
References: <20210109180220.121511-1-j.neuschaefer@gmx.net>
 <20210109180220.121511-4-j.neuschaefer@gmx.net>
 <20210112203649.67f66996@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210112203649.67f66996@aktux>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 12 Jan 2021, Andreas Kemnade wrote:

> On Sat,  9 Jan 2021 19:02:16 +0100
> Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:
> 
> > The Netronix embedded controller is a microcontroller found in some
> > e-book readers designed by the original design manufacturer Netronix,
> > Inc. It contains RTC, battery monitoring, system power management, and
> > PWM functionality.
> > 
> > This driver implements register access and version detection.
> > 
> > Third-party hardware documentation is available at:
> > 
> >   https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-controller
> > 
> > The EC supports interrupts, but the driver doesn't make use of them so
> > far.
> > 
> > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

[...]

> > +static const struct of_device_id of_ntxec_match_table[] = {
> > +	{ .compatible = "netronix,ntxec", },
> > +	{}
> > +};
> > +
> MODULE_DEVICE_TABLE?
> 
> > +static struct i2c_driver ntxec_driver = {
> > +	.driver = {
> > +		.name = "ntxec",
> > +		.of_match_table = of_ntxec_match_table,
> > +	},
> > +	.probe_new = ntxec_probe,
> > +	.remove = ntxec_remove,
> > +};
> > +module_i2c_driver(ntxec_driver);
> 
> MODULE_LICENSE()?
> 
> modpost moans about that here.

Andreas, would you be kind enough to snip/trim your replies in future
please.  It would save a *lot* of people a little bit of time (which
adds up fast).  TIA.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
