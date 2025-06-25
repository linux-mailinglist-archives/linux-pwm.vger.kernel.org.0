Return-Path: <linux-pwm+bounces-6525-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DB3AE785C
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 09:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41FE37A9C07
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Jun 2025 07:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F8F126C05;
	Wed, 25 Jun 2025 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bADYCqdk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C33597E;
	Wed, 25 Jun 2025 07:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836002; cv=none; b=R2allyfr8NEtF38cD44RauNhcizOL+nS/6quMtTb0Z3K5QnMkMrHYA4c4OWpncrsRXGoDK0pO9/Tfj49RrgxGoxFgJ+b9tw4NqvoGAfgw9DvvES63VA80u6B12nUB7twjqk3z6Dhnak+fvVuUNHQI+as5qWFjX7zDPVJX2tF/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836002; c=relaxed/simple;
	bh=LuJi1VNE/G1vKjVvK+xAlqsoT8AAVna9tG+hj4b7RFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFuf9P37kYmfyA8eZuk6m8jsRwOk04Q/S+6pZ9IJSSHk/TJryGrjK/Xqv2w0njK7C8tqxLMt9MTVdNkoUdFS4u0kLPnUBwPyM4zAVKy5EbfzideMzd3qAHAydC92bTlDIXVlNjU9DsNKjOZt6oWvPbzZWzj9KYaRGlBerUuJ1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bADYCqdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A366C4CEEA;
	Wed, 25 Jun 2025 07:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750836002;
	bh=LuJi1VNE/G1vKjVvK+xAlqsoT8AAVna9tG+hj4b7RFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bADYCqdkD3ZNIf1+Eb8K3j67BIAQrorSJEnvXZKYAnnvvbYP+mHniMOxO6gBJjuli
	 XebWDmwLVmZEoykCEHg9YZXCMoMIMUDzcFECae4G/5vaDD/LdlThcb6R8O3jMEmvtf
	 3oOUKAvToc6y5KfhLLEm0n7nRHACLDlfUigQFIf8orGck+QDphJ79Qc3xoxT6bZbJt
	 AXhIwuE9hK6bEqhzGVQvSWEF4+oLzxft464zT3ZRmr0yaN8eJ6dqPHvvqvypBERWxi
	 tlJxyYt3oVxRd8jEcqHisL2g1D+opks5KFWxhI38eCu5tqIm5QOYKabDs/SG3nFgF6
	 YgYb/gzfDydvg==
Date: Wed, 25 Jun 2025 09:19:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pwm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v4 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
Message-ID: <n5euqjvuc6efyi3mums7ggmmmgycuda7ol5d6mz5htetqpebwl@6zumq5ruftee>
References: <20250621172056.160855-1-marek.vasut+renesas@mailbox.org>
 <20250621172056.160855-3-marek.vasut+renesas@mailbox.org>
 <purpjdp72jw2rok5ihyua635izyih54ufom2knsbaiwdd3jzgk@6wjf364fao2g>
 <dbec18f0-5df4-4eb8-93ab-da6ccfedf8ab@mailbox.org>
 <apbocxuzcptlpghphh7nchnwyxpfhmiwosgxrt4y5awsb67ar3@fbskfbulwsma>
 <033bbb7d-ab00-467e-ab21-877f76d027a2@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pbpjsoz762zsasuf"
Content-Disposition: inline
In-Reply-To: <033bbb7d-ab00-467e-ab21-877f76d027a2@mailbox.org>


--pbpjsoz762zsasuf
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/3] pwm: argon-fan-hat: Add Argon40 Fan HAT support
MIME-Version: 1.0

Hello Marek,

On Mon, Jun 23, 2025 at 10:44:28PM +0200, Marek Vasut wrote:
> On 6/23/25 9:53 PM, Uwe Kleine-K=F6nig wrote:
> > On Mon, Jun 23, 2025 at 07:30:33PM +0200, Marek Vasut wrote:
> > > On 6/23/25 11:11 AM, Uwe Kleine-K=F6nig wrote:
> > > > when I replied to v3 this v4 was already on the list which I missed=
=2E My
> > > > concern applies here, too, though.
> > > >=20
> > > > On Sat, Jun 21, 2025 at 07:19:56PM +0200, Marek Vasut wrote:
> > > > > +static void argon_fan_hat_i2c_shutdown(struct i2c_client *i2c)
> > > > > +{
> > > > > +	argon_fan_hat_write(i2c, 100);
> > > > > +}
> > > >=20
> > > > If you drop this, I'm willing to apply.
> > >=20
> > > Dropping this would make the hardware which uses this device more
> > > susceptible to thermal damage, e.g. in case it gets stuck during rebo=
ot and
> > > does not boot Linux afterward. I don't want to risk such thermal dama=
ge.
> >=20
> > We agree here. But the right place to address this is the pwm-fan
> > driver. A PWM is supposed to do exactly and only what its consumer wants
> > it to do (in the limits set by hardware). Officially a PWM driver
> > doesn't know the polarity of a fan, so `argon_fan_hat_write(i2c, 100)`
> > might fully enable or complete disable the fan. The fan-driver knows the
> > polarity. The PWM driver doesn't even know that it controls a fan. And
> > the next guy takes the argon device and controls a motor with it --- and
> > wonders that the vehicle gives full-speed at shutdown.
>=20
> I suspect this cannot happen without non-standard hardware change of this
> device, see the link which shows what this device is, it is an integrated
> PWM+fan device:
>=20
> Argon Fan HAT https://argon40.com/products/argon-fan-hat

I know people using hardware in different ways than specified by the
vendor, so this is a weak argument.

> > So I hope we also agree that the pwm-fan driver (or an even more generic
> > place if possible that applies to all fan drivers) is the right layer to
> > fix this. And note that the pwm-fan driver already has such a decision
> > implemented, it's just the wrong one from your POV as it disables the
> > fan at shutdown. For me this is another confirmation that having a
> > shutdown callback in the PWM driver is wrong. The two affected drivers
> > shouldn't fight about what is the right policy.
>=20
> I would fully agree with this argument for a generic PWM controller, but
> this isn't one, this is a combined PWM+fan device.

You model it as PWM + fan, and that's fine. I don't want special sauce
in the PWM driver part. And you don't need special sauce in the PWM
driver part to ensure the fan to spin up at shutdown.

> The PWM driver is the last one that is being shut down, it is being shut
> down after the pwm-fan driver.

Did you notice that the i2c bus driver is shut down still later? I
suggest to ensure there that the fan isn't disabled. /s

> If the pwm-fan driver fails for whatever
> reason, the PWM driver -- in this case driver for a combined PWM+fan devi=
ce
> -- should make sure that the hardware does not melt. So I would argue tha=
t,
> for this specific device, the shutdown hook here is correct.

The most likely problem in the pwm-fan driver is that the i2c bus is
broken, the pwm driver doesn't help here either. How far do you want to
go? Force the driver to =3Dy in .config? Probe it even when it's missing
in the device tree? Provide the fan device if PWM_FAN is disabled?

=46rom a software architecture POV splitting responsibilities to different
components is the right thing to do. This helps to keep maintainability
efforts within bounds, doesn't surprise developers that research the fan
behaviour and so check the fan driver, and increase reusability and
solving problems only once. Also the next PWM driver author creating an
i2c based PWM driver won't copy the shutdown hook from the argon40
driver which probably is even more wrong for that one.

> I would propose to keep the shutdown hook here, and extend the pwm-fan
> driver to be aligned with the behavior of the shutdown hook here. Does th=
at
> work for you ?

I stand to my request: Drop the shutdown hook and adapt the pwm-fan
driver to your needs.

Best regards
Uwe

--pbpjsoz762zsasuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhboxwACgkQj4D7WH0S
/k55+gf/dN2PkFx0Wau4xvX9qA+TxSD+j6m0BISKvrRoXw8iqySCwgDTSGju2eNX
HKV/G1PrOpE7iOayyfi7VFAuBprFzFjPluMFnt6k1pgR7jqVSzYKLqu9OrF+fNkO
W90XLEHRbCvEb/7p1xi03guEk2QCt3482DUpcRBelcxg7aVh3Blcl7tgK83ScJ0f
KasNtPZRwS8jqaACXamebkzVLPmAMYNzVO8FWwbOiyrZ/m2CCHYCNBe1XjiKryyZ
YOKHtchyyqUg7smGKBiW6hsmB1zPXjYGYXvDAyryurIC+4WX88doAbJ284P3fwyI
MYSqSjxpZp5ZIIGWuhO7q/m9p2i9nw==
=l2Zr
-----END PGP SIGNATURE-----

--pbpjsoz762zsasuf--

