Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E231005FA
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 13:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfKRM5H (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 07:57:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:38358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbfKRM5H (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 Nov 2019 07:57:07 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16E8420692;
        Mon, 18 Nov 2019 12:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574081825;
        bh=D42/XnP8BTkRdLMB0sfjNYCvjVmtv3XV0wVH/ObQtWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=REU+MnKH/jfxkLo0UnQ+ACUSgGSvJsHkc36Fgkosi60t+lPgSNnJ3EylqBANKsD18
         JOtPOTsrOh7xq4pZGrh+7YHfUTFV5SsvF9JIXJ+neHGWm0yVbFzVKLeCMWPH7cKdKz
         lqDfQPsr2yCymECD4z9NA08J7X595BC7WklnY5oU=
Date:   Mon, 18 Nov 2019 13:57:02 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
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
Subject: Re: [PATCH v6 1/8] dt-bindings: pwm: allwinner: Add H6 PWM
 description
Message-ID: <20191118125702.GK4345@gilmour.lan>
References: <20191118110034.19444-1-peron.clem@gmail.com>
 <20191118110034.19444-2-peron.clem@gmail.com>
 <20191118110640.GE4345@gilmour.lan>
 <CAJiuCceVyjSTGymOiXTZvyQXyXScGZuGS6gW+2=0gdxDFzg3dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="luUS5rQ1j20Qzq8E"
Content-Disposition: inline
In-Reply-To: <CAJiuCceVyjSTGymOiXTZvyQXyXScGZuGS6gW+2=0gdxDFzg3dA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--luUS5rQ1j20Qzq8E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2019 at 01:42:48PM +0100, Cl=E9ment P=E9ron wrote:
> Hi Maxime
>
> On Mon, 18 Nov 2019 at 12:06, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > Hi,
> >
> > On Mon, Nov 18, 2019 at 12:00:27PM +0100, Cl=E9ment P=E9ron wrote:
> > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > >
> > > H6 PWM block is basically the same as A20 PWM, except that it also has
> > > bus clock and reset line which needs to be handled accordingly.
> > >
> > > Expand Allwinner PWM binding with H6 PWM specifics.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> > > ---
> > >  .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml | 48 +++++++++++++++++=
++
> > >  1 file changed, 48 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a1=
0-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.=
yaml
> > > index 0ac52f83a58c..1bae446febbb 100644
> > > --- a/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.y=
aml
> > > +++ b/Documentation/devicetree/bindings/pwm/allwinner,sun4i-a10-pwm.y=
aml
> > > @@ -30,13 +30,51 @@ properties:
> > >        - items:
> > >            - const: allwinner,sun50i-h5-pwm
> > >            - const: allwinner,sun5i-a13-pwm
> > > +      - const: allwinner,sun50i-h6-pwm
> > >
> > >    reg:
> > >      maxItems: 1
> > >
> > >    clocks:
> > > +    minItems: 1
> > > +    maxItems: 2
> > > +    items:
> > > +      - description: Module Clock
> > > +      - description: Bus Clock
> > > +
> > > +  # Even though it only applies to subschemas under the conditionals,
> > > +  # not listing them here will trigger a warning because of the
> > > +  # additionalsProperties set to false.
> > > +  clock-names: true
> > > +
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
> > > +        maxItems: 2
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
> > Sorry for not noticing this earlier, but this should be at the topmost
> > level
>
> No problem, but I don't get what you want, (yaml format is new for me).
> Do you mean I should put the if condition before the "resets" ?

No, here if we condense a bit the file, we have something like:

title: PWM

properties:
  compatible:
    ...

  ...

  resets:
    ...

  if:
    properties:
      ...

  then:
    properties:
      ...

which means that you expect that the node may contain a compatible
property, a resets one, and then two properties "if" and "then", which
in turn contain properties (ie, two nodes).

This is obviously not what you want, what you want instead is:

properties:
  compatible:
    ...

  ...

  resets:
    ...

if:
  properties:
    ...

then:
  properties:
    ...

Which then describes that there's two properties, compatible and
resets, and if the schema under 'if' is valid against the node we try
to validate, the schema under 'then' is used to validate the node as
well.

I hope it's clearer,
Maxime

--luUS5rQ1j20Qzq8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXdKVHgAKCRDj7w1vZxhR
xRf+AQDIKDWmitZKrfNWWYoRdbyxBBWj5ixRoYR6aGpqSbCu9wEA5XGA6Ew4woTI
rOvVvGt0j8oafbBT1xQ/xkok13nHqAo=
=Y2SH
-----END PGP SIGNATURE-----

--luUS5rQ1j20Qzq8E--
