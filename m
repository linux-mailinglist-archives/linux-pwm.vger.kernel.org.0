Return-Path: <linux-pwm+bounces-2355-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9D38FD348
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 18:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7334F1F247B2
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578EB18FDDE;
	Wed,  5 Jun 2024 16:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Iaa3E0wF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D934D188CB8
	for <linux-pwm@vger.kernel.org>; Wed,  5 Jun 2024 16:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717606618; cv=none; b=DKY3VAQC/NJ8jZxi3G9fu5OFKI+SCVfp6oZyuT+zvrtnVbbVZ1HGx/nCfzJ/tP3pBPWpK57wS99wM+n6WjqD3LX+SaMfy9uasp2G0u2sIymuifYZ69A3JIkVHb4vpxxJoit4moQ46nP4tlS6ELQamQ0EtkpKtZ2Wud3AQWItJZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717606618; c=relaxed/simple;
	bh=nbGtcQ9JXV+Ky54hfk8rh5aN4Wu7xmosWuw+Ltr0Tvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ut577DrWyVzBCzs2ZmR4lmeR1878mQLSweDdmbjdNYTrN5jhRQ4jJw82kjSntwHNS2ayEYmCxxQivD8hhXzE8J26kih2xPhB24Igd6eS1Se5Zk5v4t207xuwnugciEZxFSNCFjw1nBv/kR5hrHPu4+feHRbojPV+ssPNo1TLKoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Iaa3E0wF; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ba65c2127cso1234990eaf.3
        for <linux-pwm@vger.kernel.org>; Wed, 05 Jun 2024 09:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717606615; x=1718211415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qm/0jrgtk/YbDhSWTbbxULkfl8pN16Arr5JvcX2mAz8=;
        b=Iaa3E0wFQPvyBqVMIG4hQ2GpESRgio7gqPXdm9wd7KBq0j3O2eSjIJMg3IW4fUva8h
         Siu4yGBdy5Mb4sckEKWCAIMIIyNvUpzMA9HCPvajEK1MFsfPnD2AmwF5c+uomibl7pQw
         XATKQ2K3A6FEhfZ/6cixMpAFYu6nEjsURgUasJk7+dohUOdJ5kLdOPpYOkhXxFU7Tfe9
         ctkxts5bUy4ShSwiU+1T4KNbjW4fuhox9L1YdMtN7pcYmb4+rDKprP1WjZ2Sa7xC49D9
         2i/PP7M84U9MO2dh7KglekdZPAam/BJ7A/scpwHj/MympZ7a1wdCSVfcdxP5tpv/z6po
         ad8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717606615; x=1718211415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qm/0jrgtk/YbDhSWTbbxULkfl8pN16Arr5JvcX2mAz8=;
        b=nkXums03nNXfezQl0tgYMN8Ut6KCOTXJ0ooWoBo4DCpksZwp9Od0c53uPFH6EttREJ
         nb2i5xguU8EeBXHYLbxN/a7roDigvHYwYUBcer5eecJqG0MOyQ7z7MQNFgAhri3lcmaH
         rfJd9IDLhw+NB9wbJntWMJ9IodqE+M8P7XzXJL+uttKn03xIAC5+jYyYHlccG2oQRB4A
         pKRlUm7XmEtJ0rNao0qk9vQZw8sfZ0fSkJNdTvyQz+quMdJVNNyicwMqubJB5IQilmTu
         QASLPd98Z9XT7c7ICi5d9FYusAra6Xa88UbCRmHHbiH6bHJEeUnrpdyuAPW5zAt5dJuy
         XyTA==
X-Gm-Message-State: AOJu0Yw8AdMBeeln+C6NT1AgtfM/Bbn6pGB4wFU0Ma06KwxEGj0MoAnY
	zwa5MHz04AvayFqhUEi655KxwGfxqvtVJDrYtJgeqxbCbW1PfGCskSQyb5G9qV0a+ItLW0IVjQC
	J
X-Google-Smtp-Source: AGHT+IFFtDw1jKf7Rma0jvCe7LX6CA2/1RI12HDXtzPl5lt/1iOzX8tvTtEUrMapmJKNfKZ9nmI4fg==
X-Received: by 2002:a05:6358:783:b0:19c:6472:42ed with SMTP id e5c5f4694b2df-19d09e1f45cmr130361155d.20.1717606614690;
        Wed, 05 Jun 2024 09:56:54 -0700 (PDT)
Received: from localhost.localdomain (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a74d6fesm49187586d6.55.2024.06.05.09.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 09:56:54 -0700 (PDT)
From: tgamblin@baylibre.com
To: linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ukleinek@baylibre.com,
	ukleinek@kernel.org,
	michael.hennerich@analog.com,
	nuno.sa@analog.com,
	tgamblin@baylibre.com,
	dlechner@baylibre.com,
	devicetree@vger.kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: [PATCH 0/2 v6] pwm: add axi-pwm-gen driver
Date: Wed,  5 Jun 2024 12:56:41 -0400
Message-ID: <20240605165644.3221716-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trevor Gamblin <tgamblin@baylibre.com>

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
(https://analogdevicesinc.github.io/hdl/library/axi_pwm_gen/index.html),
the driver was changed to support only the v2 IP after squashing those
additions. As a result, the overall driver is simpler as it no longer
uses an axi_pwm_variant struct. Support for v1 IP can be added back
later in the event that it is required.

---
v6 changes:
* Address feedback for driver in v5:
  * Add link to public device documentation in pwm-axi-pwmgen.c
  * Remove unnecessary line split in axi_pwmgen_setup
  * Remove unnecessary call to devm_add_action_or_reset() in
    axi_pwmgen_probe
* Update documentation link in driver and binding commit messages

Link to v5: https://lore.kernel.org/linux-pwm/20240424125850.4189116-1-tgamblin@baylibre.com/

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

Link to v4: https://lore.kernel.org/linux-pwm/20240301173343.1086332-1-tgamblin@baylibre.com/

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
 drivers/pwm/pwm-axi-pwmgen.c                  | 241 ++++++++++++++++++
 5 files changed, 312 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
 create mode 100644 drivers/pwm/pwm-axi-pwmgen.c

-- 
2.45.1


