Return-Path: <linux-pwm+bounces-5152-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4ACA5F779
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2100420B3A
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EFB267F65;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/J0MeeR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D22842077;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875557; cv=none; b=DmtRPO1uWQS3xmMTqsPqYSfSk6oeyylKdOu5ZjY9ubqEIdzS0NfyNxTh2F1Dzb3pm77VJdHV5gOklcKtf+Di+UQWk6dl3YCYhNfj+G3wShxXaYkeAnpdpngskvUfeD4VitLw1/lcNr0VDIDV9K67Ail2oZy8T4IG+cGim5AyAJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875557; c=relaxed/simple;
	bh=1hmYFCYRlnFEnOVA+8j1hptv02veyE2YwfRsJCXsjL4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OjEBwA8btYYPvaIgg9n5EG2bIFc7ysQglQBouN8ZX1yao1GZWGK/DICIjuS+pm4+7JLpfpdp2ZvhDvcWKlc/UxJU0Ev1uOj4EfeJ+rucQlh48W8H/jPGDt1C6HvL6S/FokvzZBXCAyH16LMVG2ek6En5Bl7a5/86ltxpTzqPnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/J0MeeR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44272C4CEEB;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875557;
	bh=1hmYFCYRlnFEnOVA+8j1hptv02veyE2YwfRsJCXsjL4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=T/J0MeeRFpV6kuvJc2wFRZW5+InTiZiBs5wpHWZU9pp3uBRRL611Mvw5HUrkUdHZl
	 T0eic7qKHXsHuFQgoIZD9Q8XWbUJcNjwVYVxbGkCoVkWqHSAFdo4qVNAykKMdVPOAR
	 Wcku3mKRUbUcLrLcADd1aNuVkk8AM5eWn71e8T8rukykkBOBMiKJV8GEB5nIm/OQEH
	 pjIjNSdH7Wc2ozqdLphVmmb5SwQDTOZDLINj6GJY8fl3Uhg1C+KKID1OV59ez/64Kr
	 Y1/g780EVCdeSgtfVuRib5XDjCj5c5sX5WE8imuMn5yCjicCSZnejFw3ONUq3y1EbR
	 D7iwETtQ91XHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366CCC282EC;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 00/18] mfd: adp5585: support keymap events and drop legacy
 Input driver
Date: Thu, 13 Mar 2025 14:19:17 +0000
Message-Id: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGbp0mcC/x3MQQqAIBBA0avErBtQ06iuEi1Ex5qNhUIF4t2Tl
 m/xf4FMiSnD0hVIdHPmMzbIvgN32LgTsm8GJZQRg5To6UbrL2OmGcODJLQLftZGTSO06EoU+P2
 H61brB2w0KPRgAAAA
X-Change-ID: 20250311-dev-adp5589-fw-e04cfd945286
To: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875561; l=3601;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=1hmYFCYRlnFEnOVA+8j1hptv02veyE2YwfRsJCXsjL4=;
 b=HO4x96uZcuESctomGU8fatWdFsgoQn9KLUeut0G8836eRXN3jvJMzSkjvrZOH486P6BzuEohr
 QbgRIWaUh1RD8yCObB7uHdwzu2js9lzPZHXjqenm/x/MH8Whl/wHbit
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

The adp5585 MFD driver was introduced in 6.11 adding support for gpio
and PWM. However, the gpio part of it was already supported as part of
the keyboard driver:

https://elixir.bootlin.com/linux/v6.14-rc6/source/drivers/input/keyboard/adp5589-keys.c#L532

On top of that it also overlapped with my refactoring of the above driver [1]
to drop usage of platform data and use FW properties instead.

Now, it actually makes sense for this device to be supported under MFD
and since the "legacy" input device depends on platform data that is not
defined anywhere the plan in this series is to add support for the
keyboard and adp5589 devices as part of the MFD driver. Once the MFD
driver supports all that's supported in the Input one, we drop it...

For DT Maintainers:

The compatible for adp5589 is part of trivial devices. To me, it makes
sense to remove it in the patch where we drop the driver but doing so
would result in a warning when adding the same compatible for the MFD
bindings. Hence, I remove it in that patch. Is that ok?

Uwe:

In my eval board, I could see that reading the GPIO value (when
configured as input) does not work when OSC_EN is not set. Therefore,
commit ("pwm: adp5585: don't control OSC_EN in the pwm driver") could
very well have a Fixes tag. However I'm not 100% sure it's a real issue
or something special to my eval board.

It would be nice if Laurent or Liu could test the PWM bits or even
check that the above is also an issue for their platform.

[1]: https://lore.kernel.org/linux-input/d1395bd61ce58b3734121bca4e09605a3e997af3.camel@gmail.com/

---
Nuno Sá (18):
      dt-bindings: mfd: adp5585: ease on the required properties
      mfd: adp5585: enable oscilator during probe
      pwm: adp5585: don't control OSC_EN in the pwm driver
      mfd: adp5585: make use of MFD_CELL_NAME()
      dt-bindings: mfd: adp5585: document adp5589 I/O expander
      mfd: adp5585: add support for adp5589
      gpio: adp5585: add support for the ad5589 expander
      pwm: adp5585: add support for adp5589
      dt-bindings: mfd: adp5585: add properties for input events
      mfd: adp5585: add support for key events
      gpio: adp5585: support gpi events
      Input: adp5585: Add Analog Devices ADP5585/89 support
      Input: adp5589: remove the driver
      mfd: adp5585: support getting vdd regulator
      dt-bindings: mfd: adp5585: document reset gpio
      mfd: adp5585: add support for a reset pin
      pwm: adp5585: make sure to include mod_devicetable.h
      gpio: adp5585: make sure to include mod_devicetable.h

 .../devicetree/bindings/mfd/adi,adp5585.yaml       |  243 ++++-
 .../devicetree/bindings/trivial-devices.yaml       |    2 -
 MAINTAINERS                                        |    1 +
 drivers/gpio/Kconfig                               |    1 +
 drivers/gpio/gpio-adp5585.c                        |  299 +++++-
 drivers/input/keyboard/Kconfig                     |   21 +-
 drivers/input/keyboard/Makefile                    |    2 +-
 drivers/input/keyboard/adp5585-keys.c              |  221 ++++
 drivers/input/keyboard/adp5589-keys.c              | 1066 --------------------
 drivers/mfd/adp5585.c                              |  799 ++++++++++++++-
 drivers/pwm/pwm-adp5585.c                          |   57 +-
 include/linux/mfd/adp5585.h                        |  153 ++-
 12 files changed, 1703 insertions(+), 1162 deletions(-)
---
base-commit: 4d395cb071a343196ca524d3694790f06978fe91
change-id: 20250311-dev-adp5589-fw-e04cfd945286
--

Thanks!
- Nuno Sá



