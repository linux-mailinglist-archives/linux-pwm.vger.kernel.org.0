Return-Path: <linux-pwm+bounces-3778-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3799AD5F0
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 22:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8588C1F227F0
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 20:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774F61F891E;
	Wed, 23 Oct 2024 20:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zR+XJDM1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D7A1E7C10
	for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 20:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717164; cv=none; b=C6if471qDcusCi6whYRxbOM3I52VFasDG283dm3I5xIzEHYaFhH8NTcG8QpNoek7gWAWRdoCitIgHmO7uCC93PhcgdoaYO5vZM2Rl76GO5qIzlFOkz2fRAxEyLtt/negPLVeDIWQ7ERzoGCkj9UQISPqsier1ZpxRD2dAbvsZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717164; c=relaxed/simple;
	bh=HKTElFd7OXujlNdM4D8yqgrjJL9W/OPjIGHrOikRQG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GZLgOlqTuIlm7dCKWXOF0n2mXrf0cmzAbUXp4yYxqG6ZErUQK2asUr5jFQo9gnD4JViGp4iVLfGtEHnS8guhO8umACLQ2rvGZAZ8bltejHH+FapmJLfNIAewFRSPDSYE+9pRaKTNIsFYQtF6xy9UYjqz1zOGAfgC+bq9Of6gqwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zR+XJDM1; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5e5568f1b6eso112651eaf.1
        for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 13:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717161; x=1730321961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXqLesX8rnPnZthafDRHkFzQvyeLIHy3ztKqxTjOUDs=;
        b=zR+XJDM1aD0zPf4lTxzOO+KnIPu28dGhi6yxt3hwhQTm/SVfCJTrVoIi+6VEXaukFe
         2bt7cFuwmPIFnWAZee7mCrkPQmZlf9ZSzSfeLSk25CRpAXSMABW8A6dU2SuAVg96sx0h
         9cumBLcBcZhMqAazbE/sNmIkqOlAYcyfrdMyipppu2kA/bFVsinJpsROf2iXF/kv9L2H
         77KxgQ8xLPMCd7uEYTuoDDBfzZS5tDoHNSevE5gn+lGkWIBLOzthroRXtEFVG7cvSpDl
         UAZVsha4ASZX3A9jjBBQ2GangIMUyWvDI1oKBn/In4H8gdZQA41PM2YnETrjin2A+8dk
         N/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717161; x=1730321961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXqLesX8rnPnZthafDRHkFzQvyeLIHy3ztKqxTjOUDs=;
        b=Ln03iN9hyJoiXhIB/trkytQDsq8yCuoZmsItWg/K/s2+aeT9P6zywWIzRGw74liFaZ
         FuNGzO9PaDn9sPJwc8I8ipU6GKY2FUxMQj/Qz/DR8UNMudZUd/31jDp9KHypg28ymUhg
         WlLpjwAIyuIzbjGZaoS6m5wfJNa0trTzwh23wQw+OYU/U3mmAPH8569V4f6e2EVG01uX
         PT2QNfQAryxVC0f5v3dlubedBmMl5h/Flev81RaVSy4JsA7pHxEJNktN25grZi59PCSc
         dYhK7V5jeyXMRTOfCUGIEAyqYH0U8H4FLdrp5uwPCG9SO/vitn3EGzY+rUY29TEZm3+c
         4X+A==
X-Forwarded-Encrypted: i=1; AJvYcCXFFvhMCuCXqJWTTixt9hx9F0zLwCAx9fzs5mtZxIg21chj/Z84yPBvw7wE62uRKl7f6Hk3TuZ3RRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOZzsQidwusUqRyOjTDQGkDViTCdbFWMRX4uQJIcj7YA+mHIw
	yslgka2LVMacEIMDx4MJG7QGbYsqgE/8IL/4aPyxFulEYuBTYFffqa2ij+7yRKw=
X-Google-Smtp-Source: AGHT+IHAy/NA0bFNSLRqnV7yJBc3WmP+MzRNe6q3hvfdyUYztm7KyWhryeO4CowXGGIIBPOMMON0Tg==
X-Received: by 2002:a05:6820:260d:b0:5eb:b292:bb85 with SMTP id 006d021491bc7-5ebee8e315dmr2260773eaf.6.1729717161294;
        Wed, 23 Oct 2024 13:59:21 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:20 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:09 -0500
Subject: [PATCH RFC v4 02/15] spi: add basic support for SPI offloading
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-2-f8125b99f5a1@baylibre.com>
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

Add the basic infrastructure to support SPI offload providers and
consumers.

SPI offloading is a feature that allows the SPI controller to perform
transfers without any CPU intervention. This is useful, e.g. for
high-speed data acquisition.

SPI controllers with offload support need to implement the get_offload
callback and can use the devm_spi_offload_alloc() to allocate offload
instances.

SPI peripheral drivers will call devm_spi_offload_get() to get a
reference to the matching offload instance. This offload instance can
then be attached to a SPI message to request offloading that message.

It is expected that SPI controllers with offload support will check for
the offload instance in the SPI message in the optimize_message()
callback and handle it accordingly.

CONFIG_SPI_OFFLOAD is intended to be a select-only option. Both
consumer and provider drivers should `select SPI_OFFLOAD` in their
Kconfig to ensure that the SPI core is built with offload support.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

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
 drivers/spi/Kconfig             |   3 ++
 drivers/spi/Makefile            |   1 +
 drivers/spi/spi-offload.c       | 104 ++++++++++++++++++++++++++++++++++++++++
 include/linux/spi/spi-offload.h |  64 +++++++++++++++++++++++++
 include/linux/spi/spi.h         |  16 +++++++
 5 files changed, 188 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 823797217404..d65074b85f62 100644
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
index a9b1bc259b68..6a470eb475a2 100644
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
index 000000000000..c344cbf50bdb
--- /dev/null
+++ b/drivers/spi/spi-offload.c
@@ -0,0 +1,104 @@
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
+#include <linux/property.h>
+#include <linux/spi/spi-offload.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+/**
+ * devm_spi_offload_alloc() - Allocate offload instances
+ * @dev: Device for devm purposes
+ * @num_offloads: Number of offloads to allocate
+ * @priv_size: Size of private data to allocate for each offload
+ *
+ * Offload providers should use this to allocate offload instances.
+ *
+ * Return: Pointer to array of offloads or error on failure.
+ */
+struct spi_offload *devm_spi_offload_alloc(struct device *dev,
+					   size_t num_offloads,
+					   size_t priv_size)
+{
+	struct spi_offload *offloads;
+	void *privs;
+	size_t i;
+
+	offloads = devm_kcalloc(dev, num_offloads, sizeof(*offloads) + priv_size,
+				GFP_KERNEL);
+	if (!offloads)
+		return ERR_PTR(-ENOMEM);
+
+	privs = (void *)(offloads + num_offloads);
+
+	for (i = 0; i < num_offloads; i++) {
+		struct spi_offload *offload = offloads + i;
+		void *priv = privs + i * priv_size;
+
+		offload->provider_dev = dev;
+		offload->priv = priv;
+	}
+
+	return offloads;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_alloc);
+
+static void spi_offload_put(void *data)
+{
+	struct spi_offload *offload = data;
+
+	offload->spi = NULL;
+	put_device(offload->provider_dev);
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
+	struct spi_offload *offload;
+	int ret;
+
+	if (!spi || !config)
+		return ERR_PTR(-EINVAL);
+
+	if (!spi->controller->get_offload)
+		return ERR_PTR(-ENODEV);
+
+	offload = spi->controller->get_offload(spi, config);
+	if (IS_ERR(offload))
+		return offload;
+
+	if (offload->spi)
+		return ERR_PTR(-EBUSY);
+
+	offload->spi = spi;
+	get_device(offload->provider_dev);
+
+	ret = devm_add_action_or_reset(dev, spi_offload_put, offload);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return offload;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_get);
diff --git a/include/linux/spi/spi-offload.h b/include/linux/spi/spi-offload.h
new file mode 100644
index 000000000000..92a557533b83
--- /dev/null
+++ b/include/linux/spi/spi-offload.h
@@ -0,0 +1,64 @@
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
+	/** @spi: SPI device that is currently using the offload */
+	struct spi_device *spi;
+	/** @priv: provider driver private data */
+	void *priv;
+};
+
+struct spi_offload *devm_spi_offload_alloc(struct device *dev,
+					   size_t num_offloads,
+					   size_t priv_size);
+struct spi_offload *devm_spi_offload_get(struct device *dev, struct spi_device *spi,
+					 const struct spi_offload_config *config);
+
+#endif /* __LINUX_SPI_OFFLOAD_H */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8497f4747e24..c230d6a209ee 100644
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
@@ -496,6 +499,9 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
  * @mem_ops: optimized/dedicated operations for interactions with SPI memory.
  *	     This field is optional and should only be implemented if the
  *	     controller has native support for memory like operations.
+ * @get_offload: callback for controllers with offload support to get matching
+ *	offload instance. Implementations should return -ENODEV if no match is
+ *	found.
  * @mem_caps: controller capabilities for the handling of memory operations.
  * @unprepare_message: undo any work done by prepare_message().
  * @target_abort: abort the ongoing transfer request on an SPI target controller
@@ -740,6 +746,9 @@ struct spi_controller {
 	const struct spi_controller_mem_ops *mem_ops;
 	const struct spi_controller_mem_caps *mem_caps;
 
+	struct spi_offload *(*get_offload)(struct spi_device *spi,
+					   const struct spi_offload_config *config);
+
 	/* GPIO chip select */
 	struct gpio_desc	**cs_gpiods;
 	bool			use_gpio_descriptors;
@@ -1108,6 +1117,7 @@ struct spi_transfer {
  * @state: for use by whichever driver currently owns the message
  * @opt_state: for use by whichever driver currently owns the message
  * @resources: for resource management when the SPI message is processed
+ * @offload: (optional) offload instance used by this message
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
@@ -1168,6 +1178,12 @@ struct spi_message {
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


