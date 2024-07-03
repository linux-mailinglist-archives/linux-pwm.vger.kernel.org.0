Return-Path: <linux-pwm+bounces-2664-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDA7924D39
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 03:44:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB809284C6D
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jul 2024 01:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5CC184E;
	Wed,  3 Jul 2024 01:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV1/ba8j"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F251FAA;
	Wed,  3 Jul 2024 01:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719971065; cv=none; b=h7R3Ohr6DhOy4ZxhkkcsG37o9M7crK6slhFwaqPj1dyA55E3ss7zQc+VY7K7UkTIwphEjjGrxj9C2pyzKbMSIq7C/ycu3ErfLjSaViiPAWi8LV3h4BgxqKurUgq7Cov22TLGnPJ+vFFKIFr7jLVFD7MJWwL026W80XrqXYWuDyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719971065; c=relaxed/simple;
	bh=42mTcGmLRkv0gLZBJggEWYL7CYdyKG+MNeqUzQmh2M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHn3OPogvY8dDl1tkmVn7Z/O5UVvAIhF51nktZLwHPBDNvsRzb1zjVzWGnTlXgQ7kDNLUQd/zl6izTeU8fPcwYMZuV8T7mbLP/LnVrDsoRthiTUvMLNcoXUoLrRCbPh1UE+slYmPwsJCfAp+zai7nz7WK5iZNHVCYAHwFTMIRSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV1/ba8j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CDB5C116B1;
	Wed,  3 Jul 2024 01:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719971064;
	bh=42mTcGmLRkv0gLZBJggEWYL7CYdyKG+MNeqUzQmh2M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hV1/ba8jri4uW/hdq1fo1Phlp5vxHC/78G3R3PdGKXYzHBnF8euCPl6/bOSKb9mfW
	 HBgHG/7/fv0Zs2+l/SdssQ8imeUfc96UW4vzGER2clro7QfwMlrRIIgXsLpltInN5f
	 D7STOdUUHcN2nvgj5wa1MQHOKG0dUKOjHxFESIkfgL/kA3IFQ0yXZ0a6Ps9br1ZrZw
	 NcODsZ4/UEVcz9RaMD4Qv5wmZF4Y9QLzBKQ+GXEHcKKgeUa9JKwQnuhWBr0nf4oItW
	 EOQTskB+rW+R19sik+GPIbZjZCXSccho8FXnzBGafyH92BWn38zbpW84wHB7FodNDj
	 59/+rJ72k9H9g==
Date: Wed, 3 Jul 2024 10:44:16 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thorsten Scherer <T.Scherer@eckelmann.de>
Subject: Re: [GIT PULL] Immutable branch between MFD and Counter due for the
 v5.11 merge window
Message-ID: <ZoSs8M3C72xAyG_J@ishi>
References: <cover.1718791090.git.u.kleine-koenig@baylibre.com>
 <20240626151343.GA2504017@google.com>
 <20240628142847.GN2532839@google.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cHosmM4QmEp1ldDc"
Content-Disposition: inline
In-Reply-To: <20240628142847.GN2532839@google.com>


--cHosmM4QmEp1ldDc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 03:28:47PM +0100, Lee Jones wrote:
> Enjoy!
>=20
> The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfab=
d0:
>=20
>   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
>=20
> are available in the Git repository at:
>=20
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags=
/ib-mfd-counter-v5.11
>=20
> for you to fetch changes up to 304d02aa711369da89b4f8c01702bf1b5d1f7abc:
>=20
>   mfd: stm32-timers: Drop unused TIM_DIER_CC_IE (2024-06-26 16:09:58 +010=
0)
>=20
> ----------------------------------------------------------------
> Immutable branch between MFD and Counter due for the v5.11 merge window
>=20
> ----------------------------------------------------------------
> Uwe Kleine-K=C3=B6nig (4):
>       mfd: stm32-timers: Unify alignment of register definition
>       mfd: stm32-timers: Add some register definitions with a parameter
>       counter: stm32-timer-cnt: Use TIM_DIER_CCxIE(x) instead of TIM_DIER=
_CCxIE(x)
>       mfd: stm32-timers: Drop unused TIM_DIER_CC_IE
>=20
>  drivers/counter/stm32-timer-cnt.c |   4 +-
>  include/linux/mfd/stm32-timers.h  | 179 ++++++++++++++++++++------------=
------
>  2 files changed, 96 insertions(+), 87 deletions(-)
>=20
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

Merged and pushed out to counter-next.

Thanks,

William Breathitt Gray

--cHosmM4QmEp1ldDc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZoSs8AAKCRC1SFbKvhIj
Ky8MAQCC9OFsKPs8E4VTmZK8Xqj6JXfh9iGdsN91Jg4gi36RXwEA0grMJ7WNXywX
ZzM6pVG8xYYtcsMeyAz9psBr/wCtkQg=
=1DWZ
-----END PGP SIGNATURE-----

--cHosmM4QmEp1ldDc--

