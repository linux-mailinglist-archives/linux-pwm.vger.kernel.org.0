Return-Path: <linux-pwm+bounces-1154-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CD0844A38
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jan 2024 22:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31BF01C23D69
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jan 2024 21:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183AD39AF6;
	Wed, 31 Jan 2024 21:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vhywtnwT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACBA39AD8
	for <linux-pwm@vger.kernel.org>; Wed, 31 Jan 2024 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737250; cv=none; b=IuQT48Nmxub97RBabAOz/3pICicflez4ZtzwxahvISlazTH7ehHJFcFC7zDsR1avyEvwoTfkFOMD+G6DB7Zq358izk6OGmGHjBxtoES3K0pLT/aJvnWm74U2A4WSDg1DuzNXIZuZ047/9gLlQqiCTO8JCrjXMVdTWUMN5OEapfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737250; c=relaxed/simple;
	bh=T402gfDyzXVtmo/oZ0m9qcfgfnOlOaxqSbRV+G64Ecg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kjo/pUpjhuXhoide220KCrmeUb2QfyZX/uRNHdIbVkLVWpdrgPkF6nIwDTFnzIU3w9jkIldSFMUWzA0fbVnY0GwT8pGYdwGvWOZQOTgBLZCBmsMt2uRdG++GF/zIFQmSddNzxZBg4U98/ieOFwwBnDOUYoO0XLVJ4rS/dNm3P3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vhywtnwT; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-783d84ecb13so22858685a.0
        for <linux-pwm@vger.kernel.org>; Wed, 31 Jan 2024 13:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706737245; x=1707342045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Knxj9uv4iZ1dgBHeg4EtTaZgAoXlIxg9l8W0a+giSJM=;
        b=vhywtnwTuc9RakhLiZheE9wwv3V24jhKA2luXPUmble72pN0MPDNVJNdW4e9VZVBQ8
         2g5YtgMCj1KpS7GXFVdN4QSM8xxE+7q6FX7lp4Dqv4BoeZk9B6mu3pC56rWcU7IzSu1Q
         aJ3sR/0aq0Pw//XUZNsPdrJaDlPoCT61z20orp6U36OiUsCJQEcKCcRk35C4eCF+aQQk
         e6zwopHAVIjEjbXG8Nl2bJjabaF6CJDG/8z6PjGtUDdTnV6YbdJpvDnElFtrI+K19yoM
         zstaJSB9h1CtdMXWJn4Poen6vdXm0UW4PRVOq70RxHkdAESAVP7ybISLBnEWm3USqTb7
         wLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706737245; x=1707342045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Knxj9uv4iZ1dgBHeg4EtTaZgAoXlIxg9l8W0a+giSJM=;
        b=SRBKns7VwSlJaKTwQZ+tpO0/MoUxrmkt5QIhCFW6CcCqDDYFX2T+1xfZoKgO+1t8T7
         A77g4G/WAXWqmF2tN/LSd6JCK971I2G2a+5XoD4OBS4A5ZbyDoPEh3JWpKjnG80/PkdI
         DDR+Pd9x08LdJgOrEEsHcn3uq3AkfaqdlIi25ZrAIRd2DxKzQyD7WzlocWqDnKptVZpC
         /dU4utcxrP3SvepVO+gNCrTcD0K59Gna3arh2oCOGBAORG4x+OhB7pfzPgqDQSvw125d
         zvwuefPzPcdT0587WQR73N2/qal/J496a1x9qy/Z8CVegpH0DZ3riHeyXaiVKufSQnVQ
         E/8Q==
X-Gm-Message-State: AOJu0Yx84Re8pyB5cIWYkM9tmj9e69/RAlIsaymdX8UFGBa9XHV+9dsy
	4merP2StdSY+UWiqwmvO24cnVHihJBLN9FxHh1ueYG7Ed7Z+GezR+ExN86C0r69hjgOcxBGq1tT
	j
X-Google-Smtp-Source: AGHT+IH//FtR5pU/FvoNykuJnaaFodVtnbBuyvND4LKvSIV3uPOqqJuM+XClfFfjusxFg5hSItim4A==
X-Received: by 2002:a05:620a:13cd:b0:783:81c7:fb75 with SMTP id g13-20020a05620a13cd00b0078381c7fb75mr666629qkl.67.1706737245495;
        Wed, 31 Jan 2024 13:40:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUa/5saWV0RbshTbvr43QC/fkrGL4QuqVlfgMyHHE81mXU7LaMchz8kJvhTcfQkpxd/3he9NsDfHpfQVKeSxKmH9L/LQf5tJVk46peChycwPPzVZI6ioBpZHKYp3oCIIdvi4mvjPnZNd5uc5q3WY09EYQooEcBO6Q7brVTolECZSaL4hagp5AkIChW4UQkx8lgtdzbX5cAb1h7smPKCrR1G1CzMRASGg2sDZ8QR7WUbCQTuMo6XwaTFcA3CCQ9Nlgb8jehZczvTRQIxGno10G8a7wBMisX2YKmcsr/Yrw09SKH++O8JD5bJOhIFS8gBbKZq7sRT5eDuHq8/8c+0VgY=
Received: from workbox.taildc8f3.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id br44-20020a05620a462c00b007853f040aedsm537160qkb.8.2024.01.31.13.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 13:40:45 -0800 (PST)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH 0/2 v3] pwm: add axi-pwm-gen driver
Date: Wed, 31 Jan 2024 16:40:39 -0500
Message-ID: <20240131214042.1335251-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the AXI PWM GEN subsystem found on FPGA IP
cores. It can be used to generate configurable PWM outputs, and includes
options for external synchronization and clock signals.  The work is
being done on behalf of, and therefore lists maintainers from Analog
Devices, Inc.

The series has been tested on actual hardware using an EVAL-AD7985FMCZ
evaluation board. An oscilloscope was used to validate that the
generated PWM signal matched the requested one.

---

v3 changes:
* Address feedback for driver in v2:
  * Remove unnecessary blank line in axi_pwmgen_apply
  * Use macros already defined in <linux/fpga/adi-axi-common.h> for
    version checking

Link to v2: https://lore.kernel.org/linux-pwm/20240123220515.279439-1-tgamblin@baylibre.com/

v2 changes:
* Address feedback for driver and device tree in v1:
  * Use more reasonable Kconfig approach
  * Use common prefixes for all functions
  * Rename axi_pwmgen struct to axi_pwmgen_ddata
  * Change use of "pwm" to "ddata"
  * Set and check state->polarity
  * Multiply safely with mul_u64_u64_div_u64()
  * Improve handling of max and zero periods
  * Error if clk_rate_hz > NSEC_PER_SEC
  * Add "Limitations" section at top of pwm-axi-pwmgen.c
  * Don't disable outputs by default
  * Remove unnecessary macros for period, duty, offset
  * Fix axi_pwmgen_ddata alignment
  * Don't artificially limit npwm to four
  * Use clk_rate_exclusive_get(), balance with clk_rate_exclusive_put()
  * Cache clk rate in axi_pwmgen_ddata
  * Don't assign pwm->chip.base, do assign pwm->chip.atomic
  * Relocate "unevaluatedProperties" in device tree binding
* Remove redundant calls to clk_get_rate
* Test contents of AXI_PWMGEN_REG_CORE_MAGIC instead of
  arbitrary AXI_PWMGEN_TEST_DATA in AXI_PWMGEN_REG_SCRATCHPAD
* Remove redundant clk struct from axi_pwmgen_ddata
* Add self as module author
* Add major version check for IP core

Link to v1: https://lore.kernel.org/linux-pwm/20240115201222.1423626-1-tgamblin@baylibre.com/

Drew Fustini (2):
  dt-bindings: pwm: Add AXI PWM generator
  pwm: Add driver for AXI PWM generator

 .../bindings/pwm/adi,axi-pwmgen.yaml          |  48 ++++
 MAINTAINERS                                   |   9 +
 drivers/pwm/Kconfig                           |  13 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-axi-pwmgen.c                  | 242 ++++++++++++++++++
 5 files changed, 313 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
 create mode 100644 drivers/pwm/pwm-axi-pwmgen.c

-- 
2.43.0


