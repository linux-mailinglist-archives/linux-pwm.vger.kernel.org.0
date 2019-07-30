Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B1C7A325
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2019 10:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfG3IdM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 30 Jul 2019 04:33:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34255 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729283AbfG3IdL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Jul 2019 04:33:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so26968211edb.1;
        Tue, 30 Jul 2019 01:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q84VjJRDJ4OplkCoHhwYo8/gOcoNfhF91Mul/YA2O6A=;
        b=dX7TiSuRTkdoICkGDXTIkRUiokG9IdMUAp0tE7fXbPH8M5WPmPz007DpPpndieZI4A
         TfcsyY7RpXcOJq9HR9+Xmcr9kwHrzEsHTl4rWDSVywVhXY6Ni9Bmz50cxxMaLvAg2BVZ
         pNefM1lxKMm22JwPv2KfDlm5q5Ow5VMyihWGhiPDupHD7Q2FMmp+QV5FTkvx4fjG2xON
         FJDgZzZmyexKSj9YDBkYCf8zNEAxX9dt/UOioFd0gQi0+0zOxUbmPHcgBLFmFDRj3+en
         XBPUiVFbmsMZaN9dbO0CHelrvw2SCKVg193WEaB7Z3DGj1dNcgfZKucMY8fOaoKSkJCq
         0uVA==
X-Gm-Message-State: APjAAAVUCsZkD25vKTZJKIGDhZQgqz1vvqPacOWUlj2UhUQbj2bOjP/i
        HT4q7X91ZENoDPyofu4Av8VYPwDTPSo=
X-Google-Smtp-Source: APXvYqzcur+qsv4fySmXJ6Fh+6dVDIu6zINrTMeLarEZAVBAE62jSh3ijh2z0tNkHM/OpXA3zURH6w==
X-Received: by 2002:a50:8a04:: with SMTP id i4mr100107817edi.301.1564475588252;
        Tue, 30 Jul 2019 01:33:08 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id pv18sm11776409ejb.14.2019.07.30.01.33.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 01:33:08 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id a15so56259271wmj.5;
        Tue, 30 Jul 2019 01:33:07 -0700 (PDT)
X-Received: by 2002:a7b:c051:: with SMTP id u17mr101736986wmc.25.1564475587103;
 Tue, 30 Jul 2019 01:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <173825848.1FZsmuHfpq@jernej-laptop> <20190729185108.tpilwoooxvi2z72e@pengutronix.de>
 <2452836.v7ux4bnEjb@jernej-laptop> <20190730080900.hhxrqun7vk4nsj2h@pengutronix.de>
In-Reply-To: <20190730080900.hhxrqun7vk4nsj2h@pengutronix.de>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 30 Jul 2019 16:32:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v65jFdFZGLti4_B=2QPbtrj1b8wh63R5G3NpY_ndpJoV5g@mail.gmail.com>
Message-ID: <CAGb2v65jFdFZGLti4_B=2QPbtrj1b8wh63R5G3NpY_ndpJoV5g@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 30, 2019 at 4:09 PM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Rob and Frank,
>
> Maxime and Jernej on one side and me on the other cannot agree about a
> detail in the change to the bindings here. I'm trying to objectively
> summarize the situation for you to help deciding what is the right thing
> to do here.
>
> TLDR: The sun4i pwm driver is extended to support a new variant of that
> device on the H6 SoC. Compared to the earlier supported variants
> allwinner,sun50i-h6-pwm on H6 needs to handle a reset controller and an
> additional clock.
>
> The two positions are:
>
>  - We need a new compatible because only then the driver and/or the dt
>    schema checker can check that each "allwinner,sun50i-h6-pwm" device
>    has a reset property and a "bus" clock; and the earlier variants
>    don't.
>
>  - The driver can be simpler and the device specific knowledge is only
>    in a single place (the dt) if the device tree is considered valid and
>    a reset property and "bus" clock is used iff it's provided in the
>    device tree without additional comparison for the compatible.
>
> Now our arguments seem to go in circles and Jernej was interested in
> your position. That's something I agree with ;-) Can you please share
> your view?
>
> Find below some context about the arguments.

A bit more context on the failure modes:

If the reset control is missing, anything done to hardware will be
silently ignored, since any writes to the registers are ignored.

On the other hand, if the bus clock is missing and otherwise not enabled,
accessing the device's registers could actually stall the whole system.

ChenYu

> Best regards
> Uwe
>
> On Tue, Jul 30, 2019 at 12:04:47AM +0200, Jernej Škrabec wrote:
> > Dne ponedeljek, 29. julij 2019 ob 20:51:08 CEST je Uwe Kleine-König
> > napisal(a):
> > > On Mon, Jul 29, 2019 at 08:46:25PM +0200, Jernej Škrabec wrote:
> > > > Dne ponedeljek, 29. julij 2019 ob 20:40:41 CEST je Uwe Kleine-König
> > > > napisal(a):
> > > > > On Mon, Jul 29, 2019 at 06:40:15PM +0200, Jernej Škrabec wrote:
> > > > > > Dne ponedeljek, 29. julij 2019 ob 18:24:28 CEST je Uwe Kleine-König
> > > > > > napisal(a):
> > > > > > > On Tue, Jul 30, 2019 at 12:09:40AM +0800, Chen-Yu Tsai wrote:
> > > > > > > > On Tue, Jul 30, 2019 at 12:07 AM Uwe Kleine-König
> > > > > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > > > > On Mon, Jul 29, 2019 at 05:55:52PM +0200, Jernej Škrabec wrote:
> > > > > > > > > > Dne ponedeljek, 29. julij 2019 ob 08:40:30 CEST je Uwe Kleine-König
> > > > > > > > > > napisal(a):
> > > > > > > > > > > On Fri, Jul 26, 2019 at 08:40:43PM +0200, Jernej Skrabec wrote:
> > > > > > > > > > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > > > > > > > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > > > > > > > > > @@ -331,6 +331,13 @@ static const struct sun4i_pwm_data
> > > > > > > > > > > > sun4i_pwm_single_bypass = {>
> > > > > > > > > > > >
> > > > > > > > > > > >   .npwm = 1,
> > > > > > > > > > > >
> > > > > > > > > > > >  };
> > > > > > > > > > > >
> > > > > > > > > > > > +static const struct sun4i_pwm_data
> > > > > > > > > > > > sun50i_pwm_dual_bypass_clk_rst
> > > > > > > > > > > > = {
> > > > > > > > > > > > + .has_bus_clock = true,
> > > > > > > > > > > > + .has_prescaler_bypass = true,
> > > > > > > > > > > > + .has_reset = true,
> > > > > > > > > > > > + .npwm = 2,
> > > > > > > > > > > > +};
> > > > > > > > > > > > +
> > > > > > > > > > > >
> > > > > > > > > > > >  static const struct of_device_id sun4i_pwm_dt_ids[] = {
> > > > > > > > > > > >
> > > > > > > > > > > >   {
> > > > > > > > > > > >
> > > > > > > > > > > >           .compatible = "allwinner,sun4i-a10-pwm",
> > > > > > > > > > > >
> > > > > > > > > > > > @@ -347,6 +354,9 @@ static const struct of_device_id
> > > > > > > > > > > > sun4i_pwm_dt_ids[] =
> > > > > > > > > > > > {
> > > > > > > > > > > >
> > > > > > > > > > > >   }, {
> > > > > > > > > > > >
> > > > > > > > > > > >           .compatible = "allwinner,sun8i-h3-pwm",
> > > > > > > > > > > >           .data = &sun4i_pwm_single_bypass,
> > > > > > > > > > > >
> > > > > > > > > > > > + }, {
> > > > > > > > > > > > +         .compatible = "allwinner,sun50i-h6-pwm",
> > > > > > > > > > > > +         .data = &sun50i_pwm_dual_bypass_clk_rst,
> > > > > > > > > > >
> > > > > > > > > > > If you follow my suggestion for the two previous patches,
>
> (i.e. use devm_clk_get_optional instead of using devm_clk_get iff the
> compatible is allwinner,sun50i-h6-pwm; analogous for the reset
> controller.)
>
> > > > > > > > > > > you can just use:
> > > > > > > > > > >
> > > > > > > > > > >     compatible = "allwinner,sun50i-h6-pwm", "allwinner,sun5i-a10s-pwm";
> > > > > > > > > > >
> > > > > > > > > > > and drop this patch.
> > > > > > > > > >
> > > > > > > > > > Maxime found out that it's not compatible with A10s due to difference
> > > > > > > > > > in bypass bit, but yes, I know what you mean.
> > > > > > > > > >
> > > > > > > > > > Since H6 requires reset line and bus clock to be specified, it's not
> > > > > > > > > > compatible from DT binding side. New yaml based binding must somehow
> > > > > > > > > > know that in order to be able to validate DT node, so it needs
> > > > > > > > > > standalone compatible. However, depending on conclusions of other
> > > > > > > > > > discussions, this new compatible can be associated with already
> > > > > > > > > > available quirks structure or have it's own.
> > > > > > > > >
> > > > > > > > > I cannot follow. You should be able to specify in the binding that the
> > > > > > > > > reset line and bus clock is optional. Then allwinner,sun50i-h6-pwm
> > > > > > > > > without a reset line and bus clock also verifies, but this doesn't
> > > > > > > > > really hurt (and who knows, maybe the next allwinner chip needs exactly this).
> > > > > > > >
> > > > > > > > It is not optional. It will not work if either the clocks or reset controls
> > > > > > > > are missing. How would these be optional anyway? Either it's connected and
> > > > > > > > thus required, or it's not and therefore should be omitted from the description.
> > > > > > >
> > > > > > > [Just arguing about the clock here, the argumentation is analogous for
> > > > > > > the reset control.]
> > > > > > >
> > > > > > > From the driver's perspective it's optional: There are devices with and
> > > > > > > without a bus clock. This doesn't mean that you can just ignore this
> > > > > > > clock if it's specified. It's optional in the sense "If dt doesn't
> > > > > > > specify it, then assume this is a device that doesn't have it and so you
> > > > > > > don't need to handle it." but not in the sense "it doesn't matter if
> > > > > > > you handle it or not.".
> > > > > > >
> > > > > > > Other than that I'm on your side. So for example I think it's not
> > > > > > > optimal that gpiod_get_optional returns NULL if GPIOLIB=n or that
> > > > > > > devm_reset_control_get_optional returns NULL if RESET_CONTROLLER=n
> > > > > > > because this hides exactly the kind of problem you point out here.
> > > > > >
> > > > > > I think there's misunderstanding. I only argued that we can't use
> > > > > >
> > > > > > compatible = "allwinner,sun50i-h6-pwm", "allwinner,sun5i-a10s-pwm";
> > > > > >
> > > > > > as you suggested and only
> > > > > >
> > > > > > compatible = "allwinner,sun50i-h6-pwm";
> > > > > >
> > > > > > will work. Not because of driver itself (it can still use _optional()
> > > > > > variants), but because of DT binding, which should be able to validate H6
> > > > > > PWM node - reset and bus clock references are required in this case.
> > > > >
> > > > > I think I understood. In my eyes there is no need to let validation of
> > > > > the DT bindings catch a missing "optional" property that is needed on
> > > > > H6.
> > > > >
> > > > > You have to draw the line somewhere which information the driver has
> > > > > hard-coded and what is only provided by the device tree and just assumed
> > > > > to be correct by the driver. You argue the driver should know that
> > > >
> > > > No, in this thread I argue that DT validation tool, executed by
> > > >
> > > > make ARCH=arm64 dtbs_check
> > > >
> > > > should catch that. This is not a driver, but DT binding described in YAML.
> > >
> > > The argumentation is the same. dtbs_check doesn't notice if the base
> > > address of your "allwinner,sun50i-h6-pwm" device is wrong. So why should
> > > it catch a missing reset controller phandle?
> >
> > Of course checking actual values of node properties doesn't make sense in
> > dtbs_check, otherwise we would have million DT bindings. If you have 10 copies
> > of the same IP core, of course you would use same compatible, but actual
> > register ranges, interrupts, etc. would be different in DT nodes.
> >
> > At this point I would make same argument as were made before, but there is no
> > point going in circles. I'm interested what have DT maintainers to say.
>
> --
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20190730080900.hhxrqun7vk4nsj2h%40pengutronix.de.
