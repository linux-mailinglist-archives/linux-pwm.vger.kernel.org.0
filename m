Return-Path: <linux-pwm+bounces-2316-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0582D8D769C
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Jun 2024 17:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359B71C210BE
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Jun 2024 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E0048CCD;
	Sun,  2 Jun 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WbeMhCih"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2570C43AAB;
	Sun,  2 Jun 2024 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717341871; cv=none; b=KINJIxqOP3H5RbW8iTH/O0CFUfQ03Pn5BZmZBfWWmY1/WO2Q0KcKV0kkRJGs0HtRGealG3aumzZM1GVSxHpF6sUcNPnmxEEong2OxOzyNMuyYkeOuzzBRpUWe2AKxmYjYLLoGg7zPg+3ZJb9mvkhAS144ddct4R56aTeUS6zGzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717341871; c=relaxed/simple;
	bh=B4v8dd6sGN66YL+OYBa6jbQNYmWGri5yn2X5L1dYr10=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s1tZ9pHVgoxd6+Cf9jwzwwCOKeoCxE1uYpfqrhScv7IvX3ppq4OYhPR5xyq16Kj5K1DOZ2jeVzwH0jY/VoIpkKcqj34Bu1osU6S+wD+jebW78Xqu1jviiDBP1HilD3DtXL0fLgytcPrKlbDnajqLQy7js11lvsMDNyHFB1A/P3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=WbeMhCih; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8BB3939F;
	Sun,  2 Jun 2024 17:24:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1717341860;
	bh=B4v8dd6sGN66YL+OYBa6jbQNYmWGri5yn2X5L1dYr10=;
	h=From:To:Cc:Subject:Date:From;
	b=WbeMhCihZdRyrbNF3Vmz4Z5eha1Am92aL8k9MJySW3u0RFqHdgVa8UEehUEGP1Mwl
	 zaBZfCS3p37qPQBCC+C5y6F+77lj0ECT3pPU+xIfPWgt00VGj0+gCAO246ZGQP7XM0
	 vHFr1q7CZBHjeM2M7V62BpnSLepPrDNDdCDLxXHA=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH v3 0/4] ADP5585 GPIO expander, PWM and keypad controller support
Date: Sun,  2 Jun 2024 18:24:08 +0300
Message-ID: <20240602152412.29136-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch series introduces support for the Analog Devices ADP5585, a
GPIO expander, PWM and keyboard controller. It models the chip as an MFD
device, and includes DT bindings (1/4), an MFD driver (2/4) and drivers
for the GPIO (3/4) and PWM (4/4) functions.

Support for the keypad controller is left out, as I have no means to
test it at the moment. The chip also includes a tiny reset controller,
as well as a 3-bit input programmable logic block, which I haven't tried
to support (and also have no means to test).

The driver is based on an initial version from the NXP BSP kernel, then
extensively and nearly completely rewritten, with added DT bindings. I
have nonetheless retained original authorship. Clark, Haibo, if you
would prefer not being credited and/or listed as authors, please let me
know.

Compared to v2, this version addresses lots of miscellaneous review
comments. It also fixes a DT binding validation issue that sneaked in
v2.

What's the preferred way to merge such an MFD driver ? Should all
patches go through the MFD tree (with the acks of the GPIO and PWM
maintainers) ?

Clark Wang (1):
  pwm: adp5585: Add Analog Devices ADP5585 support

Haibo Chen (2):
  mfd: adp5585: Add Analog Devices ADP5585 core support
  gpio: adp5585: Add Analog Devices ADP5585 support

Laurent Pinchart (1):
  dt-bindings: Add bindings for the Analog Devices ADP5585

 .../devicetree/bindings/mfd/adi,adp5585.yaml  |  90 +++++++
 .../devicetree/bindings/trivial-devices.yaml  |   4 -
 MAINTAINERS                                   |  11 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-adp5585.c                   | 231 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/adp5585.c                         | 199 +++++++++++++++
 drivers/pwm/Kconfig                           |   7 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-adp5585.c                     | 189 ++++++++++++++
 include/linux/mfd/adp5585.h                   | 126 ++++++++++
 13 files changed, 875 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
 create mode 100644 drivers/gpio/gpio-adp5585.c
 create mode 100644 drivers/mfd/adp5585.c
 create mode 100644 drivers/pwm/pwm-adp5585.c
 create mode 100644 include/linux/mfd/adp5585.h


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
Regards,

Laurent Pinchart


