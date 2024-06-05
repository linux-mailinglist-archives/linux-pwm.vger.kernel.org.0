Return-Path: <linux-pwm+bounces-2361-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC6D8FD797
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 22:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF44B21738
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Jun 2024 20:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E445A15F319;
	Wed,  5 Jun 2024 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="BwdcCM7v"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10F515EFAC
	for <linux-pwm@vger.kernel.org>; Wed,  5 Jun 2024 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619722; cv=none; b=n5Q54Cj0s7JXa1iXnFf9tH6dEaBI8T8AVd7xlqZLKtJN8Mx/2hfC5lOHHv0xoQwoQyj/bfyo/rHUDoKhJ7zkrGRKYCJtereYR4PKViP/gfiq+vvg/JcJZEauFRQHZwOfrIh8u+lumrLwr07Ie+ERUpIa1P5rEE1pa9FTJ46PPU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619722; c=relaxed/simple;
	bh=fxwfVm39ZcRybdnNzjnvsoYSEvG2oI1jTB6vXvqSv1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bim+S0En6I2xyXYWD3UghClmvqBupylyq2AxrPR2NtD9i3H4+yHlv7oEuA6mChPwMWXcKCLCtmy4ljkRalpCKztFwtpr+JWoED4NvFGuDRtd3C8Z9AHsC1+Ca/nQ7D6yAhfZwXJaOB2og7ZG8aWVOoXbfBckaApfvTqxU3oCKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=BwdcCM7v; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6afbbc87967so1338456d6.2
        for <linux-pwm@vger.kernel.org>; Wed, 05 Jun 2024 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717619719; x=1718224519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+E/sPYFZ2r3gxbf3KE8pUaSfH7SoBFCbZu0vjofWEI=;
        b=BwdcCM7vdFRwEp6cqFe7vPROlVKPSFIRUYVk8nXwIhHxMOddLKmyR3usHccZ+oi8tX
         2AHC1B0GKJki6eTQ4dDakAehdp8X2AZkQ0h6Crug19sjU3ugPFqClMfs7ULfj0qoKbom
         J0NM25YCnXWh6Zypt8AuYpgfr5sVIoOnjC8E5zn55RHwPz4PCMo/ieoH9+W1tY0yuBHN
         nFIFt/fc7T0vlhIUV7rbr7/VPzwKzzQN59NndkPQSpgaR5GwsXJCoX6V4kOetfJjOhYP
         x8VGhntjzWGG91Q/XelkbdS3A61R6IZyStK0BF2k1pMhcrAkBXWbsVBYNvaKPNGB/KK3
         YvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717619719; x=1718224519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+E/sPYFZ2r3gxbf3KE8pUaSfH7SoBFCbZu0vjofWEI=;
        b=EOrXRVuCTqr8rhU5QVHAyLEDjZctuZ91PKJNudmCP2bXmb8m6uceaTyLhdTbfbLelH
         iqIItWvhYswIf08e9OrpTrmOjpZxDuUfNg4Qufw0Yk0v7UKU01KbiwdOhBT8aCdmJ9mf
         EA5JIc30oj4AThSc19Uu9SMY4+3uSIa368Q05lUphctKzO9vsW43CNcFKgnwr7s5FmRK
         oLIB1q5YnGtfA3eWTfg1TU/gPhs9/2V2jvzX2GkJlu4Fzcjo8yNe2RiF0uDNcvQSR1eU
         aveefkYsWl3MMZ1JUnSxpWDQXzEWBEeTs9LLpl3/1spVJcudsny5pGZRVsgK8b8uxfVK
         KRLA==
X-Gm-Message-State: AOJu0YxQNzpFlgXH2QCkZCcoRlHd7p4gPoIXNLVSi5jlkuu/cfs+QBQZ
	u4kKdPX7pSE2p5ymiMnsRFuubb9obLHNHhROyEvYS+I3L/GJsyVDIdeFYKwkEjp1/mluDLW/GJa
	h
X-Google-Smtp-Source: AGHT+IF9GDFQiIuzkSYc2GiPRBY2oYaLDMU5ux7BQkFZIJgvvwabcj/Q2Wy2ss+fgBl6GYLWmTug0w==
X-Received: by 2002:a05:6214:4385:b0:6ae:d66c:40db with SMTP id 6a1803df08f44-6b030aa92dbmr34370476d6.65.1717619719371;
        Wed, 05 Jun 2024 13:35:19 -0700 (PDT)
Received: from localhost.localdomain (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6afc72485f8sm25359866d6.5.2024.06.05.13.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:35:18 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
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
Subject: [PATCH 2/2 v6] pwm: Add driver for AXI PWM generator
Date: Wed,  5 Jun 2024 16:35:06 -0400
Message-ID: <20240605203507.1934434-3-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240605203507.1934434-1-tgamblin@baylibre.com>
References: <20240605203507.1934434-1-tgamblin@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Drew Fustini <dfustini@baylibre.com>

Add support for the Analog Devices AXI PWM Generator. This device is an
FPGA-implemented peripheral used as PWM signal generator and can be
interfaced with AXI4. The register map of this peripheral makes it
possible to configure the period and duty cycle of the output signal.

Link: https://analogdevicesinc.github.io/hdl/library/axi_pwm_gen/index.html
Co-developed-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
Acked-by: Nuno Sa <nuno.sa@analog.com>
Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
v6 changes:
* Address feedback for driver in v5:
  * Add link to public device documentation in pwm-axi-pwmgen.c
  * Remove unnecessary line split in axi_pwmgen_setup
  * Remove unnecessary call to devm_add_action_or_reset() in
    axi_pwmgen_probe
* Update documentation link in commit message

v5 changes:
* Address feedback for driver in v5:
  * Clarify device behavior in frontmatter
  * Include register name in bitfield definitions
  * Use devm_clk_rate_exclusive_get() and handle error
* Squash v2 IP support from: https://lore.kernel.org/linux-pwm/20240314204722.1291993-1-tgamblin@baylibre.com/
* Refactor driver code to support only v2 IP
  * Issues were identified with v1 IP implementation, so only v2 will be
    supported
  * Remove axi_pwm_variant struct and usage
  * Version check in axi_pwmgen_setup() left as-is to limit usage to
  * only v2 IP

v4 changes:
* Address feedback for driver in v3:
  * Update to use devm_pwmchip_alloc() function
  * Simplify use of dev symbol in axi_pwmgen_probe
  * Remove unnecessary axi_pwmgen_from_chip function and use
    pwmchip_get_drvdata directly

v3 changes:
* Address feedback for driver in v2:
  * Remove unnecessary blank line in axi_pwmgen_apply
  * Use macros already defined in <linux/fpga/adi-axi-common.h> for
    version checking

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
* Remove redundant calls to clk_get_rate
* Test contents of AXI_PWMGEN_REG_CORE_MAGIC instead of
  arbitrary AXI_PWMGEN_TEST_DATA in AXI_PWMGEN_REG_SCRATCHPAD
* Remove redundant clk struct from axi_pwmgen_ddata
* Add self as module author
* Add major version check for IP core
---
 MAINTAINERS                  |   1 +
 drivers/pwm/Kconfig          |  13 ++
 drivers/pwm/Makefile         |   1 +
 drivers/pwm/pwm-axi-pwmgen.c | 241 +++++++++++++++++++++++++++++++++++
 4 files changed, 256 insertions(+)
 create mode 100644 drivers/pwm/pwm-axi-pwmgen.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e3cb7465fcc2..485b7e224a03 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3472,6 +3472,7 @@ L:	linux-pwm@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
+F:	drivers/pwm/pwm-axi-pwmgen.c
 
 AXXIA I2C CONTROLLER
 M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 1dd7921194f5..00a543de8f82 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -94,6 +94,19 @@ config PWM_ATMEL_TCB
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-atmel-tcb.
 
+config PWM_AXI_PWMGEN
+	tristate "Analog Devices AXI PWM generator"
+	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  This enables support for the Analog Devices AXI PWM generator.
+
+	  This is a configurable PWM generator with variable pulse width and
+	  period.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called pwm-axi-pwmgen.
+
 config PWM_BCM_IPROC
 	tristate "iProc PWM support"
 	depends on ARCH_BCM_IPROC || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 90913519f11a..6964ba45c795 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
+obj-$(CONFIG_PWM_AXI_PWMGEN)	+= pwm-axi-pwmgen.o
 obj-$(CONFIG_PWM_BCM_IPROC)	+= pwm-bcm-iproc.o
 obj-$(CONFIG_PWM_BCM_KONA)	+= pwm-bcm-kona.o
 obj-$(CONFIG_PWM_BCM2835)	+= pwm-bcm2835.o
diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
new file mode 100644
index 000000000000..1bd4150e0158
--- /dev/null
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AXI PWM generator
+ *
+ * Copyright 2024 Analog Devices Inc.
+ * Copyright 2024 Baylibre SAS
+ *
+ * Device docs: https://analogdevicesinc.github.io/hdl/library/axi_pwm_gen/index.html
+ *
+ * Limitations:
+ * - The writes to registers for period and duty are shadowed until
+ *   LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG, at which point
+ *   they take effect.
+ * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
+ *   enabled channels, which could cause glitching on other channels. It
+ *   is therefore expected that channels are assigned harmonic periods
+ *   and all have a single user coordinating this.
+ * - Supports normal polarity. Does not support changing polarity.
+ * - On disable, the PWM output becomes low (inactive).
+ */
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/fpga/adi-axi-common.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#define AXI_PWMGEN_REG_CORE_VERSION	0x00
+#define AXI_PWMGEN_REG_ID		0x04
+#define AXI_PWMGEN_REG_SCRATCHPAD	0x08
+#define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
+#define AXI_PWMGEN_REG_CONFIG		0x10
+#define AXI_PWMGEN_REG_NPWM		0x14
+#define AXI_PWMGEN_CHX_PERIOD(ch)	(0x40 + (4 * (ch)))
+#define AXI_PWMGEN_CHX_DUTY(ch)		(0x80 + (4 * (ch)))
+#define AXI_PWMGEN_CHX_OFFSET(ch)	(0xC0 + (4 * (ch)))
+#define AXI_PWMGEN_REG_CORE_MAGIC_VAL	0x601A3471 /* Identification number to test during setup */
+#define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
+#define AXI_PWMGEN_REG_CONFIG_RESET	BIT(0)
+
+struct axi_pwmgen_ddata {
+	struct regmap *regmap;
+	unsigned long clk_rate_hz;
+};
+
+static const struct regmap_config axi_pwmgen_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
+	unsigned int ch = pwm->hwpwm;
+	struct regmap *regmap = ddata->regmap;
+	u64 period_cnt, duty_cnt;
+	int ret;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (state->enabled) {
+		period_cnt = mul_u64_u64_div_u64(state->period, ddata->clk_rate_hz, NSEC_PER_SEC);
+		if (period_cnt > UINT_MAX)
+			period_cnt = UINT_MAX;
+
+		if (period_cnt == 0)
+			return -EINVAL;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), period_cnt);
+		if (ret)
+			return ret;
+
+		duty_cnt = mul_u64_u64_div_u64(state->duty_cycle, ddata->clk_rate_hz, NSEC_PER_SEC);
+		if (duty_cnt > UINT_MAX)
+			duty_cnt = UINT_MAX;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), duty_cnt);
+		if (ret)
+			return ret;
+	} else {
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_PERIOD(ch), 0);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(regmap, AXI_PWMGEN_CHX_DUTY(ch), 0);
+		if (ret)
+			return ret;
+	}
+
+	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
+}
+
+static int axi_pwmgen_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct axi_pwmgen_ddata *ddata = pwmchip_get_drvdata(chip);
+	struct regmap *regmap = ddata->regmap;
+	unsigned int ch = pwm->hwpwm;
+	u32 cnt;
+	int ret;
+
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_PERIOD(ch), &cnt);
+	if (ret)
+		return ret;
+
+	state->enabled = cnt != 0;
+
+	state->period = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
+
+	ret = regmap_read(regmap, AXI_PWMGEN_CHX_DUTY(ch), &cnt);
+	if (ret)
+		return ret;
+
+	state->duty_cycle = DIV_ROUND_UP_ULL((u64)cnt * NSEC_PER_SEC, ddata->clk_rate_hz);
+
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	return 0;
+}
+
+static const struct pwm_ops axi_pwmgen_pwm_ops = {
+	.apply = axi_pwmgen_apply,
+	.get_state = axi_pwmgen_get_state,
+};
+
+static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
+{
+	int ret;
+	u32 val;
+
+	ret = regmap_read(regmap, AXI_PWMGEN_REG_CORE_MAGIC, &val);
+	if (ret)
+		return ret;
+
+	if (val != AXI_PWMGEN_REG_CORE_MAGIC_VAL)
+		return dev_err_probe(dev, -ENODEV,
+			"failed to read expected value from register: got %08x, expected %08x\n",
+			val, AXI_PWMGEN_REG_CORE_MAGIC_VAL);
+
+	ret = regmap_read(regmap, AXI_PWMGEN_REG_CORE_VERSION, &val);
+	if (ret)
+		return ret;
+
+	if (ADI_AXI_PCORE_VER_MAJOR(val) != 2) {
+		return dev_err_probe(dev, -ENODEV, "Unsupported peripheral version %u.%u.%u\n",
+			ADI_AXI_PCORE_VER_MAJOR(val),
+			ADI_AXI_PCORE_VER_MINOR(val),
+			ADI_AXI_PCORE_VER_PATCH(val));
+	}
+
+	/* Enable the core */
+	ret = regmap_update_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_REG_CONFIG_RESET, 0);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(regmap, AXI_PWMGEN_REG_NPWM, &val);
+	if (ret)
+		return ret;
+
+	/* Return the number of PWMs */
+	return val;
+}
+
+static int axi_pwmgen_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct regmap *regmap;
+	struct pwm_chip *chip;
+	struct axi_pwmgen_ddata *ddata;
+	struct clk *clk;
+	void __iomem *io_base;
+	int ret;
+
+	io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
+
+	regmap = devm_regmap_init_mmio(dev, io_base, &axi_pwmgen_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "failed to init register map\n");
+
+	ret = axi_pwmgen_setup(regmap, dev);
+	if (ret < 0)
+		return ret;
+
+	chip = devm_pwmchip_alloc(dev, ret, sizeof(*ddata));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	ddata = pwmchip_get_drvdata(chip);
+	ddata->regmap = regmap;
+
+	clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
+
+	ret = devm_clk_rate_exclusive_get(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get exclusive rate\n");
+
+	ddata->clk_rate_hz = clk_get_rate(clk);
+	if (!ddata->clk_rate_hz || ddata->clk_rate_hz > NSEC_PER_SEC)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid clock rate: %lu\n", ddata->clk_rate_hz);
+
+	chip->ops = &axi_pwmgen_pwm_ops;
+	chip->atomic = true;
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not add PWM chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id axi_pwmgen_ids[] = {
+	{ .compatible = "adi,axi-pwmgen-2.00.a" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axi_pwmgen_ids);
+
+static struct platform_driver axi_pwmgen_driver = {
+	.driver = {
+		.name = "axi-pwmgen",
+		.of_match_table = axi_pwmgen_ids,
+	},
+	.probe = axi_pwmgen_probe,
+};
+module_platform_driver(axi_pwmgen_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sergiu Cuciurean <sergiu.cuciurean@analog.com>");
+MODULE_AUTHOR("Trevor Gamblin <tgamblin@baylibre.com>");
+MODULE_DESCRIPTION("Driver for the Analog Devices AXI PWM generator");
-- 
2.45.1


