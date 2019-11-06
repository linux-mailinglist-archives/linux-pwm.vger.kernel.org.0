Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E61C9F121D
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Nov 2019 10:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfKFJZq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 6 Nov 2019 04:25:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35159 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfKFJZq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 6 Nov 2019 04:25:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id 8so2488747wmo.0;
        Wed, 06 Nov 2019 01:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZOJbwXEfRC32OcivT3s1o5LQP4VegomtuiAoRP6hxYA=;
        b=uSdRdcv3jeShjMmF5bqnACHCGtOE8ifA4CsrRxHIqqgtxQ/d12HF2mHz3rwOKh369v
         tu0OtHSk7IUdW2Es8R8/C1tQrVQ4Vz9ziK61IGiwfzCm1pTDWx+/ol0tTetP1VepH4t+
         gxBGHtExamDG8RAVJVOx39ihsTZgO5VX6noiLCwODHjpdcXmGdrZZ/hbzLAOB6PY3Afa
         /UoxdAfjQ/aC+cX1BfChQeM0rO9tTfbhh4f/rPvMD4RkhKDoHTtpr+vpntrP6zPenrmQ
         DkfgNbgc0Q+VWLmyPkeiAPhm57Yy3xjTZWcTEnKQ1qlSRPKTSFXW5AZ/NOk+e4dQwKmZ
         eXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZOJbwXEfRC32OcivT3s1o5LQP4VegomtuiAoRP6hxYA=;
        b=dhjIWVnWjXqKI6f7uoMZ7Lk/SMBAzTGK9MG5iakLwfZMuezqTiOqoaCw8o1Z8mwR86
         LzznIYWojAYmdA0eKmUus/8Ui4G1tnIfE2C9Q580WbfSRdaT3jnA4iY8+ig+Zx/qxVZC
         UCMQISGbAFVYPUfsaldL6DWFivCdJ9uYicv6h2pX8T0ENLQiAu9NFimdhojfAK4YYMTm
         iBstpRFVVfTy1qtaU6u+olg6yLkb+ErKrSncnes2cVgfRPgXkGqFlYN4Lu6kDnjOl9df
         Fc+PsaenbqVmPX59O19FaMaZJ6EgzLwyYfj4/xDHhiaG5cn16lN7fG6iAFJlj4xM03+/
         ELMQ==
X-Gm-Message-State: APjAAAU6ic6EAYJH/4qre3sy1955UzOcCb90qCsizJyojm4fM8rupqXy
        yDCK2C1MVJmd7sOUzVm0djbPVAl4pWpG79+Va1w=
X-Google-Smtp-Source: APXvYqwDNQcqlVPCyFV9lSCoMv7rDyFzRgqxYkaCN0CfxqAF1uaJ8P0S7puanFdFxDqIiquTmFnYtsUfsuz3l1taXL0=
X-Received: by 2002:a1c:a512:: with SMTP id o18mr1431731wme.4.1573032342346;
 Wed, 06 Nov 2019 01:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20191103203334.10539-1-peron.clem@gmail.com> <20191103203334.10539-2-peron.clem@gmail.com>
 <20191104080359.6kjugbt3yi63ywhb@pengutronix.de> <20191105111134.GG3876@gilmour.lan>
 <CAJiuCcc7sQvuPX+FTErXS+_RzUDvbDrB3Z5EX9wE_2EZaex0qw@mail.gmail.com> <20191105173208.GA46143@gilmour.lan>
In-Reply-To: <20191105173208.GA46143@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 6 Nov 2019 10:25:31 +0100
Message-ID: <CAJiuCcdQzXScxu=nOP6HaKyFK6Q--gvQubNR8wezTVvPctVf7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: pwm: allwinner: Add H6 PWM description
To:     Maxime Ripard <mripard@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Tue, 5 Nov 2019 at 18:32, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Tue, Nov 05, 2019 at 01:34:37PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > On Tue, 5 Nov 2019 at 12:11, Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > Hi Clement, Uwe,
> > >
> > > On Mon, Nov 04, 2019 at 09:03:59AM +0100, Uwe Kleine-K=C3=B6nig wrote=
:
> > > > On Sun, Nov 03, 2019 at 09:33:28PM +0100, Cl=C3=A9ment P=C3=A9ron w=
rote:
> > > > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > >
> > > > > H6 PWM block is basically the same as A20 PWM, except that it als=
o has
> > > > > bus clock and reset line which needs to be handled accordingly.
> > > > >
> > > > > Expand Allwinner PWM binding with H6 PWM specifics.
> > > > >
> > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > > ---
> > > > >  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 45 +++++++++++++=
+++++-
> > > > >  1 file changed, 44 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4=
i-a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-=
pwm.yaml
> > > > > index 0ac52f83a58c..bf36ea509f31 100644
> > > > > --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-p=
wm.yaml
> > > > > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-p=
wm.yaml
> > > > > @@ -30,13 +30,46 @@ properties:
> > > > >        - items:
> > > > >            - const: allwinner,sun50i-h5-pwm
> > > > >            - const: allwinner,sun5i-a13-pwm
> > > > > +      - const: allwinner,sun50i-h6-pwm
> > > > >
> > > > >    reg:
> > > > >      maxItems: 1
> > > > >
> > > > > -  clocks:
> > > > > +  # Even though it only applies to subschemas under the conditio=
nals,
> > > > > +  # not listing them here will trigger a warning because of the
> > > > > +  # additionalsProperties set to false.
> > > > > +  clocks: true
> > > > > +  clock-names: true
> > > > > +  resets:
> > > > >      maxItems: 1
> > > > >
> > > > > +  if:
> > > > > +    properties:
> > > > > +      compatible:
> > > > > +        contains:
> > > > > +          const: allwinner,sun50i-h6-pwm
> > > > > +
> > > > > +  then:
> > > > > +    properties:
> > > > > +      clocks:
> > > > > +        items:
> > > > > +          - description: Module Clock
> > > > > +          - description: Bus Clock
> > > > > +
> > > > > +      clock-names:
> > > > > +        items:
> > > > > +          - const: mod
> > > > > +          - const: bus
> > > > > +
> > > > > +    required:
> > > > > +      - clock-names
> > > > > +      - resets
> > > > > +
> > > > > +  else:
> > > > > +    properties:
> > > > > +      clocks:
> > > > > +        maxItems: 1
> > > > > +
> > > >
> > > > I guess this hunk says "If this is a allwinner,sun50i-h6-pwm, a mod=
 and
> > > > bus clock is required.", right?
> > > >
> > > > I wonder if it is sensible to require a clock-names property in the=
 else
> > > > branch, too. This would make it obvious if the clock there correspo=
nds
> > > > to the "mod" or the "bus" clock on H6. (I guess it's "mod".)
> > >
> > > This can be done a bit differently and could address your concerns
> > >
> > > Something like
> > >
> > > properties:
> > >   ...
> > >
> > >   clocks:
> > >     minItems: 1
> > >     maxItems: 2
> > >     items:
> > >       - description: Bus Clock
> > >       - description: Module Clock
> > >
> > > required:
> > >   - clocks
> > >
> > > if:
> > >   ...
> > >
> > > then:
> > >   properties:
> > >     clocks:
> > >       maxItems: 2
> >
> > Here we should set minItems to 2 right ?
> > so Max =3D Min =3D 2
>
> It's done automatically by the tooling when the other is missing.

Ok thanks,
I will update in v4.

Regards,
Cl=C3=A9ment

>
> Maxime
