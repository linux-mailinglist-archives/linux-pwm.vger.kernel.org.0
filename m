Return-Path: <linux-pwm+bounces-4397-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE369F73B7
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 05:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5764016302E
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 04:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 647C82163A4;
	Thu, 19 Dec 2024 04:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmhVPEXt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8A678F4A;
	Thu, 19 Dec 2024 04:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734582941; cv=none; b=tP0IT6HZmqrkyG1Bs46o2y4R2hO8/fo1OfFbAgAzPppxB2J4mJJCUC7SK5MbGSzt9goim86mr4L7RAGcspPoxzwV4owSQY5V3FrAh3VHTGU0r+dqmjmH+lKWHDCtwyij1mpztfqgCZElzU2WRTz4HsO97770NMxFbHkGX3GfFAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734582941; c=relaxed/simple;
	bh=hV9rPYBMtv6zYearTenprodqq3vw1d5TA0nxIP3JZ6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjkVZTVT5nGoFD1Vjmrt1UONd0sar00n1EVgBwCJsWvqmtrQiyQmVA4yStwGR4AFOdQ2TYFAuk8n9BCDDynXgo0AvPSISE9EMPKTQE8AY/KZOGd1smch3A5XazhIwwla81GhlzsJjBakmFg14GlPy+jPaeas+/o5RhGtqbVabFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmhVPEXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDF5C4CED4;
	Thu, 19 Dec 2024 04:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734582940;
	bh=hV9rPYBMtv6zYearTenprodqq3vw1d5TA0nxIP3JZ6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PmhVPEXtShJus3vwjeSG5S4LQfWCt0QUciQanZHZtLfx25uODBbaAxOiV+xmD4P0x
	 lSLGwwOECXwwtM3TDH3rIlzn2tlT2Lnoe/55j6VRDIUE/fD9aYWQa4y8PFX6p7Fqbq
	 wnJOpU+wB0MBZO2Y/mjlnvnQSMPRpT1w8BYg8o7GsVeUxmfVTs4pBCG8C8M0tIBpJ5
	 R9h50P2Aw6FyTHvqUpO/UPwkMAzNE1FD2azO36OG3hFzIXcNFzx3w76X0f/psjKfT2
	 BDvxuEKi0B1KhVZNDMGrTkA8HshT2oSa8zUyE+H2Q1dCK1cyYiifZ+j5igGoNhlanf
	 PHN6ALlKl3X+g==
Date: Thu, 19 Dec 2024 13:35:35 +0900
From: William Breathitt Gray <wbg@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, alexandre.torgue@foss.st.com, jic23@kernel.org,
	ukleinek@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	olivier.moysan@foss.st.com
Subject: Re: [PATCH 4/9] counter: stm32-timer-cnt: add support for stm32mp25
Message-ID: <Z2Oilz0GECUbovtN@ishi>
References: <20241218090153.742869-1-fabrice.gasnier@foss.st.com>
 <20241218090153.742869-5-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iv0TR1n6hMiqaW6j"
Content-Disposition: inline
In-Reply-To: <20241218090153.742869-5-fabrice.gasnier@foss.st.com>


--iv0TR1n6hMiqaW6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 10:01:48AM +0100, Fabrice Gasnier wrote:
> Add support for STM32MP25 SoC. There are new counter modes that may be
> implemented in later. Still, use newly introduced compatible to handle
> this new HW variant and avoid being blocked with existing compatible
> in SoC dtsi file. Modes supported currently still remains compatible.
> New timer 20 has encoder capability, add it to the list.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Acked-by: William Breathitt Gray <wbg@kernel.org>

--iv0TR1n6hMiqaW6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZ2OilwAKCRC1SFbKvhIj
K6GkAQD+kR7xgAP18OR+NrSPlqcTp3zBvvvPdQkB+Hg+9YasgQEAoM1u+U2lGv6Q
2ZQAnG3TGdEj7O7hRpdM5mQ3nywuYQo=
=GExD
-----END PGP SIGNATURE-----

--iv0TR1n6hMiqaW6j--

