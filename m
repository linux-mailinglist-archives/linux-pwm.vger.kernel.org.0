Return-Path: <linux-pwm+bounces-6880-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4756AB112C8
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jul 2025 23:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C7C1CE33D2
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Jul 2025 21:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D902F238C1A;
	Thu, 24 Jul 2025 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ngv2evMu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F911FFC5E;
	Thu, 24 Jul 2025 21:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753391200; cv=none; b=rE+9SSC4nioCXSNI5OceIcxBn8WXNwafDr8mnFKO+NojvMkNQvGXXy+WV/VyFz+pvlAGrLUbDPDtRQX1aeNuhYJR1vZj8EsO72FgvZAyxPF8ur9MMKZ1Nay7Inn83eTez7nzVzntHLYXknLIyTDe2Pxka9/ctzcSZgWHPmt/O4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753391200; c=relaxed/simple;
	bh=QOwacRNEVeeeVrBxgCmz/psw2bKyWXzSMrsEjsiKuUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nodrkD58rZBIGv5j9VhEZC0LMhP4aq+UkAMPd1fvTLBo5ArkMTr8GbKrhEwfKYEvieNoupTAxIqA7tnVM3QtKCxd7xZagKUaSsc9qh3f/4wWemFKriAk3I5vOEk+cB8HYXvTO+UqcrR7aMY4t9FvMPeva2Bdn11gnBBpDxfZdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ngv2evMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2BCC4CEED;
	Thu, 24 Jul 2025 21:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753391200;
	bh=QOwacRNEVeeeVrBxgCmz/psw2bKyWXzSMrsEjsiKuUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ngv2evMu7+AANzGVRNQyPDx9E3xkL1Tk1epokwgyNCsP0stkNt4dlYiIfaZMbmqwa
	 NKEVzodlMNVgyge1hTsRdSzjHwXK9QNMSHqyco991uvLMMIeuga6YrznroY89kgqzk
	 5LOhzGsQfZryCxhftaBPTLKuAXa1zhEcXL1UnYBj0ziVKND0IfTBuSDZJiUQ7zEuM0
	 nhjKuedFAjzxAMtXrvyd2ZLSloYbM1451DE0bnj74f+1txNUorUPE+dvkae3ZWzWvE
	 F1rCXLvpEsx4E4UJHlOz1Xd5tzTUaF+FIAqDNupbC/L/4V3YUaYKOVGO2v7yKslnOS
	 mXIJaLx60+VIA==
Date: Thu, 24 Jul 2025 23:06:36 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: linux-pwm@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] pwm: Fix spelling mistake "Firwmware" -> "Firmware"
Message-ID: <ykjehesx7ozh3w42hprewiip2g4uxyhs5c2qdzqhfc2b7z6mj6@foeuy5vgs7wf>
References: <20250724104148.139559-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tbubr6jh3k2elbwf"
Content-Disposition: inline
In-Reply-To: <20250724104148.139559-1-colin.i.king@gmail.com>


--tbubr6jh3k2elbwf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH][next] pwm: Fix spelling mistake "Firwmware" -> "Firmware"
MIME-Version: 1.0

Hello,

On Thu, Jul 24, 2025 at 11:41:48AM +0100, Colin Ian King wrote:
> There is a spelling mistake in the PWM_RASPBERRYPI_POE Kconfig,
> fix it.
>=20
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thanks, applied to
https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
next
=2E

Best regards
Uwe

--tbubr6jh3k2elbwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiCoFoACgkQj4D7WH0S
/k4yXwf/Zz2ZVoaJ2aZ5srlwY+6rTK4Kgx3QRSjsS+9ivfeoixC8tBtaDyGiQSzM
AFLgOAj3qaLcG6t4X37OWqjdFCv9SxtfIQ5keFXYmBYFICvwQ0HzL7Mj4pklFfAv
76dkZddpnv+PpiWMw5sbCbLvsvnScGZbOpEaoyHIJBJivbb+jpFJV5Q2tH4tYjaN
Qk4HINFTwt3oe0Tq6H/i5430M5lzNuuJEOmyqfosLL/XKRsCQOn9Oze6FbC+PAq7
ZcYkcKr0WEMKy58qNxPvmVHeXl1AYIdKIpHYgNdxZ1Lx6q3MFYgQV6UbJCMM3Txl
4UiHT4Lf9cF7b2+CHkoKMhEFJXuUPw==
=el/X
-----END PGP SIGNATURE-----

--tbubr6jh3k2elbwf--

