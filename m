Return-Path: <linux-pwm+bounces-7651-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A1BC7ABBE
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 17:10:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EDE1D361001
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Nov 2025 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B094333508F;
	Fri, 21 Nov 2025 16:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er2/XSVo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734442BE047
	for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741329; cv=none; b=HAM6U0BeIVhJ6IptTDJdsnr6s1ELz0h250CzSr8x0IQLGGPw5VriNlOveLTxZSkI242fHA+MBrhKopVEjQXG0OOrPlf5d/ctLds9sx0ThUOe8Yh2XHMHGb765u6Py6mgiQxSbyGYzvfXghlJKUukrbpQRLHLK1OQsvD+0dpKshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741329; c=relaxed/simple;
	bh=4W2wUHFcuGyWiz8+6gUf7Bpjr+WJgOLxolMNrpBo+RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bp/kfE0hx3lZqBsxikXeHnTIW7m8tCNC+OHlOkBTeezRglt6033gOrcuWe5CW2eDgdoYBkzKY9bfgvyEOa7Jm6j+K/VMiDylu/Ar40EL2cOA/2CpQ5jtCVHJ4igdc9QP9DJHtGcUjWyW2ZXPKi0GVbry2YeOyZRNCKPVKDo90c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er2/XSVo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775ae77516so24280515e9.1
        for <linux-pwm@vger.kernel.org>; Fri, 21 Nov 2025 08:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763741326; x=1764346126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3/orAuSpaF5HTB6929AgvV0WKZABdlI/t47+2/JoX6w=;
        b=Er2/XSVofpmtahIPIUY5MkuTJWJVLlfx3Rfn/ivNrpeK0V1QRD6tajaq19xxyEGNCZ
         DSm3pPeKWVQ3gLSzgFGRjqspD39obplDYy3Fffh2/xdPq8Ap5tLlRsfY0OThQC7GWc7d
         Xs3NK0yVRwQ8vh0BHJBYJeR4bfFC+nXEClWWFl3gKp56GmMvVuhJrUiP0usH85U+UgK4
         WgsmhmpMIoYg0DAzR3/uVlGXjKAoTuHL6JTEHjOWZX5MFzxCca42iec16JKyLqJqT9zv
         tBIEjfDnY9eIsIev7ZWEu39UMXeJUyPYo/0wjWlPovgJaEGQXhdFuT4a0dHMN0E41K6D
         TrTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763741326; x=1764346126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3/orAuSpaF5HTB6929AgvV0WKZABdlI/t47+2/JoX6w=;
        b=dryLB+239erK60MJPLopiOAJ0oiiUq3SqsVw5Jx5t6osb5vI4admZVm5W7N2X1cNTc
         Tn+H2I5gEGtfyieZxiLsbG3h8Lg8RLAJVaDvPGQKhBU4xqubbJS4bO7xO5xp2vSxbkEl
         6sM4sJqqF9UNYQedo16Bb5XJyPKwORrh+L1cCu6Ca5pgrkFymbnJjol1TkrEwbQkM8yq
         tjL6Slsb3zVjM5spjfLMCiZAzdpL61KisBgpNcdiBvqsbIhaCA9/9oV4qU6Zjn5qw56v
         zCxuRZK4Iow9c2t/kVKLoLjrqJTL+oQ9ybVTIbcehYQ6vy6kn15Byrh49ENvzH9Jqlsf
         NxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV89j+zHCnLfb6p0PmkROaPHF78ED3gbokGCeZPM05TF4qy3qhA5r6JFiUgpxtUxJs+dW+1ig8MW/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwB1+/S4uAhRd4PZN0dxm72RujUjDKZgvfHs7PplPrcyPUNuLm
	pyjydPKE7EtUEIXU7WyMJC/gsPiCdmBl09BrvMjNsB28FFaBGGxiGOYS
X-Gm-Gg: ASbGnctTaam1xyEGo4t43G7sdHDFoO2fiJTqQthTGra1WwLwlZB8IWKfJwgl9ycBMLT
	5txnSF6ohsPGpcuRyLMtWczcWaGFvuGHAemT9ASrauS2wy/mdY8wNj1mYenAMwaBqh2KP72YZaG
	6WQNsYgM7AEfiQaacknf4aimzLq24zl6u6wu2MFuWbanR2EXNWKSfdNQ2dCCb0IhqmtlnoF52Ol
	6V99a5uYIwJPz4RO5JncFM9v5wCbHZX2BDhBvOgn33d1d/EVty6I95WdHB9XTsOXHWp8caZiWqD
	+Pgv4CRQTEXEAAZ+68Yzp1iUUmlOtTzyYhpGNFbsw6curztn8brJ0qCQwLrOFk4g+hS7z/7cYan
	VgJXTtm7hTfT+92wbFH9J7DtIl9DeSowAIXKwAIiUxyMjJB1toR9IJijc5tEL6lkxwWO5Nuux7+
	yFkijMut/QnlxWtlu0ZvYsci/J5rpNcHaRC4VA6Knm1gmd2PnVlxhrsskLWMUqtJ6b3f9vG3o=
X-Google-Smtp-Source: AGHT+IGNr2oFBi9yiP1muvPT0qy/GV8msIHybnUSVrCwDl0Wxbmd1Ylty9nunW/cmYCZvINh1/LbOg==
X-Received: by 2002:a05:600c:c490:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-477c11325c2mr28662945e9.31.1763741325613;
        Fri, 21 Nov 2025 08:08:45 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9dea7fcsm89496195e9.8.2025.11.21.08.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:08:45 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v8 00/15] Add RZ/G2L POEG support
Date: Fri, 21 Nov 2025 16:08:07 +0000
Message-ID: <20251121160842.371922-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The output pins of the general PWM timer (GPT) can be disabled by using
the port output enabling function for the GPT (POEG). Specifically, either
of the following ways can be used.

  * Input level detection of the GTETRGA to GTETRGD pins.
  * Output-disable request from the GPT.
  * Register setting(ie, by setting POEGGn.SSF to 1)

This patch series adds basic support for user control and output-disable
requests from the GTETRGn pins by using poeg char device.

Merged the pwm[2] and poeg[6] patch series together to get an overall view
of the system and also both are linked devices.

Patch #8 to patch #15 are just for testing Output-disable request from
the GPT

When dead time error occurs or the GTIOCA pin output value is the same as
the GTIOCB pin output value, output protection is required. GPT detects
this condition and generates output disable requests to POEG based on the
settings in the output disable request permission bits, such as
GTINTAD.GRP{DTE,ABH,ABL}. After the POEG receives output disable requests
from each channel and calculates external input using an OR operation, the
POEG disables the output of the GTIOCxA and GTIOCxB pins.

A sample test app is developed to handle POEG events. The POEG handles
output disable request from GPT and send an event to userspace. The
userspace with the help of poeg clears the fault condition.

This patch#2 on this series depend upon[1]
[1] https://lore.kernel.org/all/20251121133654.364688-1-biju.das.jz@bp.renesas.com/

Ref:
PWM:
[2] https://lore.kernel.org/all/20250226144531.176819-5-biju.das.jz@bp.renesas.com/
[3] https://lore.kernel.org/all/20240220194318.672443-5-biju.das.jz@bp.renesas.com/
[4] https://lore.kernel.org/all/20230228150756.482432-1-biju.das.jz@bp.renesas.com/
[5] https://lore.kernel.org/all/20221215205843.4074504-1-biju.das.jz@bp.renesas.com/
POEG:
[6] https://lore.kernel.org/all/20230328101011.185594-1-biju.das.jz@bp.renesas.com/

Merge strategy:
 patch #1-#2  PWM subsystem
 patch #3-#4  Pinctrl subsytem
 patch #5-#7  SoC

v7->v8:
 * Merged the pwm[2] and poeg[6] patches together to get an overall view
   of the system and also both are linked devices.
 * Add ack from Rob for the binding patch#3.
 * Replaced return type of rzg2l_gpt_poeg_init() from void->int and
   probe() checks this return value.
 * Added more error checks in rzg2l_gpt_poeg_init().
 * Replaced config name from POEG_RZG2L->RENESAS_RZG2L_POEG.
 * Updated POEG Kconfig dependency with PWM
 * Dropped static variable minor_n and instead using the value of
   "renesas,poeg-id".
 * Replaced devm_reset_*_exclusive()->devm_reset_*_exclusive_deasserted()
 * Replaced pm_runtime_enable() with devm variant.
 * Added support for handling output-disable requests from the GTETRGn
   pins.
 * Replaced the macros RZG2L_POEG_USR_CTRL_{EN,DiS}ABLE_CMD to 
   RZG2L_POEG_OUTPUT_DISABLE_USR_{EN,DIS}ABLE_CMD.
 * Replaced '&pdev->dev' by 'dev' in probe().
 * Added DT and config patch
v6->v7:
 * Documented renesas,poeg-config optional property for configuring the
   system for pin output disable.
 * Used DT to handle the system configuration
 * Added poeg char device for user control support to enable/disable
   output from GPT
 * Replaced iowrite32/ioread32-> writel/readl
 * Dropped of_match_ptr from .of_match_table
v5->v6:
 * Dropped binding patch as it is accepted for 6.4.
 * Added sysfs support for configuring pin output disable 
   function in a generic way.
v4->v5:
 * Added Rb tag from Rob.
 * Updated kernel version in sysfs doc.
v3->v4:
 * Replaced companion->renesas,gpt for the phandle to gpt instance
 * Replaced renesas,id->renesas,poeg-id
 * Removed default from renesas,poeg-id as default for a required
   property doesn't make much sense.
 * Updated the example and required properties with above changes
v2->v3:
 * Removed Rb tag from Rob as there are some changes introduced.
 * Added companion property, so that poeg can link with gpt device
 * Documented renesas,id, as identifier for POEGG{A,B,C,D}.
 * Updated the binding example.
 * Added sysfs documentation for output_disable
 * PWM_RZG2L_GPT implies ARCH_RZG2L. So removed ARCH_RZG2L dependency
 * Used dev_get_drvdata to get device data
 * Replaced sprintf->sysfs_emit in show().
v1->v2:
 * Updated binding description.
 * Renamed the file poeg-rzg2l->rzg2l-poeg
 * Removed the macro POEGG as there is only single register and
   updated rzg2l_poeg_write() and rzg2l_poeg_read()
 * Updated error handling in probe()
REF->v1:
 * Modelled as pincontrol as most of its configuration is intended to be
   static and moved driver files from soc to pincontrol directory.
 * Updated reg size in dt binding example.
 * Updated Kconfig

logs:
With renesas,poeg-config = <1>;
root@smarc-rzv2l:~# /poeg.sh
Test case 1 user POEG control
Read at address  0x10048434 (0xffffbdcc4434): 0x031B031B
Read at address  0x10048438 (0xffff9341f438): 0x03000000
Read at address  0x10049400 (0xffffacdfe400): 0x00000000
[POEG]open
[POEG] user control pin output disable disabled
[POEG]close
[POEG]open
[POEG] user control pin output disable enabled
[POEG]close
Read at address  0x10048434 (0xffff89990434): 0x031B031B
Read at address  0x10048438 (0xffffb5b98438): 0x03000000
Read at address  0x10049400 (0xffff949ef400): 0x00000008
[POEG]open
[POEG] user control pin output disable disabled
[POEG]close
 74:          0          0    GICv3 357 Level     10049400.poeg
Read at address  0x10048434 (0xffff8f401434): 0x031B031B
Read at address  0x10048438 (0xffffbb55b438): 0x03000000
Read at address  0x10049400 (0xffff969c4400): 0x00000000

With renesas,poeg-config = <2>;
root@smarc-rzv2l:~# /poeg.sh
Test case 2  GPT control
Read at address  0x10048434 (0xffffa2e9c434): 0x031B031B
[POEG]open
[POEG] GPT control configure IRQ
Read at address  0x10048438 (0xffff88063438): 0x23000000
Read at address  0x10049400 (0xffff9a09a400): 0x00000020
gpt ch:4, irq=2
gpt ch:4, irq=2
gpt ch:4, irq=2
gpt ch:4, irq=2
Read at address  0x10048434 (0xffff90768434): 0x021B031B
Read at address  0x10048438 (0xffffa652c438): 0x23000000
Read at address  0x10049400 (0xffffa2b64400): 0x00000020
 74:          5          0    GICv3 357 Level     10049400.poeg

With renesas,poeg-config = <4>;
root@smarc-rzv2l:~# /poeg.sh
Test case 2  GPT control
Read at address  0x10048434 (0xffff81226434): 0x031B031B
[POEG]open
[POEG] GPT control configure IRQ
Read at address  0x10048438 (0xffffa35fd438): 0x43000000
Read at address  0x10049400 (0xffffb4a0e400): 0x00000020
gpt ch:4, irq=4
gpt ch:4, irq=4
gpt ch:4, irq=4
gpt ch:4, irq=4
Read at address  0x10048434 (0xffff81df7434): 0x021B031B
Read at address  0x10048438 (0xffffa8fdf438): 0x43000000
Read at address  0x10049400 (0xffff9f49b400): 0x00000020
 74:          5          0    GICv3 357 Level     10049400.poeg

Biju Das (15):
  dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
  pwm: rzg2l-gpt: Add support for gpt linking with poeg
  dt-bindings: pinctrl: rzg2l-poeg: Document renesas,poeg-config
    property
  drivers: pinctrl: renesas: Add RZ/G2L POEG driver support
  arm64: dts: renesas: r9a07g0{4,5}4: Add POEG nodes
  arm64: dts: renesas: rzg2l-smarc: Enable POEGG{A,B,C,D} on carrier
    board
  arm64: defconfig: Enable Renesas RZ/G2L POEG interface
  tools/poeg: Add test app for poeg
  pwm: rzg2l-gpt: Add support for output disable request from gpt
  pwm: rzg2l-gpt: Add support for output disable when both output low
  pwm: rzg2l-gpt: Add support for output disable on dead time error
  pinctrl: renesas: rzg2l-poeg: Add support for GPT Output-Disable
    Request
  pinctrl: renesas: rzg2l-poeg: output-disable request from GPT when
    both outputs are low.
  pinctrl: renesas: rzg2l-poeg: output-disable request from GPT on dead
    time error
  tools: poeg: Add support for handling GPT output request disable

 .../bindings/pinctrl/renesas,rzg2l-poeg.yaml  |  16 +
 .../bindings/pwm/renesas,rzg2l-gpt.yaml       |  23 +
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi    |  52 ++
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi    |  52 ++
 arch/arm64/boot/dts/renesas/rzg2l-smarc.dtsi  |   6 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/pinctrl/renesas/Kconfig               |   2 +
 drivers/pinctrl/renesas/Makefile              |   2 +
 drivers/pinctrl/renesas/poeg/Kconfig          |  11 +
 drivers/pinctrl/renesas/poeg/Makefile         |   2 +
 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c     | 481 ++++++++++++++++++
 drivers/pwm/pwm-rzg2l-gpt.c                   | 212 ++++++++
 include/linux/pinctrl/rzg2l-poeg.h            |  26 +
 include/linux/pwm/rzg2l-gpt.h                 |  44 ++
 tools/poeg/Build                              |   1 +
 tools/poeg/Makefile                           |  53 ++
 tools/poeg/poeg_app.c                         |  95 ++++
 17 files changed, 1079 insertions(+)
 create mode 100644 drivers/pinctrl/renesas/poeg/Kconfig
 create mode 100644 drivers/pinctrl/renesas/poeg/Makefile
 create mode 100644 drivers/pinctrl/renesas/poeg/rzg2l-poeg.c
 create mode 100644 include/linux/pinctrl/rzg2l-poeg.h
 create mode 100644 include/linux/pwm/rzg2l-gpt.h
 create mode 100644 tools/poeg/Build
 create mode 100644 tools/poeg/Makefile
 create mode 100644 tools/poeg/poeg_app.c

-- 
2.43.0


