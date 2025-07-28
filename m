Return-Path: <linux-pwm+bounces-6895-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF9CB13841
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jul 2025 11:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7B601884A18
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Jul 2025 09:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7D225486D;
	Mon, 28 Jul 2025 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0rFXn+s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C692528E1;
	Mon, 28 Jul 2025 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753695958; cv=none; b=ntXPfv/d8zuZ3CsmAtJ2W8osXHS8MfSvv5oPxcORfJ1HaHSCz03TdJfmEbFpD2C2X73g1LbH0Qd/1YvjFqLcNKPJmZRC1OrwrB6ODSqTySe3ay9gwOdaqMFeN8VzMm3qCWwX/AY6WOG4Y65KA7bcAADglZAizgAa11dRXmGu1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753695958; c=relaxed/simple;
	bh=XgeMqHBvZI8GGsevR51bGWO14j9HG8BS2EPLyCs+U74=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JxbWTsazkm71xeSPfH4eYsVC8jrj+HJeUdpzY+j9UgJOvxagGcoXIOMifxbXRdhTsOEpMD++IB/UmdALE8pWt1FtMmomOg68zE4HeSVy86HAPVSp25I68x5QP7xEgCMOmu+PT8u1USh9Eq4zie0nswCOqlhfbr8TgmvbHVlWXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0rFXn+s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7CEC4CEE7;
	Mon, 28 Jul 2025 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753695958;
	bh=XgeMqHBvZI8GGsevR51bGWO14j9HG8BS2EPLyCs+U74=;
	h=Date:From:To:Cc:Subject:From;
	b=F0rFXn+sFrkktutzkUWQWEK0mPthKRax8hZEZ0XMhRz8k13eO39Atb48BZPu9hjbT
	 3v2U0ghVQXXZBlXSSFbHKe5HwUIqb4JtKfNSwf7fr0pwy4ESqyyWYYv2Vnb1eoggA/
	 zV6X3AWDVAD2bNr7Rlo8d7VAhSU1VMKzI9Zm3AsdjtJOg8EBHiKWH0auQltoqvxjx4
	 bYKfpFx3SE0NtpxPVeyvz1U7zZvHE7FFE6XAyp/aoHOA1qkpO0CYXZaQUY0muWPdHl
	 sj05M8fre29liskB35+aBa4HkCGrSk/Pd79qJ6UNilxRLNNDCAttNsm6vssItdbBk1
	 0TnQST8ZWyH0Q==
Date: Mon, 28 Jul 2025 11:45:55 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: [GIT PULL] pwm: Changes for v6.17-rc1
Message-ID: <aukywky7iv22b3noqkzx42hod5zbhgfgrhrt4uddg6c5k7nzlb@oey3yxxhroj6>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7w4iqxp5wccgkzc6"
Content-Disposition: inline


--7w4iqxp5wccgkzc6
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for v6.17-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.17-rc1

for you to fetch changes up to 68b9272ca7ac948b71aba482ef8244dee8032f46:

  pwm: raspberrypi-poe: Fix spelling mistake "Firwmware" -> "Firmware" (202=
5-07-24 23:04:16 +0200)

----------------------------------------------------------------
pwm: Changes for v6.17-rc1

Apart from the usual mix of new drivers (pwm-argon-fan-hat), adding
support for variants to existing drivers, minor improvements to both
drivers and docs, device tree documenation updates, the noteworthy
changes are:

 - A pull of pm-runtime-6.17-rc1 to make it possible to apply
   a582469541a3 ("pwm: img: Remove redundant pm_runtime_mark_last_busy()
   calls"). Note this updates the base for my tree to 6.16-rc2.

 - A hwmon companion driver to pwm-mc33xs2410 living in drivers/hwmon
   and acked by Guenter Roeck

 - chardev support for PWM devices
   This leverages atomic PWM updates to userspace and at the same time
   simplifies and accelerates PWM configuration changes.

----------------------------------------------------------------

Lee provided another immutable branch containing patches by Nuno S=E1,
including PWM changes at
git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-gpio-input=
-pwm-v6.17
, but I didn't merge it as there is no conflict with my tree and so I
don't see a benefit in polluting the diffstat of this PR. The pwm
related changes in there of course have my blessing anyhow.

The three topmost patches are in next only since next-20250725, the
others are in next since next-20250710. Two of the three "new" patches
are quite simple. The third is the hwmon change, that I didn't want to
hold back to free both the hwmon guys and me from the need to coordinate
this change for a whole development cycle.

I considered waiting a bit with my PR to give these changes a bit more
exposure in next, but giving your travel plans I decided to create it
early as usual.

Diffstat below and thanks too all contributors.

Please pull the pwm/for-6.17-rc1 tag into 6.17-rc1.

Thanks
Uwe


AngeloGioacchino Del Regno (3):
      dt-bindings: pwm: mediatek,mt2712-pwm: Add support for MT6991/MT8196
      pwm: pwm-mediatek: Pass PWM_CK_26M_SEL from platform data
      pwm: pwm-mediatek: Add support for PWM IP V3.0.2 in MT6991/MT8196

Colin Ian King (1):
      pwm: raspberrypi-poe: Fix spelling mistake "Firwmware" -> "Firmware"

David Lechner (1):
      dt-bindings: pwm: adi,axi-pwmgen: Update documentation link

Dimitri Fedrau (2):
      pwm: mc33xs2410: add hwmon support
      hwmon: add support for MC33XS2410 hardware monitoring

Fabrice Gasnier (1):
      pwm: stm32: add support for stm32mp25

Frank Li (2):
      dt-bindings: pwm: convert lpc1850-sct-pwm.txt to yaml format
      dt-bindings: pwm: Convert lpc32xx-pwm.txt to yaml format

Guodong Xu (3):
      dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT K1 PWM support
      pwm: pxa: Add optional reset control
      pwm: pxa: Allow to enable for SpacemiT K1 SoC

Longbin Li (3):
      dt-bindings: pwm: sophgo: Add pwm controller for SG2044
      pwm: sophgo-sg2042: Reorganize the code structure
      pwm: sophgo-sg2042: Add support for SG2044

Marek Vasut (3):
      dt-bindings: vendor-prefixes: Document Argon40
      dt-bindings: pwm: argon40,fan-hat: Document Argon40 Fan HAT
      pwm: argon-fan-hat: Add Argon40 Fan HAT support

Michal Wilczynski (1):
      pwm: Expose PWM_WFHWSIZE in public header

Nicolas Frattaroli (1):
      pwm: rockchip: Round period/duty down on apply, up on get

Nylon Chen (3):
      riscv: dts: sifive: unleashed/unmatched: Remove PWM controlled LED's =
active-low properties
      pwm: sifive: Fix PWM algorithm and clarify inverted compare behavior
      pwm: sifive: Fix rounding and idempotency issues in apply and get_sta=
te

Sakari Ailus (7):
      PM: runtime: Document return values of suspend-related API functions
      PM: runtime: Mark last busy stamp in pm_runtime_put_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_put_sync_autosuspend()
      PM: runtime: Mark last busy stamp in pm_runtime_autosuspend()
      PM: runtime: Mark last busy stamp in pm_request_autosuspend()
      Documentation: PM: *_autosuspend() functions update last busy time
      pwm: img: Remove redundant pm_runtime_mark_last_busy() calls

Uwe Kleine-K=F6nig (13):
      pwm: Fix invalid state detection
      pwm: mediatek: Ensure to disable clocks in error path
      pwm: Add support for pwmchip devices for faster and easier userspace =
access
      pwm: atmel: Drop driver local locking
      pwm: clps711x: Drop driver local locking
      pwm: fsl-ftm: Drop driver local locking
      pwm: lpc18xx-sct: Drop driver local locking
      pwm: microchip-core: Drop driver local locking
      pwm: sti: Drop driver local locking
      pwm: sun4i: Drop driver local locking
      pwm: twl-led: Drop driver local locking
      docs: pwm: Adapt Locking paragraph to reality
      Merge tag 'pm-runtime-6.17-rc1' of https://git.kernel.org/pub/scm/lin=
ux/kernel/git/rafael/linux-pm

 .../devicetree/bindings/pwm/adi,axi-pwmgen.yaml    |   2 +-
 .../devicetree/bindings/pwm/argon40,fan-hat.yaml   |  48 +++
 .../devicetree/bindings/pwm/lpc1850-sct-pwm.txt    |  20 --
 .../devicetree/bindings/pwm/lpc32xx-pwm.txt        |  17 -
 .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml   |  35 ++-
 .../bindings/pwm/mediatek,mt2712-pwm.yaml          |   5 +
 .../bindings/pwm/nxp,lpc1850-sct-pwm.yaml          |  54 ++++
 .../devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml   |  44 +++
 .../devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml |   4 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 Documentation/driver-api/pwm.rst                   |  13 +-
 Documentation/hwmon/index.rst                      |   1 +
 Documentation/hwmon/mc33xs2410_hwmon.rst           |  34 ++
 Documentation/power/runtime_pm.rst                 |  50 ++-
 .../riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  12 +-
 .../riscv/boot/dts/sifive/hifive-unmatched-a00.dts |  12 +-
 drivers/hwmon/Kconfig                              |  10 +
 drivers/hwmon/Makefile                             |   1 +
 drivers/hwmon/mc33xs2410_hwmon.c                   | 178 +++++++++++
 drivers/pwm/Kconfig                                |  14 +-
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 | 350 +++++++++++++++++=
++--
 drivers/pwm/pwm-argon-fan-hat.c                    | 109 +++++++
 drivers/pwm/pwm-atmel.c                            |  12 -
 drivers/pwm/pwm-clps711x.c                         |   8 -
 drivers/pwm/pwm-fsl-ftm.c                          |  28 +-
 drivers/pwm/pwm-img.c                              |   2 -
 drivers/pwm/pwm-lpc18xx-sct.c                      |  14 -
 drivers/pwm/pwm-mc33xs2410.c                       |  20 +-
 drivers/pwm/pwm-mediatek.c                         |  51 +--
 drivers/pwm/pwm-microchip-core.c                   |  17 +-
 drivers/pwm/pwm-pxa.c                              |   6 +
 drivers/pwm/pwm-rockchip.c                         |  33 +-
 drivers/pwm/pwm-sifive.c                           |  52 ++-
 drivers/pwm/pwm-sophgo-sg2042.c                    | 143 +++++++--
 drivers/pwm/pwm-sti.c                              |  23 +-
 drivers/pwm/pwm-stm32.c                            |  42 ++-
 drivers/pwm/pwm-sun4i.c                            |  10 -
 drivers/pwm/pwm-twl-led.c                          |  49 +--
 include/linux/mc33xs2410.h                         |  16 +
 include/linux/pm_runtime.h                         | 187 +++++++++--
 include/linux/pwm.h                                |   5 +
 include/uapi/linux/pwm.h                           |  53 ++++
 43 files changed, 1423 insertions(+), 364 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/argon40,fan-hat.y=
aml
 delete mode 100644 Documentation/devicetree/bindings/pwm/lpc1850-sct-pwm.t=
xt
 delete mode 100644 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,lpc1850-sct-p=
wm.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.y=
aml
 create mode 100644 Documentation/hwmon/mc33xs2410_hwmon.rst
 create mode 100644 drivers/hwmon/mc33xs2410_hwmon.c
 create mode 100644 drivers/pwm/pwm-argon-fan-hat.c
 create mode 100644 include/linux/mc33xs2410.h
 create mode 100644 include/uapi/linux/pwm.h

--7w4iqxp5wccgkzc6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmiHRtAACgkQj4D7WH0S
/k6MpwgArqrVZJCOPE850ZQNJQwjuXH3JBup6TZV5D99NI5tszpuzFEeO4tkEDGt
wkSRpuneZHRRtEzIAXoqBHc2+gQrwlLMcv+jTSNMWER1frqQo5qaz3ZKeSbHllpH
SzkEG0jyUGeU3ZeraxNnCp6nbdWWblKESXvSfqdWnnQgAE2knxvCiwcVoCTtAmNH
H8SP4Os7r1ThJK78Tqf0Ov56UTxnVmi0bDm2MQUniDTlp9W9+SrdSdyNIyRhWXpp
bJmmhtQEzq5y8swbZYi6Nk1F1qoqL1iaq674p4p3GlH4lN3EHHurpe4lLfKlm6hW
RkzS+ACPE84f9FE+mSr2ak4Hnb/b7g==
=0vgo
-----END PGP SIGNATURE-----

--7w4iqxp5wccgkzc6--

