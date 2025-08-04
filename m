Return-Path: <linux-pwm+bounces-6949-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D925B19FDB
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 12:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94F58169853
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 10:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9AB2494FF;
	Mon,  4 Aug 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMu2BTKq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5130122D7B6;
	Mon,  4 Aug 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754304172; cv=none; b=iywTnMTnM7V4xw6acn13FqO4js3vun9DmkG5zlTIsQ59dIYok1EFYEI60Z2yUHIQsZIY3qQZrz8SKx+4po5Sh3LQHUdOR5o2Wq0wZN9E3UJDS14fswu2T92zikfLIaL89qg781nbAkOCK7pkY/mwOwCGWM75QZmaweCI5b9w6o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754304172; c=relaxed/simple;
	bh=m0mT9t4kvDpPBL2vj8DzXbWcyAMZuJv68f2sAk/zW7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V22NPwH62Tih+yUvYNzY6rou+nY4Qp0XK2wnU804Y+8lqj4HOQB0c6zwUbltxWXi56r6vPHOBrBqfB/6tpkMQvakLTGgzaaHbBI4l6GRyL1qLK9ZJ+swiw2YfutMlI6JCQ34VUAY+Vrv7fOQE2GM6gaokrTXnSatYDDVSiRcdy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMu2BTKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454C3C4CEE7;
	Mon,  4 Aug 2025 10:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754304171;
	bh=m0mT9t4kvDpPBL2vj8DzXbWcyAMZuJv68f2sAk/zW7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aMu2BTKqYSW0T7uFORi5MGJsjdnf9qzViR8XS8FspKLpKVV2YfL/gXg4TrFaZC+KV
	 JbaQi7/hz+yNhBFguxW6sXiUz330/bkY+s4vVPTxVtxagDlwFYV12aFLPrDrEyTM5J
	 PrvoSU/Zoz7CyzmzSI1219YaVjG78/T6HNq/uHLuvDo1LS3YqLgSRR4qE+vDcJNXMy
	 ZBknZKXgpsguVktH364EEkLngDBIPMLore0RRalQrwUYljWg+4qFuL70IFGE/10qfz
	 BcYpSDwzhSfc8tHCl+Ks9fmWx10VfAGP0s8wohh1Cn7nsidc4bVOuj0opGpnRB+QfS
	 DUIvXzQgUzzEg==
Date: Mon, 4 Aug 2025 12:42:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Nylon Chen <nylon.chen@sifive.com>, Zong Li <zong.li@sifive.com>, 
	Vincent Chen <vincent.chen@sifive.com>, paul.walmsley@sifive.com, samuel.holland@sifive.com, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.16 41/85] pwm: sifive: Fix PWM algorithm and
 clarify inverted compare behavior
Message-ID: <zecmbmpzmgjaccbjq2rh5z54ryqaqkbxup27yq7lzrxtncrqpn@4bmmk4bnhoai>
References: <20250804002335.3613254-1-sashal@kernel.org>
 <20250804002335.3613254-41-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="va72grwbkcpsl3ni"
Content-Disposition: inline
In-Reply-To: <20250804002335.3613254-41-sashal@kernel.org>


--va72grwbkcpsl3ni
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH AUTOSEL 6.16 41/85] pwm: sifive: Fix PWM algorithm and
 clarify inverted compare behavior
MIME-Version: 1.0

Hello,

On Sun, Aug 03, 2025 at 08:22:50PM -0400, Sasha Levin wrote:
> From: Nylon Chen <nylon.chen@sifive.com>
>=20
> [ Upstream commit 7dbc4432ea6bf9d709391eb57f1e9fb44e99845a ]
>=20
> The `frac` variable represents the pulse inactive time, and the result
> of this algorithm is the pulse active time. Therefore, we must reverse
> the result.
>=20
> Although the SiFive Reference Manual states "pwms >=3D pwmcmpX -> HIGH",
> the hardware behavior is inverted due to a fixed XNOR with 0. As a result,
> the pwmcmp register actually defines the low (inactive) portion of the pu=
lse.
>=20
> The reference is SiFive FU740-C000 Manual[0]
>=20
> Link: https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-86ed8b=
16acba_fu740-c000-manual-v1p6.pdf [0]
>=20
> Co-developed-by: Zong Li <zong.li@sifive.com>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
> Link: https://lore.kernel.org/r/20250529035341.51736-3-nylon.chen@sifive.=
com
> Signed-off-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Please drop this patch, see
https://lore.kernel.org/all/52ycm5nf2jrxdmdmcijz57xhm2twspjmmiign6zq6rp3d5w=
t6t@tq5w47fmiwgg/
for the rationale.

Best regards
Uwe

--va72grwbkcpsl3ni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiQjqYACgkQj4D7WH0S
/k4iBggApLj6vvJ2LMGHqDHEQN/u7J935iBi0I94MQlm/tIYmPbHnvNB9xBcob/B
ayq17ymltOYUuOzBCWf5QI7O2Amb7tZQ4b7Teg/EmuSvBUR8cfDiMAD7iR0VzX6v
u3jiXXOGIIf92EqD/ss2p/kR8AZl9k4YletARjoiulGEzXfS2YxoFm6CVoD8RNKe
WOGCGRXr82DZbYu0NB1oczwTqT7fjCIxF5yV9q7Qr1Cu+s3S4pLkWDAki7u5rjg0
mWfew9WUmTq3EgbznyF+GjJ94EZK99/j6XBiiLRgwD+G+KO/PnGeT9+vx1829cUU
VeCbx/X9p+FhpGeY4F0WQCdGWD7k6g==
=4nYN
-----END PGP SIGNATURE-----

--va72grwbkcpsl3ni--

