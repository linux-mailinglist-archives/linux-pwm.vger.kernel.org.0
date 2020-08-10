Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89097240246
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Aug 2020 09:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgHJHNe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Aug 2020 03:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgHJHNd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Aug 2020 03:13:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4326C061756
        for <linux-pwm@vger.kernel.org>; Mon, 10 Aug 2020 00:13:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id 88so7113808wrh.3
        for <linux-pwm@vger.kernel.org>; Mon, 10 Aug 2020 00:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+TUd9JRbZ1pyZaCnuclZ/AO9DW45PgvoNIXxTZ6zZrE=;
        b=xQ1R7jn546DiRqc42dCW1K0GBZinc8U+spujkwGvBUURTctIhYaWn2QdhGZfToWnw/
         5WaTr1uaqsnHbcqicFNMbrOXBvK3DRuOoa97gNdCZ3P/jMkT5DMw8Oqxo1o+rrdWnycB
         F1Cmwbw50K8AsHAmU5ovD0YutO27HrbG0f5BRd7XGL/5CQdplPTOe43ukzJHgt0QJuIM
         D49YXIRmo8bTF+TIGOxUn4gLC+4NkqpjzL3XxxmadY2k4VEgAi1B7xaQTHPeVPo2lVZS
         qyQZU1p/vIReqk4RRLfGi8wx+XfFdG1W58Ic/CLzzZfCQ4+MaAjNBW4DYLLJJNqNd9tS
         kRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+TUd9JRbZ1pyZaCnuclZ/AO9DW45PgvoNIXxTZ6zZrE=;
        b=ok3wB8OY+ryCKIFwqVP5iGMiCuJR5++tVDJFxOvaHhLvQXEWluULnua3GGFIYlpbSp
         Q7IcQ9ZQuXzz/WxQIHf9VHICm/5uCLiUqwprka1HTR1MFJAhmiZPhKisvFR79Cx2D7D/
         f37FBF7bIhSuwFiY2MxYjnOwMOUX/jEFMS8btc3tRvZ94cUrmy3lGPvfvG88dM9AYgCA
         9WOawsdElwF61YyCQ/CnZT1e2bnChZAZ5p/hA2nWZPx4EknKCcQBPPJmuDNPLedE4Y2e
         mBF9zTr1qUkSpwo8amWttuGWnX3ITAQZjYjQGE27R0+qKj8zOq813nOKS+cz7rYA/MJC
         USGA==
X-Gm-Message-State: AOAM530xnF2YBBg18+Ufc5FZGSXtBp+JnQHdlOt8d0Fa81z/scQqhVWa
        0jTCpeLkUp7+U3DXzqXYRHUAxg==
X-Google-Smtp-Source: ABdhPJyqMpwZFIytM3dip4yb9zg/T5q+SVei4Y+VdZ3uIDP/QBRxHBX79zX6kLVNBEQ3N66zTYZL3w==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr23689763wrv.104.1597043611405;
        Mon, 10 Aug 2020 00:13:31 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id t3sm3850812wrx.5.2020.08.10.00.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 00:13:30 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:13:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 06/13] pwm: add support for sl28cpld PWM controller
Message-ID: <20200810071328.GB4411@dell>
References: <20200803093559.12289-1-michael@walle.cc>
 <20200803093559.12289-7-michael@walle.cc>
 <20200806084000.k3aj5nmqdodmb35v@pengutronix.de>
 <e288ca6cfee819223395712e04159dd9@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e288ca6cfee819223395712e04159dd9@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, 07 Aug 2020, Michael Walle wrote:

> Hi Uwe, Hi Lee,
> 
> Am 2020-08-06 10:40, schrieb Uwe Kleine-König:
> > On Mon, Aug 03, 2020 at 11:35:52AM +0200, Michael Walle wrote:
> > > diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> > > index 7dbcf6973d33..a0d50d70c3b9 100644
> > > --- a/drivers/pwm/Kconfig
> > > +++ b/drivers/pwm/Kconfig
> > > @@ -428,6 +428,16 @@ config PWM_SIFIVE
> > >  	  To compile this driver as a module, choose M here: the module
> > >  	  will be called pwm-sifive.
> > > 
> > > +config PWM_SL28CPLD
> > > +	tristate "Kontron sl28cpld PWM support"
> > > +	select MFD_SIMPLE_MFD_I2C
> > 
> > Is it sensible to present this option to everyone? Maybe
> > 
> > 	depends on SOME_SYMBOL_ONLY_TRUE_ON_SL28CPLD || COMPILE_TEST
> 
> Because there is now no real MFD driver anymore, there is also
> no symbol for that. The closest would be ARCH_ARM64 but I don't
> think that is a good idea.
> 
> Lee, what do you think about adding a symbol to the MFD, which
> selects MFD_SIMPLE_MFD_I2C but doesn't enable any C modules?
> 
> I.e.
> config MFD_SL28CPLD
>     tristate "Kontron sl28cpld"
>     select MFD_SIMPLE_MFD_I2C
>     help
>       Say yes here to add support for the Kontron sl28cpld board
>       management controller.
> 
> Then all the other device driver could depend on the MFD_SL28CPLD
> symbol.

You want to add a virtual symbol to prevent having to present a real
one?  How is that a reasonable solution?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
