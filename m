Return-Path: <linux-pwm+bounces-3313-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6D397D937
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 19:35:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A6971F21317
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 17:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCF3186E2D;
	Fri, 20 Sep 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W7pMnu3g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841AF18594B
	for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726853618; cv=none; b=KExoo5eUSTwRbd1cp6P0BUj529eCS9NtrvV3WnHu66/WMuK3ckcQieBJAZ6C8P+GOXYlWKzD3F0G1W32KuxO0uROZM/7YZ01mcYiGnjmRMcUumEGvpv59Iax1nF21dasfzfY2Ee4SBtqzvii/PWhGhY1TqRBMlyynVvJE+HAx/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726853618; c=relaxed/simple;
	bh=fuWeZdZAtXd8rMGyPZJvoL1he1KOv88DgrMKYX9gf5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HIIWatCi+u1Qn0/2Jub5uK0S2CohGz5rmEPjXIGKkZNm7gFlONBmi6vra5wzSwC4MWZIO+yDU0k6gNXiNIJQr4TW4tgJf73WKJvaxdub35oCjMQy6cJ6DsESkDGT5Sd2dYMXzuOGAxJoYtt5OItwF2qhzYHsRDEak8uPI0y27Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W7pMnu3g; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb9a0c300so19784585e9.0
        for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726853613; x=1727458413; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vv19IsM1bE4LEmErHqweMrxFva6RQxz/zQSSqYTyIdM=;
        b=W7pMnu3gb7XeABh9C/uvNH1n9tSB9JVgFijVt7v6nlQgq3kves57eqBVnfh33fCMFv
         MDImJzNUk0CDnzxmupVBOsUfLah4bym5v41yGo5IS3ui6EGniFDS0e3YPRcN4qFSSHxk
         NT9MIysWaoyJuHCAuQojP9+i0l39OHT/sf/CKX65xNhNAhIK4hRECTF+MBe2Q/o1FNcG
         gZFsOHb9P4YUphabLsQkTWyKMUn/DMAmdhaCYHaDd5q1CBfvAGsQWLbmWnO6xi20Q8Wr
         6fumoKuZn12c/ovuCRsM40qAdJAkfqQzg52+FVQQPaLvgNeIfnIuwFGcsEQ9HdZfQF7A
         hVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726853613; x=1727458413;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vv19IsM1bE4LEmErHqweMrxFva6RQxz/zQSSqYTyIdM=;
        b=BkRGRs2rfwjbQlexn1CdjXthIr29ny5TJnOlhziwdk1omUu00YD1EeP3Zwtu67e0kp
         QiPrecW8CKKDAybw5bI+UA5r4NBGf+gFtv+GYUeptgpybOqFvKHTyXn1YsmnoOIgsNlT
         IaVPVQZSvwU3tmHBh75jhvxfHwIU+c0Dn55ualE9TlSqAp0+DWc9KcakGva1zqBBMs6K
         jYtWbiwbMEm9FH+neiCxyptLk3Ra09o33BJKUsjn23pRPhAyK0BHwDBPHQq14MFhqYLZ
         yo+qsXYONUMscZwgHPnPU+Aobm5IqoxUX5hlYdzzineDTZLwk1+gnqaevVcHmeTOY+pT
         aiWw==
X-Gm-Message-State: AOJu0Yxk3UzjkdOqwhKbqN9rmZL7KebuvYx42P+10wTdHECOiGiZbZOW
	QYq7gjN2Amjx7pcvq1n9pvkjn+SKUvWkwDZC7+V1fqV/ybZ8j/vRkQQ25TGX9wY=
X-Google-Smtp-Source: AGHT+IGL6vfqfGi6Z7IWSrm4xlJwm4PF1Z7woAUfWI1dOX15RNSvnp51jlUH8XoytHh9rGsz/L7kSQ==
X-Received: by 2002:a5d:6e92:0:b0:374:c945:2569 with SMTP id ffacd0b85a97d-37a4227192fmr1913676f8f.15.1726853612504;
        Fri, 20 Sep 2024 10:33:32 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780e029sm18111177f8f.116.2024.09.20.10.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:33:31 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Fri, 20 Sep 2024 17:33:27 +0000
Subject: [PATCH v2 07/10] iio: adc: ad7606: Add compatibility to fw_nodes
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240920-ad7606_add_iio_backend_support-v2-7-0e78782ae7d0@baylibre.com>
References: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
In-Reply-To: <20240920-ad7606_add_iio_backend_support-v2-0-0e78782ae7d0@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Michal Marek <mmarek@suse.com>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, 
 Guillaume Stols <gstols@baylibre.com>, jstephan@baylibre.com
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726853604; l=14598;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=fuWeZdZAtXd8rMGyPZJvoL1he1KOv88DgrMKYX9gf5A=;
 b=dbMIwK0lwOnaaMdTebmlSP9dy4cLxLrx9/I8U1qI/hBlefobVsgli89cD96H91ZdchZJPxhik
 5cmLe6R7qozDRWGrCGMcseX9pBF0dBx5Bvge0212Q2Xky88dJkEdb+w
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

On the parallel version, the current implementation is only compatible
with id tables and won't work with fw_nodes, this commit intends to fix
it.

Also, chip info is moved in the .h file so to be accessible to all the
driver files that can set a pointer to the corresponding chip as the
driver data.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 208 ++++++++++++++++++++++++-------------------
 drivers/iio/adc/ad7606.h     |  34 +++++--
 drivers/iio/adc/ad7606_par.c |  29 +++---
 drivers/iio/adc/ad7606_spi.c |  31 ++++---
 4 files changed, 173 insertions(+), 129 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index b98057138295..7f2ff1674638 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -51,6 +51,116 @@ static const unsigned int ad7616_oversampling_avail[8] = {
 	1, 2, 4, 8, 16, 32, 64, 128,
 };
 
+static const struct iio_chan_spec ad7605_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(4),
+	AD7605_CHANNEL(0),
+	AD7605_CHANNEL(1),
+	AD7605_CHANNEL(2),
+	AD7605_CHANNEL(3),
+};
+
+static const struct iio_chan_spec ad7606_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+	AD7606_CHANNEL(0),
+	AD7606_CHANNEL(1),
+	AD7606_CHANNEL(2),
+	AD7606_CHANNEL(3),
+	AD7606_CHANNEL(4),
+	AD7606_CHANNEL(5),
+	AD7606_CHANNEL(6),
+	AD7606_CHANNEL(7),
+};
+
+/*
+ * The current assumption that this driver makes for AD7616, is that it's
+ * working in Hardware Mode with Serial, Burst and Sequencer modes activated.
+ * To activate them, following pins must be pulled high:
+ *	-SER/PAR
+ *	-SEQEN
+ * And following pins must be pulled low:
+ *	-WR/BURST
+ *	-DB4/SER1W
+ */
+static const struct iio_chan_spec ad7616_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(16),
+	AD7606_CHANNEL(0),
+	AD7606_CHANNEL(1),
+	AD7606_CHANNEL(2),
+	AD7606_CHANNEL(3),
+	AD7606_CHANNEL(4),
+	AD7606_CHANNEL(5),
+	AD7606_CHANNEL(6),
+	AD7606_CHANNEL(7),
+	AD7606_CHANNEL(8),
+	AD7606_CHANNEL(9),
+	AD7606_CHANNEL(10),
+	AD7606_CHANNEL(11),
+	AD7606_CHANNEL(12),
+	AD7606_CHANNEL(13),
+	AD7606_CHANNEL(14),
+	AD7606_CHANNEL(15),
+};
+
+const struct ad7606_chip_info ad7605_4_info = {
+	.channels = ad7605_channels,
+	.num_channels = 5,
+	.name = "ad7605-4",
+	.id = ID_AD7605_4,
+};
+EXPORT_SYMBOL_NS_GPL(ad7605_4_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7606_8_info = {
+	.channels = ad7606_channels,
+	.num_channels = 9,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.name = "ad7606-8",
+	.id = ID_AD7606_8,
+};
+EXPORT_SYMBOL_NS_GPL(ad7606_8_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7606_6_info = {
+	.channels = ad7606_channels,
+	.num_channels = 7,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.name = "ad7606-6",
+	.id = ID_AD7606_6,
+};
+EXPORT_SYMBOL_NS_GPL(ad7606_6_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7606_4_info = {
+	.channels = ad7606_channels,
+	.num_channels = 5,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.name = "ad7606-4",
+	.id = ID_AD7606_4,
+};
+EXPORT_SYMBOL_NS_GPL(ad7606_4_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7606b_info = {
+	.channels = ad7606_channels,
+	.num_channels = 9,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.name = "ad7606B",
+	.id = ID_AD7606B,
+};
+EXPORT_SYMBOL_NS_GPL(ad7606b_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7616_info = {
+	.channels = ad7616_channels,
+	.num_channels = 17,
+	.oversampling_avail = ad7616_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
+	.os_req_reset = true,
+	.init_delay_ms = 15,
+	.name = "ad7616",
+	.id = ID_AD7616,
+};
+EXPORT_SYMBOL_NS_GPL(ad7616_info, IIO_AD7606);
+
 int ad7606_reset(struct ad7606_state *st)
 {
 	if (st->gpio_reset) {
@@ -395,96 +505,6 @@ static const struct attribute_group ad7606_attribute_group_range = {
 	.attrs = ad7606_attributes_range,
 };
 
-static const struct iio_chan_spec ad7605_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(4),
-	AD7605_CHANNEL(0),
-	AD7605_CHANNEL(1),
-	AD7605_CHANNEL(2),
-	AD7605_CHANNEL(3),
-};
-
-static const struct iio_chan_spec ad7606_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_CHANNEL(0),
-	AD7606_CHANNEL(1),
-	AD7606_CHANNEL(2),
-	AD7606_CHANNEL(3),
-	AD7606_CHANNEL(4),
-	AD7606_CHANNEL(5),
-	AD7606_CHANNEL(6),
-	AD7606_CHANNEL(7),
-};
-
-/*
- * The current assumption that this driver makes for AD7616, is that it's
- * working in Hardware Mode with Serial, Burst and Sequencer modes activated.
- * To activate them, following pins must be pulled high:
- *	-SER/PAR
- *	-SEQEN
- * And following pins must be pulled low:
- *	-WR/BURST
- *	-DB4/SER1W
- */
-static const struct iio_chan_spec ad7616_channels[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(16),
-	AD7606_CHANNEL(0),
-	AD7606_CHANNEL(1),
-	AD7606_CHANNEL(2),
-	AD7606_CHANNEL(3),
-	AD7606_CHANNEL(4),
-	AD7606_CHANNEL(5),
-	AD7606_CHANNEL(6),
-	AD7606_CHANNEL(7),
-	AD7606_CHANNEL(8),
-	AD7606_CHANNEL(9),
-	AD7606_CHANNEL(10),
-	AD7606_CHANNEL(11),
-	AD7606_CHANNEL(12),
-	AD7606_CHANNEL(13),
-	AD7606_CHANNEL(14),
-	AD7606_CHANNEL(15),
-};
-
-static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
-	/* More devices added in future */
-	[ID_AD7605_4] = {
-		.channels = ad7605_channels,
-		.num_channels = 5,
-	},
-	[ID_AD7606_8] = {
-		.channels = ad7606_channels,
-		.num_channels = 9,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7606_6] = {
-		.channels = ad7606_channels,
-		.num_channels = 7,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7606_4] = {
-		.channels = ad7606_channels,
-		.num_channels = 5,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7606B] = {
-		.channels = ad7606_channels,
-		.num_channels = 9,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7616] = {
-		.channels = ad7616_channels,
-		.num_channels = 17,
-		.oversampling_avail = ad7616_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
-		.os_req_reset = true,
-		.init_delay_ms = 15,
-	},
-};
-
 static int ad7606_request_gpios(struct ad7606_state *st)
 {
 	struct device *dev = st->dev;
@@ -624,7 +644,7 @@ static void ad7606_pwm_disable(void *data)
 }
 
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
-		 const char *name, unsigned int id,
+		 const struct ad7606_chip_info *chip_info,
 		 const struct ad7606_bus_ops *bops)
 {
 	struct ad7606_state *st;
@@ -653,7 +673,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		return dev_err_probe(dev, ret,
 				     "Failed to enable specified AVcc supply\n");
 
-	st->chip_info = &ad7606_chip_info_tbl[id];
+	st->chip_info = chip_info;
 
 	if (st->chip_info->oversampling_num) {
 		st->oversampling_avail = st->chip_info->oversampling_avail;
@@ -676,7 +696,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			indio_dev->info = &ad7606_info_no_os_or_range;
 	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->name = name;
+	indio_dev->name = chip_info->name;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
@@ -758,7 +778,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 					NULL,
 					&ad7606_interrupt,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					name, indio_dev);
+					chip_info->name, indio_dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index c13dda444526..18c87fe9a41a 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -38,8 +38,19 @@
 	AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),\
 		0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
 
+enum ad7606_supported_device_ids {
+	ID_AD7605_4,
+	ID_AD7606_8,
+	ID_AD7606_6,
+	ID_AD7606_4,
+	ID_AD7606B,
+	ID_AD7616,
+};
+
 /**
  * struct ad7606_chip_info - chip specific information
+ * @name		device name
+ * @id			device id
  * @channels:		channel specification
  * @num_channels:	number of channels
  * @oversampling_avail	pointer to the array which stores the available
@@ -50,6 +61,8 @@
  *			after a restart
  */
 struct ad7606_chip_info {
+	enum ad7606_supported_device_ids id;
+	const char			*name;
 	const struct iio_chan_spec	*channels;
 	unsigned int			num_channels;
 	const unsigned int		*oversampling_avail;
@@ -150,19 +163,22 @@ struct ad7606_bus_ops {
 };
 
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
-		 const char *name, unsigned int id,
+		 const struct ad7606_chip_info *info,
 		 const struct ad7606_bus_ops *bops);
 
 int ad7606_reset(struct ad7606_state *st);
 
-enum ad7606_supported_device_ids {
-	ID_AD7605_4,
-	ID_AD7606_8,
-	ID_AD7606_6,
-	ID_AD7606_4,
-	ID_AD7606B,
-	ID_AD7616,
-};
+extern const struct ad7606_chip_info ad7605_4_info;
+
+extern const struct ad7606_chip_info ad7606_8_info;
+
+extern const struct ad7606_chip_info ad7606_6_info;
+
+extern const struct ad7606_chip_info ad7606_4_info;
+
+extern const struct ad7606_chip_info ad7606b_info;
+
+extern const struct ad7606_chip_info ad7616_info;
 
 #ifdef CONFIG_PM_SLEEP
 extern const struct dev_pm_ops ad7606_pm_ops;
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index d651639c45eb..7bac39033955 100644
--- a/drivers/iio/adc/ad7606_par.c
+++ b/drivers/iio/adc/ad7606_par.c
@@ -11,6 +11,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/types.h>
 
 #include <linux/iio/iio.h>
@@ -89,12 +90,20 @@ static const struct ad7606_bus_ops ad7606_par8_bops = {
 
 static int ad7606_par_probe(struct platform_device *pdev)
 {
-	const struct platform_device_id *id = platform_get_device_id(pdev);
+	const struct ad7606_chip_info *chip_info;
+	const struct platform_device_id *id;
 	struct resource *res;
 	void __iomem *addr;
 	resource_size_t remap_size;
 	int irq;
 
+	if (dev_fwnode(&pdev->dev)) {
+		chip_info = device_get_match_data(&pdev->dev);
+	} else {
+		id = platform_get_device_id(pdev);
+		chip_info = (const struct ad7606_chip_info *)id->driver_data;
+	}
+
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -106,25 +115,25 @@ static int ad7606_par_probe(struct platform_device *pdev)
 	remap_size = resource_size(res);
 
 	return ad7606_probe(&pdev->dev, irq, addr,
-			    id->name, id->driver_data,
+			    chip_info,
 			    remap_size > 1 ? &ad7606_par16_bops :
 			    &ad7606_par8_bops);
 }
 
 static const struct platform_device_id ad7606_driver_ids[] = {
-	{ .name	= "ad7605-4", .driver_data = ID_AD7605_4, },
-	{ .name	= "ad7606-4", .driver_data = ID_AD7606_4, },
-	{ .name	= "ad7606-6", .driver_data = ID_AD7606_6, },
-	{ .name	= "ad7606-8", .driver_data = ID_AD7606_8, },
+	{ .name	= "ad7605-4", .driver_data = (kernel_ulong_t)&ad7605_4_info, },
+	{ .name	= "ad7606-4", .driver_data = (kernel_ulong_t)&ad7606_4_info, },
+	{ .name	= "ad7606-6", .driver_data = (kernel_ulong_t)&ad7606_6_info, },
+	{ .name	= "ad7606-8", .driver_data = (kernel_ulong_t)&ad7606_8_info, },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
 
 static const struct of_device_id ad7606_of_match[] = {
-	{ .compatible = "adi,ad7605-4" },
-	{ .compatible = "adi,ad7606-4" },
-	{ .compatible = "adi,ad7606-6" },
-	{ .compatible = "adi,ad7606-8" },
+	{ .compatible = "adi,ad7605-4", .data = &ad7605_4_info },
+	{ .compatible = "adi,ad7606-4", .data = &ad7606_4_info },
+	{ .compatible = "adi,ad7606-6", .data = &ad7606_6_info },
+	{ .compatible = "adi,ad7606-8", .data = &ad7606_8_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7606_of_match);
diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index d3fbc7c7a823..719f9e09a5f7 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -307,10 +307,10 @@ static const struct ad7606_bus_ops ad7606B_spi_bops = {
 
 static int ad7606_spi_probe(struct spi_device *spi)
 {
-	const struct spi_device_id *id = spi_get_device_id(spi);
+	const struct ad7606_chip_info *chip_info = spi_get_device_match_data(spi);
 	const struct ad7606_bus_ops *bops;
 
-	switch (id->driver_data) {
+	switch (chip_info->id) {
 	case ID_AD7616:
 		bops = &ad7616_spi_bops;
 		break;
@@ -323,28 +323,27 @@ static int ad7606_spi_probe(struct spi_device *spi)
 	}
 
 	return ad7606_probe(&spi->dev, spi->irq, NULL,
-			    id->name, id->driver_data,
-			    bops);
+			    chip_info, bops);
 }
 
 static const struct spi_device_id ad7606_id_table[] = {
-	{ "ad7605-4", ID_AD7605_4 },
-	{ "ad7606-4", ID_AD7606_4 },
-	{ "ad7606-6", ID_AD7606_6 },
-	{ "ad7606-8", ID_AD7606_8 },
-	{ "ad7606b",  ID_AD7606B },
-	{ "ad7616",   ID_AD7616 },
+	{ "ad7605-4", (kernel_ulong_t)&ad7605_4_info },
+	{ "ad7606-4", (kernel_ulong_t)&ad7606_4_info },
+	{ "ad7606-6", (kernel_ulong_t)&ad7606_6_info },
+	{ "ad7606-8", (kernel_ulong_t)&ad7606_8_info },
+	{ "ad7606b",  (kernel_ulong_t)&ad7606b_info },
+	{ "ad7616",   (kernel_ulong_t)&ad7616_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7606_id_table);
 
 static const struct of_device_id ad7606_of_match[] = {
-	{ .compatible = "adi,ad7605-4" },
-	{ .compatible = "adi,ad7606-4" },
-	{ .compatible = "adi,ad7606-6" },
-	{ .compatible = "adi,ad7606-8" },
-	{ .compatible = "adi,ad7606b" },
-	{ .compatible = "adi,ad7616" },
+	{ .compatible = "adi,ad7605-4", &ad7605_4_info },
+	{ .compatible = "adi,ad7606-4", &ad7606_4_info },
+	{ .compatible = "adi,ad7606-6", &ad7606_6_info },
+	{ .compatible = "adi,ad7606-8", &ad7606_8_info },
+	{ .compatible = "adi,ad7606b", &ad7606b_info },
+	{ .compatible = "adi,ad7616", &ad7616_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7606_of_match);

-- 
2.34.1


