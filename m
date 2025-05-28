Return-Path: <linux-pwm+bounces-6158-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFD6AC61AC
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 08:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135B57A99DF
	for <lists+linux-pwm@lfdr.de>; Wed, 28 May 2025 06:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3305020FAAB;
	Wed, 28 May 2025 06:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKlu/j8q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EC2A31;
	Wed, 28 May 2025 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748412657; cv=none; b=ZytCt7fYP1qqlLMXV6cr1cFRWV6YdJgsTupbGywsCNnD1gmthjPO4kUeXz/c/ZYlBkeAQwEJ6UoqgQg9ajem6zc3BOkm0Ca3GhrXFfMXloTrvI1uUohU+SfGkSkUOxPPO+7/+QA1bYvyE4Pg1lsFXwl2W7rEqjjZ+GWtdXfQBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748412657; c=relaxed/simple;
	bh=jH2Cq7YV8yLvjOewDtu4tyy+E+bC0DKt+7ChlxEimgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6wGRt7rUCTXCxRiQpd4e6IRajOvUdFvrdcNMup9BDc6tBAKlJciKTDSNnHHpbu7tgVVuQR4FGm/8WigR4iqf3um8NtcqZ4wNsuqfOw9oEAmYCGHHntFTqEcZAGmBYE4EKmNSI60daGucuz1Gni45v/BDfi6iEua8EJ+qalF/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKlu/j8q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B7BC4CEE7;
	Wed, 28 May 2025 06:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748412656;
	bh=jH2Cq7YV8yLvjOewDtu4tyy+E+bC0DKt+7ChlxEimgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uKlu/j8qJ65xeJNnER7iR3pSijmQsKFz93K+9GB7xwhY+HRW3WXj5UJ+UHmYlmW4K
	 Cx2rZO32eYUW7+TFpgME9vhFZMV4V/Is58gM9w25sJdMSO8eVqHsugIior6NypgjBE
	 kwet92jXAOnsARnh+OlcAYUlVsvZMnsb+zQTVQNRRzjNmDWedK3QcWJ7lJT0OCYkO3
	 PCuqNUx0/tq+1QXmvhQCUUfPqtksEVv6DG1CmtR6KAR6eHzxK5pF5wISa5msTHRdMz
	 RPFr6xCV/kAiIHjM0Qw1JDnWJQT7YSKga3AJE/z+/gkNHER2m8xsoTebTZeT4iyEgs
	 TwFagyQ1MtUhA==
Date: Wed, 28 May 2025 08:10:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>, 
	"linux@roeck-us.net" <linux@roeck-us.net>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Message-ID: <jmxmxzzfyobuheqe75lj7qcq5rlt625wddb3rlhiernunjdodu@tgxghvfef4tl>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
 <20240722221737.3407958-2-chris.packham@alliedtelesis.co.nz>
 <jzxu6mcbxf5zwyirnb2jjpm2i7sln3v5mz3gyhc5xhpqexicvb@atrcjvh7wuh5>
 <bc99a27e-74ec-45a0-b77c-48f993269586@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wxa3sx6tfxbdtvfo"
Content-Disposition: inline
In-Reply-To: <bc99a27e-74ec-45a0-b77c-48f993269586@alliedtelesis.co.nz>


--wxa3sx6tfxbdtvfo
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
MIME-Version: 1.0

Hello Chris,

On Tue, May 27, 2025 at 08:24:56PM +0000, Chris Packham wrote:
> On 28/05/2025 04:12, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >
> > On Tue, Jul 23, 2024 at 10:17:35AM +1200, Chris Packham wrote:
> >> Add fan child nodes that allow describing the connections for the
> >> ADT7475 to the fans it controls. This also allows setting some
> >> initial values for the pwm duty cycle and frequency.
> >>
> >> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> >> ---
> >>
> >> Notes:
> >>      Changes in v7:
> >>      - None
> >>      Changes in v6:
> >>      - Collect r-by from Rob
> >>      Changes in v5:
> >>      - Use nanoseconds for PWM frequency and duty cycle as per existing
> >>        conventions for PWMs
> >>      - Set flags to 0 in example to match adi,pwm-active-state setting
> >>      Changes in v4:
> >>      - 0 is not a valid frequency value
> >>      Changes in v3:
> >>      - Use the pwm provider/consumer bindings
> >>      Changes in v2:
> >>      - Document 0 as a valid value (leaves hardware as-is)
> >>
> >>   .../devicetree/bindings/hwmon/adt7475.yaml    | 35 +++++++++++++++++=
+-
> >>   1 file changed, 34 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Do=
cumentation/devicetree/bindings/hwmon/adt7475.yaml
> >> index 051c976ab711..df2b5b889e4d 100644
> >> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> >> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> >> @@ -51,6 +51,24 @@ properties:
> >>         enum: [0, 1]
> >>         default: 1
> >>  =20
> >> +  "#pwm-cells":
> >> +    const: 4
> > I asked to add support for #pwm-cells =3D <4> to the pwm core in reply =
to
> > v4 (see
> > https://lore.kernel.org/linux-pwm/drqvaon5lb2ei3jqofutbr6demibyfdhbmr24=
sva27gzpqdnon@fxa7rpl33iih/).
> >
> > I'm unhappy to see this merged anyhow in combination with ad-hoc parsing
> > of the pwm properties in the driver :-\
>=20
> As I mentioned at the time the adt7475 is not currently pwm_chip so I=20
> need the ad-hoc parsing in that driver. I'd be happy to take you=20
> prototype patch for pwm/core.c and polish it although I don't really=20
> have a good way of testing it.

It's more the deviation of the default binding for PWMs that I don't
like than the ad-hoc parsing. Ideally the adt7475 would provide a
pwmchip (as the binding suggests) and the fan would be formalized as a
pwm-fan. With the binding that was chosen here that option becomes more
ugly than necessary to implement.

If I understand correctly you need the default value for duty to
statically setup (or only initialize?) a fan, right? I'm not sure I like
extending #pwm-cells for a default duty value. Thinking about that a
while I'd prefer a binding that looks more like the clock configuration
stuff because actually having the period and flags as part of the
reference to the PWM to be used is also a bit strange. So I imagine
something like:

	mypwm: pwm {
		compatible =3D "...."
		#pwm-cells =3D <1>;
	};

	fan {
		compatible =3D "pwm-fan";
		pwms =3D <&mypwm 1>;
		assigned-pwms =3D <&mypwm>;
		assigned-pwm-default-period-lengths-ns =3D <40000>;
		assigned-pwm-default-flags =3D <PWM_POLARITY_INVERTED>;
	};

Then specifying a period (or later a duty cycle length) would be
optional and could be provided iff the device needs that for operation.

My mail was just me being frustrated about another special case that I'd
have to handle if I go into that direction. I should have been more
attentive to that development before it entered the mainline.

Best regards
Uwe

--wxa3sx6tfxbdtvfo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg2qOoACgkQj4D7WH0S
/k4HoAf/W31Z4loGE2bUUh7hYXL033+ZSkiDovri3L9xXm1QF6gBQQY90puK34GB
NOsiUfSwvpC/L+KEVXEt9yfZBtnLgWUJ3TMUe9lD5qfKMYCmYOvX4o7w1aOh8MFg
WooJVj7+Drw5GZaUJ0kGQSGfAez9Wqkf5W+Nc3T9/w7QZJR+71P9he8kgH+SnCJz
9h3TIFdx1gfLt34TCbUq5U6kwD56HAwfoMJNEpqqkAgXqsl/dMVwUeLP6lH/AMW1
9UmyWv7k1wlO2NB4FMxJbZfUQshyuwfjR/AwUJX2f5KIsYUy9BGiWsrI4MY6ZC4X
HtAgo7VzBcReQ83B6l+YF6lR74QDzQ==
=0PfT
-----END PGP SIGNATURE-----

--wxa3sx6tfxbdtvfo--

