Return-Path: <linux-pwm+bounces-6950-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018CFB19FE8
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 12:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309AC16FA2E
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Aug 2025 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34D7200BAE;
	Mon,  4 Aug 2025 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Am8XXDsL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875141EEA49;
	Mon,  4 Aug 2025 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754304328; cv=none; b=kMrCgsgQ89ETFz12Ow5K4CYEBehO064XyWNCpwANzQZ2Tg1QVh7Lra+JE+MPkPxiGOJP2NFhe1W7SOAzj3XDZ6FQ4qyg+r0heXYNfh1Xae8JBTIpPDjTZ+XM/z1xnyxdX2oCchd+lnVrHq9mvn9+ptcfbezAaqFj9eP/QyZCDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754304328; c=relaxed/simple;
	bh=rtsaWUajhwl7HqaJuXOdQM8ui9VtQUKyeIYR+6mQOEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QRqp0Ce9saA/YgSa6wR5ryQPAyYKT2U+6M33InlOs5+/2ZNBt5vZ4zwggEuTg6k+nzt0C9mEMjioDMFDPMDPJcH8QqYbdXJVrcaCgiD4gdZQ/+vtE2VRsDksMPWqRuKq+Oa5CVUeS1hJMBttF7rU4mEf006fqn7QaCmAwYvqJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Am8XXDsL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC83C4CEF7;
	Mon,  4 Aug 2025 10:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754304328;
	bh=rtsaWUajhwl7HqaJuXOdQM8ui9VtQUKyeIYR+6mQOEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Am8XXDsLutdMj01Ypv1GK768KA8uqK/DoqQSrS7fr5DnWfuDN0aCM5dvh4IngJLXM
	 Cz85uQ8RWlAEvIAgJZ0cIqDURNrdgAh8DFO9IC6S28aNzXjFcwMRnFYVr4bN5PLmLy
	 rBDzM9KgA3g+ELGnFH9XGIQfGI/UwXxni1yDu28O04nVTj8XQWVVzhQLQz3v6xbfeu
	 7nbDXwyA9po5SXQwfbCQFHgeWrzfDWGuNgZ6DR/htCbZkgc+Jfb5/wKzicydYuTm4l
	 V3nglhJA0LBX4ts2K1cQJoC3BrtgG2mTwv+8OdPP27bA/fo2Giw8w6xCblG7LhVpQz
	 emmoyQ7lMobaA==
Date: Mon, 4 Aug 2025 12:45:24 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, 
	Nylon Chen <nylon.chen@sifive.com>, Zong Li <zong.li@sifive.com>, 
	Vincent Chen <vincent.chen@sifive.com>, paul.walmsley@sifive.com, samuel.holland@sifive.com, 
	linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.6 28/59] pwm: sifive: Fix PWM algorithm and
 clarify inverted compare behavior
Message-ID: <xgy4dio2oqwqow7k5nlbf2vgrx63ptmtsi533wad7pfa3v23tk@nzrkhb2nytpb>
References: <20250804003413.3622950-1-sashal@kernel.org>
 <20250804003413.3622950-28-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ffr2hu7lxjke47gh"
Content-Disposition: inline
In-Reply-To: <20250804003413.3622950-28-sashal@kernel.org>


--ffr2hu7lxjke47gh
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH AUTOSEL 6.6 28/59] pwm: sifive: Fix PWM algorithm and
 clarify inverted compare behavior
MIME-Version: 1.0

Hello,

On Sun, Aug 03, 2025 at 08:33:42PM -0400, Sasha Levin wrote:
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
> ---

Please drop this patch from your queue, see
https://lore.kernel.org/all/52ycm5nf2jrxdmdmcijz57xhm2twspjmmiign6zq6rp3d5w=
t6t@tq5w47fmiwgg/
for the rationale.

This is the fourth mail of this type I'm writing. For the future: Is it
enough to raise these concerns once only and maybe even make it easier
on your end, too? If so, should I better pick the oldest or the newest
base version series to reply?

Best regards
Uwe

--ffr2hu7lxjke47gh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiQj0EACgkQj4D7WH0S
/k6oMQf+O4wdYC4RKeBWaggB5ZX3bh1tCXkDhGIpvm2OyM/W3MrVOVzUXSMjrNtm
ecvkwgDbn/USVwyOzHklS9m9/LfSY26y5XFh+XY6rArW8lb2OAVMjTWSrWLN2P5n
hkUTREkNNNJ0tj1/iFKGubbLPKw8pbjPe9QSEkcXvniQZKdvsd1VO2vwKIxWcgur
TQrdn+/UPXa+DW3LfinaeVPG9g5qMPhAV2esa0/DmrZ/RRikYxLu8HCWcrtTCGYw
nAfXXztH7v33LxjLcqta7zsG3f2QDBBhBZsodu1D11vjMkL2RvcwCAU/10ABDSXe
2XiXiVcXGexyUzBZdzMpcJxS0WETXw==
=ICmB
-----END PGP SIGNATURE-----

--ffr2hu7lxjke47gh--

