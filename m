Return-Path: <linux-pwm+bounces-2191-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E21C38CA2FB
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 21:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CFE281AA9
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 19:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DC81386CC;
	Mon, 20 May 2024 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MgBA7YSN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3D754735;
	Mon, 20 May 2024 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235194; cv=none; b=ePTQs1NK4qcJbMAhMYcKp9d7Y6natXGBPxdmsITuhT8KfhxFo2EwcNp1UvI4zOL39kTm/yeD8+b50bQE74T/QUrlII+jf6WSzEqSSENCXiCIMmTWVfRVXm+i6utQ2QWI8B/5X1cpIoVSNB1UVXupw/m/AGWXtcswehbBalRTo9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235194; c=relaxed/simple;
	bh=qrk44uOhfAMSRJpAW63tdWL3WDheju7jjKOR4llVcmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Urzkas0lw6tDx1OsBVu6GgFwgvQ7DZV2e2gm07UPewn1jR7yM6S74F7Wq+JdaR26kanzda7HSbfYF7C8+3Nq66YLgmzY3ry7fJ2me+GkZyRfTktUqX6KRL3w7f5iJJENNOy0C1Sjfm6Pm8s6r/l8gYtrxpVwq+/Ee377Clv0mlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=MgBA7YSN; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3644CD49;
	Mon, 20 May 2024 21:59:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716235179;
	bh=qrk44uOhfAMSRJpAW63tdWL3WDheju7jjKOR4llVcmU=;
	h=From:To:Cc:Subject:Date:From;
	b=MgBA7YSNXu+cKhX28C4TMm1kkq3uziRTsBMK2szRuy4Lif4ii8HVgOocifsvU8MU6
	 lzLOIKvpD6PjGjVKgNJUAXP0z0Ob7Tlxb1Jf9hIf5ytdLDauv/Rul89XA1xw3bR73E
	 pvGOO3uUM5op43psOlHiakyw0DjolaSgx6XbE4uU=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH 0/5] ADP5585 GPIO expander, PWM and keypad controller support
Date: Mon, 20 May 2024 22:59:36 +0300
Message-ID: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.44.1
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
device, and includes DT bindings (2/5), an MFD driver (3/5) and drivers
for the GPIO (4/5) and PWM (5/5) functions.

Support for the keypad controller is left out, as I have no means to
test it at the moment. The chip also includes a tiny reset controller,
as well as a 3-bit input programmable logic block, which I haven't tried
to support (and also have no means to test).

The driver is based on an initial version from the NXP BSP kernel, then
extensively and nearly completely rewritten, with added DT bindings. I
have nonetheless retained original authorship. Clark, Haibo, if you
would prefer not being credited and/or listed as authors, please let me
know.

Clark Wang (1):
  pwm: adp5585: Add Analog Devices ADP5585 support

Haibo Chen (2):
  mfd: adp5585: Add Analog Devices ADP5585 core support
  gpio: adp5585: Add Analog Devices ADP5585 support

Laurent Pinchart (2):
  dt-bindings: trivial-devices: Drop adi,adp5585 and adi,adp5585-02
  dt-bindings: Add bindings for the Analog Devices ADP5585

 .../bindings/gpio/adi,adp5585-gpio.yaml       |  36 +++
 .../devicetree/bindings/mfd/adi,adp5585.yaml  | 117 +++++++++
 .../bindings/pwm/adi,adp5585-pwm.yaml         |  35 +++
 .../devicetree/bindings/trivial-devices.yaml  |   4 -
 MAINTAINERS                                   |  11 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-adp5585.c                   | 232 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  11 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/adp5585.c                         | 207 ++++++++++++++++
 drivers/pwm/Kconfig                           |   7 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-adp5585.c                     | 230 +++++++++++++++++
 include/linux/mfd/adp5585.h                   | 120 +++++++++
 15 files changed, 1016 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/adi,adp5585-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
 create mode 100644 Documentation/devicetree/bindings/pwm/adi,adp5585-pwm.yaml
 create mode 100644 drivers/gpio/gpio-adp5585.c
 create mode 100644 drivers/mfd/adp5585.c
 create mode 100644 drivers/pwm/pwm-adp5585.c
 create mode 100644 include/linux/mfd/adp5585.h


base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
-- 
Regards,

Laurent Pinchart


