Return-Path: <linux-pwm+bounces-3963-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4CD9B54EF
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 22:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608BF1F22078
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Oct 2024 21:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7636D20ADC6;
	Tue, 29 Oct 2024 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="uFDUo/Yt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D761208237
	for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730236748; cv=none; b=KpbEtw8IjkzrxCO6bL2bZCcVKf99Px1sFbKD1cdD/SMy5TUMXTjDdqO9rjYdtj0J37ihSj5EaTpQty8ye9F+KCFlBhw/6esxdn6XRvJHeRvP3n4Mk+ajLGeW25TbcTmp+uAsPvfwQaoe5bGu7kyv/DpYkN1G6zKEws6vjf34IAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730236748; c=relaxed/simple;
	bh=pTM0zMdu3d6TO9urzgyfiUUlPjCSI6OIMoF7GWE/KtA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CHPeFBxp9AzecgqYrftZFj3vwNLcxm5qYLBMba0bkHksvywojAhq3f9a+MlcmDTRPcTnAQT7CrdMkKO9UPNn9NRPFWpKwbBtY4upHDDdWM8rDAOnAVyVa/rxqxUpx2eYpJ6huBZGkBoQDvBB1uqBdGmwMSK6ZRtBpaU+Wk3AXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=uFDUo/Yt; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3e607556c83so3489212b6e.1
        for <linux-pwm@vger.kernel.org>; Tue, 29 Oct 2024 14:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730236745; x=1730841545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1eyK4YeafZM3wWbxx8SgDvrmQ+/xdJDtwtTgNckCGQ=;
        b=uFDUo/YtT/plC2lRd8HNa3IAb08SCXC9qtTccrzgrUQ0hwU3T5Aku1/ysh9JYrEGWS
         OW3lFbz+UmJm0xXdArKcVcdhIjmJr7tRiTwQqhGaS830VKh719tBA/tHSxxDzcWY7yOs
         lXkRjsjnW24T6hM1DWIuV3Dit/zcQukr/aGG+rX7LHAi2geIZwouqDl7t082a4VMfN2P
         UTKjGtpPpDnp1GHILccA5C91mmliCNjn8+I6L6hMeEu6sli7YVBt23L8Mo3qhRBxJExg
         lJe2VfZrs54xAAwuwqFVM6xiJKVmTLyN2X6TvsEe2l3MKr8M5Q311ZZczN96z1AuIOt8
         Elng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730236745; x=1730841545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x1eyK4YeafZM3wWbxx8SgDvrmQ+/xdJDtwtTgNckCGQ=;
        b=ues4vO2Yglu5a4WcTyLtd0PA3C0yRJeqERgS3W46Dn+oycj1iDpylH+nan27V/Gyt9
         HGG68pifmaYsouqqOTNLNG3d/CpSOcdsDJ+fo/ChQ/MKqSDQGbSWsy5f1JxaCwulGi1S
         17gflk1LQctQXd281xTGQ/b0AURqS9PTkbULGeCe0aJWpgPaB7lrKghpJMUUDBkpFsKQ
         P/PACAXCrN9+JxN4TIEaMYW6aqMwIRWIdZvHCdeyfI+J6vD2L9O/MiyEIc5Ry5aAsZ46
         RFBAxoOegy5DO9qzFqPek4kA9WTmqd1a3Am6D4aCV8pcr3r5SdtdxT2Xs+QXv/Pp9RXP
         lUUA==
X-Forwarded-Encrypted: i=1; AJvYcCVBxA8LVUG9zSJYnkYpcTmmLvq1uvuY1DN/KVYKdozUkOKzRQKUIyCQOhfZ1RvJu9bQYuLrFoYwL74=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuOJp66Hb7IQuOFql/inW+8a2cVKCTPIQJZOAm5NYSndfGrfJV
	kDPkcvamOOl4OsQhgdp0d8BIhztq/6Ibs7zKUueRUv2/eN/dL9opWaHuC5vaziA=
X-Google-Smtp-Source: AGHT+IHNyylNNYk4pJl4v9Wic0OnFFDI+mUGd5rmtr8KeXqE5vw1L04LSd4rV1eOn4xDGik8dGnw4g==
X-Received: by 2002:a05:6808:2183:b0:3e5:fd08:d020 with SMTP id 5614622812f47-3e6384c54ebmr12182255b6e.42.1730236745444;
        Tue, 29 Oct 2024 14:19:05 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e6325b87ecsm2280559b6e.54.2024.10.29.14.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 14:19:04 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 29 Oct 2024 16:18:50 -0500
Subject: [PATCH v2 2/2] iio: adc: ad7606: finish pwm_get_state_hw() TODO
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-pwm-export-pwm_get_state_hw-v2-2-03ba063a3230@baylibre.com>
References: <20241029-pwm-export-pwm_get_state_hw-v2-0-03ba063a3230@baylibre.com>
In-Reply-To: <20241029-pwm-export-pwm_get_state_hw-v2-0-03ba063a3230@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, Guillaume Stols <gstols@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Replace the call to pwm_get_state() with a call to pwm_get_state_hw() in
the ad7606 driver. This allows reading the sampling_frequency attribute
to return the rate the hardware is actually running at rather than the
rate that was requested. These may differ when the hardware isn't
capable of running at exactly the requested frequency.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

I went ahead and made this patch since it is trivial, but it would be
nice to get a Tested-by from Guillaume to make sure it actually works
as expected.
---
 drivers/iio/adc/ad7606.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 8b2046baaa3e..1581eb31b8f9 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -762,11 +762,9 @@ static int ad7606_read_raw(struct iio_dev *indio_dev,
 		*val = st->oversampling;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		/*
-		 * TODO: return the real frequency intead of the requested one once
-		 * pwm_get_state_hw comes upstream.
-		 */
-		pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+		ret = pwm_get_state_hw(st->cnvst_pwm, &cnvst_pwm_state);
+		if (ret < 0)
+			return ret;
 		*val = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, cnvst_pwm_state.period);
 		return IIO_VAL_INT;
 	}

-- 
2.43.0


