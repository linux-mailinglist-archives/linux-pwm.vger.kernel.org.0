Return-Path: <linux-pwm+bounces-7706-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17868C8D705
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Nov 2025 10:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9754E34F312
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Nov 2025 09:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F0B320CAA;
	Thu, 27 Nov 2025 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiCia616"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94791F7586;
	Thu, 27 Nov 2025 09:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764234380; cv=none; b=i2VKu8wwPLHXbrKl/ywdX0OnAJXMqPtFi5VN8rXvBle7bHHSMQgV73yu/zwYrfHttSWobRGarwqCKExYxCrPQwCAqtx84JZG9algpHBZK5KeF9WR1kwXnmGv6aacRIup5YBo/Pn4fMTYRQUtHeswo3fguqeIVL1V/zcZAArBmII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764234380; c=relaxed/simple;
	bh=ge3py+4MCp7Mg423L5dT8NctDgCuRZqI/wnwaIpcKTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=em0xyM8JDmxeTr2CRKt849LtA6uR2D/KmFG7di3/VM7/3qIwXNxKtomCINTzVStnD21zQlEfEgouRcTLLZ3+eFQVbhNXPBlA/bCn7FwV38IN7Ie7BgGKF6Ge9+uA81nOWNzvxYotksqvFAuA3k5pFGoR4xWWf8L9/m5TVJVPV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiCia616; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC8BC4CEF8;
	Thu, 27 Nov 2025 09:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764234380;
	bh=ge3py+4MCp7Mg423L5dT8NctDgCuRZqI/wnwaIpcKTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XiCia616ot9C7pnVRCnBhPQ/3ZaY3Q1KvKbfPDd5YM8mzvwPMip/Xmi6YmY58FtA2
	 3IalgqKpyMj93vKUbNpSe8UcDAG0iAbVMycjmPduI6vi47C9KqQzyAsc3q7YT8NffQ
	 Hx6PleJIAB7Z6hclg/AwQj2UCQuicITcNApW/qHjoYuryBJYW01snEVmLurGjYTlQA
	 GUQ9fhlMr4u4Evlqv9N+s6MygiUWuxjJbC4WRVN3ahS+LyI3GPfrzclc15SS0A4CNo
	 lgj2CRGkSkZNeXYW2bXmH74QbCcxUL30ThrkjTdOUeiyBt3rsbkR1VRHq4bswGanCf
	 hk7NbIKHNOZVA==
Date: Thu, 27 Nov 2025 10:06:17 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH v6] pwm: rzg2l-gpt: Allow checking period_tick cache
 value only if sibling channel is enabled
Message-ID: <wmc5r5j7ldnv4roac32tavejwj5twrjhy77iws5pqkh3zbfanu@psdcy543bjsf>
References: <20251126104308.142302-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="77zltqbkgywj6a2d"
Content-Disposition: inline
In-Reply-To: <20251126104308.142302-1-biju.das.jz@bp.renesas.com>


--77zltqbkgywj6a2d
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6] pwm: rzg2l-gpt: Allow checking period_tick cache
 value only if sibling channel is enabled
MIME-Version: 1.0

Hello
On Wed, Nov 26, 2025 at 10:42:48AM +0000, Biju wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> The rzg2l_gpt_config() tests the rzg2l_gpt->period_tick variable when
> both channels of a hardware channel are in use. This check is not valid
> if rzg2l_gpt_config() is called after disabling all the channels, as it
> tests against the cached value. Hence, allow checking and setting the
> cached value only if the sibling channel is enabled.
>=20
> While at it, drop else after return statement to fix the check patch
> warning.
>=20
> Cc: stable@kernel.org
> Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

I'm happy with the patch now and applied it to

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for=
-next

=2E I won't send it to Linus before 6.18, but it will be part of the PR
for 6.19-rc1.

Thanks
Uwe

--77zltqbkgywj6a2d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkoFIcACgkQj4D7WH0S
/k7K3gf8CkdPqX3ARHTincS6SUPKHrT7TCCg/gyj6pUc0FrC1rGlBprS7oUwO7Qv
nWRkLoZM6Hh2RCOEQk8ae+bTZyOiohVBYQtP725NE8L862zMaqRwnyghm4ZDlxKk
IoDp8rwTIaVjl1k+/9Q3oiwTHYCdR65TGTTR4XXIgsklUN6uQ4lefeNiPuMfTixn
bZGdlk9tjV/Sm8cKDSv1rEno6ZKBRpYUykMtcRqkJq3k6f+354X50YQBHDf+9MqM
nWS91P8Vb5MyxDv+fB+NazY65AVKC4qGUs/W6SUOmM6jwjyiFf9Ldxaz1rBe7ZzJ
x4ChbD6H/MOGC2yqhdxEtGkZqdduzA==
=Kmfh
-----END PGP SIGNATURE-----

--77zltqbkgywj6a2d--

