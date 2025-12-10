Return-Path: <linux-pwm+bounces-7793-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF630CB22E6
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Dec 2025 08:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED9B73011328
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Dec 2025 07:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE392EBDD6;
	Wed, 10 Dec 2025 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5UnbGqF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D29221D92;
	Wed, 10 Dec 2025 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765351421; cv=none; b=A+WPmV4CZlIayFbzbp8J0uThHK/+Qz06odI+T1RNPUHyG+KfahN2M/DUj2vCCHaUxyqjTyUSAEnfSMLpWOhmGQTzp/bt0itTFjzqziDaxjWn9XH0Ix7LBJmfqxBJJjOvPdrBq4iacHJFCy1DcNvhMRj8svqfu2CRzSoCv9IXUJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765351421; c=relaxed/simple;
	bh=oOgbQdxuGsMc0UJPFocHEmp9wBTnEsiWiwOrBylAdRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtT4pb8P3pNyhH0qIUxghhJus4jKddFLaB6YjeE6dmuh1DPJkdbdevPIpNAogBB+UudRP9eM7UCRL+TEgmycgPvJjDdsmVkL8qsVrWQzBEnJxrL28qXvuxHXtVbIEX7KAlHXxOsDMkVIRhL/vXpOxHQArJ8wWb5SusyM8gUXiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5UnbGqF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9B6C4CEF1;
	Wed, 10 Dec 2025 07:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765351420;
	bh=oOgbQdxuGsMc0UJPFocHEmp9wBTnEsiWiwOrBylAdRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N5UnbGqFFNzzIT+0B/CYdHyEy6++IgbHhBwI2330SRU/VUm8Z86seqVmUoAiIAUzr
	 zC+hBXh1bc3RKxXx7A629tcBs0Y0RL/67k9Hy1UOvk+VOrSZGSwsBhc0KSKI0L7xZR
	 aU0ix3nWm4632qpdpZWIRGVeXEEVq0XL3ysG25+6RVwkW6AYYZ8Sff7u9+3+DPCJ51
	 5eiDUfO62t/Qkztf1IPoLGY6e1vw97u3KAAV6LaOZks1PSvQXZrUyMUo6LHf4nxa9l
	 YMxA1P8rmoiHeRV+DI+8T9+jMcbb5nNAdL/+ShWWq1Qfr/2sEiXplZdiFyPxsxiHEI
	 OokXdScs04nrw==
Date: Wed, 10 Dec 2025 08:23:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Elle Rhumsaa <elle@weathered-steel.dev>, 
	Markus Probst <markus.probst@gmail.com>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] pwm: th1520: Fix missing Kconfig dependencies
Message-ID: <uhydiq3gzwkupvnvd3h4eocmmnflpyx4lwzvxb6kosit2ahw65@gnocgispdklh>
References: <CGME20251209200656eucas1p2849683e0977353b12c35838fef24a344@eucas1p2.samsung.com>
 <20251209-fix_deps_pwm-v1-1-f7ed8bd1bd3d@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wknxcaix2sot6z56"
Content-Disposition: inline
In-Reply-To: <20251209-fix_deps_pwm-v1-1-f7ed8bd1bd3d@samsung.com>


--wknxcaix2sot6z56
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] pwm: th1520: Fix missing Kconfig dependencies
MIME-Version: 1.0

Hello,

On Tue, Dec 09, 2025 at 09:06:03PM +0100, Michal Wilczynski wrote:
> The driver fails to build on configurations lacking COMMON_CLK (missing
> clk::Clk) or HAS_IOMEM (incomplete `pwm_chip` struct on UML).
>=20
> Add dependencies on ARCH_THEAD and HAS_IOMEM, and add COMMON_CLK to
> ensure correct compilation and platform targeting.
>=20
> Reported-by: Markus Probst <markus.probst@gmail.com>
> Closes: https://lore.kernel.org/all/a66b337528d700ae92d7940a04c59206e06a8=
495.camel@posteo.de/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512020957.PqnHfe7C-lkp@i=
ntel.com/
> Fixes: e03724aac758 ("pwm: Add Rust driver for T-HEAD TH1520 SoC")
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Thanks for the patch. I applied it to=20
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fixes
and will send it to Linus in a few days. While this fixes a build time
issue it seems to be exotically enough to give us a few days in next.

Best regards
Uwe

--wknxcaix2sot6z56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmk5H/cACgkQj4D7WH0S
/k5tigf/S7u1kXSpAurFkCv0WHEhhQKq9EIrTOV98Uoh6fdlrtmdzxTGXbyLMOOy
u0ifxRl6BSSJ2Hdul2Gt+5BX4W0kDpi6VNYa5w7J/vtqRMBzwq78POglOnkySqeP
3w1VK25SeGiDYX+3kjIyu/d+XBnNVERIRTZ42gI5ZKjGQxsdHDDlT/qnoj0PRe2j
69c+ijrW31UgbUxOMuWVAVKtiaon+DOHmEgY2kgrjp8RHj8bc4OoA6oRJh5dcnim
bpS8rgJN/wyx3haa6Iw0f3G0/z7nRhE2DMBkaj3P1P2Wd+Hgi4EtaRmvVWNxcI0Y
Sj3KJESUQF+PYFoZWIXH83a9JxOjQQ==
=+POt
-----END PGP SIGNATURE-----

--wknxcaix2sot6z56--

