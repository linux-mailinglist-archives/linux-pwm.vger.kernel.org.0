Return-Path: <linux-pwm+bounces-4724-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82477A1AAE9
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 21:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7156C188DF29
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 20:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDC81ADC98;
	Thu, 23 Jan 2025 20:11:31 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F7132122;
	Thu, 23 Jan 2025 20:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663091; cv=none; b=aaBvyB/jFj5pSIbP0i7RBu6Nl2q65x32CF6kxf68cohZxDJPrKiPb+OB5kNtDyiEBtKR7oPctYeevubPyOAiwISY/cRyNa8z5eO+tIXwG0hwoFPu1rCgmDsOndjrVZPRdxg5xjz7pondKHKpgLO7dlyGkzPOxZzWQckjCDzIx/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663091; c=relaxed/simple;
	bh=Pt7LgIRgmPgDGySdcSX8FNi4rFGFkqkFh233INI8b1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XMvaJDlNEIhxgZjPGVCMb9J4cnlWF/gGAl7e2Hck6u3jopL0473Spl1bkWL3aMPyXw4t+fTY2FexrXH/8LD2B011IDVKDsXziMRsszod/CFkkLH13N0DXciK2/hsdMTLbFSsMcxfK1sFnEg/gxyT/hCI5YwYdqZpl4d7W/OO6vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 50NJa25A004973;
	Fri, 24 Jan 2025 03:36:02 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 50NJZbtx004747
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 03:35:37 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Fri, 24 Jan 2025
 03:35:37 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Ben Zong-You Xie <ben717@andestech.com>
Subject: [v3 0/2] pwm: add PWM driver for atcpit100
Date: Fri, 24 Jan 2025 03:35:32 +0800
Message-ID: <20250123193534.874256-1-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 50NJa25A004973

Re-introduce the driver for atcpit100. This device driver was previously
part of the Linux Kernel, but was removed due to the deprecation of the
NDS32 architecture [1]. Although Andes now dedicates our effort on RISC-V,
ATCPIT100 is still one of our peripheral platform IPs, and that's why we
are re-introducing it now.

This patch series includes DT-bindings(1/2) and PWM driver(2/2).

The ATCPIT100 Programmable Interval Timer (PIT) is a set of compact
multi-function timers, which can be used as pulse width modulators (PWM)
as well as simple timers. ATCPIT100 supports up to 4 PIT channels,
and each PIT channel may be a simple timer or PWM, or a combination of
the timer and the PWM.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aec499c75cf8e0b599be4d559e6922b613085f8f
---
Changes in v3:
(1/2):
 - modify the compatible string according to Krzysztof's review.
(2/2):
 - add a check for the clock rate to prevent the overflow warning by
   kernel test robot.
 - remove the unnecessary check in .apply() reported by kernel test
   robot.

Link to v2: https://lore.kernel.org/linux-pwm/20241202060147.1271264-1-ben717@andestech.com/T/#t

Changes in v2:
(1/2):
 - change "title" in the yaml file.
 - remove vendor-specific property, and add clocks property.
(2/2):
 - add a description for hardware limitations.
 - instead of statically configuring the clock source in the dtb,
   switch the clock parent depending on the requested setting.
 - have some minor changes according to Uwe's suggestion.

Link to v1: https://lore.kernel.org/linux-pwm/20241028102721.1961289-1-ben717@andestech.com/T/#t
---
Ben Zong-You Xie (2):
  dt-bindings: pwm: add atcpit100
  pwm: atcpit100: add Andes PWM driver support

 .../bindings/pwm/andestech,atcpit100-pwm.yaml |  51 +++
 MAINTAINERS                                   |   6 +
 drivers/pwm/Kconfig                           |  17 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-atcpit100.c                   | 296 ++++++++++++++++++
 5 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
 create mode 100644 drivers/pwm/pwm-atcpit100.c

---
2.34.1


