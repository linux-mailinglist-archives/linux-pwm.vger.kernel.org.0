Return-Path: <linux-pwm+bounces-6584-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B455AEDBB6
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 13:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D2E1896C21
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 11:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043BA283FF6;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NniqNchQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA1283FC9;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284365; cv=none; b=amT8/s2lbnBexf9bK2LW/7aOf40WoQagOCWiC8FOK9pBjgaNqIvTvUtPt5GiCDXFPD3y6tB8yZlYP1blxbJ3nZvIR3rEaGsArXRgWccuG15YwTiOn8kIS0IfudfKL3/NGXlDkfyO/nQKCav7TUMB1mUVR47bDkJ3mOzbSuk3604=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284365; c=relaxed/simple;
	bh=Tuue1hmuHDuh+BsGUr9KiLI1MbJGf/yvmllNqLm9VGE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jsfhJJZZbIQZ6uFfr9BtrlYKUrdmZgEC+k6drJSUXOxKZYyHsO6ZqSDHP/+HiDl/HTUH+jsVJ48J2GyjbHM12kuTwX30PKcH9+HFnUjqJek0K4fOvPJeo6hNaHCrvgVvl43Nxdgvom6JBnlgr+usGqffy67H6z9X6rGV0pCfu7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NniqNchQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B003C4CEE3;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751284365;
	bh=Tuue1hmuHDuh+BsGUr9KiLI1MbJGf/yvmllNqLm9VGE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=NniqNchQdMIfX6R+8zW+bTPZ+MNGxEt3srOG0zqd2hJCEXIIOzFQJeWErPwzU42yW
	 UAbd9mpE4v6QDa+MWBfBmgMoKjhzPvylhWblOI7Ov1JuMKh1MDOyGPrxAfMn5T/L/D
	 /eBDdZYxvqFXdGpG5tXR5/0MPrQik1dTWzRqCYl6i4CO3mp6Nks+cU7H8M/xIjDwqA
	 9vVQtB+Ospsiq8tBWnZmVP/UYYg4KgvTTkJoWEEvdhV8lwnP23Rh0Iq+t1KngUWoiV
	 1x+lsHrG2dt91BsZVq5NIpFLok3noMrV81lMcdb13eHYpGbw9tmOw3S3uaW97ql3SO
	 ejCYuGm7hU68A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42057C7EE2A;
	Mon, 30 Jun 2025 11:52:45 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v6 00/20] mfd: adp5585: support keymap events and drop
 legacy Input driver
Date: Mon, 30 Jun 2025 12:52:51 +0100
Message-Id: <20250630-dev-adp5589-fw-v6-0-a0f392a0ba91@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJR6YmgC/2XQ3UoDMRCG4VspOTaSTCY/0yPvQzzIJrNtQHfLr
 kSl7L2bFmTVHH6B5x3IVay8FF7F8XAVC9eylnlqwz0cRDrH6cSy5LYFKLDKaC0zVxnzxdpAcvy
 QrDCNmdBCcKKhy8Jj+bwHn1/aPpf1fV6+7v2qb68/KfM/VbVUEhQHlXHIyPEpTvF1Pj2m+U3cW
 hV2j9p2Hpo30RMlwzlo6LzZvdXQedO8Ihg0Dp5iCJ3HXx66r6jY/AiJQsg++qg6b3fvNHbeNu+
 ZckBSDtzf+9u2fQPH5YZUrQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751284374; l=2695;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Tuue1hmuHDuh+BsGUr9KiLI1MbJGf/yvmllNqLm9VGE=;
 b=pLHQvRZYzYYmUWhmgrGGvtuvkgUi3oa8Ds3SLuTCixTMwA0ncawRA4rRyqbFTx4tZLewRx9AM
 2FXWfuuSOFVA0u0gqF+LBmrK6Cmrt6boKbedcpdYQamXgah0wzuouuY
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi all,

Here it goes v6. Lee, note that I did not added changelog for changing
the the git subject on MFD patches.

Thanks!
- Nuno Sá

---
- Link to v5: https://lore.kernel.org/r/20250614-dev-adp5589-fw-v5-0-7e9d84906268@analog.com
- Link to v4: https://lore.kernel.org/r/20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com
- Link to v3: https://lore.kernel.org/r/20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com
- Link to v2: https://lore.kernel.org/r/20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com
- Link to v1: https://lore.kernel.org/r/20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com

---
Nuno Sá (20):
      dt-bindings: mfd: adp5585: ease on the required properties
      mfd: adp5585: Only add devices given in FW
      mfd: adp5585: Enable oscilator during probe
      mfd: adp5585: Make use of MFD_CELL_NAME()
      dt-bindings: mfd: adp5585: document adp5589 I/O expander
      mfd: adp5585: Refactor how regmap defaults are handled
      mfd: adp5585: Add support for adp5589
      mfd: adp5585: Add a per chip reg struture
      gpio: adp5585: add support for the adp5589 expander
      pwm: adp5585: add support for adp5589
      dt-bindings: mfd: adp5585: add properties for input events
      mfd: adp5585: Add support for event handling
      mfd: adp5585: Support reset and unlock events
      mfd: adp5585: Add support for input devices
      gpio: adp5585: support gpi events
      Input: adp5585: Add Analog Devices ADP5585/89 support
      Input: adp5589: remove the driver
      mfd: adp5585: Support getting vdd regulator
      dt-bindings: mfd: adp5585: document reset gpio
      mfd: adp5585: Add support for a reset pin

 .../devicetree/bindings/mfd/adi,adp5585.yaml       |  240 ++++-
 .../devicetree/bindings/trivial-devices.yaml       |    2 -
 MAINTAINERS                                        |    1 +
 drivers/gpio/Kconfig                               |    1 +
 drivers/gpio/gpio-adp5585.c                        |  364 ++++++-
 drivers/input/keyboard/Kconfig                     |   21 +-
 drivers/input/keyboard/Makefile                    |    2 +-
 drivers/input/keyboard/adp5585-keys.c              |  371 +++++++
 drivers/input/keyboard/adp5589-keys.c              | 1066 --------------------
 drivers/mfd/adp5585.c                              |  741 +++++++++++++-
 drivers/pwm/pwm-adp5585.c                          |   78 +-
 include/linux/mfd/adp5585.h                        |  118 ++-
 12 files changed, 1797 insertions(+), 1208 deletions(-)
---
base-commit: 407f60a151df3c44397e5afc0111eb9b026c38d3
change-id: 20250311-dev-adp5589-fw-e04cfd945286
--

Thanks!
- Nuno Sá



