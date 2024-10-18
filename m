Return-Path: <linux-pwm+bounces-3719-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F739A3F55
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 15:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9155F1F2136E
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC4942AAE;
	Fri, 18 Oct 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXLqJwXe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A667B1E49F;
	Fri, 18 Oct 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729257572; cv=none; b=odIOnoAm54CSLPnFKJxf5O+6tC3H1ulbFK7EuxtPUlB01bbkyUqelrrSIPLvMrzUSMglGi20HGnoXvFpi+ZryYLDuiniwYvf4t6Ny+IdYJzXBoblmPuw76M4x5qYOhOgvS3nquBFByoVkcELnVTxKym0adIGGPzA+9YBG1VqZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729257572; c=relaxed/simple;
	bh=dNESMw4yGXRuQCex6utRMbGLz39CnUHW11KM6eIz4dA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BtxuzW68V1SaJov0yJ1FQQzPszr3MhoyLm7n1KY0lAUz0Y88NV7hJAvTDraqIhROrSi9pQDK9KupqAogL+pPglGGpWhMwaOOms5tz/r2yHPltzdkxDC5ALJtD79rUBiTfUYo3E9MVO0Vx+rwzLwO1wb92D8WTU2XRSzdl3bEYBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXLqJwXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E214C4CEC3;
	Fri, 18 Oct 2024 13:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729257572;
	bh=dNESMw4yGXRuQCex6utRMbGLz39CnUHW11KM6eIz4dA=;
	h=From:Subject:Date:To:Cc:From;
	b=tXLqJwXetwyMcmYjpkE0Orho2ns7gz5n9BaOj5a///6clyC3sz5sNQpGIfdDZrTm8
	 4v1c6DTcdwOgnSGuHKAGnYLubM/u0cCoTQof6hcCZBrypQbM3bqdrPL/PJsymhezCs
	 +4cgOSw4ZHxi38FQQciS+HBvMsVXI0e6ynqqHL2YhFMVze6TrTPE87zQ87qMx8k46U
	 tYiPHhqHSZcY3bkk3+zrEG1nvLl+ULeNBPCx+AHq9IxPJyJ01y1hzczigMDsPir/1M
	 y5lLTxRPf6xuwZ8XSgea5/mfVJPZUKIOcE1INv/ufMZfm3LXZuUGvFcdibwrDq8tiK
	 S19Urfdwn/xJQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v8 0/6] Add mfd, pinctrl and pwm support to EN7581 SoC
Date: Fri, 18 Oct 2024 15:19:01 +0200
Message-Id: <20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEVgEmcC/2XQTU7DMBAF4KtUWePIMx7/dcU9EIvYGbcRJSluq
 ICqd8dtEQ14OZa+N89zag6cBz4069WpyXwcDsM0lsE9rJq47cYNi6Evc4MSSTpwgkerHYj9MMY
 57wSEBChBU2DZFLTPnIaPa+DTc5lTnl7FvM3cXWNkr5Vl54IhRzZEYvJWm4DkA3LqYyLng8cWL
 CrlkYjazTC3uynz+DU9vnAeeddOefOzLPPbeyk93zbeO69X18ZWapGmLIwAEGGfRKfIc4rS9cm
 tj9hcOm6Hwzzlz+sNytMl5/ZdxP/fPaKQInSgtQerOpuWjS5ZR7XwCiqviveOOaRAfWdM5enuP
 dSeijeyi1711sgQKq9/PUhZe118HyGyJgwm1vvNwoOqvCkeJTnGXnofsfJ26U3lbfGUkgFIaMo
 B//jz+fwNz+6Hg5ECAAA=
X-Change-ID: 20240818-en7581-pinctrl-1bf120154be0
To: Lorenzo Bianconi <lorenzo@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 upstream@airoha.com, benjamin.larsson@genexis.eu, ansuelsmth@gmail.com, 
 linux-pwm@vger.kernel.org
X-Mailer: b4 0.14.2

Introduce airoha-mfd driver in order to load pinctrl and pwm drivers for
EN7581 SoC. airoha-mfd is needed since both pinctrl and pwm drivers
needs to access the same memory block (gpio memory region) to configure
{gio,irq}_chip and pwm functionalities respectively, so model them as
childs of a parent mfd driver.
Current EN7581 pinctrl driver supports the following functionalities:
- pin multiplexing via chip_scu syscon
- pin pull-up, pull-down, open-drain, current strength,
  {input,output}_enable, output_{low,high} via chip_scu syscon
- gpio controller
- irq controller

---
Changes in v8:
- pwm: add missing properties documentation
- Link to v7: https://lore.kernel.org/r/20241016-en7581-pinctrl-v7-0-4ff611f263a7@kernel.org

Changes in v7:
- pinctrl: cosmetics
- pinctrl: fix compilation warning
- Link to v6: https://lore.kernel.org/r/20241013-en7581-pinctrl-v6-0-2048e2d099c2@kernel.org

Changes in v6:
- pwm: rely on regmap APIs
- pwm: introduce compatible string
- pinctrl: introduce compatible string
- remove airoha-mfd driver
- add airoha,en7581-pinctrl binding
- add airoha,en7581-pwm binding
- update airoha,en7581-gpio-sysctl binding
- Link to v5: https://lore.kernel.org/r/20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org

Changes in v5:
- use spin_lock in airoha_pinctrl_rmw instead of a mutex since it can run
  in interrupt context
- remove unused includes in pinctrl driver
- since the irq_chip is immutable, allocate the gpio_irq_chip struct
  statically in pinctrl driver
- rely on regmap APIs in pinctrl driver but keep the spin_lock local to the
  driver
- rely on guard/guard_scope APIs in pinctrl driver
- improve naming convention pinctrl driver
- introduce airoha_pinconf_set_pin_value utility routine
- Link to v4: https://lore.kernel.org/r/20240911-en7581-pinctrl-v4-0-60ac93d760bb@kernel.org

Changes in v4:
- add 'Limitation' description in pwm driver
- fix comments in pwm driver
- rely on mfd->base __iomem pointer in pwm driver, modify register
  offsets according to it and get rid of sgpio_cfg, flash_cfg and
  cycle_cfg pointers
- simplify register utility routines in pwm driver
- use 'generator' instead of 'waveform' suffix for pwm routines
- fix possible overflow calculating duty cycle in pwm driver
- do not modify pwm state in free callback in pwm driver
- cap the maximum period in pwm driver
- do not allow inverse polarity in pwm driver
- do not set of_xlate callback in the pwm driver and allow the stack to
  do it
- fix MAINTAINERS file for airoha pinctrl driver
- fix undefined reference to __ffsdi2 in pinctrl driver
- simplify airoha,en7581-gpio-sysctl.yam binding
- Link to v3: https://lore.kernel.org/r/20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org

Changes in v3:
- introduce airoha-mfd driver
- add pwm driver to the same series
- model pinctrl and pwm drivers as childs of a parent mfd driver.
- access chip-scu memory region in pinctrl driver via syscon
- introduce a single airoha,en7581-gpio-sysctl.yaml binding and get rid
  of dedicated bindings for pinctrl and pwm
- add airoha,en7581-chip-scu.yaml binding do the series
- Link to v2: https://lore.kernel.org/r/20240822-en7581-pinctrl-v2-0-ba1559173a7f@kernel.org

Changes in v2:
- Fix compilation errors
- Collapse some register mappings for gpio and irq controllers
- update dt-bindings according to new register mapping
- fix some dt-bindings errors
- Link to v1: https://lore.kernel.org/all/cover.1723392444.git.lorenzo@kernel.org/

---
Benjamin Larsson (1):
      pwm: airoha: Add support for EN7581 SoC

Christian Marangi (1):
      dt-bindings: mfd: Add support for Airoha EN7581 GPIO System Controller

Lorenzo Bianconi (4):
      dt-bindings: arm: airoha: Add the chip-scu node for EN7581 SoC
      dt-bindings: pinctrl: airoha: Add EN7581 pinctrl
      dt-bindings: pwm: airoha: Add EN7581 pwm
      pinctrl: airoha: Add support for EN7581 SoC

 .../bindings/arm/airoha,en7581-chip-scu.yaml       |   42 +
 .../bindings/mfd/airoha,en7581-gpio-sysctl.yaml    |   90 +
 .../bindings/pinctrl/airoha,en7581-pinctrl.yaml    |  400 +++
 .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml |   61 +
 MAINTAINERS                                        |    7 +
 drivers/pinctrl/mediatek/Kconfig                   |   17 +-
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/pinctrl-airoha.c          | 2970 ++++++++++++++++++++
 drivers/pwm/Kconfig                                |   11 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-airoha.c                           |  421 +++
 11 files changed, 4020 insertions(+), 1 deletion(-)
---
base-commit: e4188772459fec428bf85ce6711a0147387c1455
change-id: 20240818-en7581-pinctrl-1bf120154be0
prerequisite-change-id: 20240705-for-6-11-bpf-a349efc08df8:v2

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


