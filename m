Return-Path: <linux-pwm+bounces-3281-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE5497A31A
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 15:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1214C1F2293F
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Sep 2024 13:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F45155359;
	Mon, 16 Sep 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDNWPK33"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B922132122;
	Mon, 16 Sep 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726494887; cv=none; b=N+uqT+2p6S6cVklJuLIGdCbch1xTCqDIKEtDI2PtmJkY/YRq/tZCkGkR5DDVcEssrAlWwIJSEo9s376ym6eIj9pSz2OVxYfYddmx0n4TV/uxSdb/vWFnx6S1kvjryuaH+QDTMnXtM46Mo8gI/c4sTMIJeuZTZlwTvaSniqz4Ogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726494887; c=relaxed/simple;
	bh=q8RpOO4BiIZIOm6wF0IM09g6mupF4T25XHV9SSUFFs8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bR7oHddjDOq+WaXe1vVxBHelx0XnIlSsHPTCEo8rF3gZKuYl9ZIExfnsVbFk/NXE/p5WGXt4hVmXPNyCCZP0d4L5Sm0chV8iC56tYwCzH5Ge7acvdK2wh4zjBsZZ9a0FZGANHpAKUHhQg7UpHLYUnFQ597qDO67LMP4PVcR2LSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDNWPK33; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F724C4CEC4;
	Mon, 16 Sep 2024 13:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726494886;
	bh=q8RpOO4BiIZIOm6wF0IM09g6mupF4T25XHV9SSUFFs8=;
	h=Date:From:To:Cc:Subject:From;
	b=nDNWPK33sYStPxih4Oz4byc3WjvmJ9CVsDFNjwWsdygMGVsDw6R4D3dD5X/udxcN0
	 931hMPKZaU/UIlvliIJxyzezF4hUozHyFaP/6qu0zxjDwLlNzwMNW62Gvopm2vE5xG
	 nhRq0RCmC0tqYJdxkY0P546JwYx8RyfByf3Uqfi52yuhWz0tQAW+OJ9ljr2Rrh8Mkv
	 DWCcykwTM1boBKD1OhTf7uwdPs+ppJgkPll26O4W2EM1CaOgW7QxJlRctpmX8jPWmB
	 OYByRQYrpzKZgb031nRIrHLgIsGRVgLtXfY9hVAl8XeycV3zvhzdoHEbkonPiL8wBG
	 0CvyjgBXvAgDg==
Date: Mon, 16 Sep 2024 15:54:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
	Lee Jones <lee@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] pwm: Changes for 6.12-rc1
Message-ID: <b4pdalox2xlrrwontj7ceesyko6v3atbtgoa4fcbe52ei4kqe3@yw7yfwl7zz5o>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adbwfppeizvdptnh"
Content-Disposition: inline


--adbwfppeizvdptnh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

the following changes since commit 10c48e9a8fd5e524d37559cf4a06039b4c25db48:

  pwm: stm32: Use the right CCxNP bit in stm32_pwm_enable() (2024-09-05 11:=
12:01 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.12-rc1

for you to fetch changes up to d242feaf81d63b25d8c1fb1a68738dc33966a376:

  pwm: stm32: Fix a typo (2024-09-16 15:24:59 +0200)

This is mostly what is in next for a while, I just found a broken commit
hash in a Fixes line during my last-minute-pre-PR checks, so I rewrote
00576dc859b82267e65b600dedc762d258f35e43 to
a550d6ae4d73dc4b9f1a2b3ad3d8d9e355b396be. The commits above changed
their IDs accordingly and the top commit is relatively new (but an
obvious spelling fix in a code comment, so should be harmless).

Please pull for v6.12-rc1.

Greetings to Vienna,
Uwe

----------------------------------------------------------------
pwm: Changes for v6.12-rc1

This pull request contains some cleanups to the core and some mostly
minor updates to a bunch of drivers and device tree bindings. One thing
worth pointing out is that it contains an immutable branch containing
support for a new mfd chip (Analog Devices ADP5585) with several sub
drivers. So expect to get the four affected commits also from my fellow
MFD and GPIO maintainers.

Thanks go to Andrew Kreimer, Clark Wang, Conor Dooley, David Lechner,
Dmitry Rokosov, Frank Li, Geert Uytterhoeven, George Stark, Jiapeng
Chong, Krzysztof Kozlowski, Laurent Pinchart, Liao Chen, Liu Ying, Rob
Herring and Wolfram Sang for code contributions and reviews and to Lee
Jones for preparing the above mentioned immutable branch.

----------------------------------------------------------------
Andrew Kreimer (1):
      pwm: stm32: Fix a typo

Clark Wang (1):
      pwm: adp5585: Add Analog Devices ADP5585 support

David Lechner (1):
      pwm: axi-pwmgen: use shared macro for version reg

George Stark (2):
      dt-bindings: pwm: amlogic: Add optional power-domains
      dt-bindings: pwm: amlogic: Add new bindings for meson A1 PWM

Haibo Chen (2):
      mfd: adp5585: Add Analog Devices ADP5585 core support
      gpio: adp5585: Add Analog Devices ADP5585 support

Jiapeng Chong (1):
      pwm: lp3943: Fix an incorrect type in lp3943_pwm_parse_dt()

Krzysztof Kozlowski (1):
      dt-bindings: pwm: allwinner,sun4i-a10-pwm: add top-level constraints

Laurent Pinchart (1):
      dt-bindings: mfd: Add Analog Devices ADP5585

Liao Chen (2):
      pwm: atmel-hlcdc: Enable module autoloading
      pwm: atmel-hlcdc: Drop trailing comma

Liu Ying (1):
      pwm: adp5585: Set OSC_EN bit to 1 when PWM state is enabled

Rob Herring (Arm) (2):
      pwm: lp3943: Use of_property_count_u32_elems() to get property length
      pwm: omap-dmtimer: Use of_property_read_bool()

Uwe Kleine-K=F6nig (5):
      pwm: Make info in traces about affected pwm more useful
      pwm: Don't export pwm_capture()
      pwm: Simplify pwm_capture()
      Merge tag 'ib-mfd-gpio-pwm-v6.12' of https://git.kernel.org/pub/scm/l=
inux/kernel/git/lee/mfd
      pwm: Switch back to struct platform_driver::remove()

Wolfram Sang (2):
      dt-bindings: pwm: renesas,pwm-rcar: Add r8a779h0 support
      dt-bindings: pwm: renesas,tpu: Add r8a779h0 support

 .../devicetree/bindings/mfd/adi,adp5585.yaml       |  92 +++++++++
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml      |   9 +-
 .../devicetree/bindings/pwm/pwm-amlogic.yaml       |  17 ++
 .../devicetree/bindings/pwm/renesas,pwm-rcar.yaml  |   1 +
 .../devicetree/bindings/pwm/renesas,tpu-pwm.yaml   |   1 +
 .../devicetree/bindings/trivial-devices.yaml       |   4 -
 MAINTAINERS                                        |  11 +
 drivers/gpio/Kconfig                               |   7 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-adp5585.c                        | 229 +++++++++++++++++=
++++
 drivers/mfd/Kconfig                                |  12 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/adp5585.c                              | 205 ++++++++++++++++++
 drivers/pwm/Kconfig                                |   7 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |  13 +-
 drivers/pwm/pwm-adp5585.c                          | 188 +++++++++++++++++
 drivers/pwm/pwm-atmel-hlcdc.c                      |   7 +-
 drivers/pwm/pwm-atmel-tcb.c                        |   2 +-
 drivers/pwm/pwm-axi-pwmgen.c                       |   3 +-
 drivers/pwm/pwm-clk.c                              |   2 +-
 drivers/pwm/pwm-hibvt.c                            |   2 +-
 drivers/pwm/pwm-img.c                              |   2 +-
 drivers/pwm/pwm-lp3943.c                           |  10 +-
 drivers/pwm/pwm-lpc18xx-sct.c                      |   2 +-
 drivers/pwm/pwm-omap-dmtimer.c                     |   4 +-
 drivers/pwm/pwm-rcar.c                             |   2 +-
 drivers/pwm/pwm-rockchip.c                         |   2 +-
 drivers/pwm/pwm-sifive.c                           |   2 +-
 drivers/pwm/pwm-stm32.c                            |   2 +-
 drivers/pwm/pwm-sun4i.c                            |   2 +-
 drivers/pwm/pwm-tegra.c                            |   2 +-
 drivers/pwm/pwm-tiecap.c                           |   2 +-
 drivers/pwm/pwm-tiehrpwm.c                         |   2 +-
 include/linux/mfd/adp5585.h                        | 126 ++++++++++++
 include/linux/pwm.h                                |  10 -
 include/trace/events/pwm.h                         |  10 +-
 37 files changed, 939 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
 create mode 100644 drivers/gpio/gpio-adp5585.c
 create mode 100644 drivers/mfd/adp5585.c
 create mode 100644 drivers/pwm/pwm-adp5585.c
 create mode 100644 include/linux/mfd/adp5585.h

--adbwfppeizvdptnh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmboOJ0ACgkQj4D7WH0S
/k65/AgAoyg7UCCQCzgF67GIarTypBoLD8MqPL5gyZ5+BB55wChr/gMSfVcfDGDJ
VOo0H0U0ZNQk5FXfwvcYd4YKjEAs3fGxR+laNTs/QNCPZgyVQ+oqV+I/AEmYml/+
x/FJOVmbXNBmgFw4NlYirZK7uhayhRdVOtxu9Y67sp/z3FgqrMR0IScf/fBvkBLk
sqPeAB2HqyfxUtBkUSC0hOweYzTBmiVxD8Sc6q5g1Gm9+cNz7pgVuxB7dMmvDPqe
SE5R6uCi9ZarMH77a+IUce53UMCPgNBcL90iI+LSFRvtEqVNtocDn/WaHIaIHg57
ovIG3PqKLe1f/BpC9OyitzdKQ3BZbQ==
=24vQ
-----END PGP SIGNATURE-----

--adbwfppeizvdptnh--

