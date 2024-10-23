Return-Path: <linux-pwm+bounces-3782-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B89A09AD609
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 23:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D005E1C214E6
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 21:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6171FF7D3;
	Wed, 23 Oct 2024 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1zHdq8Qa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC11FDFA3
	for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717177; cv=none; b=GulI1BMzX8sE2DQNt+p5JcOv7P1px3xHFyLjZ0DFzzysTZET/VcBj5NK08IKvj5diIRnR22KkWTgokhgnfiEWWpXQURHRXGeVKCr0I1QLr9E+Ijd3Ag6DE7XOTDBCXfYqQ6TSNUL8/w/BxUQ8y/tVv8n+sDmM9m8r4R2T7SUtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717177; c=relaxed/simple;
	bh=6LuqxODFa87GHKbqZm4iCQa79o+y+ZqqHBFoFKpHwas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LHdgD1meXSb9q/Qfg/SqAfrVXWCP64IMCU0W8F5m8yV0dzebRZYThXSNgPYkg2kX/Ue5FlwrjZfi2zXMs2KnRqop3/iBmybXFEgJEQ2c2oHt3MudFznfPA4DLqD2oSfwFprpxVYgjYYQcYbq+8Adhcfwrsc4FL+NeGpO38+AL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1zHdq8Qa; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5ebc0dbc566so111478eaf.3
        for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717174; x=1730321974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7eZRQmN+d1Xl5AiVFjBojgvbjgVdZFYfr/t0WGin1o=;
        b=1zHdq8Qad+iSEdtjTR/1OoiREQdoyujRSmpjrdX123UwpzNtIHd1bMObDJAZoO8SkV
         vmkhKhwsrYXS+ePVhghtMRdZzNtGzzCyWncpn139qwTZcYNNEOsqA+3xZT0H1mJtQgo8
         Vli20+gpdzI/Q09oAudNHMTYCJ2KEF9vE2y1NmNJt7IPNWajnFhtWDe76SnwrSYGSRqP
         QZlOUxfpCWKw30wRGGIboTT0PfhR5IX9I4dxVBC+eud/l3Bsi7DsuXXQox2hMJG8PuJu
         kqGNyNhLnOrN6dFnlkypLrodKP+3HAvm4s4ZineXQBNE7vqJDoNUUWF+Qd8BnZWfdcH1
         7Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717174; x=1730321974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7eZRQmN+d1Xl5AiVFjBojgvbjgVdZFYfr/t0WGin1o=;
        b=o3kYvTzMecnC8zSzO+MaIx9PsrlD4ladqk/Xlr8Ky78iKI5eVFJ6+M5O0djllcmH1Q
         Fp4JerSBzWK94RTwFk5NHm8zM9e9YqozMV7SLDPSEjJLbXE8wwqPL6ZEUce+HW+8LLj0
         TP6Uoq33ahUxQhM8sbycf9agPDVtGe77q1BCmwVHnY43yA4XeZZecMNQNxrbV65r6Bil
         gdZRS+LyHHL03zP/UliOPvyXVOtyK4hH630FwmXsDT2DBjSkbVr4CIKKAatT51ycnoyG
         DDgM7sw98PN5Y1C6ytq2kVPBjDZIt20/YEC+xkpZ07XQG63yrMCDIWxgwswDKLwXkL/7
         rf3A==
X-Forwarded-Encrypted: i=1; AJvYcCU/HgAmXrUaYx+mFjHfEGaNQ9pVPqvQ2jewDczIxGVaWfd/s+MBbUIHMGVuHhZ1pAkgVONBxNsLMy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVdOWQXZWocbUOu08JF65dTGGsu8hFJm1PFzMZhybk8iSlfoDL
	mtEoFqxA3iSZrPP2ngi75L70/99VTAdyjB0zIFIjBjBdMnQO3m+kWkhpLa7/VKk=
X-Google-Smtp-Source: AGHT+IGrGeUFNoZ4nfpg0y/vsYc+3tkphmXVxQMQc7RfHzm/YAo//LBkLU7KTfCeOuufF1v+fn0hcg==
X-Received: by 2002:a05:6820:1688:b0:5eb:827b:9bbf with SMTP id 006d021491bc7-5ebee9726famr2547696eaf.7.1729717173815;
        Wed, 23 Oct 2024 13:59:33 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:13 -0500
Subject: [PATCH RFC v4 06/15] spi: offload-trigger: add PWM trigger driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-6-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add a new driver for a generic PWM trigger for SPI offloads.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes: new patch in v4
---
 drivers/spi/Kconfig                   |  12 +++
 drivers/spi/Makefile                  |   3 +
 drivers/spi/spi-offload-trigger-pwm.c | 169 ++++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d65074b85f62..50d04fa317b7 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1286,4 +1286,16 @@ endif # SPI_SLAVE
 config SPI_DYNAMIC
 	def_bool ACPI || OF_DYNAMIC || SPI_SLAVE
 
+if SPI_OFFLOAD
+
+comment "SPI Offload triggers"
+
+config SPI_OFFLOAD_TRIGGER_PWM
+	tristate "SPI offload trigger using PWM"
+	depends on PWM
+	help
+	  Generic SPI offload trigger implemented using PWM output.
+
+endif # SPI_OFFLOAD
+
 endif # SPI
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 6a470eb475a2..3a76b9c61486 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -161,3 +161,6 @@ obj-$(CONFIG_SPI_AMD)			+= spi-amd.o
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
 obj-$(CONFIG_SPI_SLAVE_SYSTEM_CONTROL)	+= spi-slave-system-control.o
+
+# SPI offload triggers
+obj-$(CONFIG_SPI_OFFLOAD_TRIGGER_PWM)	+= spi-offload-trigger-pwm.o
diff --git a/drivers/spi/spi-offload-trigger-pwm.c b/drivers/spi/spi-offload-trigger-pwm.c
new file mode 100644
index 000000000000..ffb0bf75cace
--- /dev/null
+++ b/drivers/spi/spi-offload-trigger-pwm.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Analog Devices Inc.
+ * Copyright (C) 2024 BayLibre, SAS
+ *
+ * Generic PWM trigger for SPI offload.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/mod_devicetable.h>
+#include <linux/spi/spi-offload.h>
+#include <linux/types.h>
+
+struct spi_offload_trigger_pwm_state {
+	struct device *dev;
+	struct pwm_device *pwm;
+};
+
+static bool spi_offload_trigger_pwm_match(void *priv,
+					  enum spi_offload_trigger_type type,
+					  u64 *args, u32 nargs)
+{
+	if (nargs)
+		return false;
+
+	return type == SPI_OFFLOAD_TRIGGER_PERIODIC;
+}
+
+static int spi_offload_trigger_pwm_validate(void *priv,
+					    struct spi_offload_trigger_config *config)
+{
+	struct spi_offload_trigger_pwm_state *st = priv;
+	struct spi_offload_trigger_periodic *periodic = &config->periodic;
+	struct pwm_waveform wf = { };
+	int ret;
+
+	if (config->type != SPI_OFFLOAD_TRIGGER_PERIODIC)
+		return -EINVAL;
+
+	if (!periodic->frequency_hz)
+		return -EINVAL;
+
+	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
+	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
+	wf.duty_length_ns = wf.period_length_ns / 2;
+
+	ret = pwm_round_waveform_might_sleep(st->pwm, &wf);
+	if (ret < 0)
+		return ret;
+
+	periodic->frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC, wf.period_length_ns);
+
+	return 0;
+}
+
+static int spi_offload_trigger_pwm_enable(void *priv,
+					  struct spi_offload_trigger_config *config)
+{
+	struct spi_offload_trigger_pwm_state *st = priv;
+	struct spi_offload_trigger_periodic *periodic = &config->periodic;
+	struct pwm_waveform wf = { };
+
+	if (config->type != SPI_OFFLOAD_TRIGGER_PERIODIC)
+		return -EINVAL;
+
+	if (!periodic->frequency_hz)
+		return -EINVAL;
+
+	wf.period_length_ns = DIV_ROUND_UP_ULL(NSEC_PER_SEC, periodic->frequency_hz);
+	/* REVISIT: 50% duty-cycle for now - may add config parameter later */
+	wf.duty_length_ns = wf.period_length_ns / 2;
+
+	return pwm_set_waveform_might_sleep(st->pwm, &wf, false);
+}
+
+static void spi_offload_trigger_pwm_disable(void *priv)
+{
+	struct spi_offload_trigger_pwm_state *st = priv;
+	struct pwm_waveform wf;
+	int ret;
+
+	ret = pwm_get_waveform_might_sleep(st->pwm, &wf);
+	if (ret < 0) {
+		dev_err(st->dev, "failed to get waveform: %d\n", ret);
+		return;
+	}
+
+	wf.duty_length_ns = 0;
+
+	ret = pwm_set_waveform_might_sleep(st->pwm, &wf, false);
+	if (ret < 0)
+		dev_err(st->dev, "failed to disable PWM: %d\n", ret);
+}
+
+static const struct spi_offload_trigger_ops spi_offload_trigger_pwm_ops = {
+	.match = spi_offload_trigger_pwm_match,
+	.validate = spi_offload_trigger_pwm_validate,
+	.enable = spi_offload_trigger_pwm_enable,
+	.disable = spi_offload_trigger_pwm_disable,
+};
+
+static void spi_offload_trigger_pwm_release(void *data)
+{
+	pwm_disable(data);
+}
+
+static int spi_offload_trigger_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_offload_trigger_info info = {
+		.name = "trigger",
+		.id = 0,
+		.parent = dev,
+		.fwnode = dev_fwnode(dev),
+		.ops = &spi_offload_trigger_pwm_ops,
+	};
+	struct spi_offload_trigger_pwm_state *st;
+	struct spi_offload_trigger *trigger;
+	struct pwm_state state;
+	int ret;
+
+	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	st->dev = dev;
+
+	st->pwm = devm_pwm_get(&pdev->dev, NULL);
+	if (IS_ERR(st->pwm))
+		return dev_err_probe(dev, PTR_ERR(st->pwm), "failed to get PWM\n");
+
+	/* init with duty_cycle = 0, output enabled to ensure trigger off */
+	pwm_init_state(st->pwm, &state);
+	state.enabled = true;
+
+	ret = pwm_apply_might_sleep(st->pwm, &state);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to apply PWM state\n");
+
+	ret = devm_add_action_or_reset(dev, spi_offload_trigger_pwm_release, st->pwm);
+	if (ret)
+		return ret;
+
+	trigger = devm_spi_offload_trigger_alloc(dev, &info);
+	if (IS_ERR(trigger))
+		return dev_err_probe(dev, PTR_ERR(trigger), "failed to allocate trigger\n");
+
+	return devm_spi_offload_trigger_register(dev, trigger, st);
+}
+
+static const struct of_device_id spi_offload_trigger_pwm_of_match_table[] = {
+	{ .compatible = "trigger-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, spi_offload_trigger_pwm_of_match_table);
+
+static struct platform_driver spi_offload_trigger_pwm_driver = {
+	.driver = {
+		.name = "trigger-pwm",
+		.of_match_table = spi_offload_trigger_pwm_of_match_table,
+	},
+	.probe = spi_offload_trigger_pwm_probe,
+};
+module_platform_driver(spi_offload_trigger_pwm_driver);
+
+MODULE_AUTHOR("David Lechner <dlechner@baylibre.com>");
+MODULE_DESCRIPTION("Generic PWM trigger");
+MODULE_LICENSE("GPL");

-- 
2.43.0


