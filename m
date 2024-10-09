Return-Path: <linux-pwm+bounces-3579-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AD999774B
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 23:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E25283740
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 21:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074641DFE2B;
	Wed,  9 Oct 2024 21:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d9lL2ZB+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B701A3BDE
	for <linux-pwm@vger.kernel.org>; Wed,  9 Oct 2024 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508317; cv=none; b=g4bgtykhnmDMhDGpCxfr/ibHIWrFLJNE7wbIz0q45MVwzHnonXuS+cQd0FpwvTMu+OuLVrWa7iT1ESsxDeRn/fnlvAX0U6mRPVKzH07aAGjIJWQrWVVbCI8kyvgi6rY2ux94AGLCxotFjq1FDAa/235MJf7yc7ijVvzgXwdBCBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508317; c=relaxed/simple;
	bh=dLQCCQQtufIVRgZujVQA7cz/RTTXW+jz4SwFA6lj5kI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RtNVdU3lFtTGq/ECw/6mvB81RTKxnhTGvBw5N2MPdVjai8LgemHK/LN68Ii3rSUso44EBW+mstl4o/Z9Zl9flhxGI8KDe9ATgzPqfFaR2T6ZMeotAEGsfWl3PSEoGeLXonxR+lmVCmJlUxvgTz2DfSK9FzlELDDNTco+qjflsRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d9lL2ZB+; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5e98ea02c9dso108536eaf.2
        for <linux-pwm@vger.kernel.org>; Wed, 09 Oct 2024 14:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728508313; x=1729113113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=85xyWXXyK86Bi+Vmln4tAd1ehUyjEiDpAVUverCE2bw=;
        b=d9lL2ZB+OKLqCoqZCEWWaOaf3uueN10eA9s2fIKDfWkupTjTDG1ZPwshgjTLqjW48E
         MXqgFnrdd/1KYgXEiwn1vKyR9kchIVEbXr7YP2FHBw6yDZ9u8b9UN9RpxGtUObjDHg4U
         IMdsniKE1XfudJY2tL/BvqXO1FZ+yih6Bv85blMyFhlx3U816VTJekS7G73vpaJwrNA1
         4kLxn/2JlOvTCjqtkWWh2o8z5z9Mog2HnUNv0jvJ3SPi7roTpCcj9U7W6H1xBM0UoFGm
         EqZlFhiNF9nujSVDBniSTjMwakUNycSwmHyftuCDfYsrUIn9XJvG4m2jlVpqqvA7+hNC
         taXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728508313; x=1729113113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=85xyWXXyK86Bi+Vmln4tAd1ehUyjEiDpAVUverCE2bw=;
        b=mhnofO+07hqDsivJKXXgynj/Q8oSg79bsHfI1SXPNsbndoPKcFydNJD+q19VXBDg6b
         /cp01RCwkoZ8fgt/7ijYzOfytbCVTnKhONGbPhaTkX65ZWUrFcqeOPpWi9YFdq+/LZfn
         1Wmv6B80kYthd1D8VGytCQwNxEpp9Rtu9r2JwxH8dTXc8Q+tZaCKXDYnq9nfBOOZXM74
         5NcEIVbCxDAGWuAgCJ8cxw6xKzHzHDbswsUso2SAXIZ6p4nyEHxiAxH17JD7SqntZH74
         mQE+qP7CpCit1PjGULtHn8OyKf67adM5PloPkHgfeG3+KTLFk8SiSiHqY+8fafp8RQOj
         x3Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWixaGYqHiVO0sAMDVxQsnhcp6D5pz8meURqYPB3oEYyWLSTQurW8FEklR4EUmDq22KIoNV2Kn4lsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDLQBY/xAy2nYTSgC6WxwdU47Ax1LCAreVNemOByghzetoL6oF
	q/E9PZuUV7eTaDZaIss0QFdljDDFQ48M+ejWf2CTVm8ebNDISzkEwrR77xNd/KMqGjfR7dI1r/r
	k
X-Google-Smtp-Source: AGHT+IG9U3vkypzlVrStYFq5tKuDwHhP0eam5EiIGPAzX0+MxGE0J9VvLF6lY5aEtgeJJ/YMNlYClQ==
X-Received: by 2002:a05:6820:1690:b0:5e1:eba9:8fe7 with SMTP id 006d021491bc7-5e987b51200mr3161499eaf.3.1728508313372;
        Wed, 09 Oct 2024 14:11:53 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7155688a874sm2455747a34.81.2024.10.09.14.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:11:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 09 Oct 2024 16:11:49 -0500
Subject: [PATCH 1/2] pwm: axi-pwmgen: rename 0x10 register
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-pwm-axi-pwmgen-enable-force_align-v1-1-5d6ad8cbf5b4@baylibre.com>
References: <20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
In-Reply-To: <20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Rename the 0x10 register from REG_CONFIG to REG_RSTN. Also rename the
associated bit macros accordingly.

While touching this, move the bit macros close to the register address
macro for better organization.

According to [1], the name of the 0x10 register is REG_RSTN, and there
is a different register named REG_CONFIG (0x18). So we should not be
using REG_CONFIG for the 0x10 register to avoid confusion.

[1]: http://analogdevicesinc.github.io/hdl/library/axi_pwm_gen/index.html

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index 6e56ceb23d18..e1ddeaa4998b 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -9,7 +9,7 @@
  *
  * Limitations:
  * - The writes to registers for period and duty are shadowed until
- *   LOAD_CONFIG is written to AXI_PWMGEN_REG_CONFIG, at which point
+ *   LOAD_CONFIG is written to AXI_PWMGEN_REG_RSTN, at which point
  *   they take effect.
  * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
  *   enabled channels, which could cause glitching on other channels. It
@@ -33,14 +33,14 @@
 #define AXI_PWMGEN_REG_ID		0x04
 #define AXI_PWMGEN_REG_SCRATCHPAD	0x08
 #define AXI_PWMGEN_REG_CORE_MAGIC	0x0C
-#define AXI_PWMGEN_REG_CONFIG		0x10
+#define AXI_PWMGEN_REG_RSTN		0x10
+#define   AXI_PWMGEN_REG_RSTN_LOAD_CONFIG	BIT(1)
+#define   AXI_PWMGEN_REG_RSTN_RESET		BIT(0)
 #define AXI_PWMGEN_REG_NPWM		0x14
 #define AXI_PWMGEN_CHX_PERIOD(ch)	(0x40 + (4 * (ch)))
 #define AXI_PWMGEN_CHX_DUTY(ch)		(0x80 + (4 * (ch)))
 #define AXI_PWMGEN_CHX_OFFSET(ch)	(0xC0 + (4 * (ch)))
 #define AXI_PWMGEN_REG_CORE_MAGIC_VAL	0x601A3471 /* Identification number to test during setup */
-#define AXI_PWMGEN_LOAD_CONFIG		BIT(1)
-#define AXI_PWMGEN_REG_CONFIG_RESET	BIT(0)
 
 struct axi_pwmgen_ddata {
 	struct regmap *regmap;
@@ -152,7 +152,7 @@ static int axi_pwmgen_write_waveform(struct pwm_chip *chip,
 	if (ret)
 		return ret;
 
-	return regmap_write(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_LOAD_CONFIG);
+	return regmap_write(regmap, AXI_PWMGEN_REG_RSTN, AXI_PWMGEN_REG_RSTN_LOAD_CONFIG);
 }
 
 static int axi_pwmgen_read_waveform(struct pwm_chip *chip,
@@ -223,7 +223,7 @@ static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
 	}
 
 	/* Enable the core */
-	ret = regmap_clear_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_REG_CONFIG_RESET);
+	ret = regmap_clear_bits(regmap, AXI_PWMGEN_REG_RSTN, AXI_PWMGEN_REG_RSTN_RESET);
 	if (ret)
 		return ret;
 

-- 
2.43.0


