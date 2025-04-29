Return-Path: <linux-pwm+bounces-5751-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39703AA0630
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 10:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D23178075
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 08:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4F0279347;
	Tue, 29 Apr 2025 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="UhdSu1Us"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D9927A934
	for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916674; cv=none; b=nDHKtDHNFG5nggyuwEgoNhcdoIA5hzBvnKIy+99E/zE2XGtgkOVWauGj826afS2M9mAHZ1sfaSsrsd7TcArUBvB8cuFMLHeNaPMcjfxv45TIDjiBnaof7fE1QNfv4FOUGKTnaUNtZ3yeHjN/Ox2FBbnC8+kv+SHAO3fV0mtXexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916674; c=relaxed/simple;
	bh=YsDFhu4HcEnff3t1qXe/L3ejyCjNlMTtIe/MIcb0h08=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bIr1rW8fz5+1JBXGWEpeMzxwBYWWVcb6t10Ft+B+RiXMtJaF93XpQu4l+B6EfBDRtBI/l9cAKJN2EjRLWLTlYQKIKIgnGNzzCedykDbDYYAhgY1T82H0a+cvzm1eCCbKWOTcfeZldYBr3sO5QMkKkZ8Ofx/WbBn5n/BlfAxl5eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=UhdSu1Us; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73bb647eb23so4726961b3a.0
        for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1745916671; x=1746521471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YxwsaEgj+Q0Omu+vZ1eyC37eLFX1X+cgZiMPV4Vs2Kw=;
        b=UhdSu1Us6iRu8aXXyY6WAJLdee4YB5yKjO02A136Q1NEt41nblNqRFdlwtNkY7blxS
         xtY9OcftB5a73NVYgjiEmU7j8+SZPSsl6Jwk+rnSGgk23lXKj/WM1sK/3enkkDHawTPy
         /zTfBR9PWDfIP7Hgwdz3aT7NG05e+C6RvIwD1999qBaTsnM+lMhfV5QhJyuT0HbisVzM
         X0A8m4XPjcCC9cOF/eBfLtVU5gfF0D3fuXYZBgIDgxQtx35WHE2fW3eVjJIpzTEUqzsU
         atQ/lueHzp2jt4MPjRTyvBMVy9w8eNUpo5Xzj+1ALDriYdCc6RrPDNvuzcwWvBRW3xcW
         0N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745916671; x=1746521471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxwsaEgj+Q0Omu+vZ1eyC37eLFX1X+cgZiMPV4Vs2Kw=;
        b=VVtACVdF97cTltvvuZ2ngzIMgLE91lZyzdTSLIjvXTi6jEwCjysl7+WMAZ9x87ZLIL
         0P3Abiv8yD7DrCTkhTxwGW9Yp08PFcL6qlpMc/07ElyUnHCz19uTgiH3bgvcpByhQQA2
         xrPMWJFkFG6WhJKxXbHIjQwyWq2flUO0xUpAEilfDw2fEvUwWH4YpwqMTVDZEk50sJK5
         CuOnrKyAOX6vcFvp9JDBlWHoUEBiICd4f+NtMMD5MXGecH/06GWvWFCrgXHsR5BsMRWU
         9WwBH/bOAaeuA48H2CSPEnAlSWr7d9xAg6130TnWh3DT7A8h58NC7Vt7PfN02EdHFHvJ
         CLWA==
X-Forwarded-Encrypted: i=1; AJvYcCWZw0y3hlpr6rji6GSKMtYRwHhh48V+/zTu+Koi63IXdkxBA29siabGkgjLd/ZfV95ehZi/HLAU35Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNeEO6pJW+vjCGj68njmAbX0nJQmnfMAJCvycro8nEfwRbXphe
	huhZX701a7NjQPlvD9xOefslSXMHluQSiNeP2AfG+SGFHDlmOXDo0e5X+lCB9cg=
X-Gm-Gg: ASbGncu1dzBJ5QWgNZnEf+U1oyS3U4y4aMyVhb+vWC32mHuB30tbXB/DDdqqwU5Qxg+
	L+Txp1Pj8/kEBzelEZh0fRG2A+vxg66Dsxj/hPX8YmV0cklogsA3mBYKOtGpaAHWXn3ezYICBvs
	H+cQciu6NgEEtIodtMtOSeTXTx3pPLaW7SpV79ELgTTJ0yxFCQb1benTEt2UogJDbJoDsBMPUDg
	OYlm6jISgxJQoRXkEOCHeIYsbhKMRvKXeYgSFFVPyJTzyU5IVOz/XMrOoxQAMqm8NSE5poH5j4L
	cUX0kRdN+gSY3LZ/5gzjsYSVVRZW5XjzXKZqdk7CkjcnJ4GjuEf4cycoTNzG9/JJUgiwYHcPawr
	cYavQ681buDS/Ma0=
X-Google-Smtp-Source: AGHT+IEctMKqKIxfKHwBx6+1Ghb0+9YYYgqcw8OVqlt6Q6s6LPNYwZUXZToj5U3b66+aQrGv2/impw==
X-Received: by 2002:a05:6a21:3a44:b0:1f5:93cd:59b5 with SMTP id adf61e73a8af0-2046a646f3cmr19836662637.28.1745916671308;
        Tue, 29 Apr 2025 01:51:11 -0700 (PDT)
Received: from localhost.localdomain (210-61-187-174.hinet-ip.hinet.net. [210.61.187.174])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f8597e0bsm8550119a12.44.2025.04.29.01.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:51:10 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dlan@gentoo.org,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	heylenay@4d2.org,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	unicorn_wang@outlook.com,
	duje.mihanovic@skole.hr,
	heikki.krogerus@linux.intel.com
Cc: elder@riscstar.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	guodong@riscstar.com
Subject: [PATCH v3 0/6] pwm: Update PWM_PXA driver for SpacemiT K1
Date: Tue, 29 Apr 2025 16:50:42 +0800
Message-ID: <20250429085048.1310409-1-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds support for the SpacemiT K1 SoC in the PWM_PXA driver
and updates related device tree bindings. The changes enable PWM
functionality on the K1 platform through driver enhancements,
configuration updates, and device tree additions.

Functionality has been verified on the Banana Pi BPI-F3 board using PWM14,
configured as a pwm-backlight. Per community feedback, the actual
pwm-backlight node is not included in this patchset but can be found in
patch 7 of the v1 series, with modification of pwms property to 4-cell
format to match updated binding (#pwm-cells = <3>) since v3.

+		pwms = <&pwm14 0 2000 0>;

This patchset is based on [spacemit/for-next]
  base: https://github.com/spacemit-com/linux for-next

Plus the following dependencies:
1. Clock controller driver, posted by Heylen Chu (v8), with most of it has
   been accepted:
https://lore.kernel.org/all/20250416135406.16284-1-heylenay@4d2.org/
2. Reset controller driver, posted by Alex Elder (v5):
https://lore.kernel.org/all/20250418145401.2603648-1-elder@riscstar.com/

Major differences between v3 and v2:
 - Patch 1:
    - Added: Reviewed-by: Rob Herring (Arm) <robh@kernel.org> # v2.
    - When compatible string contains "spacemit,k1-pwm",
      #pwm-cells must be 3.
 - Patch 2:
    - Dropped the addition of a reset_control field to struct pxa_pwm_chip.
    - Using a local variable in pwm_probe() instead.
 - Patch 3:
    - In k1.dtsi, changed #pwm-cells = <1> to <3>.

Major differences between v2 and v1:
 - Dropped the addition of spacemit,k1-pwm as a compatible string in the
   PWM_PXA driver; instead, it now falls back to marvell,pxa910-pwm.
 - Removed pinctrl settings for all PWM nodes (pwm0-pwm14); only the
   pwm14_1 configuration is included in this version.
 - Changed PWM_PXA from built-in to a loadable module (=m) in the
   riscv defconfig.

v2 consists of the following patches:
Patch 1: Add spacemit,k1-pwm compatible string (with fallback to
           marvell,pxa910-pwm) and support optional resets property.
Patch 2: Add reset controller support to the PWM_PXA driver.
Patch 3: Add device tree nodes for all 20 PWM instances on K1.
Patch 4: Add pinctrl settings for PWM14.
Patch 5: Add ARCH_SPACEMIT dependency to the PWM_PXA Kconfig entry.
Patch 6: Enable PWM and PWM_PXA in riscv defconfig for SpacemiT K1.

v2:
https://lore.kernel.org/all/20250420070251.378950-1-guodong@riscstar.com/

v1:
https://lore.kernel.org/all/20250411131423.3802611-1-guodong@riscstar.com/

Best regards,
Guodong Xu

Guodong Xu (6):
  dt-bindings: pwm: marvell,pxa-pwm: Add SpacemiT K1 PWM support
  pwm: pxa: add optional reset control
  riscv: dts: spacemit: add PWM support for K1 SoC
  riscv: dts: spacemit: add pwm14_1 pinctrl setting
  pwm: Kconfig: add depends on ARCH_SPACEMIT to PWM_PXA
  riscv: defconfig: Enable PWM support for SpacemiT K1 SoC

 .../bindings/pwm/marvell,pxa-pwm.yaml         |  35 +++-
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi  |   7 +
 arch/riscv/boot/dts/spacemit/k1.dtsi          | 180 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |   2 +
 drivers/pwm/Kconfig                           |   2 +-
 drivers/pwm/pwm-pxa.c                         |   7 +
 6 files changed, 225 insertions(+), 8 deletions(-)


base-commit: cb9c3aeae509b36afbdf46942a7a0a0dfc856ce7
prerequisite-patch-id: a5d2fb43fd88525fa6c8ee767c31adfee87f1012
prerequisite-patch-id: 8a8d0eefd0b4423d87f3c093b451a0fa60622ec4
prerequisite-patch-id: 30f92f93e5b3577bde61424303f21c709a715ec5
prerequisite-patch-id: d774b8281b5c6a822445365ee94925e1ab6c7a93
prerequisite-patch-id: 54a4f5d065eb9f212fd99efec6e7e06abbb9bad8
prerequisite-patch-id: 93962be60d1b58a98d947edf51b4af9edf513785
prerequisite-patch-id: 5f53f8bf16fb067628092daebc4831293261aa01
-- 
2.43.0


