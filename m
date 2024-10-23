Return-Path: <linux-pwm+bounces-3785-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534F39AD615
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 23:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712AF1C22714
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 21:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBE8200B9C;
	Wed, 23 Oct 2024 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vd2vMYiS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF552003BE
	for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717185; cv=none; b=X+N9BcYhmbpv+xumekbfjgP6BOLDccURBnIx4OKVejJJeNFY2yV1AWlDnlbh3SSSd5Zn4ClLJcVZqhhIQEnsgl2pL9b3RVsRMx65YUnB5r54Px4M0jQ87NvXeMli6krcxTTGMsjY6dPMNPFS51NK065EadPvFr/gj4JOnJceIik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717185; c=relaxed/simple;
	bh=0tN20Qo7iZmMxrMubM9JRyuw2sf4MH8ve9wlkVNucLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QhlcLHE3iuIP12GLFYhDgf7R1QQ7XycSkiXPm9rBUfZV4NnHAxYVE2XN/UbrsqLD9KPzm1hjHerE4QTQu69mkn3nxFwJ/OC8KkO6iMmqIswVcy87k0vrRGegL+VbF5SVEbdqeQ++DvIkALKAI7TI3+vkAWMzHAcN/VCsYckatoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vd2vMYiS; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc5b4190eso94455eaf.3
        for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 13:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717183; x=1730321983; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1jZtRWuGDZc3p8oqIaTkwjGWETdlg6Xkaw+OwlJ3/g=;
        b=vd2vMYiSjLwJgbCjGcJxb4Hi3969snHHseCts37Dit8sok8yAsCRSXxSrRJKibey7K
         /XsruxjbcyriVcJSZW3+GgWqBgQX/8FiecUPQVuQkanpYLCRxobvoMhEMkvkAltjWeFR
         JKURh9ObHNdbRTXZuHOCtTFgwMKffan7/MfBuy3SASTO9KZCrI5da3yDu1o7uJS9vUqr
         VDtRhUybl0OH2ll/6XqkA84zG8XzCWDzbarHXXck68faw8k3eVC09DiShYYYVJ1LajZd
         KLYLntkOBWZ2rhTgH4177Nj8kKQpTv07cXyf/L0PJtxDHyREHsSHWvuONPwM1zblyMjg
         pf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717183; x=1730321983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1jZtRWuGDZc3p8oqIaTkwjGWETdlg6Xkaw+OwlJ3/g=;
        b=exX9ZozvH/Agmi5gxysiy1mA1+WAfjHiFGIEiH9kXwh6GLmRB2GIQyYIVQwR5/D7mz
         R21GzI7wlX41OrcjamJ1/273Z1YhHQE4YMId5i8FEvaBXU7qKpYbA8fOM8lMQ+2uqK13
         A3yG9vAP548q3sfvCdIIsu+1uLCQyevF8v8bMIQYOqvPWOXg9NfnMW0BMBOOjEZms0Hp
         aRxhbpf1KCjKU+0+s3wdsiBVGVXNCOF2xWLkCqHMesx8ZPqb53EGvHo2pg/G7wlpc/DN
         nbGekmam0jJEmuNtEn6SpfFFFkyRbGTcCtktcqWbwRo6xwR24Q9+xYII3PVea/eH4DPo
         sRhw==
X-Forwarded-Encrypted: i=1; AJvYcCXuhwWwY8ozFNzjEsN4p72qxD+/lzc/wzN/g871pZxErr7MiPePSBGbHswm83EiddFg0tPfmHVjkPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCcWbIlmlMoIVm1DNaAp82hmRzITfi9BLYpAvIjLE7C6JLWFrh
	+21Jbr2O/2vGR4LGtzSNT92ImHerZ52LvsT2MXs+gX5cChjSgsmJYZsM4Y7ZMG8=
X-Google-Smtp-Source: AGHT+IF8x+aD99RxFMh3FeGHpY5loia0nZ0+Sh4mFEUePMnHFDpbdmLf52YsmuvOEnKoXKJ1PAjaEw==
X-Received: by 2002:a05:6820:1628:b0:5eb:c72e:e29b with SMTP id 006d021491bc7-5ebee96e015mr2912369eaf.7.1729717182998;
        Wed, 23 Oct 2024 13:59:42 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:16 -0500
Subject: [PATCH RFC v4 09/15] spi: axi-spi-engine: implement offload
 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-9-f8125b99f5a1@baylibre.com>
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

Implement SPI offload support for the AXI SPI Engine. Currently, the
hardware only supports triggering offload transfers with a hardware
trigger so attempting to use an offload message in the regular SPI
message queue will fail. Also, only allows streaming rx data to an
external sink, so attempts to use a rx_buf in the offload message will
fail.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes:
* Adapted to changes in other patches in the series.
* Moved trigger enable/disable to same function as offload
  enable/disable.

v3 changes:
* Added clk and dma_chan getter callbacks.
* Fixed some bugs.

v2 changes:

This patch has been reworked to accommodate the changes described in all
of the other patches.
---
 drivers/spi/Kconfig              |   1 +
 drivers/spi/spi-axi-spi-engine.c | 273 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 268 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 50d04fa317b7..af3143ec5245 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -168,6 +168,7 @@ config SPI_AU1550
 config SPI_AXI_SPI_ENGINE
 	tristate "Analog Devices AXI SPI Engine controller"
 	depends on HAS_IOMEM
+	select SPI_OFFLOAD
 	help
 	  This enables support for the Analog Devices AXI SPI Engine SPI controller.
 	  It is part of the SPI Engine framework that is used in some Analog Devices
diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 2d24d762b5bd..1710847d81a1 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -2,11 +2,14 @@
 /*
  * SPI-Engine SPI controller driver
  * Copyright 2015 Analog Devices Inc.
+ * Copyright 2024 BayLibre, SAS
  *  Author: Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
+#include <linux/dmaengine.h>
 #include <linux/fpga/adi-axi-common.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -14,8 +17,10 @@
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/platform_device.h>
+#include <linux/spi/spi-offload.h>
 #include <linux/spi/spi.h>
 
+#define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
 #define SPI_ENGINE_REG_RESET			0x40
 
 #define SPI_ENGINE_REG_INT_ENABLE		0x80
@@ -23,6 +28,7 @@
 #define SPI_ENGINE_REG_INT_SOURCE		0x88
 
 #define SPI_ENGINE_REG_SYNC_ID			0xc0
+#define SPI_ENGINE_REG_OFFLOAD_SYNC_ID		0xc4
 
 #define SPI_ENGINE_REG_CMD_FIFO_ROOM		0xd0
 #define SPI_ENGINE_REG_SDO_FIFO_ROOM		0xd4
@@ -33,10 +39,24 @@
 #define SPI_ENGINE_REG_SDI_DATA_FIFO		0xe8
 #define SPI_ENGINE_REG_SDI_DATA_FIFO_PEEK	0xec
 
+#define SPI_ENGINE_MAX_NUM_OFFLOADS		32
+
+#define SPI_ENGINE_REG_OFFLOAD_CTRL(x)		(0x100 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
+#define SPI_ENGINE_REG_OFFLOAD_STATUS(x)	(0x104 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
+#define SPI_ENGINE_REG_OFFLOAD_RESET(x)		(0x108 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
+#define SPI_ENGINE_REG_OFFLOAD_CMD_FIFO(x)	(0x110 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
+#define SPI_ENGINE_REG_OFFLOAD_SDO_FIFO(x)	(0x114 + SPI_ENGINE_MAX_NUM_OFFLOADS * (x))
+
+#define SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_SDO	GENMASK(15, 8)
+#define SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_CMD	GENMASK(7, 0)
+
 #define SPI_ENGINE_INT_CMD_ALMOST_EMPTY		BIT(0)
 #define SPI_ENGINE_INT_SDO_ALMOST_EMPTY		BIT(1)
 #define SPI_ENGINE_INT_SDI_ALMOST_FULL		BIT(2)
 #define SPI_ENGINE_INT_SYNC			BIT(3)
+#define SPI_ENGINE_INT_OFFLOAD_SYNC		BIT(4)
+
+#define SPI_ENGINE_OFFLOAD_CTRL_ENABLE		BIT(0)
 
 #define SPI_ENGINE_CONFIG_CPHA			BIT(0)
 #define SPI_ENGINE_CONFIG_CPOL			BIT(1)
@@ -78,6 +98,14 @@
 #define SPI_ENGINE_CMD_CS_INV(flags) \
 	SPI_ENGINE_CMD(SPI_ENGINE_INST_CS_INV, 0, (flags))
 
+/* default sizes - can be changed when SPI Engine firmware is compiled */
+#define SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE	16
+#define SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE	16
+
+#define SPI_ENGINE_OFFLOAD_CAPS (SPI_OFFLOAD_CAP_TRIGGER | \
+				 SPI_OFFLOAD_CAP_TX_STATIC_DATA | \
+				 SPI_OFFLOAD_CAP_RX_STREAM_DMA)
+
 struct spi_engine_program {
 	unsigned int length;
 	uint16_t instructions[] __counted_by(length);
@@ -105,6 +133,16 @@ struct spi_engine_message_state {
 	uint8_t *rx_buf;
 };
 
+enum {
+	SPI_ENGINE_OFFLOAD_FLAG_PREPARED,
+};
+
+struct spi_engine_offload {
+	struct spi_engine *spi_engine;
+	unsigned long flags;
+	unsigned int offload_num;
+};
+
 struct spi_engine {
 	struct clk *clk;
 	struct clk *ref_clk;
@@ -117,6 +155,11 @@ struct spi_engine {
 	unsigned int int_enable;
 	/* shadows hardware CS inversion flag state */
 	u8 cs_inv;
+
+	unsigned int offload_ctrl_mem_size;
+	unsigned int offload_sdo_mem_size;
+	struct spi_offload *offloads;
+	unsigned int num_offloads;
 };
 
 static void spi_engine_program_add_cmd(struct spi_engine_program *p,
@@ -164,7 +207,7 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 
 		if (xfer->tx_buf)
 			flags |= SPI_ENGINE_TRANSFER_WRITE;
-		if (xfer->rx_buf)
+		if (xfer->rx_buf || (xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM))
 			flags |= SPI_ENGINE_TRANSFER_READ;
 
 		spi_engine_program_add_cmd(p, dry,
@@ -220,16 +263,24 @@ static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
  *
  * NB: This is separate from spi_engine_compile_message() because the latter
  * is called twice and would otherwise result in double-evaluation.
+ *
+ * Returns 0 on success, -EINVAL on failure.
  */
-static void spi_engine_precompile_message(struct spi_message *msg)
+static int spi_engine_precompile_message(struct spi_message *msg)
 {
 	unsigned int clk_div, max_hz = msg->spi->controller->max_speed_hz;
 	struct spi_transfer *xfer;
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		/* If we have an offload transfer, we can't rx to buffer */
+		if (msg->offload && xfer->rx_buf)
+			return -EINVAL;
+
 		clk_div = DIV_ROUND_UP(max_hz, xfer->speed_hz);
 		xfer->effective_speed_hz = max_hz / min(clk_div, 256U);
 	}
+
+	return 0;
 }
 
 static void spi_engine_compile_message(struct spi_message *msg, bool dry,
@@ -544,11 +595,94 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 	return IRQ_HANDLED;
 }
 
+static int spi_engine_offload_prepare(struct spi_message *msg)
+{
+	struct spi_controller *host = msg->spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	struct spi_engine_program *p = msg->opt_state;
+	struct spi_engine_offload *priv = msg->offload->priv;
+	struct spi_transfer *xfer;
+	void __iomem *cmd_addr;
+	void __iomem *sdo_addr;
+	size_t tx_word_count = 0;
+	unsigned int i;
+
+	if (p->length > spi_engine->offload_ctrl_mem_size)
+		return -EINVAL;
+
+	/* count total number of tx words in message */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (!xfer->tx_buf)
+			continue;
+
+		if (xfer->bits_per_word <= 8)
+			tx_word_count += xfer->len;
+		else if (xfer->bits_per_word <= 16)
+			tx_word_count += xfer->len / 2;
+		else
+			tx_word_count += xfer->len / 4;
+	}
+
+	if (tx_word_count > spi_engine->offload_sdo_mem_size)
+		return -EINVAL;
+
+	if (test_and_set_bit_lock(SPI_ENGINE_OFFLOAD_FLAG_PREPARED, &priv->flags))
+		return -EBUSY;
+
+	cmd_addr = spi_engine->base +
+		   SPI_ENGINE_REG_OFFLOAD_CMD_FIFO(priv->offload_num);
+	sdo_addr = spi_engine->base +
+		   SPI_ENGINE_REG_OFFLOAD_SDO_FIFO(priv->offload_num);
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (!xfer->tx_buf)
+			continue;
+
+		if (xfer->bits_per_word <= 8) {
+			const u8 *buf = xfer->tx_buf;
+
+			for (i = 0; i < xfer->len; i++)
+				writel_relaxed(buf[i], sdo_addr);
+		} else if (xfer->bits_per_word <= 16) {
+			const u16 *buf = xfer->tx_buf;
+
+			for (i = 0; i < xfer->len / 2; i++)
+				writel_relaxed(buf[i], sdo_addr);
+		} else {
+			const u32 *buf = xfer->tx_buf;
+
+			for (i = 0; i < xfer->len / 4; i++)
+				writel_relaxed(buf[i], sdo_addr);
+		}
+	}
+
+	for (i = 0; i < p->length; i++)
+		writel_relaxed(p->instructions[i], cmd_addr);
+
+	return 0;
+}
+
+static void spi_engine_offload_unprepare(struct spi_offload *offload)
+{
+	struct spi_engine_offload *priv = offload->priv;
+	struct spi_engine *spi_engine = priv->spi_engine;
+
+	writel_relaxed(1, spi_engine->base +
+			  SPI_ENGINE_REG_OFFLOAD_RESET(priv->offload_num));
+	writel_relaxed(0, spi_engine->base +
+			  SPI_ENGINE_REG_OFFLOAD_RESET(priv->offload_num));
+
+	clear_bit_unlock(SPI_ENGINE_OFFLOAD_FLAG_PREPARED, &priv->flags);
+}
+
 static int spi_engine_optimize_message(struct spi_message *msg)
 {
 	struct spi_engine_program p_dry, *p;
+	int ret;
 
-	spi_engine_precompile_message(msg);
+	ret = spi_engine_precompile_message(msg);
+	if (ret)
+		return ret;
 
 	p_dry.length = 0;
 	spi_engine_compile_message(msg, true, &p_dry);
@@ -560,20 +694,54 @@ static int spi_engine_optimize_message(struct spi_message *msg)
 	spi_engine_compile_message(msg, false, p);
 
 	spi_engine_program_add_cmd(p, false, SPI_ENGINE_CMD_SYNC(
-						AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
+		msg->offload ? 0 : AXI_SPI_ENGINE_CUR_MSG_SYNC_ID));
 
 	msg->opt_state = p;
 
+	if (msg->offload) {
+		ret = spi_engine_offload_prepare(msg);
+		if (ret) {
+			msg->opt_state = NULL;
+			kfree(p);
+			return ret;
+		}
+	}
+
 	return 0;
 }
 
 static int spi_engine_unoptimize_message(struct spi_message *msg)
 {
+	if (msg->offload)
+		spi_engine_offload_unprepare(msg->offload);
+
 	kfree(msg->opt_state);
 
 	return 0;
 }
 
+static struct spi_offload
+*spi_engine_get_offload(struct spi_device *spi,
+			const struct spi_offload_config *config)
+{
+	struct spi_controller *host = spi->controller;
+	struct spi_engine *spi_engine = spi_controller_get_devdata(host);
+	int i;
+
+	if (config->capability_flags & ~SPI_ENGINE_OFFLOAD_CAPS)
+		return ERR_PTR(-EINVAL);
+
+	for (i = 0; i < spi_engine->num_offloads; i++) {
+		struct spi_offload *offload = &spi_engine->offloads[i];
+		struct spi_engine_offload *priv = offload->priv;
+
+		if (priv->offload_num == spi_get_chipselect(spi, 0))
+			return offload;
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
 static int spi_engine_setup(struct spi_device *device)
 {
 	struct spi_controller *host = device->controller;
@@ -606,6 +774,12 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 	unsigned int int_enable = 0;
 	unsigned long flags;
 
+	if (msg->offload) {
+		dev_err(&host->dev, "Single transfer offload not supported\n");
+		msg->status = -EOPNOTSUPP;
+		goto out;
+	}
+
 	/* reinitialize message state for this transfer */
 	memset(st, 0, sizeof(*st));
 	st->cmd_buf = p->instructions;
@@ -641,11 +815,62 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 		msg->status = -ETIMEDOUT;
 	}
 
+out:
 	spi_finalize_current_message(host);
 
 	return msg->status;
 }
 
+static int spi_engine_trigger_enable(struct spi_offload *offload)
+{
+	struct spi_controller *host = offload->spi->controller;
+	struct spi_engine_offload *priv = offload->priv;
+	struct spi_engine *spi_engine = priv->spi_engine;
+	unsigned int reg;
+
+	guard(mutex)(&host->io_mutex);
+
+	reg = readl_relaxed(spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
+	reg |= SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
+	writel_relaxed(reg, spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
+	return 0;
+}
+
+static void spi_engine_trigger_disable(struct spi_offload *offload)
+{
+	struct spi_controller *host = offload->spi->controller;
+	struct spi_engine_offload *priv = offload->priv;
+	struct spi_engine *spi_engine = priv->spi_engine;
+	unsigned int reg;
+
+	guard(mutex)(&host->io_mutex);
+
+	reg = readl_relaxed(spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
+	reg &= ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
+	writel_relaxed(reg, spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
+}
+
+static struct dma_chan
+*spi_engine_rx_stream_request_dma_chan(struct spi_offload *offload)
+{
+	struct spi_engine_offload *priv = offload->priv;
+	char name[16];
+
+	snprintf(name, sizeof(name), "offload%u-rx", priv->offload_num);
+
+	return dma_request_chan(offload->provider_dev, name);
+}
+
+static const struct spi_offload_ops spi_engine_offload_ops = {
+	.trigger_enable = spi_engine_trigger_enable,
+	.trigger_disable = spi_engine_trigger_disable,
+	.rx_stream_request_dma_chan = spi_engine_rx_stream_request_dma_chan,
+};
+
 static void spi_engine_release_hw(void *p)
 {
 	struct spi_engine *spi_engine = p;
@@ -660,8 +885,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	struct spi_engine *spi_engine;
 	struct spi_controller *host;
 	unsigned int version;
-	int irq;
-	int ret;
+	int irq, ret, i;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -676,6 +900,29 @@ static int spi_engine_probe(struct platform_device *pdev)
 	spin_lock_init(&spi_engine->lock);
 	init_completion(&spi_engine->msg_complete);
 
+	/*
+	 * REVISIT: for now, all SPI Engines only have one offload. In the
+	 * future, this should be read from a memory mapped register to
+	 * determine the number of offloads enabled at HDL compile time.
+	 */
+	spi_engine->num_offloads = 1;
+
+	spi_engine->offloads =
+		devm_spi_offload_alloc(&pdev->dev, spi_engine->num_offloads,
+				       sizeof(struct spi_engine_offload));
+	if (IS_ERR(spi_engine->offloads))
+		return PTR_ERR(spi_engine->offloads);
+
+	for (i = 0; i < spi_engine->num_offloads; i++) {
+		struct spi_offload *offload = &spi_engine->offloads[i];
+		struct spi_engine_offload *offload_priv = offload->priv;
+
+		offload->ops = &spi_engine_offload_ops;
+		offload->xfer_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+		offload_priv->spi_engine = spi_engine;
+		offload_priv->offload_num = i;
+	}
+
 	spi_engine->clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(spi_engine->clk))
 		return PTR_ERR(spi_engine->clk);
@@ -697,6 +944,19 @@ static int spi_engine_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (ADI_AXI_PCORE_VER_MINOR(version) >= 1) {
+		unsigned int sizes = readl(spi_engine->base +
+				SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH);
+
+		spi_engine->offload_ctrl_mem_size = 1 <<
+			FIELD_GET(SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_CMD, sizes);
+		spi_engine->offload_sdo_mem_size = 1 <<
+			FIELD_GET(SPI_ENGINE_SPI_OFFLOAD_MEM_WIDTH_SDO, sizes);
+	} else {
+		spi_engine->offload_ctrl_mem_size = SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE;
+		spi_engine->offload_sdo_mem_size = SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE;
+	}
+
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_RESET);
 	writel_relaxed(0xff, spi_engine->base + SPI_ENGINE_REG_INT_PENDING);
 	writel_relaxed(0x00, spi_engine->base + SPI_ENGINE_REG_INT_ENABLE);
@@ -718,6 +978,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->transfer_one_message = spi_engine_transfer_one_message;
 	host->optimize_message = spi_engine_optimize_message;
 	host->unoptimize_message = spi_engine_unoptimize_message;
+	host->get_offload = spi_engine_get_offload;
 	host->num_chipselect = 8;
 
 	/* Some features depend of the IP core version. */

-- 
2.43.0


