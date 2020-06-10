Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF3F1F5AED
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jun 2020 20:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgFJSCr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 10 Jun 2020 14:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgFJSCq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Jun 2020 14:02:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C276C03E96F
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jun 2020 11:02:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u13so2674754wml.1
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jun 2020 11:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JxeiI81YmGg5d9U0C/O9qY0Fd0/ZtRnG2PDA0HglqPI=;
        b=a/0EIHUrn6R4n3hmim8fYaSU+3VEc6XzE/W9OBdliAF/zvveloGdlLfeLyj/O+g0S+
         xtGgV00xUPkUAOEq/5grpicbBu7iVxTzPCJLDkCVX4eExpPDvDyft+HwHi6O6t6ksH3Y
         gwTO7zIdQuRfQxyrmebXQg9q0Ji4x4FAbf0y6TrEfSfCWIculPyuWE6YNUT6KQW8+agX
         kd9q7mNOJoM/eU9Ca7bX4t6jq0Dy8hfpfOoAwmzi2B+UJN2Mip2mPsRVCPqoaqUtBSgd
         kj+aPAukgh6gQ0GWPjFa1SHsVOhg58J1eVSu9CuTFweyULX/38yDxnzZD7r2E+cp2gi8
         RllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JxeiI81YmGg5d9U0C/O9qY0Fd0/ZtRnG2PDA0HglqPI=;
        b=apcshEHSaWV7RLFX46MReOWiMvgwmWfCsnDwJZF4OleTIEnzUIYTzwW+YyZJex/Alu
         ACYpJYxdLKMs4tLG8ah/6dmtbnGgG+kW6YW0SlumrDDbKR64N7R7/8+oAdimDWE4l+3e
         PVBp/3sP50QmnK7oDkx7++/htyUEOZbUOX8hB0BrRpmBl5aQVn+ALMp6ZsZpj/bojr0V
         oaSLE/vK94HM5M7Dxr5fhuHq7gGh22uqNTNf3zMgBKtbXdZWP3VBdLHG0e3sWjNacioz
         KEpfS91mR3RI7By2b5TbqUQf03S31amiEMounjMlJ3QGM530iOTkb1aSP5JAQCWaoQnU
         plUA==
X-Gm-Message-State: AOAM53301PNhd3KyUum0YSA22UbkrvcA8p9CR7PCtNgSeij+XzZ83cQ3
        VMK2mym/457uhbpQbl4bbZCaXA==
X-Google-Smtp-Source: ABdhPJw80wfVrkd4Pt8pEq+dAgi4oji9xyaGUc5f8gKzhaU2nyB3JgXw9lNxPsej44PCRcfJ5yA8YA==
X-Received: by 2002:a05:600c:287:: with SMTP id 7mr4521647wmk.91.1591812164504;
        Wed, 10 Jun 2020 11:02:44 -0700 (PDT)
Received: from dell ([2.27.167.101])
        by smtp.gmail.com with ESMTPSA id f11sm832108wrj.2.2020.06.10.11.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 11:02:43 -0700 (PDT)
Date:   Wed, 10 Jun 2020 19:02:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        david.m.ertman@intel.com, shiraz.saleem@intel.com,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
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
Message-ID: <20200610180241.GU4106@dell>
References: <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
 <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
 <20200609151941.GM4106@dell>
 <95e6ec9bbdf6af7a9ff9c31786f743f2@walle.cc>
 <20200609194505.GQ4106@dell>
 <3a6931248f0efcaf8efbb5425a9bd833@walle.cc>
 <20200610071940.GS4106@dell>
 <CAL_JsqKr1aDVzgAMjwwK8E8O_f29vSrx1HXk81FF+rd3sEe==w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKr1aDVzgAMjwwK8E8O_f29vSrx1HXk81FF+rd3sEe==w@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 10 Jun 2020, Rob Herring wrote:

> On Wed, Jun 10, 2020 at 1:19 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Wed, 10 Jun 2020, Michael Walle wrote:
> > > Am 2020-06-09 21:45, schrieb Lee Jones:
> > > > On Tue, 09 Jun 2020, Michael Walle wrote:
> > > > > > We do not need a 'simple-regmap' solution for your use-case.
> > > > > >
> > > > > > Since your device's registers are segregated, just split up the
> > > > > > register map and allocate each sub-device with it's own slice.
> > > > >
> > > > > I don't get it, could you make a device tree example for my
> > > > > use-case? (see also above)
> > > >
> > > >     &i2cbus {
> > > >         mfd-device@10 {
> > > >             compatible = "simple-mfd";
> > > >             reg = <10>;
> > > >
> > > >             sub-device@10 {
> > > >                 compatible = "vendor,sub-device";
> > > >                 reg = <10>;
> > > >             };
> > > >    };
> > > >
> > > > The Regmap config would be present in each of the child devices.
> > > >
> > > > Each child device would call devm_regmap_init_i2c() in .probe().
> > >
> > > Ah, I see. If I'm not wrong, this still means to create an i2c
> > > device driver with the name "simple-mfd".
> >
> > Yes, it does.
> 
> TBC, while fine for a driver to bind on 'simple-mfd', a DT compatible
> with that alone is not fine.

'simple-mfd' essentially means:

  "This device doesn't do anything useful, but the children do."

When used with 'syscon' it means:

  "Memory for this device is shared between all children"

Adding more specific/descriptive compatible strings is conceptually
fine, but they should not be forced to bind to a real driver using
them.  Else we're creating drivers for the sake of creating drivers.

This is especially true with 'simple-mfd' is used without 'syscon'.

> > > Besides that, I don't like this, because:
> > >  - Rob already expressed its concerns with "simple-mfd" and so on.
> >
> > Where did this take place?  I'd like to read up on this.
> >
> > >  - you need to duplicate the config in each sub device
> >
> > You can have a share a single config.
> >
> > >  - which also means you are restricting the sub devices to be
> > >    i2c only (unless you implement and duplicate other regmap configs,
> > >    too). For this driver, SPI and MMIO may be viable options.
> >
> > You could also have a shared implementation to choose between different
> > busses.
> 
> I think it is really the syscon mfd driver you want to generalize to
> other buses. Though with a quick look at it, there's not really a
> whole lot to share. The regmap lookup would be the main thing. You are
> going to need a driver instance for each bus type.

On it.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
