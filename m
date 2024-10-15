Return-Path: <linux-pwm+bounces-3652-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071C499EE63
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 15:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB691C2225E
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 13:57:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C391D514A;
	Tue, 15 Oct 2024 13:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R5+Labys"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD1F1B21B0
	for <linux-pwm@vger.kernel.org>; Tue, 15 Oct 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000603; cv=none; b=juXpgXafrco62bnqPMNoh2YMj+oBiJ0QpCJG8rTt+ci1R5tW5fcuvKWbHVLm8vPhUAyKWGaM/9ew76Drq8vh9VPB7cQylMuMH73p8doL9a9ncs6ReeebQYJGBajE5tBaZYBDLwF5XF/8L/Q0nTrCFF0YGgIJ7Ubh5/+wv3OQ02c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000603; c=relaxed/simple;
	bh=p5W7C9eFQDZ97zIyZZtTH6VbXAEzZrNsKQ8f3gAiwNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b3+XZICRn7Sn8wOr2JtSuNimM9Hh1Z5MTavbvmdOVvsxrGg11ygCfg6M3DboAFZjXzerictgD0dOnRNiS9zeGJqguAkeA7PMEldjX3XObgeTwvx8BMsVplbp8py3dPV0dlcDYCqbx2rYxjQ0ll3h7t/1krcdby7cy2RhZp/MVyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R5+Labys; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4305724c12eso41315265e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 15 Oct 2024 06:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729000597; x=1729605397; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dNGaz3l6gqVCoOrgRrKVESyDKob5nGVERM1ufe0iOM=;
        b=R5+LabysKiKfn7fDQ3Wx6grx74ZhmyMzgIUZT/3a9eXn9zPEDdr/G8qneh+whrHkjF
         446YmHjiHvmObrxB9K4b+cPYPcX3foDH8BTlBoSxYWc+R1jaaGGaGaDjbNE+Dcu42EMy
         aFQIaCIMJe+ACH+xXIlCfsG2v/AlMGIQqi/WmUQyqGh+0wZEDz+kRoAGSIv1z+wP8lwx
         Gtucf9UqgS1lA/Gmj02eK/NAtMhAFa1rfpnyyBj/aal9bqPeLoOk4GrEJoVQsMP8/GP9
         GPhErANBPRv0XqxM8mG4JdMVGNDNIbklv/ZPYpX82l7jdGkLF65Q1hnpSx+d2DhiDXo1
         dwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729000597; x=1729605397;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dNGaz3l6gqVCoOrgRrKVESyDKob5nGVERM1ufe0iOM=;
        b=q4/tx4gdETPMsN06zhNxXsQy1HraJ6fFbbZX44W6PMNdRY4jUmpDhDI5CP62QGvWzJ
         Xhdaxufb0GVEBzISIev1l7DijlMVhVJQUUUY/BORGqSu7s9qn6stpAJMcpPZskfE3Ydo
         txA1PAUHlGdsVcn1lnLb54/xJXsrfbVJzBjIXU4Wp6l7YFCbVnOtCW9NKMyRBPbBnNh6
         fKwg+PzZqTGT2poKdunNUINMeIKKNtL6U4qj6aT/OHi0sAPl0m7DpCQsJp2I6XKYuASw
         AZAVQZeaUfzO/0jVihD30hFPwaYNT8FvoTslP7dTZUDh/NG3TpdFbQ+DXVwdqkKyq+7u
         8EOw==
X-Gm-Message-State: AOJu0YyJxto7Tkb/qOLd+YlgXRDIFRGHfrqvvTN3wJpM9x0c3nJ0H3Np
	pULMO9L0/v+ZN7EcU6osmqcVbN4yDzzI7cBMpJ2BIdVCPj76KTwDhVTrvqnDzjk=
X-Google-Smtp-Source: AGHT+IFIkh6dlqRoSYKOkKuRFQJg4MaUz3gdRyhlx7GycNkyrdUgLUu3pcYOyJBkdac3H/TC5zEe2w==
X-Received: by 2002:a05:600c:3b8a:b0:426:6edf:6597 with SMTP id 5b1f17b1804b1-431255e485dmr107437955e9.19.1729000596915;
        Tue, 15 Oct 2024 06:56:36 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56f241sm18848295e9.22.2024.10.15.06.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 06:56:36 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 15 Oct 2024 13:56:18 +0000
Subject: [PATCH v5 5/8] iio: adc: ad7606: Add compatibility to fw_nodes
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-ad7606_add_iio_backend_support-v5-5-654faf1ae08c@baylibre.com>
References: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
In-Reply-To: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 nuno.sa@analog.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729000592; l=20772;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=p5W7C9eFQDZ97zIyZZtTH6VbXAEzZrNsKQ8f3gAiwNE=;
 b=jEWYPIumcW14EL7S3zdjULrVgwT+Dc6SVyQkhidG17sm5Dsd6l/RZ4m2VS0CBNGPBtjdWTxct
 F28NtKYqmKaBN77fFNNpXu2JxPV7/B5mxiIS/9Soe3Z4hWNIGk+MsoK
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

On the parallel version, the current implementation is only compatible
with id tables and won't work with fw_nodes, this commit intends to fix
it.

Doing so required to declare ad7606_chip_info structures in the .h file
so to make them accessible to all the driver files that can set a
pointer to the corresponding chip as the driver data.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c     | 283 ++++++++++++++++++++++++-------------------
 drivers/iio/adc/ad7606.h     |  32 +++--
 drivers/iio/adc/ad7606_par.c |  30 +++--
 drivers/iio/adc/ad7606_spi.c |  96 +++++++++------
 4 files changed, 254 insertions(+), 187 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index dd4e0c6fce3e..72e0864ba9e4 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -78,6 +78,155 @@ static const unsigned int ad7616_oversampling_avail[8] = {
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
+static const struct iio_chan_spec ad7606_channels_16bit[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+	AD7606_CHANNEL(0, 16),
+	AD7606_CHANNEL(1, 16),
+	AD7606_CHANNEL(2, 16),
+	AD7606_CHANNEL(3, 16),
+	AD7606_CHANNEL(4, 16),
+	AD7606_CHANNEL(5, 16),
+	AD7606_CHANNEL(6, 16),
+	AD7606_CHANNEL(7, 16),
+};
+
+static const struct iio_chan_spec ad7606_channels_18bit[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(8),
+	AD7606_CHANNEL(0, 18),
+	AD7606_CHANNEL(1, 18),
+	AD7606_CHANNEL(2, 18),
+	AD7606_CHANNEL(3, 18),
+	AD7606_CHANNEL(4, 18),
+	AD7606_CHANNEL(5, 18),
+	AD7606_CHANNEL(6, 18),
+	AD7606_CHANNEL(7, 18),
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
+	AD7606_CHANNEL(0, 16),
+	AD7606_CHANNEL(1, 16),
+	AD7606_CHANNEL(2, 16),
+	AD7606_CHANNEL(3, 16),
+	AD7606_CHANNEL(4, 16),
+	AD7606_CHANNEL(5, 16),
+	AD7606_CHANNEL(6, 16),
+	AD7606_CHANNEL(7, 16),
+	AD7606_CHANNEL(8, 16),
+	AD7606_CHANNEL(9, 16),
+	AD7606_CHANNEL(10, 16),
+	AD7606_CHANNEL(11, 16),
+	AD7606_CHANNEL(12, 16),
+	AD7606_CHANNEL(13, 16),
+	AD7606_CHANNEL(14, 16),
+	AD7606_CHANNEL(15, 16),
+};
+
+static int ad7606c_18bit_chan_scale_setup(struct ad7606_state *st,
+					  struct iio_chan_spec *chan, int ch);
+static int ad7606c_16bit_chan_scale_setup(struct ad7606_state *st,
+					  struct iio_chan_spec *chan, int ch);
+static int ad7606_16bit_chan_scale_setup(struct ad7606_state *st,
+					 struct iio_chan_spec *chan, int ch);
+
+const struct ad7606_chip_info ad7605_4_info = {
+	.channels = ad7605_channels,
+	.name = "ad7605-4",
+	.num_channels = 5,
+	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
+};
+EXPORT_SYMBOL_NS_GPL(ad7605_4_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7606_8_info = {
+	.channels = ad7606_channels_16bit,
+	.name = "ad7606-8",
+	.num_channels = 9,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
+};
+EXPORT_SYMBOL_NS_GPL(ad7606_8_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7606_6_info = {
+	.channels = ad7606_channels_16bit,
+	.name = "ad7606-6",
+	.num_channels = 7,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
+};
+EXPORT_SYMBOL_NS_GPL(ad7606_6_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7606_4_info = {
+	.channels = ad7606_channels_16bit,
+	.name = "ad7606-4",
+	.num_channels = 5,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
+};
+EXPORT_SYMBOL_NS_GPL(ad7606_4_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7606b_info = {
+	.channels = ad7606_channels_16bit,
+	.name = "ad7606b",
+	.num_channels = 9,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
+};
+EXPORT_SYMBOL_NS_GPL(ad7606b_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7606c_16_info = {
+	.channels = ad7606_channels_16bit,
+	.name = "ad7606c16",
+	.num_channels = 9,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
+};
+EXPORT_SYMBOL_NS_GPL(ad7606c_16_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7606c_18_info = {
+	.channels = ad7606_channels_18bit,
+	.name = "ad7606c18",
+	.num_channels = 9,
+	.oversampling_avail = ad7606_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
+	.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
+};
+EXPORT_SYMBOL_NS_GPL(ad7606c_18_info, IIO_AD7606);
+
+const struct ad7606_chip_info ad7616_info = {
+	.channels = ad7616_channels,
+	.init_delay_ms = 15,
+	.name = "ad7616",
+	.num_channels = 17,
+	.oversampling_avail = ad7616_oversampling_avail,
+	.oversampling_num = ARRAY_SIZE(ad7616_oversampling_avail),
+	.os_req_reset = true,
+	.scale_setup_cb = ad7606_16bit_chan_scale_setup,
+};
+EXPORT_SYMBOL_NS_GPL(ad7616_info, IIO_AD7606);
+
 int ad7606_reset(struct ad7606_state *st)
 {
 	if (st->gpio_reset) {
@@ -622,128 +771,6 @@ static const struct attribute_group ad7606_attribute_group_range = {
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
-static const struct iio_chan_spec ad7606_channels_16bit[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_CHANNEL(0, 16),
-	AD7606_CHANNEL(1, 16),
-	AD7606_CHANNEL(2, 16),
-	AD7606_CHANNEL(3, 16),
-	AD7606_CHANNEL(4, 16),
-	AD7606_CHANNEL(5, 16),
-	AD7606_CHANNEL(6, 16),
-	AD7606_CHANNEL(7, 16),
-};
-
-static const struct iio_chan_spec ad7606_channels_18bit[] = {
-	IIO_CHAN_SOFT_TIMESTAMP(8),
-	AD7606_CHANNEL(0, 18),
-	AD7606_CHANNEL(1, 18),
-	AD7606_CHANNEL(2, 18),
-	AD7606_CHANNEL(3, 18),
-	AD7606_CHANNEL(4, 18),
-	AD7606_CHANNEL(5, 18),
-	AD7606_CHANNEL(6, 18),
-	AD7606_CHANNEL(7, 18),
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
-	AD7606_CHANNEL(0, 16),
-	AD7606_CHANNEL(1, 16),
-	AD7606_CHANNEL(2, 16),
-	AD7606_CHANNEL(3, 16),
-	AD7606_CHANNEL(4, 16),
-	AD7606_CHANNEL(5, 16),
-	AD7606_CHANNEL(6, 16),
-	AD7606_CHANNEL(7, 16),
-	AD7606_CHANNEL(8, 16),
-	AD7606_CHANNEL(9, 16),
-	AD7606_CHANNEL(10, 16),
-	AD7606_CHANNEL(11, 16),
-	AD7606_CHANNEL(12, 16),
-	AD7606_CHANNEL(13, 16),
-	AD7606_CHANNEL(14, 16),
-	AD7606_CHANNEL(15, 16),
-};
-
-static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
-	/* More devices added in future */
-	[ID_AD7605_4] = {
-		.channels = ad7605_channels,
-		.num_channels = 5,
-		.scale_setup_cb = ad7606_16bit_chan_scale_setup,
-	},
-	[ID_AD7606_8] = {
-		.channels = ad7606_channels_16bit,
-		.num_channels = 9,
-		.scale_setup_cb = ad7606_16bit_chan_scale_setup,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7606_6] = {
-		.channels = ad7606_channels_16bit,
-		.num_channels = 7,
-		.scale_setup_cb = ad7606_16bit_chan_scale_setup,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7606_4] = {
-		.channels = ad7606_channels_16bit,
-		.num_channels = 5,
-		.scale_setup_cb = ad7606_16bit_chan_scale_setup,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7606B] = {
-		.channels = ad7606_channels_16bit,
-		.num_channels = 9,
-		.scale_setup_cb = ad7606_16bit_chan_scale_setup,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7606C_16] = {
-		.channels = ad7606_channels_16bit,
-		.num_channels = 9,
-		.scale_setup_cb = ad7606c_16bit_chan_scale_setup,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7606C_18] = {
-		.channels = ad7606_channels_18bit,
-		.num_channels = 9,
-		.scale_setup_cb = ad7606c_18bit_chan_scale_setup,
-		.oversampling_avail = ad7606_oversampling_avail,
-		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
-	},
-	[ID_AD7616] = {
-		.channels = ad7616_channels,
-		.num_channels = 17,
-		.scale_setup_cb = ad7606_16bit_chan_scale_setup,
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
@@ -922,7 +949,7 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
 	.validate_device = iio_trigger_validate_own_device,
 };
 
-static int ad7606_sw_mode_setup(struct iio_dev *indio_dev, unsigned int id)
+static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
@@ -983,7 +1010,7 @@ static void ad7606_pwm_disable(void *data)
 }
 
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
-		 const char *name, unsigned int id,
+		 const struct ad7606_chip_info *chip_info,
 		 const struct ad7606_bus_ops *bops)
 {
 	struct ad7606_state *st;
@@ -1008,7 +1035,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		return dev_err_probe(dev, ret,
 				     "Failed to enable specified AVcc supply\n");
 
-	st->chip_info = &ad7606_chip_info_tbl[id];
+	st->chip_info = chip_info;
 
 	if (st->chip_info->oversampling_num) {
 		st->oversampling_avail = st->chip_info->oversampling_avail;
@@ -1031,7 +1058,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 			indio_dev->info = &ad7606_info_no_os_or_range;
 	}
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->name = name;
+	indio_dev->name = chip_info->name;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
@@ -1050,7 +1077,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	st->write_scale = ad7606_write_scale_hw;
 	st->write_os = ad7606_write_os_hw;
 
-	ret = ad7606_sw_mode_setup(indio_dev, id);
+	ret = ad7606_sw_mode_setup(indio_dev);
 	if (ret)
 		return ret;
 
@@ -1101,7 +1128,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 					NULL,
 					&ad7606_interrupt,
 					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-					name, indio_dev);
+					chip_info->name, indio_dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index 760cf5e2ecb6..d401d3ab37e0 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -69,6 +69,7 @@ typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
 /**
  * struct ad7606_chip_info - chip specific information
  * @channels:		channel specification
+ * @name		device name
  * @num_channels:	number of channels
  * @scale_setup_cb:	callback to setup the scales for each channel
  * @oversampling_avail	pointer to the array which stores the available
@@ -80,6 +81,7 @@ typedef int (*ad7606_scale_setup_cb_t)(struct ad7606_state *st,
  */
 struct ad7606_chip_info {
 	const struct iio_chan_spec	*channels;
+	const char			*name;
 	unsigned int			num_channels;
 	ad7606_scale_setup_cb_t		scale_setup_cb;
 	const unsigned int		*oversampling_avail;
@@ -199,22 +201,30 @@ struct ad7606_bus_ops {
 	u16 (*rd_wr_cmd)(int addr, char isWriteOp);
 };
 
+/**
+ * struct ad7606_bus_info - agregate ad7606_chip_info and ad7606_bus_ops
+ * @chip_info		entry in the table of chips that describes this device
+ * @bops		bus operations (SPI or parallel)
+ */
+struct ad7606_bus_info {
+	const struct ad7606_chip_info	*chip_info;
+	const struct ad7606_bus_ops	*bops;
+};
+
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
-	ID_AD7606C_16,
-	ID_AD7606C_18,
-	ID_AD7616,
-};
+extern const struct ad7606_chip_info ad7605_4_info;
+extern const struct ad7606_chip_info ad7606_8_info;
+extern const struct ad7606_chip_info ad7606_6_info;
+extern const struct ad7606_chip_info ad7606_4_info;
+extern const struct ad7606_chip_info ad7606b_info;
+extern const struct ad7606_chip_info ad7606c_16_info;
+extern const struct ad7606_chip_info ad7606c_18_info;
+extern const struct ad7606_chip_info ad7616_info;
 
 #ifdef CONFIG_PM_SLEEP
 extern const struct dev_pm_ops ad7606_pm_ops;
diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
index d651639c45eb..b87be2f1ca04 100644
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
@@ -105,26 +114,25 @@ static int ad7606_par_probe(struct platform_device *pdev)
 
 	remap_size = resource_size(res);
 
-	return ad7606_probe(&pdev->dev, irq, addr,
-			    id->name, id->driver_data,
+	return ad7606_probe(&pdev->dev, irq, addr, chip_info,
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
index d12e55123888..44c6031e9e9a 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -334,7 +334,7 @@ static const struct ad7606_bus_ops ad7616_spi_bops = {
 	.sw_mode_config = ad7616_sw_mode_config,
 };
 
-static const struct ad7606_bus_ops ad7606B_spi_bops = {
+static const struct ad7606_bus_ops ad7606b_spi_bops = {
 	.read_block = ad7606_spi_read_block,
 	.reg_read = ad7606_spi_reg_read,
 	.reg_write = ad7606_spi_reg_write,
@@ -352,54 +352,76 @@ static const struct ad7606_bus_ops ad7606c_18_spi_bops = {
 	.sw_mode_config = ad7606c_18_sw_mode_config,
 };
 
+static const struct ad7606_bus_info ad7605_4_bus_info = {
+	.chip_info = &ad7605_4_info,
+	.bops = &ad7606_spi_bops,
+};
+
+static const struct ad7606_bus_info ad7606_8_bus_info = {
+	.chip_info = &ad7606_8_info,
+	.bops = &ad7606_spi_bops,
+};
+
+static const struct ad7606_bus_info ad7606_6_bus_info = {
+	.chip_info = &ad7606_6_info,
+	.bops = &ad7606_spi_bops,
+};
+
+static const struct ad7606_bus_info ad7606_4_bus_info = {
+	.chip_info = &ad7606_4_info,
+	.bops = &ad7606_spi_bops,
+};
+
+static const struct ad7606_bus_info ad7606b_bus_info = {
+	.chip_info = &ad7606b_info,
+	.bops = &ad7606b_spi_bops,
+};
+
+static const struct ad7606_bus_info ad7606c_16_bus_info = {
+	.chip_info = &ad7606c_16_info,
+	.bops = &ad7606b_spi_bops,
+};
+
+static const struct ad7606_bus_info ad7606c_18_bus_info = {
+	.chip_info = &ad7606c_18_info,
+	.bops = &ad7606c_18_spi_bops,
+};
+
+static const struct ad7606_bus_info ad7616_bus_info = {
+	.chip_info = &ad7616_info,
+	.bops = &ad7616_spi_bops,
+};
+
 static int ad7606_spi_probe(struct spi_device *spi)
 {
-	const struct spi_device_id *id = spi_get_device_id(spi);
-	const struct ad7606_bus_ops *bops;
-
-	switch (id->driver_data) {
-	case ID_AD7616:
-		bops = &ad7616_spi_bops;
-		break;
-	case ID_AD7606B:
-	case ID_AD7606C_16:
-		bops = &ad7606B_spi_bops;
-		break;
-	case ID_AD7606C_18:
-		bops = &ad7606c_18_spi_bops;
-		break;
-	default:
-		bops = &ad7606_spi_bops;
-		break;
-	}
+	const struct ad7606_bus_info *bus_info = spi_get_device_match_data(spi);
 
 	return ad7606_probe(&spi->dev, spi->irq, NULL,
-			    id->name, id->driver_data,
-			    bops);
+			    bus_info->chip_info, bus_info->bops);
 }
 
 static const struct spi_device_id ad7606_id_table[] = {
-	{ "ad7605-4", ID_AD7605_4 },
-	{ "ad7606-4", ID_AD7606_4 },
-	{ "ad7606-6", ID_AD7606_6 },
-	{ "ad7606-8", ID_AD7606_8 },
-	{ "ad7606b",  ID_AD7606B },
-	{ "ad7606c-16",  ID_AD7606C_16 },
-	{ "ad7606c-18",  ID_AD7606C_18 },
-	{ "ad7616",   ID_AD7616 },
+	{ "ad7605-4", (kernel_ulong_t)&ad7605_4_bus_info },
+	{ "ad7606-4", (kernel_ulong_t)&ad7606_4_bus_info },
+	{ "ad7606-6", (kernel_ulong_t)&ad7606_6_bus_info },
+	{ "ad7606-8", (kernel_ulong_t)&ad7606_8_bus_info },
+	{ "ad7606b",  (kernel_ulong_t)&ad7606b_bus_info },
+	{ "ad7606c-16", (kernel_ulong_t)&ad7606c_16_bus_info },
+	{ "ad7606c-18", (kernel_ulong_t)&ad7606c_18_bus_info },
+	{ "ad7616",   (kernel_ulong_t)&ad7616_bus_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad7606_id_table);
 
 static const struct of_device_id ad7606_of_match[] = {
-	{ .compatible = "adi,ad7605-4" },
-	{ .compatible = "adi,ad7606-4" },
-	{ .compatible = "adi,ad7606-6" },
-	{ .compatible = "adi,ad7606-8" },
-	{ .compatible = "adi,ad7606b" },
-	{ .compatible = "adi,ad7606c-16" },
-	{ .compatible = "adi,ad7606c-18" },
-	{ .compatible = "adi,ad7616" },
+	{ .compatible = "adi,ad7605-4", .data = &ad7605_4_bus_info },
+	{ .compatible = "adi,ad7606-4", .data = &ad7606_4_bus_info },
+	{ .compatible = "adi,ad7606-6", .data = &ad7606_6_bus_info },
+	{ .compatible = "adi,ad7606-8", .data = &ad7606_8_bus_info },
+	{ .compatible = "adi,ad7606b", .data = &ad7606b_bus_info },
+	{ .compatible = "adi,ad7606c-16", .data = &ad7606c_16_bus_info },
+	{ .compatible = "adi,ad7606c-18", .data = &ad7606c_18_bus_info },
+	{ .compatible = "adi,ad7616", .data = &ad7616_bus_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7606_of_match);

-- 
2.34.1


