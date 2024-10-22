Return-Path: <linux-pwm+bounces-3760-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13DC9AB9F1
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 01:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4271C20A34
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 23:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5321CEAAC;
	Tue, 22 Oct 2024 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9zWB6tT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BDA130AF6;
	Tue, 22 Oct 2024 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729639277; cv=none; b=D+77CE3QeDTVoNLBYR0Bqs0KYq45pFsrcdcUavr+RmtMVl3D3PKo5bye05PGhUmtwoA1fCP6j6MREGwU6/rn+lvFLTbwPFjwqUvJIsb0/aU6MDslE4JFU6WC9QMRLEf6qlUBUKwv7JT5zlcrtCCafyTxDknFJwNXxkChgwQMJtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729639277; c=relaxed/simple;
	bh=X1e8vDLLwVMBwesOw7xOWYQnP0hPlECb7qpb+1bGdGk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gpbds4D5SwtJ5/QVsp8NXpstuOF/EetPKE+ew+lw8m6UlHWgZYFSwCYn2HEUl6NDwvB1NehbbOs6bQxZAXAtbGWVXxUWYPA/tj/S1fNk/NQtGt9tg/AxxAy9WfcFVAuXu2gFPeuxf+ssBl8ypo4MQq081PDM23ksZXd9AzNgGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9zWB6tT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137B0C4CEC3;
	Tue, 22 Oct 2024 23:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729639277;
	bh=X1e8vDLLwVMBwesOw7xOWYQnP0hPlECb7qpb+1bGdGk=;
	h=From:Subject:Date:To:Cc:From;
	b=M9zWB6tTp8/ghWcm6b12A/+7JTwIMjPHrZajO3ivmRGZ3kBt/w/hfVtSrkmbhip7L
	 7GFsxVi0/qUTCco6QXvVwsBVXJ9eiUWAMbGrp8IKSHGEClS93d56KpVh/Ack+cjmUn
	 1cyTSf2Exss7XY7SY/bXTLFBBJwQ8TUG9r7petsud3ohCpAUVBH0U2FHcVjcp8Km7F
	 8K8V4xazSwJYnz5JD7wu831YC6D8m25tf/GG+uDa7RNvekCiO3wxwlQniao/za/akj
	 K/DzEhLUlzgwqIuAV/wB0+iSyQm+HYiIzt49U+ft6Mf9eKjuVieS0PSSOHCkMkA8yf
	 euQZPrMKNeCyw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v9 0/6] Add mfd, pinctrl and pwm support to EN7581 SoC
Date: Wed, 23 Oct 2024 01:20:00 +0200
Message-Id: <20241023-en7581-pinctrl-v9-0-afb0cbcab0ec@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACAzGGcC/2XSS27jMAwG4KsEXleBSFGvrOYeRReWRCVGUzuju
 EbbIHevkhZTT7WkgI/8SejSnbkMfO52m0tXeBnOwzTWwj9sunjoxz2LIdW6Q4kkHTjBo9UOxGk
 Y41yOAkIGlKApsOwqOhXOw9u94eNTrXOZXsR8KNzf28iklWXngiFHNkRi8labgOQDck4xk/PB4
 xYsKuWRiLb7Yd4ep8Ljx/TnmcvIx+1U9t/DCv99raHnr4k/mXebe2IrtchTEUYAiHDKolfkOUf
 pUna7BbtbxsNwnqfyfr9Bfbr1+VoX8fe6CwopQg9ae7Cqt3md6NZrUSuvoPGqeu+YQw6UemMaT
 z/eQ+upeiP76FWyRobQeP3Pg5St19WnCJE1YTCxnW9WHlTjTfUoyTEm6X3Extu1N4231VPOBiC
 jqQdsvFv75rst7nZ/Y03wxvSQ4D9/vV4/AardYHLRAgAA
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
Changes in v9:
- pwm: remove unused properties
- Link to v8: https://lore.kernel.org/r/20241018-en7581-pinctrl-v8-0-b676b966a1d1@kernel.org

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
 .../devicetree/bindings/pwm/airoha,en7581-pwm.yaml |   34 +
 MAINTAINERS                                        |    7 +
 drivers/pinctrl/mediatek/Kconfig                   |   17 +-
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/pinctrl-airoha.c          | 2970 ++++++++++++++++++++
 drivers/pwm/Kconfig                                |   11 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-airoha.c                           |  386 +++
 11 files changed, 3958 insertions(+), 1 deletion(-)
---
base-commit: 712a7891b8b68467edb10dc4dbc3eb11805d5795
change-id: 20240818-en7581-pinctrl-1bf120154be0
prerequisite-change-id: 20240705-for-6-11-bpf-a349efc08df8:v2

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


