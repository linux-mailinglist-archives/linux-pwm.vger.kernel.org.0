Return-Path: <linux-pwm+bounces-6354-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BE6AD9D94
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 16:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D7817941A
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Jun 2025 14:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1122E2EE9;
	Sat, 14 Jun 2025 14:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQGMWqsp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE422DECB1;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749911830; cv=none; b=jDUF2Ej7U+te0mex//LAu03Kf3EpLdXNfs0qzvJqimeVa09exXPzwNGRptvtK+6PZOo2ALQTQ50xKMA4VB7ZGFdO2t92LoLls309Ky7LaEsh0Je07NYhtYZ/3kAETjgXm8IlMSvh0vCFXjDtyRTHRJMBeWlRxOhz8xFGRJgJwnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749911830; c=relaxed/simple;
	bh=HpQ+IOBHeSPQkLLUSRUG0Nf5j2qaZir3u+Hl3A3IsNw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hhVDIjWWS/s4qdLIb3lxQWo1UstDIKct/g6RHyIdNgazcUF7Ue1OGGhK5tz3IP5YUsbXnYOQAJ/n5GKV9sJIPnkJHW0vte8ItDzWEpQgr4vHpYVRkfH99mhszBOFs7vdUjtKYmanEPIybsTE3niU3vyJmLgsxONjm2GCntkxi+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQGMWqsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4729AC4CEEB;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749911830;
	bh=HpQ+IOBHeSPQkLLUSRUG0Nf5j2qaZir3u+Hl3A3IsNw=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=uQGMWqsp59ntf2w1H0jYSMzXkjzC7MgGomjzv3pEdP8OvgKUeKXzIp0+IBjkbJCHv
	 R4INZbZMK4HhUJ4vyt5M92+QYtKUD3DBeSbznh4VBOum+WZh1CgG/cRUSFvoh4XXep
	 THgG7id8GnAhu/ktHmoqG6n2345nwyqTRTyHtMnZ1A9eh+Q8X7XpfSsj6sZMqk6WZV
	 Kbw3h+REjL9fJAl7msgckNHEeLeiKxxiBeYSPqkzTfRc82c/U5CE6xEMPYwqe+PLkR
	 jNdYg4OBZ9OsRY+ATF+M9a0zZO2OTWwPNecxddJRAwzzq6zKwASs4RuvYcL7ahHI1P
	 eYUaeNn0KG4tA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3318EC71153;
	Sat, 14 Jun 2025 14:37:10 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v5 00/20] mfd: adp5585: support keymap events and drop
 legacy Input driver
Date: Sat, 14 Jun 2025 15:35:51 +0100
Message-Id: <20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMeITWgC/2XQTQ7CIBCG4asY1mJgAAuuvIdxMYWpkmhrWoMa0
 7tLmxh/WH6TPO9inmygPtLANosn6ynFIXZtHma5YP6I7YF4DHkzEGCEkpIHShzDxRjreHPjJLR
 vgtMG7JpldOmpifc5uNvnfYzDtesfcz/J6fpOqf9UklxwEGRF0HXQhFts8dQdVr47s6mV4OO1N
 IWH7BVWznlFwUoovPp4I6HwKnvhoJa6rhxaW3j95aF4RdLZN+CdtaHCCsWPH8fxBVDAMBZtAQA
 A
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749911835; l=3573;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=HpQ+IOBHeSPQkLLUSRUG0Nf5j2qaZir3u+Hl3A3IsNw=;
 b=ArtXRoO+FuNVNZqfpl2+TCQ9EL+05vwIiPyFP6UolfWbeck0+iU9jRWBvSQUWBcWMGsimkCX1
 vRJRENsYoM/C/HCJ62K6frCjaP1puvEpKAleEPCVZDFycxYkWHQs9oe
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi all,

Here it goes v4. Main changes is to drop chip info based struct and
directly use an enum in the FW .data pointer, use the notifier API for
dispatching events and multiple calls to mfd_add_devices().

Regarding the last point, I think I could have used multiple calls to
devm_mfd_add_devices() and avoid those gotos in adp5585_add_devices()
but I do not feel that would have been "correct".

Thanks!
- Nuno Sá

---
Changes in v5:
- Patch 2:
  * Use the existing devm_mfd_add_devices().
- Patch 3:
  * Remove TODO comment.
- Patch 4:
  * Mention in the commit message the Copyright update.
- Patch 6:
  * Return a struct regmap_config pointer in
    adp5585_fill_regmap_config();
  * Just leave a blank entry in the adp5585_regmap_defaults array.
- Patch 13:
  * Improve comments for pin6 (row5) validation;
  * Don't use magic numbers;
  * Drop some odd line breaks;
  * Initialize vartiable when declaring.
- Patch 14:
  * Drop double spaces;
  * Don't use magic numbers;
  * Improve some comments.
- Patch 16:
  * Fix missing semicolon.
- Patch 20:
  * DS -> datasheet. 

- Link to v4: https://lore.kernel.org/r/20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com
- Link to v3: https://lore.kernel.org/r/20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com
- Link to v2: https://lore.kernel.org/r/20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com
- Link to v1: https://lore.kernel.org/r/20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com

---
Nuno Sá (20):
      dt-bindings: mfd: adp5585: ease on the required properties
      mfd: adp5585: only add devices given in FW
      mfd: adp5585: enable oscilator during probe
      mfd: adp5585: make use of MFD_CELL_NAME()
      dt-bindings: mfd: adp5585: document adp5589 I/O expander
      mfd: adp5585: refactor how regmap defaults are handled
      mfd: adp5585: add support for adp5589
      mfd: adp5585: add a per chip reg struture
      gpio: adp5585: add support for the adp5589 expander
      pwm: adp5585: add support for adp5589
      dt-bindings: mfd: adp5585: add properties for input events
      mfd: adp5585: add support for event handling
      mfd: adp5585: support reset and unlock events
      mfd: adp5585: add support for input devices
      gpio: adp5585: support gpi events
      Input: adp5585: Add Analog Devices ADP5585/89 support
      Input: adp5589: remove the driver
      mfd: adp5585: support getting vdd regulator
      dt-bindings: mfd: adp5585: document reset gpio
      mfd: adp5585: add support for a reset pin

 .../devicetree/bindings/mfd/adi,adp5585.yaml       |  240 ++++-
 .../devicetree/bindings/trivial-devices.yaml       |    2 -
 MAINTAINERS                                        |    1 +
 drivers/gpio/Kconfig                               |    1 +
 drivers/gpio/gpio-adp5585.c                        |  364 ++++++-
 drivers/input/keyboard/Kconfig                     |   21 +-
 drivers/input/keyboard/Makefile                    |    2 +-
 drivers/input/keyboard/adp5585-keys.c              |  371 +++++++
 drivers/input/keyboard/adp5589-keys.c              | 1066 --------------------
 drivers/mfd/adp5585.c                              |  743 +++++++++++++-
 drivers/pwm/pwm-adp5585.c                          |   78 +-
 include/linux/mfd/adp5585.h                        |  118 ++-
 12 files changed, 1799 insertions(+), 1208 deletions(-)
---
base-commit: 407f60a151df3c44397e5afc0111eb9b026c38d3
change-id: 20250311-dev-adp5589-fw-e04cfd945286
--

Thanks!
- Nuno Sá



