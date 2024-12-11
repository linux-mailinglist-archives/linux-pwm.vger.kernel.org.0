Return-Path: <linux-pwm+bounces-4314-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45D89ED78D
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2024 21:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFAEB18833A6
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2024 20:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D8F2288F8;
	Wed, 11 Dec 2024 20:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t4W4CT+W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B2E22689C
	for <linux-pwm@vger.kernel.org>; Wed, 11 Dec 2024 20:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950500; cv=none; b=HE8whHRwY/zdDFnnMOn7RnocDwPK6WWdDAX5OXleETZKvVcHKqYJQx+wsb1rzqttSW7ZRTAMypbORHSIg/cPQrwyl3sikKah44K5njZ6bUs9O/BiXgtNcLHeiCDPAA0EBsKxmM3rxRNZM3fw63MA7Ob+Q+0RZ1LPHYehw6/KCdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950500; c=relaxed/simple;
	bh=RGggUajwKcxwMBqnwmDZ76Eu+OfENqU99nf0uDpoQRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oHFqwNkTc5sYB1gJzu9/u7F5xzAU99hAsw5yggo85BuBCV7mY7TYZ0VgRVzlpWr7kRBF0SZGsh6okMEDXLfnn7vlghnsn3/6Gng1XbgGrdS09EsORuCb9qzEj39Q7Hxpu+a5fvhwa4x9izz2i6iNWVOdtBY6iicp/Ya3u7w185k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t4W4CT+W; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f2e370bb3aso200127eaf.0
        for <linux-pwm@vger.kernel.org>; Wed, 11 Dec 2024 12:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950497; x=1734555297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ffc3LxMkAvRH+svHl43EnhBnXUPIwZq2nOCjPB5PSI=;
        b=t4W4CT+WaFUICIFPy9VoOBAfzBVgHz8ww/CDhMDHqjy1ZVxq8ukEjYeweTgPl5ioyg
         lgexYO2GBpzXrzhNPZ34NGBDEuTOMFzk5eQu+bpHdurTIlBYlYTO8zM+OH7TJZbRmS4N
         5cHBa/YvQoDYJkV8BUOrmrTLHJoLNxtlXpiUQ+Sq4sDnwWYcIF2GGK/2QHhuB0oy7baS
         vvd624yUoRzu3prnU75f1saGZoC7NvtSh5I0iXbPZ9gQFNxpQ0kdcg0hXNPPI/JFHX10
         F7cC6Edets41PNObY2p4y3CMMzk9SwfDowf6+Vq7nHwPmAfRdd/Bg3pJGMe9lNedrTRd
         5DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950497; x=1734555297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ffc3LxMkAvRH+svHl43EnhBnXUPIwZq2nOCjPB5PSI=;
        b=vq6qvwgIVxyjx1Dvsqpe09JRVWb63E5i0Z7CcMMj7I7EDlzyb7AGLOsRgLzMD8K4K0
         FaxWm0Qvagpxwve4T0rvXTAjgCeVgjSwl9JOfLZYnFJCfL9ySn5pYnjWxUTmR3Cvt190
         8cX5McyZ+BAV0559tDVAxiflE+6VAH0yl2I3afNZvoMgCgJlJZu2KM7NPEPOQ2OrgBo/
         2E2aH+lizsfxWG0+a27JvAjKfeN0UJQ0geKcRKUV3Eken4N/PNlCy+ktURvSCltCn65G
         FPadxh78MPEue3rNoosFfWRtZa+z9Ic/bKyE9d6Y59PLDJu+rHEkXZEDgLvsY6GzgnbQ
         KcdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1f75zlOu1rOoRxBKlvp76BxkiS4VlPQZj+VybN3RS28upncKb78ZJQe/zQ6GV0X5R8mVZQTCwB3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcURanHGg/huaSLVUQVnOD1gqFudbufEVIOjRo+Gtmydc0v9mu
	HDI+RpJMLyDfgTN4MiHDJ2vLKW1poA8yxrWSMrTT8W29gpXgOb+CwkwSgXGPE0U=
X-Gm-Gg: ASbGncsAa3O8cchlUOrE7LRdNe1kRXj6T6edcSvmNhvlYaAVylg+C0Su9HHb83oKiAX
	pD+KC2fJ95zYKMlyPvQtK7Crf9yQ7xO9/2E2y5iPy7N/c9jGRpmrdkDWOM2LF5+6r7r4ipygU7b
	uvxSIE5k6t1liTn9xhN1B8gz82YIf00oqk8/gNPhu59u6M9bqD5qMNGqtjpRcCwHbLTlASuln1d
	7T5iL63D3gXfAFnNE3ka/ew9vApzbTooY/E8yADcbYD2IdwvhvvEgHLzUez3bgTKvUc/4C6S6H1
	nzbhZtr30w==
X-Google-Smtp-Source: AGHT+IG7inO0xnuwDZeUqSYTrfiBKUGM+ravvukMEKOFTzNGsJgAfy6fOUDwdyEAKDaxSFKj91kwLA==
X-Received: by 2002:a05:6820:1989:b0:5f1:e3d1:b994 with SMTP id 006d021491bc7-5f2ef873a5emr610173eaf.0.1733950496838;
        Wed, 11 Dec 2024 12:54:56 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:54:55 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Dec 2024 14:54:38 -0600
Subject: [PATCH v6 01/17] spi: add basic support for SPI offloading
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-1-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes:
* Drop use of PTR_ERR_OR_ZERO().
* Split header into types.h/provider.h/consumer.h.
* Remove unused spi_controller_offload_ops forward declaration.

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
 MAINTAINERS                          |   6 ++
 drivers/spi/Kconfig                  |   3 +
 drivers/spi/Makefile                 |   1 +
 drivers/spi/spi-offload.c            | 114 +++++++++++++++++++++++++++++++++++
 include/linux/spi/offload/consumer.h |  22 +++++++
 include/linux/spi/offload/provider.h |  19 ++++++
 include/linux/spi/offload/types.h    |  43 +++++++++++++
 include/linux/spi/spi.h              |  17 ++++++
 8 files changed, 225 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf2dcd4e0261785add520b5eac747ceac523e112..9284a257607a740ab7f6fd960c2bcdc34ead7586 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22129,6 +22129,12 @@ F:	Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
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
index ea8a310329274bb2701e265cd152a56fb4e0f3a7..02064a4e292815ec0213e2e446b4f90ed8855a52 100644
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
index 9db7554c1864bf9b37dcf59c16eb76f5af03a7e8..bb5fc20df21332232533c2e70c0cc230f6bcf27f 100644
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
index 0000000000000000000000000000000000000000..3a40ef30debf09c6fd7b2c14526f3e5976e2b21f
--- /dev/null
+++ b/drivers/spi/spi-offload.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+#define DEFAULT_SYMBOL_NAMESPACE "SPI_OFFLOAD"
+
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/mutex.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/provider.h>
+#include <linux/spi/offload/types.h>
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
+	if (IS_ERR(resource->offload)) {
+		kfree(resource);
+		return resource->offload;
+	}
+
+	ret = devm_add_action_or_reset(dev, spi_offload_put, resource);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return resource->offload;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_get);
diff --git a/include/linux/spi/offload/consumer.h b/include/linux/spi/offload/consumer.h
new file mode 100644
index 0000000000000000000000000000000000000000..05543dbedf3086fb4befcd149cff3c8c70a88825
--- /dev/null
+++ b/include/linux/spi/offload/consumer.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Analog Devices Inc.
+ * Copyright (C) 2024 BayLibre, SAS
+ */
+
+#ifndef __LINUX_SPI_OFFLOAD_CONSUMER_H
+#define __LINUX_SPI_OFFLOAD_CONSUMER_H
+
+#include <linux/module.h>
+#include <linux/spi/offload/types.h>
+#include <linux/types.h>
+
+MODULE_IMPORT_NS("SPI_OFFLOAD");
+
+struct device;
+struct spi_device;
+
+struct spi_offload *devm_spi_offload_get(struct device *dev, struct spi_device *spi,
+					 const struct spi_offload_config *config);
+
+#endif /* __LINUX_SPI_OFFLOAD_CONSUMER_H */
diff --git a/include/linux/spi/offload/provider.h b/include/linux/spi/offload/provider.h
new file mode 100644
index 0000000000000000000000000000000000000000..278c4edfcdb7b1f43870ca99d2ba252bf2820576
--- /dev/null
+++ b/include/linux/spi/offload/provider.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Analog Devices Inc.
+ * Copyright (C) 2024 BayLibre, SAS
+ */
+
+#ifndef __LINUX_SPI_OFFLOAD_PROVIDER_H
+#define __LINUX_SPI_OFFLOAD_PROVIDER_H
+
+#include <linux/module.h>
+#include <linux/types.h>
+
+MODULE_IMPORT_NS("SPI_OFFLOAD");
+
+struct device;
+
+struct spi_offload *devm_spi_offload_alloc(struct device *dev, size_t priv_size);
+
+#endif /* __LINUX_SPI_OFFLOAD_PROVIDER_H */
diff --git a/include/linux/spi/offload/types.h b/include/linux/spi/offload/types.h
new file mode 100644
index 0000000000000000000000000000000000000000..a74f8d84541b10062353e81a638f05628b696394
--- /dev/null
+++ b/include/linux/spi/offload/types.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Analog Devices Inc.
+ * Copyright (C) 2024 BayLibre, SAS
+ */
+
+#ifndef __LINUX_SPI_OFFLOAD_TYPES_H
+#define __LINUX_SPI_OFFLOAD_TYPES_H
+
+#include <linux/types.h>
+
+struct device;
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
+#endif /* __LINUX_SPI_OFFLOAD_TYPES_H */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 8497f4747e24d4ecd85b74f49609ac1c82c73535..98bdc8c16c20521c0a94e5f72f5e71c4f6d7d11e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -31,6 +31,8 @@ struct spi_transfer;
 struct spi_controller_mem_ops;
 struct spi_controller_mem_caps;
 struct spi_message;
+struct spi_offload;
+struct spi_offload_config;
 
 /*
  * INTERFACES between SPI master-side drivers and SPI slave protocol handlers,
@@ -496,6 +498,10 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
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
@@ -740,6 +746,10 @@ struct spi_controller {
 	const struct spi_controller_mem_ops *mem_ops;
 	const struct spi_controller_mem_caps *mem_caps;
 
+	struct spi_offload *(*get_offload)(struct spi_device *spi,
+					   const struct spi_offload_config *config);
+	void (*put_offload)(struct spi_offload *offload);
+
 	/* GPIO chip select */
 	struct gpio_desc	**cs_gpiods;
 	bool			use_gpio_descriptors;
@@ -1108,6 +1118,7 @@ struct spi_transfer {
  * @state: for use by whichever driver currently owns the message
  * @opt_state: for use by whichever driver currently owns the message
  * @resources: for resource management when the SPI message is processed
+ * @offload: (optional) offload instance used by this message
  *
  * A @spi_message is used to execute an atomic sequence of data transfers,
  * each represented by a struct spi_transfer.  The sequence is "atomic"
@@ -1168,6 +1179,12 @@ struct spi_message {
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


