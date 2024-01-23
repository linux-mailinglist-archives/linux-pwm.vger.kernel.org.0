Return-Path: <linux-pwm+bounces-892-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE52839BB9
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jan 2024 23:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED6F1F25730
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Jan 2024 22:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE434E1D8;
	Tue, 23 Jan 2024 22:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZHaXuQow"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9D84E1C6
	for <linux-pwm@vger.kernel.org>; Tue, 23 Jan 2024 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706047527; cv=none; b=b1a2IiUASCCUA4Jtonly1qnYMNz9cHfNzRPhPa4RuF0SsL2+DA+zYtuAzrhUqyoGMqp1RgP5MluxE/rIrC8Rm1uCQM2XtoYVqOulh/zsHudOqHgasWA3XWVhzoF1GsPpp/zKoB10Ms8UTcXVSgxSdzHYksCAikJCxxm2d+v4dw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706047527; c=relaxed/simple;
	bh=Bh9Fg0Rq0EJlsBfbc1tG8zPavrGOwHmk32V77WBaex8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VkknSRSN+aqdu52zxmwwminIMbB4IrzVd18vIHKGT1QT49q/HJ4hrEly4IdFjj1NP3MIS8USHdpJYGOFRhbwvWhe0i1Y/RZH7I5Ah6MW6XJlP+4HX3PTwcJPD2flMnfxSzdR7o4fSOD/V6sjokUgQXzbpXWA4kLPbjM9XgUs4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZHaXuQow; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-427ca22a680so36035731cf.3
        for <linux-pwm@vger.kernel.org>; Tue, 23 Jan 2024 14:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1706047525; x=1706652325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mdlT2UzjRTynjGJwl0r9wdEFjr2b0CwzSnhw17kn+IM=;
        b=ZHaXuQow011owNGtnBiccVUdB0Aa1suE5tKB4H/ic8a5yZALlEUsAHL+z9qLEEjx0i
         uvn5qUH8hE/Qlo0XqfWAluyIwNFX3LiXGG0p8GFfq7gm4oxdUAQCqn+IQfU0fH55vRW1
         el5rqHgO2PqFWARP2TkSe12W944aLj+7yTgRoMFGOdzNvBIESdS4FsHr6I98QcH2w5ho
         CVGOgyGyMfR1/9bzg7FRD47/JXhzMTLcD3lz1fcwkcpVqk0/KbGjcHH4U2+iQB34Nm3V
         G2802ZifOh2stsHI2TOGZsMAQ6rCm4k+4tUvQMkPaDx1aHiwhXBm6TssAaY8+RIiEV7A
         b5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706047525; x=1706652325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mdlT2UzjRTynjGJwl0r9wdEFjr2b0CwzSnhw17kn+IM=;
        b=nKONQ6OAtbAoj2ANjXjRskjFIMkufpatZOlO+NvNi+4IbRDt5Zu/HTr0DHKFFJE9Hz
         ZssyXOShnVJRMdtR3KFT0joHo5Q9SK8DsOzXr/CV/4Pv3odjg2B9S4fs/WejmGsmHTQW
         tvgYEXYbmEZf8APw3IbV8OaSDX9JqUOPtrX+NnTF1Vrg/UroFQu9V+9C2wYQJzGN9EwR
         0u3heJjwDRBDp6yppbsd4L5henQEau7wFY6oz+EJ6L75pE4Y6KwHJGh+jeW8PF6Ur6GH
         bTwtirRbaH9jv4tUwxXdJVzZOD1v/AKLbQDX8aDraVb/WRATzH5127Pis8wkEnfPRYfa
         vuHQ==
X-Gm-Message-State: AOJu0YwPyUcUSfYwazNV3fKr4PMdl25TPN2hDIci0i2ZGdl71f6g3UZs
	hQ1jxUN4oYoB6/ywUBTBZVb9QqbGvN6nhc+5feET1jeoKXu5YI83iy9Aeq0QPGmhyf/LkyMDCeA
	c
X-Google-Smtp-Source: AGHT+IEy6vndxL/qZwg46M6T1+B5UwYUPIYojzTwfwPyZwjEBVl4oIrWaUzqgnxYDnKrVJc2w2zAEA==
X-Received: by 2002:a05:6214:21ab:b0:686:ac5c:5547 with SMTP id t11-20020a05621421ab00b00686ac5c5547mr464815qvc.86.1706047524843;
        Tue, 23 Jan 2024 14:05:24 -0800 (PST)
Received: from workbox.taildc8f3.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id y26-20020a05620a09da00b007834bfeb0e8sm3425402qky.51.2024.01.23.14.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 14:05:24 -0800 (PST)
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
Subject: [PATCH 0/2 v2] pwm: add axi-pwm-gen driver
Date: Tue, 23 Jan 2024 17:05:12 -0500
Message-ID: <20240123220515.279439-1-tgamblin@baylibre.com>
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
 drivers/pwm/pwm-axi-pwmgen.c                  | 246 ++++++++++++++++++
 5 files changed, 317 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
 create mode 100644 drivers/pwm/pwm-axi-pwmgen.c

-- 
2.43.0


