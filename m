Return-Path: <linux-pwm+bounces-6773-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6E9AFD053
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 18:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89C827B377F
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Jul 2025 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80F92E4990;
	Tue,  8 Jul 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmbdCwyR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8342DC321;
	Tue,  8 Jul 2025 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751991188; cv=none; b=Gdz923V42SCH3u7on6Xk66Z8pGmpJLZAl/y/4pOkwEyPBEc91wnXYlLsGo5rC+sDDKAD2ESMGWaph1mB6y3zOtHmNkoPvzgNEacQikya/afsLXntAA48h/TcwHQLv6vHcgzIlfWF5F3Y5W0CsiuaA0ngcbAoefRIOGz2j2JpaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751991188; c=relaxed/simple;
	bh=Cwb3nUB6lTov3BPnF0GyHtI8BZLdVWF5iDdsj0Ls56g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KjlWL1aYwDWJUB/6yKVUDyEBMKJlXAE+gXIE3OLVEYBUON+CTBVo7BK8+n9/i/LD+E59iOpBo2r3GpjbbAzshTcHXhJgmByzTcpn6wV2OQhvfbufCzR/XMnXFOk6YyhOtW4H1biHO8f5M3ZEJlObzbTkwU5g4bKyGDMQNCyEWeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmbdCwyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27FF4C4CEF0;
	Tue,  8 Jul 2025 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751991188;
	bh=Cwb3nUB6lTov3BPnF0GyHtI8BZLdVWF5iDdsj0Ls56g=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=SmbdCwyRFFyWnv772ogI3tGFGImwvVFyjYefMMJvxfFh1xV1C4m/uenK1jqCRDyvh
	 4oqvR8Uwvdlb8rDIw+hEPmd09AP/RhYIH8FX2Poc5GCGr3bXzc0ev7jziipdn/YIlX
	 3h4bp1kPiLmGJ8b/pmTbD4QnHAdjUDmK06nlrgM9L3qJqs4JTomysNDPzRUjySaFLl
	 vgvDPz2ljEGd0rnmm2DcY9ZjHsEv9eJMF7OFlbcEJy5JcWDcvJUPPz5hmLPQfwqMYa
	 WGbQ/U/mCPa8bkdC6yc1BLZEh/HVyAZuRIZvuN0oraacdSAS9A5TypWVpm2MNFuE0E
	 vSTU4PeDwN8SA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1207CC83F0A;
	Tue,  8 Jul 2025 16:13:08 +0000 (UTC)
From: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Subject: [PATCH v4 0/2] hwmon: add support for MC33XS2410 hardware
Date: Tue, 08 Jul 2025 18:13:02 +0200
Message-Id: <20250708-mc33xs2410-hwmon-v4-0-95b9e3ea5f5c@liebherr.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAI5DbWgC/23N3wrCIBTH8VcJrzP8M3PrqveILpweU2gzNGwx9
 u65ERS1y++B3+eMKEH0kNBhM6II2Scf+hLVdoO0U/0FsDelESNMEEEk7jTnQ2IVJdg9utBjJax
 twIImRKAyu0WwfljI07m08+ke4nP5kOl8fWOU/WOZYoqVMa2SUsvaNserh9ZBjDsdOjR7mX0bY
 sVgxagNg7KXwIlZMfjH2NNmxeDF4IRKTqFqbG1/jGmaXt4upTE7AQAA
X-Change-ID: 20250507-mc33xs2410-hwmon-a5ff9efec005
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Dimitri Fedrau <dimitri.fedrau@liebherr.com>, 
 Dimitri Fedrau <dima.fedrau@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751991186; l=1629;
 i=dimitri.fedrau@liebherr.com; s=20241202; h=from:subject:message-id;
 bh=Cwb3nUB6lTov3BPnF0GyHtI8BZLdVWF5iDdsj0Ls56g=;
 b=HirHDqyykc7iCpQ/3mXnfNNpmURi0wQMxBQeo36GQ5Jpk1oLhUJsHKRDKsaw3e48vkOMfOQwT
 S9wdVM6STX9B1XFJKuXbdw1MUsITjMJq5ngclipRSvqZw0CLLeeL5PE
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

 drivers/hwmon/Kconfig            |  10 +++
 drivers/hwmon/Makefile           |   1 +
 drivers/hwmon/mc33xs2410_hwmon.c | 179 +++++++++++++++++++++++++++++++++++++++
 drivers/pwm/Kconfig              |   1 +
 drivers/pwm/pwm-mc33xs2410.c     |  64 +++++++++++++-
 include/linux/mc33xs2410.h       |  14 +++
 6 files changed, 267 insertions(+), 2 deletions(-)
---
base-commit: 446d36aa71b56e8a926e6ff066d83b12130fda59
change-id: 20250507-mc33xs2410-hwmon-a5ff9efec005

Best regards,
-- 
Dimitri Fedrau <dimitri.fedrau@liebherr.com>



