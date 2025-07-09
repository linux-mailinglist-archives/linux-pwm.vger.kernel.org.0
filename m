Return-Path: <linux-pwm+bounces-6795-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B80B1AFDFC6
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 08:05:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECDF581F3A
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Jul 2025 06:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FCF26B2C8;
	Wed,  9 Jul 2025 06:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTmO4pte"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3231426A0FD;
	Wed,  9 Jul 2025 06:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752041108; cv=none; b=VClECMLQoXy0GZkOj25v4g1rCucGo/GdQr4aQV/l6pfmPbXDSJiLRks/sRKPasN0QKLA9VCnIEegdusjWHDWE8CMTby49UjOlmUDJLUds+VXA5sV+prlK5DSzMbTH418koPEEuXfRcU5Vi+XBW31w5qoruLIqXAqWdGw3BGGLxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752041108; c=relaxed/simple;
	bh=SzD8fsHU7duvdSUQLYizw2PuJGQ8kvETIYaho9kNf10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0C2z9BqF8gsL9v1Xyu/SO1+4L8Pyk+aVX5Tm8+aTbRl+cGbotgoBIT55UaqTGxzFlpBLd3xGvNgoMjviJJh2X9IuBlHkrnAfoLemL5P/bVm7DTGv+BksktU2tIGp5/SV341BBvubQgoEX8z4I3/tcGtMo5gGRHK/riITkDm6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTmO4pte; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181DEC4CEF0;
	Wed,  9 Jul 2025 06:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752041107;
	bh=SzD8fsHU7duvdSUQLYizw2PuJGQ8kvETIYaho9kNf10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nTmO4pteY97Kik7iPXm2GrBZ2k+ytY/51/0hYrDwr8tP2BmdFndwlFWeZJ02QxayF
	 bP+HnMSYmzi23Ssn6wqpMjW78n5yCy71sUQpG/ByD9rmbRjp8Fu1Heb65xhY55ftCw
	 SDCLTBwk04U+kQNIs3WyqmvuHvX6xTPHpLoFa3EpXJbaOKvntBEDo4W74kkRIxM5ZC
	 APgtU64n1gCyVeFJ6pKTAuAFtUiX6uBc/ibClllYw6J2knt2vAIU8q8j36W0B8tkCM
	 6DmMOv3mlUPoWFKtffaP6SoZFfBTKshsy7Mxoh3gt5cvUrUHnAE19vck0OwvLYdO6V
	 dov1haKVEqIpw==
Date: Wed, 9 Jul 2025 08:05:04 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	linux-pwm@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Subject: Re: [PATCH] pwm: imx-tpm: reset counter if CMOD is 0
Message-ID: <xo56zato6pgqqttdriskfgh4kdt2g6q5eg5jxte56uddkdfr63@sa7coeifbsmy>
References: <20250701220147.1007786-1-laurentiumihalcea111@gmail.com>
 <vwozlwajisjw5qomwtmnfdklmucevyxncsxl2cdmixn2yixxrk@x6j3r2lrl5qz>
 <a1b6039e-7020-4d17-8186-d40ac17ba730@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lxvmazlbdrmpdgwa"
Content-Disposition: inline
In-Reply-To: <a1b6039e-7020-4d17-8186-d40ac17ba730@gmail.com>


--lxvmazlbdrmpdgwa
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: imx-tpm: reset counter if CMOD is 0
MIME-Version: 1.0

Hello Laurentiu,

On Wed, Jul 02, 2025 at 11:31:28AM +0300, Laurentiu Mihalcea wrote:
> On 7/2/2025 8:51 AM, Uwe Kleine-K=F6nig wrote:
> > On Tue, Jul 01, 2025 at 06:01:47PM -0400, Laurentiu Mihalcea wrote:
> >> +		 * MOD will NOT reset the value of the TPM counter.
> >> +		 *
> >> +		 * Therefore, if CNT.COUNT > MOD.MOD, the counter will reset
> >> +		 * after UINT32_MAX - CNT.COUNT + MOD.MOD cycles, which is
> >> +		 * incorrect.
> >> +		 *
> >> +		 * To avoid this, we need to force a reset of the
> >> +		 * counter before writing the new MOD value.
> >> +		 */
> > Without the reference manual at hand or a deeper understanding of the
> > hardware this isn't understandable. What is MOD? What is CMOD?
>=20
> so, MOD is the reference value for the counter. The counter needs to
> count until this value is reached, at which point the counter value
> gets reset to 0 and the output signal is driven HIGH or LOW (depends
> on the configured polarity). This value is used to define the period
> of the PWM.
>=20
> CMOD, on the other hand, is a clocking-related configuration option.
> I'd say what we're most interested in here is the fact that if CMOD is
> 0 then the counter will be disabled. Otherwise, it will be enabled.

JFTR: I marked your patch as "changes requested" now in patchwork and my
inbox and expect an updated patch, but without holding my breath :-)

Best regards
Uwe

--lxvmazlbdrmpdgwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmhuBo0ACgkQj4D7WH0S
/k6dsgf/RheRWtMwEqe7uWfXT5aywFTiqSMVTEDTy8ZWFhJ977cgY7pWfCCqtk2U
RYLXoc+cp5FIhb0yBfk25qK5cHIzwVxE6p0H07itNWXjKlP2NYssB3ozzCv2Cer9
WNO/rZKF4TYaYI7cd6eqM0+HJZMABZuOBvJnMG7xGds3ktFG4OHkYUSQfcDIBUqg
Ty6LOq2LQMXKsT8IXzYYGlqGk8BblLKfgVyOing2W3+eKJCqI5R5G43S5dH5SZBR
1EAAEEfmzVviiRbe2hpYVSrRoTgfQjCPjX42QmIDH0lsgoGtzhHllP7l+hlImesh
RbFkCkmk8Aw6dTWrBeaF+89ovOg8lA==
=k8wj
-----END PGP SIGNATURE-----

--lxvmazlbdrmpdgwa--

