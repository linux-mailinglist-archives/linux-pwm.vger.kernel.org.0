Return-Path: <linux-pwm+bounces-7735-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CBDC94C6E
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Nov 2025 09:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F92F34300F
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Nov 2025 08:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CDE23C4FF;
	Sun, 30 Nov 2025 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axIp9aY8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4B1F872D;
	Sun, 30 Nov 2025 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764491156; cv=none; b=n3Jakywz6DEoxfoiJjZaJVYfz2sf9qYGYdEDLHAkWQ1LCf+r9OAozUMdH/D/1EKcWGr9l+lpnte2rRay9YfdjJcxFr8YAv5LZPlhzohkMRTcXS3iGgSziRgxJ7PvyWsLExXEPbFrwREOAhU6/+AvI6+bp3oCdooW5jVLVuPUmpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764491156; c=relaxed/simple;
	bh=PYHWnWKbcL0kYVp4X9GLi/I1tWsWC+HQPfK/nCT+Jyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q18+Sxsyo9LW9rJaW4B4vQHMUz1SP+9PrDjCJfrpLY5WC8qD/weZCwDMLkUbe93to5kp5OdxMpgDtB7T5/E631IqOxFudlzTljGHJqdXoBAYJuscZEo7EcDFn9v/LToOFTEWkKrc+GpaC+3m6wcLb5fTJvRKHNI2CXmYBGutIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axIp9aY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D7CC4CEF8;
	Sun, 30 Nov 2025 08:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764491156;
	bh=PYHWnWKbcL0kYVp4X9GLi/I1tWsWC+HQPfK/nCT+Jyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axIp9aY8OM5vCLiytXQHclaB6+3i7OF1h/2Ea8g6UPVwxA3g8fFlO6VT33AdkW9Uk
	 Z+E9hal4xTbXHWNtpnx2eaRjS1eupkdl+BT3RT/NoLqioEWHQE4dsZEpAx42j+SeOb
	 vm0WfkPvpBp6t0psP75pC7SAC76fQS8mM7b10DmWrUrf1m6sa2VUXZe+VJBYexavaQ
	 OaLx4jSgktPKePienlR2Pfh6Hzl6+AVcRERxjBPbNwGE8eddk7TvfgImunT7pZ6SwY
	 +5Cn+8rbKGuPuJGtrlkLrvuDkEBlW7hPmkAOB3hy/Iqu6WVMamEky3U84EJI4x57Jn
	 U801vqLdikysw==
Date: Sun, 30 Nov 2025 09:25:53 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju <biju.das.au@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: Re: [PATCH v3 2/8] pwm: rzg2l-gpt: Add info variable to struct
 rzg2l_gpt_chip
Message-ID: <lb4h7cm5jv7xngwihq3k3kgcj7a33suictdjztv5xcy75wpafd@i4rf44e5sigi>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
 <20250923144524.191892-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gbxvle4qyffyhowu"
Content-Disposition: inline
In-Reply-To: <20250923144524.191892-3-biju.das.jz@bp.renesas.com>


--gbxvle4qyffyhowu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/8] pwm: rzg2l-gpt: Add info variable to struct
 rzg2l_gpt_chip
MIME-Version: 1.0

Hello Biju,

thanks for your patience, now I finally come around to tackle your
series.

On Tue, Sep 23, 2025 at 03:45:06PM +0100, Biju wrote:
> =20
> @@ -46,7 +59,6 @@
> =20
>  #define RZG2L_GTCR_CST		BIT(0)
>  #define RZG2L_GTCR_MD		GENMASK(18, 16)
> -#define RZG2L_GTCR_TPCS		GENMASK(26, 24)

Even though this is only used once now, I wonder if it's beneficial to
keep the name to have the definitions relevant to registers all
together.
=20
>  #define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
> =20
> @@ -77,9 +89,14 @@
>  #define RZG2L_MAX_SCALE_FACTOR	1024
>  #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
> =20
> +struct rzg2l_gpt_info {
> +	u32 gtcr_tpcs_mask;

For consistency I would have called this only gtcr_tpcs without _mask.
But here I'm not entirely sure if this will be confused by the
occasional reader with the actual value. What's your thought here?

> +};
> +
>  struct rzg2l_gpt_chip {
>  	void __iomem *mmio;
>  	struct mutex lock; /* lock to protect shared channel resources */
> +	const struct rzg2l_gpt_info *info;
>  	unsigned long rate_khz;
>  	u32 period_ticks[RZG2L_MAX_HW_CHANNELS];
>  	u32 channel_request_count[RZG2L_MAX_HW_CHANNELS];

Just these two very weak suggestions. Please consider these and tell me
what you prefer. If you like to keep them as they are, that's fine for
me.

Best regards
Uwe

--gbxvle4qyffyhowu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmkr/44ACgkQj4D7WH0S
/k43zgf/ew3o+ezHQ1O5HVJrNo2L8TH08lcfpeEO0UIMbaZKbsXk3lbQYmmhnR/T
Sq8R/vwMR9pxuo26UDcpDBchbzShig++VsMWi6znPpQ5o9Yns2LikSp0e8avJUPs
kfqgvprNBSIwQT8JkvqdcgVkbz2cHFnvKA18pe9ryrmsjFJZQZKq9+OIWz6Rpmvw
o5fjHwzi5H9VyOFXn7TDfKRnGVK8UwCmrAVjoRSv2FkSIC4sQNH3DNyL/9r5I7Iq
nTcgO4JqmKpfDVRemlMdfvv5ZzqLT48DAjp67BGbpg1F9mAgi59SGFH7xqM9q5QV
ZzfTF0xJabAKpIuYyB9gONXbdrqn0w==
=BnQx
-----END PGP SIGNATURE-----

--gbxvle4qyffyhowu--

