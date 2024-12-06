Return-Path: <linux-pwm+bounces-4269-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FEA9E67AB
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 08:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4B5280F53
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 07:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74848191F78;
	Fri,  6 Dec 2024 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbaEyGu1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DED32C8B;
	Fri,  6 Dec 2024 07:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733469181; cv=none; b=Z6ash8QJe7NGa+2KCkxV9uX1nMzk5Nti8Qcs+7EPsih+hadnzdya+IPk7wyg+QQWnh9LOlG8qCb18NW4uZ4CQvnwkMXdb4TJFZIPp+w7Uhz864qqYHjR7GRNjMBkjHNiuTENguW9CaDxvt26khJP0OclsmmOoWctIOVSPDID40Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733469181; c=relaxed/simple;
	bh=wqdP/q7jz5/cYPHRhOGlO8Dgz7Z7fVb1WpWpSjFHEtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dX5Vtqu4WWkdl2AQn+BzqhtIAVEpcW455JcDmI0Xs1W+S85eZKsAjVvN9/82YTxWuhS4kFedwOcgvA4gUdLDhNKahwX4hEGNHdi6vJ1Yp89N0zspxS2F+Yczmd8YrlmIOfYPASwturd+SRv408EBXeKHp3FncxmASE+H96Lrw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbaEyGu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FCA9C4CEDD;
	Fri,  6 Dec 2024 07:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733469180;
	bh=wqdP/q7jz5/cYPHRhOGlO8Dgz7Z7fVb1WpWpSjFHEtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bbaEyGu11/UxJoI+wxVZKQze/GAiyViGlIHkW/LeTFayFPOP21hgFvJ9UQL16Of6n
	 oSFi59lFAGU0zrx/RohkY08DvXuR0VVpaeGxN1xx0Tf7/qXSLG8T11zP+M57cVh+JY
	 ITT1xrXF0oS+Za3klS9l6lxOteodrT7qa1MSYCRcee8O9F/hXUqsvoavGQ/2cjk8vF
	 CBE6z0z04SoUUDGF0JQRrm0IllLkGhUsXYZTYSU2qh3steCGZtdFaRj89WNfpctiM2
	 0jw2uJpI/yglEHWHuKoQiZklmUMtDU8E/yd6lHsgh7uyG/VaHstYWuHKxH/pidNskB
	 7RzhF0hivOOyw==
Date: Fri, 6 Dec 2024 08:12:57 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Mingwei Zheng <zmw12306@gmail.com>
Cc: fabrice.gasnier@foss.st.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, hierry.reding@gmail.com, lee@kernel.org, 
	linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Jiasheng Jiang <jiashengjiangcool@gmail.com>
Subject: Re: [PATCH V2] pwm: stm32-lp: Add check for clk_enable()
Message-ID: <cim6rnzdvhik4kdibfmglf6jiky7xccynqwazmxmnr2f5fvu3f@lvoo3drlgaua>
References: <20241206012605.2877412-1-zmw12306@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="24swak54o7mx3jph"
Content-Disposition: inline
In-Reply-To: <20241206012605.2877412-1-zmw12306@gmail.com>


--24swak54o7mx3jph
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH V2] pwm: stm32-lp: Add check for clk_enable()
MIME-Version: 1.0

On Thu, Dec 05, 2024 at 08:26:05PM -0500, Mingwei Zheng wrote:
> Add check for the return value of clk_enable() to catch the potential
> error.
>=20
> Fixes: e70a540b4e02 ("pwm: Add STM32 LPTimer PWM driver")
> Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>

In reply to (implicit) v1 you wrote:
> We detected this through static analysis, instead of actually hit.

Would be nice to mention the tool that actually found it in the commit
log.

Otherwise I'm happy with that change now.

Given the issue is old (the offending commit is in v4.14-rc1), I'd note
send it as a fix before v4.14. I'd send it along however if something
more urgent pops up.

Best regards
Uwe

--24swak54o7mx3jph
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdSo/YACgkQj4D7WH0S
/k58qQgAoaSkhGFgO/Kk52GXlgiISBHJAWIcISJ5+foNu36MAFY3eW6ti+GT0DBw
XuYgt/Z7uV4mklpmSb0NsHU9o1Rg0wqdqPpeOydgp+nDnWRLOU7Ym5ZLGGIna4M+
VuKtK4l3wY5wW9LXMR0YlBhNQ8LlSNIG3yGfektvc4kWLaTB1S3o3FkY3mx6PaFl
As6hDgS2eg5rGjRaAYqiBQ0RCPVDOtH4+dgVAXC7w4LNyJo6ujdPQdaSBmq05RQi
DDH6nEL/NVw3PSjoDcK3Q2YQ8Ch3O/XyzybATAlLlNNqN2/M1mwEK08vbeEnv5mP
OYIkTcu2MYynEx6XzaGy1PAATeTcqw==
=onJO
-----END PGP SIGNATURE-----

--24swak54o7mx3jph--

