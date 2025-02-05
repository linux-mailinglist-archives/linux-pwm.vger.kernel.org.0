Return-Path: <linux-pwm+bounces-4778-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C71B0A29619
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 17:21:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC91E1886B8B
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2025 16:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B391B1D7E52;
	Wed,  5 Feb 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="W25dn78h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074CE1A83ED;
	Wed,  5 Feb 2025 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772488; cv=none; b=KvZuq+vpkkJHrahvx3HWJ+4mjsN/1EgxLYgU1E6F53QwZHFNWwaW9ZyHCoJZQH4mNaPAFFF8GlFUacC21Qlzf/8brPIXDBQgq0fyJy2q0cLMRXTMPtsgBTYCHlj2wmjI7JWHhqlaadPROW0Y0jYGak10xOlWbTRIq/YMjpkC4Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772488; c=relaxed/simple;
	bh=2DNQADN7pp+le24xGXf6k5UgfsW76QzM6fsRSbiQY/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TH1qDYASRQWxiDIfZpJ7LCJa2HB37RH38Mnz05YB8NM+u/BECoJXv2U9GAWxVlNAJkyGYQruVxYw2knnYfxT0m1IirIDerCgTPW5ennt8b0SfprM7VKSZ0NW17yxw/5XAvjMXAaWDVZD8VWCoH92Y1gvOCM+ipdIyzzRWTxbnRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=W25dn78h; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from wse-pc.fritz.box (pd9e59260.dip0.t-ipconnect.de [217.229.146.96])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 706062FC0079;
	Wed,  5 Feb 2025 17:21:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1738772476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jfgNw/sFpnsNIWvl27HWsqu0tv0PJPndFa2C+AYRXaA=;
	b=W25dn78h6+f8rUN+JITzeNYy+vEC5SbOlwXE8WA1DD88FqqjMLZ9QdD3XoWgbEbo5lN/b+
	YYwkWg11b0pG9gjIdNHzZ/LDKr5UOwk2/yPa1SubTss6jWvskkE7DtS3nXhkwj8EQC8DKu
	5LndYp55+VjyfcmZLqZfA4pNBsxU5ZA=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	wse@tuxedocomputers.com,
	ukleinek@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: [RFC PATCH 0/1] platform/x86/tuxedo: Implement TUXEDO TUXI ACPI TFAN via hwmon
Date: Wed,  5 Feb 2025 17:19:19 +0100
Message-ID: <20250205162109.222619-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This Implements fan controls for userspace for the TUXEDO Sirius 16 Gen 1 & 2.

It also adds safeguards that userspace cannot go below certain fanspeeds at
certain temperatures. My suspicion that this is necessary was proven correct
during testing of this patch: The former version had the highest safeguard level
as 40% fanspeed at temperatures above 90°C. But after letting the device run
like that with a CPU + GPU load for a short period of time, it turned off.

It was hot to the touch above the keyboard and it doesn't turn on anymore since
then. Even after letting it cool down overnight. So I probably fried the
mainboard.

This cut my testing short for the time being and is the reason why this is send
as an RFC. It should however work and now has two additional min fanspeeds: 60%
at 95°C and 100% at 100°C.

Enforcing these minimum fanspeeds at the EC-firmware level is not possible as we
only have access to the EC-firmware as a binary blob.

Werner Sembach (1):
  platform/x86/tuxedo: Implement TUXEDO TUXI ACPI TFAN via hwmon

 MAINTAINERS                                   |   6 +
 drivers/platform/x86/Kconfig                  |   2 +
 drivers/platform/x86/Makefile                 |   3 +
 drivers/platform/x86/tuxedo/Kbuild            |   6 +
 drivers/platform/x86/tuxedo/Kconfig           |   6 +
 drivers/platform/x86/tuxedo/nbxx/Kbuild       |   9 +
 drivers/platform/x86/tuxedo/nbxx/Kconfig      |  13 +
 .../x86/tuxedo/nbxx/acpi_tuxi_hwmon.c         | 421 ++++++++++++++++++
 .../x86/tuxedo/nbxx/acpi_tuxi_hwmon.h         |  14 +
 .../platform/x86/tuxedo/nbxx/acpi_tuxi_init.c |  60 +++
 .../platform/x86/tuxedo/nbxx/acpi_tuxi_init.h |  16 +
 .../platform/x86/tuxedo/nbxx/acpi_tuxi_util.c |  58 +++
 .../platform/x86/tuxedo/nbxx/acpi_tuxi_util.h |  84 ++++
 13 files changed, 698 insertions(+)
 create mode 100644 drivers/platform/x86/tuxedo/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kbuild
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/Kconfig
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_hwmon.c
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_hwmon.h
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_init.c
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_init.h
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.c
 create mode 100644 drivers/platform/x86/tuxedo/nbxx/acpi_tuxi_util.h

-- 
2.43.0


