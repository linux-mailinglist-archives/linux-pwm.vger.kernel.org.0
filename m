Return-Path: <linux-pwm+bounces-5269-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BAEA6E098
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Mar 2025 18:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8233A3A6AC9
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Mar 2025 17:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2343C2641D1;
	Mon, 24 Mar 2025 17:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQqM6pJ6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B8263F4C;
	Mon, 24 Mar 2025 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742836136; cv=none; b=T77MMuzli1fA9CsKOHin8WbYkyjA6D1FGloD7ZCSJlUMFtc9mGG9bop3MvPxLeHMp6MaWgRMGjRo9hqFqcjP0brov02iVbF03+eI7JQ+Lcm7Iy6I4cx+mT9aaTubeXX4R1zTOh700sO19BwP5g8mFDFSQ1j+D/gQhnn0wLHDNnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742836136; c=relaxed/simple;
	bh=1RZR1rmwIvUvIXlqLuLhx6DIKSNHQjzBEPPf3ULBh4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oVSTeBuF7M6zLBnoq/H8PlIDnFrtdPwWSRkjicE0Xk+Ldzy24t0PNHv3eSBbI6ac3Pz5aBz5LS/GpIxIVbEcAR62TGE8mIAA7Y5c38ckvESjolaS1+R1ymP0+KaauNe5VEdGQek34k1YY6aS/hTwc/5TIKUI9ENMQ1uj45ARanY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQqM6pJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14433C4CEDD;
	Mon, 24 Mar 2025 17:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742836135;
	bh=1RZR1rmwIvUvIXlqLuLhx6DIKSNHQjzBEPPf3ULBh4Q=;
	h=Date:From:To:Cc:Subject:From;
	b=GQqM6pJ6hrG0WVxL+2u7JTWzBz8tzT6mG8+Soivw8807F2FNhTHbEh3Djkw/+qyja
	 LANxyDPac/7mPUFg+hmxuG7orXUn04tN/rR7gdUUJCmmaQuyRPutRnxOAYkIIm/cKq
	 lg8+oyxi3BvBWFeAxtuangUWTZeyjx7srOXebm5Rg5zel+SkWB+ZHsaxYjdcr3NtVe
	 MLaBpIuo0SsC+8WnF+/wG4tDtOEupOrMRlL/YbK6CKGqDn5KubvJlP9TV6l+Sb3FvK
	 VzX5oQw3mItHUhU0Kt5cZIMaiEIi5lfAi0KR1NF6F7utBlNUFIoHSSVQdwLT3xhHq2
	 PmzO6Od09+aNw==
Date: Mon, 24 Mar 2025 18:08:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for 6.15-rc1
Message-ID: <gwhcc5df76untpl5ko4mqbt7vtxo3z4zdbqn4ehkenktt6untv@eng6ov2jmlwb>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qtmlwnort57mfscr"
Content-Disposition: inline


--qtmlwnort57mfscr
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for 6.15-rc1
MIME-Version: 1.0

Hello Linus,

warn: No match for commit 6df320abbb40654085d7258de33d78481e93ac8d found at=
 uklko
warn: Are you sure you pushed 'pwm/for-6.15-rc1' there?
The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/fo=
r-6.15-rc1

for you to fetch changes up to 6df320abbb40654085d7258de33d78481e93ac8d:

  dt-bindings: pwm: imx: Add i.MX93, i.MX94 and i.MX95 support (2025-03-10 =
17:13:54 +0100)

I intended to include a few changes by a guy from salutedevices.com, but
given that there was no feedback to him and these changes were only in
next since mid of last week, I backed them out with the intention to
send them to you during the next cycle when they were exposed to next
considerably longer. The changes included here are in next since nearly
two weeks.

Thanks for pulling this for v6.15-rc1.

Best regards from Germany,
Uwe

----------------------------------------------------------------
pwm: Changes for v6.15-rc1

Here comes the usual mix of cleanups, new dt-bindings for existing
drivers and nexus nodes; and a new driver for the pwm subsystem.

Patches were contributed by Andy Shevchenko, Chen Wang, Chukun Pan,
Frank Li, Herve Codina, Kever Yang, and Nam Cao.
Patch feedback was provided by Andy Shevchenko, Conor Dooley, Daniel
Mack, Duje Mihanovi=C4=87, Heiko Stuebner, Herve Codina, Krzysztof Kozlowsk=
i,
Neil Armstrong, Rob Herring, and Zack Rusin.
Thanks to all of them.

----------------------------------------------------------------
Andy Shevchenko (1):
      pwm: pca9685: Drop ACPI_PTR() and of_match_ptr()

Chen Wang (2):
      dt-bindings: pwm: sophgo: add PWM controller for SG2042
      pwm: sophgo: add driver for Sophgo SG2042 PWM

Chukun Pan (1):
      dt-bindings: pwm: rockchip: Add rockchip,rk3528-pwm

Frank Li (1):
      dt-bindings: pwm: imx: Add i.MX93, i.MX94 and i.MX95 support

Herve Codina (2):
      dt-bindings: pwm: Add support for PWM nexus node
      pwm: Add support for pwm nexus dt bindings

Kever Yang (1):
      dt-bindings: pwm: rockchip: Add rockchip,rk3562-pwm

Nam Cao (1):
      pwm: gpio: Switch to use hrtimer_setup()

Uwe Kleine-K=C3=B6nig (6):
      pwm: lpss: Only include <linux/pwm.h> where needed
      pwm: Add upgrade path to #pwm-cells =3D <3> for users of of_pwm_singl=
e_xlate()
      pwm: clps711x: Drop of_match_ptr() usage for .of_match_table
      pwm: Strengthen dependency for PWM_SIFIVE
      pwm: Check for CONFIG_PWM using IS_REACHABLE() in main header
      pwm: stmpe: Allow to compile as a module

 .../devicetree/bindings/pwm/imx-tpm-pwm.yaml       |  11 +-
 .../devicetree/bindings/pwm/pwm-nexus-node.yaml    |  65 +++++++
 .../devicetree/bindings/pwm/pwm-rockchip.yaml      |   2 +
 .../devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml |  58 ++++++
 drivers/pwm/Kconfig                                |  14 +-
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |  19 +-
 drivers/pwm/pwm-clps711x.c                         |   4 +-
 drivers/pwm/pwm-gpio.c                             |   5 +-
 drivers/pwm/pwm-lpss.c                             |   1 +
 drivers/pwm/pwm-lpss.h                             |   1 -
 drivers/pwm/pwm-pca9685.c                          |   9 +-
 drivers/pwm/pwm-sophgo-sg2042.c                    | 194 +++++++++++++++++=
++++
 drivers/pwm/pwm-stmpe.c                            |  25 ++-
 include/linux/pwm.h                                |   4 +-
 15 files changed, 390 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-nexus-node.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm=
=2Eyaml
 create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c

--qtmlwnort57mfscr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmfhkaIACgkQj4D7WH0S
/k6RiAgAkGzTf65DXYgHnIz8/Ah/1X9GJKCIZ0ylNtX77PohhCe6y43ARkCmZyuy
ljlO8G3rP+cOyxQkLAGRoMAeMQj/eX7JmDPYIu1/uLFgvoGAooO1x+JsSpPNqehm
t5Q5rwIpPJd3omObhcxeKclCia3m3wBihIrdivG1DgODreHq6rG5JK5S/NMdOJ27
AsR3PhdYKOSpdMLlDG4DFrzpiw9CgATA8pJPnOtlQUpRyc7WJDGBsU7xn+l41l8U
a1nCAnt5N1wBFNbzJ1Ni5+v1VO6MKR2IXcvwvCkOhVSJuWtwiB00FIzuZo2yhxXO
4J1vrYeXmzdwr2ymcLkZId6M/49tkw==
=keqi
-----END PGP SIGNATURE-----

--qtmlwnort57mfscr--

