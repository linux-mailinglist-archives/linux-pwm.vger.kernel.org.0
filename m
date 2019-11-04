Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB08EE690
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2019 18:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfKDRtN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Nov 2019 12:49:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54720 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728188AbfKDRtN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Nov 2019 12:49:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id z26so4499951wmi.4;
        Mon, 04 Nov 2019 09:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p2xKl9sk3AGAtQ4LlnI3zNkpScq7gYHsvOfvGfAQyL4=;
        b=hDuEqnDhVk7kPLTfGLMq/WeOZAhbhSMAJJbCeOf+BLERB82koHBkKphxwkbknhDs3J
         Obr+dHWwQWzWiEy1P9TZaAGqTwD9QQLPDKlpSq2UeZQ72RKbsbQW2kmOjIH3jjybyQar
         jiapj0psw8heQmPX0/1XhGmakh5EQEDo03gownZn2neuCbngAF1WMIJ2w4VvaB7zLmNR
         smmZAcW1rzVodKEX6DURemUVuZhKbcuxtcg+h7b7+J/bdYiMga1q9epRQj6i+BVp/fOi
         AMd5GIZyPG55XP9KQuaqH6yfrfUaKokf2Rzc+DBfmeurrUhAuhXpu3805K50ix2tLlgm
         W4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p2xKl9sk3AGAtQ4LlnI3zNkpScq7gYHsvOfvGfAQyL4=;
        b=CVtqKNjqgd6vP6HKuofmGdQw0DDIUql6nM5ezs4/gFv4WQSLES8Tc2pGYhsTzpAOis
         zMb+w9/+pxGjM36pE+2fJwl74kr9+B0cJeyA8gKt78f9IPSiywRHJsu6lKwVTAhzY+3L
         L5lVB7aeFH9g3nV0w/h8QvuaqNR6TdjRj2b99RKJ6EYIP1n361yJrCa41wX3jPfhpaTS
         CzzCGPqAUt35L/8Rk+ukdgWRldJNE4JO3l3ELiF2PdTb/nDGu0QFuyYnFmJ8UkMlhfyq
         1W/7wEorUjKs4lP/Nm0stgoAOkxn/Yv4tZ481Ad92geZkPZEjgXvMJqLYHLS7TnEjcXn
         uDSg==
X-Gm-Message-State: APjAAAVwusJ7Pc5gXPwCF4CvXaYXvbjEmOVqLVAKx5QBusBpHX9h3SRU
        TSt3LCkkVoXi1fVfWkrWmPLaCZZJ75mXPN43J14=
X-Google-Smtp-Source: APXvYqwOHtKxgzOFlIXHimPJ2owhRc/to3TzER1kse9EqS8W/w1eEg9DUEJJUI1U5VQmdGnU3C50BansJnwSlPsMMA0=
X-Received: by 2002:a05:600c:228e:: with SMTP id 14mr241937wmf.119.1572889751662;
 Mon, 04 Nov 2019 09:49:11 -0800 (PST)
MIME-Version: 1.0
References: <20191103203334.10539-1-peron.clem@gmail.com> <20191103203334.10539-2-peron.clem@gmail.com>
 <20191104080359.6kjugbt3yi63ywhb@pengutronix.de>
In-Reply-To: <20191104080359.6kjugbt3yi63ywhb@pengutronix.de>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Mon, 4 Nov 2019 18:49:00 +0100
Message-ID: <CAJiuCccf3=McRfJ85SiudDHZ4nDOT+d7hh+nKDgC1u6nTpphPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: pwm: allwinner: Add H6 PWM description
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
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

On Mon, 4 Nov 2019 at 09:04, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Sun, Nov 03, 2019 at 09:33:28PM +0100, Cl=C3=A9ment P=C3=A9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 PWM block is basically the same as A20 PWM, except that it also has
> > bus clock and reset line which needs to be handled accordingly.
> >
> > Expand Allwinner PWM binding with H6 PWM specifics.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 45 ++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-=
pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.ya=
ml
> > index 0ac52f83a58c..bf36ea509f31 100644
> > --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yam=
l
> > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yam=
l
> > @@ -30,13 +30,46 @@ properties:
> >        - items:
> >            - const: allwinner,sun50i-h5-pwm
> >            - const: allwinner,sun5i-a13-pwm
> > +      - const: allwinner,sun50i-h6-pwm
> >
> >    reg:
> >      maxItems: 1
> >
> > -  clocks:
> > +  # Even though it only applies to subschemas under the conditionals,
> > +  # not listing them here will trigger a warning because of the
> > +  # additionalsProperties set to false.
> > +  clocks: true
> > +  clock-names: true
> > +  resets:
> >      maxItems: 1
> >
> > +  if:
> > +    properties:
> > +      compatible:
> > +        contains:
> > +          const: allwinner,sun50i-h6-pwm
> > +
> > +  then:
> > +    properties:
> > +      clocks:
> > +        items:
> > +          - description: Module Clock
> > +          - description: Bus Clock
> > +
> > +      clock-names:
> > +        items:
> > +          - const: mod
> > +          - const: bus
> > +
> > +    required:
> > +      - clock-names
> > +      - resets
> > +
> > +  else:
> > +    properties:
> > +      clocks:
> > +        maxItems: 1
> > +
>
> I guess this hunk says "If this is a allwinner,sun50i-h6-pwm, a mod and
> bus clock is required.", right?

Correct.
>
>
> I wonder if it is sensible to require a clock-names property in the else
> branch, too. This would make it obvious if the clock there corresponds
> to the "mod" or the "bus" clock on H6. (I guess it's "mod".)

This will also require to change example and all the current allwinner
device-tree that have a PWM declared.

Regards,
Cl=C3=A9ment

>
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  =
|
