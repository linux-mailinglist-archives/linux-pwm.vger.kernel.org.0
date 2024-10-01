Return-Path: <linux-pwm+bounces-3416-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C292298C466
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 19:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55B6A1F23E06
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 17:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB9A1CC143;
	Tue,  1 Oct 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i30gMClf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB65321D;
	Tue,  1 Oct 2024 17:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803807; cv=none; b=UxrUyxE0FR1cPG04Q0jw8/6+xSGrpEOedabR81Jp0Syt5vsgHrQtaD4pOwh74LIIzQozfdivHiUF3YCnpzJdXJ3GRSxW53kX93g8nEAu42tdHUXDI3oOWTN1SX7qRFXpjmHeLlXMf+JxN8juRixqNz6Ni2v5l+HkuyHUA634M5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803807; c=relaxed/simple;
	bh=k41iufEvAgZKKjtKzshB6ZOXsBvWR7K1rRznnG1aVTI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QMJ5MIVeFX6MRMhlIFMiGeiXMgmIfTZQMNk8ZTnbQSTGpGx0j2nH7rLo94/GKvuZrVY4nLoZTxr+pdCixIn53aUt2AATPEw5IRoSn/TW4jhJchvj1RKHmT7MObdvCJgVnYK2y9pRuM/cwGVq4i5rWsjaJT9G/O8Df41roY7wReA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i30gMClf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71044C4CEC6;
	Tue,  1 Oct 2024 17:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727803807;
	bh=k41iufEvAgZKKjtKzshB6ZOXsBvWR7K1rRznnG1aVTI=;
	h=From:Subject:Date:To:Cc:From;
	b=i30gMClf8GT+f0jPFRdVB5GECcVbPD79WWw+qYhevh0w0zaY2EboAtLJzK2Bez4YS
	 XsW7aUYJF1Fs+zJ+dUTdl++yWs85kBBHk00ZqhcBzEtqIB3OkT0HDoj5R1m7rOqXoW
	 6bPtt31LFB1c+/1u0BITYX61XaEONSMzpG+Q4NZ3vQcJ03yThjVyn/vDaap+3fnfX0
	 y4GhINwFqQ7bUz3KNWjvaT2SbUbW9JlC/yFXzjgb4JhTMm6yaar1CgxisaL4+gZdZa
	 pN2WgQ2Vz92yfVYO6dIYItko7xGOj3OpVMWsyGuOW3A5vaLh+58ZXBEAIyevuEAUV2
	 pnCxxZoDxlbnA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v5 0/5] Add mfd, pinctrl and pwm support to EN7581 SoC
Date: Tue, 01 Oct 2024 19:29:29 +0200
Message-Id: <20241001-en7581-pinctrl-v5-0-dc1ce542b6c6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHkx/GYC/2WQy07DMBBFf6XyGkd+jF9d8R+IhScZtxYlLk6Ig
 Kr/jpsiFejyjnTunJkTm6hmmth2c2KVljzlMrZgHjas38dxRzwPLTMlFAgvPafRGS/5MY/9XA9
 cYpJKSANIgjXoWCnlj7Xw6bnlVMsrn/eV4lojBqMdeY8WPDjsgSA4Y1FBQEVp6BP4gEF10imtg
 wKAbpfn7lAqjV/l8YXqSIeu1N3Pskpv7016vm68OW83q7EThqdSueVScjwmHjUESr3wQ/LbRbG
 L4z5Pc6mf6w/a6NJzPVep/+cuiguOURoTpNPRpd9Gl65F/+K1vON144MnwoQwRGvveLjxQd7z0
 HgrYh/04KxA/MOfz+dvo5lC69EBAAA=
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
X-Mailer: b4 0.14.1

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

Christian Marangi (2):
      dt-bindings: mfd: Add support for Airoha EN7581 GPIO System Controller
      mfd: airoha: Add support for Airoha EN7581 MFD

Lorenzo Bianconi (2):
      dt-bindings: arm: airoha: Add the chip-scu node for EN7581 SoC
      pinctrl: airoha: Add support for EN7581 SoC

 .../bindings/arm/airoha,en7581-chip-scu.yaml       |   42 +
 .../bindings/mfd/airoha,en7581-gpio-sysctl.yaml    |  433 +++
 MAINTAINERS                                        |    7 +
 drivers/mfd/Kconfig                                |    8 +
 drivers/mfd/Makefile                               |    2 +
 drivers/mfd/airoha-en7581-gpio-mfd.c               |   72 +
 drivers/pinctrl/mediatek/Kconfig                   |   17 +-
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/pinctrl-airoha.c          | 3007 ++++++++++++++++++++
 drivers/pwm/Kconfig                                |   10 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-airoha.c                           |  414 +++
 include/linux/mfd/airoha-en7581-mfd.h              |    9 +
 13 files changed, 4022 insertions(+), 1 deletion(-)
---
base-commit: 437d220f284a16e52c7d7f819e4a1a7e25fe8fe9
change-id: 20240818-en7581-pinctrl-1bf120154be0
prerequisite-change-id: 20240705-for-6-11-bpf-a349efc08df8:v2

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


