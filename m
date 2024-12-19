Return-Path: <linux-pwm+bounces-4398-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6179F79E8
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 11:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0218A188FA16
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 10:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B56422259A;
	Thu, 19 Dec 2024 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8uN/oG3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F3C221D8E;
	Thu, 19 Dec 2024 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734605725; cv=none; b=L/zbAHGGgaPPzx7eZKVuwCJi5GU9ucHEZTDzjBP5sCGosH+wgVmMuUASmrxDC8F6ARWsNzjzABfOPSHlMrEjzJ34tiqLiDv2T7NMy129EwJqRvXO6WvEHf98DlTDTBfPTEiByfPH4f6qAfFo5KYCdlC6zhQInh9Zw8QtYSswLLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734605725; c=relaxed/simple;
	bh=YfAGEquYUeN/UwxooVNBMSn5jVYWKvTuT0w7IIh3g5w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rZVNJFW0v6ooaoHFBRvljFeK73duI4JMl9H7GU8FirVdXMbUePyrUkZZlN9EVEK0zJSiVpuSzt+jS5OwfHIBR23VyNEQCycJxdR89I9YgwMdAd6Zq5O8jHZgD+0TL+JBgT0/TF34vxazoJ1Y4DN3HZtu92EN2Ocack2+r5l2t9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8uN/oG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F95C4CECE;
	Thu, 19 Dec 2024 10:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734605724;
	bh=YfAGEquYUeN/UwxooVNBMSn5jVYWKvTuT0w7IIh3g5w=;
	h=Date:From:To:Cc:Subject:From;
	b=B8uN/oG32ccNRPjTJ1FrohhGNHD+gzB05DeoA6tFThXSSf+F6JrH2/Cq53Ux6P/nZ
	 AMd6UTqDbtVLhfRYbB/RqnVDv/oYP4nwRRe9R9RzTM01m/29a+mRp2L+G+IqD3PgQw
	 zL8BXRp4ykEgiBB7LvCa/594f3yMZBass/41coVlEyMz2f2utcXe4EBmLgXjuryhzX
	 zL9RiL7gBaRcvoP4W1KMebaI6Q7jCw1oQyF3vtZqHSTLx7WmWQf88lM0hNdYYLDFcx
	 5HO6eJYRHOA3N/BKN7NfkzCnL3z2y9azvDZXRuHJnDkSMr2RjMfLIZN4n5PceeUN4F
	 lJJa2Ku9YJ9BA==
Date: Thu, 19 Dec 2024 11:55:22 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [GIT PULL] pwm: Fix regression in pwm-stm32 driver when converting
 to new waveform support
Message-ID: <xzfckqs3o7trfrfpwzllviweimeohy4xvzy3oxnawm3mdpoe4z@vf2qqhvbgt3y>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ubkkoqjhduem4ud"
Content-Disposition: inline


--6ubkkoqjhduem4ud
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: [GIT PULL] pwm: Fix regression in pwm-stm32 driver when converting
 to new waveform support
MIME-Version: 1.0

Hello Linus,

the following change since commit 40384c840ea1944d7c5a392e8975ed088ecf0b37:

  Linux 6.13-rc1 (2024-12-01 14:28:56 -0800)

is available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/pwm/for-6.13-rc4-fixes

for you to fetch changes up to edc19bd0e571c732cd01c8da62f904e6d2a29a48:

  pwm: stm32: Fix complementary output in round_waveform_tohw() (2024-12-18 11:08:36 +0100)

Thanks for pulling this for 6.13-rc4.

Happy holidays
Uwe

----------------------------------------------------------------
pwm: Fix regression in pwm-stm32 driver when converting to new waveform support

Fabrice Gasnier found and fixed a regression I introduced with v6.13-rc1
when converting the stm32 pwm driver to support the new waveform stuff.
On some hardware variants this completely broke the driver.

----------------------------------------------------------------
Fabrice Gasnier (1):
      pwm: stm32: Fix complementary output in round_waveform_tohw()

 drivers/pwm/pwm-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--6ubkkoqjhduem4ud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmdj+5cACgkQj4D7WH0S
/k4uCAgAhRCAaN3BX9DpJSG5A/VzS1fHCEyy87QpVW5kuQnvryVNrIIfhj95tKH2
26MLRFSRSSmMV8SSnaTceRWgA55t8wW66xKZTYFD/4xuRy4Pf+KUjg5Rz9RSxmma
tfBLk+zb+zHoY9x0L1hTaqTE1Ei9hT20NG/DauFaJItRb+AXS1Mx3uUSzed9qtzh
cWOFMvyHSbpZJmmbUOKqg8EkuFy7H5rGo2PluPmHMkextVVcSDQs1J7YlRTHym9R
FWUoOcHajzcZhWGPSxpEcx9rbkWSPDLJDeHr4xT+61yLEFV6A6FGnxLL+Jx2MWIG
yO2oYOL7WPkFQ3/e62w557y0jCdAUQ==
=wlxT
-----END PGP SIGNATURE-----

--6ubkkoqjhduem4ud--

