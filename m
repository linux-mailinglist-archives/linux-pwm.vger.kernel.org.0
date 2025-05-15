Return-Path: <linux-pwm+bounces-5997-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E7AAB8273
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 11:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390A417EAC6
	for <lists+linux-pwm@lfdr.de>; Thu, 15 May 2025 09:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DEA296736;
	Thu, 15 May 2025 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7mU282L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F2D221296;
	Thu, 15 May 2025 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301097; cv=none; b=E3XVRriMAD8lsLgYCd30CCZzqiG1+knGIo9Fw6f9zRLF+Q86oWM0m5Ej8Qtj7xrtAXi8PCWpoaPt+yRZfugpRH0LYkwyZl5aTLrBwlQcG41Xh29SBIVbPMAwDE+jGC8zXjncAVlb62lWRpmpNf8mKlImGJbxTYOPClfhwMJRvtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301097; c=relaxed/simple;
	bh=JZp32cGnARt5v5SngWT8bwZW1Jh8iJC7PUvH3dlXTsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4liFbo1pr/73dqUtm8X9RXRpJjn3vWj8OSzJVS03J9TxvgHKN/9zyWl7uwxvqGfa3Wv21o5FGVnkedyHXfWsltCXnKhbEb+Hg1s5MxMHQ8syCfaqHs74xIkqgnGLOWGMzweo0nY+yn4FtxEQvo5kD5doTKPyhU+Ae4KjVS7vRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7mU282L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28A3C4CEE7;
	Thu, 15 May 2025 09:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747301096;
	bh=JZp32cGnARt5v5SngWT8bwZW1Jh8iJC7PUvH3dlXTsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A7mU282LSWsGdpwJ5DOiLTIAyqVyxqrlhiVc/v/e9xV8IF8oplET2K7F1vaW9ndS9
	 Tlas2OXmX6IsN+pRPlTSwvSVtCP/Cw8hsCLXnTBqvAPakVN7aP6hBug3Z5jAfSXubn
	 ZZrk7AA4uR2EeRexTRs3IkByDiF4sfYVO8tBjoHvFYBpCuapOsYHAbkzEnbptayKPG
	 MaoK0JqisvSZA0NJiNex8WCJ8Q3RnsW2nI/+VLG9cLM4obd3XEaUHaDi8QTplnEc1M
	 321EnbfQT9BLZhjy61zQ22mIKJpakf9bnmHCgr0tDdiOLD7gc8Vv4jdSy+oggRK3O8
	 BkvdzdvjkhAOg==
Date: Thu, 15 May 2025 11:24:53 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	wbg@kernel.org, jic23@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, olivier.moysan@foss.st.com, lee@kernel.org, 
	alexandre.torgue@foss.st.com
Subject: Re: [PATCH v3 4/8] pwm: stm32: add support for stm32mp25
Message-ID: <5ui74qlssllgn4h34by5jcpi5g6rknziclcsh4w27tjvznynsv@lcjtjxn6rovl>
References: <20250110091922.980627-1-fabrice.gasnier@foss.st.com>
 <20250110091922.980627-5-fabrice.gasnier@foss.st.com>
 <4b641513-ff2e-43ab-8074-ba6b521875e2@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dxezo4t7v65ydh54"
Content-Disposition: inline
In-Reply-To: <4b641513-ff2e-43ab-8074-ba6b521875e2@foss.st.com>


--dxezo4t7v65ydh54
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 4/8] pwm: stm32: add support for stm32mp25
MIME-Version: 1.0

Hello Fabrice,

On Wed, May 14, 2025 at 11:30:26AM +0200, Fabrice Gasnier wrote:
> On 1/10/25 10:19, Fabrice Gasnier wrote:
> > Add support for STM32MP25 SoC. Use newly introduced compatible to handle
> > new features along with registers and bits diversity.
> > The MFD part of the driver fills in ipidr, so it is used to check the
> > hardware configuration register, when available to gather the number
> > of PWM channels and complementary outputs.
> >=20
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> > ---
> > Changes in v2:
> > Address Uwe review comments:
> > - Make MAX_PWM_OUTPUT definition less generic: STM32_PWM_MAX_OUTPUT
> > - No need to initialize 'npwm'
> > - refactor code, for *num_enabled to use same code path
> > ---
> >  drivers/pwm/pwm-stm32.c | 42 ++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 35 insertions(+), 7 deletions(-)
>=20
> Hi Uwe,
>=20
> I think this patch still miss some reviews.
> The first patches of this series have been merged.
>=20
> Is it ok for you to merge, or shall I resend separately ?

I have it still on my radar, no need to resend. I just have to find the
time to look into it in more detail.

Best regards
Uwe

--dxezo4t7v65ydh54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmglstgACgkQj4D7WH0S
/k7tvQgAr0tuQYW7a8kZHG4D+r8Ju5Etk+73ekoD+5NJcmpwe6C8Nye8E3mKfgS6
bWCXuQS9aBsBvnmwFzIV9jkcwJrdeejQfv46EJ0IOZZFloj7b/vB3K/L/dzS3Ray
XkPiy+M1R1rGt5B5X1U2gyUK6QRCE4KOMquhXMRCQxO7zqXlozUOk2rcmcAzgGMV
tpQY/lDPoA9V6k4R6WL4yGAzwybvl+ASbzdrDmsjuIcW9On5Y5xDzkeVH9RSU5P0
apvIu6hfS3bj3LvTF8QiT9emDOMQJAMU0J5t2YOeazfw/A7rFfqFQl7FA4Z2nDGZ
wxTfL+UCcOGnVPHKb0fByZ5OKLMqrA==
=ZB/v
-----END PGP SIGNATURE-----

--dxezo4t7v65ydh54--

