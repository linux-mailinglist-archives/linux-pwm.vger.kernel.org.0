Return-Path: <linux-pwm+bounces-6873-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE89B0F954
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Jul 2025 19:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C605A0AFD
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Jul 2025 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32796221F11;
	Wed, 23 Jul 2025 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVTh23Ym"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015ED21FF5B;
	Wed, 23 Jul 2025 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292107; cv=none; b=ZeP9fNLdc/tEHg2szdqkWsNbpGbD6/4rxM00jF1WO639MtXUdbquuldYu/vIIo24NQIZE/OOWL7ixkR63G2JFi6w4zTBtJV5cjFjwzeF/tLlrSk5lkkxDKt0fqOa20llz/MUtywFyLSSU1chtbbkS8phYi4fL9X4sLdPTcvNVDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292107; c=relaxed/simple;
	bh=DxP/8U/gv179+30ubQutejfBAUlzcxofPDI//uz2+R4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q8qnDxnM/Gx/0q3ubgJdxOuggqz73SDNQJtKMBWM94LM+DjGbb82bSwkYZ3Z4pgyxe8uybYJESX8CzweUZ6W96nkB5Erj613ynBoFKJ+U7QFlltI/lOlCWC/PIyl2j9kA2OukFTO3l4xalASlGvnjHFzsilAdYfZWO07SCObYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVTh23Ym; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 908A1C4CEE7;
	Wed, 23 Jul 2025 17:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753292106;
	bh=DxP/8U/gv179+30ubQutejfBAUlzcxofPDI//uz2+R4=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=MVTh23YmUNkU71zCRbAYlnJYU4ugyNq3CDZLnJrUfZAvrJ3AVaPH9p3XRWW8xGgtB
	 NPmC9pqJTDx9OGXUz/yrGsddDYAqBm2RhJy3HJ/UOyMqhFwRN2+4Mutb5YAxVPlM42
	 ixRbnYyPFr67e9d88K16+7WmnoyAOeWZLUJ9nGywq4cHezPq4v/KuPEJgTLhZsKWRP
	 KzgxJmMIph1wRYd7mk3l5o2Tji0XsmTBqcG9onOOwlYZ+maQGZ/mEdbPvTVfF+Kst2
	 zebSL/UD2YxtIsiaZqKfaQfh3lqHi5mHRs8ofIP/x7qaSKwUofxeLN6Cm7VJNudOTK
	 d6A2rqKzMBetQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804E1C83F1A;
	Wed, 23 Jul 2025 17:35:06 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v5 0/2] hwmon: add support for MC33XS2410 hardware
Date: Wed, 23 Jul 2025 19:34:55 +0200
Message-Id: <20250723-mc33xs2410-hwmon-v5-0-f62aab71cd59@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD8dgWgC/23Q0QrCIBQG4FcJrzOOOnN21XtEF5sem9C20FiLs
 XfPjaAoL/8D//fDmUjE4DGSw2YiAQcffd+lILcbYpqquyD1NmXCgUuQoGhrhBgjLxjQ5tH2Ha2
 kcxodGgBJUu0W0PlxJU/nlBsf7314rgsDW65vjPF/bGCU0craulLKqNLp49Vj3WAIO9O3ZPEG/
 m3IjMGTUVqOqa9QgM0Y4mPsmc4YIhkCmBIMC+1KlzGKj6GgzBgFBaplrVFgepI0P8Y8zy99T6x
 EfwEAAA==
X-Change-ID: 20250507-mc33xs2410-hwmon-a5ff9efec005
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753292105; l=2083;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=DxP/8U/gv179+30ubQutejfBAUlzcxofPDI//uz2+R4=;
 b=w2jsYEX3F4tizmo5c8iQbF8fCJeuHjAOI2yQlfmaW1ngd4BN8okSmhyujLKXgFy+3yMnJifrF
 AsQ/iBYkl/QC5eDneSi+Vzq27UhkWc3o1+06/u5pAfbmjZ84VIjJedp
X-Developer-Key: i=dimitri.fedrau@liebherr.com; a=ed25519;
 pk=rT653x09JSQvotxIqQl4/XiI4AOiBZrdOGvxDUbb5m8=
X-Endpoint-Received: by B4 Relay for dimitri.fedrau@liebherr.com/20241202
 with auth_id=290
X-Original-From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
Reply-To: dimitri.fedrau@liebherr.com

The device is able to monitor temperature, voltage and current of each of
the four outputs. Add basic support for monitoring the temperature of the
four outputs and the die temperature.

Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
---
Changes in v5:
- Define DEFAULT_SYMBOL_NAMESPACE
- Replace mc33xs2410_hwmon_register with devm_auxiliary_device_create
- Add MODULE_IMPORT_NS("PWM_MC33XS2410") to mc33xs2410.h
- Add documentation for HWMON driver
- Link to v4: https://lore.kernel.org/r/20250708-mc33xs2410-hwmon-v4-0-95b9e3ea5f5c@liebherr.com

Changes in v4:
- Move hwmon functionality into separate driver residing in hwmon subsystem
  (auxiliary device)
- Link to v3: https://lore.kernel.org/r/20250619-mc33xs2410-hwmon-v3-1-301731e49f8f@liebherr.com

Changes in v3:
- Add changes suggested by Uwe Kleine-König.
  Remove "#if IS_ENABLED(CONFIG_HWMON)" and add
  "if (IS_REACHABLE(CONFIG_HWMON))" in mc33xs2410_hwmon_probe.
- Link to v2: https://lore.kernel.org/r/20250515-mc33xs2410-hwmon-v2-1-8d2e78f7e30d@liebherr.com

Changes in v2:
- Remove helper mc33xs2410_hwmon_read_out_status and report the last
  latched status.
- Link to v1: https://lore.kernel.org/r/20250512-mc33xs2410-hwmon-v1-1-addba77c78f9@liebherr.com

---
Dimitri Fedrau (2):
      pwm: mc33xs2410: add hwmon support
      hwmon: add support for MC33XS2410 hardware monitoring

 Documentation/hwmon/index.rst            |   1 +
 Documentation/hwmon/mc33xs2410_hwmon.rst |  34 ++++++
 drivers/hwmon/Kconfig                    |  10 ++
 drivers/hwmon/Makefile                   |   1 +
 drivers/hwmon/mc33xs2410_hwmon.c         | 178 +++++++++++++++++++++++++++++++
 drivers/pwm/Kconfig                      |   1 +
 drivers/pwm/pwm-mc33xs2410.c             |  20 +++-
 include/linux/mc33xs2410.h               |  16 +++
 8 files changed, 259 insertions(+), 2 deletions(-)
---
base-commit: 3b85883a9a7751ab198696f33f94afa428b43722
change-id: 20250507-mc33xs2410-hwmon-a5ff9efec005

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



