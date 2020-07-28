Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9923057D
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 10:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgG1IfX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 04:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728010AbgG1IfW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 28 Jul 2020 04:35:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DF2C0619D2
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 01:35:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so17369817wrj.13
        for <linux-pwm@vger.kernel.org>; Tue, 28 Jul 2020 01:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wIEap5nu6/u8U1i+WE2J6fe1oYcakn7JFpIXO/o4yqY=;
        b=wzdHmSNupB/gvHxvaTzGoKr1l0PUZe1L5IJjQHR+y+Mftcr7BWvLUXOOxcbrqw/NeC
         txj7PBsaU7zWETRFk7Y3jqiE7gbWfXw6QTy5c8RiQnko2Uvtw0n9+h/2MW1oYQ6J3BHm
         orUCUrnlxxKnUDvUVWzC+ws2mP9aRwuKOLuTxTSGfFE0TLlGcso1EL/1VvUkP/zhmaRf
         QuXPY1hgq16BhisRZ5VkUg9FH351qj7iV+17Bvy8LvnpWlPHTy61IlLLqRgZqsdqA2F2
         EgDK32RgjKUxJ3MVsyl1NPNqLT/bU95m5q6dSnXvN1LR4O9aV1Nru/mFvVMbcjy87O1L
         wbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wIEap5nu6/u8U1i+WE2J6fe1oYcakn7JFpIXO/o4yqY=;
        b=XPcup9S0BGP05Nq71xppNa+p0FutJkWl/hVS9I9QiXLAX7iq73/D2rcJMxK6+6F4/l
         ji4IFV6KSVd+IA8dR/VMkHsWKheT1bw6AGyVp4Ae6Og2Q+dIDDxPIsYGlvt7iECx1kzO
         M+M1s8r+GuhD9pds9+piRPXBH1CbyRrPqpAMhsUuNhfdN1RLbljwQ+ORa1EkI/cJvSC9
         67lEo68TtRj3sjFtrcn3vNyTopsCeV9X5KZJOzoPRRHfLbbRx6P+q6xFLtm9MJHkp8tb
         4RSOg8KGlOsggsn3o5Gc+sbvZAsNI6C/Vx0cIP4Zq7qkMrNqRAqPJjyIhSxHWjUsXEoy
         3ygw==
X-Gm-Message-State: AOAM531CF1gEyuBzcWTvbWHUgVyQLFVKSEaBCqIYtYOTQw/PH5qvrGG5
        xBNVt005LCsdJP/JqpBw/C1D6A==
X-Google-Smtp-Source: ABdhPJwG1bTGEwviQBx4fQX6vXqs1qp0AAL5ZGxkde5J0PYhdXIPql4dbkmS6q4z2xbEkiCvqUsGMQ==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr23369607wrn.51.1595925321324;
        Tue, 28 Jul 2020 01:35:21 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id 62sm16885342wrq.31.2020.07.28.01.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 01:35:20 -0700 (PDT)
Date:   Tue, 28 Jul 2020 09:35:18 +0100
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 01/13] mfd: add simple regmap based I2C driver
Message-ID: <20200728083518.GC2419169@dell>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-2-michael@walle.cc>
 <20200728071949.GE1850026@dell>
 <23a9ecf5fe4f15b9b20a91cc292aca80@walle.cc>
 <20200728081506.GA2419169@dell>
 <5de219e973e9d3c1455f1a09b4ce4177@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5de219e973e9d3c1455f1a09b4ce4177@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 28 Jul 2020, Michael Walle wrote:

> Am 2020-07-28 10:15, schrieb Lee Jones:
> > On Tue, 28 Jul 2020, Michael Walle wrote:
> > 
> > > Am 2020-07-28 09:19, schrieb Lee Jones:
> > > > On Sun, 26 Jul 2020, Michael Walle wrote:
> > > >
> > > > > There are I2C devices which contain several different functions but
> > > > > doesn't require any special access functions. For these kind of
> > > > > drivers
> > > > > an I2C regmap should be enough.
> > > > >
> > > > > Create an I2C driver which creates an I2C regmap and enumerates its
> > > > > children. If a device wants to use this as its MFD core driver, it has
> > > > > to add an individual compatible string. It may provide its own regmap
> > > > > configuration.
> > > > >
> > > > > Subdevices can use dev_get_regmap() on the parent to get their regmap
> > > > > instance.
> > > > >
> > > > > Signed-off-by: Michael Walle <michael@walle.cc>
> > > > > ---
> > > > > Changes since v5:
> > > > >  - removed "select MFD_CORE" in Kconfig
> > > > >  - removed help text in Kconfig, we assume that the users of this
> > > >
> > > > That's the opposite of what I asked for.
> > > 
> > > What is the use to describe the symbol, if it is not user selectable?
> > > I'm not aware this is done anywhere in the kernel, am I missing
> > > something?
> > 
> > You mean in menuconfig?
> > 
> > I find 'help's helpful even outside of menuconfig.
> > 
> > Surely I'm not the only one who reads them 'raw'?
> 
> Its already available in the header of the file. But sure, I can
> copy it.

Thanks.

[...]

> > > Why would you remove information about the intention of this driver?
> > > If
> > > someone
> > > looks for a place to implement its SPI/I3C/Slimbus MFD driver this
> > > might
> > > come
> > > in handy.
> > 
> > By all means put something similar in the commit log, but it has no
> > place in the driver itself.  Besides, if we were to add support for
> > SPI, it is likely to be a completely separate/unrelated driver.
> 
> Why would that be another driver? It would be 90% copy paste with
> regmap_init_i2c() replaced by regmap_init_spi() and i2c_driver replaced
> by spi_driver.

We'll investigate options if/when the time comes.  If 'spi_driver' and
'i2c_driver' can *sensibly* co-exist, then that is certainly an option
we can explore.

> But I don't care. I'll remove it.

Please.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
