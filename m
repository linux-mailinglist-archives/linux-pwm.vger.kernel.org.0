Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC541F3F13
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 17:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730569AbgFIPTs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgFIPTp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jun 2020 11:19:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A870BC03E97C
        for <linux-pwm@vger.kernel.org>; Tue,  9 Jun 2020 08:19:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l11so21779389wru.0
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jun 2020 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Rk2oDZPnfwMXUWPErdEgPnP2nnFU5znUIkJLh8odeKY=;
        b=TrSlB8pYYj3hLyZLYGz8CnGfrshe0S63alFmjMac7FlNzG2WrvJcCnPzJ8Y3oz/zHu
         grMZ5fATJYLfW21vf4pqIUOAPjq+r3Et4vCnkaPwST2LbT2KEoI9waM0A52GPC6YdUT3
         Wc8cUHOlxEpq9fSHi+NmPiY88KUNz40lvfstxa+lVwypcEQcKWkK1lidFi9i4AvNKYnx
         vJyRjAGpSN4P2TaQTOE5rxOe+rMbWd3rvknENlTFtY9iDv9LR2IXfrDmM0YiCIhZ5Dtc
         /f++AJlEm+hW9u6LzmlFxwyrCxmT2YbHV9t0fJaWdoOmplWYM0XKAZtxSVfkybGK8Xrc
         MoRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Rk2oDZPnfwMXUWPErdEgPnP2nnFU5znUIkJLh8odeKY=;
        b=bw7nneqxwFpFOYaLP8rmEHQAFHFYne+gdY6E9iFKdxTvyj6/O8MKBI+EfQmI4DydOR
         FNPmVJx+7gIYjQPzR5DjWFa6Rvz66gMLExbxSdzmieIProRIRue8sJvw7u3jsouotA8Z
         gwyQYJKTs9SqmgkLns/3y0GSrPhD7uDKoXlx6YtXkw6D2bq5S8LsiluhxG2mKLQLFY+g
         lw9ta2ExJCO52xBmZpuKUq+yOCdsI/FN7b9yA6tZGsEBZyRF88Qw/jPjx1vVq/MjUvV0
         Xqi0c4lKYdw99Bv/wUsB6kyZmu6On5X9Zl4n02fd7GfGpcPKzsiiAK4QFa3eiprI5vt+
         7OFA==
X-Gm-Message-State: AOAM530ExJPSgNKHgw6m4R8B7CzcGu2ddpyQD5oCnWOgFSDvabzwYdiY
        zoD4spgmKsww07v0653Hlg4a0A==
X-Google-Smtp-Source: ABdhPJw2lbdxCvWfX4BaLx0JY0xh8sw3TkHMqxmT6Rm1ZGth1zxLA0vydahsSf+ib3yzcV5qZtEpfw==
X-Received: by 2002:adf:f4c6:: with SMTP id h6mr5221915wrp.398.1591715984320;
        Tue, 09 Jun 2020 08:19:44 -0700 (PDT)
Received: from dell ([2.27.167.101])
        by smtp.gmail.com with ESMTPSA id h5sm3800319wrw.85.2020.06.09.08.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 08:19:43 -0700 (PDT)
Date:   Tue, 9 Jun 2020 16:19:41 +0100
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
Message-ID: <20200609151941.GM4106@dell>
References: <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
 <20200606114645.GB2055@sirena.org.uk>
 <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
 <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
 <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
 <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, 09 Jun 2020, Michael Walle wrote:

> Am 2020-06-09 08:47, schrieb Lee Jones:
> > On Mon, 08 Jun 2020, Michael Walle wrote:
> > 
> > > Am 2020-06-08 20:56, schrieb Lee Jones:
> > > > On Mon, 08 Jun 2020, Michael Walle wrote:
> > > >
> > > > > Am 2020-06-08 12:02, schrieb Andy Shevchenko:
> > > > > > +Cc: some Intel people WRT our internal discussion about similar
> > > > > > problem and solutions.
> > > > > >
> > > > > > On Mon, Jun 8, 2020 at 11:30 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > > On Sat, 06 Jun 2020, Michael Walle wrote:
> > > > > > > > Am 2020-06-06 13:46, schrieb Mark Brown:
> > > > > > > > > On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> > > > > > > > > > Am 2020-06-05 12:50, schrieb Mark Brown:
> > > > > >
> > > > > > ...
> > > > > >
> > > > > > > Right.  I'm suggesting a means to extrapolate complex shared and
> > > > > > > sometimes intertwined batches of register sets to be consumed by
> > > > > > > multiple (sub-)devices spanning different subsystems.
> > > > > > >
> > > > > > > Actually scrap that.  The most common case I see is a single Regmap
> > > > > > > covering all child-devices.
> > > > > >
> > > > > > Yes, because often we need a synchronization across the entire address
> > > > > > space of the (parent) device in question.
> > > > > >
> > > > > > >  It would be great if there was a way in
> > > > > > > which we could make an assumption that the entire register address
> > > > > > > space for a 'tagged' (MFD) device is to be shared (via Regmap) between
> > > > > > > each of the devices described by its child-nodes.  Probably by picking
> > > > > > > up on the 'simple-mfd' compatible string in the first instance.
> > > > > > >
> > > > > > > Rob, is the above something you would contemplate?
> > > > > > >
> > > > > > > Michael, do your register addresses overlap i.e. are they intermingled
> > > > > > > with one another?  Do multiple child devices need access to the same
> > > > > > > registers i.e. are they shared?
> > > > >
> > > > > No they don't overlap, expect for maybe the version register, which is
> > > > > just there once and not per function block.
> > > >
> > > > Then what's stopping you having each device Regmap their own space?
> > > 
> > > Because its just one I2C device, AFAIK thats not possible, right?
> > 
> > Not sure what (if any) the restrictions are.
> 
> You can only have one device per I2C address. Therefore, I need one device
> which is enumerated by the I2C bus, which then enumerates its sub-devices.
> I thought this was one of the use cases for MFD. (Regardless of how a
> sub-device access its registers). So even in the "simple-regmap" case this
> would need to be an i2c device.
> 
> E.g.
> 
> &i2cbus {
>   mfd-device@10 {
>     compatible = "simple-regmap", "simple-mfd";
>     reg = <10>;
>     regmap,reg-bits = <8>;
>     regmap,val-bits = <8>;
>     sub-device@0 {
>       compatible = "vendor,sub-device0";
>       reg = <0>;
>     };
>     ...
> };
> 
> Or if you just want the regmap:
> 
> &soc {
>   regmap: regmap@fff0000 {
>     compatible = "simple-regmap";
>     reg = <0xfff0000>;
>     regmap,reg-bits = <16>;
>     regmap,val-bits = <32>;
>   };
> 
>   enet-which-needs-syscon-too@1000000 {
>     vendor,ctrl-regmap = <&regmap>;
>   };
> };
> 
> Similar to the current syscon (which is MMIO only..).

We do not need a 'simple-regmap' solution for your use-case.

Since your device's registers are segregated, just split up the
register map and allocate each sub-device with it's own slice.

> > I can't think of any reasons why not, off the top of my head.
> > 
> > Does Regmap only deal with shared accesses from multiple devices
> > accessing a single register map, or can it also handle multiple
> > devices communicating over a single I2C channel?
> > 
> > One for Mark perhaps.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
