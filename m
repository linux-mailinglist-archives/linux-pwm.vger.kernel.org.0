Return-Path: <linux-pwm+bounces-4089-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEC69CF5CA
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 21:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613C41F22839
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 20:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CB11F582C;
	Fri, 15 Nov 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C3AZV1W1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F071E9099
	for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701944; cv=none; b=L5BWA+6xFP7EHsDScu9vczbJSoUexK6qv0boxoArSmXanTDeqlA2BmRE6XRVfF0/6ELIy7QA/Q2e9ISMTb22Zvcr/6GTXYW3qgOdpqmfVNtnLjR05h6zL4dp58WcEVB1J05pZs6SF3MC7UYqauEXepb9J418Ct8v610XAaRyE8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701944; c=relaxed/simple;
	bh=erKKZRVUn7IwrRaCIDy7XYkV9HY0K/mNJSiRh3VE4VY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HVaVLELD03372XAM2VO4fDayZ7JEeTi6A9mILk4u38hk00Oh3r0TaTxFPbCOumD5AbjCalO2wFglPBDvrrgGURK+GaF8HqWz0Q4tR8yThUOKKpf+9hDCwpYKEzkAJSS3G19KjY6Jvz7krEdNsC5efvi8mSBvgLaylXju2VMU5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C3AZV1W1; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-71806621d42so535537a34.3
        for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 12:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701940; x=1732306740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYPeRBi9nrELQs979W4XEUoH02dIXOt6zRUj5jB314E=;
        b=C3AZV1W1hdpBM8tiRrVtqK/uBkExgv3KzBjnOAN4pLnnuox9gnNklYc+b/tCw/t/DC
         5csUhT4R9rOzQoX7Kh2r3NDSKwNVAhHSvdx8gux67BF62MFxteSw7nrk2als6INVnyaY
         goBzkCMc6tHwZA7Yh3mefemai5eISk/AH6jHzhzH3yMIz/eydC6iVh/S2FNoo+Pce5NZ
         Mk4KSZqhR895FZWGBjzWsjfg6IbJW6kDV7meBlsfmTtpTlygOw6OJhL5LKrD2Ei7B11t
         bDBIcg/6ucAjdjKXBzemZHnixVD9e5t6l7uWvqyUr6tL5IVHI0G3eHRvgsqdJH2knbzX
         lr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701940; x=1732306740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PYPeRBi9nrELQs979W4XEUoH02dIXOt6zRUj5jB314E=;
        b=I4/U7aIYQuAwheVUyT6aJAqMohmCx/iIVfxEFdy8V/ZcF3SvkeKBRYKCQzuYmNDfD5
         CJp2TLISMxG+hSLJo8zoahjbTNM7r9bXjwDy4GstU3uBE+AU2kEq9u36I0xl1Acv4/WT
         zQXs4Wv4ARWJW/VREtBBqKzfmEba/8hD5Bdzm+pZ3C5f/k+2HEBJcn4AemGG7nLFI4pX
         g/+plrP4I9a9pAB7Xt0UZxKQcsLXtmmaIVdhGcp6I5kUQRrePxbXxCTzINctuyLGUOHl
         dcDNC/YDy0GQZ7ICwalj7qnTdQ+2S0dYMAIdmxx33Cn7iNdep93pw0wIQH27shBscgBJ
         hs6A==
X-Forwarded-Encrypted: i=1; AJvYcCXz7/tkYs9d5jT46QvuDWm8fefSQFna83JLwZY9ihDuXL58XJxxgC/Cchfnw1ubAPNd5qNR3fye3rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQFnM3JmxSxnAlRhks/RutnuRGLl7VNbnhtIrwRb+IoftUoOhs
	sGTOIh1eVc/VMLG0zvCqeGs9rRSBvsTXos7ofH//+4dKLevBjqz1hpJjoIZLKZU=
X-Google-Smtp-Source: AGHT+IHMGVKi0FqsBN5EszNDDL8jXkOP8TayUeRcOI/MUXnbSEj5fQ0Os+LSjCLYDsLnL8MyGGdFWw==
X-Received: by 2002:a05:6830:600a:b0:719:cd05:c7fe with SMTP id 46e09a7af769-71a7798f130mr4876373a34.17.1731701940414;
        Fri, 15 Nov 2024 12:19:00 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:19:00 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Nov 2024 14:18:47 -0600
Subject: [PATCH v5 08/16] spi: axi-spi-engine: implement offload support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-8-bea815bd5ea5@baylibre.com>
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

Implement SPI offload support for the AXI SPI Engine. Currently, the
hardware only supports triggering offload transfers with a hardware
trigger so attempting to use an offload message in the regular SPI
message queue will fail. Also, only allows streaming rx data to an
external sink, so attempts to use a rx_buf in the offload message will
fail.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes:
* Set offload capability flags based on DT properties.
* Add support for TX DMA since the hardware supports that now.
* Update for changes in other patches in the series.

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
 drivers/spi/spi-axi-spi-engine.c | 314 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 308 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 867d4b55bef9..b7bbead647eb 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -179,6 +179,7 @@ config SPI_AU1550
 config SPI_AXI_SPI_ENGINE
 	tristate "Analog Devices AXI SPI Engine controller"
 	depends on HAS_IOMEM
+	select SPI_OFFLOAD
 	help
 	  This enables support for the Analog Devices AXI SPI Engine SPI controller.
 	  It is part of the SPI Engine framework that is used in some Analog Devices
diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 9386ddc4714e..172a9f1f1ead 100644
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
@@ -14,9 +17,11 @@
 #include <linux/module.h>
 #include <linux/overflow.h>
 #include <linux/platform_device.h>
+#include <linux/spi/spi-offload.h>
 #include <linux/spi/spi.h>
 #include <trace/events/spi.h>
 
+#define SPI_ENGINE_REG_OFFLOAD_MEM_ADDR_WIDTH	0x10
 #define SPI_ENGINE_REG_RESET			0x40
 
 #define SPI_ENGINE_REG_INT_ENABLE		0x80
@@ -24,6 +29,7 @@
 #define SPI_ENGINE_REG_INT_SOURCE		0x88
 
 #define SPI_ENGINE_REG_SYNC_ID			0xc0
+#define SPI_ENGINE_REG_OFFLOAD_SYNC_ID		0xc4
 
 #define SPI_ENGINE_REG_CMD_FIFO_ROOM		0xd0
 #define SPI_ENGINE_REG_SDO_FIFO_ROOM		0xd4
@@ -34,10 +40,24 @@
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
@@ -79,6 +99,10 @@
 #define SPI_ENGINE_CMD_CS_INV(flags) \
 	SPI_ENGINE_CMD(SPI_ENGINE_INST_CS_INV, 0, (flags))
 
+/* default sizes - can be changed when SPI Engine firmware is compiled */
+#define SPI_ENGINE_OFFLOAD_CMD_FIFO_SIZE	16
+#define SPI_ENGINE_OFFLOAD_SDO_FIFO_SIZE	16
+
 struct spi_engine_program {
 	unsigned int length;
 	uint16_t instructions[] __counted_by(length);
@@ -106,6 +130,17 @@ struct spi_engine_message_state {
 	uint8_t *rx_buf;
 };
 
+enum {
+	SPI_ENGINE_OFFLOAD_FLAG_ASSIGNED,
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
@@ -118,6 +153,11 @@ struct spi_engine {
 	unsigned int int_enable;
 	/* shadows hardware CS inversion flag state */
 	u8 cs_inv;
+
+	unsigned int offload_ctrl_mem_size;
+	unsigned int offload_sdo_mem_size;
+	struct spi_offload *offload;
+	u32 offload_caps;
 };
 
 static void spi_engine_program_add_cmd(struct spi_engine_program *p,
@@ -163,9 +203,9 @@ static void spi_engine_gen_xfer(struct spi_engine_program *p, bool dry,
 		unsigned int n = min(len, 256U);
 		unsigned int flags = 0;
 
-		if (xfer->tx_buf)
+		if (xfer->tx_buf || (xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM))
 			flags |= SPI_ENGINE_TRANSFER_WRITE;
-		if (xfer->rx_buf)
+		if (xfer->rx_buf || (xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM))
 			flags |= SPI_ENGINE_TRANSFER_READ;
 
 		spi_engine_program_add_cmd(p, dry,
@@ -221,16 +261,24 @@ static void spi_engine_gen_cs(struct spi_engine_program *p, bool dry,
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
@@ -545,11 +593,105 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
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
+		/* no support for reading to rx_buf */
+		if (xfer->rx_buf)
+			return -EINVAL;
+
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
+	if (tx_word_count && !(spi_engine->offload_caps & SPI_OFFLOAD_CAP_TX_STATIC_DATA))
+		return -EINVAL;
+
+	if (tx_word_count > spi_engine->offload_sdo_mem_size)
+		return -EINVAL;
+
+	/*
+	 * This protects against calling spi_optimize_message() with an offload
+	 * that has already been prepared with a different message.
+	 */
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
@@ -561,20 +703,61 @@ static int spi_engine_optimize_message(struct spi_message *msg)
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
+	struct spi_engine_offload *priv;
+
+	if (!spi_engine->offload)
+		return ERR_PTR(-ENODEV);
+
+	if (config->capability_flags & ~spi_engine->offload_caps)
+		return ERR_PTR(-EINVAL);
+
+	priv = spi_engine->offload->priv;
+
+	if (test_and_set_bit_lock(SPI_ENGINE_OFFLOAD_FLAG_ASSIGNED, &priv->flags))
+		return ERR_PTR(-EBUSY);
+
+	return spi_engine->offload;
+}
+
+static void spi_engine_put_offload(struct spi_offload *offload)
+{
+	struct spi_engine_offload *priv = offload->priv;
+
+	clear_bit_unlock(SPI_ENGINE_OFFLOAD_FLAG_ASSIGNED, &priv->flags);
+}
+
 static int spi_engine_setup(struct spi_device *device)
 {
 	struct spi_controller *host = device->controller;
@@ -607,6 +790,12 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
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
@@ -656,11 +845,68 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 			trace_spi_transfer_stop(msg, xfer);
 	}
 
+out:
 	spi_finalize_current_message(host);
 
 	return msg->status;
 }
 
+static int spi_engine_trigger_enable(struct spi_offload *offload)
+{
+	struct spi_engine_offload *priv = offload->priv;
+	struct spi_engine *spi_engine = priv->spi_engine;
+	unsigned int reg;
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
+	struct spi_engine_offload *priv = offload->priv;
+	struct spi_engine *spi_engine = priv->spi_engine;
+	unsigned int reg;
+
+	reg = readl_relaxed(spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
+	reg &= ~SPI_ENGINE_OFFLOAD_CTRL_ENABLE;
+	writel_relaxed(reg, spi_engine->base +
+			    SPI_ENGINE_REG_OFFLOAD_CTRL(priv->offload_num));
+}
+
+static struct dma_chan
+*spi_engine_tx_stream_request_dma_chan(struct spi_offload *offload)
+{
+	struct spi_engine_offload *priv = offload->priv;
+	char name[16];
+
+	snprintf(name, sizeof(name), "offload%u-tx", priv->offload_num);
+
+	return dma_request_chan(offload->provider_dev, name);
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
+	.tx_stream_request_dma_chan = spi_engine_tx_stream_request_dma_chan,
+	.rx_stream_request_dma_chan = spi_engine_rx_stream_request_dma_chan,
+};
+
 static void spi_engine_release_hw(void *p)
 {
 	struct spi_engine *spi_engine = p;
@@ -675,8 +921,7 @@ static int spi_engine_probe(struct platform_device *pdev)
 	struct spi_engine *spi_engine;
 	struct spi_controller *host;
 	unsigned int version;
-	int irq;
-	int ret;
+	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -691,6 +936,46 @@ static int spi_engine_probe(struct platform_device *pdev)
 	spin_lock_init(&spi_engine->lock);
 	init_completion(&spi_engine->msg_complete);
 
+	/*
+	 * REVISIT: for now, all SPI Engines only have one offload. In the
+	 * future, this should be read from a memory mapped register to
+	 * determine the number of offloads enabled at HDL compile time. For
+	 * now, we can tell if an offload is present if there is a trigger
+	 * source wired up to it.
+	 */
+	if (device_property_present(&pdev->dev, "trigger-sources")) {
+		struct spi_engine_offload *priv;
+
+		spi_engine->offload =
+			devm_spi_offload_alloc(&pdev->dev,
+					       sizeof(struct spi_engine_offload));
+		if (IS_ERR(spi_engine->offload))
+			return PTR_ERR(spi_engine->offload);
+
+		priv = spi_engine->offload->priv;
+		priv->spi_engine = spi_engine;
+		priv->offload_num = 0;
+
+		spi_engine->offload->ops = &spi_engine_offload_ops;
+		spi_engine->offload_caps = SPI_OFFLOAD_CAP_TRIGGER;
+
+		if (device_property_match_string(&pdev->dev, "dma-names", "offload0-rx") >= 0) {
+			spi_engine->offload_caps |= SPI_OFFLOAD_CAP_RX_STREAM_DMA;
+			spi_engine->offload->xfer_flags |= SPI_OFFLOAD_XFER_RX_STREAM;
+		}
+
+		if (device_property_match_string(&pdev->dev, "dma-names", "offload0-tx") >= 0) {
+			spi_engine->offload_caps |= SPI_OFFLOAD_CAP_TX_STREAM_DMA;
+			spi_engine->offload->xfer_flags |= SPI_OFFLOAD_XFER_TX_STREAM;
+		} else {
+			/*
+			 * HDL compile option to enable TX DMA stream also disables
+			 * the SDO memory, so can't do both at the same time.
+			 */
+			spi_engine->offload_caps |= SPI_OFFLOAD_CAP_TX_STATIC_DATA;
+		}
+	}
+
 	spi_engine->clk = devm_clk_get_enabled(&pdev->dev, "s_axi_aclk");
 	if (IS_ERR(spi_engine->clk))
 		return PTR_ERR(spi_engine->clk);
@@ -712,6 +997,19 @@ static int spi_engine_probe(struct platform_device *pdev)
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
@@ -733,6 +1031,8 @@ static int spi_engine_probe(struct platform_device *pdev)
 	host->transfer_one_message = spi_engine_transfer_one_message;
 	host->optimize_message = spi_engine_optimize_message;
 	host->unoptimize_message = spi_engine_unoptimize_message;
+	host->get_offload = spi_engine_get_offload;
+	host->put_offload = spi_engine_put_offload;
 	host->num_chipselect = 8;
 
 	/* Some features depend of the IP core version. */

-- 
2.43.0


