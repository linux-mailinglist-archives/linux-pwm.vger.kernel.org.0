Return-Path: <linux-pwm+bounces-5896-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D60AAB372C
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AD61886695
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A929372B;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRi0Mj/A"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD07D610D;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=J1PIBoYczzbs5ZUidjok8mLZt1c++YfOz1SPXNRc54H8R4Stke79D3JNhPAdjBIVgXvkHE3lOpn1BG98QyHkmSeEfRxqN3cJbo3Vkk9SNWFe7pIholPv7hD7qbuTUrJh21eaTRz29JBtW8VZA3ijE0Eq1O6CWWh9D3SIe0PP4vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=NqT3bibK3Jvi4NAqycwo7bNrt+NCy+HAVXsUduhU2QE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hfckXFbLHk8Hm1Q+Wp+BsudIL1VrK3JL9C563LyU7ggBd9DuCJEAaO+nQvppMhAzt2A2mWIScg5RPjvbpzQnVPh4EZ8/39BhL0JrycK4hJXP3iiVQNl6VDGY8L3xGFENaiD8GAbJtGtkETIQ2XPj+Ap2aG//SHNY+m1KH3azXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRi0Mj/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A3E0C4CEE7;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053538;
	bh=NqT3bibK3Jvi4NAqycwo7bNrt+NCy+HAVXsUduhU2QE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=RRi0Mj/AIUzwoec+hbMvz57SPHm63KsWx0k1Bt4eFDn5KpUWj40qpVw+G4ycTKoJt
	 dHn0FQKmFP3LmUczZO0kVX/emUHt02Dui9G0k9mMB9H5kRkUewOBuWie8uXWMUZ9cq
	 zAjH04YoDZiYY7TPTDANDlgvgBuvpL6b8yx1IJ/VAl0d9qyuDN1Ot4UcVNNt0WWG/Y
	 iaDBe5HcKA7jLSZBGPaJAvWVu5NxxTgRHYqTDLd5+qKfOpI+KC2wrdnqmXnFxC2u03
	 frtv18JG1roXm86O97hfgufbe/wwyAz6/TizQ6SiFNIjWdzJ86eotrDq4ZoR456dDi
	 jJ+DQ4+ReWlNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A82EC3ABC3;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v3 00/22] mfd: adp5585: support keymap events and drop
 legacy Input driver
Date: Mon, 12 May 2025 13:38:52 +0100
Message-Id: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAN3rIWgC/2XMSwrCMBSF4a3IHRvJUxNH7kMcxOS2DWhTEolK6
 d5NCyLq8Bz4vxEypoAZ9qsREpaQQ+zrEOsVuM72LZLg6wZOuaKCMeKxEOsHpbQhzZ0gla7xRiq
 ut1CjIWETHgt4PNXdhXyL6bn4hc3vmxK/VGGEEk5RUy/PXqI92N5eYrtx8QqzVfinl0z99bz2w
 u6McQK9Zvyrn6bpBZhdk7vtAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=5336;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=NqT3bibK3Jvi4NAqycwo7bNrt+NCy+HAVXsUduhU2QE=;
 b=EFLo6ZIgTAM5O8iofw+ajksRi/O1Lv5AWVLMBQWA4uFzJOSyo7ELbf+OH49Gh9U66zTj6jxfd
 DAPGQTxQtFRAQifU5otPopYWjE9713nXZZE/NtubtDTu+TqXrKHz4No
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Hi all,

Here it goes v3. There was some major refactoring in this version due to
Lee's and Laurent's feedback. There are some splits (and some explicit
requests) resulting in new patches being added. The biggest change is the
effort in trying to minimize the usage of specific child device bits in
the top level device (mainly stuff related to the keymap). I think now
it's fairly self contained and the only thing that we really need to
handle in the top device are the unlock and reset events as those can be
supported through both the input and gpio devices (via gpio_keys). This
results in a bit of more runtime complexity but well, that's life...

Another change is Lee's suggestion of making use of templates (for
regmap and chip specific data) and fill things up at probe.

I also refactored a bit the event handling so it's more generic now.
There were lot's of changes so odds are that I might have forgotten some
feedback and so, my apologies in advance :).

I also dropped the tags in:

patch 16/22 ("gpio: adp5585: support gpi events") as it has some
significant changes (replacing .init_valid_masks() with .request() and
.free())

Thanks!
- Nuno Sá

---
Changes in v3:
- Patch 2:
 * New patch (only add devices given in DT).
- Patch 5:
 * Don't include adp5585-keys (still not present at this point).
- Patch 6:
 * Alphabetical order for compatibles.
- Patch 7:
 * New patch. Refactor regmap_config and fill variant differences at probe.
- Patch 8:
 * Rework according to changes introduced in patch 7;
 * Drop the regs struct in this patch. 
- Patch 9:
 * New patch. Add a per chip register structure. 
- Patch 10:
 * Moved the per variant gpio register into the gpio driver;
 * Moved ADP558[59]_GPIO_{BANK_BIT} into the gpio driver;
 * Moved ADP5589_GPIO_MAX and dropped the max_{col|row}.
- Patch 11:
 * Moved the per variant pwm register into the pwm driver (hence adding a chip_info struct.
- Patch 12:
 * Renamed the -keys suffix in the unlock/reset to events as that's the code we give in dt.
- Patch 13:
 * New patch (add event handling in a more generic way).
- Patch 14:
 * Support reset and unlock events in a separate patch;
 * Reworked how these events are validated.
- Patch 15:
 * Add support for input devices in it's own patch;
 * Add a bitmap for marking pins busy so there's no overlaps between
   the input and gpio devices. 
- Patch 16:
 * Drop .init_valid_mask() and use .free() and .request() for checking
   pin availability;
 * Drop max_gpios variables as that info is now available from the top
   device;
 * Adapt events handling to the new code.
- Patch 17:
 * Moved DT pin parsing into the input driver;
 * Validate reset/unlock events that are generated by the keymap;
 * Use error instead of ret;
 * Drop call to input_set_drvdata();
 * Adapt events handling to the new code.
- Patch 20:
 * Add a comment on the reset sleep time.

- Link to v2: https://lore.kernel.org/r/20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com
- Link to v1: https://lore.kernel.org/r/20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com

---
Nuno Sá (22):
      dt-bindings: mfd: adp5585: ease on the required properties
      mfd: adp5585: only add devices given in FW
      mfd: adp5585: enable oscilator during probe
      pwm: adp5585: don't control OSC_EN in the pwm driver
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
      pwm: adp5585: make sure to include mod_devicetable.h

 .../devicetree/bindings/mfd/adi,adp5585.yaml       |  240 ++++-
 .../devicetree/bindings/trivial-devices.yaml       |    2 -
 MAINTAINERS                                        |    1 +
 drivers/gpio/Kconfig                               |    1 +
 drivers/gpio/gpio-adp5585.c                        |  348 ++++++-
 drivers/input/keyboard/Kconfig                     |   21 +-
 drivers/input/keyboard/Makefile                    |    2 +-
 drivers/input/keyboard/adp5585-keys.c              |  356 +++++++
 drivers/input/keyboard/adp5589-keys.c              | 1066 --------------------
 drivers/mfd/adp5585.c                              |  794 ++++++++++++++-
 drivers/pwm/pwm-adp5585.c                          |   79 +-
 include/linux/mfd/adp5585.h                        |  148 ++-
 12 files changed, 1852 insertions(+), 1206 deletions(-)
---
base-commit: 407f60a151df3c44397e5afc0111eb9b026c38d3
change-id: 20250311-dev-adp5589-fw-e04cfd945286
--

Thanks!
- Nuno Sá



