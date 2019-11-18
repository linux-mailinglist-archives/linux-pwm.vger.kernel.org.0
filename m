Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 247BB100661
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 14:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfKRNXV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 08:23:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39439 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfKRNXV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 08:23:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id l7so19444536wrp.6;
        Mon, 18 Nov 2019 05:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Fi408zecYZ+JxozjOtIUW0lemV9jQmGDB7s5YARwS4=;
        b=MXP6GE/s65zeyFbxCAQO8+XQ37PB8b9NTT+gYUaRizGiqk8dzMDnu1ZImZGS7+BU7+
         W5wL+EpoBz6WZJ1S1Cb0UlMVRkIjXo2mMz6rQ6EEtS0dh9NsjaIye0ZEAc0/syEAHWK4
         ctEGnHvvzoai9MhB9zz7JbZkVDKLsEgl3pKKiO8vwKbRNf+s7tDwZs5vq5iZgQvwcJCv
         xyPDK20qmVH1RLImk5ToTNQ4cz1QoU5guGC647j7AeYqgO80pUn+lWpu4xZrfMWga1AF
         +j7BuyAhA7/0jXrA4Kjt/WYlJ/VBgmt0/ehcsZqBHN0SmRAO9wcdm0qBloh4fzp+iPp2
         FDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Fi408zecYZ+JxozjOtIUW0lemV9jQmGDB7s5YARwS4=;
        b=AKibUZSnOngaSp23/RLUuGI79KM2dNMZBQm+wBowT8zoHdoHDgxVVl9wYfLaViOwec
         CJCQrun9Zs+7jDCRJfGcSHU3v1pgrgagaF1N7raIJJPsLMH/IkiNUD9EIjirn74FZBLY
         cdBEJMIpAlHmhf1Wn617YgTgGP4ufZFiPNvS1A2y7hdD4gn/eyqop/qIq1MYPhPt8W2W
         LL3vBzPl77mE2nDdGf/oQhugQzVEVU2AxqQrQxQZkgg0jZSpHvTCcTle3x9DtasVKZSG
         wweKpBnivCtjPjVtQDxL78RFzdFuuQca1sBIerTfPqO58rVUcaRN9aRO/FJd2es3WuAH
         pQ1Q==
X-Gm-Message-State: APjAAAWX1OmOA3ExRxB9WODEgKaDxhe/OZ6RnDUgfo6McnjRPQf0n2Qv
        wEU/Sr1Ya/E2lAUt65ccT8RTEkBkQPjubBWqHOw=
X-Google-Smtp-Source: APXvYqyo4y/agQzVtH2ECZnIYIOGEv1/ZBv1PJs0+BopW0iO5N/GQIYDUcjrFOcZYJWpd5uRqmvXsp8uSQF/TUlfCiA=
X-Received: by 2002:adf:da52:: with SMTP id r18mr30182195wrl.167.1574083397043;
 Mon, 18 Nov 2019 05:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20191118110034.19444-1-peron.clem@gmail.com> <20191118110034.19444-2-peron.clem@gmail.com>
 <20191118110640.GE4345@gilmour.lan> <CAJiuCceVyjSTGymOiXTZvyQXyXScGZuGS6gW+2=0gdxDFzg3dA@mail.gmail.com>
 <20191118125702.GK4345@gilmour.lan>
In-Reply-To: <20191118125702.GK4345@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 18 Nov 2019 14:23:05 +0100
Message-ID: <CAJiuCcfBurkmX-6j9T2JHsdUw+RGCnuBSYCpo5BG+V-H-mcLUw@mail.gmail.com>
Subject: Re: [PATCH v6 1/8] dt-bindings: pwm: allwinner: Add H6 PWM description
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Mon, 18 Nov 2019 at 13:57, Maxime Ripard <mripard@kernel.org> wrote:
>
> On Mon, Nov 18, 2019 at 01:42:48PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > Hi Maxime
> >
> > On Mon, 18 Nov 2019 at 12:06, Maxime Ripard <mripard@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Nov 18, 2019 at 12:00:27PM +0100, Cl=C3=A9ment P=C3=A9ron wro=
te:
> > > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > > >
> > > > H6 PWM block is basically the same as A20 PWM, except that it also =
has
> > > > bus clock and reset line which needs to be handled accordingly.
> > > >
> > > > Expand Allwinner PWM binding with H6 PWM specifics.
> > > >
> > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > > ---
> > > >  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 48 +++++++++++++++=
++++
> > > >  1 file changed, 48 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-=
a10-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pw=
m.yaml
> > > > index 0ac52f83a58c..1bae446febbb 100644
> > > > --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm=
.yaml
> > > > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm=
.yaml
> > > > @@ -30,13 +30,51 @@ properties:
> > > >        - items:
> > > >            - const: allwinner,sun50i-h5-pwm
> > > >            - const: allwinner,sun5i-a13-pwm
> > > > +      - const: allwinner,sun50i-h6-pwm
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > >
> > > >    clocks:
> > > > +    minItems: 1
> > > > +    maxItems: 2
> > > > +    items:
> > > > +      - description: Module Clock
> > > > +      - description: Bus Clock
> > > > +
> > > > +  # Even though it only applies to subschemas under the conditiona=
ls,
> > > > +  # not listing them here will trigger a warning because of the
> > > > +  # additionalsProperties set to false.
> > > > +  clock-names: true
> > > > +
> > > > +  resets:
> > > >      maxItems: 1
> > > >
> > > > +  if:
> > > > +    properties:
> > > > +      compatible:
> > > > +        contains:
> > > > +          const: allwinner,sun50i-h6-pwm
> > > > +
> > > > +  then:
> > > > +    properties:
> > > > +      clocks:
> > > > +        maxItems: 2
> > > > +
> > > > +      clock-names:
> > > > +        items:
> > > > +          - const: mod
> > > > +          - const: bus
> > > > +
> > > > +    required:
> > > > +      - clock-names
> > > > +      - resets
> > > > +
> > > > +  else:
> > > > +    properties:
> > > > +      clocks:
> > > > +        maxItems: 1
> > > > +
> > >
> > > Sorry for not noticing this earlier, but this should be at the topmos=
t
> > > level
> >
> > No problem, but I don't get what you want, (yaml format is new for me).
> > Do you mean I should put the if condition before the "resets" ?
>
> No, here if we condense a bit the file, we have something like:
>
> title: PWM
>
> properties:
>   compatible:
>     ...
>
>   ...
>
>   resets:
>     ...
>
>   if:
>     properties:
>       ...
>
>   then:
>     properties:
>       ...
>
> which means that you expect that the node may contain a compatible
> property, a resets one, and then two properties "if" and "then", which
> in turn contain properties (ie, two nodes).
>
> This is obviously not what you want, what you want instead is:
>
> properties:
>   compatible:
>     ...
>
>   ...
>
>   resets:
>     ...
>
> if:
>   properties:
>     ...
>
> then:
>   properties:
>     ...
>
> Which then describes that there's two properties, compatible and
> resets, and if the schema under 'if' is valid against the node we try
> to validate, the schema under 'then' is used to validate the node as
> well.
>
> I hope it's clearer,

Yes it's totally clear didn't see this bad indentation,
Thanks for the catch and for the explanation.

Regards,
Cl=C3=A9ment

> Maxime
