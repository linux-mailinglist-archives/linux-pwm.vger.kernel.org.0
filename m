Return-Path: <linux-pwm+bounces-6122-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E48DAC36F4
	for <lists+linux-pwm@lfdr.de>; Sun, 25 May 2025 23:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA611892D22
	for <lists+linux-pwm@lfdr.de>; Sun, 25 May 2025 21:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1691B1A3178;
	Sun, 25 May 2025 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/7ZHKlt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BE77263F;
	Sun, 25 May 2025 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748208356; cv=none; b=qivCRAFGdp5UoMNlNGIpQNnJ6WZU+VDTm3s1aYjol3VsSgmmUypDvX5FEjzlh2lzN/9+32z5rq1+5SYNh8EHBx/JSxD2rMmV1NWjjnPViP4msJUSede1SWoN0otAOj1/Kshwg8EmsI49DFWmUTUGJ74RHtdNxiVQamYx9dn2Mjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748208356; c=relaxed/simple;
	bh=pZ5pv2URNbGJHfJe1LId3MqzvYngg2w87QtQtHT8UIo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DFmSceC0to4yBFf9/e8KvKpRE/JYMXENlfUo2Bpd4PBeG/Mp+LRvHgaZ3Uyf+JYrYqcdcbHdqPQGiuM5dtoXTF9JnbfazOaMgx4/YZuHYxmiuMjx6tjCcngHIucK59Lv24qRfS+7c0ajWe3Aq7p460xFOOmpKAxN14NdlUtxY5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/7ZHKlt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3F2C4CEEA;
	Sun, 25 May 2025 21:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748208355;
	bh=pZ5pv2URNbGJHfJe1LId3MqzvYngg2w87QtQtHT8UIo=;
	h=Date:From:To:Cc:Subject:From;
	b=r/7ZHKlt5B5zjS0Yqt/OaPtgBBJ0SVEWiiBDycs7TUJq2aGrXGUzsU9Il3t+EyWxG
	 j74XHN+BmG/bU7RpUm643hihQnWzcfxG+F6SCjLoEsHItRxF2DbtWmq6fRS18p7wm9
	 8rUvhAFsEmlJyWwBsBA9BgeYPk/aXutxxL4nncX9YoEIFecJI75nQOYHAeAQKex3Jm
	 tmofEJpCMp0sYx43WrEjOAbWbf5O7U87GHrk/cb4algu7GumWdNen+yL/EhB9FwPMH
	 Z03qqZDBCWBiiC4CB8Nyh/i+i5FXZpcfjA1nWdhgr7WHulNX1pI3mmIdNeNJ4B/Mft
	 7sA5nT11xkG8A==
Date: Sun, 25 May 2025 23:25:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Lee Jones <lee@kernel.org>, Andi Shyti <andi@smida.it>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for 6.16-rc1
Message-ID: <rsnijkpfz2u2y67352hmcmo7bufcwm4ukdklf6ucw3fj72utxa@snrwsd27ye6a>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2b5waiygeda6pqj3"
Content-Disposition: inline


--2b5waiygeda6pqj3
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] pwm: Changes for 6.16-rc1
MIME-Version: 1.0

Hello Linus,

the following changes since commit 8ffd015db85fea3e15a77027fda6c02ced4d2444:

  Linux 6.15-rc2 (2025-04-13 11:54:49 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/p=
wm/for-6.16-rc1

for you to fetch changes up to c0c980f237e822fd9cc6c0ab5b60ce8efe76464e:

  dt-bindings: timer: renesas,tpu: remove binding documentation (2025-05-19=
 18:46:45 +0200)

It contains a merge of the Renesas tree by Geert Uytterhoeven that you
will also get a pull request for via the arm-soc tree. This was merged to
allow to rename a few PWM Kconfig symbols where the old name was added
to a defconfig file (commit 5ad7de623853 ("arm64: defconfig: Enable
Renesas RZ/G2L GPT config")).

You will get another pull request including a change to
drivers/pwm/pwm-stm32-lp.c by Lee Jones. Lee provided an immutable
branch for that, I didn't merge it however as there are no conflicting
changes in my tree, so you will only notice that if you look carefully
at the diffstat.

There is a merge conflict in MAINTAINERS with commit 3887d3f64260
("dt-bindings: i2c: i2c-wmt: Convert to YAML") from Andi Shyti's
i2c-tree. The trivial resolution that is also in next looks as follows:

diff --cc MAINTAINERS
index 26ef29a0c9bf,bc13b87e85c0..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -3427,8 -3434,7 +3434,8 @@@ M:	Alexey Charkov <alchark@gmail.com
  M:	Krzysztof Kozlowski <krzk@kernel.org>
  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
  S:	Odd Fixes
- F:	Documentation/devicetree/bindings/i2c/i2c-wmt.txt
+ F:	Documentation/devicetree/bindings/i2c/wm,wm8505-i2c.yaml
 +F:	Documentation/devicetree/bindings/pwm/via,vt8500-pwm.yaml
  F:	arch/arm/boot/dts/vt8500/
  F:	arch/arm/mach-vt8500/
  F:	drivers/clocksource/timer-vt8500.c

Depending on merge order it also might conflict with commit 47cbd5d8693d
("ARM: vt8500: MAINTAINERS: Include vt8500 soc driver in maintainers
entry") from Krzysztof Kozlowski's dt tree again in MAINTAINERS. The
difficulty is similar, I guess you hit these conflicts all the time and
will cope just fine. If you still want a reference: next is fine here,
too.

This time thanks for contributions and reviews go to Alexey Charkov,
AngeloGioacchino Del Regno, Bartosz Golaszewski, Biju Das, Binbin Zhou,
Dan Carpenter, Dimitri Fedrau, Geert Uytterhoeven, George Stark, Huacai
Chen, Juxin Gao, Krzysztof Kozlowski, Kuninori Morimoto, Laurent
Pinchart, Neil Armstrong, Nuno S=E1, Rob Herring, and Trevor Gamblin.

Best regards
Uwe

----------------------------------------------------------------
pwm: Changes for v6.16-rc1

This time around the pwm changes for the next release contain three new
drivers (loongson, mc33xs2410 and rzg2l-gpt) and the usual collection of
cleanups in both the core and drivers, support for new variants in
existing drivers, conversion of dt bindings to yaml and documentation
updates.

----------------------------------------------------------------
Alexey Charkov (1):
      dt-bindings: pwm: vt8500-pwm: Convert to YAML

AngeloGioacchino Del Regno (1):
      dt-bindings: pwm: mediatek,pwm-disp: Add compatible for MT6893

Bartosz Golaszewski (1):
      pwm: pca9685: Use new GPIO line value setter callbacks

Biju Das (3):
      dt-bindings: pwm: Add RZ/G2L GPT binding
      pwm: Add support for RZ/G2L GPT
      arm64: defconfig: Enable Renesas RZ/G2L GPT config

Binbin Zhou (2):
      dt-bindings: pwm: Add Loongson PWM controller
      pwm: Add Loongson PWM controller support

Dan Carpenter (1):
      pwm: loongson: Fix an error code in probe()

Dimitri Fedrau (2):
      dt-bindings: pwm: add support for MC33XS2410
      pwm: add support for NXPs high-side switch MC33XS2410

Geert Uytterhoeven (1):
      ARM: shmobile: defconfig: Enable more support for RZN1D-DB/EB

George Stark (5):
      pwm: meson: Simplify get_state() callback
      pwm: meson: Support constant and polarity bits
      pwm: meson: Use separate device id data for axg and g12
      pwm: meson: Enable constant and polarity features for g12, axg, s4
      pwm: meson: Simplify meson_pwm_cnt_to_ns()

Kuninori Morimoto (3):
      arm64: defconfig: Add Renesas MSIOF sound support
      pwm: Tidyup PWM menu for Renesas
      dt-bindings: timer: renesas,tpu: remove binding documentation

Lad Prabhakar (4):
      soc: renesas: Kconfig: Enable SoCs by default when ARCH_RENESAS is set
      arm64: defconfig: Remove individual Renesas SoC entries
      arm: shmobile_defconfig: Drop individual Renesas SoC entries
      arm: multi_v7_defconfig: Drop individual Renesas SoC entries

Nuno S=E1 (1):
      pwm: adp5585: make sure to include mod_devicetable.h

Uwe Kleine-K=F6nig (15):
      pwm: pxa: Improve using dev_err_probe()
      pwm: Make chip parameter to pwmchip_get_drvdata() a const pointer
      pwm: Add actual hardware state to pwm debugfs file
      pwm: stm32: Don't open-code TIM_CCER_CCxE()
      pwm: stm32: Emit debug output also for corner cases of the rounding c=
allbacks
      pwm: Do stricter return value checking for .round_waveform_tohw()
      pwm: loongson: Fix u32 overflow in waveform calculation
      pwm: Better document return value of pwm_round_waveform_might_sleep()
      pwm: Fix various formatting issues in kernel-doc
      pwm: rzg2l-gpt: Accept requests for too high period length
      pwm: Let pwm_set_waveform_might_sleep() fail for exact but impossible=
 requests
      pwm: Let pwm_set_waveform_might_sleep() return 0 instead of 1 after r=
ounding up
      pwm: Formally describe the procedure used to pick a hardware waveform=
 setting
      pwm: Restore alphabetic ordering in Kconfig and Makefile
      Merge tag 'renesas-arm-defconfig-for-v6.16-tag2' of https://git.kerne=
l.org/pub/scm/linux/kernel/git/geert/renesas-devel into pwm/for-next

 .../devicetree/bindings/pwm/loongson,ls7a-pwm.yaml |  67 +++
 .../devicetree/bindings/pwm/mediatek,pwm-disp.yaml |   1 +
 .../devicetree/bindings/pwm/nxp,mc33xs2410.yaml    | 118 ++++++
 .../devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml | 378 +++++++++++++++++
 .../devicetree/bindings/pwm/renesas,tpu-pwm.yaml   |   9 -
 .../devicetree/bindings/pwm/via,vt8500-pwm.yaml    |  43 ++
 .../devicetree/bindings/pwm/vt8500-pwm.txt         |  18 -
 .../devicetree/bindings/timer/renesas,tpu.yaml     |  56 ---
 MAINTAINERS                                        |   8 +
 arch/arm/configs/multi_v7_defconfig                |  21 +-
 arch/arm/configs/shmobile_defconfig                |  28 +-
 arch/arm64/configs/defconfig                       |  29 +-
 drivers/pwm/Kconfig                                | 113 ++++--
 drivers/pwm/Makefile                               |  11 +-
 drivers/pwm/core.c                                 | 118 ++++--
 drivers/pwm/pwm-adp5585.c                          |   1 +
 drivers/pwm/pwm-loongson.c                         | 290 +++++++++++++
 drivers/pwm/pwm-mc33xs2410.c                       | 391 ++++++++++++++++++
 drivers/pwm/pwm-meson.c                            | 123 ++++--
 drivers/pwm/pwm-pca9685.c                          |   8 +-
 drivers/pwm/pwm-pxa.c                              |  18 +-
 drivers/pwm/pwm-rzg2l-gpt.c                        | 447 +++++++++++++++++=
++++
 drivers/pwm/pwm-stm32.c                            |  15 +-
 drivers/soc/renesas/Kconfig                        |  42 ++
 include/linux/pwm.h                                |  10 +-
 25 files changed, 2086 insertions(+), 277 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/pwm/nxp,mc33xs2410.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/pwm/via,vt8500-pwm.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/pwm/vt8500-pwm.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tpu.yaml
 create mode 100644 drivers/pwm/pwm-loongson.c
 create mode 100644 drivers/pwm/pwm-mc33xs2410.c
 create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c

--2b5waiygeda6pqj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmgzitwACgkQj4D7WH0S
/k7sZAf/T2zWdbkMGeKeoT/of1eomiCF6XDGXDI5i1okI1foNY/tt2HPIFIenjKP
rbRZl6xa+zw6O4Ibb/E5X6h1nazSqQNX6JETJ+1TmSZtQDqy7h+t+ZIQ8DSjsL9s
o9EmiYwUkQSXyAUfGXZ1xjViKNLNveCZFYODgj4qoMzZVl1MhAH+z5tEIgpDuFse
T6Gs97KrTOjRto3lYTtUfUc2oDphRRx5ICzTxwLOIlgxQUVhztOSB3qsInHhiga/
xmwjH6PYejAEPgaUoAUB897aqPidE6WoZj31J8PEXpjWn6xqRGi5LYf71PhlEpYF
1yAng1uQQh4N4uLgMMny/Czl7dsMEA==
=cD4E
-----END PGP SIGNATURE-----

--2b5waiygeda6pqj3--

