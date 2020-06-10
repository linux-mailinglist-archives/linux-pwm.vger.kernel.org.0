Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3931F5B31
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jun 2020 20:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgFJSbA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 10 Jun 2020 14:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgFJSa6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Jun 2020 14:30:58 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77826C08C5C1
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jun 2020 11:30:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so3443078wru.0
        for <linux-pwm@vger.kernel.org>; Wed, 10 Jun 2020 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/+J5oO5OnfDiIOVOhIHmtbQvypR4NOyguvZ+vS+VBRA=;
        b=DV34bec3kn8ups3mo1KcqY/YeluhEBHJfMnEoE9K8u+na1nJ1DGGsyc4jU+glucolT
         TUviM5dxviwZLPuM0g8+vQXe6cH2pxFxUWwU93dsLznmfLILTgw0LIRBUGyUiEr5eR3C
         YVHYT4otqvUKNG5g6IBlf3xE5gnzBzFj8GQusuekh3De1azhWfnqZ9zrNkArwxjoeSDN
         OrOIMECTmg9RCEjAQB7ALp90Ij1RGNwkk5LC/8K25KqHj43cQrS4VRgqmzzK2AP4yrmE
         cR6KgKL7WPcVlg8QndhCyIa1+G17DLQVODULBk72RsyfmyYYRSqETFm9e19h9C2G/EmO
         VhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/+J5oO5OnfDiIOVOhIHmtbQvypR4NOyguvZ+vS+VBRA=;
        b=ebzEBIuMnnDD0cOY5mQRqH1gUTyBV1LjIVNEAk9yMPn2YyJUQULrUadQu1PAsE9nKS
         exT7oP/WHCOjDScrNt8iEHBx25fEKfklDFzF2tq9v1zx6YeUHS5jpKpSqjr8eXrAvMZS
         QlJm41o1hrcA3hfdPDgRqwsiXw2pQp8bneqCWzUOI7WJWSYbxiPdzyAmx9ZNxZUuRz8X
         KMBVPVJfd/0LknjG+lV9OJvA7ZYmjqwXx5ts0Jq+iYCNAaMzz6Dh/bVV/hfUxRBbFzqm
         8j69/OJiB9ZK6wtCqdn2D3Y582pd+t3uCmk95cXVbdZyU7rnuqtQS3ysclbwYaxgQDHj
         5uFQ==
X-Gm-Message-State: AOAM5327nwibX+4VIvuYLtW+rV3mRpRYyMPbMtr6bSMhQjtnwnJoRuH6
        cynez2rYMdv8TSpELviZu7w1Sw==
X-Google-Smtp-Source: ABdhPJz6Ni2JYhcqjCdFdfUuYTBOEDs7I3nA8SyUMwPOtX+kOnBTbqU0Si/knyTH6nG0/LiIF9R1rQ==
X-Received: by 2002:adf:c98a:: with SMTP id f10mr5095428wrh.329.1591813856649;
        Wed, 10 Jun 2020 11:30:56 -0700 (PDT)
Received: from dell ([2.27.167.101])
        by smtp.gmail.com with ESMTPSA id a15sm878966wra.86.2020.06.10.11.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 11:30:55 -0700 (PDT)
Date:   Wed, 10 Jun 2020 19:30:53 +0100
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
Message-ID: <20200610183053.GV4106@dell>
References: <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc>
 <20200609151941.GM4106@dell>
 <95e6ec9bbdf6af7a9ff9c31786f743f2@walle.cc>
 <20200609194505.GQ4106@dell>
 <3a6931248f0efcaf8efbb5425a9bd833@walle.cc>
 <20200610071940.GS4106@dell>
 <f7b2b690750edd022000ab56d2f58154@walle.cc>
 <20200610075615.GT4106@dell>
 <b06a79c845e0ab251235d30f7dc94dd5@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b06a79c845e0ab251235d30f7dc94dd5@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, 10 Jun 2020, Michael Walle wrote:

> Am 2020-06-10 09:56, schrieb Lee Jones:
> > On Wed, 10 Jun 2020, Michael Walle wrote:
> > 
> > > Am 2020-06-10 09:19, schrieb Lee Jones:
> > > > On Wed, 10 Jun 2020, Michael Walle wrote:
> > > > > Am 2020-06-09 21:45, schrieb Lee Jones:
> > > > > > On Tue, 09 Jun 2020, Michael Walle wrote:
> > > > > > > > We do not need a 'simple-regmap' solution for your use-case.
> > > > > > > >
> > > > > > > > Since your device's registers are segregated, just split up the
> > > > > > > > register map and allocate each sub-device with it's own slice.
> > > > > > >
> > > > > > > I don't get it, could you make a device tree example for my
> > > > > > > use-case? (see also above)
> > > > > >
> > > > > >     &i2cbus {
> > > > > >         mfd-device@10 {
> > > > > >             compatible = "simple-mfd";
> > > > > >             reg = <10>;
> > > > > >
> > > > > >             sub-device@10 {
> > > > > >                 compatible = "vendor,sub-device";
> > > > > >                 reg = <10>;
> > > > > >             };
> > > > > >    };
> > > > > >
> > > > > > The Regmap config would be present in each of the child devices.
> > > > > >
> > > > > > Each child device would call devm_regmap_init_i2c() in .probe().
> > > > >
> > > > > Ah, I see. If I'm not wrong, this still means to create an i2c
> > > > > device driver with the name "simple-mfd".
> > > >
> > > > Yes, it does.
> > > >
> > > > > Besides that, I don't like this, because:
> > > > >  - Rob already expressed its concerns with "simple-mfd" and so on.
> > > >
> > > > Where did this take place?  I'd like to read up on this.
> > > 
> > > In this thread:
> > > https://lore.kernel.org/linux-devicetree/20200604211039.12689-1-michael@walle.cc/T/#m16fdba5962069e7cd4aa817582ee358c9fe2ecbf
> > > 
> > > >
> > > > >  - you need to duplicate the config in each sub device
> > > >
> > > > You can have a share a single config.
> > > >
> > > > >  - which also means you are restricting the sub devices to be
> > > > >    i2c only (unless you implement and duplicate other regmap configs,
> > > > >    too). For this driver, SPI and MMIO may be viable options.
> > > >
> > > > You could also have a shared implementation to choose between different
> > > > busses.
> > > 
> > > Then what is the difference between to have this shared config in the
> > > parent driver only and use the functions which are already there, i.e.
> > > dev_get_regmap(parent). But see, below, I'll wait with what you're
> > > coming up.
> > 
> > The difference is the omission of an otherwise pointless/superfluous
> > driver.  Actually, it's the difference between the omission of 10
> > pointless drivers!
> 
> If you want to omit anything generic in the device tree - and as far as
> I understand it - that should be the way to go, the specific compatible
> string of the parent device has to go somewhere. Thus I'd appreciate
> a consolidated (MFD) driver which holds all these, as you say it
> pointless drivers.
> Because IMHO they are not pointless, rather they are
> the actual drivers for the MFD. Its sub nodes are just an implementation
> detail to be able to use the OF bindings
> (like your clock example or
> a phandle to a PWM controller). Just because it is almost nothing there
> except the regmap instantiation doesn't mean it is not a valid MFD driver.

A valid MFD driver is whatever we (the Linux community at large)
define it to be.  An MFD is not a real thing.  We made it up.  It's
MFD which is the implementation detail, not the child devices.  If a
driver a) does very little, and b) the very little it does do can be
resolved in a different way, is not a valid driver.  It's a waste of
disk space.

> And there is also additional stuff, like clock enable, version checks, etc.

As more functionality is added *then* we can justify a driver.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
