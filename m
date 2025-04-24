Return-Path: <linux-pwm+bounces-5686-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66E4A9A425
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 09:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FA4922C6E
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Apr 2025 07:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECAB2206A9;
	Thu, 24 Apr 2025 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ7OlNoc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AEB2206A4;
	Thu, 24 Apr 2025 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479844; cv=none; b=I8w3d5pIxXJt+zJ4epADw2HAa5U6LXJJQwNtJWG7W9w23GlAzPf9vV2I/qATdHGtKA9t+79arNOtnFc5dJXEpBQsrt0Mar+2VOV/JoTnd0ZCXd9otzm2ClGoTXPD7pAqstPmxrjcA8gJwAj4MDzYxyXI4v2ZWaAkQtrEyp/jc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479844; c=relaxed/simple;
	bh=kWaWSxfzAOeVQlRkq60NVI4QsIYjUWB1A9Y9Nj3yPCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxyPswiG4sEs2kphvW34PdJKmbMZq/85kf2Bf5BWDL+THi7c4dSuPrwu/e8Dx9Fc74oxluUCNTsZxxp73iMiG/BMpYKOt4TwZjKBJ7HD4HUwGAUoU8uNPTMiXYqfxTobyXlRX0nFommHbLZxXE2/WXNDS9AqWsGXPkGlx9qB7+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ7OlNoc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332E6C4CEE3;
	Thu, 24 Apr 2025 07:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745479843;
	bh=kWaWSxfzAOeVQlRkq60NVI4QsIYjUWB1A9Y9Nj3yPCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQ7OlNocl570YDHdFBrRWtojdEaHxy3uXCFJRTphSz6caEYX3Mjrrd6kfU1f4GW/P
	 Wr2bPOYaIcwazz3rZYitkGXDa7+2r/bhW8k9aXIzvjjzBqWD710ELJEgb2FN6nmykn
	 eS2AGgfNb/x2F9IzAYl5tJ0Oom5DX/RLtMfxahI8Bu5hqlqPYaNNJ26hMuBvQ8kOXJ
	 5Ef0Y0kKWreEavHMtkQcFro+VaXMdOcRg/evsCGlChHVV4WtbKS/rH8/w5pRDdNZva
	 C5n6kNNPbX4Jr46Kp49tR1KVSw5pkVo2LTP4yfk3K318mnq4nRzj2t13pcdTekq/Uz
	 or9QNBxC28Hmg==
Date: Thu, 24 Apr 2025 09:30:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Guodong Xu <guodong@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	dlan@gentoo.org, p.zabel@pengutronix.de, drew@pdp7.com, inochiama@gmail.com, 
	geert+renesas@glider.be, heylenay@4d2.org, tglx@linutronix.de, hal.feng@starfivetech.com, 
	unicorn_wang@outlook.com, duje.mihanovic@skole.hr, elder@riscstar.com, 
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Subject: Re: [PATCH v2 2/6] pwm: pxa: add optional reset control
Message-ID: <mzfiyc2me2smqrrmiymzkzxvsyjmst6ggy7scq4wxz2yfj2ef5@np3h3k467mbl>
References: <20250420070251.378950-1-guodong@riscstar.com>
 <20250420070251.378950-3-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7v5t3ymowpvpmtvv"
Content-Disposition: inline
In-Reply-To: <20250420070251.378950-3-guodong@riscstar.com>


--7v5t3ymowpvpmtvv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/6] pwm: pxa: add optional reset control
MIME-Version: 1.0

Hello,

On Sun, Apr 20, 2025 at 03:02:47PM +0800, Guodong Xu wrote:
> @@ -49,10 +50,10 @@ MODULE_DEVICE_TABLE(platform, pwm_id_table);
>  #define PWMDCR_FD	(1 << 10)
> =20
>  struct pxa_pwm_chip {
> -	struct device	*dev;
> -
> -	struct clk	*clk;
> -	void __iomem	*mmio_base;
> +	struct device		*dev;
> +	struct clk		*clk;
> +	void __iomem		*mmio_base;
> +	struct reset_control	*reset;

Changes like these are the reason I prefer to not align the member
names. Luckily reset is a write only variable and you can just drop this
hunk if you use a local variable for it in pwm_probe() below.

>  };
> =20
>  static inline struct pxa_pwm_chip *to_pxa_pwm_chip(struct pwm_chip *chip)
> @@ -179,6 +180,11 @@ static int pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pc->clk))
>  		return PTR_ERR(pc->clk);
> =20
> +	pc->reset =3D devm_reset_control_get_optional_exclusive_deasserted(
> +			&pdev->dev, NULL);
> +	if (IS_ERR(pc->reset))
> +		return PTR_ERR(pc->reset);
> +
>  	chip->ops =3D &pxa_pwm_ops;
> =20
>  	if (IS_ENABLED(CONFIG_OF))

Best regards
Uwe

--7v5t3ymowpvpmtvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgJ6J4ACgkQj4D7WH0S
/k6xkwf/eaBJze5ndiNHEnGHJcgfmpTZsHwESV/Cwj5PIp5luRW90TAB1L3SoNyQ
OHH/mCf9BoZemUdaM1+uHqSp2Uh8OzQqpeEYckqGWi2wYTCsTtlrbpfm27MdnWul
BQB3NvoFTVtICfchbF3t2qqI9MPmgQTsx/RKES15cnEoscazo3G1o1txQDY1zneP
U3mHPCwcM1PmKZIjFsySl2ptMiVHqO3G8oKZvk91HPeScVjOkk3mH+qy9aNN/mFf
veMH70GVkuQSSAUC4tAX/fRjbSZMXdeClEHuZ1yZjYLPVx2HquRP7bnt89wRDGzf
BnV9zfqbbZHhqmBShnKP2GewNTFnUg==
=2AE+
-----END PGP SIGNATURE-----

--7v5t3ymowpvpmtvv--

