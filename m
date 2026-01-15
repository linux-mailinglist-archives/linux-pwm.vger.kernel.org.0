Return-Path: <linux-pwm+bounces-7914-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD81AD276E1
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 19:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2223B30C59B5
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Jan 2026 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C44239B48E;
	Thu, 15 Jan 2026 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc1aNxkW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561E134F24E;
	Thu, 15 Jan 2026 18:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768500602; cv=none; b=htYpie/bwM4h61lIMEb5CVqxESXUincf/shBZBAcJ+pau8jCMDO+oBwjpkBjN1hetOxqh81V0+2+i0cSlarTRTkikka24sDHQIUn1Gk53+s7MiU0hTPAaOUsFKlrimgOnv5En4eaGksVPvndeAYfGFnVbgIYaVUTF6Rj9mm6Utw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768500602; c=relaxed/simple;
	bh=cmga3VGUs9lgeykk873UFHClgQGDKuBeHf4c9rfje5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqkz9PToYhTgCJXBCIHv+xmsANtLLf3bYe/jAF8O7rV6rPBscSqIc2UGtdgHiTfsrYiqyh3v10ygedu78hbdZLJpNMYtOrIeTV9UzLsUj/EPY6NPgG4UFUvbL42xsGrPc+EvFdMRp5GYh5hfCFXEMx/EJE5YByhlOgUQMbn9T1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc1aNxkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B20C116D0;
	Thu, 15 Jan 2026 18:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768500601;
	bh=cmga3VGUs9lgeykk873UFHClgQGDKuBeHf4c9rfje5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kc1aNxkW1D7MjsZlUXP3Q84q5led//REHcKLJe91PG/OfoY2pSDjQGpnHFOCRS9Do
	 52Duct60AXfbPCPEQWzkKMcH0EguZWQRGTsq1KCcXaakh40Y4vqRbWJXWr1KxY65EE
	 EN9rvQ5XDTc7rE8gFf1goE+vpZlYC2WlCL6PlaRiYyF9Duy260rZO641vB8FuDh3SM
	 EkmoflBMNEeXR98KAy8ILh3oeVg6VdMhou8sJZqs2dwtOrwJQ/iBNHrPQ9H6gEVcnb
	 a8/5TU13ZWjfWjw3HC69Xmt4whsaQtTZP1kotnw+wyXluZ4II/5t7VLe0WJUncA9/0
	 xdSFcQxkGGwLA==
Date: Thu, 15 Jan 2026 19:09:59 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: linux-pwm@vger.kernel.org, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
Message-ID: <ygyirj7jqkivztwgpwzskmleyvscywl2yjfjhfcawmlsgkkohe@dzsahribiqid>
References: <20250904210604.186893-1-marek.vasut+renesas@mailbox.org>
 <qdqla4f5nfccqg2vdwkshzo6znwfizqizsyhfs7ksp6znja7uv@u4uwzvx7pgn6>
 <05bf0e18-68dd-4eab-b4d2-05af5f8d1ef7@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cyidhgceeeox2tux"
Content-Disposition: inline
In-Reply-To: <05bf0e18-68dd-4eab-b4d2-05af5f8d1ef7@mailbox.org>


--cyidhgceeeox2tux
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v2] regulator: rpi-panel-v2: Convert to new PWM waveform
 ops
MIME-Version: 1.0

Hello,

> I'll send a V3 now, but even revisiting it at this point, the waveform API
> does not seem to be the right fit for this device.

If you consider the waveform API worse than the .apply() callback,
please expand on the reasons.

Best regards
Uwe

--cyidhgceeeox2tux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlpLXQACgkQj4D7WH0S
/k5geAf/Tz6NwfPHoK3MQB6M4atzBxAV8yyS8sZ1HW7ItRNXncmYYTqLLH+A4O1e
80JCLOiAw0GHR7KXWjNxaMrqvb0nHOXtrLf7kGuAOed4XEMkqWM5ysNtpVYYSjlJ
15/f5AaWm89cOvoIRLsojGbSyc4Fm6CM1bzyt/FT8CwgKJ53KGwXiOoUw+65sSI0
2xFF/X7UyMHc99PP2iA2HzWvYXrb/0eHncyaKrnhYaiyv1gzvoyiSMBbRE8JD7ZW
bCRJDDkoyBDvM0nG6wi+X4hkKcWxveafKOL8sdzbCaxqcE+nuuXJoRwe3hjAyQ+K
YsAmPUHmgjj4NubtoSJhJsXBjeZliA==
=g9bh
-----END PGP SIGNATURE-----

--cyidhgceeeox2tux--

