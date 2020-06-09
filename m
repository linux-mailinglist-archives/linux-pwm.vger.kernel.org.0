Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313B61F4764
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 21:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgFITpT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 15:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbgFITpP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jun 2020 15:45:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DF9C08C5C5
        for <linux-pwm@vger.kernel.org>; Tue,  9 Jun 2020 12:45:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id y20so4335906wmi.2
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jun 2020 12:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eVChyNp9hZc+Gzjg8UZb0YNMtsUWDyIgCP+b2/L/34Y=;
        b=Cimu+rlxTJjxCBFMH0knwV5QoVBXhRJmOfAz+EC43J0oGHTAEwARoNbay95Kx3eB7W
         ptqDaODZ32mHoLWcGw81m9wQbqK3ifMfpRo9GyK+2vojRokke8yhlk/mJgXTBLsl4WpQ
         0U0yQpDvzkXCZwXSxyDb/ufDjEoWfCeu66+0+50n9NPCoYUhTs2u2Gm62fETckdu7UWT
         S/YtCKh4HnEschFfSQCfjdd7iC6oO8rLeRA759ywXW6qUciDGTfKtXEWRwHnlIKMAwc1
         hfaewDA0sHH7tFerdI9BStCA5eGFa7Av0bxROgGCwkuT0nkS67vm8NnbqVA5lUEv8fuo
         PUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eVChyNp9hZc+Gzjg8UZb0YNMtsUWDyIgCP+b2/L/34Y=;
        b=aMbbRESMW6gssUXIpmsy2888eaIMb3k+dhsvZHLFmrKFvJOEXeGx/rQVsmrtpTmuWK
         kEKNkpR1YmHTXHFBAFpJL7Uk6DWlFN/D6QWGLe4DWhHhMVWbLF5jL4kdIAUVoLZ02s+r
         nffa7BEI9nTjxuASCuMCVw2a5zaeqYBu4WCmhrem2DIwJqU9BZ39xJaioK9DAZumxOmz
         mkl6ifqouUCSOv9OuHz3+3bM9NayDvHdFFgUKswPVmjfyo7zQ0hDmj7BkQ2Iv33vwDOu
         gQQCbkqiZ+wXcZepoR0i1L7JU+ONoW2DFwUw1XqWGvALBOkOiyh9neodU4ILrhx3YcyJ
         11eA==
X-Gm-Message-State: AOAM530ZrbFQrwMGC5DosYSfuIUajuGmpTI/1Ngu+qxeaRicOUa9+r+C
        kiZJeieKP9FgqLgcNsZU7w/sqQ==
X-Google-Smtp-Source: ABdhPJy0yYa42yENG73o0WmFdkVW7mcgR4r704T13woKoj35YQQS5XtfAK0Wu3xQ01RXCjgttX8XLA==
X-Received: by 2002:a1c:f216:: with SMTP id s22mr5325673wmc.167.1591731907981;
        Tue, 09 Jun 2020 12:45:07 -0700 (PDT)
Received: from dell ([2.27.167.101])
        by smtp.gmail.com with ESMTPSA id q1sm3856878wmc.12.2020.06.09.12.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 12:45:07 -0700 (PDT)
Date:   Tue, 9 Jun 2020 20:45:05 +0100
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
Message-ID: <20200609194505.GQ4106@dell>
References: <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
 <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
 <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
 <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
 <20200609151941.GM4106@dell>
 <95e6ec9bbdf6af7a9ff9c31786f743f2@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95e6ec9bbdf6af7a9ff9c31786f743f2@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 09 Jun 2020, Michael Walle wrote:

> Am 2020-06-09 17:19, schrieb Lee Jones:
> > On Tue, 09 Jun 2020, Michael Walle wrote:
> > 
> > > Am 2020-06-09 08:47, schrieb Lee Jones:
> > > > On Mon, 08 Jun 2020, Michael Walle wrote:
> > > >
> > > > > Am 2020-06-08 20:56, schrieb Lee Jones:
> > > > > > On Mon, 08 Jun 2020, Michael Walle wrote:
> > > > > >
> > > > > > > Am 2020-06-08 12:02, schrieb Andy Shevchenko:
> > > > > > > > +Cc: some Intel people WRT our internal discussion about similar
> > > > > > > > problem and solutions.
> > > > > > > >
> > > > > > > > On Mon, Jun 8, 2020 at 11:30 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > > > > On Sat, 06 Jun 2020, Michael Walle wrote:
> > > > > > > > > > Am 2020-06-06 13:46, schrieb Mark Brown:
> > > > > > > > > > > On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> > > > > > > > > > > > Am 2020-06-05 12:50, schrieb Mark Brown:
> > > > > > > >
> > > > > > > > ...
> > > > > > > >
> > > > > > > > > Right.  I'm suggesting a means to extrapolate complex shared and
> > > > > > > > > sometimes intertwined batches of register sets to be consumed by
> > > > > > > > > multiple (sub-)devices spanning different subsystems.
> > > > > > > > >
> > > > > > > > > Actually scrap that.  The most common case I see is a single Regmap
> > > > > > > > > covering all child-devices.
> > > > > > > >
> > > > > > > > Yes, because often we need a synchronization across the entire address
> > > > > > > > space of the (parent) device in question.
> > > > > > > >
> > > > > > > > >  It would be great if there was a way in
> > > > > > > > > which we could make an assumption that the entire register address
> > > > > > > > > space for a 'tagged' (MFD) device is to be shared (via Regmap) between
> > > > > > > > > each of the devices described by its child-nodes.  Probably by picking
> > > > > > > > > up on the 'simple-mfd' compatible string in the first instance.
> > > > > > > > >
> > > > > > > > > Rob, is the above something you would contemplate?
> > > > > > > > >
> > > > > > > > > Michael, do your register addresses overlap i.e. are they intermingled
> > > > > > > > > with one another?  Do multiple child devices need access to the same
> > > > > > > > > registers i.e. are they shared?
> > > > > > >
> > > > > > > No they don't overlap, expect for maybe the version register, which is
> > > > > > > just there once and not per function block.
> > > > > >
> > > > > > Then what's stopping you having each device Regmap their own space?
> > > > >
> > > > > Because its just one I2C device, AFAIK thats not possible, right?
> > > >
> > > > Not sure what (if any) the restrictions are.
> > > 
> > > You can only have one device per I2C address. Therefore, I need one
> > > device
> > > which is enumerated by the I2C bus, which then enumerates its
> > > sub-devices.
> > > I thought this was one of the use cases for MFD. (Regardless of how a
> > > sub-device access its registers). So even in the "simple-regmap"
> > > case this
> > > would need to be an i2c device.
> 
> Here (see below)

Yes, it should still be an I2C device.

> > > 
> > > E.g.
> > > 
> > > &i2cbus {
> > >   mfd-device@10 {
> > >     compatible = "simple-regmap", "simple-mfd";
> > >     reg = <10>;
> > >     regmap,reg-bits = <8>;
> > >     regmap,val-bits = <8>;
> > >     sub-device@0 {
> > >       compatible = "vendor,sub-device0";
> > >       reg = <0>;
> > >     };
> > >     ...
> > > };
> > > 
> > > Or if you just want the regmap:
> > > 
> > > &soc {
> > >   regmap: regmap@fff0000 {
> > >     compatible = "simple-regmap";
> > >     reg = <0xfff0000>;
> > >     regmap,reg-bits = <16>;
> > >     regmap,val-bits = <32>;
> > >   };
> > > 
> > >   enet-which-needs-syscon-too@1000000 {
> > >     vendor,ctrl-regmap = <&regmap>;
> > >   };
> > > };
> > > 
> > > Similar to the current syscon (which is MMIO only..).
> > 
> > We do not need a 'simple-regmap' solution for your use-case.
> > 
> > Since your device's registers are segregated, just split up the
> > register map and allocate each sub-device with it's own slice.
> 
> I don't get it, could you make a device tree example for my
> use-case? (see also above)

    &i2cbus {
        mfd-device@10 {
            compatible = "simple-mfd";
            reg = <10>;

            sub-device@10 {
                compatible = "vendor,sub-device";
                reg = <10>;
            };
   };

The Regmap config would be present in each of the child devices.

Each child device would call devm_regmap_init_i2c() in .probe().

> > > > I can't think of any reasons why not, off the top of my head.
> > > >
> > > > Does Regmap only deal with shared accesses from multiple devices
> > > > accessing a single register map, or can it also handle multiple
> > > > devices communicating over a single I2C channel?
> > > >
> > > > One for Mark perhaps.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
