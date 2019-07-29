Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7A307905D
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfG2QJ4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 29 Jul 2019 12:09:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33371 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfG2QJ4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 12:09:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id i11so59827452edq.0;
        Mon, 29 Jul 2019 09:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pUWi5s/lZaidbjPDb3R/qRFf6NikitzloPwYU7hh5ag=;
        b=K0EwT9/TQvIYCUplatwB/NMprp4oh2GRdPFlFT7mv8zMH68/cOhLkrW9SbuEbwO+vr
         UR+4eXRJOvktOG2J3EehRrS+8FDhzzzj5hEbMvrs4A5Id1RtzBI52TRuM13msrykZvcm
         k6ph6K7lBac7tOfN1oZP/iJbhovdRdVsx8VAxp6DuA0O1MfaYBk7//9kC4gTqQu7bTb9
         926F7s8CjXDpfuDYwPGw4HJwbgwoCSgQOTtPGBDPA9EueEnPZJY7KWNr11Ss3NLArOKl
         XRhHQrKbxqlCfdq7dgXwrFp/CiRDyRY5lpe4qHxibD9kEEnXhjiZ7NbC0TmDUX+wuSyD
         SR6A==
X-Gm-Message-State: APjAAAX1sz3HPc2YQVU+nWVJepzzK0D+VQ3wob/8lMoOe5+vQv+AlrD8
        T8QeBOGHOvfORDTJgwMkyLiBMZQWw00=
X-Google-Smtp-Source: APXvYqzSp7FCTLWEM0vT5hXT0+IF9s0L+mKE1cMmPASahDLhrzghfSPeMYbwppKt0QLnlWwno8W3hQ==
X-Received: by 2002:a17:906:401a:: with SMTP id v26mr86924427ejj.62.1564416593758;
        Mon, 29 Jul 2019 09:09:53 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id x11sm11665497eju.26.2019.07.29.09.09.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 09:09:53 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id x15so54395972wmj.3;
        Mon, 29 Jul 2019 09:09:53 -0700 (PDT)
X-Received: by 2002:a7b:cc04:: with SMTP id f4mr35947541wmh.125.1564416592986;
 Mon, 29 Jul 2019 09:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-5-jernej.skrabec@siol.net> <20190729064030.7uenld2kbof45zti@pengutronix.de>
 <223488703.0I5IR7NXoI@jernej-laptop> <20190729160723.am3cs5pasi22pibi@pengutronix.de>
In-Reply-To: <20190729160723.am3cs5pasi22pibi@pengutronix.de>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 30 Jul 2019 00:09:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v66C=ghjck6rxTg6Vt4xN2DcXntzVOa=KJWh98KRjkhnHQ@mail.gmail.com>
Message-ID: <CAGb2v66C=ghjck6rxTg6Vt4xN2DcXntzVOa=KJWh98KRjkhnHQ@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 30, 2019 at 12:07 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, Jul 29, 2019 at 05:55:52PM +0200, Jernej Škrabec wrote:
> > Hi Uwe,
> >
> > Dne ponedeljek, 29. julij 2019 ob 08:40:30 CEST je Uwe Kleine-König
> > napisal(a):
> > > On Fri, Jul 26, 2019 at 08:40:43PM +0200, Jernej Skrabec wrote:
> > > > Now that sun4i PWM driver supports deasserting reset line and enabling
> > > > bus clock, support for H6 PWM can be added.
> > > >
> > > > Note that while H6 PWM has two channels, only first one is wired to
> > > > output pin. Second channel is used as a clock source to companion AC200
> > > > chip which is bundled into same package.
> > > >
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > ---
> > > >
> > > >  drivers/pwm/pwm-sun4i.c | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >
> > > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > > index 7d3ac3f2dc3f..9e0eca79ff88 100644
> > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > @@ -331,6 +331,13 @@ static const struct sun4i_pwm_data
> > > > sun4i_pwm_single_bypass = {>
> > > >   .npwm = 1,
> > > >
> > > >  };
> > > >
> > > > +static const struct sun4i_pwm_data sun50i_pwm_dual_bypass_clk_rst = {
> > > > + .has_bus_clock = true,
> > > > + .has_prescaler_bypass = true,
> > > > + .has_reset = true,
> > > > + .npwm = 2,
> > > > +};
> > > > +
> > > >
> > > >  static const struct of_device_id sun4i_pwm_dt_ids[] = {
> > > >
> > > >   {
> > > >
> > > >           .compatible = "allwinner,sun4i-a10-pwm",
> > > >
> > > > @@ -347,6 +354,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] =
> > > > {
> > > >
> > > >   }, {
> > > >
> > > >           .compatible = "allwinner,sun8i-h3-pwm",
> > > >           .data = &sun4i_pwm_single_bypass,
> > > >
> > > > + }, {
> > > > +         .compatible = "allwinner,sun50i-h6-pwm",
> > > > +         .data = &sun50i_pwm_dual_bypass_clk_rst,
> > >
> > > If you follow my suggestion for the two previous patches, you can just
> > > use:
> > >
> > >     compatible = "allwinner,sun50i-h6-pwm", "allwinner,sun5i-a10s-pwm";
> > >
> > > and drop this patch.
> >
> > Maxime found out that it's not compatible with A10s due to difference in bypass
> > bit, but yes, I know what you mean.
> >
> > Since H6 requires reset line and bus clock to be specified, it's not compatible
> > from DT binding side. New yaml based binding must somehow know that in order
> > to be able to validate DT node, so it needs standalone compatible. However,
> > depending on conclusions of other discussions, this new compatible can be
> > associated with already available quirks structure or have it's own.
>
> I cannot follow. You should be able to specify in the binding that the
> reset line and bus clock is optional. Then allwinner,sun50i-h6-pwm
> without a reset line and bus clock also verifies, but this doesn't
> really hurt (and who knows, maybe the next allwinner chip needs exactly
> this).

It is not optional. It will not work if either the clocks or reset controls
are missing. How would these be optional anyway? Either it's connected and
thus required, or it's not and therefore should be omitted from the
description.

ChenYu
