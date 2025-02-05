Return-Path: <linux-pwm+bounces-4789-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C40DA29871
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 19:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 920A97A3C19
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 18:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604581FCD02;
	Wed,  5 Feb 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewFUZzoF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EED71FCCE2;
	Wed,  5 Feb 2025 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738778976; cv=none; b=f0LFwYGblQwcyH68IMIHKJfLpqS59Tw76q9+oKfZk6QzfeGYB7QvAZP7CXp0J0owQC/UubV9Go4bUAO+d55EQgrmCe7EOcBkQUhBL0/B0F5J6vCn+MoS7RsQDVnWu/Tq37gTNKRj2JVl3ZkIem4UMBe8mNTGiNuPGb/P3LDn+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738778976; c=relaxed/simple;
	bh=UgqCtBbMnL3YDT0zAGJzyptc/uBlUlezWyA5TcMQFys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ybv89h7Kml2IEBoSQz5Kg3DG+ZADgu2G8QAwK+hWo4A5aezBIu/fV7dbSR1oDy5KL0pqsniOB8BlrOttfYYYfKc6l8rT8OtacLfb2dQyj+0NTlydk3tjyVAMn02Gn74jAREEjnoAbNecNAy+VbbhUxBOnZgFoYXzsdRIwx9xO58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewFUZzoF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424A1C4CED1;
	Wed,  5 Feb 2025 18:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738778975;
	bh=UgqCtBbMnL3YDT0zAGJzyptc/uBlUlezWyA5TcMQFys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ewFUZzoFh5gX6yzxQhJCIw7BP0jvb/lIzXdGrFFdRDIMInuHPYUfg0IFMN784YJ9m
	 AjQ3ImMjNyfehJjuqbWXo4liEKcaEPIT6/a8GmCFJmqCH/Z2BfJhNhcIgbQw9DCw+b
	 +AGT6msGqqTa824np0mmSGoKDYUoEY0W+m+ISxx6o4Y4DGT9AYYN5gpWuh8Bl/DD+h
	 rMlFK9B17Zb2eE31c/wATHTVqHLq1UGPJK9MBwilwM62xnubS8cKBx0pBcXczChFh0
	 UfOfRkNBFi6A1u4leLKCKiLFa68L/GJq+0n7/AY7sVmOv1AxctCBH0URxhJHVfXYZB
	 L538vml1TfvOg==
Date: Wed, 5 Feb 2025 19:09:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 2/2] pwm: Add support for pwm nexus dt bindings
Message-ID: <2qnscxa3rzhnsslwzdms43m336l47qutk6ohfqny44lwofjiwh@r6cfdextnhwn>
References: <20250205095547.536083-1-herve.codina@bootlin.com>
 <20250205095547.536083-3-herve.codina@bootlin.com>
 <ejdh76c4r44gxsdi7gwed65ste3wuunki2jgavc3wsfri5yaex@jccsywdfadgp>
 <20250205143737.1315baba@bootlin.com>
 <6js6k6xz3vuqshq2pfwqifby4t5q54ftztxxw2rau4j23xx2y5@u5xubi6v3uil>
 <20250205181930.3b800a13@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dlmz6zrvchrky5ix"
Content-Disposition: inline
In-Reply-To: <20250205181930.3b800a13@bootlin.com>


--dlmz6zrvchrky5ix
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/2] pwm: Add support for pwm nexus dt bindings
MIME-Version: 1.0

Hello Herv=E9,

On Wed, Feb 05, 2025 at 06:19:30PM +0100, Herve Codina wrote:
> On Wed, 5 Feb 2025 17:29:30 +0100
> Uwe Kleine-K=F6nig <ukleinek@kernel.org> wrote:
>=20
> > On Wed, Feb 05, 2025 at 02:37:37PM +0100, Herve Codina wrote:
> > > On Wed, 5 Feb 2025 12:38:32 +0100
> > > Uwe Kleine-K=F6nig <ukleinek@kernel.org> wrote: =20
> > > > Could I adapt the mapping that the effect is
> > > >=20
> > > > 	pwms =3D <&soc_pwm2 57000 0> =20
> > >=20
> > > In this one, I think you miss the PWM number
> > >=20
> > > If I read correctly this line you ask for the PWM 57000 from the soc_=
pwm2
> > > controller. This doesn't make sense :) =20
> >=20
> > Some pwm chip devices with only a single output line use this. The first
> > paramter is the default period (which is passed in the 2nd parameter
> > normally) and the 2nd paramter are flags (normally the 3rd parameter).
> > Back then the rationale was that for such hardware, the line index is
> > zero always anyhow, and so could better be skipped.
> >=20
> > Compare of_pwm_xlate_with_flags() to of_pwm_single_xlate(). pwm-pxa is
> > the single offender using the latter. Thinking about that, it's easy
> > enough to fix without breaking compatibility. I'll tackle that.
> >=20
> > So for a PWM on pxa `<&soc_pwm2 57000 0>` works fine.
>=20
> I see. In this case, a parameter shift during translation would be needed=
 to
> skip the PWM line index in the translated arguments. This is not currently
> neither described in device-tree specicication [0] nor handled in the com=
mon
> code of_parse_phandle_with_args_map() in the kernel.

OK, that's what I expected.

> This use case can appear for resources other than PWMs and IMHO it should=
 be
> nice to have it supported.
>=20
> I think this support should proposed out of this series adding support for
> PWM nexus nodes.
>=20
> Is it blocking for this current series ?

Not from my side. If I get an Ack from the dt guys, I'll merge it.

Thanks
Uwe

--dlmz6zrvchrky5ix
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmejqVoACgkQj4D7WH0S
/k5KjQf/fLoTm7YFevHSeyuYnbrV5Pl54qHfowekR7rk6ALrPj2U/1EJkeyLSsNo
fBWzO/V85vn5nFmq25mPwn7PYQ8nKVi64k8XBYdJqiE3JB3R2SwbiZyaLI7a3wyP
/DxIdYckHQYAYJGqNSss/gzjAJ5lN/oQBr5+AhlgfmdnBgKf0RfVsXOzr84L9csY
xuWu+c/hPggx+4nRWHBy2iMp5O5ARZSb0Rp9z7hMtgcHQvgjPfcdixAoDs33jLkz
yygabaqSXIyX3HONJDjUWZyEOgcnR3byVJTMY8/KPWbdMRH89Dqz8l6jduosGd/H
iRj9cc66uU9q1xLohfAkLA3ncrQ1QQ==
=qlka
-----END PGP SIGNATURE-----

--dlmz6zrvchrky5ix--

