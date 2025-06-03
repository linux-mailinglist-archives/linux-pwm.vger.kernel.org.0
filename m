Return-Path: <linux-pwm+bounces-6236-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CDCACC210
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 10:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7241816BA02
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Jun 2025 08:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C617B25D216;
	Tue,  3 Jun 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGfQMCwW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825A218E1F;
	Tue,  3 Jun 2025 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938821; cv=none; b=e1w8PzqNHgby7BS2IPJI6P4joVllLXEnaqb0QNpgnZFJF2zm1xMNQPN/08yUYWImuYuJKeuO6kwPR5f+Xy/iLyU1EodiswrUBw6w4ySdKG4K7HLw9LcSr5WLsKxYerd1N1JMtG6tfDGwthek3QQxeuBok+OGV8vUM1X938ydT60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938821; c=relaxed/simple;
	bh=V766QfVIPo2Fq0Fscd2gihyKLHyoBdox2rZ6FnqVc2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7QMM7CaNUY+jzH8tPVy+PvsPTBewiw34FPypAwWIIFOJZGJqTAWI8jxNajPaoeI+OrtBEKvdAzMmcbAE8JkwVpmD4JsBYwI2Su3EYQ/JBsUvUfaCekjp80UR6vRS9ZyDiIqQKa7DPZwuUc6Tp6OeXp5Zh0GEMiwESqthVadSds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGfQMCwW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80170C4CEED;
	Tue,  3 Jun 2025 08:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748938820;
	bh=V766QfVIPo2Fq0Fscd2gihyKLHyoBdox2rZ6FnqVc2w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGfQMCwWbM7fsn61JAfgM0lgkHNuAxI60VItIuDAS6ZWgaRvXLLr/lweiXWAntybm
	 mDa3c751LVCgqgMJVcdhjKk4XhOObsnqwmysrxof6pqMw4koGraHdFOLRZOggAIjiy
	 sGpWAmsgaGov1dL66W4ZBJTAVtcEwY52NQ3sTwMY1O6zBd/HBFniwaHWaecVFFRhs1
	 785LNKwksjlOFoOJ8+f2Opx5s6dIXyVH7oU0mtn/FlAkblzHosOKwk5wg0jWRjpS+s
	 Rk3MY9ZsepgQVAU/vGg7FFPRAu4F5V0hjWJGptiBennulcP/UEYnbBGvy5UUsEJSSm
	 MV4/LWhGCWPsw==
Date: Tue, 3 Jun 2025 10:20:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "jdelvare@suse.com" <jdelvare@suse.com>, 
	"linux@roeck-us.net" <linux@roeck-us.net>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Message-ID: <afiirmp4q4txm5ibiaa4nvzl6tlj7merc3ienvt4o4zhmbcuua@f6r6fyg2jviz>
References: <20240722221737.3407958-1-chris.packham@alliedtelesis.co.nz>
 <20240722221737.3407958-2-chris.packham@alliedtelesis.co.nz>
 <jzxu6mcbxf5zwyirnb2jjpm2i7sln3v5mz3gyhc5xhpqexicvb@atrcjvh7wuh5>
 <bc99a27e-74ec-45a0-b77c-48f993269586@alliedtelesis.co.nz>
 <jmxmxzzfyobuheqe75lj7qcq5rlt625wddb3rlhiernunjdodu@tgxghvfef4tl>
 <4858ce06-2081-4335-af09-f118872317ea@alliedtelesis.co.nz>
 <dirkbdd5oeofjhy5pk6jiaixbuhmuq7axewhrd7bdghc3dp5x6@ok2uhywwz5ls>
 <d538cd42-f8b3-43cb-897d-d60c3af57300@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="guut3mpnwuespg6c"
Content-Disposition: inline
In-Reply-To: <d538cd42-f8b3-43cb-897d-d60c3af57300@alliedtelesis.co.nz>


--guut3mpnwuespg6c
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
MIME-Version: 1.0

Hello Chris,

On Mon, Jun 02, 2025 at 08:52:56PM +0000, Chris Packham wrote:
> On 30/05/2025 21:38, Uwe Kleine-K=F6nig wrote:
> > I wonder how other similar devices determine the default duty cycle.
> > Isn't the norm to make the fan rotate at max speed and then when
> > userspace takes over it's speeded down?
>=20
> Yes that is the normal (and sensible thing do to). But occasionally=20
> hardware designers like to use incredibly over spec'd=A0 fans that are=20
> just ridiculously noisy. On some products I've worked on we added basic=
=20
> fan control to u-boot so we could silence the fans early in the boot. I=
=20
> also gather that in the PC world the fan control is often done=20
> externally to the OS. In the specific case were I needed this=20
> functionality it was an embedded x86_64 so I had neither U-Boot nor a BMC.

So you're saying that Linux is the first instance that is able to setup
the fan -- no BIOS, right?

I think that's quite normal and the fan is only noisy until userspace
takes over. So I still think that is what should happen here.

In case this is really too noisy, I'd prefer the driver to know itself
how to setup the fan and not put that policy into the device tree.

Best regards
Uwe

--guut3mpnwuespg6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmg+sD4ACgkQj4D7WH0S
/k4xrgf+OMIC6cym6UhCCGXK1EqDRciHWKcVjqBzAoaNmEXCKSTuzcs9lP6h/abm
DIMUSTgoO8UjQZp8bQJiLiOmWy8+pKeYLE4TTf8155p+4gW1b7gQZ/l2lSNal90M
Z9LzcxGueVhj+yzE0XCYMpDbVzyXLeYltMUXEjsDdeBMoLUYiRNtwZvP35WXsveX
ACM3bPLkVDTw1j13gbV1Bi8ISTCDfG12Jq/fN7yYcQKM0y0+fy24IIfCIl0VaGbn
SgisHfVDrZK8jkbtuzuDHicFH6DxHRMh6++/fcg7MURgQ3WUobrRT2oiydMoKacp
M+Lf+bivSjXN+MbUnHKVBO8PtPDSLw==
=7cXp
-----END PGP SIGNATURE-----

--guut3mpnwuespg6c--

