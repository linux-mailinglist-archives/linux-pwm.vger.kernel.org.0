Return-Path: <linux-pwm+bounces-4557-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DABCA07158
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 10:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845CC3A11B6
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 09:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51EB9215052;
	Thu,  9 Jan 2025 09:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp83uHH+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5FE20409B;
	Thu,  9 Jan 2025 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414599; cv=none; b=cFK4Z3E/mMEASJ6HgOvtiPWvdg373LRfq51CvuYxzqbwk2WwAczPPzWtkCQdbkrfTuwUIjBRSfJxQ+al3nghuODGTg2lj35awAq0NuSIzW9byWVLOzrWfZQMwsDDlo/uHg1msbkQqXh8R7PSUtVaCLtEiybRz83FDNBK98deAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414599; c=relaxed/simple;
	bh=Tm6LaQqvG5mvB+yVP+DebxZJ7+jxBQzzI05WiM+f2/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr3K7FMj49AWW4TVyGrBOt8zmcel0ZxSZWofIxWTZwzen50DJWM2/E80xJCHoPAGH06CZwPvWKzK6FtJ+Wqv8/vpzMC2bXWkVT1PEVRGck2oeiBCREpfNUKX0quF5dODI2HGLYnIZJahrpJllHvUkJmqT9kI2zkcVj6tNjFUnJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp83uHH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36038C4CED2;
	Thu,  9 Jan 2025 09:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736414598;
	bh=Tm6LaQqvG5mvB+yVP+DebxZJ7+jxBQzzI05WiM+f2/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tp83uHH+aaKF3+9eezlVgg39zvp9B85sX1w9kyI4B/NwEkZeJRLbuCFfLCQgTfyMP
	 MOeLTwAgnIzx8VMbcpq4NJjTWOWTVFNWg43alIy1vFiI5Wc67179OIQ5F201ovf0+n
	 zRmII+zKSB5F6pPqLlG7n1WJpmLk5nbNbdmNTzs8q9fgJGpALaqcwJk6p2YrSQ0GG9
	 vj2KiV4isWhxwCCgnQ09g9bhSM20Pcwsp/PEBS7J/Maa3mdEDkf41/1n1vuauhes73
	 2sxKIGF76zI/oPvahvyHlhV7u4kRAk35IKX8nx7EevCOPxNB/KUjtZQyD/BkOJDzYN
	 lZA7CzFuDO8wQ==
Date: Thu, 9 Jan 2025 10:23:16 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: kernel test robot <lkp@intel.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	"linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
Message-ID: <b7woae7iquvuzs4vcollns7qcyand4ginrbjqs75bnsiockrjc@c4pyody6zdcr>
References: <20241217132921.169640-4-biju.das.jz@bp.renesas.com>
 <202412182358.9wma1UUE-lkp@intel.com>
 <TY3PR01MB11346CC402843A628226F5C6186122@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4b5d23alxi7ewmst"
Content-Disposition: inline
In-Reply-To: <TY3PR01MB11346CC402843A628226F5C6186122@TY3PR01MB11346.jpnprd01.prod.outlook.com>


--4b5d23alxi7ewmst
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v23 3/4] pwm: Add support for RZ/G2L GPT
MIME-Version: 1.0

Hello Biju,

On Wed, Jan 08, 2025 at 02:13:09PM +0000, Biju Das wrote:
> Please let me know, if there is any feedback for this patch series or any new API to be adapted in next
> kernel version which simplifies the code, So that I can send next version.

I didn't look, but if you're ambitious you can convert your driver to
the waveform callbacks. Otherwise I didn't take a look into this
revision yet (also because of the kernel bot message).

Best regards
Uwe

--4b5d23alxi7ewmst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmd/lYEACgkQj4D7WH0S
/k7A2Qf8DVvH01S3oLDrc2muN/tozO0je67gkpPNLtD3r8B8Z+BW2w3rGC+C1M1i
ButK1Ug7mr72IbPhZwMwyrKxfVVgElPWCAiDXQ8lu024qVFNQ0UvZW7dkafYrwQH
+jymUGeh+ozMrPUsOUvfhXP9a3RV0RyTNzzY8ODRW8bRsBOdqxte+4Qmr9YFIoft
WyQMCwFqmiJ/ZaQC51MHcpaGl4Zd/Z5goUoG8plDyf4Zp342dLeSW7dV97J32dJU
WjGIXWpDsI9Ra9HrDtJcDFZHrvti103fbhqGNBPnn+A6pJuVktrJp7BCJ8yIQ5B8
IxbS6fj+Kq4rxDVAEhX3lET7qetrpg==
=mzbC
-----END PGP SIGNATURE-----

--4b5d23alxi7ewmst--

