Return-Path: <linux-pwm+bounces-7737-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76BC94C86
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Nov 2025 09:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DE4E3A4D71
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Nov 2025 08:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1E9236453;
	Sun, 30 Nov 2025 08:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzZtkNC8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A058A537E9;
	Sun, 30 Nov 2025 08:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764491952; cv=none; b=Q4AmavNUu6ZWlcCxeurjxlnDQFEF0UkEAp64NoDUMjFbQ5nhmHcD1oGmJp++tGQWvrmTEvtwANleoTbR5gNXqHjOvYHhqvjthY1SkOS3zQaGuV468xtvRPWZ0mQTngwD1vVYIjpeWlJhfvIAQLJzW8W9WD2ad2uJqKBA2ZngmLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764491952; c=relaxed/simple;
	bh=8vOTHzmCf5/xvLzxXR0X3YKXDP9IWOBID+jKXczDy3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqpufrjnvO2tVZDaBjhzz9JPzFsPldW6qnsIb4hRPDvVsgkgh1Z3UFRBMgHgchn7UESEeHmVV2f29nbKeB3IoonU3wL4nVRn6lVqIZ30zuJOBxwjvc4mcGBrPIvVUZseuEuW99x9Pw10U5ONLIFg8IC0H2iIQUGwpQSxaJdY780=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzZtkNC8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD02CC4CEF8;
	Sun, 30 Nov 2025 08:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764491951;
	bh=8vOTHzmCf5/xvLzxXR0X3YKXDP9IWOBID+jKXczDy3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DzZtkNC8Xd0tiq6r9WOePBDc46yzXn2Iuy8Tj2QtqFS3WYMtSpzLXLs1l6wpUg80R
	 kum8IIn3wIGsZPo503JiNE2C1eKLIAQsB+wvlvJeDHfr+Z8SKFFTL7cs+apTljo3fv
	 f2miwH4pYWPtGvQkRzQCV8vWcU4x8qr6qb8BKsfwtfSvpkGhOhdFfjb6D0HUQUVz5P
	 Fo0IVYKrrv2Gxxrh+vSvBsS7pdPGcp+84BOFAre87N5xqTwvrzesGxp+5YE8z1FOOp
	 NjG8YKqlxMXUGdjKw3Tb1Vw3Ai8oQD421CnAkl7qPOoVdQj/MUJUmLvg1h7gfu/ABT
	 9vAcYtyxyP/jA==
Date: Sun, 30 Nov 2025 09:39:08 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, 
	Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
Message-ID: <wah57av7ypb42zcaosx7n64j6qmmcq5ylhgnde2brbiy6o7sun@7rqkr6ke3g5k>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-7-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rpnzmdgir2lvb6ia"
Content-Disposition: inline
In-Reply-To: <20250923144524.191892-7-biju.das.jz@bp.renesas.com>


--rpnzmdgir2lvb6ia
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v3 6/8] pwm: rzg2l-gpt: Add suspend/resume support
MIME-Version: 1.0

On Tue, Sep 23, 2025 at 03:45:10PM +0100, Biju wrote:
> +static int rzg2l_gpt_suspend(struct device *dev)
> +{
> +	struct pwm_chip *chip = dev_get_drvdata(dev);
> +	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
> +	unsigned int i;
> +
> +	for (i = 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
> +		if (!rzg2l_gpt->channel_enable_count[i])
> +			continue;
> +
> +		rzg2l_gpt->hw_cache[i].gtpr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTPR(i));
> +		rzg2l_gpt->hw_cache[i].gtccr[0] = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(i, 0));
> +		rzg2l_gpt->hw_cache[i].gtccr[1] = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCCR(i, 1));
> +		rzg2l_gpt->hw_cache[i].gtcr = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR(i));
> +		rzg2l_gpt->hw_cache[i].gtior = rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTIOR(i));
> +	}
> +
> +	clk_disable_unprepare(rzg2l_gpt->clk);
> +	clk_disable_unprepare(rzg2l_gpt->bus_clk);
> +	reset_control_assert(rzg2l_gpt->rst_s);
> +	reset_control_assert(rzg2l_gpt->rst);
> +
> +	return 0;
> +}
> +
> +static int rzg2l_gpt_resume(struct device *dev)
> +{
> +	struct pwm_chip *chip = dev_get_drvdata(dev);
> +	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
> +	unsigned int i;
> +	int ret;
> +
> +	ret = reset_control_deassert(rzg2l_gpt->rst);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_deassert(rzg2l_gpt->rst_s);
> +	if (ret)
> +		goto fail_reset;
> +
> +	ret = clk_prepare_enable(rzg2l_gpt->bus_clk);
> +	if (ret)
> +		goto fail_reset_all;
> +
> +	ret = clk_prepare_enable(rzg2l_gpt->clk);
> +	if (ret)
> +		goto fail_bus_clk;
> +
> +	for (i = 0; i < RZG2L_MAX_HW_CHANNELS; i++) {
> +		if (!rzg2l_gpt->channel_enable_count[i])
> +			continue;
> +
> +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTPR(i), rzg2l_gpt->hw_cache[i].gtpr);
> +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 0), rzg2l_gpt->hw_cache[i].gtccr[0]);
> +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCCR(i, 1), rzg2l_gpt->hw_cache[i].gtccr[1]);
> +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTCR(i), rzg2l_gpt->hw_cache[i].gtcr);
> +		rzg2l_gpt_write(rzg2l_gpt, RZG2L_GTIOR(i), rzg2l_gpt->hw_cache[i].gtior);
> +	}
> +
> +	return 0;
> +fail_bus_clk:
> +	clk_disable_unprepare(rzg2l_gpt->bus_clk);
> +fail_reset_all:
> +	reset_control_assert(rzg2l_gpt->rst_s);
> +fail_reset:
> +	reset_control_assert(rzg2l_gpt->rst);
> +	return ret;

I wonder what happens if these calls in the error path fail. I think the
correct way would be to track the actual state to handle the state on
the next invokation for .resume() properly. But note that suspend/resume
is a somewhat blind spot for me, so I'm unsure here. (And I'm aware that
most resume callbacks don't cope cleanly here.)

I added linux-pm to Cc:, maybe someone can speak up about the
expectations here?

Best regards
Uwe

--rpnzmdgir2lvb6ia
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmksAqkACgkQj4D7WH0S
/k60Ogf9EdyzCceL/FLLmM6ywlVMBetlhlj4ZfpVCmPlBWdb++La6jxCUTGORaR/
OWqSwsXCRbIY+tIMSf+tIfUSgkbia3RdeXE3FJZwkn+N2zvuEBJ4h8k074JZGP96
xsYiYyTaNkclG2toCuCezWfVeSZRG24Uj6SKbF/uwEjEUl2zczY8DXEucBb6NtK6
0IdRNbV7l2K1doE3B5uDmG3H4kYpSfnnKAxOj+QUvTQFO9HOaO0QkCNJ6m6r83nQ
C4t06Ef7qpMJBO75vmK6Hpg9S/HTuElfZbBOSf0/H+Hq8rpg0nS2jAYOrBAitrVL
HjU98hnT35ob0Kzi+XqJroMWhFF7RA==
=0pJy
-----END PGP SIGNATURE-----

--rpnzmdgir2lvb6ia--

