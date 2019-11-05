Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1B6EFC1B
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 12:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbfKELLj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 06:11:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:60224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388494AbfKELLj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 5 Nov 2019 06:11:39 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4BA820869;
        Tue,  5 Nov 2019 11:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572952297;
        bh=L0MQuT4XYxAFwm79QAhiL05f/SdnH/s1jkfSPz113BE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yl1o9f4oD62go+SoZTI/xdBt6WJXvvuOwVzpe7vPn+ctS79K7B1/M8YvcKQlgyXiJ
         BE2CNaKz1BaPD3A6kklxIl+zEHlVAvYshsIDdrpTGwnP16AI0jIK7jzvyj0RyhME5g
         DlR6EqbQDkkEYmG8eIj2b92ZyKXifryUwNnjalY8=
Date:   Tue, 5 Nov 2019 12:11:34 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>, kernel@pengutronix.de
Subject: Re: [PATCH v2 1/7] dt-bindings: pwm: allwinner: Add H6 PWM
 description
Message-ID: <20191105111134.GG3876@gilmour.lan>
References: <20191103203334.10539-1-peron.clem@gmail.com>
 <20191103203334.10539-2-peron.clem@gmail.com>
 <20191104080359.6kjugbt3yi63ywhb@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline
In-Reply-To: <20191104080359.6kjugbt3yi63ywhb@pengutronix.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Clement, Uwe,

On Mon, Nov 04, 2019 at 09:03:59AM +0100, Uwe Kleine-K=F6nig wrote:
> On Sun, Nov 03, 2019 at 09:33:28PM +0100, Cl=E9ment P=E9ron wrote:
> > From: Jernej Skrabec <jernej.skrabec@siol.net>
> >
> > H6 PWM block is basically the same as A20 PWM, except that it also has
> > bus clock and reset line which needs to be handled accordingly.
> >
> > Expand Allwinner PWM binding with H6 PWM specifics.
> >
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> > ---
> >  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 45 ++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-=
pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.ya=
ml
> > index 0ac52f83a58c..bf36ea509f31 100644
> > --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.yaml
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
>
> I wonder if it is sensible to require a clock-names property in the else
> branch, too. This would make it obvious if the clock there corresponds
> to the "mod" or the "bus" clock on H6. (I guess it's "mod".)

This can be done a bit differently and could address your concerns

Something like

properties:
  ...

  clocks:
    minItems: 1
    maxItems: 2
    items:
      - description: Bus Clock
      - description: Module Clock

required:
  - clocks

if:
  ...

then:
  properties:
    clocks:
      maxItems: 2

    clocks-names:
      items:
        - const: mod
        - const: bus

    required:
      - clock-names

else:
  properties:
    clocks:
      maxItems: 1

That way, the definition of the order and which clock is which is
pretty obvious in both cases, and we don't get any weird warnings.

Maxime
--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXcFY5gAKCRDj7w1vZxhR
xbV/AQCe7CHt/mkieAm/L+E98h/loKt0hEB6kyNqdnXH0QKxZAEA3BWTeLZyVpFc
GGWBi+MvM8vrJsH5MAMILsm76CTF6QE=
=GzAC
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--
