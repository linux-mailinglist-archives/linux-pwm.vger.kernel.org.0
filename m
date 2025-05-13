Return-Path: <linux-pwm+bounces-5941-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF9AAB4FE7
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 11:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201804675D2
	for <lists+linux-pwm@lfdr.de>; Tue, 13 May 2025 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A35121CC47;
	Tue, 13 May 2025 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwpRdnqF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6333321C9F6;
	Tue, 13 May 2025 09:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747128822; cv=none; b=EaQ6sIYN7J6ALTf8nVup2WwvP0YGIRa3Kl7VDV5Cs6qd0Wamatae9O3zaiuizFejh85exjgX0Es2c5Iub/ACFIQzA4hRfkcDmfAsvlIASGJbvkm+OvJht+XP/sVNSmPheOa6zTLg7QlsXRP7v/lw6UNLymnNhvaH26Bmw6SZvdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747128822; c=relaxed/simple;
	bh=Sj/IHno6JWyo/c+Z7kQKRTXDflepGjZuWMaOcKv6Oug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+cSXbZIBxkUKzMkjcPugei7xBoRn5fRI5yVupjZ9rHA7xLZnHgSDkXu1gdxu+jz3E2HBCb3TNj+WDYBzN+UNDlKQOE3j7h+NtivZ1JumDY0EDW6DtBSiDszcsAvomkDRmSubMZZalNiboNUNkSosver4LvmuWAknQnswPBkRj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwpRdnqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6F1C4CEED;
	Tue, 13 May 2025 09:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747128820;
	bh=Sj/IHno6JWyo/c+Z7kQKRTXDflepGjZuWMaOcKv6Oug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VwpRdnqF1vbf3WQEgBMxS5eDUhabPvoP9kBABb252GrK65RCn6Qotc0n9Vl80lUbg
	 mO3NxPNneEOE+mzt6xq7LHpPqmyo0lCeuHamRtc+vhHAF6poT3vtSzdHn2/PN/v5r3
	 DqTBmUy+DedX3zOdRNcY8ZpSdc1UX6jogYEBsnBpWvLDdWnBtcCcEc7/cB2E2/zn8m
	 ZHCFmqCs7N6gl0+l61zYweHamJ+hSKZt/2Xfndy2dyCxeyZdG1tKyY6MY43mDaA5va
	 fp/Rr+4ga0CJQOguzV6+T3279gl6MqMbGFc8JwDrz6mrzX2wLSvfchdr0sAKGl5lxH
	 aTm+FtWh7khng==
Date: Tue, 13 May 2025 11:33:38 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] pwm: tiehrpwm: ensure clock and runtime PM are
 enabled if hardware is active
Message-ID: <xuprgpxmzbdi6yq74xpzpsuzytpuy7x5ektq2pt3l4vd7f2rhw@gpsxqzrhljg6>
References: <20250419195555.78933-1-rafael.v.volkmer@gmail.com>
 <20250419195830.79053-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="alstrvmifjlefene"
Content-Disposition: inline
In-Reply-To: <20250419195830.79053-1-rafael.v.volkmer@gmail.com>


--alstrvmifjlefene
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 3/4] pwm: tiehrpwm: ensure clock and runtime PM are
 enabled if hardware is active
MIME-Version: 1.0

Hello Rafael,

On Sat, Apr 19, 2025 at 04:58:30PM -0300, Rafael V. Volkmer wrote:
> During probe, if the hardware is already active, it is not guaranteed
> that the clock is enabled. To address this, ehrpwm_pwm_probe() now
> checks whether the PWM is enabled and ensures that the necessary
> resources are initialized.
>=20
> Signed-off-by: Rafael V. Volkmer <rafael.v.volkmer@gmail.com>
> ---
>  drivers/pwm/pwm-tiehrpwm.c | 46 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index cde331a73696..23530d53e177 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -583,15 +583,50 @@ static int ehrpwm_pwm_probe(struct platform_device =
*pdev)
>  {
>  	struct device_node *np =3D pdev->dev.of_node;
>  	struct ehrpwm_pwm_chip *pc;
> +	struct pwm_device *pwm;
> +	struct pwm_state state;
>  	struct pwm_chip *chip;
>  	struct clk *clk;
> +	bool tbclk_enabled;
>  	int ret;
> =20
> +	u16 aqcsfrc_reg, aqctl_reg;
> +
> +	u8 csf_bits;
> +
>  	chip =3D devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
>  	if (IS_ERR(chip))
>  		return PTR_ERR(chip);
>  	pc =3D to_ehrpwm_pwm_chip(chip);
> =20
> +	pwm =3D &chip->pwms[0];
> +
> +	if (pwm->hwpwm =3D=3D 0) {

This is always true. And actually a lowlevel driver shouldn't need=20
chip->pwms at all.

> +		aqcsfrc_reg =3D readw(pc->mmio_base + AQCSFRC);
> +		csf_bits =3D FIELD_GET(AQCSFRC_CSFA_MASK, aqcsfrc_reg);
> +		aqctl_reg =3D readw(pc->mmio_base + AQCTLA);
> +	} else {
> +		aqcsfrc_reg =3D readw(pc->mmio_base + AQCSFRC);
> +		csf_bits =3D FIELD_GET(AQCSFRC_CSFB_MASK, aqcsfrc_reg);
> +		aqctl_reg =3D readw(pc->mmio_base + AQCTLB);
> +	}
> +
> +	if (csf_bits)
> +		state.enabled =3D false;
> +	else if (aqctl_reg)
> +		state.enabled =3D true;
> +	else
> +		state.enabled =3D false;
> +
> +	if (state.enabled) {
> +		ret =3D clk_enable(pc->tbclk);
> +		if (ret) {
> +			dev_err_probe(&pdev->dev, ret, "clk_prepare_enable() failed");
> +			goto err_pwmchip_remove;
> +		}
> +		tbclk_enabled =3D true;
> +	}

You don't check the 2nd PWM, this is needed however. You even need to
call pm_runtime_get_sync() twice if both PWMs are on.

>  	clk =3D devm_clk_get(&pdev->dev, "fck");
>  	if (IS_ERR(clk)) {
>  		if (of_device_is_compatible(np, "ti,am33xx-ecap")) {
> @@ -626,6 +661,15 @@ static int ehrpwm_pwm_probe(struct platform_device *=
pdev)
>  		return ret;
>  	}
> =20
> +	if (state.enabled) {
> +		ret =3D pm_runtime_get_sync(&pdev->dev);
> +		if (ret < 0) {
> +			dev_err_probe(&pdev->dev, ret, "pm_runtime_get_sync() failed");
> +			clk_disable_unprepare(pc->tbclk);
> +			goto err_pwmchip_remove;
> +			}

indention inconsistency.

> +	}
> +
>  	ret =3D pwmchip_add(chip);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> @@ -637,6 +681,8 @@ static int ehrpwm_pwm_probe(struct platform_device *p=
dev)
> =20
>  	return 0;
> =20
> +err_pwmchip_remove:
> +		pwmchip_remove(chip);

That's wrong. When the `goto err_pwmchip_remove` is taken, pwmchip_add
wasn't called yet.

>  err_clk_unprepare:
>  	clk_unprepare(pc->tbclk);
> =20

Best regards
Uwe

--alstrvmifjlefene
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgjEe8ACgkQj4D7WH0S
/k6WcQf6As9HDrKAdYQLfhoEDviF9oYxaq/KdEpvdNj9bgEeiByBs+vxJQywhXEq
2GPqdCjZCwCwzMdSAWbE3GKIzHk4ylCz+PMul8KETGZ0F6hR6174vfQcEq4hFoQs
0Kq9vuyi089QAdESMCx+7Hw+4Bt8TV0Zh088OPXTVsPLUxdFEoHN3+MDwKdXjQTc
+RSsFXTsWJCruaExFFPHfRhu4JQi/Rmz6TMhHmxqh5zYM5egIVarb08STEseJA/h
bybbmrvgwqtRkA1iOMQdkM8WiQ2JnEx88HIKFKxnFgrj4pTs6UyU1NOfKnky3upK
e8SnM02mWCA0MjEEq3LB68B7dvU6WQ==
=nTAZ
-----END PGP SIGNATURE-----

--alstrvmifjlefene--

