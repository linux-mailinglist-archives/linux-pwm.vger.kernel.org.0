Return-Path: <linux-pwm+bounces-3065-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB3696722B
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Aug 2024 16:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F6DAB21A00
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Aug 2024 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69261BC39;
	Sat, 31 Aug 2024 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcItafka"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8894117999;
	Sat, 31 Aug 2024 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725114515; cv=none; b=U0+kyjMNYxf4WVaeeuNal+9w+dnARR3qdrP6KJ2tLVGLFmuoG9UvNmuTfpwEWg33s6Xg0pwriqXTSaC1aQPSjACyV0j+aYIQD24q+V6HTbKT3+Jom9jlZ9Mv8k4AHEjajD/hyV8MxPr5pT3y7yqQHf/SRk7r4RR9cHIlBWTio8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725114515; c=relaxed/simple;
	bh=NxucNnCnJizcmF2lSWVyU0LQyReQyHJFnoqf4gfasbo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IUbvP8vIlG2RpI7RrmMwKZljmvhJCqrGK7GVF979+aSPlelHJgg3gL6y6U3QCEb/+LbU3oH+yCUlOAOziMQ1A6Iq4eo/YZz3Gs8Mb1CjuzO1OTeuNWwIlf4/aIECGyu09UyfqoQ37MYR1ckp/irulKzQ12EBL/ouXechTc1u7Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcItafka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E2EC4CEC0;
	Sat, 31 Aug 2024 14:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725114515;
	bh=NxucNnCnJizcmF2lSWVyU0LQyReQyHJFnoqf4gfasbo=;
	h=From:Subject:Date:To:Cc:From;
	b=YcItafkawK8PxwdOVLQMnIrzH1PflF1oCp9JdxpZDo2FfB3IRP49XUmtVnCEOlgb1
	 AOarRiLWWihmj60eV5JywhMpA+i1cuoe9p82mFRLTSjo/cfDnDyDZdOAOlj3oPypb0
	 BgT569s3ojB9+Min4cuIOUTFJHJOJhWaMk2IeZsTU/OjiYroHnh9rqDWzZz7hiaTBT
	 KIkcnO7KZ8BJPg38xqrIFQfMpth/weBxKx66cDVURpV/sJZTI/rSpo7d/Zx9/S6YeJ
	 n1gneOpwA/paBII0f6Vv0F2wAtHl5zaN3hOR+5A9et1hVKUTREH5vjvFcBBNGYkuJE
	 zieyaQ+2pho7w==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v3 0/5] Add mfd, pinctrl and pwm support to EN7581 SoC
Date: Sat, 31 Aug 2024 16:27:45 +0200
Message-Id: <20240831-en7581-pinctrl-v3-0-98eebfb4da66@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGEo02YC/12Q3U6EMBSEX4X02kP6S1uufA+zFxROoRFbtiBRN
 7y7XdZE4+Wc5Mx8MzeyYg64kra6kYx7WEOKRYinivRTF0eEMBRNOOWSGmYAo1aGwRJiv+UZmPO
 MU6akQ0rK05LRh4/T8OVStM/pDbYpY3fa0EEJjca4RhqpXS9RWq0ax6V1HP3Qe2mss7xmmgthu
 ZSyHsNWzylj/ErPr5gjznXK409Yxut7gd4eib/MbXUSa6rApwwNMAZu8dAJadH31AzetDsnd8Y
 prFvKn+cG5XT3edTl/H/dnQMF1zGlLNOi0/4v0eU4jm9bMUPhUQEAAA==
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
 drivers/pinctrl/mediatek/Kconfig                   |   16 +-
 drivers/pinctrl/mediatek/Makefile                  |    1 +
 drivers/pinctrl/mediatek/pinctrl-airoha.c          | 2964 ++++++++++++++++++++
 drivers/pwm/Kconfig                                |   10 +
 drivers/pwm/Makefile                               |    1 +
 drivers/pwm/pwm-airoha.c                           |  435 +++
 include/linux/mfd/airoha-en7581-mfd.h              |    9 +
 13 files changed, 3999 insertions(+), 1 deletion(-)
---
base-commit: defaf1a2113a22b00dfa1abc0fd2014820eaf065
change-id: 20240818-en7581-pinctrl-1bf120154be0
prerequisite-change-id: 20240705-for-6-11-bpf-a349efc08df8:v2

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


