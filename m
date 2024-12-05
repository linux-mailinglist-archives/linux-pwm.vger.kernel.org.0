Return-Path: <linux-pwm+bounces-4247-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9629E4FCE
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 09:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252851694A9
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 08:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43EF1CB332;
	Thu,  5 Dec 2024 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOVY2eow"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA6B189B94;
	Thu,  5 Dec 2024 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387676; cv=none; b=Jihh+HnaGMcMyjIhsrp4n0qjBNjoqB7OdO7F0BrW3NESEc2uVtStqBm2p5FqCFS3Rrd6Sdh5jHpZ7NZT3jOMUY9YSJe2V+JJOjkB6iTALENmTOPzARWVzm+P+IeFNa5Izux6Cha82HwZ4WzL+GINI3v1UOwveAZIIlYwvv7oYRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387676; c=relaxed/simple;
	bh=gKCbD7Svx+y4jFvtnoFhWfAzzEJNorqOmAWV9TmCq9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KA2OJZvHDPd7Y1gManzvOnfTi9w5gXfjmKrkR67DYv0C/hTs7r70h4kKIfsgWBWght7m7K/cLeLgz8pYh9HRmfxyvaAgo2WmUSFn4zRbESeHB0QMWHkXapL3DNrb1yYjGey4dVp3CZh+kzFg/hwmohDP8HW9C4FyaDaR0cFeHb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOVY2eow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF60C4CED1;
	Thu,  5 Dec 2024 08:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733387676;
	bh=gKCbD7Svx+y4jFvtnoFhWfAzzEJNorqOmAWV9TmCq9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOVY2eowOfL3vNW8Xwy5XggMKNW3YYHT+8993h3w9/y8N1zctDMuY7oVKQfrb/Shm
	 XZoSoyO7+uNHD8uaqywzHVzQdlixDFafBXjnbpSJiNKB7dJ4WF5wC/wYemnYNRPl7D
	 30F4TCXZQPxhMIo8oO/P6rN10HxY/wFCS+nieVBBTB/MrCWCHYSIOdCv0G5aSrwMtL
	 6cLO7bCYv6wsLJC+NDMaCd93D4AZ01fRD8MBXj3QhMlNNdK3fCbHxiZAYJQ0uLndCY
	 TGVt4FZ1Xyh8sDS1ekD1atTSyi3kuhNvWTdcVeG0NQLTn9HuWutbzvaaQuyz6bQrbJ
	 k6oIIa9CsKNlw==
Date: Thu, 5 Dec 2024 09:34:32 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mingwei Zheng <zmw12306@gmail.com>
Cc: fabrice.gasnier@foss.st.com, coquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, thierry.reding@gmail.com, lee@kernel.org, 
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: Re: [PATCH] pwm: stm32-lp: Add check for clk_enable()
Message-ID: <geyicxufezkbu7cdvnbgnr2qeuwrn5ubz5ent3spk5biuozxrs@gsqx2chgiiot>
References: <20241205051746.2465490-1-zmw12306@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="shdmdu5ypwpb65ru"
Content-Disposition: inline
In-Reply-To: <20241205051746.2465490-1-zmw12306@gmail.com>


--shdmdu5ypwpb65ru
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: stm32-lp: Add check for clk_enable()
MIME-Version: 1.0

On Thu, Dec 05, 2024 at 12:17:46AM -0500, Mingwei Zheng wrote:
> Add check for the return value of clk_enable() to catch the potential
> error.

Is this something that you actually hit, or just a janitoral fix you
noticed while browsing the code (or reading some checker output)?

> Fixes: e70a540b4e02 ("pwm: Add STM32 LPTimer PWM driver")
> Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
>  drivers/pwm/pwm-stm32-lp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
> index 989731256f50..4abef304417d 100644
> --- a/drivers/pwm/pwm-stm32-lp.c
> +++ b/drivers/pwm/pwm-stm32-lp.c
> @@ -163,12 +163,16 @@ static int stm32_pwm_lp_get_state(struct pwm_chip *=
chip,
>  	unsigned long rate =3D clk_get_rate(priv->clk);
>  	u32 val, presc, prd;
>  	u64 tmp;
> +	int ret;

Please move this variable to the block where it's used. No need for such
a big scope.

Otherwise looks fine.

Best regards
Uwe

--shdmdu5ypwpb65ru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdRZZUACgkQj4D7WH0S
/k4TXwf/Wzw/hs8+EisqpH4An6STPdmc8pwIJCKQu1lwE6fQKkTYk5nYTs4JMxRx
9JLhTTsBNGJrQ3mjJrjjOEPscREqkZoVBxdlZFEPaPpYukjgvSiYQwvPERXQNqbR
y+Xb+CZuo5cITA51Jd3UDRIHktAIABl3Ox8GcqDhGgMq1Cje+XE24dwQ85kMyFJq
2ncZRb7TuNhF9XtQkUmGcWXsEUq5iVlhG25UziKlX+ZhMz9MJaU5LnVOFSy9HAPb
DTUS7vmaNGJiePZagOduLZ5Z/f7q/xMu311Xi4ylcjc59I54Ohp+VKuEnTMVzqaR
R1M+5N2Zbe9/BZGXpnHvfs9MOLb7pg==
=wFbu
-----END PGP SIGNATURE-----

--shdmdu5ypwpb65ru--

