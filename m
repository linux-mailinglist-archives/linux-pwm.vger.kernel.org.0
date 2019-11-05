Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0ADEFD2D
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 13:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388049AbfKEMev (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 07:34:51 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54262 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387744AbfKEMev (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 07:34:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id x4so9556905wmi.3;
        Tue, 05 Nov 2019 04:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uXDWMsp5qvVlHIVMxPVb2fsrIl1aloFJ+doxLS5hVLU=;
        b=XWLAY/tT9UADwTl92xmE3tOUHaT4sD3761TLXhMGIk74SGtCX8Hy6pfaiZiCsNnSfM
         kyecKhsvFggXdcfzTFcq8MnDlzOwDZ6u2WFeKaSD9kexaCcYEPayqcvkgEsxZtd+DGZ+
         dSc67hY54a5/yjv8WFht9F6gO/9gj8WbJ62dcM9TByXAPxPDsS3ymi92JOXtl1+rjBvj
         Ep/DAnTg53X4oJXJKuvvWG/+DZcInFCfHhZtfaUnlMpFifqeoEi9m+r+4yew5jUxWOXW
         Vcv98KvzLv5Y0NqX19D5zaEUtajaNW5G+GgLLJKbfNflvbHaiBaKKUUQTKVy9ATYrDWN
         UfEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uXDWMsp5qvVlHIVMxPVb2fsrIl1aloFJ+doxLS5hVLU=;
        b=g+1oyk/Vb7lsr9hu5sYAMBu8w1vwr9AIzES6Cop3fBfvuAtgVT+BDL9X88hNvObT3G
         PMuTN1hjPJm9R4IZj/JUT1s4wqQzRl4rgt8+0EE2TrPK8sdT+B6ogzEmxKBIpAkbtMPa
         emcymNizMBIxNq5M/8UKd3QKQUROKba4q1sGjLKd7kaHud8AOBOAYifP9bI25hKzi5PD
         fnxOtsGMLLpqY4u3rCIZPJh7eWf1CXNFuuUr2I0w64K160AV8/j+n56Tw9sRXBOp3ROy
         Bie4Dhn2oKDPlFrFKliNGTyvbvk8fz1yin0rIySIqBi/1l9/cDTWoTaXPZPsrVVKLNvm
         HNJA==
X-Gm-Message-State: APjAAAWtTi814NZRuAFyoMyHuj/EbmjgC+vmk1O9V9AemBOb0ItsN7kg
        y33cyWBNbPEXA8Qri+pYFUTgA1SdqhgC/5py9H4=
X-Google-Smtp-Source: APXvYqx2VTjX7SpCQ9bFbyLIvq0HI/5gSO9syMahnkO6f1EAMR8g0VgtqPCSwcYkRvXnLfPvgMsRFdEEsyBOBDbtRhQ=
X-Received: by 2002:a05:600c:228e:: with SMTP id 14mr3817629wmf.119.1572957288363;
 Tue, 05 Nov 2019 04:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20191103203334.10539-1-peron.clem@gmail.com> <20191103203334.10539-2-peron.clem@gmail.com>
 <20191104080359.6kjugbt3yi63ywhb@pengutronix.de> <20191105111134.GG3876@gilmour.lan>
In-Reply-To: <20191105111134.GG3876@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 5 Nov 2019 13:34:37 +0100
Message-ID: <CAJiuCcc7sQvuPX+FTErXS+_RzUDvbDrB3Z5EX9wE_2EZaex0qw@mail.gmail.com>
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

Hi Maxime,

On Tue, 5 Nov 2019 at 12:11, Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi Clement, Uwe,
>
> On Mon, Nov 04, 2019 at 09:03:59AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> > On Sun, Nov 03, 2019 at 09:33:28PM +0100, Cl=C3=A9ment P=C3=A9ron wrote=
:
> > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > >
> > > H6 PWM block is basically the same as A20 PWM, except that it also ha=
s
> > > bus clock and reset line which needs to be handled accordingly.
> > >
> > > Expand Allwinner PWM binding with H6 PWM specifics.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > ---
> > >  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 45 +++++++++++++++++=
+-
> > >  1 file changed, 44 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a1=
0-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.=
yaml
> > > index 0ac52f83a58c..bf36ea509f31 100644
> > > --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.y=
aml
> > > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.y=
aml
> > > @@ -30,13 +30,46 @@ properties:
> > >        - items:
> > >            - const: allwinner,sun50i-h5-pwm
> > >            - const: allwinner,sun5i-a13-pwm
> > > +      - const: allwinner,sun50i-h6-pwm
> > >
> > >    reg:
> > >      maxItems: 1
> > >
> > > -  clocks:
> > > +  # Even though it only applies to subschemas under the conditionals=
,
> > > +  # not listing them here will trigger a warning because of the
> > > +  # additionalsProperties set to false.
> > > +  clocks: true
> > > +  clock-names: true
> > > +  resets:
> > >      maxItems: 1
> > >
> > > +  if:
> > > +    properties:
> > > +      compatible:
> > > +        contains:
> > > +          const: allwinner,sun50i-h6-pwm
> > > +
> > > +  then:
> > > +    properties:
> > > +      clocks:
> > > +        items:
> > > +          - description: Module Clock
> > > +          - description: Bus Clock
> > > +
> > > +      clock-names:
> > > +        items:
> > > +          - const: mod
> > > +          - const: bus
> > > +
> > > +    required:
> > > +      - clock-names
> > > +      - resets
> > > +
> > > +  else:
> > > +    properties:
> > > +      clocks:
> > > +        maxItems: 1
> > > +
> >
> > I guess this hunk says "If this is a allwinner,sun50i-h6-pwm, a mod and
> > bus clock is required.", right?
> >
> > I wonder if it is sensible to require a clock-names property in the els=
e
> > branch, too. This would make it obvious if the clock there corresponds
> > to the "mod" or the "bus" clock on H6. (I guess it's "mod".)
>
> This can be done a bit differently and could address your concerns
>
> Something like
>
> properties:
>   ...
>
>   clocks:
>     minItems: 1
>     maxItems: 2
>     items:
>       - description: Bus Clock
>       - description: Module Clock
>
> required:
>   - clocks
>
> if:
>   ...
>
> then:
>   properties:
>     clocks:
>       maxItems: 2

Here we should set minItems to 2 right ?
so Max =3D Min =3D 2

Regards,
Cl=C3=A9ment

>
>     clocks-names:
>       items:
>         - const: mod
>         - const: bus
>
>     required:
>       - clock-names
>
> else:
>   properties:
>     clocks:
>       maxItems: 1
>
> That way, the definition of the order and which clock is which is
> pretty obvious in both cases, and we don't get any weird warnings.
>
> Maxime
