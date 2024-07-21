Return-Path: <linux-pwm+bounces-2874-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12B693855C
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jul 2024 18:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A8AB1C2040D
	for <lists+linux-pwm@lfdr.de>; Sun, 21 Jul 2024 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6447166307;
	Sun, 21 Jul 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Gkj0N1uF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04207944E;
	Sun, 21 Jul 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721577670; cv=none; b=inq3gFCY3t69Esj4lSD5rr87Y8C9cGfse9XMdR1uBf55N4CvsAHR/UJYNRW8hQwqb348dKHT/t9nB98vtZy94vPUBsJz9OfZ4KowfhBO07MSDb7vNF20mHzdBK97Q4AuhsUhwc+WtmrzWChK0fJrSYErSu3UXY0ZvKchNI7op4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721577670; c=relaxed/simple;
	bh=6eEQLC3KG/Iqi6ccclzRmh80TU39h6mBxFo7jJwyX2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBEFd1Jenwe1JcT2oqtvcZ8BdvVugQ5jXm42z0hE/2qOggstINhopsCPHtc8IM5snqVoGWxStoGH04YiVU0J0xTL2++UxjCNjLqfC6RYrt8A3VMBNhmsvoVZWAPb1ag8YbBA3GOaCDlAEwRl0K1na11b8jCwPzSgxuSOVKvhPpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Gkj0N1uF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4687D21E;
	Sun, 21 Jul 2024 18:00:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1721577626;
	bh=6eEQLC3KG/Iqi6ccclzRmh80TU39h6mBxFo7jJwyX2A=;
	h=From:To:Cc:Subject:Date:From;
	b=Gkj0N1uFefNWMciNf+iOC2wGwDR9N2VLU9XzNJNYIj0rfjnFiePImCHUEr4Vy3bRh
	 UyNqPc7FZg4aBZNdBEA7YlIeHMgLZu9mw1gF4f82z2kbsMZ2X51DqqMNUKGb2Rx+QV
	 A5gcct8ZwfGEGdqXqDgnX0nGFG2/OwV1WzLDwX1E=
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Haibo Chen <haibo.chen@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>
Subject: [PATCH v6 0/4] ADP5585 GPIO expander, PWM and keypad controller support
Date: Sun, 21 Jul 2024 19:00:45 +0300
Message-ID: <20240721160049.20470-1-laurent.pinchart@ideasonboard.com>
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

Compared to v5, this version addresses small review comments. I believe
it is ready to go, pending one last review of the PWM side by Uwe. Once
done, I think the simplest course of action is to merge the whole series
through the MFD tree.

Clark Wang (1):
  pwm: adp5585: Add Analog Devices ADP5585 support

Haibo Chen (2):
  mfd: adp5585: Add Analog Devices ADP5585 core support
  gpio: adp5585: Add Analog Devices ADP5585 support

Laurent Pinchart (1):
  dt-bindings: mfd: Add Analog Devices ADP5585

 .../devicetree/bindings/mfd/adi,adp5585.yaml  |  92 +++++++
 .../devicetree/bindings/trivial-devices.yaml  |   4 -
 MAINTAINERS                                   |  11 +
 drivers/gpio/Kconfig                          |   7 +
 drivers/gpio/Makefile                         |   1 +
 drivers/gpio/gpio-adp5585.c                   | 229 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  12 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/adp5585.c                         | 200 +++++++++++++++
 drivers/pwm/Kconfig                           |   7 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-adp5585.c                     | 183 ++++++++++++++
 include/linux/mfd/adp5585.h                   | 126 ++++++++++
 13 files changed, 870 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
 create mode 100644 drivers/gpio/gpio-adp5585.c
 create mode 100644 drivers/mfd/adp5585.c
 create mode 100644 drivers/pwm/pwm-adp5585.c
 create mode 100644 include/linux/mfd/adp5585.h


base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
-- 
Regards,

Laurent Pinchart


