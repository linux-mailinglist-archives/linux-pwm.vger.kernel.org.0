Return-Path: <linux-pwm+bounces-4087-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F229CF5BF
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 21:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385601F21B04
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1F11EABD2;
	Fri, 15 Nov 2024 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R6c6CIeV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F01E7645
	for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 20:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701942; cv=none; b=szUNwnP+qc2lbbq7MSnoLTfzcHuOD6NUPq5R0bRH/ZVugHH2Wfot09wnyCLVoQyU0TiWRmvCoUoDPEOL/Bmg/0t0SIGpdw8AQjf3buLRC9MJXoEF5NU+vuUZVvBvvTm+hONBWP40tTHlDA1PN9qITbA3dmw1g0SesyHiFX9dD8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701942; c=relaxed/simple;
	bh=lHDQPMwP/f0vQi/LB7g/3w7zJV7pZTr+cdbnP18cpFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bQ2vEpj+GTItxQZJVISnXzv9O25YOaa2O1a19qopJU6B3RHNkCJ82+l9RosIES3nKO7qOJy57bpAstTqPqQmwoxGIfSnN0n0SHm2Ovjh8SXfGb75lKWfA13m1wOqIEdY42ltn8wFUzdpCMDy3U1O4rZWbAEhb+QLaRoUM3cg1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R6c6CIeV; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2958ddf99a7so1825976fac.2
        for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 12:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701938; x=1732306738; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPVL9IOUqvtFQfEuJrra9pvdj030MVfb0lKKNV1PGXo=;
        b=R6c6CIeVHIWKx2lZs8e3l40s1sKmmBa+b2zU599WLI44U8VzWhVqIBOB4tgOM1v+DM
         APKXGewytHdX2zQJJQ+q+ccyl4xchUciapzkO1J3+lU892XlB1gv0Q+qBj1DF8eUBBXW
         J8DdWsPPNbc2H3Q7MN56cOfNYzkJ4mmnDlufgW7noNBqKL/KkMZdbnRZA00jqGsivKtd
         Ivw/igXsaBQXsvvS8dGGmzxyK0NxIAO6YyMkqnLnSx7e7ynzXXcVqTZfegYOawoQpc7W
         9F6TIfHlpqqMehkAn46yHMEM8RVwfy0DS3+GRL2ygzdF7JB0Qwecf4AvP5T/ohjTuwqh
         fD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701938; x=1732306738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPVL9IOUqvtFQfEuJrra9pvdj030MVfb0lKKNV1PGXo=;
        b=cos82gp9ms0nK+1mIV4fMLeyiabuCl5hTO8ZxmmxVn2SYSArjaSG/G7HPuir/AJSdb
         Nyonj2j9ASxW9uZBNL6tE5m6df30s/KxkgiY4duMdMcw63ALNUBDcqKPfJF6QafSoNnG
         WwBpu6ToSMfwhSFqazOpTtjotFALN+o8g3FjDnqy1i7BOcoBBg9VkhBes+xZnuYm15un
         CS+SBQvDK/rfgESSpIkV8nHGqtuVSrNFod18umBA3jZsQ/i3nT+AeGIga721HUVyV+jC
         L8nzwNEjIOwrZZvCBvrcqWneAk2MVrSRArFWMTJE+f/wYFaeEN+RhZekZpE2QROKQUko
         VeKA==
X-Forwarded-Encrypted: i=1; AJvYcCX5dGa/cvgF5qfLQIPRe34P965obdAYX5iUrr/YxGeeDJXFHbQi1XG5YS8aniAAgwiN7K+QYPhGQ6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUXyArvfRj6+xbUGBKW+O6UzAHOHP04IJgjieZNuHAbgkM2xT2
	mRQIckExrokQ8drBVfmrFFMexPERpIODaz6GKQ+pL30srBBvpSPD15WoNdEzyn8=
X-Google-Smtp-Source: AGHT+IFKWlC4vrCp05d3/1c9UNzH+kf3T3fxbtPXzPVlfEhklc/TU9XpmmRHVZeejKXSJzbZd/jR9w==
X-Received: by 2002:a05:6870:3923:b0:288:2906:6882 with SMTP id 586e51a60fabf-2962dfeec01mr4621330fac.29.1731701938603;
        Fri, 15 Nov 2024 12:18:58 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:18:58 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Nov 2024 14:18:45 -0600
Subject: [PATCH v5 06/16] spi: add offload TX/RX streaming APIs
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-6-bea815bd5ea5@baylibre.com>
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

Most configuration of SPI offloads is handled opaquely using the offload
pointer that is passed to the various offload functions. However, there
are some offload features that need to be controlled on a per transfer
basis.

This patch adds a flag field to struct spi_transfer to allow specifying
such features. The first feature to be added is the ability to stream
data to/from a hardware sink/source rather than using a tx or rx buffer.
Additional flags can be added in the future as needed.

A flags field is also added to the offload struct for providers to
indicate which flags are supported. This allows for generic checking of
offload capabilities during __spi_validate() so that each offload
provider doesn't have to implement their own validation.

As a first users of this streaming capability, getter functions are
added to get a DMA channel that is directly connected to the offload.
Peripheral drivers will use this to get a DMA channel and configure it
to suit their needs.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 change:
* Remove incorrect comment about caller needing to release DMA channels.

v4 changes:
* DMA API's now automatically release DMA channels instead of leaving
  it up to the caller.

v3 changes:
* Added spi_offload_{tx,rx}_stream_get_dma_chan() functions.

v2 changes:
* This is also split out from "spi: add core support for controllers with
  offload capabilities".
* In the previous version, we were using (void *)-1 as a sentinel value
  that could be assigned, e.g. to rx_buf. But this was naive since there
  is core code that would try to dereference this pointer. So instead,
  we've added a new flags field to the spi_transfer structure for this
  sort of thing. This also has the advantage of being able to be used in
  the future for other arbitrary features.
---
 drivers/spi/spi-offload.c       | 70 +++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi.c               | 10 ++++++
 include/linux/spi/spi-offload.h | 24 ++++++++++++++
 include/linux/spi/spi.h         |  3 ++
 4 files changed, 107 insertions(+)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index 01d7b632d109..7b3e20ad9e4f 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -8,6 +8,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/export.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -319,6 +320,75 @@ void spi_offload_trigger_disable(struct spi_offload *offload,
 }
 EXPORT_SYMBOL_GPL(spi_offload_trigger_disable);
 
+static void spi_offload_release_dma_chan(void *chan)
+{
+	dma_release_channel(chan);
+}
+
+/**
+ * spi_offload_tx_stream_request_dma_chan_info - Get the DMA channel info for the TX stream
+ * @spi: SPI device
+ * @id: Function ID if SPI device uses more than one offload or NULL.
+ *
+ * This is the DMA channel that will provide data to transfers that use the
+ * %SPI_OFFLOAD_XFER_TX_STREAM offload flag.
+ *
+ * Return: Pointer to DMA channel info, or negative error code
+ */
+struct dma_chan
+*devm_spi_offload_tx_stream_request_dma_chan(struct device *dev,
+					     struct spi_offload *offload)
+{
+	struct dma_chan *chan;
+	int ret;
+
+	if (!offload->ops || !offload->ops->tx_stream_request_dma_chan)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	chan = offload->ops->tx_stream_request_dma_chan(offload);
+	if (IS_ERR(chan))
+		return chan;
+
+	ret = devm_add_action_or_reset(dev, spi_offload_release_dma_chan, chan);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_tx_stream_request_dma_chan);
+
+/**
+ * spi_offload_rx_stream_request_dma_chan_info - Get the DMA channel info for the RX stream
+ * @spi: SPI device
+ * @id: Function ID if SPI device uses more than one offload or NULL.
+ *
+ * This is the DMA channel that will receive data from transfers that use the
+ * %SPI_OFFLOAD_XFER_RX_STREAM offload flag.
+ *
+ * Return: Pointer to DMA channel info, or negative error code
+ */
+struct dma_chan
+*devm_spi_offload_rx_stream_request_dma_chan(struct device *dev,
+					     struct spi_offload *offload)
+{
+	struct dma_chan *chan;
+	int ret;
+
+	if (!offload->ops || !offload->ops->rx_stream_request_dma_chan)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	chan = offload->ops->rx_stream_request_dma_chan(offload);
+	if (IS_ERR(chan))
+		return chan;
+
+	ret = devm_add_action_or_reset(dev, spi_offload_release_dma_chan, chan);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return chan;
+}
+EXPORT_SYMBOL_GPL(devm_spi_offload_rx_stream_request_dma_chan);
+
 /* Triggers providers */
 
 static void spi_offload_trigger_unregister(void *data)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 74e04a4b0f19..47020bd033bd 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -31,6 +31,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/sched/rt.h>
 #include <linux/slab.h>
+#include <linux/spi/spi-offload.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <uapi/linux/sched/types.h>
@@ -4159,6 +4160,15 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 
 		if (_spi_xfer_word_delay_update(xfer, spi))
 			return -EINVAL;
+
+		/* make sure controller supports required offload features */
+		if (xfer->offload_flags) {
+			if (!message->offload)
+				return -EINVAL;
+
+			if (xfer->offload_flags & ~message->offload->xfer_flags)
+				return -EINVAL;
+		}
 	}
 
 	message->status = -EINPROGRESS;
diff --git a/include/linux/spi/spi-offload.h b/include/linux/spi/spi-offload.h
index c8c673784e99..132b2f819b91 100644
--- a/include/linux/spi/spi-offload.h
+++ b/include/linux/spi/spi-offload.h
@@ -25,6 +25,11 @@ struct device;
 struct fwnode_handle;
 struct spi_device;
 
+/* This is write xfer but TX uses external data stream rather than tx_buf. */
+#define SPI_OFFLOAD_XFER_TX_STREAM	BIT(0)
+/* This is read xfer but RX uses external data stream rather than rx_buf. */
+#define SPI_OFFLOAD_XFER_RX_STREAM	BIT(1)
+
 /* Offload can be triggered by external hardware event. */
 #define SPI_OFFLOAD_CAP_TRIGGER			BIT(0)
 /* Offload can record and then play back TX data when triggered. */
@@ -54,6 +59,8 @@ struct spi_offload {
 	void *priv;
 	/** @ops: callbacks for offload support */
 	const struct spi_offload_ops *ops;
+	/** @xfer_flags: %SPI_OFFLOAD_XFER_* flags supported by provider */
+	u32 xfer_flags;
 };
 
 enum spi_offload_trigger_type {
@@ -89,6 +96,18 @@ struct spi_offload_ops {
 	 * given offload instance.
 	 */
 	void (*trigger_disable)(struct spi_offload *offload);
+	/**
+	 * @tx_stream_request_dma_chan: Optional callback for controllers that
+	 * have an offload where the TX data stream is connected directly to a
+	 * DMA channel.
+	 */
+	struct dma_chan *(*tx_stream_request_dma_chan)(struct spi_offload *offload);
+	/**
+	 * @rx_stream_request_dma_chan: Optional callback for controllers that
+	 * have an offload where the RX data stream is connected directly to a
+	 * DMA channel.
+	 */
+	struct dma_chan *(*rx_stream_request_dma_chan)(struct spi_offload *offload);
 };
 
 struct spi_offload *devm_spi_offload_alloc(struct device *dev, size_t priv_size);
@@ -107,6 +126,11 @@ int spi_offload_trigger_enable(struct spi_offload *offload,
 void spi_offload_trigger_disable(struct spi_offload *offload,
 				 struct spi_offload_trigger *trigger);
 
+struct dma_chan *devm_spi_offload_tx_stream_request_dma_chan(struct device *dev,
+							     struct spi_offload *offload);
+struct dma_chan *devm_spi_offload_rx_stream_request_dma_chan(struct device *dev,
+							     struct spi_offload *offload);
+
 /* Trigger providers */
 
 struct spi_offload_trigger;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index c2b24a0909ea..e7e612e30a2f 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1094,6 +1094,9 @@ struct spi_transfer {
 
 	u32		effective_speed_hz;
 
+	/* Use %SPI_OFFLOAD_XFER_* from spi-offload.h */
+	unsigned int	offload_flags;
+
 	unsigned int	ptp_sts_word_pre;
 	unsigned int	ptp_sts_word_post;
 

-- 
2.43.0


