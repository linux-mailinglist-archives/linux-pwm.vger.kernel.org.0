Return-Path: <linux-pwm+bounces-7000-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2ADB21716
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 23:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2F9462883
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 21:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D912E2DD0;
	Mon, 11 Aug 2025 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1we82//"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FD32E285B;
	Mon, 11 Aug 2025 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946676; cv=none; b=fI0Dif0MGCO69scZfOR7ljHDjDo1uUnfMBNun4PSFVv5PboIGxi49p72mh4aE6KbGGUGkJb/AMINiXUj6b2CFoiMzzTRKYccFKDPmuLah1Vw308zQE9S/r2f+Wrnb56HFFFmntpFrhmAae9WRu8NBrG3EJ+s6znTvvKUpxYa58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946676; c=relaxed/simple;
	bh=GiMzNPUdom6LpwJOVXfmdvsrpf5L5vNqPJToueU7gX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVHYsB+cVHFCR11HcKzyBpQRrYka9EOFMS/oJHdeT7kxOj0pg3e3cMqPMI9QINNu9aSnBpxbTpxh8/lMRJ4OGf2v61ekKDQs66TQ+8S5TtdIX21haDMvghJRLx3WcJfg4mWlfcMInbEigoLQI6Hm5VFxcZgMuGWI6/Ug0OI3jVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1we82//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19986C4CEED;
	Mon, 11 Aug 2025 21:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754946675;
	bh=GiMzNPUdom6LpwJOVXfmdvsrpf5L5vNqPJToueU7gX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1we82//iorTlQ/NxDsUJQOYCWVLd2icuiWFD7dyboZjqN6Bn/WxCsw6/Sa4kJOG+
	 dm+l+nUC/da9E1BpwrAi7puaFAySpluYDfWqiNh4wRhGKRtZXhqUEJC+/maqtuErN1
	 SjvLnOVl0ZbMxkN8KJZXY6sBxHyfwahy77KA/7jvrf+5eQeEtb1fnPVsqsEvpITxh7
	 RYo5Yvm+asdmZe3MkBeo7PttLrjIW9TfYQJtNVThsMphNETcyWK9id1UGTMBzbM1T/
	 uXBNOaAeteITJlQQ7S2HKu4yLaY5zbT+SToH6FbXOUyR1x5f0KeBB/iG3+suJdFrVR
	 lAIRrQyFX0Q9Q==
Date: Mon, 11 Aug 2025 23:11:12 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Frank.Li@nxp.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ghennadi.Procopciuc@nxp.com, s32@nxp.com
Subject: Re: [PATCH v1 2/2] pwm: Add the S32G support in the Freescale FTM
 driver
Message-ID: <ejua4dgtdtlpr22xio6sywhaiyfjrjwdf744s73fz4zxhxyhrk@ep7o37hzwzvv>
References: <20250810185221.2767567-1-daniel.lezcano@linaro.org>
 <20250810185221.2767567-3-daniel.lezcano@linaro.org>
 <p5pwwdlrldqdkpqtfvgo3dz2liz46ywy7crjfe4nybxmrhlh55@b6v7lccczczs>
 <47ed1b83-9ace-475b-8279-6c7f394c35f3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2tvy32zt7ncrrsxl"
Content-Disposition: inline
In-Reply-To: <47ed1b83-9ace-475b-8279-6c7f394c35f3@linaro.org>


--2tvy32zt7ncrrsxl
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 2/2] pwm: Add the S32G support in the Freescale FTM
 driver
MIME-Version: 1.0

Hello Daniel,

On Mon, Aug 11, 2025 at 11:44:32AM +0200, Daniel Lezcano wrote:
> On 11/08/2025 07:18, Uwe Kleine-K=F6nig wrote:
> > All variants (up to now) have .has_fltctrl =3D=3D .has_fltpol. Is there=
 a
> > good reason that justifies two bools for the register description?
>=20
> Yeah, I agree it can be folded into a single has_flt_reg boolean. I can o=
nly
> guess that was done with the idea of sticking to the reference manual and
> perhaps having more variant to come with, eg.,  fltctrl=3Dfalse and
> fltpol=3Dtrue
>=20
> Do you want me to merge these boolean ?

That's the obvious thing to do if you want the new variant supported :-)

Unless you know that there is such a variant with .has_fltctrl !=3D
=2Ehas_fltpol to appear soon, I prefer the simplified handling with only
one bool.

> > Also I wonder about the fuss given that the two registers are not used
> > in the PWM driver. So this is only to prevent reading these registers
> > via regmap debug stuff? What happens if the memory locations are read
> > where the other implementations have these registers?
>=20
> The problem arises at resume time.
>=20
> 	/* restore all registers from cache */
>         clk_prepare(fpc->ipg_clk);
> 	regcache_cache_only(fpc->regmap, false);
>         regcache_sync(fpc->regmap);
>=20
> Without skipping these registers, the kernel crashes on s32g2/3

That's a useful information for the commit log.

Best regards
Uwe

--2tvy32zt7ncrrsxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiaXG0ACgkQj4D7WH0S
/k58Xwf/Zjf1uFWjpbwlJjnQdVYbt/qmlA7RXyNxLa9E/SnQeizlsdpSKquRCqJo
R/nrnJyJ/GO1oKm91Barl+XpUSr7dyxJ8mgFMtPtNKn/ItZEJDZXrxUn5hSJHzCL
aETQEkbwucRul6dBnCczX8ObCU44n4Gd7QRPSWP3dmQnPbAUiD9La5QWUhcVKpyI
vxGk69ROjMWD3XAOUApQlcloa2VNUa+Plrbqh85KPyMThd/a0z9LVSah8yPBSfOF
8B8EMSpEtpW/Yx0kosqJvEgw5F/IctL80kYxa5HmyQZ/PWyYmmWIR8Y9xhmirLJR
08JHQJkAupcmMPl8TuXzvVEn6kKV1A==
=XcLy
-----END PGP SIGNATURE-----

--2tvy32zt7ncrrsxl--

