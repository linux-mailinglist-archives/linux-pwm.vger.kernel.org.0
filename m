Return-Path: <linux-pwm+bounces-2169-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA5318C4D4C
	for <lists+linux-pwm@lfdr.de>; Tue, 14 May 2024 09:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8D81C20E92
	for <lists+linux-pwm@lfdr.de>; Tue, 14 May 2024 07:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBB814A85;
	Tue, 14 May 2024 07:52:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8426F13ACC
	for <linux-pwm@vger.kernel.org>; Tue, 14 May 2024 07:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715673162; cv=none; b=C4E6i9WGG+j+zMdbKoIZNTsLeEr8fmwJm27/Zcifgv5fRILm//wfFqe5p+GSlcDwYIdQ2Z7hlvWbctZzzGWsgmRCFzQSUw/vCwNlNcC+SwZwDIEqP2flbnagcNcbQz16I8ddsM8MROeZv+T22jcylr2q0TJbw7oeiiqmztWroK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715673162; c=relaxed/simple;
	bh=GzUDP9qyUtPowYjkmxi34ELF72sAUuP1hvoLcRapgG8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cWJw+7lKjlqe/EAsdMlkAD8sh8wI6oX5tT3BJ3AWCQhZkFmlxf2I1nSZX31zEQnHyNhHNPK4R4ap2NhOk6Tr9mCs45bpabyquFaaWRlWnR3qvOwcBvollsI/WCYEZxCRun5JgxXcRhlUZJ3SE7M1V72t+xNK/dXxH0vFhrLW4wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1s6mxf-0001Yg-V6; Tue, 14 May 2024 09:52:35 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1s6mxe-001JY2-GH; Tue, 14 May 2024 09:52:34 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1s6mxe-004MdF-1K;
	Tue, 14 May 2024 09:52:34 +0200
Date: Tue, 14 May 2024 09:52:22 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pwm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	Alexandre Mergnat <amergnat@baylibre.com>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Dmitry Rokosov <ddrokosov@salutedevices.com>, George Stark <gnstark@salutedevices.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, Varshini Rajendran <varshini.rajendran@microchip.com>, 
	kernel@pengutronix.de
Subject: [GIT PULL] pwm: Changes for v6.10-rc1
Message-ID: <ea6vevhosh66ghu724gpsvawqq3zggvruhhjsvbmasskhevmsq@lircam7wky64>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ceclf3girx2xyptj"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org


--ceclf3girx2xyptj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

the following changes since commit 190f1f46ede17ca0d7153ac115d6518ec1be2ba3:

  MAINTAINERS: Update Uwe's email address, drop SIOX maintenance (2024-04-2=
6 08:20:14 +0200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.10-rc1

for you to fetch changes up to 4817118f257e49b043f3d80f021a327b7e1d796f:

  pwm: pca9685: Drop explicit initialization of struct i2c_device_id::drive=
r_data to 0 (2024-05-10 07:30:27 +0200)

----------------------------------------------------------------
pwm: Changes for v6.10-rc1

Apart for the normal updates for dt bindings, cleanups and support for
new device variants to existing drivers this completes the conversion to
pwmchip_alloc() which was started in the v6.9 development cycle.

Using pwmchip_alloc() is a precondition to the character device support
which allows easier and faster access to PWM devices. However there are
some issues I want to clean up before including it in mainline, so this
isn't contained here despite it was in next for some time.

Thanks to Alexandre Mergnat, Binbin Zhou, Dmitry Rokosov, George Stark,
Jerome Brunet and Varshini Rajendran for their contributions. Further
thanks go to AngeloGioacchino Del Regno, Conor Dooley, David Lechner,
Fabrice Gasnier, Florian Fainelli, Guenter Roeck, Gustavo A. R. Silva,
Krzysztof Kozlowski and Rob Herring for valuable patch review.

----------------------------------------------------------------

This is based on v6.9-rc5 because commit 141a8502214d ("pwm: bcm2835:
Drop open coded variant of devm_clk_rate_exclusive_get()") made the
build bots unhappy without commit 7f1dd39aedfc ("clk: Provide
!COMMON_CLK dummy for devm_clk_rate_exclusive_get()").

There are two commits touching drivers/hwmon. The driver modified here
provides a pwm device and it is converted to pwmchip_alloc() before
making pwmchip_alloc() mandatory. These two patches have Guenter's
blessing.

Please pull this for v6.10-rc1.

Thanks
Uwe

Alexandre Mergnat (1):
      dt-bindings: pwm: mediatek,pwm-disp: add compatible for mt8365 SoC

Binbin Zhou (6):
      dt-bindings: pwm: bcm2835: Do not require pwm-cells twice
      dt-bindings: pwm: google,cros-ec: Do not require pwm-cells twice
      dt-bindings: pwm: marvell,pxa: Do not require pwm-cells twice
      dt-bindings: pwm: mediatek,mt2712: Do not require pwm-cells twice
      dt-bindings: pwm: mediatek,pwm-disp: Do not require pwm-cells twice
      dt-bindings: pwm: snps,dw-apb-timers: Do not require pwm-cells twice

George Stark (3):
      pwm: meson: Drop unneeded check in .get_state()
      pwm: meson: Add check for error from clk_round_rate()
      pwm: meson: Use mul_u64_u64_div_u64() for frequency calculating

Jerome Brunet (1):
      pwm: meson: Add generic compatible for meson8 to sm1

Uwe Kleine-K=F6nig (22):
      hwmon: (aspeed-g6-pwm-tacho): Make use of pwmchip_parent() accessor
      hwmon: (aspeed-g6-pwm-tacho): Make use of devm_pwmchip_alloc() functi=
on
      pwm: Ensure that pwm_chips are allocated using pwmchip_alloc()
      pwm: sti: Simplify probe function using devm functions
      pwm: sti: Improve error reporting using dev_err_probe()
      pwm: sti: Drop member from driver data that only carries a constant
      pwm: sti: Maintain all per-chip driver data in a single struct
      pwm: sti: Use devm_kcalloc() instead of calculating the size for devm=
_kzalloc()
      pwm: sti: Prefer local variable over pointer dereference
      pwm: Give some sysfs related variables and functions better names
      pwm: Move contents of sysfs.c into core.c
      pwm: Ensure a struct pwm has the same lifetime as its pwm_chip
      pwm: Add a struct device to struct pwm_chip
      pwm: Don't check pointer for being non-NULL after use
      pwm: Make pwmchip_[sg]et_drvdata() a wrapper around dev_set_drvdata()
      pwm: stm32: Add error messages in .probe()'s error paths
      pwm: stm32: Improve precision of calculation in .apply()
      pwm: stm32: Fix for settings using period > UINT32_MAX
      pwm: stm32: Calculate prescaler with a division instead of a loop
      pwm: bcm2835: Introduce a local variable for &pdev->dev
      pwm: bcm2835: Drop open coded variant of devm_clk_rate_exclusive_get()
      pwm: pca9685: Drop explicit initialization of struct i2c_device_id::d=
river_data to 0

Varshini Rajendran (1):
      dt-bindings: pwm: at91: Add sam9x7 compatible strings list

 .../devicetree/bindings/pwm/atmel,at91sam-pwm.yaml |   3 +
 .../bindings/pwm/google,cros-ec-pwm.yaml           |   1 -
 .../devicetree/bindings/pwm/marvell,pxa-pwm.yaml   |   1 -
 .../bindings/pwm/mediatek,mt2712-pwm.yaml          |   1 -
 .../devicetree/bindings/pwm/mediatek,pwm-disp.yaml |   2 +-
 .../devicetree/bindings/pwm/pwm-bcm2835.yaml       |   1 -
 .../bindings/pwm/snps,dw-apb-timers-pwm2.yaml      |   1 -
 drivers/hwmon/aspeed-g6-pwm-tach.c                 |  21 +-
 drivers/pwm/Kconfig                                |   4 -
 drivers/pwm/Makefile                               |   1 -
 drivers/pwm/core.c                                 | 606 +++++++++++++++++=
++--
 drivers/pwm/pwm-bcm2835.c                          |  30 +-
 drivers/pwm/pwm-meson.c                            | 213 +++++---
 drivers/pwm/pwm-pca9685.c                          |   4 +-
 drivers/pwm/pwm-sti.c                              | 161 ++----
 drivers/pwm/pwm-stm32.c                            |  60 +-
 drivers/pwm/sysfs.c                                | 545 ------------------
 include/linux/pwm.h                                |  36 +-
 18 files changed, 832 insertions(+), 859 deletions(-)
 delete mode 100644 drivers/pwm/sysfs.c
--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ceclf3girx2xyptj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmZDGCoACgkQj4D7WH0S
/k5riwf/f2KlvYedl1IYp+oS/j9cPIdByb6twz4AWQYbP6DrR8S245oYdNeImr1R
fx9L+DiyENMFxOFcVUp4vR59Rckmkw1zucylJ5zje4/mqfDmBuh66zDqpQLFApju
MLldf1Qb2OYycrMzvZYG+DqHyiYj7SvlIKwydO9ep/wgOhPpFVqXohc7toHVdHEu
H+gfKLel2PUpMKTD61/7n4A6TCxGkTfKmfqOp9wLtvo4uC1G1HICKa5NR7taWRts
FLQKsm3BBt4Y/XFJDFPOeiZegk/9JWaey2HnfdjSQ+VFx7YM+WKKrXKDiRTz0HdF
JQXYluezV+VZgCg7fVttxTUb/mpfAQ==
=ayjq
-----END PGP SIGNATURE-----

--ceclf3girx2xyptj--

