Return-Path: <linux-pwm+bounces-5492-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 202E3A8A196
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 16:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D76A441A8D
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED51A29A3D3;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UM3LOCZ+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53C81C84A2;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728559; cv=none; b=p33kryhs1iBOpF/k8G0sOtZuxYxw31GyK/R5q1HbaRHJWOJ07eN7qSmh9RcFNsyDXpf6do1tAM96+bajI/iRk/LGiUOmxU9ChPc7wYA9UJoyPqkZWfjs6UGKC3yAiwE4myVHcVQE0fQVjJJPi6tXX2yZc3rOgQ9jsF5dUJioVnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728559; c=relaxed/simple;
	bh=1YZSRaVDusksRM573pWwDi4SZBCKuSaeLIow9Kp3l3I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Mm9EUZVniSvX0NSY42uTFQ0sBZHd1YMLsPXmZnKmiEPLwUeC3ZY2lvJyY4XvutR1jsbYlT7NJwhvcuclu6v6cXhciebdrDn+I0rl9J/0Tub+eXA8yZhL8Xswp4tj9LuJItuA8Ff21OVawcjigo0DSQAX2MnS0K1z/SCO5i7TdTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UM3LOCZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 232A2C4CEEB;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728559;
	bh=1YZSRaVDusksRM573pWwDi4SZBCKuSaeLIow9Kp3l3I=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=UM3LOCZ+j+l42mq9moS6IN+XAJ14rcWF/yTFXb+i4yMHVa4+44Un9ORFZF7vOeXRP
	 Rl9stWHc2bEHLsdklU41WZ3JCFBiar692j2uaNWghVqJtRIwB8o7pBx5BCjJzGBL3g
	 vYTs213TgkinqNGqZ1J7ouu3Yq6zvw3pmjSwXD+/JDJT0q+uOgp5+2ktXcaOuTrGbv
	 RlYnZUNhrwdL8cCDwg/bWf2/Qd8VMhax/k+hcT7DeAgMHWGZsvJvvGc8vJ2eR9KCOW
	 WLjY5aFeWUKnD+9+XmXnVsQUISusWGsxSN79If9mRAQRyxasDxjEpxQ+g2090DXu5/
	 Sw6/NJ32tUE5A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13818C369AB;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 00/17] mfd: adp5585: support keymap events and drop
 legacy Input driver
Date: Tue, 15 Apr 2025 15:49:16 +0100
Message-Id: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOxx/mcC/13MQQ7CIBCF4as0s3YMUDCtq97DdIEwtCRaGjCoa
 bi72MSNy/8l79sgUfSU4NxsECn75MNSQxwaMLNeJkJva4NgQrGWc7SUUdtVqa5H90Ri0jjbSyW
 6E9TTGsn51w5extqzT48Q37uf+Xf9Ue0/lTkyFIw6ZuXVStKDXvQtTEcT7jCWUj6Zld7srQAAA
 A==
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
 Liu Ying <victor.liu@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728559; l=3998;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=1YZSRaVDusksRM573pWwDi4SZBCKuSaeLIow9Kp3l3I=;
 b=w0G5TNF3ytrz+ne3xbnvovn3y0/E5PqAb7Y/asbnYDqtM/Z73hQZEnaSQAOWjHoZdmXfWh3V6
 Fe2KiJys+hFAiR6I8Z3ceeR9Wyvihg6p9RL3r1COFyC8eUccipAM0bQ
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

BTW the series is based on linux-next/master

---
Changes in v2:
- Patch 5:
   * Do not nest if:then:else::if:then.
- Patch 6:
   * Make use of the adp5585 info variables and adp5589 volatile regs.
- Patch 9:
   * Use standard "poll-interval" property (and move it before vendor
     properties).
- Patch 10:
   * Make sure to include bitfield.h.

- Link to v1: https://lore.kernel.org/r/20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com

---
Nuno Sá (17):
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

 .../devicetree/bindings/mfd/adi,adp5585.yaml       |  240 ++++-
 .../devicetree/bindings/trivial-devices.yaml       |    2 -
 MAINTAINERS                                        |    1 +
 drivers/gpio/Kconfig                               |    1 +
 drivers/gpio/gpio-adp5585.c                        |  299 +++++-
 drivers/input/keyboard/Kconfig                     |   21 +-
 drivers/input/keyboard/Makefile                    |    2 +-
 drivers/input/keyboard/adp5585-keys.c              |  221 ++++
 drivers/input/keyboard/adp5589-keys.c              | 1066 --------------------
 drivers/mfd/adp5585.c                              |  808 ++++++++++++++-
 drivers/pwm/pwm-adp5585.c                          |   57 +-
 include/linux/mfd/adp5585.h                        |  153 ++-
 12 files changed, 1709 insertions(+), 1162 deletions(-)
---
base-commit: 5b37f7bfff3b1582c34be8fb23968b226db71ebd
change-id: 20250311-dev-adp5589-fw-e04cfd945286
--

Thanks!
- Nuno Sá



