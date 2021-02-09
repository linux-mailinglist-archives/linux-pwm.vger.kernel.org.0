Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A341E31514D
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Feb 2021 15:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhBIOMq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Feb 2021 09:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhBIOMm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Feb 2021 09:12:42 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6C1C061793
        for <linux-pwm@vger.kernel.org>; Tue,  9 Feb 2021 06:12:02 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z6so21929013wrq.10
        for <linux-pwm@vger.kernel.org>; Tue, 09 Feb 2021 06:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=k1HhnpSm7palodE2BhJbwA2o7GYtOSex3ooquhrx81E=;
        b=T87iwANX2bAYRxZaQ0Z9PSx+xhQ3pig0kYuKz7L0TFzP8KIOx61cS2BeggXG5U6eSC
         TehNjJAijyzIjuLvJHhW7y7q3q/bIDw5VlsTc0jtYg9D79vloeFzYTsLAEOe6LO+pHPL
         dgZ2RtqE8NiP6inQiyOwdsP3Su0LyVbLYG84N27ag9T3QMcq+9APLn/h+EhDUysAvc42
         PvYWgclqRiEJHXf8UG90XTFH7+bf81InRc0Acx+qoalaMDw2G9o77VgMsEATvTqxe01E
         zNu0XnVULhojgSsX4gQRvBmthEAmTtNIzB1XcHUAmEozdcU/Brh4Jfft+bs5rnF5Eury
         yAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k1HhnpSm7palodE2BhJbwA2o7GYtOSex3ooquhrx81E=;
        b=srckBv7Rs0IzAZ6TKMhqhyPe7bKy1nqRs9Lx35B5tRspS/cB+7KkNPSE5OTB2uzDGE
         fh1Yrt2a8P/nk1fEv+fWDvvgdm//odyVHi+Zps0twegsVhbpDc6e1lyMzqbfeIWop8qv
         WGyRxJr1tmuKCpDeS7u+WVry4iPgJYmxeFtTlCfIdUUQ2VHhY+aPpWZXFzJAfhIrOaTf
         +2rPF+Uepo9apNKgdH6y/J+Ivja876vHKBurtWgbAUVTTHorJ9s6E1uELYuR5y6WdLvI
         K/n+3wDqLhZmJQzH0OfhLMjYxmbZDB9u1pvcrN/5+efNkdBAA2b7DxMQVcYe/KYNbuq1
         leZw==
X-Gm-Message-State: AOAM530YYepI9VZFWQgzeLx6zToJq7Z9E2EJCLvg5EksJzQyK0i2+Y0v
        EL9g+uKXzBzGiNX/4wvfY8akkQ==
X-Google-Smtp-Source: ABdhPJwhlg9/4addqJWZY9EJWC2V/ljjUkL52jAkH5a66gwevR6yODdQLNjXa223yZxHOa6oVfQnHg==
X-Received: by 2002:a5d:67d1:: with SMTP id n17mr18771567wrw.168.1612879920377;
        Tue, 09 Feb 2021 06:12:00 -0800 (PST)
Received: from dell ([91.110.221.187])
        by smtp.gmail.com with ESMTPSA id x4sm2187357wrn.64.2021.02.09.06.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 06:11:59 -0800 (PST)
Date:   Tue, 9 Feb 2021 14:11:57 +0000
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
Subject: Re: [PATCH v9 0/7] Netronix embedded controller driver for Kobo and
 Tolino ebook readers
Message-ID: <20210209141157.GD4766@dell>
References: <20210124214127.3631530-1-j.neuschaefer@gmx.net>
 <20210208225644.3df4da99@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210208225644.3df4da99@aktux>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 08 Feb 2021, Andreas Kemnade wrote:

> On Sun, 24 Jan 2021 22:41:20 +0100
> Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:
> 
> > This patchset adds basic support for the embedded controller found on
> > older ebook reader boards designed by/with the ODM Netronix Inc.[1] and
> > sold by Kobo or Tolino, for example the Kobo Aura and the Tolino Shine.
> > These drivers are based on information contained in the vendor kernel
> > sources, but in order to all information in a single place, I documented
> > the register interface of the EC on GitHub[2].
> > 
> > [1]: http://www.netronixinc.com/products.aspx?ID=1
> > [2]: https://github.com/neuschaefer/linux/wiki/Netronix-MSP430-embedded-controller
> > 
> > v9:
> > - Fixed a bug in the error handling of ntxec_probe,
> >   Reported-by: kernel test robot <lkp@intel.com>
> > - Added Thierry Reding's ACK to the PWM patch
> > 
> what is the fate of this one, looks like it got all acks from
> maintainers.

I'll apply it when -rc1 is out.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
