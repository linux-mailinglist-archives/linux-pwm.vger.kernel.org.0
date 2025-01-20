Return-Path: <linux-pwm+bounces-4688-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D00E0A17460
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 22:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDF416AC2A
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 21:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EE61EF0AC;
	Mon, 20 Jan 2025 21:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohVM1Ae7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC061EEA5F;
	Mon, 20 Jan 2025 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737410203; cv=none; b=ccxK/4D6yFSp/nJjsKDzuN6IhYGL9NCjCcUI30ebdECgPhGECfgd7Zx4b1J8WCL7+RBd/MhFzlqZldYFslSXWMrsKGSYdFzvflLZJAcMOh9l7gQVCmdQcLgcWCR7929bD1rgirnuGQdHPXDlaXLbOtZ9UjDOiZ50/2AN8U2XKzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737410203; c=relaxed/simple;
	bh=VZJjEyGnuG4Da0MIgtP6/MY3kVfIXi2If+sUcdslapE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EnoEXlX2T9rFgufzAbbQZrhBys0rzzQZKOlF+E9BLiwTUIzEsTzrlyPBk9IiW0lMgd+IVlAAWfWCnXAeG3rQ1n1Z+FhbU0atG0D9+1cWm3INViiuqEznRRZE+VhADQg8T/S2VIAaAGhJZP7kMieaC3UyKeHvkJME1N1V/ceA1pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohVM1Ae7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CBFC4CEDD;
	Mon, 20 Jan 2025 21:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737410202;
	bh=VZJjEyGnuG4Da0MIgtP6/MY3kVfIXi2If+sUcdslapE=;
	h=Date:From:To:Cc:Subject:From;
	b=ohVM1Ae79z0luwGCLUE3SODcYIsBdtZFnk2fP6Q7lk9irHRBAbUECTc7fu4qfyEeE
	 WHRIOIlDKi1x7Pc9dV+hb1PjCBa3gCc1ss2qSFHv5YnNXkkgvrEZlbEGeql3eFH9Q9
	 Nf27acF73Z1cViJFGsA5A2KvBPAqsgfgZnOYS1upmv4xP0W8cGAdKE8qoWNd9n0hpR
	 uFc0OhIBBCJGwaJ2MWSlf+hIVAvc5rDdjdR328JBmDqkd8lFzed5wTeYQtRnAfsyRA
	 Zv/0D0/tVgePFezK7Kn1aMuetWOxdo6dGDcFKduQnVxZY7/oJoLs7YrrT+YbCnNf7r
	 trgG7sQyKnjeg==
Date: Mon, 20 Jan 2025 22:56:38 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for 6.14-rc1
Message-ID: <2cig3eu5b6noqdtx7jjken4larht3ch7rlmfizw7kzpm7aqx22@qm7etmdulru6>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mngwwcioyg7juvw4"
Content-Disposition: inline


--mngwwcioyg7juvw4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for 6.14-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit edc19bd0e571c732cd01c8da62f904e6d2a29a48:

  pwm: stm32: Fix complementary output in round_waveform_tohw() (2024-12-18=
 11:08:36 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.14-rc1

for you to fetch changes up to e8c59791ebb60790c74b2c3ab520f04a8a57219a:

  pwm: stm32: Add check for clk_enable() (2025-01-17 10:41:56 +0100)

This gives you very little changes compared to earlier pull requests.
The topmost commit is simple and very similar to its grand parent. The
other patches were all exposed to next since 2025-01-09.

Initially I thought to base my PR on v6.13-rc2 to prevent conflicts with
the module namespace conversion that were done just after v6.13-rc1, but
it merges just fine on top of the fixes PR from last cycle as there is
no conflicting change.

Thanks for pulling this for v6.14-rc1.

Best regards from Germany,
Uwe

----------------------------------------------------------------
pwm: Changes for v6.14-rc1

This time there are very little changes for pwm. There is nothing new,
just a few maintenance cleanups.

The contributors this time around were Krzysztof Kozlowski, Mingwei
Zheng, Philipp Stanner, and Stanislav Jakubek. Thanks!

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      dt-bindings: pwm: Correct indentation and style in DTS example

Mingwei Zheng (2):
      pwm: stm32-lp: Add check for clk_enable()
      pwm: stm32: Add check for clk_enable()

Philipp Stanner (1):
      pwm: Replace deprecated PCI functions

Stanislav Jakubek (1):
      dt-bindings: pwm: sprd,ums512-pwm: convert to YAML

Uwe Kleine-K=F6nig (1):
      dt-bindings: pwm: marvell,berlin-pwm: Convert from txt to yaml

 .../devicetree/bindings/pwm/adi,axi-pwmgen.yaml    |  8 +--
 .../devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml  |  8 +--
 .../devicetree/bindings/pwm/brcm,kona-pwm.yaml     |  8 +--
 .../bindings/pwm/marvell,berlin-pwm.yaml           | 44 +++++++++++++++
 .../devicetree/bindings/pwm/pwm-berlin.txt         | 17 ------
 Documentation/devicetree/bindings/pwm/pwm-sprd.txt | 40 -------------
 .../devicetree/bindings/pwm/sprd,ums512-pwm.yaml   | 66 ++++++++++++++++++=
++++
 drivers/pwm/pwm-dwc.c                              | 14 ++---
 drivers/pwm/pwm-lpss-pci.c                         |  9 +--
 drivers/pwm/pwm-stm32-lp.c                         |  8 ++-
 drivers/pwm/pwm-stm32.c                            |  7 ++-
 11 files changed, 143 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/marvell,berlin-pw=
m.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-berlin.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/sprd,ums512-pwm.y=
aml

--mngwwcioyg7juvw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmeOxpQACgkQj4D7WH0S
/k5q4gf/YSmaJTU1PCl1R8ZAgVF6HSMkYwsGKyBwOwz+r6Q6P73wK8JtXbkNSYtv
zs0OhnEDCMGIxn5j3VvaRE/zHM7OdkTlV8E5a6JFwkZpzzk03WuJ5ln51J6UD0Hh
miococm6xwx1qpw2KkM3w8khvLxpIaISXA89hAKF5nFBNAL4iDmQWQAucBMZ/InF
15Kd8F0HPwJC6KmnEyQ1gv02Lf3D6w5p3FeNX7fuggXfDfdQTETmEUmB/7aZGq1M
7DGI/YaH0TkTechrZNyx+2CxFqf0Atlbxc+obU45QW2RGTr0+tWYtO646bFk+HC5
4raCVnl7ymX7twsN0RJ6AmbeY1i+rg==
=sQQv
-----END PGP SIGNATURE-----

--mngwwcioyg7juvw4--

