Return-Path: <linux-pwm+bounces-5325-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A7A7A5A3
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 16:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC293AD303
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Apr 2025 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE8824EF7E;
	Thu,  3 Apr 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExO5LxSL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59651F4CBA;
	Thu,  3 Apr 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743691480; cv=none; b=RBXx325OPpqRdpmztW2O7P/T/1DQMcwG1pFT0ujj8K5aVn/X1AO6cztmjFzCLaFq4xiDaYDUFBtbXbcCDq/AGhr8n8aFmATe1yMZGSxu6SXYDc+O2+/1bkp/CzqAalocl+FVYwP1X3qtkhgfs+HdQftmmRlFShiOkycsGSqZMSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743691480; c=relaxed/simple;
	bh=5cs+eJv9Izu47I2J3NXxyVbwPDeNCqJD2YuijQFC92o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Si4a0CiEn3Uit6ji+8kf0vZLdTVPLUms3QOCObvYW78c4zS7hIp8VeuhSQQAMhIn2jHbxOxu9nuEdvKIyOsHplFOYwV4ZNhI1oFPajHB9Lzs+v0LXU7Dl8LmbiWqCP1zZB69TtTvg7V2MWdO7r4lfVput5OgDP7SVIGjAX3/38s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExO5LxSL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AFDC4CEE3;
	Thu,  3 Apr 2025 14:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743691480;
	bh=5cs+eJv9Izu47I2J3NXxyVbwPDeNCqJD2YuijQFC92o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExO5LxSLKI8SpDKDmAe2trw+n1wCOphVhp8nC42JmUFBPWkCpVbITDZt9hWyttE0Z
	 mY2sOHy8Efvzxs2cuY47HJjV6hjtMDVGZzMH/o/KAZL2vnAbyomCRJusrs0s8rQi3k
	 hqWlwE1e/UFjquaxc/+qXZhaoezXaNuxS/yFztiJTrJTkSbfCz0qgU+HoXnTeOB/wE
	 m61GM8Mmin7+Geyfy8dXXC4txdkAQNjJ1QH+bWG3f/dUbuZEeaCOuZlEbFDPPndZeC
	 EPqpcCUHZfbq5DMMjggmPz7ZQPrg58z08jzZXh59VLrAKmpXkPTtxz3soiuWir3iRO
	 SCca/CttFJXVw==
Date: Thu, 3 Apr 2025 16:44:37 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pwm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: rcar: include linux/bitfield.h
Message-ID: <oliggucdkxoowajjgszzxips77x4p4y6v4wav56r6cqzu6cdil@rghywo2xqrrm>
References: <20250403132406.81003-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vjcxojrerajqyepf"
Content-Disposition: inline
In-Reply-To: <20250403132406.81003-1-arnd@kernel.org>


--vjcxojrerajqyepf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: rcar: include linux/bitfield.h
MIME-Version: 1.0

Hello Arnd,

On Thu, Apr 03, 2025 at 03:23:59PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The use of FIELD_MAX() breaks in some configurations because of
> a missing header:
>=20
> drivers/pwm/pwm-rcar.c:114:12: error: call to undeclared function 'FIELD_=
MAX'; ISO C99 and later do not support implicit function declarations [-Wim=
plicit-function-declaration]
>   114 |         if (tmp > FIELD_MAX(RCAR_PWMCNT_CYC0_MASK))
>       |                   ^
>=20
> Fixes: edd549f4956b ("pwm: rcar: Improve register calculation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I already fixed that in my pwm/for-next branch. I did exactly what you
did and squashed that in the offending commit.

Thanks for caring
Uwe

--vjcxojrerajqyepf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfuntMACgkQj4D7WH0S
/k76Xgf/Zzgpc8cJHu8poSgQZDscT002xpFBpC/b6bZvJr0a3kuyFsOmwGeFCUgh
cKHRNTinIIWfhPTJLq3Zz5Ys23P5auhQ0K7TojrWPqOfEAV+9speGL2Phtgn0xWJ
L4ZS3JOGF0otVkw/5nzdA9Ys8hJaoWxktxOl+rP3rhlCNof6LVxT3luHIVHkdIoE
bjwdPB6adc8BowfGInDG57zD5BBn6YjNjduitEco3Hf3/cfAOkEag4/j3U/jeei9
pDINFtccx7HU05M4I7j0BhyBe+YGH7SDAA9GtiS8llC6B31zotb5mj4Wrsa4F9/v
gt66wr70v+hbSMpYRjVSTFs4URqQeQ==
=miw2
-----END PGP SIGNATURE-----

--vjcxojrerajqyepf--

