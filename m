Return-Path: <linux-pwm+bounces-4246-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6BF09E4FAF
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 09:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C56518819A2
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 08:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8161A195985;
	Thu,  5 Dec 2024 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7AZBvh6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5740F239195;
	Thu,  5 Dec 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387288; cv=none; b=siOWdn3FMJlJXYZP/aWkKf6u68S0EDHGRlLeuHEl/rCnUuZa2Ad0rZ4YCJMRd7PiSrajoummCk6RxNP96rAbegt1CrtnA4Q9UDmYpwzYCUt03pg+rdre3KZSteSQdz8V3IQ/U0jqpdwbwCwL0WlZc0B15NnIp0Nfq/LKHZ/+3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387288; c=relaxed/simple;
	bh=NlhysIv/yM2j31hi9eBDAjWataAAJORw/hVtbxft7P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWANdTKjq8kkVYgyE1/H2Y+yHMcl6WKn2rkq6Q8/9W/+hQIAjEY1DQkYpT8YUokp3EqQ4inogAkPhukGKTIMR6I1HO3Z6OlrQQG/N5BbS/msyC2LRN8GodKYMGyg1q3UNdIGU9rQqXdnyokB1sN9e7mcLAYGMRtzn+GnVqaXL3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7AZBvh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F925C4CED1;
	Thu,  5 Dec 2024 08:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733387287;
	bh=NlhysIv/yM2j31hi9eBDAjWataAAJORw/hVtbxft7P0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I7AZBvh6oszGph8WWvf+XiJ2Pr66W7nKqncG0hf7RAEJezGYvV/DBgCuQwtIgYVHF
	 k5KL0rDrfTzKeYqYIJSV21FBmy1aR/wqs0XBzaMUUnSo0a4HZi3DdoiRurXsDn/4B3
	 aCcGVWNMdWw3lZaZv2egtBpGB4fdameZGZ7iqPIyM51cxS9A0fgk7izO76r98AfprB
	 x5XDBhGRfFW5ppvp/GqPDcKQFKuZyjcetuuLW9+UwceXtqMB6zrEyVsPkZvUUWsyQT
	 Ub7g9VIC3bJb5SMcHOXO/EvHBVFVJuxRWqhBFApmYX+41tg+9QoFFRsaz59uXluGe0
	 AeEqknjZ+/NRA==
Date: Thu, 5 Dec 2024 09:28:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"biju.das.au" <biju.das.au@gmail.com>
Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <phr4mtucfmyuhaywspzpxwqvwmklwcgsljcc5dvzbft44kengw@65axncbiotf7>
References: <20241018130049.138775-1-biju.das.jz@bp.renesas.com>
 <20241018130049.138775-4-biju.das.jz@bp.renesas.com>
 <slgs56imb3u6fv35bo2hl4moa77nnhrtcygi4womtuzs2mcipt@ylcvacvhsgcl>
 <TY3PR01MB11346421B5C0C4A193F70C3A586372@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="plapp44ynklwfcqe"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346421B5C0C4A193F70C3A586372@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--plapp44ynklwfcqe
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v22 3/4] pwm: Add support for RZ/G2L GPT
MIME-Version: 1.0

Hello Biju,

On Wed, Dec 04, 2024 at 06:24:19PM +0000, Biju Das wrote:
> > > +	 * different settings.
> > > +	 */
> > > +	if (rzg2l_gpt->user_count[ch] > 1 && period_ticks < rzg2l_gpt->peri=
od_ticks[ch])
> > > +		return -EBUSY;
>=20
> Do we need to allow this operation (period_ticks < rzg2l_gpt->period_tick=
s[ch]) ?
>=20
> For example,
>    First IO (IO_A) period/duty is in the order nsec (PWM frequency in MHz=
) and second channel period/duty in the
> order of microsec(PWM frequency in kHz)
>=20
> Allowing period_ticks < rzg2l_gpt->period_ticks[ch] will lead to incorrec=
t operations=20
> for First IO (IO_A) as PWM frequency will be in kHz compared to MHz.

Well, the policy is to pick the highest possible period not bigger than
the requested period. So if B is asked to be set to 5ms and 5ns is the
highest currently possible value, that's it.

I agree that being off by a factor of 1000 isn't nice. But if you say
this is too much, you have to draw a line somewhere. Where should that
be? Everything you pick is arbitrary and I'm sure there is a use case
for every choice where it's wrong. Additionally if you are too picky --
in the extreme case don't allow any modification >=3D 1ns -- the API
becomes very hard to use.

The only sensible way out is to allow consumers to query the result
before actually applying a request. This is in the making and if you
want to benefit from it, look at the waveform stuff that recently hit
mainline. (deaba9cff8092cbb2bef4dc79a6ce296017904b1 is an example driver
conversion, 6c5126c6406d1c31e91f5b925c621c1c785366be and
17e40c25158f2505cbcdeda96624afcbab4af368 are the relevant core changes.)
=20
> According to me, we should not allow updating periods for second enabled =
channel.

Not entirely sure you mean the right thing here. If IO A operates at 5ns
and IO B is requested to set .period =3D 5 ms, every operation that also
changes A is out-of-bounds. So your options are only: Use the 5ns, or
return an error. The latter is hard for consumers because it's unclear
what to do then.

Best regards
Uwe

--plapp44ynklwfcqe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdRZBEACgkQj4D7WH0S
/k76Wwf+PwL1QoeMXoeeOVnrVAL3DeetG37liUIlmeFUTcokRfBGQr5Lyx3sXxj9
9r8jAowrTpBo10hC+CsJVc10HwPXECpEcgHzlMEFLZetqNWcRDuIfcAwvILnohxe
MRu56X3B0JqADdmaqTpBhFg6wz+XodZHx4P0wceD8oubm+1+q9tMqZuL24z4A0Tu
0CqJ0SeBy3sVtIx3WnK+YZhBJt5iCrlZ3f8QcXjQoLAbgrSbaJBBojwHvvGiJu+7
hFgMp4CaVPyioQrINhD57H65tfVX+CCZLsW5U/vxvwehueRCfKBm1G+tDsKNDrFD
xJ4aetG+2k1ekYcCJStngKjHsh3iOg==
=K+zz
-----END PGP SIGNATURE-----

--plapp44ynklwfcqe--

