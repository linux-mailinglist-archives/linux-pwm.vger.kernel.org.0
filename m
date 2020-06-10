Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F30D1F4EBA
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jun 2020 09:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgFJHTq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 10 Jun 2020 03:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbgFJHTq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Jun 2020 03:19:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D3EC08C5C3
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jun 2020 00:19:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so975009wrn.11
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jun 2020 00:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=11ciiGFTUr2GF55cgml5pBiTEF8081Q9X8UCb/QcHRA=;
        b=Y9ae5q6P3q0sJJ1zZgF5extf7FxIBPJDw9AERd1YPcixBQAP0Gr+TCXETNfkI0Ur3N
         B8mPHGrm319rRaMA4hgm+eI0R3VG+o6oRgiiCl8INYlYZnx1OnsY1uuUZyOnYb9PXFEf
         5Mn3qxOZjRhNgI7R7zTJRQP4nS22KepHMy5J6lwf0eqyJYSEFoUgcuipvEYeo9d5tFgj
         uHcfLI/dm118AnKQJoCfnCkZm8DPVRTv3Mv35S+aFF9S/ifBiRJl6V58bk5CCgr3Na7f
         VB7ylHcVoSU5G6Cgq0d1kRMjbpWguWaBM4S6/TkoWS4gIyzZL6hewxemNDEwJJG0prKJ
         fzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=11ciiGFTUr2GF55cgml5pBiTEF8081Q9X8UCb/QcHRA=;
        b=X74YCMDDmwTAOQfKzAkGJUeey7voHAGoQpuaucVaRhIqG2Bn2fd3p8w49bIRj/rS8a
         bNqRvgb620ywuOpeIeS4NsqgPDb95nyYO9nr508mokaJh1wKh3YetrTKCd6xJglA7fHn
         oLbKJKREY9ZS6mKoSu+gNnPGoRog+C+vAsckG3x5aLzO8Z0pEMMKNrE9t+ZnDKvI/vxw
         otAgYXISuETUzUCaPzJy+6JN/WN231enpeV0c/BFJ4jzIXyF0e3UBRe/zs5iNXgiuQpK
         7tsipi3xVFZ1N239Nic/ZJVcYsZHWaqiQFTmqEzNxrAnDb1sUVywbmDDaEoFkfceonGX
         fNYA==
X-Gm-Message-State: AOAM530Jj/PAjv8s+3CmC+s1R3uekdbKObNla6CaE4ReFIvT9qHUb8Td
        0iIFxKgiu45QWF1cQ9TajHGaxQ==
X-Google-Smtp-Source: ABdhPJx35j366zEzN8LJVnCpeR2FpiGqjvYG09aoVlwPYi548sT34jyAOpph5ZNw8v8eHkYZVutgRw==
X-Received: by 2002:adf:e84c:: with SMTP id d12mr1957757wrn.284.1591773582952;
        Wed, 10 Jun 2020 00:19:42 -0700 (PDT)
Received: from dell ([2.27.167.101])
        by smtp.gmail.com with ESMTPSA id 67sm7063666wrk.49.2020.06.10.00.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:19:42 -0700 (PDT)
Date:   Wed, 10 Jun 2020 08:19:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        david.m.ertman@intel.com, shiraz.saleem@intel.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Message-ID: <20200610071940.GS4106@dell>
References: <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
 <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
 <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
 <20200609151941.GM4106@dell>
 <95e6ec9bbdf6af7a9ff9c31786f743f2@walle.cc>
 <20200609194505.GQ4106@dell>
 <3a6931248f0efcaf8efbb5425a9bd833@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a6931248f0efcaf8efbb5425a9bd833@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 10 Jun 2020, Michael Walle wrote:
> Am 2020-06-09 21:45, schrieb Lee Jones:
> > On Tue, 09 Jun 2020, Michael Walle wrote:
> > > > We do not need a 'simple-regmap' solution for your use-case.
> > > >
> > > > Since your device's registers are segregated, just split up the
> > > > register map and allocate each sub-device with it's own slice.
> > > 
> > > I don't get it, could you make a device tree example for my
> > > use-case? (see also above)
> > 
> >     &i2cbus {
> >         mfd-device@10 {
> >             compatible = "simple-mfd";
> >             reg = <10>;
> > 
> >             sub-device@10 {
> >                 compatible = "vendor,sub-device";
> >                 reg = <10>;
> >             };
> >    };
> > 
> > The Regmap config would be present in each of the child devices.
> > 
> > Each child device would call devm_regmap_init_i2c() in .probe().
> 
> Ah, I see. If I'm not wrong, this still means to create an i2c
> device driver with the name "simple-mfd".

Yes, it does.

> Besides that, I don't like this, because:
>  - Rob already expressed its concerns with "simple-mfd" and so on.

Where did this take place?  I'd like to read up on this.

>  - you need to duplicate the config in each sub device

You can have a share a single config.

>  - which also means you are restricting the sub devices to be
>    i2c only (unless you implement and duplicate other regmap configs,
>    too). For this driver, SPI and MMIO may be viable options.

You could also have a shared implementation to choose between different
busses.

> Thus, I'd rather implement a simple-mfd.c which implement a common
> I2C driver for now and populate its children using
> devm_of_platform_populate(). This could be extended to support other
> type of regmaps like SPI in the future.
> 
> Also some MFD drivers could be moved to this, a likely candidate is
> the smsc-ece1099.c. Although I don't really understand its purpose,
> if don't have CONFIG_OF.
> 
> Judging from the existing code, this simple-mfd.c wouldn't just be
> "a list of compatible" strings but also additional quirks and tweaks
> for particular devices in this list.

Hold off on the simple-mfd.c idea, as I'm not taken by it yet and
wouldn't want you to waste your time.  I have another idea which would
help.  Give me a few days to put something together.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
