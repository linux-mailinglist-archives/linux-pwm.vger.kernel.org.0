Return-Path: <linux-pwm+bounces-4810-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFC3A2BE5D
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 09:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1006B188ABAE
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F085A1A4F2D;
	Fri,  7 Feb 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC4i48kQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60211946BC;
	Fri,  7 Feb 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738918147; cv=none; b=XOdi39ixEpp59duCMpFXbBt0IiUUdnucrpKXc3BY1eBn2lgFDCRsM0Jvqp79IvdocnvBcGxAH7vu8DEOGZBKV75QVOebOdwvBiJlV4PCjFxwncYd6y9Qahpee/Kd71mEPpSrg4r52EXBF3PpJy/1qcEXfQGQiwzOjMGSd1S+TsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738918147; c=relaxed/simple;
	bh=gOUk2fKwLtzXzYZsjeh6qV2PpFaqwwoQief/yTsP2hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAm9hZFptvui7F6f8K7UAh7Yq15FF18j7kQW8kpZaxwjQf5flrvPXiO/ilDIgpT+l1PX4DTkHp4eSxxItoGYFvAjHljzveMkYqFQb9klzD4DH4xTs6puJuyHxu9mK8EGukhjqSfEk7psg+8fPMf9VNwgxIP7QPWmv/VOxuHHyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC4i48kQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C39C4CED1;
	Fri,  7 Feb 2025 08:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738918147;
	bh=gOUk2fKwLtzXzYZsjeh6qV2PpFaqwwoQief/yTsP2hM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HC4i48kQ1OZz9lgya8wP949+Uq2tTnXQfj8aAOxVTjKT+ZE0hmjlaWnfHM6/Lgi8j
	 VJj2jw19q59xRX+YZHZBj0RI+Isykh9V1Iwqpxudhh1rE8FvRQxvgc50qptdL25OLI
	 87c0jGN6n5HoiX55/XpN8s8nyFh1ho0YHFUBTdj0LDampNyq4EmVsXyP7O4Ov19Wmj
	 fXUTBjogTWGG/6LbupcYyl60bXiJA3qntCtU7/ksYz9aiRFoV7uTddDxTAbC+ULIPy
	 pgWU6mmPi93epWf+mpl4mas6+YPbDsDB7xmSrYCdOK+AqEauleIDm79THQ4ZvaCJbx
	 zqmNGJTyPtsJQ==
Date: Fri, 7 Feb 2025 09:49:04 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v2 1/1] pwm: tiehrpwm: ensures that state.enabled is
 synchronized in .probe()
Message-ID: <uw4ans5zzvo65voerbaxvj2erethpuh2jfm2iu7ekqyvgg62nx@lglwyjcpa5aw>
References: <20250206031347.63700-1-rafael.v.volkmer@gmail.com>
 <20250206031852.64853-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4vpgkyftoyl3ja3j"
Content-Disposition: inline
In-Reply-To: <20250206031852.64853-1-rafael.v.volkmer@gmail.com>


--4vpgkyftoyl3ja3j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/1] pwm: tiehrpwm: ensures that state.enabled is
 synchronized in .probe()
MIME-Version: 1.0

Hello Rafael,

On Thu, Feb 06, 2025 at 12:18:52AM -0300, Rafael V. Volkmer wrote:
> If the hardware is already active during probe, it's not asserted
> that the clock is enabled. To address this, added ehrpwm_get_state()
> to verify the enable bit and update the pwm_state struct with the
> correct hardware parameters.
>=20
> In ehrpwm_pwm_probe(), the function checks if the enable bit is set
> and calls clk_enable() and pm_runtime_get_sync() if needed.
>=20
> Additionally, ehrpwm_get_state() was integrated as .get_state in
> the ehrpwm_pwm_ops struct, incorporating it into the driver's pwm_ops
> for consistent state management.

No in depth review here. One thing I just noticed when skimming your
patch: There are still whitespace style issues (that checkpatch might
not notice), please only use only a single space after =3D. Also please
split the patch in two: One to introduce .get_state() and the other to
fix clock enable accounting.

I would also consider inlining ehrpwm_read_period(),
ehrpwm_read_duty_cycle() and ehrpwm_read_polarity() into
ehrpwm_get_state() to not have to jump around to understand the register
usage.

For a more detailed review I have to ask for your patience. There are
still some more driver reviews in my list, but I come to your driver
eventually.

Best regards
Uwe

--4vpgkyftoyl3ja3j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmelyP4ACgkQj4D7WH0S
/k6d7Qf/cA3RY5/ZO7HZOShB/GBCw8qpR0/rUo//77izqky0VxyxWb2o7pp/VLla
EBBvE1BbWLfKr+vojJPw4mK8L7+aAqhT82wBtsohjaXMnDZcnEOMDCpm4JizoAGo
OzeCaIuDIogTwOjBWi/Kd7p5arApwZ7HGQjVHYqzqU1KzctZWPeGx/n0E7raOJ4v
NKwBXiPzyJdzYUR4ZjkHjchb7w9XltbtqF5RCnxiKrsQIOuXG0nHVAdD1HWnjLWj
5WpjGTJIH+Kx4tN/QXPFWIBGcg+j8wvvMxOHvTS9dUrXyFQDIc+M+XhdXrubPww6
kTC9pNpCZKHerGdPQYnBGHysuAhbBg==
=zcTK
-----END PGP SIGNATURE-----

--4vpgkyftoyl3ja3j--

