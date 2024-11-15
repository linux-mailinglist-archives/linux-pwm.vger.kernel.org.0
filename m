Return-Path: <linux-pwm+bounces-4082-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F38E9CF5AE
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 21:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F4A1B313A7
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419E21E282B;
	Fri, 15 Nov 2024 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rtNuM5JR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A881E2617
	for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 20:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701933; cv=none; b=AZvCxlawZOlb41loj/X9ah/50kacoVEyL1agYbysZxSWhZOZigtB482Sw+TD83IejNesSTzLzoZSivCcSHbQlpVqCxAMPSoIp98Bhekyr28Rcw1B4GkJNhBUJ1sZy3kUOLb/utuoRRY8zneqOZ/WUCoPFaOEDVS84es2x0IRz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701933; c=relaxed/simple;
	bh=TOgkx/m/6FrPpC7rnBHkuU0C5+5RkznAgqFoBKD3ESA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HmAVwtxK/iHYmFvOm04pgNyHmgVE1Kv1KXVJfJxi8l4o8KuikEUBIhQXsf06Sm1/vPCZ+JrwX6zUlems96fy+AfwJql107QMlbre+yTlHgcoWKbGQRtsJV8s4g3aWX+U/rfQkdKsgxGXoq23FH6C9D2nz2dJijkVBY/s+MyxTIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rtNuM5JR; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-27b7a1480bdso520488fac.2
        for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 12:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701930; x=1732306730; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A3CE0yheT4DVVry1IgtvS9L1hkM/iTvAih5hXhwRp+I=;
        b=rtNuM5JRgCZEpNamsauUYR59uY6Y0RXY6f4zloZYI2Mre+8Ks6LQQjz9bmQ1xp6r8c
         l8G6McpUKvu55X+HpzMDj5xITsF9KUGQRNRme9K0rAu/fpyf7m5oj1yI8z550br/uU1Z
         bWXTs+PvKWkQGnHyxMWe3ovyCcMeyqhVQ6LBTQUQsSIP3H7uTt80Z5/h2EWmWn2/mEIF
         uSRXniwKFumkJIBJ0uIMiJ/Tsvg+rNb+BlwRvKG3zTEztCLtKBA/QUaSy0SUEFuxYIjL
         PeAD9UDm7Oa8yP6g56FvDDjxI03g2YJe/r2uYxON39vJwspgxjNlWLjgf40A+9m+Sfh1
         6KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701930; x=1732306730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A3CE0yheT4DVVry1IgtvS9L1hkM/iTvAih5hXhwRp+I=;
        b=QTK4IsKCfJcA6LFVMw2lIvI33xDCCVOoYVc3YnhZPPs1kNjWpi1NRYiV5stVWg6J7G
         p/+cjoStRr5zlgEUVE5Bnew+8E/W3eF34Gif8VUnYDzLg2rvwDmMFTEXXCwsC2ZS7V5x
         zzHx3FVDiAQQDx/4fti9c2J91Tuk+YkktrpgDqpI608dCY+avQCk/lu7h5p2n1/SxW9R
         tYSWx3g7IlvEKHxifLabOAvhC+EZp1rW8k6DDa+tfZSxHaBGYHAY3lQGTja25mNqOXgf
         B5sxBsS4vI64AKKxDSMa8zRSDjdVQ9vFY8X9Xum9CUO5pDpL2MWuruspjS+DFJgtjkoZ
         3wZA==
X-Forwarded-Encrypted: i=1; AJvYcCVxm49kGB2+DDdcWa82b3vS/jWPEW9BaF8XcET8znzlifQb0yxZEN/VRQgn0+Kmhd39njZwFg4CeoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHiaVlmK0bwh/M4+FZbACKBwkqvq5an6NAD5MgGk14ttLsZSh
	pWkjf7hEM3ZxtkYV3zpTVRzvy73QGIksKcx/D9/Ov723vDiHnBuktwSZW6W8L0A=
X-Google-Smtp-Source: AGHT+IGYDEqISIJl9ctlQZb+4mYv7YJKqQHrlE6VL4Ec7aVtP9KKyc8lkY2pH9Td0Cs929GYSGBYnA==
X-Received: by 2002:a05:6871:5292:b0:287:20ea:2db2 with SMTP id 586e51a60fabf-2962e0369a3mr4342642fac.25.1731701930037;
        Fri, 15 Nov 2024 12:18:50 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:18:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Nov 2024 14:18:40 -0600
Subject: [PATCH v5 01/16] spi: add basic support for SPI offloading
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-1-bea815bd5ea5@baylibre.com>
References: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
In-Reply-To: <20241115-dlech-mainline-spi-engine-offload-2-v5-0-bea815bd5ea5@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add the basic infrastructure to support SPI offload providers and
consumers.

SPI offloading is a feature that allows the SPI controller to perform
transfers without any CPU intervention. This is useful, e.g. for
high-speed data acquisition.

SPI controllers with offload support need to implement the get_offload
and put_offload callbacks and can use the devm_spi_offload_alloc() to
allocate offload instances.

SPI peripheral drivers will call devm_spi_offload_get() to get a
reference to the matching offload instance. This offload instance can
then be attached to a SPI message to request offloading that message.

It is expected that SPI controllers with offload support will check for
the offload instance in the SPI message in the ctlr->optimize_message()
callback and handle it accordingly.

CONFIG_SPI_OFFLOAD is intended to be a select-only option. Both
consumer and provider drivers should `select SPI_OFFLOAD` in their
Kconfig to ensure that the SPI core is built with offload support.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes:
* Don't include linux/property.h (moved to later patch).
* Only allocate single offload instance instead of array.
* Allocate *priv separately to avoid alignment issues.
* Add put_offload() callback instead of assuming devm semantics.
* Drop struct spi_offload::spi. It was only being used as a flag.
* Don't get/put struct spi_offload::provider_dev.
* Add MAINTAINERS entry for me as reviewer for anything related to
  SPI offload.

v4 changes:
* SPI offload functions moved to a separate file instead of spi.c
  (spi.c is already too long).
* struct spi_offload and devm_spi_offload_get() are back, similar to
  but improved over v1. This avoids having to pass the function ID
  string to every function call and re-lookup the offload instance.
* offload message prepare/unprepare functions are removed. Instead the
  existing optimize/unoptimize functions should be used. Setting
  spi_message::offload pointer is used as a flag to differentiate
  between an offloaded message and a regular message.

v3 changes:
* Minor changes to doc comments.
* Changed to use phandle array for spi-offloads.
* Changed id to string to make use of spi-offload-names.

v2 changes:
* This is a rework of "spi: add core support for controllers with offload
  capabilities" from v1.
* The spi_offload_get() function that Nuno didn't like is gone. Instead,
  there is now a mapping callback that uses the new generic devicetree
  binding to request resources automatically when a SPI device is probed.
* The spi_offload_enable/disable() functions for dealing with hardware
  triggers are deferred to a separate patch.
* This leaves adding spi_offload_prepare/unprepare() which have been
  reworked to be a bit more robust.
---
 MAINTAINERS                     |   6 +++
 drivers/spi/Kconfig             |   3 ++
 drivers/spi/Makefile            |   1 +
 drivers/spi/spi-offload.c       | 103 ++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-offload.h |  60 +++++++++++++++++++++++
 include/linux/spi/spi.h         |  18 +++++++
 6 files changed, 191 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bcc42036d635..75c8ca9a8584 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22019,6 +22019,12 @@ F:	Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
 F:	drivers/mtd/spi-nor/
 F:	include/linux/mtd/spi-nor.h
 
+SPI OFFLOAD
+R:	David Lechner <dlechner@baylibre.com>
+F:	drivers/spi/spi-offload.c
+F:	include/linux/spi/spi-offload.h
+K:	spi_offload
+
 SPI SUBSYSTEM
 M:	Mark Brown <broonie@kernel.org>
 L:	linux-spi@vger.kernel.org
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index f51f9466e518..cdc483b0ec5c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -55,6 +55,9 @@ config SPI_MEM
 	  This extension is meant to simplify interaction with SPI memories
 	  by providing a high-level interface to send memory-like commands.
 
+config SPI_OFFLOAD
+	bool
+
 comment "SPI Master Controller Drivers"
 
 config SPI_AIROHA_SNFI
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index aea5e54de195..39025ae5364d 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -10,6 +10,7 @@ ccflags-$(CONFIG_SPI_DEBUG) := -DDEBUG
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 obj-$(CONFIG_SPI_MEM)			+= spi-mem.o
 obj-$(CONFIG_SPI_MUX)			+= spi-mux.o
+obj-$(CONFIG_SPI_OFFLOAD)		+= spi-offload.o
 obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 
diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
new file mode 100644
index 000000000000..5ded7aecf9fc
--- /dev/null
+++ b/drivers/spi/spi-offload.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Analog Devices Inc.
+ * Copyright (C) 2024 BayLibre, SAS
+ */
+
+#define DEFAULT_SYMBOL_NAMESPACE SPI_OFFLOAD
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/mutex.h>
+#include <linux/spi/spi-offload.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+struct spi_controller_and_offload {
+	struct spi_controller *controller;
+	struct spi_offload *offload;
+};
+
+/**
+ * devm_spi_offload_alloc() - Allocate offload instance
+ * @dev: Device for devm purposes and assigned to &struct spi_offload.provider_dev
+ * @priv_size: Size of private data to allocate
+ *
+ * Offload providers should use this to allocate offload instances.
+ *
+ * Return: Pointer to new offload instance or error on failure.
+ */
+struct spi_offload *devm_spi_offload_alloc(struct device *dev,
+					   size_t priv_size)
+{
+	struct spi_offload *offload;
+	void *priv;
+
+	offload = devm_kzalloc(dev, sizeof(*offload), GFP_KERNEL);
+	if (!offload)
+		return ERR_PTR(-ENOMEM);
+
+	priv = devm_kzalloc(dev, priv_size, GFP_KERNEL);
+	if (!priv)
+		return ERR_PTR(-ENOMEM);
+
+	offload->provider_dev = dev;
+	offload->priv = priv;
+
+	return offload;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_alloc);
+
+static void spi_offload_put(void *data)
+{
+	struct spi_controller_and_offload *resource = data;
+
+	resource->controller->put_offload(resource->offload);
+	kfree(resource);
+}
+
+/**
+ * devm_spi_offload_get() - Get an offload instance
+ * @dev: Device for devm purposes
+ * @spi: SPI device to use for the transfers
+ * @config: Offload configuration
+ *
+ * Peripheral drivers call this function to get an offload instance that meets
+ * the requirements specified in @config. If no suitable offload instance is
+ * available, -ENODEV is returned.
+ *
+ * Return: Offload instance or error on failure.
+ */
+struct spi_offload *devm_spi_offload_get(struct device *dev,
+					 struct spi_device *spi,
+					 const struct spi_offload_config *config)
+{
+	struct spi_controller_and_offload *resource;
+	int ret;
+
+	if (!spi || !config)
+		return ERR_PTR(-EINVAL);
+
+	if (!spi->controller->get_offload)
+		return ERR_PTR(-ENODEV);
+
+	resource = kzalloc(sizeof(*resource), GFP_KERNEL);
+	if (!resource)
+		return ERR_PTR(-ENOMEM);
+
+	resource->controller = spi->controller;
+	resource->offload = spi->controller->get_offload(spi, config);
+	ret = PTR_ERR_OR_ZERO(resource->offload);
+	if (ret) {
+		kfree(resource);
+		return ERR_PTR(ret);
+	}
+
+	ret = devm_add_action_or_reset(dev, spi_offload_put, resource);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return resource->offload;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_get);
diff --git a/include/linux/spi/spi-offload.h b/include/linux/spi/spi-offload.h
new file mode 100644
index 000000000000..81b115fc89bf
--- /dev/null
+++ b/include/linux/spi/spi-offload.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Analog Devices Inc.
+ * Copyright (C) 2024 BayLibre, SAS
+ */
+
+/*
+ * SPI Offloading support.
+ *
+ * Some SPI controllers support offloading of SPI transfers. Essentially, this
+ * is the ability for a SPI controller to perform SPI transfers with minimal
+ * or even no CPU intervention, e.g. via a specialized SPI controller with a
+ * hardware trigger or via a conventional SPI controller using a non-Linux MCU
+ * processor core to offload the work.
+ */
+
+#ifndef __LINUX_SPI_OFFLOAD_H
+#define __LINUX_SPI_OFFLOAD_H
+
+#include <linux/types.h>
+
+MODULE_IMPORT_NS(SPI_OFFLOAD);
+
+struct device;
+struct spi_device;
+
+/* Offload can be triggered by external hardware event. */
+#define SPI_OFFLOAD_CAP_TRIGGER			BIT(0)
+/* Offload can record and then play back TX data when triggered. */
+#define SPI_OFFLOAD_CAP_TX_STATIC_DATA		BIT(1)
+/* Offload can get TX data from an external stream source. */
+#define SPI_OFFLOAD_CAP_TX_STREAM_DMA		BIT(2)
+/* Offload can send RX data to an external stream sink. */
+#define SPI_OFFLOAD_CAP_RX_STREAM_DMA		BIT(3)
+
+/**
+ * struct spi_offload_config - offload configuration
+ *
+ * This is used to request an offload with specific configuration.
+ */
+struct spi_offload_config {
+	/** @capability_flags: required capabilities. See %SPI_OFFLOAD_CAP_* */
+	u32 capability_flags;
+};
+
+/**
+ * struct spi_offload - offload instance
+ */
+struct spi_offload {
+	/** @provider_dev: for get/put reference counting */
+	struct device *provider_dev;
+	/** @priv: provider driver private data */
+	void *priv;
+};
+
+struct spi_offload *devm_spi_offload_alloc(struct device *dev, size_t priv_size);
+struct spi_offload *devm_spi_offload_get(struct device *dev, struct spi_device *spi,
+					 const struct spi_offload_config *config);
+
+#endif /* __LINUX_SPI_OFFLOAD_H */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8497f4747e24..c2b24a0909ea 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -31,6 +31,9 @@ struct spi_transfer;
 struct spi_controller_mem_ops;
 struct spi_controller_mem_caps;
 struct spi_message;
+struct spi_controller_offload_ops;
+struct spi_offload;
+struct spi_offload_config;
 
 /*
  * INTERFACES between SPI master-side drivers and SPI slave protocol handlers,
@@ -496,6 +499,10 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @mem_ops: optimized/dedicated operations for interactions with SPI memory.
  *	     This field is optional and should only be implemented if the
  *	     controller has native support for memory like operations.
+ * @get_offload: callback for controllers with offload support to get matching
+ *	offload instance. Implementations should return -ENODEV if no match is
+ *	found.
+ * @put_offload: release the offload instance acquired by @get_offload.
  * @mem_caps: controller capabilities for the handling of memory operations.
  * @unprepare_message: undo any work done by prepare_message().
  * @target_abort: abort the ongoing transfer request on an SPI target controller
@@ -740,6 +747,10 @@ struct spi_controller {
 	const struct spi_controller_mem_ops *mem_ops;
 	const struct spi_controller_mem_caps *mem_caps;
 
+	struct spi_offload *(*get_offload)(struct spi_device *spi,
+					   const struct spi_offload_config *config);
+	void (*put_offload)(struct spi_offload *offload);
+
 	/* GPIO chip select */
 	struct gpio_desc	**cs_gpiods;
 	bool			use_gpio_descriptors;
@@ -1108,6 +1119,7 @@ struct spi_transfer {
  * @state: for use by whichever driver currently owns the message
  * @opt_state: for use by whichever driver currently owns the message
  * @resources: for resource management when the SPI message is processed
+ * @offload: (optional) offload instance used by this message
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
@@ -1168,6 +1180,12 @@ struct spi_message {
 	 */
 	void			*opt_state;
 
+	/*
+	 * Optional offload instance used by this message. This must be set
+	 * by the peripheral driver before calling spi_optimize_message().
+	 */
+	struct spi_offload	*offload;
+
 	/* List of spi_res resources when the SPI message is processed */
 	struct list_head        resources;
 };

-- 
2.43.0


