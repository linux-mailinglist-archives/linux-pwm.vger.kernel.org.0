Return-Path: <linux-pwm+bounces-3783-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4819AD60B
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 23:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29A0DB22FFE
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2024 21:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE451EBA1D;
	Wed, 23 Oct 2024 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hvptctuZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49AC1FF7B3
	for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717179; cv=none; b=aJeKQpljjaP9ORXEEMd35oImNs1+j+VL2vXCzNuOd4fGFf6jVWII+DWg7jnkpl6TapxMnSy0dP8kDaW8woDureOK0imDfoxdQDoJ7IqaYLIlr0XTCFbK9po9Yg+OSdXO6OwqhAhPJfSdRVgDJQ184FuP0NNlaJrFR/VA1mr/a64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717179; c=relaxed/simple;
	bh=9Uoi/lsx5lDzmesX/dTqmB11w7iIVMU2MC+rAN+Xo0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EcpZf07SJeEAOuFeI9hTvI40k93pp/wF+tbswKe3BmHUYy9+zjXPrHoMHTzITsbfGaHq8A6726eoMCV6KsSlg9JJ5SRRoHRzhoR8ecE0disS0oC660AjNbJzl7WlS43hno0eOtLj+hFO3N9/4ZHOVWD8MYB7+I2O+/NutGS7sfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hvptctuZ; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5eba976beecso597407eaf.0
        for <linux-pwm@vger.kernel.org>; Wed, 23 Oct 2024 13:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717177; x=1730321977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJpBAkzSSYPV4RvQhjaw2/1DFd2kkl7hVgMR3+qjlgE=;
        b=hvptctuZQ5a5qjfBFSAo2mQX4Dubo1Q1glMKG2CfM3Y6QPqO8RZulJVrHr1fvWu7aj
         oqWvuydKGganITgmZoH+ssSdHVvszZ6xGtCQpAZ0P+tpoe/LlwvtR3zufBE6aat3GPAO
         vHoD3hCzUYLx1CfnlYZQKmKafxyFQC3ZfMiGQUkFVcWKxZZhGlfC5AP69LTa+bK0x3A4
         HiyMmkZf/GDBWWnwAt33PvLKY0KaZ9ZF3K4U6WGU3Gqwzrh3jb2D4+ijjZuRL/nVNLtB
         ux77Pc2/7OS5VT9v6/WdY8j+Wno/8MJ2D+kicx8WkJts4iJQAf3EzsStXR4ErjqmVcot
         1UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717177; x=1730321977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MJpBAkzSSYPV4RvQhjaw2/1DFd2kkl7hVgMR3+qjlgE=;
        b=VdOyN58hHqZTt5tVFB6PYo/5xJjyS1pd1sk6SytmQBzKMUU/2PAYAfsw4Mf48YikCi
         O3fueVv7YIdihl9xYweyT6wRPdWyH+uxNsJ0mS2STD8NMO6PCaV53UmFl/rKFHtCzVQ8
         9bXdwG+w/QiN30BEW4MLAfOZ1/Hg5uC1ipAX3UeDDF5ovvMUdHzm56YsI+cRZD+G/c8j
         LYHwb3M+nqVbf7drpTE+ydwFewHeoRw91Gh69ibE+eoFEkNmF7K1YSHcDfv0xA4B+dGJ
         /IOwIfBIyFB95Ssrpci7nsNxzn2202pX172Tcne4Hv30AjwnIimfZ8OMCIszNEhcUahg
         vZIA==
X-Forwarded-Encrypted: i=1; AJvYcCULgrf4vtb3zK3pVOYFsH2fCdws9u+Zf1+kpnN963S8kNJWyClma9T+OVY+d775URuJI2scsTmI4ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4KSjV5IySZ3WM7lW0nzQQjbc4iwud/Nvnfd9EXaig4o0/OHKi
	HO11cCm0G5zrwDEAo7sME6ssY/8A5PZnsn2NJQ4aW7oOAQZImk/DTh8rq16CXr8=
X-Google-Smtp-Source: AGHT+IHhgz4z/pNzeGgfxd28esWvpBib5iH9I1o0u1Snz5WDz9JUClIdWIVkcf1KuO2G++R03tqq+Q==
X-Received: by 2002:a05:6820:608:b0:5eb:c72e:e29f with SMTP id 006d021491bc7-5ebee0753aemr2275209eaf.1.1729717176874;
        Wed, 23 Oct 2024 13:59:36 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:35 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:14 -0500
Subject: [PATCH RFC v4 07/15] spi: add offload TX/RX streaming APIs
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-7-f8125b99f5a1@baylibre.com>
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
 drivers/spi/spi-offload.c       | 76 +++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi.c               | 10 ++++++
 include/linux/spi/spi-offload.h | 24 +++++++++++++
 include/linux/spi/spi.h         |  3 ++
 4 files changed, 113 insertions(+)

diff --git a/drivers/spi/spi-offload.c b/drivers/spi/spi-offload.c
index 2a1f9587f27a..dd4cb3c2e985 100644
--- a/drivers/spi/spi-offload.c
+++ b/drivers/spi/spi-offload.c
@@ -8,6 +8,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/device.h>
+#include <linux/dmaengine.h>
 #include <linux/export.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -282,6 +283,81 @@ void spi_offload_trigger_disable(struct spi_offload *offload,
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
+ * The caller is responsible for calling spi_offload_free_dma_chan_info() on the
+ * returned pointer.
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
+ * The caller is responsible for calling spi_offload_free_dma_chan_info() on the
+ * returned pointer.
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
 
 static void spi_offload_trigger_dev_release(struct device *dev)
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7c5e76b15421..cb6184c0ae03 100644
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
index 561cc1fb6f35..5d0e29b25977 100644
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
@@ -56,6 +61,8 @@ struct spi_offload {
 	void *priv;
 	/** @ops: callbacks for offload support */
 	const struct spi_offload_ops *ops;
+	/** @xfer_flags: %SPI_OFFLOAD_XFER_* flags supported by provider */
+	u32 xfer_flags;
 };
 
 enum spi_offload_trigger_type {
@@ -91,6 +98,18 @@ struct spi_offload_ops {
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
 
 struct spi_offload *devm_spi_offload_alloc(struct device *dev,
@@ -111,6 +130,11 @@ int spi_offload_trigger_enable(struct spi_offload *offload,
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
index c230d6a209ee..fbb8b2d0b5ea 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -1092,6 +1092,9 @@ struct spi_transfer {
 
 	u32		effective_speed_hz;
 
+	/* Use %SPI_OFFLOAD_XFER_* from spi-offload.h */
+	unsigned int	offload_flags;
+
 	unsigned int	ptp_sts_word_pre;
 	unsigned int	ptp_sts_word_post;
 

-- 
2.43.0


