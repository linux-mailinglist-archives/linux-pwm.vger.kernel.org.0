Return-Path: <linux-pwm+bounces-3578-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E69A799774C
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 23:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67253B216FF
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Oct 2024 21:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85851E2821;
	Wed,  9 Oct 2024 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GgcjrlGC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7661DFE2B
	for <linux-pwm@vger.kernel.org>; Wed,  9 Oct 2024 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728508317; cv=none; b=p9e9Rg5Zv2ZmVfOri+NmXBBtr10B6TETgGFngOP90N1SFFb1v5v/2+9q9V3GhB3G/Xmc/Sa91Xi+C8GK/8TyuPODfjkeFhpJvhnG+U21iy0YdkOlL5+6e4D1dCtdSNLU8p0cnjZjW5h9B9hmTmNN35bvtJaVR7WdB56QaX/wufQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728508317; c=relaxed/simple;
	bh=0cV0cyyyQ1bZABKVOC7av6Ej39bBbJtonUrGUcTyX1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJXjhubHLVc0fvKVriZGXUioAnoyK0AdGTWmUhqd0D+faMzvWcFgHgCWDs5LRfxc3qhZ7dLvFRIWjfNmfXBHhbRf147/BJggu2G2K/SEJW8IZev3oKXmzPvNExisqsvynIqgiGvxcsp7SkV6dVmlZyA5etmMtvTauHOPEGLpdZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GgcjrlGC; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-710dad96bf7so105510a34.0
        for <linux-pwm@vger.kernel.org>; Wed, 09 Oct 2024 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728508315; x=1729113115; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rVFF0E6/gb9kFOjmVnyiMsngj2f6Uhyx5US2JDKt1a0=;
        b=GgcjrlGCLVO6ogpw8zjbBJN/wk13EsMrhrDITIgEgf1PhHLP7XeUW1RP1a3tI4WY18
         gvwRf51szIWuZAoemMkT7iugnQWj2ry429A+lN3ttNkDqxTLKn1ApORV4evFqL8EGTfT
         Gmn89D6pbqsoM9oQuJ+kKL8caM1SJ+Jr3DaiUQ9FN5yG0PE3lPdIYGkO37vzvxLXDkhC
         W8L5DoQgxBPvoqo9hIjO19AUrf6vf80eSJQzg1rbiiHctDCxyZlsWDQGHM7kaJD17b9p
         v3yPuBi6IjVozodTflg+zRhO+yU0U8+RULQFBfyXGGa0nxoENXL+C7H2KxVq33EbJC9L
         PvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728508315; x=1729113115;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rVFF0E6/gb9kFOjmVnyiMsngj2f6Uhyx5US2JDKt1a0=;
        b=tNWtErUedR2G6h8DebldSYS0ieE54yqBnF61LcZZHroXS/RkR5xPw6qFwGP8VTklvd
         FmjuuugFgCi4b0+oVnWUZDwQiqCNwToRZQvzDipP9SNaJe+Jr4bQNybRy4QPjG5piFPX
         Z+zs5+B4lGSHl3Vjup8Pt9T74bo4DTKbF+y1osoNBbjOuVzWtWyKDW8yH+GVi7tTG6iY
         veatjViX9GbQ1ye5Xe7aqk75wG57t7LWtjlKnjUgXoP4ULlEtwAyzTe5z3CtSc7bKyPC
         MPMHThdBblpZgQb0c6at6RK/PgaQ58GHKdA+EI3rPN9sxnxuk5zyfquC5bENL3EDEn9R
         FktA==
X-Forwarded-Encrypted: i=1; AJvYcCXV2YLyyUZRBB/PcJGBRA5nBIUAD+bTJjqcazuQ6T6sL5QolmtdW9DiUSvjHaTGTgHwaajo/YIDmLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXpRyS9Npoiv9rxFQrlbmgFUmZDA6Qo0gmzaUDmSrAd26xyvE
	C8TxZcVi4nWl89W678yeaW4HniUvqJCIlrw5HVvzbEAm9hBCy+DbkwTlzrtKpnBlxhZeLAOeC32
	S
X-Google-Smtp-Source: AGHT+IEvJZngVeGRk73y394qZT0oT0wpSwPHi2bTK3SdGZFK1isXZ+7q99wfWlKZqLS1SWgXBcDzAQ==
X-Received: by 2002:a05:6830:6c0f:b0:709:3b06:d578 with SMTP id 46e09a7af769-716a4218490mr2332056a34.26.1728508315134;
        Wed, 09 Oct 2024 14:11:55 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7155688a874sm2455747a34.81.2024.10.09.14.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 14:11:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 09 Oct 2024 16:11:50 -0500
Subject: [PATCH 2/2] pwm: axi-pwmgen: enable FORCE_ALIGN by default
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241009-pwm-axi-pwmgen-enable-force_align-v1-2-5d6ad8cbf5b4@baylibre.com>
References: <20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
In-Reply-To: <20241009-pwm-axi-pwmgen-enable-force_align-v1-0-5d6ad8cbf5b4@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Enable the FORCE_ALIGN flag by default in the AXI PWMGEN driver. This
flag makes the behavior of the PWM output consistent with the
description at the top of the driver file.

    * Limitations:
    * - The writes to registers for period and duty are shadowed until
    *   LOAD_CONFIG is written to AXI_PWMGEN_REG_RSTN, at which point
    *   they take effect.
    * - Writing LOAD_CONFIG also has the effect of re-synchronizing all
    *   enabled channels, which could cause glitching on other channels. It
    *   is therefore expected that channels are assigned harmonic periods
    *   and all have a single user coordinating this.

Without this flag, the PWM output does not change until the period of
all PWM output channels has run out, which makes the PWM impossible to
use in some cases because it takes too long to change the output.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index e1ddeaa4998b..4259a0db9ff4 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -37,6 +37,8 @@
 #define   AXI_PWMGEN_REG_RSTN_LOAD_CONFIG	BIT(1)
 #define   AXI_PWMGEN_REG_RSTN_RESET		BIT(0)
 #define AXI_PWMGEN_REG_NPWM		0x14
+#define AXI_PWMGEN_REG_CONFIG		0x18
+#define   AXI_PWMGEN_REG_CONFIG_FORCE_ALIGN	BIT(1)
 #define AXI_PWMGEN_CHX_PERIOD(ch)	(0x40 + (4 * (ch)))
 #define AXI_PWMGEN_CHX_DUTY(ch)		(0x80 + (4 * (ch)))
 #define AXI_PWMGEN_CHX_OFFSET(ch)	(0xC0 + (4 * (ch)))
@@ -227,6 +229,16 @@ static int axi_pwmgen_setup(struct regmap *regmap, struct device *dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Enable force align so that changes to PWM period and duty cycle take
+	 * effect immediately. Otherwise, the effect of the change is delayed
+	 * until the period of all channels run out, which can be long after the
+	 * apply function returns.
+	 */
+	ret = regmap_set_bits(regmap, AXI_PWMGEN_REG_CONFIG, AXI_PWMGEN_REG_CONFIG_FORCE_ALIGN);
+	if (ret)
+		return ret;
+
 	ret = regmap_read(regmap, AXI_PWMGEN_REG_NPWM, &val);
 	if (ret)
 		return ret;

-- 
2.43.0


