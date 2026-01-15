Return-Path: <linux-pwm+bounces-7911-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC500D25C83
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 17:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4FC3C30019C4
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60972C11CA;
	Thu, 15 Jan 2026 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eusNISs0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D73A1E77;
	Thu, 15 Jan 2026 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768495055; cv=none; b=r+s5GEVopT78/1mcq9Jy0WwXTg0lGQ5PWlUFS08ONq2bUTl+56P6qIeAT9cfsTeJ/kk8cNjMiuYsI/mNI4fqbRYyHAZLps2V58NUq+D7p6DZa0OdsbVlm83KHVuvd2CKwlzGWJU2M5MXwTLo0rnqlcC0cTSOscz8QtPsmiZObNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768495055; c=relaxed/simple;
	bh=1++S04BfsZ4kNdUF/obcwax38D/1M1lsT8MCZfkO7Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UZnyxrvTxnun9BSoguEtH3chd6Afre547ZUdS6Fa6fB6Q3aQP4fokPt0jeejPjAb28EcsGxieuVQ/01HQi3OtppRnqc2aBCZnYtzwRJcFYxjgebu2S7TKAPUOzMSRSEvEGl8rTobFFzqthp+aoXU9KePJOWGEqB3VGBwhwnPcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eusNISs0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF30AC116D0;
	Thu, 15 Jan 2026 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768495055;
	bh=1++S04BfsZ4kNdUF/obcwax38D/1M1lsT8MCZfkO7Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eusNISs0jvhqUodVoP6xzNRjMRh51/8d+VnGeS1AvxGhVwQVhXK+nwYccRiV4UCSa
	 YEAlV1lE7qQ7uS8sYGJ0pJTDmF4Vva6eheGqLmlleR6L2OSsGR4xmkr+q6KEPzkC72
	 KmHdzATn3lWagAKC97A+ZnLYbQAK5vr2R5pYbhWfra85NRfzw+2Dx0gkwyFR+RugF2
	 Jnd3qmfrQZ/vYauY78n8TIsenH57npRJe0+fT6CNAEBpb0Nee8xzaoxzMgi6X6QeuG
	 xXMJ6xhdc0eQCPrIru7Qq2DqZog2igmaKe9CV1F1Y6SjZk4nS34h+EzuyixmklDpcH
	 51WKiHDZzVfkg==
Date: Thu, 15 Jan 2026 17:37:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pwm@vger.kernel.org, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
Message-ID: <xsjwvmlqclctnf6dgwyuoi7zits27is2s7r7taprb2w2lhsf7i@uiljd7o3ivbk>
References: <20260104194224.41245-1-marek.vasut+renesas@mailbox.org>
 <x25kxyh4t4u6c3ilj7nxp6sywab5dsar46b2foesrwfux2l4b2@d5iwqqcpdhlm>
 <797047eb-e422-4a8b-80eb-ab130066c1d7@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iqvylxh5u5rrvdvq"
Content-Disposition: inline
In-Reply-To: <797047eb-e422-4a8b-80eb-ab130066c1d7@mailbox.org>


--iqvylxh5u5rrvdvq
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
MIME-Version: 1.0

Hello Marek,

On Thu, Jan 15, 2026 at 02:14:15PM +0100, Marek Vasut wrote:
> On 1/15/26 11:12 AM, Uwe Kleine-K=F6nig wrote:
> > On Sun, Jan 04, 2026 at 08:41:43PM +0100, Marek Vasut wrote:
> > > -	struct regmap *regmap =3D pwmchip_get_drvdata(chip);
> > > -	unsigned int duty;
> > > +	u8 *wfhw =3D _wfhw;
> > > +
> > > +	if (wf->duty_length_ns > wf->period_length_ns)
> > > +		*wfhw =3D PWM_BL_MASK;
> > > +	else
> > > +		*wfhw =3D mul_u64_u64_div_u64(wf->duty_length_ns, PWM_BL_MASK, wf-=
>period_length_ns);
> >=20
> > This is wrong. There was already a discussion about this in reply to v2.
> > I'll discard this patch from my queue and continue the v2 thread.
>=20
> Instead of resuscitating the old thread, could you please tell me how to
> make the conversion, so it won't break with existing bindings and the res=
ult
> would work as well as the current code ?

the only way you can do this correctly is to measure or research the
actual period length of the device. As this seems hard, the function I
suggested in v2 works for me, too.

The specified binding is unaffected by that. The only dts I found using
this device
(arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk-rpi-display-2.dtsi)
has

	backlight {
		compatible =3D "pwm-backlight";
		pwms =3D <&mcu 0 255 0>;
	};

	mcu: gpio@45 {
                compatible =3D "raspberrypi,touchscreen-panel-regulator-v2";
		...
	};

=2E Given that the dt specifies something made up and the driver was
written in a way that is wrong but does the right thing in combination
with the made up .dts, you cannot fix the driver to be a correct PWM
driver without having to adapt the invented values in the .dts, too.

(An option would be to adapt the pwm-backlight driver to ignore the
provided period, but I think that isn't sensible and badly affects many
other machines that have a working PWM driver. Or assume the PWM's
period is 255 ns which is probably wrong, but so is 100 ms (the latter
probably to a lesser extend).)

Maybe the lesson to take away here is: if a driver implements a PWM, Cc:
the linux-pwm list and the pwm maintainer on the submission. And let me
point out that even get-maintainers.pl knows about that:

	$ git format-patch -1 --stdout d49305862fdc4d9ff1b1093b4ed7d8e0cb9971b4 | =
scripts/get_maintainer.pl
	...
	"Uwe Kleine-K=F6nig" <ukleinek@kernel.org> (maintainer:PWM SUBSYSTEM:Keywo=
rd:pwm_(config|apply_might_sleep|apply_atomic|ops))
	...
	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM:Keyword:pwm_(config|app=
ly_might_sleep|apply_atomic|ops))
	...

Best regards
Uwe

--iqvylxh5u5rrvdvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlpF8oACgkQj4D7WH0S
/k5IAwf9G/aVgTUL/t7ktmvoHgKT0SuCXVBgz5AuMC1abbdQfCOWWscjD1PJt+j/
soD6pZ93TRo821dQifsFNwvOyeULNpzSR1fg5AKUURcH0PCLeSBADvS2PHCwTOuJ
/c1jJzTFj2Bq2HWjIkEuW+E5jFxK/PEz5C6cON8hLlnDEt31B3LhGevRsNwk5tJr
F7HJyoTiO+YuVEPe4dLwEyMZNtn2FN5DxcyOCyaVKFYh1FgLN5fFYsmt1X09Gh+7
KR/QQfQ73jd7G55TTsfXct6U4gfC6ChJ9h3dAeTfM1nAp9s6e5Ze5bjdhAvCOovB
d/IFXX4fCdogl61Y9fjL638uik9iPQ==
=r04d
-----END PGP SIGNATURE-----

--iqvylxh5u5rrvdvq--

