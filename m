Return-Path: <linux-pwm+bounces-7868-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D8CCFF1E3
	for <lists+linux-pwm@lfdr.de>; Wed, 07 Jan 2026 18:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 842C234A9EEB
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jan 2026 16:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6BD37BE87;
	Wed,  7 Jan 2026 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzrWFiYr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D118337998A;
	Wed,  7 Jan 2026 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767801289; cv=none; b=byDYoJRwGFXpB82ih9j47lLjD8sJhCqSPLdi7zDiB5rGh5DD2A63f0/jE9qzo8WUl6pPdRzU8jtYi7IWjJIwx5fcnUXj0/U99tHk0VXz7KpKpvJLesf8AkxYzBmQ3aqcD3+pp7uyNfo3M0Y7tI14qKDeo+hQJkIr2+sRqbke1RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767801289; c=relaxed/simple;
	bh=dQHczuUO01yiJUoA4VVJbRjpUINgq/SBa7rpIL/696o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5+XIF9SghIEZcs/wPkKveae9u8ZTxjRZmrapuDQ6ndnWBY7GxWWLvKQxmfzBS8mYIoNQh7Bt0kyvoEQh1gPU9fyyr6bPb2JRH4wNtt1xtc7VwJ7JqRuTV8kyhpaLlxporW7l5ur57aRELAUL5OShxfcIRJLfy7RXDMZX7QEFm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzrWFiYr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AFAC4CEF1;
	Wed,  7 Jan 2026 15:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767801289;
	bh=dQHczuUO01yiJUoA4VVJbRjpUINgq/SBa7rpIL/696o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MzrWFiYr1lLU7Zo+vJOoMuB6y3YJDu3ijrEKUJhEYVuiRKPCKpIOagB9YslXNI74o
	 kUQAwTd18zutfYUw+fOkoRM7OsGpAMTNWYkm1jGXjzThQtvLO8eFhX2rq8lW1HUu6b
	 h6fnQ0k89bBDzpAi/xaBxhfFQYlX6X6h0D6WOOhV9jN7zdwAL2udsBD6es5Qu5W6Pk
	 TCIPhLiOQ9++Yz2mFrqZxrvtco6aXeu7+5le5mI01NGQgjOvsZocJA3MLPKut2rT67
	 dvOA4/aegHqCtdG+3Msr/oH97Z4qJrKMCA/3aO4YXAKYqkBd0GeNFcroJmgaN1rC/f
	 EtJJVfnO3/nVQ==
Date: Wed, 7 Jan 2026 16:54:46 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pwm: stm32: handle polarity change when PWM is enabled
Message-ID: <nwhixocvhii27jvcyg7ex5emewntgfhyxa4ds5vo2dphe7xfe4@ibjsjdd5fgmn>
References: <20260106-stm32-pwm-v1-1-33e9e8a9fc33@geanix.com>
 <kemjjoyrhqglqq4p2j6kygspevq2mdbiujtnksw4rkdapoqcfy@zte2c7fhqvn3>
 <2e2iahbzcepbzwgk7xeta2afxmycfjgv2zofzngqjvp4on46r2@mzpi4bz4uqie>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="64gye46smpsbdd4v"
Content-Disposition: inline
In-Reply-To: <2e2iahbzcepbzwgk7xeta2afxmycfjgv2zofzngqjvp4on46r2@mzpi4bz4uqie>


--64gye46smpsbdd4v
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: stm32: handle polarity change when PWM is enabled
MIME-Version: 1.0

Hey Sean,

On Tue, Jan 06, 2026 at 11:30:34AM +0000, Sean Nyekjaer wrote:
> On Tue, Jan 06, 2026 at 11:22:57AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jan 06, 2026 at 08:01:57AM +0100, Sean Nyekjaer wrote:
> > > After commit 7346e7a058a2 ("pwm: stm32: Always do lazy disabling"),
> > > polarity changes are ignored. Updates to the TIMx_CCER CCxP bits are
> > > ignored by the hardware when the master output is enabled via the
> > > TIMx_BDTR MOE bit.
> > [...]
> > I have hardware using this driver, will set it up later this week for
> > testing.
>=20
> Very cool, looking forward to hear if you can re-produce.

I cannot. I have:

	# uname -r
	6.11.0-rc1-00028-geb18504ca5cf-dirty

(the -dirty is only from enabling the pwm for my machine, no driver
changes)

	# cat /sys/kernel/debug/pwm
	0: platform/40001000.timer:pwm, 4 PWM devices
	...
	 pwm-3   (sysfs               ): requested enabled period: 313720 ns duty:=
 10000 ns polarity: normal

and pulseview/sigrok detects 3.187251% with a period of 313.8 =B5s.

After

	echo inversed > /sys/class/pwm/pwmchip0/pwm3/polarity

the output changes to

	# cat /sys/kernel/debug/pwm
	0: platform/40001000.timer:pwm, 4 PWM devices
	...
	 pwm-3   (sysfs               ): requested enabled period: 313720 ns duty:=
 10000 ns polarity: inverse

and pulseview/sigrok claims 96.812749% with a period of 313.8 =B5s.
So the polarity change happend as expected.

This is on an st,stm32mp135f-dk board.

Where is the difference to your observations?

Best regards
Uwe

--64gye46smpsbdd4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlegcMACgkQj4D7WH0S
/k4fRwf+IoPI/fQOF4r4TdyNyj65K6n+ilKzhOPYzKYcI84BEcJY/rHKy5tCk9Un
DB3fGdGsshoeaQtmX1qobV/wi6PFT27ecr9Li3lppUnc7ncvEKwKstDEY79THvf9
laZNtq6+trpelYq4JQGCoXwgE+sJTjMpFtoJLFGko4LrJxXvhVZEuU8oYuelRaOe
e7jMVbf/EdBMnLkI7TopaonJ+/FH+YDFED2h1AJPY9RbGU6VbJ+Y76pIFQwC5/Nz
zfheLxXGMWT5G9eV6atq4rcrvRQDB3pr3fULyKSwb8q9vpObaJjyIiOkqCDK8zOF
MIfKdXUl/rx9CggHjkGDcVN+AzBkEA==
=Hapr
-----END PGP SIGNATURE-----

--64gye46smpsbdd4v--

