Return-Path: <linux-pwm+bounces-2069-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B981A8B0A39
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 14:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C44284080
	for <lists+linux-pwm@lfdr.de>; Wed, 24 Apr 2024 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC6D15B159;
	Wed, 24 Apr 2024 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ODrtC3jq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197915ADA0
	for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713963536; cv=none; b=BAI7HsOZfCKHYFML4uuflUmroJrwF1e3tlnXCDE48ITvpqGK9CaokmTEAmhS7oqaGX3eAYQOUs5NiexjMSGDRFTMOHTBxzU4ddCOfGlMBBGjCBJBdNGmul64vnjpbizr+NEwQTwNkF5ZvxX7b+BxO7xNafTtM68p2t2LVhBo26Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713963536; c=relaxed/simple;
	bh=eZWwx1HleA2H2KsYpp8/b1FXrqygcSKWHtLnmkvXx/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVSIuXadY866LZengKt/fib0h5RKBTbgZD6ry/XsH/AGkhuiLwRkI4e6afd3UZStLfOU32fYqyz2BQ4EpUxLJdmZAGKAFvP1S7bZU3IMC3ZXfkE38wsyEvXLr0zDosaBF3zFKY9JeMSpxBjDpYCljkeoKSyouGglwCKU1tOm1L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ODrtC3jq; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-434d0f63c31so41301141cf.1
        for <linux-pwm@vger.kernel.org>; Wed, 24 Apr 2024 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713963533; x=1714568333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e7+ZLqU/gDelabgH8W2uB3IIPL7uflMtAzBDAnbqEuU=;
        b=ODrtC3jqDEfH6piTXTRLlOqnHfPZOulvU72FlZ6EuhxYMoj9W0PqlW+5gMcUYa4iht
         W/HGgmuoWy+RPBRcRFT25/vwjXDBHx/ytYUsMeBBsLwCQ7E45l2eZSAV4WXpWuvaH0mk
         tjeMnMba3f4V0Lx8sVXJzxHgJtAqTp8SuPXE7lBnrb8MjaQFCL+v2LgTbcCI8G1NEzfi
         WH6aC0OSKDzv4mfRVZzQ4MZhf2ksJPwELqZjlXntZ/LhXL83IylhYByULoRGmivq1wjw
         T+f2xxLXSPnIYAGcvFzsYr9tUtjy8PlNTLW/LQadjLO6ONGCQpL6o9B26eiMk7LKwbQF
         4gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713963533; x=1714568333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e7+ZLqU/gDelabgH8W2uB3IIPL7uflMtAzBDAnbqEuU=;
        b=HMk0mgp6migP4iomG82lDyYi5AwVcUlHSZRfUqDs7SbMNvp0GAYQqgBknGmT6JnXpW
         fCpU4F095U4ZsPXA1qzAVqbDPSToxBz+X0oCG5B+CFHTQPirS8PzsdHKdnkFO8iiHJdF
         ffSOwdQq50edksiRShO7Hi8wq1RO9oRx+Yq5VaM1vKXMUVs5pFv5L16ZZsLMEjJ088sD
         WYUrpSwHU5qBs8cFajDKsG7QvXXrqnvrZypE7XK1gvKCRCeQsYY6ababaI8iYmsUsugK
         +mw5QCPJeJ0qQVC2rC00065j/N9ewWeHsvI7dfLGJDPwdUSgr51utMVCw6ruL+fsiy+G
         sABg==
X-Gm-Message-State: AOJu0YxpxDK3S1vd8Xkm/6aNS73gubDgV71N9UknaKLG/T8h6CGa08JI
	GlpgUpTCeOMWff7zmj0xvURq4zg6JyFscYz4BwZi7mSJ/ho5epHKkLyX7w4CVg+ruCQHQkYGGE5
	yYNM=
X-Google-Smtp-Source: AGHT+IHvgjS1Qvogko3W0bvij7ZgjvSiRdOb5hKLjbpJWwlNsurq5a0q6joSqs0ySinlM+vkb3pvpA==
X-Received: by 2002:a05:622a:510:b0:437:4dcb:ed0 with SMTP id l16-20020a05622a051000b004374dcb0ed0mr2358337qtx.57.1713963532988;
        Wed, 24 Apr 2024 05:58:52 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id ki16-20020a05622a771000b00439c3072d24sm2399995qtb.15.2024.04.24.05.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 05:58:52 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	u.kleine-koenig@pengutronix.de,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: [PATCH 0/2 v5] pwm: add axi-pwm-gen driver
Date: Wed, 24 Apr 2024 08:58:46 -0400
Message-ID: <20240424125850.4189116-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.44.0
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

There was previously a follow-up series
(https://lore.kernel.org/linux-pwm/20240314204722.1291993-1-tgamblin@baylibre.com/)
that enabled support for two different versions of the AXI PWM GEN IP.
Since issues were identified with the v1 IP functionality and v2's
regmap is the one listed on the device wiki
(https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen), the driver
was changed to support only the v2 IP after squashing those additions.
As a result, the overall driver is simpler as it no longer uses an
axi_pwm_variant struct. Support for v1 IP can be added back later in the
event that it is required.

---
v5 changes:
* Address feedback for driver in v4:
  * Clarify device behavior in frontmatter
  * Include register name in bitfield definitions
  * Use devm_clk_rate_exclusive_get() and handle error
* Squash v2 IP patches into series from: https://lore.kernel.org/linux-pwm/20240314204722.1291993-1-tgamblin@baylibre.com/
* Refactor driver code to support only v2 IP
  * Issues were identified with v1 IP implementation, so only v2 will be
    supported
  * Remove axi_pwm_variant struct and usage
  * Version check in axi_pwmgen_setup() left as-is to limit usage to
  * only v2 IP
* Adjust dt bindings to use adi,axi-pwmgen-2.00.a

v4 changes:
* Address feedback for driver in v3:
  * Update to use devm_pwmchip_alloc() function
  * Simplify use of dev symbol in axi_pwmgen_probe
  * Remove unnecessary axi_pwmgen_from_chip function and use
    pwmchip_get_drvdata directly

Link to v3: https://lore.kernel.org/linux-pwm/20240131214042.1335251-1-tgamblin@baylibre.com/

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
 drivers/pwm/pwm-axi-pwmgen.c                  | 248 ++++++++++++++++++
 5 files changed, 319 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
 create mode 100644 drivers/pwm/pwm-axi-pwmgen.c

-- 
2.44.0


