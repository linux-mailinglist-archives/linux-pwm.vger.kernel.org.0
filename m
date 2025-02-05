Return-Path: <linux-pwm+bounces-4766-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44920A284BD
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 07:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C1D77A19C0
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 06:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48162288C4;
	Wed,  5 Feb 2025 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ck98GAYm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C83538F82;
	Wed,  5 Feb 2025 06:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738738777; cv=none; b=pOScXdoMmbb82+OfDcMfhNjQm1CXR8Ocjtc3bSAyDjhPM99Luo6QCxlNkyzc2nqamNkySi9Npothdgxu8d10Cx0f9klxpj4dHPOebyOzaFJryYFh5pPMq/rmAexQr16a+p36qJZA9mwyGF79Emz86mWtvSKFCjmtRM23r9nnedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738738777; c=relaxed/simple;
	bh=fRuzMNeIAnVp4Dufyy+ThQ4Ejb/BDdKzdbPr3bAUMh4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oP2X+gmGmH5zxAbdfIsOaOv2sJOzRt5CUXcDY41rEPH6VxpRzK6iqjyH2YTBLeOCxYzA4xwEpRN9gAUkQ3DdzxoBKIBYaV6+4OL3nZjmxKvWIsUzFQyDRnhSqcaD8K8EnZyiQEI75w11mVh8jdcj5BVofv3/VBEpSy7rnxqSxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ck98GAYm; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71e2a32297dso344332a34.0;
        Tue, 04 Feb 2025 22:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738738775; x=1739343575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UUFk6TgopSWQITCEbcE120wI7n+sBN7sqpPKgJ7PFf0=;
        b=Ck98GAYm+w8mzpSPw7dj/dnr6JSBmROmF2qb64SFxqqJpERSEmzcuySdqkXW8cVmUT
         5f8oSSNoCT1mAy70IQatwisYWPvqTqYMzkoc7MpcERQdeOM50cKEuKyRcuh/WuRzDuqa
         FG0eOlOK+0jp/sVClJ2fDMcxqBB1OCGKwdEjdS6drcSJt8BAamjhEkC6FAG9BojkaJ7S
         ZAOwgRKoFu2tud5XXziDo0t3yOFIh3jEpoCb/c61OJs5FPnxeS5j7CeqKq+Vu8WiTbiS
         HUR31iz5esF3vuzdqeTBPx1r5csFxIcDJmXYi8VpBFzr0IvlR7qzYaZVLKYjMicPZPCP
         0KNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738738775; x=1739343575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUFk6TgopSWQITCEbcE120wI7n+sBN7sqpPKgJ7PFf0=;
        b=QYo9t2AyVTgpFS5GIIDlQJAbj8Qpp6HkWdRgC7+nGhbzFiR92QxXaAw1wVi7afYPbh
         09gIBMaaU8W4lb8PfZqRFeX4yM8e+oTMFLkFy1C0mbnTqvLbDobLESsAbKf98VOAntQ3
         85121YQKQm3xJgbw8G3f4poluVmvIoKpXmwI1xxkU/ZaE7gLY0lCCNi3SuNRWMcSCaqi
         b2BAwhkjY3G0IAjgIK6/eXTCYveh79olAR86H2WWpgUyrg5VBKJI3j2lBNx2CGHSRGeO
         5fkswzytqj/3FDqFkkrChO0bysGgMJmDDORHSzZKzuQzVnRDnoMoA1broQz7CDG6c1qC
         COpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUydahQgcDEh6NEbY+cwVRIEHflCDPg1oQv4PuVlQ3teKTBUoPcwob7mIR/d+Xrwmfaz81MCJIWW5EfkYKB@vger.kernel.org, AJvYcCWMIgZcJLbvWzy2ovbd/zICkCxgic7eCOyzM3ICKptnKxQs+1oubJtoy+RjS8prnrhuM3cz7RQAIixg@vger.kernel.org, AJvYcCWVwqNH88b4ybNg2rSUm6nC6WV2zBg7dq1TOXMOy78543NCxiQtH9v8ogsJNyU6hBZ3Ewbc0+XUxnMM@vger.kernel.org
X-Gm-Message-State: AOJu0YwRTTPGdFn2CAZ6YcX/C3yzABAhHCr6WLrKNexw4sJvikBplY5M
	XjcCiBSgOP5zLkI4eIVt8m6CUAKmh41fbBHrCkeVlwzK6GolecTz
X-Gm-Gg: ASbGncs101oXPOOnLxWj1cqdp+P6F7r6zojRJzaT9boHsor6dgDNLjyGB9YZR2rjCM3
	a+bNiCUNPELa1dlMrZ8DlkSUpz5/6X+98Bl5Y4qG+PQgh4FPSAYzOdQv7x4A686oECs9+L9ZE/R
	bkbhXCkZAyJENSdu2tGcBuEW8nM2UY8R8bmYMGtLkBgmqRdds9juTp0txzDETsC8DEhI1p6E3qY
	DZu5xwVILaUOqHJiMMrytX40/VnO2LtCXPlxwPqcLzNU1xkIY90fxuTJJpZCvWOZoHD+Cfspsk4
	EBx19enyIDs5EnxlIVe1JKGUVQ==
X-Google-Smtp-Source: AGHT+IFG1SDTKozMPahzThei5PB6whL1v2BM+EVscsLeVPRgrXAkEdyUvEUjkRuufTiB8wtsfVoRXA==
X-Received: by 2002:a05:6830:3204:b0:71d:efeb:7c78 with SMTP id 46e09a7af769-726976bd30cmr3273225a34.14.1738738774982;
        Tue, 04 Feb 2025 22:59:34 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726617cba50sm3804291a34.16.2025.02.04.22.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 22:59:33 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Subject: [PATCH v7 0/3] pwm: Add pwm driver for Sophgo SG2042
Date: Wed,  5 Feb 2025 14:59:16 +0800
Message-Id: <cover.1738737617.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add driver for pwm controller of Sophgo SG2042 SoC.

Thanks,
Chen

---

Changes in v7:
  The patch series is based on v6.14-rc1.

  Fixed following issues as per comments from Uwe Kleine-König, thanks.

  - dt-bindings: change value of "#pwm-cells" from 2 to 3.
  - driver: rename variables period/hlperiod to period_ticks/hlperiod_ticks and
    improve coding of apply()/get_state(); use
    devm_reset_control_get_optional_shared_deasserted() instead of
    devm_reset_control_get_optional_shared() and reset_control_deassert();
    add more comments and other miscellaneous code improvements.

Changes in v6:
  Nothing major changes just rebased onto v6.13-rc1 and retested. You can
  simply review or test the patches at the link [6].

Changes in v5:
  The patch series is based on v6.12-rc1. You can simply review or test
  the patches at the link [5].

  Updated driver to add resets property for pwm controller node as per
  suggestion from Inochi.

Changes in v4:
  The patch series is based on v6.12-rc1. You can simply review or test
  the patches at the link [4].

  Updated driver to set property atomic of pwm_chip to true as per suggestion
  from Sean.

Changes in v3:
  The patch series is catched up with v6.12-rc1. You can simply review or test
  the patches at the link [3].

  Add patch #3 for dts part change.

Changes in v2:
  The patch series is based on v6.11-rc6. You can simply review or test the
  patches at the link [2].

  Fixed following issues as per comments from Yixun Lan, Krzysztof Kozlowski
  and Uwe Kleine-König, thanks.

  - Some minor issues in dt-bindings.
  - driver issues, use macros with name prefix for registers access; add
    limitations comments; fixed potential calculation overflow problem;
    add .get_state() callback and other miscellaneous code improvements.

Changes in v1:
  The patch series is based on v6.11-rc6. You can simply review or test the
  patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/cover.1725536870.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-riscv/cover.1725931796.git.unicorn_wang@outlook.com/ [2]
Link: https://lore.kernel.org/linux-riscv/cover.1728355974.git.unicorn_wang@outlook.com/ [3]
Link: https://lore.kernel.org/linux-riscv/cover.1729037302.git.unicorn_wang@outlook.com/ [4]
Link: https://lore.kernel.org/linux-riscv/cover.1729843087.git.unicorn_wang@outlook.com/ [5]
Link: https://lore.kernel.org/linux-riscv/cover.1733281657.git.unicorn_wang@outlook.com/ [6]
---

Chen Wang (3):
  dt-bindings: pwm: sophgo: add PWM controller for SG2042
  pwm: sophgo: add driver for Sophgo SG2042 PWM
  riscv: sophgo: dts: add pwm controller for SG2042 SoC

 .../bindings/pwm/sophgo,sg2042-pwm.yaml       |  58 ++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   9 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sophgo-sg2042.c               | 196 ++++++++++++++++++
 5 files changed, 274 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.34.1


