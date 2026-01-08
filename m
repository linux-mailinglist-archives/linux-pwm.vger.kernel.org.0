Return-Path: <linux-pwm+bounces-7883-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAE3D04BCB
	for <lists+linux-pwm@lfdr.de>; Thu, 08 Jan 2026 18:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 892383176511
	for <lists+linux-pwm@lfdr.de>; Thu,  8 Jan 2026 16:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5843B7A8;
	Thu,  8 Jan 2026 16:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flWD6jlR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A628500969;
	Thu,  8 Jan 2026 16:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888104; cv=none; b=AEL4ZIGgSuS6RaA0eJ9F/vJwgjrV7LYYslgRRF7Rlf9/MRyjXLeWd+d10yu1E77a+Yd+gdiSKCuNiss9kZjjYeeinlarLVrjfW0MRRwUl4vEz0OpXXENwah+Twpa3WnaUtFCenUNeoaq5NrbqsAFb0rkGQiUGkk5YcKjFSggNsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888104; c=relaxed/simple;
	bh=sxqTloeRRUJ6OTAy8ylqgLk5rTozFp8ZfC7yqvSuiZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwBUh55Q/jrZdlB+Gn+DTLeD5OqujtH3XOJMdiXvgWAGxVrs+7V/XXi3KnN+h0v9E0rC1FhfJ3MhGzm5r696qisiznZ/cNnhoKcz019gsR6jwgz/Q+GbFftyUQwiIAXT/DcsX+M8ic2QZ8BwMqIuQJ6KUFDxZKLwl5y+mbwyTcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flWD6jlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71169C116C6;
	Thu,  8 Jan 2026 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767888103;
	bh=sxqTloeRRUJ6OTAy8ylqgLk5rTozFp8ZfC7yqvSuiZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flWD6jlR1Z44zvUG/fL3f5FNu3EI/1cBSatqAL5XBmWvlKYlOi9c0pe35AK4vYMsd
	 4lumye5+L76U5O9nywXUC+l6xYjFiW9WX0nUeDQ4ETPhbSI7kBEnnRrwoGhGVqTbXc
	 TOQfNxtoAI634qY14nkDUQKKZEe6LIA0Ot6ncS0oUUZstX651CNuNWOmVRf/z7V6So
	 O0hsgiB5CgKvWJfkuQWydML0rll3BwyNvU/r4+oljTNHHaj5oeECVrXJS2rcwmMHU2
	 Gj1KDqk+MMdmKD1x+cTqJNzyZosjq4qxjqkCmUlv51VKwqolgrFaKKk17fE7CEh6aJ
	 Dxw+C9qou+kNg==
Date: Thu, 8 Jan 2026 17:01:41 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: Sean Nyekjaer <sean@geanix.com>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-pwm@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] pwm: stm32: Always program polarity
Message-ID: <j7qywnmejd4v2tez77hxmjnq7pavmaoed7z4aoelsbfdyt4qyx@7jawgsz2kfy7>
References: <20260108-stm32-pwm-v2-1-ced582974f8b@geanix.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6bapewmlqmprl67v"
Content-Disposition: inline
In-Reply-To: <20260108-stm32-pwm-v2-1-ced582974f8b@geanix.com>


--6bapewmlqmprl67v
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] pwm: stm32: Always program polarity
MIME-Version: 1.0

Hello Greg,

On Thu, Jan 08, 2026 at 01:45:23PM +0100, Sean Nyekjaer wrote:
> Commit 7346e7a058a2 ("pwm: stm32: Always do lazy disabling") triggered a
> regression where PWM polarity changes could be ignored.
>=20
> stm32_pwm_set_polarity() was skipped due to a mismatch between the
> cached pwm->state.polarity and the actual hardware state, leaving the
> hardware polarity unchanged.
>=20
> Fixes: 7edf7369205b ("pwm: Add driver for STM32 plaftorm")
> Cc: stable@vger.kernel.org # <=3D 6.12
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Co-developed-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>

> ---
> This patch is only applicable for stable tree's <=3D 6.12

Can you please apply this patch to v6.12.x and older? The problem fixed
here doesn't happen in mainline since commit deaba9cff809 ("pwm: stm32:
Implementation of the waveform callbacks"). That mainline commit however
is too intrusive to backport it to stable, not even considering its
dependencies (e.g. 17e40c25158f ("pwm: New abstraction for PWM
waveforms")).=20

I assume such an exception to the sable process is ok and the patch is
simple enough to be easily reviewable? If not, tell me, then I can apply
the patch and merge it (with `-s ours`) into my next PWM pull request to
Linus :-)

Best regards
Uwe

--6bapewmlqmprl67v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmlf1NoACgkQj4D7WH0S
/k6OqQf9FV+4wHydQ1d2QmXQkObz1Jz2DRvaFNGUHj2G6fyzrdXWZdOhetkguAQ9
b/pP0M15fUph3X2jzWn9/ftG1C4xzCJFzDEbxu2nZAoQy3lhZwIKq0IfiueG7eHZ
8jg1wcUZRgJPc3fVp3KFr0w8s+pAq5m4RCX+EAeG/3rZyLKV2zpPNOOXq2kVRm8Y
VnevGuGZk/U1CkgI3wSpXmd8/ueQTPOHh3fO/an9mB6xjSPNHJ/NClILhzYHAR9i
FyxIQm+py1G/cPfbmFNSfNKniIiDSNZHj2Z/bsv/R8SiHEn3pqThTGdZShy3z4uF
jCCjRCfUrPQ+/OqPwN20f/16HMtR7g==
=WGlv
-----END PGP SIGNATURE-----

--6bapewmlqmprl67v--

