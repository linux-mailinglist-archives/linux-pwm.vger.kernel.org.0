Return-Path: <linux-pwm+bounces-2190-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BC78CA2D2
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 21:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20DF6281248
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 19:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FE31F941;
	Mon, 20 May 2024 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLA5TykB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46C71E878;
	Mon, 20 May 2024 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234096; cv=none; b=JDgIjsIJtURyzH7Yb8tniFsVvqcdVoWYAxKp2Tm4VmtFgJMOJQEtAm5ZHGu+wpJV+zDYT6w5Ci1RxlPB/bks+ZnAS6oba9BLXP7I6YmCmkqq/9JyBoDTmqai1F+Ipp8m4gpoIj+LTCiHn22OjQDDkeDfDJvFsqQKAeMi3g+ZFH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234096; c=relaxed/simple;
	bh=ad/ng2ZfVJZUt5PIHKSAUXGS1BayQ+Hcf7vtMyIKGJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lX7NQloFx4VpAvCN4amnm3hh4McwgGAhYlhDoPXjIYjrzCH7JfG6EnjJn8ZM9qanZzZRFxioMlVa7qzztKATJ/ucW12NiN5UEJS1vCiJLR/x0Pa2eYNMUfsBeR8npIdPnCVxiY4WdQGvo8OIGaB/OZ39PMrFKtHJTSGFCH+LIHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLA5TykB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6E2C2BD10;
	Mon, 20 May 2024 19:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716234095;
	bh=ad/ng2ZfVJZUt5PIHKSAUXGS1BayQ+Hcf7vtMyIKGJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JLA5TykBP9W7YuF4TUzV+f0T4WKzyYSwK65imF+k9wOT6AMlZmS9DqIHOJvCKREQL
	 h54VCE50/Ljzd6xwdttjXVd7A/KlLAK/pVlCWkLCenAxGuSQdo4bxuHWqb9EMDhnmu
	 L72ztfunxdQiF3ueYTWUSWDP6mtN1GHpOC2xX0mYE4OmEEIlkoeSCfHM3w1dbrLT/G
	 vz5y8fXIGRmVnblqmCIDJWSUqaVGb0NH8vOyzLdIEKNJIECVa9aOuIFYKLTMt9j2DP
	 9JRjUI0a2y28vCNTI9EFV40XErzS0L7EGfnomRUcAyQPYWYqe6E36yR0ltBvdiuEyS
	 rVWLPkz3G2xyQ==
Date: Mon, 20 May 2024 20:41:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, jdelvare@suse.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	ukleinek@kernel.org, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Message-ID: <20240520-badly-islamist-dcae9fe1303b@spud>
References: <20240520030321.3756604-1-chris.packham@alliedtelesis.co.nz>
 <20240520030321.3756604-2-chris.packham@alliedtelesis.co.nz>
 <20240520-pendant-charity-a66a8d738690@spud>
 <62c3c546-5172-4417-a15a-d13419d42be3@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EwebWdOmCCvPoTdW"
Content-Disposition: inline
In-Reply-To: <62c3c546-5172-4417-a15a-d13419d42be3@roeck-us.net>


--EwebWdOmCCvPoTdW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 12:03:42PM -0700, Guenter Roeck wrote:
> On 5/20/24 09:49, Conor Dooley wrote:
> > On Mon, May 20, 2024 at 03:03:19PM +1200, Chris Packham wrote:
> > > Add fan child nodes that allow describing the connections for the
> > > ADT7475 to the fans it controls. This also allows setting some
> > > initial values for the pwm duty cycle and frequency.
> > >=20
> > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > > ---
> > >=20
> > > Notes:
> > >      Changes in v3:
> > >      - Use the pwm provider/consumer bindings
> > >      Changes in v2:
> > >      - Document 0 as a valid value (leaves hardware as-is)
> > >=20
> > >   .../devicetree/bindings/hwmon/adt7475.yaml    | 25 ++++++++++++++++=
++-
> > >   1 file changed, 24 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/D=
ocumentation/devicetree/bindings/hwmon/adt7475.yaml
> > > index 051c976ab711..99bd689ae0cd 100644
> > > --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> > > +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> > > @@ -51,6 +51,15 @@ properties:
> > >         enum: [0, 1]
> > >         default: 1
> > > +  "#pwm-cells":
> > > +    const: 4
> > > +    description: |
> > > +      Number of cells in a PWM specifier.
> > > +      - 0: The pwm channel
> > > +      - 1: The pwm frequency in hertz - 0, 11, 14, 22, 29, 35, 44, 5=
8, 88, 22500
> >=20
> > The standard binding is period in nanoseconds, not frequency in Hz.
> > What's gained from deviating from that?
> >=20
>=20
> I'd strongly suspect that Chris didn't know and didn't expect it,
> just like me.

I did point out on v2 that the information on the standard binding was
in pwm.txt, but I also said "order it has <index freq flags duty>" which
likely didn't help. I did however CC you both on a patch the other day
where I fixed pwm.yaml so that it actually contained the information on
what the cells represented.
> > > +      - 2: PWM flags 0 or PWM_POLARITY_INVERTED
> > > +      - 3: The default pwm duty cycle - 0-255
> >=20
> > Same here I guess, why not match the units used for the period for the
> > duty cycle?
> >=20
>=20
> Same here. I am used to pwm frequency in Hz and duty cycle as percentage.
> Using the period instead is somewhat unusual, and I must admit that I
> have never encountered it while dealing with a variety of fan controllers.

If it is what makes sense to use, because it's what everyone and their
mother documents, then sure. My rationale I suppose was threefold:
- Consistency with the period
- Time would be more portable between providers, if 8 bits of precision
  is deemed insufficient for some providers.
- Last & least, the PWM APIs in the kernel use time for the dutycycle

If you're going to use percentages rather than time, would it not
make more sense to either use percent itself with a 0-100 range or use
basis points if percent doesn't provide sufficient granularity?

I think it'd be good of Uwe chimed in, given we're discussing a PWM
provider binding after all.

> Just to make sure I understand this correctly - duty cycles would

s/duty cycles/periods/

> be (rounded):
>=20
> Hz	ns
> 11	90,909,091
> 14	71,428,571
> 22	45,454,545
> 29:	34,482,759
> 35:	28,571,429
> 44:	22,727,273
> 58:	17,241,379
> 88:	11,363,636
> 22500	44,444
>=20
> Examples for duty cycles would be
>=20
> 20%: 0,2s or 200,000,000
> 50%: 0.5s or 500,000,000
> 80%: 0.8s or 800,000,000
>=20
> Is that correct ?

Assuming a 1 second period, those look as expected.

Cheers,
Conor.


--EwebWdOmCCvPoTdW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZkunawAKCRB4tDGHoIJi
0teKAP9QTzAM4I9Knk/VlftfV7eyBojkQ7JhiscMPJjToa6SRwEAhBt2VrLVWnNN
mXPi0eWlRwYyQS6o04gwdQPgcfbFjgE=
=Mg3Z
-----END PGP SIGNATURE-----

--EwebWdOmCCvPoTdW--

