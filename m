Return-Path: <linux-pwm+bounces-6982-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E82B1FE79
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 07:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689B6189823F
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 05:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7428484A35;
	Mon, 11 Aug 2025 05:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtdkxPkS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421693FE7;
	Mon, 11 Aug 2025 05:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754889531; cv=none; b=Emn6Y5H27xer1X2wSfV+EdLb8kyboWrk4i9I98FnbMghcg6RRKxXX5uBromSp0D5afqylBHzWLU1x1DqtquPIU2EWHhWPKvA7WbIEAqFHJo5QXuVFb3JgmJZnwD08GTnzhNxtWuI58y9NfmWJXrTwNvNeAls3Avhr36gq4Zw2KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754889531; c=relaxed/simple;
	bh=iKMHjRdyP9XmmthZpNquqywenUL0QeWuDqaGBpVTFPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1BpiVbCFqyjhL5YFpWV4CtqhC0JAuIJIEHMREcuqgcHkm8ARzQJs6J7cEsAPS2eVigF8viPtUaywPKocDqv5Mu+EPdq4yPxxvLmlgQoNPlpJLbzpP15qvjl/hnGKJ7x6SjSmBA+Mt1lLh8yVO4ZlB2RO7ZeFXTPZf2FtBcCrDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtdkxPkS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22CBBC4CEF5;
	Mon, 11 Aug 2025 05:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754889530;
	bh=iKMHjRdyP9XmmthZpNquqywenUL0QeWuDqaGBpVTFPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HtdkxPkS3H/ytzLTzYr3ASnyRv9q0G1s0K5Tvj9jV61/zKw1oPpftqYtPfHYDVlNL
	 aCTJ6rSJcpg7Vtoub8Bw54+gAPptAEaq2DPiEgzMiqKFDJNbpT411A1HQnhrP/NJTE
	 oT3+qwnptVozXnokF4kNkfGu/kVhAphG1YjSYsRcG//rQLOXQ/QXD0rppKDBTEtw5B
	 pxEfnuC6tHpL7FxGa3zdbEkTg+3e7Ll2knll377FwsS8Z2axEzOLRkxLI2a/clnioJ
	 USFazZs2VrxWlGGWSBAlGcDbErXewVTeJauIsWrVDDT9nbMxWEOiNI12N3Vt2aGjrZ
	 a4h97dO3P/vJw==
Date: Mon, 11 Aug 2025 07:18:47 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Frank.Li@nxp.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ghennadi.Procopciuc@nxp.com, s32@nxp.com
Subject: Re: [PATCH v1 2/2] pwm: Add the S32G support in the Freescale FTM
 driver
Message-ID: <p5pwwdlrldqdkpqtfvgo3dz2liz46ywy7crjfe4nybxmrhlh55@b6v7lccczczs>
References: <20250810185221.2767567-1-daniel.lezcano@linaro.org>
 <20250810185221.2767567-3-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wzlnp52c7g72d727"
Content-Disposition: inline
In-Reply-To: <20250810185221.2767567-3-daniel.lezcano@linaro.org>


--wzlnp52c7g72d727
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/2] pwm: Add the S32G support in the Freescale FTM
 driver
MIME-Version: 1.0

Hello,

On Sun, Aug 10, 2025 at 08:52:18PM +0200, Daniel Lezcano wrote:
> From: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
>=20
> The Automotive S32G2 and S32G3 platforms include two FTM timers for
> pwm. Each FTM has 6 PWM channels.
>=20
> The current Freescale FTM driver supports the iMX8 and the Vybrid
> Family FTM IP. The FTM IP found on the S32G platforms is almost
> identical except for the number of channels and the register mapping.
>=20
> These changes allow to deal with different number of channels and
> support the holes found in the register memory mapping for s32gx for
> suspend / resume.
>=20
> Tested on a s32g274-rdb2 J5 PWM pin output with signal visualization
> on oscilloscope.
>=20
> Signed-off-by: Ghennadi Procopciuc <Ghennadi.Procopciuc@nxp.com>
> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/pwm/pwm-fsl-ftm.c | 42 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
> index c45a5fca4cbb..cdf2e3572c90 100644
> --- a/drivers/pwm/pwm-fsl-ftm.c
> +++ b/drivers/pwm/pwm-fsl-ftm.c
> @@ -3,6 +3,7 @@
>   *  Freescale FlexTimer Module (FTM) PWM Driver
>   *
>   *  Copyright 2012-2013 Freescale Semiconductor, Inc.
> + *  Copyright 2020-2025 NXP
>   */
> =20
>  #include <linux/clk.h>
> @@ -31,6 +32,9 @@ enum fsl_pwm_clk {
> =20
>  struct fsl_ftm_soc {
>  	bool has_enable_bits;
> +	bool has_fltctrl;
> +	bool has_fltpol;

All variants (up to now) have .has_fltctrl =3D=3D .has_fltpol. Is there a
good reason that justifies two bools for the register description?

Also I wonder about the fuss given that the two registers are not used
in the PWM driver. So this is only to prevent reading these registers
via regmap debug stuff? What happens if the memory locations are read
where the other implementations have these registers?

> +	unsigned int npwm;
>  };

Best regards
Uwe

--wzlnp52c7g72d727
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiZfTQACgkQj4D7WH0S
/k46YAgAiwVlwvJfiGDpL5Yj1GJPiQaq6KgOKd0HRhTH5Oo+fmyzpqaK9Tbb1UBf
PMq9s1ON4CFmn8NYHPai4WKTpzfCmKvN6d74TcnlngL8AzicTwlib13R3AmTt3ic
7WT67tlbuytrsV7nQqgFnn3QfpUH5zGbR3ZsGWGcFSrc0OsKq0gUNiFznKyLP5nS
J4Xz+zwAu4RD8mD67OACpLDVxXoM9VI+BcpbOSl8RPa3Fhuf7g9hlF5BSDaOX6ck
6jKXQmIYAFj/BYtVoag5LT6G5JTQ9rN0X+FETjVw4CQVyXp3EE/bgUeeJ7XStNEP
2mBsoZr7s0S7kwiW/n4acDt86OTTDQ==
=oVHp
-----END PGP SIGNATURE-----

--wzlnp52c7g72d727--

