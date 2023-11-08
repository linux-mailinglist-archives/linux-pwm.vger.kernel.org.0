Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0251F7E5665
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Nov 2023 13:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjKHMiA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Nov 2023 07:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjKHMiA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Nov 2023 07:38:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412CD1BF2
        for <linux-pwm@vger.kernel.org>; Wed,  8 Nov 2023 04:37:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A859C433C8;
        Wed,  8 Nov 2023 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699447077;
        bh=Nbl715uHuDfn/0nWvvjyrAkfUOeRaffc0nWTyED+I84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDnVBLYqCKdpQTiMGYKQlHU+ljm3pEu6Ye6L6tARUOImAi5r7O1j+48rtPF9QpoST
         LJkkRS7ARKlzDhCibIUkr23wdL2MXYTZibFGXUvMWJ94T/ejeOlfLHSxdzTAzEbAHx
         4/Hf7ApkO0aWzRJpwNARHSzIZ3wqn/w5mHaoLOt+kH3wS3/TXDI4ja1vLehJHuu+Ty
         wK3t9FlM7H/K6oAm1Wqnf5laExgDvrm2naewjTIuaJXMzbCkkKTiGfUwl8my2Cz1sQ
         2Dv3XCWCEdHH98ugCkSMIGZi7j83KtW8+9vSStjL+hXbhxj+r+qYxN9O/509SybPy3
         k076D7xNBJeBQ==
Date:   Wed, 8 Nov 2023 12:37:52 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pwm: imx-pwm: Unify #pwm-cells for
 all compatibles
Message-ID: <20231108-wisdom-overall-753fbb76ac74@spud>
References: <20231106151326.812099-1-alexander.stein@ew.tq-group.com>
 <20231106151326.812099-2-alexander.stein@ew.tq-group.com>
 <20231106153926.dqvx56fegqpmw3k7@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/OQ5+urFAx7r7TQ3"
Content-Disposition: inline
In-Reply-To: <20231106153926.dqvx56fegqpmw3k7@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


--/OQ5+urFAx7r7TQ3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 04:39:26PM +0100, Uwe Kleine-K=F6nig wrote:
> On Mon, Nov 06, 2023 at 04:13:24PM +0100, Alexander Stein wrote:
> > Use #pwm-cells for all i.MX variants. Only fsl,imx1-pwm does not support
> > inverted PWM output. Keep it the same for consistency.
> >=20
> > Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Docum=
entation/devicetree/bindings/pwm/imx-pwm.yaml
> > index c01dff3b7f843..a84a240a61dc1 100644
> > --- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
> > @@ -14,12 +14,10 @@ allOf:
> > =20
> >  properties:
> >    "#pwm-cells":
> > -    description: |
> > -      Should be 2 for i.MX1 and 3 for i.MX27 and newer SoCs. See pwm.y=
aml
> > -      in this directory for a description of the cells format.
> > -    enum:
> > -      - 2
> > -      - 3
> > +    description:
> > +      The only third cell flag supported by this binding is
> > +      PWM_POLARITY_INVERTED. fsl,imx1-pwm does not support this flags.
> > +    const: 3
>=20
> You dropped the | from the description line, but with my understanding
> of yaml this should be fine.

Ya, it was not required there in the first place.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--/OQ5+urFAx7r7TQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUuBIAAKCRB4tDGHoIJi
0kpEAQD4tcfU6SMHTCcjORQdg7Gi2jg8AfMju13nkqlCsBldCgEA09z3EDTevezq
dIIrGwZTEfQqVKQpOQLX5G91WcLLZA4=
=NvpP
-----END PGP SIGNATURE-----

--/OQ5+urFAx7r7TQ3--
