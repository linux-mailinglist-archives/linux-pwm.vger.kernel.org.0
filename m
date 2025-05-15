Return-Path: <linux-pwm+bounces-5988-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFFFAB7A6B
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 02:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30769864D1F
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 00:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF574A24;
	Thu, 15 May 2025 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIuWhMx4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DEF10E3;
	Thu, 15 May 2025 00:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747268168; cv=none; b=NltY7d/gJNO98sMhsnRkhiuRlp+tQH+Yflp7BA3+NVjYyekDZck4mTYdZzyvVJJO6EFenXrryz8R73e2/dTHAZV63KkqD8fY4TLrAMmJUN6vc1xRdD4rAcFGalnT5f/G+70KxCfx49wZk8xutzevv4tqarVjXjcLHq2JOavkXgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747268168; c=relaxed/simple;
	bh=uW+M74PgZ3HUM5ZEy0wgLlqjqjzVMkF8sZFdMOczPhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3Nkg0dhThbIxhdPaiEJRHF/Z0RzAhxIqF0YGhXtHYPOUzz3Ps5BGlmo4dQIjho7dSGGzw4Fxu1yCLQRF7eEIVLwLwatBUB3R6I6Myofv3nZUEpWBKf5jDhE9TOjKx9mmVj5LSvrETpGEI3JtmxShbuAY9Chw9S6Xwe927PNRhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIuWhMx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235B7C4CEED;
	Thu, 15 May 2025 00:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747268167;
	bh=uW+M74PgZ3HUM5ZEy0wgLlqjqjzVMkF8sZFdMOczPhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RIuWhMx4JqXHZhe2E9bp6Vc1XY9dfVCBB++H6KbySgeSdUtzfusiMCGBnctJKEq3p
	 17OVJRcKrv2iBQ8f6WfGuEeSn6Vy/jEoQFZcxtU2kn+skcX00xLYtYTpAi/hybtPIS
	 X3UaDxNvm2qpl2xD6KAOWxCAIlGFxjtSrcEpS0oJ/oj/2Tfjwom7kTg9Dn1R5RBCq3
	 qITvNErXeKTO1GYC85vUUhMll/tcXxP5SBQTIudYtKfUnacXiGcAMjoB123frXVFT3
	 Z2vtEr/zZRnLe48T9ba+7n8l09dG8bcJ4oVK8+WonJCPkQsPmToFVoHNu51hP9sere
	 ZW3DkRPAJx12Q==
Date: Thu, 15 May 2025 09:16:01 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: jic23@kernel.org, alexandre.torgue@foss.st.com, lee@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	catalin.marinas@arm.com, will@kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	olivier.moysan@foss.st.com, ukleinek@kernel.org
Subject: Re: [PATCH v3 3/8] counter: stm32-timer-cnt: add support for
 stm32mp25
Message-ID: <aCUyQbDj6pDdRYuL@ishi>
References: <20250110091922.980627-1-fabrice.gasnier@foss.st.com>
 <20250110091922.980627-4-fabrice.gasnier@foss.st.com>
 <euiZ0AkHt7QXbUa8SgT5b2zrUV2Ha-llURWKhlOUH0BhTlbbIBTELC3Uk_sQGpTMSy4vS3j66xs83vKXnJjrgA==@protonmail.internalid>
 <5268ec60-ae2e-425e-a4af-a55cb0c3a1f9@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xd2tMiRaS48NlvBR"
Content-Disposition: inline
In-Reply-To: <5268ec60-ae2e-425e-a4af-a55cb0c3a1f9@foss.st.com>


--Xd2tMiRaS48NlvBR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 14, 2025 at 11:30:14AM +0200, Fabrice Gasnier wrote:
> On 1/10/25 10:19, Fabrice Gasnier wrote:
> > Add support for STM32MP25 SoC. There are new counter modes that may be
> > implemented in later. Still, use newly introduced compatible to handle
> > this new HW variant and avoid being blocked with existing compatible
> > in SoC dtsi file. Modes supported currently still remains compatible.
> > New timer 20 has encoder capability, add it to the list.
> >
> > Acked-by: William Breathitt Gray <wbg@kernel.org>
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > ---
> >  drivers/counter/stm32-timer-cnt.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> Hi,
>=20
> The first patches of this series have been merged.
>=20
> I'm not sure who shall pick this one ? (I think there's no dependency).
> Or do I need to resend it separately ?
>=20
> Please advise,
> BR,
> Fabrice

I don't know if anyone has already picked up this patch, but I'll take
it through the counter tree regardless. No need to resend.

Thanks,

William Breathitt Gray

--Xd2tMiRaS48NlvBR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCaCUyQQAKCRC1SFbKvhIj
K0SEAQCczNPjoor1o37cz8SqvsdN/7HtNNlaPrWLW1dpooqMnwEAgbin0MfIxTCj
Kw1ZtOOoP37+0SshTS2OcPlXqohQYAY=
=B/SX
-----END PGP SIGNATURE-----

--Xd2tMiRaS48NlvBR--

