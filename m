Return-Path: <linux-pwm+bounces-4093-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246039CF5D9
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 21:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C5D289B43
	for <lists+linux-pwm@lfdr.de>; Fri, 15 Nov 2024 20:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCFA1F943C;
	Fri, 15 Nov 2024 20:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ldfS99y/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4971F7573
	for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731701950; cv=none; b=WZtoSMWcl0bEddsdjJ/UyBPVicMNSwURx9yARUSERyAeNA34+BEZ/Vx1AsajweSz7RppnSvNjW0Y3F1KLzrUncIjOuR7Bjijz3O4B4x+kHVHomUuN0QhHe+HrFc8jM9onroFmoTpDx/vFtNCj86AY6y2plRzJrdEgFz20cSPOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731701950; c=relaxed/simple;
	bh=kKFzcQWwxfRZslAvb5mFTNlEqtJH2JETnWxcZJ5iPUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ql9xqsYvcbGSX5OmYP1Uz7vMliyVlwn5VTIh3+0+RmYC9WeB5YBsQ8DG+8jzMCHiQnZNqaEfFusHPWI0EWuzyM3nb42mUpEzhF+Dv0lDkabx6HVFoOQVf5mE/VnBelryadFYGJHkzdp/3RtzmGO5GG+Bp1hTy8KbVHFsifnDUfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ldfS99y/; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5ebc05007daso546032eaf.1
        for <linux-pwm@vger.kernel.org>; Fri, 15 Nov 2024 12:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1731701945; x=1732306745; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vpBdskAj4GrGKxQ9kXlXTxFK22DsgbpucNoSRiceYI=;
        b=ldfS99y/O3tuXbMZdfeFAVfDiYdZh03qVDkjHx40pWUqnTN2+9eBEKghX838Ijcb6t
         4NdJXyV9tO9Sa2PNEa8genbwt24WgxLIGmDxxsHIIsitudHM9UX2GNv3EKHxzPGbhgcc
         zvKwvLeq4nQhYTu4s1CQnfKtCnaT4oVhXlS4X/xGJB1CuoUPUuOjKFtXOxQTdT7A78nM
         +ohjSpB9+SAUf25PvxBeyLA5PkVBqEP3hp3ahBWOFgOVlCRFc2EiEh/LgEL9csUkBMgf
         hRlPHG9rKSp/J09BmDZIYCwg8U0depZPtyirUNFVZrxy+tU5ikoZPu1/c89akTGstSqp
         VXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731701945; x=1732306745;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vpBdskAj4GrGKxQ9kXlXTxFK22DsgbpucNoSRiceYI=;
        b=rjIkxutDiKZa6U2vEciu0/3rh0cTjAwKiDoHKVJtDABIoM28C9mzxmLi2wzSnDaO6v
         waYDojUw55vWF32sFJaxHVzXlbBRJB7UQmFsIHV09EiRinBt8eogT82A1okD18yR3LWV
         Wa81cwhX2DHFpaClJucay8IbDTw7Z8D7rEohBt69V4HPlfJIWXkt4nrIeTGZ8LLD+rWe
         BisKJlR8lwHdS8ImmOofi7CPK6CjkQKl34kAqRuxMlT8tBhxDcP5mbp52yGgzmWlniQW
         QACzS+ZorI4hZjr12BvgfSkz5EsyJli5xfTstpxDbvXrM1r9H4GmdV8ptBayOZfgzbnJ
         1GxA==
X-Forwarded-Encrypted: i=1; AJvYcCVfPhCPEK1L4Z/oEHIZbI3zLApeGp3dqKFttswxrWWE812ZnMBxQtKEbBbtktgFaWuNQ2AAUh0dU7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ9JLNEUsBprbFXyxlnTrr9w4XicPEHJSowTiKFqlO9M97bVgY
	aTdDsoYEH1crbqr6TdNYDjSU1zqBeDB5C6PnJImFo9k0BjMPwblY2IUegQclNlc=
X-Google-Smtp-Source: AGHT+IEZV3/LjtJ7YJvC8Nl7cg9HoNWJp3fP6XrApsH5OzhF03yxaGbNgop8uGTjsrTSl9FpER7avg==
X-Received: by 2002:a05:6820:260e:b0:5e5:7086:ebe8 with SMTP id 006d021491bc7-5eeab0fbd99mr3753008eaf.0.1731701945295;
        Fri, 15 Nov 2024 12:19:05 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71a780ea62esm748978a34.5.2024.11.15.12.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 12:19:04 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Nov 2024 14:18:50 -0600
Subject: [PATCH v5 11/16] iio: adc: ad7944: don't use storagebits for
 sizing
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-dlech-mainline-spi-engine-offload-2-v5-11-bea815bd5ea5@baylibre.com>
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

Replace use of storagebits with realbits for determining the number of
bytes needed for SPI transfers.

When adding SPI offload support, storagebits will no longer be
guaranteed to be the "best fit" for 16-bit chips so we can no longer
rely on storagebits being the correct size expected by the SPI
framework. Instead, derive the correct size from realbits since it will
always be correct even when SPI offloads are used.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v5 changes: none

v4 changes: new patch in v4
---
 drivers/iio/adc/ad7944.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
index a5aea4e9f1a7..6d1202bd55a0 100644
--- a/drivers/iio/adc/ad7944.c
+++ b/drivers/iio/adc/ad7944.c
@@ -98,6 +98,9 @@ struct ad7944_chip_info {
 	const struct iio_chan_spec channels[2];
 };
 
+/* get number of bytes for SPI xfer */
+#define AD7944_SPI_BYTES(scan_type) ((scan_type).realbits > 16 ? 4 : 2)
+
 /*
  * AD7944_DEFINE_CHIP_INFO - Define a chip info structure for a specific chip
  * @_name: The name of the chip
@@ -164,7 +167,7 @@ static int ad7944_3wire_cs_mode_init_msg(struct device *dev, struct ad7944_adc *
 
 	/* Then we can read the data during the acquisition phase */
 	xfers[2].rx_buf = &adc->sample.raw;
-	xfers[2].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[2].len = AD7944_SPI_BYTES(chan->scan_type);
 	xfers[2].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 3);
@@ -193,7 +196,7 @@ static int ad7944_4wire_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = &adc->sample.raw;
-	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
+	xfers[1].len = AD7944_SPI_BYTES(chan->scan_type);
 	xfers[1].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
@@ -228,7 +231,7 @@ static int ad7944_chain_mode_init_msg(struct device *dev, struct ad7944_adc *adc
 	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
 
 	xfers[1].rx_buf = adc->chain_mode_buf;
-	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits) * n_chain_dev;
+	xfers[1].len = AD7944_SPI_BYTES(chan->scan_type) * n_chain_dev;
 	xfers[1].bits_per_word = chan->scan_type.realbits;
 
 	spi_message_init_with_transfers(&adc->msg, xfers, 2);
@@ -274,12 +277,12 @@ static int ad7944_single_conversion(struct ad7944_adc *adc,
 		return ret;
 
 	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN) {
-		if (chan->scan_type.storagebits > 16)
+		if (chan->scan_type.realbits > 16)
 			*val = ((u32 *)adc->chain_mode_buf)[chan->scan_index];
 		else
 			*val = ((u16 *)adc->chain_mode_buf)[chan->scan_index];
 	} else {
-		if (chan->scan_type.storagebits > 16)
+		if (chan->scan_type.realbits > 16)
 			*val = adc->sample.raw.u32;
 		else
 			*val = adc->sample.raw.u16;
@@ -409,8 +412,7 @@ static int ad7944_chain_mode_alloc(struct device *dev,
 	/* 1 word for each voltage channel + aligned u64 for timestamp */
 
 	chain_mode_buf_size = ALIGN(n_chain_dev *
-		BITS_TO_BYTES(chan[0].scan_type.storagebits), sizeof(u64))
-		+ sizeof(u64);
+		AD7944_SPI_BYTES(chan[0].scan_type), sizeof(u64)) + sizeof(u64);
 	buf = devm_kzalloc(dev, chain_mode_buf_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;

-- 
2.43.0


