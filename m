Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5C1F4E9B
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jun 2020 09:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFJHK1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 10 Jun 2020 03:10:27 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:43855 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgFJHK1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Jun 2020 03:10:27 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6397622EEB;
        Wed, 10 Jun 2020 09:10:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1591773021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I0rOB08jXbT35/9E6zpfxRpSFxgkN52VvN9kq0S08UI=;
        b=BP3GRfS1Htxt164ZGINJVvvIsrhug3C3YB9iZv77clU6dqVW9V1WXPUpQ22YfpMM1ntoEr
        YS/bN71y7HJTkKvRFG92Mzh4IerfmOY4KFbuVntCq6cb1MyP0eUbpb18EcKja3TOpxz2Jo
        0dgVu9RjTAzPW/+Jp8nf2hTIKhyn/+o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jun 2020 09:10:18 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
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
        =?UTF-8?Q?Uwe_Kleine-K?= =?UTF-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management
 controller
In-Reply-To: <20200609194505.GQ4106@dell>
References: <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
 <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc> <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc> <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc> <20200609151941.GM4106@dell>
 <95e6ec9bbdf6af7a9ff9c31786f743f2@walle.cc> <20200609194505.GQ4106@dell>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <3a6931248f0efcaf8efbb5425a9bd833@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-06-09 21:45, schrieb Lee Jones:
> On Tue, 09 Jun 2020, Michael Walle wrote:
> 
>> Am 2020-06-09 17:19, schrieb Lee Jones:
>> > On Tue, 09 Jun 2020, Michael Walle wrote:
>> >
>> > > Am 2020-06-09 08:47, schrieb Lee Jones:
>> > > > On Mon, 08 Jun 2020, Michael Walle wrote:
>> > > >
>> > > > > Am 2020-06-08 20:56, schrieb Lee Jones:
>> > > > > > On Mon, 08 Jun 2020, Michael Walle wrote:
>> > > > > >
>> > > > > > > Am 2020-06-08 12:02, schrieb Andy Shevchenko:
>> > > > > > > > +Cc: some Intel people WRT our internal discussion about similar
>> > > > > > > > problem and solutions.
>> > > > > > > >
>> > > > > > > > On Mon, Jun 8, 2020 at 11:30 AM Lee Jones <lee.jones@linaro.org> wrote:
>> > > > > > > > > On Sat, 06 Jun 2020, Michael Walle wrote:
>> > > > > > > > > > Am 2020-06-06 13:46, schrieb Mark Brown:
>> > > > > > > > > > > On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
>> > > > > > > > > > > > Am 2020-06-05 12:50, schrieb Mark Brown:
>> > > > > > > >
>> > > > > > > > ...
>> > > > > > > >
>> > > > > > > > > Right.  I'm suggesting a means to extrapolate complex shared and
>> > > > > > > > > sometimes intertwined batches of register sets to be consumed by
>> > > > > > > > > multiple (sub-)devices spanning different subsystems.
>> > > > > > > > >
>> > > > > > > > > Actually scrap that.  The most common case I see is a single Regmap
>> > > > > > > > > covering all child-devices.
>> > > > > > > >
>> > > > > > > > Yes, because often we need a synchronization across the entire address
>> > > > > > > > space of the (parent) device in question.
>> > > > > > > >
>> > > > > > > > >  It would be great if there was a way in
>> > > > > > > > > which we could make an assumption that the entire register address
>> > > > > > > > > space for a 'tagged' (MFD) device is to be shared (via Regmap) between
>> > > > > > > > > each of the devices described by its child-nodes.  Probably by picking
>> > > > > > > > > up on the 'simple-mfd' compatible string in the first instance.
>> > > > > > > > >
>> > > > > > > > > Rob, is the above something you would contemplate?
>> > > > > > > > >
>> > > > > > > > > Michael, do your register addresses overlap i.e. are they intermingled
>> > > > > > > > > with one another?  Do multiple child devices need access to the same
>> > > > > > > > > registers i.e. are they shared?
>> > > > > > >
>> > > > > > > No they don't overlap, expect for maybe the version register, which is
>> > > > > > > just there once and not per function block.
>> > > > > >
>> > > > > > Then what's stopping you having each device Regmap their own space?
>> > > > >
>> > > > > Because its just one I2C device, AFAIK thats not possible, right?
>> > > >
>> > > > Not sure what (if any) the restrictions are.
>> > >
>> > > You can only have one device per I2C address. Therefore, I need one
>> > > device
>> > > which is enumerated by the I2C bus, which then enumerates its
>> > > sub-devices.
>> > > I thought this was one of the use cases for MFD. (Regardless of how a
>> > > sub-device access its registers). So even in the "simple-regmap"
>> > > case this
>> > > would need to be an i2c device.
>> 
>> Here (see below)
> 
> Yes, it should still be an I2C device.
> 
>> > >
>> > > E.g.
>> > >
>> > > &i2cbus {
>> > >   mfd-device@10 {
>> > >     compatible = "simple-regmap", "simple-mfd";
>> > >     reg = <10>;
>> > >     regmap,reg-bits = <8>;
>> > >     regmap,val-bits = <8>;
>> > >     sub-device@0 {
>> > >       compatible = "vendor,sub-device0";
>> > >       reg = <0>;
>> > >     };
>> > >     ...
>> > > };
>> > >
>> > > Or if you just want the regmap:
>> > >
>> > > &soc {
>> > >   regmap: regmap@fff0000 {
>> > >     compatible = "simple-regmap";
>> > >     reg = <0xfff0000>;
>> > >     regmap,reg-bits = <16>;
>> > >     regmap,val-bits = <32>;
>> > >   };
>> > >
>> > >   enet-which-needs-syscon-too@1000000 {
>> > >     vendor,ctrl-regmap = <&regmap>;
>> > >   };
>> > > };
>> > >
>> > > Similar to the current syscon (which is MMIO only..).
>> >
>> > We do not need a 'simple-regmap' solution for your use-case.
>> >
>> > Since your device's registers are segregated, just split up the
>> > register map and allocate each sub-device with it's own slice.
>> 
>> I don't get it, could you make a device tree example for my
>> use-case? (see also above)
> 
>     &i2cbus {
>         mfd-device@10 {
>             compatible = "simple-mfd";
>             reg = <10>;
> 
>             sub-device@10 {
>                 compatible = "vendor,sub-device";
>                 reg = <10>;
>             };
>    };
> 
> The Regmap config would be present in each of the child devices.
> 
> Each child device would call devm_regmap_init_i2c() in .probe().

Ah, I see. If I'm not wrong, this still means to create an i2c
device driver with the name "simple-mfd".

Besides that, I don't like this, because:
  - Rob already expressed its concerns with "simple-mfd" and so on.
  - you need to duplicate the config in each sub device
  - which also means you are restricting the sub devices to be
    i2c only (unless you implement and duplicate other regmap configs,
    too). For this driver, SPI and MMIO may be viable options.

Thus, I'd rather implement a simple-mfd.c which implement a common
I2C driver for now and populate its children using
devm_of_platform_populate(). This could be extended to support other
type of regmaps like SPI in the future.

Also some MFD drivers could be moved to this, a likely candidate is
the smsc-ece1099.c. Although I don't really understand its purpose,
if don't have CONFIG_OF.

Judging from the existing code, this simple-mfd.c wouldn't just be
"a list of compatible" strings but also additional quirks and tweaks
for particular devices in this list.

-michael
