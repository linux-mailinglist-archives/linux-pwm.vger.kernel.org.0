Return-Path: <linux-pwm+bounces-6917-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14065B16EC9
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Jul 2025 11:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B76561685
	for <lists+linux-pwm@lfdr.de>; Thu, 31 Jul 2025 09:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3975238C25;
	Thu, 31 Jul 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR6i/UjU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC239EAF6;
	Thu, 31 Jul 2025 09:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753954713; cv=none; b=VfHRDKhjkRJkPWnlLx1+z7/a2HcNqlgN5QzIwz34rQ6pKW7FPXOH8oQFVYeuq1FPEbK5Y1y0ekA7Y6oq0LlBsVIJh6oyE7E1owyL+2E7J12A6B1xI5M9jj94wN0vkdPJFnDJDxq2TFpc/qvSSgbS6zXf0YV00H6JbgH0M4rw4B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753954713; c=relaxed/simple;
	bh=SHxM9vqwSAcwUoKVgchBtOnjjDW14z0y03hLQB4v+n8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bVzv+Hs2laODmgTz/djJuUigtRdIJV0wCPDqwrJfcXhamtxtT9tCd+Ek6+oRWSiidb9MEkJi1wBp4lChn3wScux0OCBqrAE55StnC3YbHEs1ILJtPChDWCEVQdeEI85e21sGDiBsTKiZU/OnqwNcVe3cBLe/E1uNVPw8HmhS8bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR6i/UjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0551C4CEEF;
	Thu, 31 Jul 2025 09:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753954712;
	bh=SHxM9vqwSAcwUoKVgchBtOnjjDW14z0y03hLQB4v+n8=;
	h=Date:From:To:Cc:Subject:From;
	b=oR6i/UjUPTLC8buFX6PaqUD9Jx/FWTNY1+U1UpRJyp6xfye1kW/0FV5uLG93JnzuJ
	 52Fn/k0JXIqMH2O3gzcY5DqnPefjjqgWB8XszOQ/VIBkx7bESb/za9R0h0a/7iROww
	 6kagF4PZj/fvkiKMmIWBhXSK27oRKq33IW+jeg1ha7tlE9+L7UnT3pY3aC3ZmI2bjQ
	 pudo/fF4LtAatvO9AU8P1UeLidoFW+ilxkhWpLSPyrGy3N2tIUZGBQ2lpe/uCAlyoU
	 al+a6/tlk3omUXv9aYt4zTNWa6FeT7hTqiaxmsKXDxHDuYuxdW9PRerqeKezXWx/Oy
	 c08FJETafuiZg==
Date: Thu, 31 Jul 2025 11:38:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [GIT PULL] pwm: Two fixes for 6.17-rc1
Message-ID: <ljulzcaas5usyyqjzcnhjtgrv7loxz5hgabdjso237kwzndwln@5zfghmq3kqjt>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ohywdf4jxmaej2zu"
Content-Disposition: inline


--ohywdf4jxmaej2zu
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Two fixes for 6.17-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit 68b9272ca7ac948b71aba482ef8244dee8032f46:

  pwm: raspberrypi-poe: Fix spelling mistake "Firwmware" -> "Firmware" (202=
5-07-24 23:04:16 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.17-rc1-fixes

for you to fetch changes up to 65c6f742ab14ab1a2679fba72b82dcc0289d96f1:

  pwm: imx-tpm: Reset counter if CMOD is 0 (2025-07-29 17:51:27 +0200)

=2E

Note that there are three commits for these two fixes; that's because
the mediatek PWM fix is split into a preparing commit and the actual
fix. The first introduces no semantic change and only makes the second
commit smaller and easier to understand. The commits are tagged for
backporting to stable and contained in yesterday's and today's next
without reported issues.

Please pull these commits before tagging 6.17, preferably considerably
earlier :-)

Thanks
Uwe

----------------------------------------------------------------
pwm: Two fixes for 6.17-rc1

Here contained are two fixes for the mediatek and the imx-tpm driver.
Both are already old but (v4.12-rc1 and v5.2-rc1 respectively) given
it's still very early in the development cycle I consider them fine to
go in.

The mediatek issue is that both period and duty_cycle were configured to
higher values than requested. For most applications the period part is
no tragedy, but a PWM that is configured for duty_cycle =3D 0 should
really emit a constant inactive signal. That was noticed by an LED not
being completely off in this case.

For the imx-tpm PWM driver the fixed issue is that the first period is
quite a bit too long under some circumstances. So it might take up to
UINT32_MAX << 7 clock ticks until the PWM starts toggling. With an
assumed input clock rate of 166 MHz (completely made up) that's 55
minutes.
----------------------------------------------------------------

Laurentiu Mihalcea (1):
      pwm: imx-tpm: Reset counter if CMOD is 0

Uwe Kleine-K=F6nig (2):
      pwm: mediatek: Handle hardware enable and clock enable separately
      pwm: mediatek: Fix duty and period setting

 drivers/pwm/pwm-imx-tpm.c  |  9 ++++++
 drivers/pwm/pwm-mediatek.c | 71 ++++++++++++++++++++++++------------------=
----
 2 files changed, 46 insertions(+), 34 deletions(-)

--ohywdf4jxmaej2zu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiLOZIACgkQj4D7WH0S
/k4ydggAicO9AP6GxNdo2RDaFqdFUrdimwq4YXotauMRomLpFAsvg7IGa+7PtiFy
5zv2CxpJEjqdok1lT0btQLPGK0CDNJDed2YNwpDPGEn6b04CJ/09lzuSPfzT0jtl
Z5iG36iw6uVNGl+s3Zn8C0iCA7B2Huf0fKvopIZLGjjHFOJvK+2ENKDVIMOIgy2e
pa6lfbt8zRyg5uG6EikAfRbNaiWeQX9acXJOKpGSc3+bf/vtz3dpEy77wqKuyNzP
AW0KRvIBflMVbs8QspE2KzzyNrMCJfgSnaDZj37n0fQRUJzlnofi9A+inc1V2NX4
t18Um97RwfTXE06+BKWTvevHEnV5Jg==
=GwUs
-----END PGP SIGNATURE-----

--ohywdf4jxmaej2zu--

