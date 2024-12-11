Return-Path: <linux-pwm+bounces-4318-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE789ED7A3
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2024 21:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E08C1889358
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Dec 2024 20:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C039222A802;
	Wed, 11 Dec 2024 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="csJI4HNP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7131229690
	for <linux-pwm@vger.kernel.org>; Wed, 11 Dec 2024 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950507; cv=none; b=JU+hK5xYTRalEH+W+po+VOpfU3nouqnsAhQ8Rwi/XdJxMnJAgxvA/joV3v9KvYYjApS0ZsjVhjwTw5UBTfRaarXHTDIAA4xLxwN+pWguroNhbHNn4lG+p/uB9mnpd4GByZp785FBKnVKKL5i8X6lshzzNi6rAXiKgoQ/c3lH/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950507; c=relaxed/simple;
	bh=zdncvfZ0Q50oYp1R7RHAvey85jbOGhAbt2b/jbzQSKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ml2a2W1l0/T0ea9N0Ggz+xZl9VEmXBnzJFAmMcw/yuTxLJ+ZO5yqVSgdCBePb3sasUWf7i309AjBderLy4Jj8b20T+JFNNQprI3Y7+Bm5e5rdWDfhCCEpg+mzqaX9/T6rh3Zj99Aq9GfCU1yMPa24fBds80MWhhQa8D6Ws/MxEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=csJI4HNP; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-71e163493efso818171a34.3
        for <linux-pwm@vger.kernel.org>; Wed, 11 Dec 2024 12:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950504; x=1734555304; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vouqSSWMwE0i1CMHfrBToPiWRjTEnBfzG9E3I/smeiU=;
        b=csJI4HNPhzHiuPZlBZaE7+ln7Ng0r5BDh7vNMonX4/vA3NaYgOW5qdh29vyhEkOsIB
         nS1O4pwa1MlmQMDjk8aRytFOWwYbmGZ3brRImuTgPUg8vSl4gpBB8LnYLsWdyBcQQydL
         D9nVysl5Lby8JreBZgN1FXu+VeS4gxsJG7MlVOFd/ZXXWB4SJWtajhQ08U7JpmgAYrMI
         PZ5sysElFndGZhPmps6q2xlLfyPdBmJr7E+nFR87jHkWGcxDo37rxY1PtLCC6S3Mva00
         hAsxoof7X61tCJ2u8M08OVYqbQ1qxI7zxU0gRfhqvhrLFNKI6MWk/F05ymsmrQaIYIyR
         MS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950504; x=1734555304;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vouqSSWMwE0i1CMHfrBToPiWRjTEnBfzG9E3I/smeiU=;
        b=pIfrjMzM+sUcET0ae+MMx+IypYxa0wJx2pSTLqGOmPwvAVKto10JrqSxlVjKMqEhkA
         kjY+7OESltWzssRwTBf7iMjfkrx9qyEPa2237t+S2xwKZidezjMQW0gEe2/VS/PwMygQ
         JOWjGUDe4mSQ19bqdgAk5mBQ07M++1ap2vVnnmGMXuLzDqcZ+GuzYUk1vxGiWsCLad+5
         j8hphczxpy/wxn3wXyeL9hS3ywd56noOIQa56klM1riruYWfNvaAZUz2DvZ2Bo20KP6H
         a3w6rBth4sznGcLOx4PwlwuTqKN/N/817pIWiIgPGGXPa3GruWW22vOHXBR5hw08tT+w
         GwIA==
X-Forwarded-Encrypted: i=1; AJvYcCW0LpEPg0g+v+u25KoyEBCMs0SBiT2k+HFhy1mU/UJYEZmqeUNL2e6oYm5YYjrpeF0UeUSm+7U5auI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp1z3xOlvusQT3QzHBAnuHRXcM25L9u2ngvomFtt6ote1KTx3a
	9kkfaLd6bikY2kPLhbJ3gcg5eCg0VyDIb91BFzvcAVh1RtFIU3pxhPwe1Qe7KRw=
X-Gm-Gg: ASbGncvY2fPRdxZ2eA/3cBs/e04onTBFGinR1kQq609ZabewSX0XjxOAXcRYsth8d9+
	XzTLjogAhS1zLSXWtcqjpVCEOQzpIceTOJuX++ZQjSqYXcnF1ByEu1oijAdGMCrgBJgFXVGOc5g
	gKdTZ2RGBvifNlQT4oa8uPNKfaulpZCnkh0zZCB398L2dCdwe2yTPcOvAv1fXJLF8IKLMUqorLU
	zm5I7GtR3zE4WGq/TClnA+nVhtDJbNOOoKpuXWYlxAxviiAsvDm4bqzzUsQF13ONaPQNsWNadwg
	/39i/8k1Ng==
X-Google-Smtp-Source: AGHT+IGjdtY9SJoSuhMzq6sD9FjC+U2bj5zrP1DIdEBADIpRixwTBYhxCGTjehUjJtVHBExWPH0lGQ==
X-Received: by 2002:a05:6830:6d09:b0:717:f666:9559 with SMTP id 46e09a7af769-71e29c5a609mr595769a34.9.1733950503638;
        Wed, 11 Dec 2024 12:55:03 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:55:03 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Dec 2024 14:54:42 -0600
Subject: [PATCH v6 05/17] spi: add offload TX/RX streaming APIs
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-5-88ee574d5d03@baylibre.com>
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
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

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

v6 changes:
* Update for header file split.
* Fix wrong kernel-doc comments.

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
 drivers/spi/spi-offload.c            | 70 ++++++++++++++++++++++++++++++++++++
 drivers/spi/spi.c                    | 10 ++++++
 include/linux/spi/offload/consumer.h |  5 +++
 include/linux/spi/offload/types.h    | 19 ++++++++++
 include/linux/spi/spi.h              |  3 ++
 5 files changed, 107 insertions(+)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index 43582e50e279c4b1b958765fec556aaa91180e55..df5e963d5ee29d37833559595536a460c530bc81 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -18,6 +18,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/export.h>
 #include <linux/kref.h>
 #include <linux/list.h>
@@ -332,6 +333,75 @@ void spi_offload_trigger_disable(struct spi_offload *offload,
 }
 EXPORT_SYMBOL_GPL(spi_offload_trigger_disable);
 
+static void spi_offload_release_dma_chan(void *chan)
+{
+	dma_release_channel(chan);
+}
+
+/**
+ * devm_spi_offload_tx_stream_request_dma_chan - Get the DMA channel info for the TX stream
+ * @dev: Device for devm purposes.
+ * @offload: Offload instance
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
+ * devm_spi_offload_rx_stream_request_dma_chan - Get the DMA channel info for the RX stream
+ * @dev: Device for devm purposes.
+ * @offload: Offload instance
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
index ff1add2ecb91f18cf82e6f1e9595584c11adf9d8..4a871db9ee636aba64c866ebdd8bb1dbf82e0f42 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -31,6 +31,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/sched/rt.h>
 #include <linux/slab.h>
+#include <linux/spi/offload/types.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 #include <uapi/linux/sched/types.h>
@@ -4163,6 +4164,15 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 
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
diff --git a/include/linux/spi/offload/consumer.h b/include/linux/spi/offload/consumer.h
index 5a0ec5303d600728959594bcdbd0cb2baeba7c77..cd7d5daa21e69b61c16eba6c10c855345a4f3297 100644
--- a/include/linux/spi/offload/consumer.h
+++ b/include/linux/spi/offload/consumer.h
@@ -31,4 +31,9 @@ int spi_offload_trigger_enable(struct spi_offload *offload,
 void spi_offload_trigger_disable(struct spi_offload *offload,
 				 struct spi_offload_trigger *trigger);
 
+struct dma_chan *devm_spi_offload_tx_stream_request_dma_chan(struct device *dev,
+							     struct spi_offload *offload);
+struct dma_chan *devm_spi_offload_rx_stream_request_dma_chan(struct device *dev,
+							     struct spi_offload *offload);
+
 #endif /* __LINUX_SPI_OFFLOAD_CONSUMER_H */
diff --git a/include/linux/spi/offload/types.h b/include/linux/spi/offload/types.h
index 7476f2073b02ee0f9edd3ae75e587b075746fa92..86d0e8cb9495bb43e177378b2041067de8ea8786 100644
--- a/include/linux/spi/offload/types.h
+++ b/include/linux/spi/offload/types.h
@@ -11,6 +11,11 @@
 
 struct device;
 
+/* This is write xfer but TX uses external data stream rather than tx_buf. */
+#define SPI_OFFLOAD_XFER_TX_STREAM	BIT(0)
+/* This is read xfer but RX uses external data stream rather than rx_buf. */
+#define SPI_OFFLOAD_XFER_RX_STREAM	BIT(1)
+
 /* Offload can be triggered by external hardware event. */
 #define SPI_OFFLOAD_CAP_TRIGGER			BIT(0)
 /* Offload can record and then play back TX data when triggered. */
@@ -40,6 +45,8 @@ struct spi_offload {
 	void *priv;
 	/** @ops: callbacks for offload support */
 	const struct spi_offload_ops *ops;
+	/** @xfer_flags: %SPI_OFFLOAD_XFER_* flags supported by provider */
+	u32 xfer_flags;
 };
 
 enum spi_offload_trigger_type {
@@ -75,6 +82,18 @@ struct spi_offload_ops {
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
 
 #endif /* __LINUX_SPI_OFFLOAD_TYPES_H */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 98bdc8c16c20521c0a94e5f72f5e71c4f6d7d11e..4c087009cf974595f23036b1b7a030a45913420c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1093,6 +1093,9 @@ struct spi_transfer {
 
 	u32		effective_speed_hz;
 
+	/* Use %SPI_OFFLOAD_XFER_* from spi-offload.h */
+	unsigned int	offload_flags;
+
 	unsigned int	ptp_sts_word_pre;
 	unsigned int	ptp_sts_word_post;
 

-- 
2.43.0


