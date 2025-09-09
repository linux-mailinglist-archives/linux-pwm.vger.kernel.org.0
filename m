Return-Path: <linux-pwm+bounces-7268-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83326B4A70B
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 11:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A4717C888
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Sep 2025 09:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4225E286887;
	Tue,  9 Sep 2025 09:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVD5rFBz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E4D284B4C;
	Tue,  9 Sep 2025 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409155; cv=none; b=Zj+ySjUi8hqZJIqG3CufYvU05CBjFs4pfZl51swSNms5OZ2UCrvMvKmGUGyK5MZSLq/nIha49C89BU0ge5kCvEj1gMETc6z0vWK0QPCbaGL9T/i6RxGxSk33w1JRT2fgoKlqO8u/hSIuR7NXl+xL+taqmeFJRz+XJPSd7E2p0s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409155; c=relaxed/simple;
	bh=EOnZ27xLmOQvALaAFP9VwkuIjXwQNuPwqxm6PL3UKf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFGlNpVTzlcE8YSF1eG/7/CQtBD33ZeWBn/iKltGPQVsjnJ4JLWOvA5hT6738ClmLopE2DXEd9mFtcwwurQ0Z9LWVeavAUr/Qv0hrVoeO8JK1ZvcR/BuxUYFrah8CPQfEjCh8n6ZwInlXnzCv4Tw1Wh4NhyMum3hGm45cnlUFKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVD5rFBz; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso2232355e9.3;
        Tue, 09 Sep 2025 02:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409151; x=1758013951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lb4rcEIiXg40WCuMtxBzuk0q0uifApbOgq5qAK4pgac=;
        b=BVD5rFBzDLBqdIBte2mMPl/f8olC2J2O9ryM+sJA6ch7/7E17So+U5tQ1CEWWFWQdi
         gQwANenX0Tm9dhGZsZbFbc/HGubPxN5to+fL7s4u0b39R7YcvrQu9KtSiWH3WYqSPBP4
         v+3PPN2fM6E5pEnwKrzmvTKL+rshKMDyK6eq/wvmu5yMrLeEh/dMaPGVqwryIAPqbO57
         iPjliRQFgu3TLy0WPZ1QLosN7OJOT0qpqA1vIEg9t4aKiauTcLWz13ysHeI26Adn6sE6
         LWJ4JbFu3v8vczS9ozPcLOGhIqJ66mC382XlElzw52bX0D2mSWHpLbKYYrNvy2rlF/aJ
         Cknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409151; x=1758013951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lb4rcEIiXg40WCuMtxBzuk0q0uifApbOgq5qAK4pgac=;
        b=dsnAwQP+/rbce8laPluTWxVtynLkjF7EIq9/iRoAhLfQQpw9DTx5+3f/EktzI2BETX
         puTSk11JzLZF63d4Rzi/lwFwckPXGgADKEU9P6IiRb1hXkN9Ubac1MDKDsocuZownBux
         XPn2yly55a2nA9x0G8Iu3C9mUv23a7Z7e+Jl63usiYqDxmfYjOGcJPLMJnAL2R3UUHXO
         YtUFnoOoJg0VU1BteTp6yfO+zgiQmzi2JleptMabcONbG7P07pYoAa4QF/J3TQD/IcmA
         QtSfsVtJDeN03sS/ifzaKGVmVX28HFpYUuba2ujbPfu1SwMCaxFzxVDRuKXXIPDuCo1a
         uGlg==
X-Forwarded-Encrypted: i=1; AJvYcCVEt4ys6XTLwLZzM2/A6VCCDipzVqC0oZ0VmjDiUVcjs2YlXCk1SweFE/krueaLlvPoPUmtjTOCqc2QusjgPfDsFYg=@vger.kernel.org, AJvYcCWR6wy/7fCcM05X0RZJzb1HitkzjdiTKAdx/BQTGRC30Gv8jFgFYE3pO3KMk0QHt+9Us2BYsHil6Spz@vger.kernel.org, AJvYcCXSixDEVpxbBJo1SBqMD2KCrFZzXAONi0hCYAGetD1+oyCgOUjBlaYQOjHSTpGN5OCh79MeZncY9iI9SJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVomZisfbb8GD4mISKg0y+gz6Px3JB5BFC/4PKrMS744Fy1L9t
	Q/FP3o7FVQ9N1kO9dK/OHscHVHtZIzfoER8ETapfi1d7PLAUXhHygFUu
X-Gm-Gg: ASbGncvgTHDBSrcqyVTaQbt74wRibyoA9vLxTXxzXp6xuVigUsQ9NDd8ehECgAGp88c
	ltvxne3GAZ1ZXYFo1p3HCqpkzbKQykH+3EVnFT1TFOdDak56VechCjtiPzM3Msgk36Z36g7M/js
	yF8nicYgo4Wiu2F9UPjlpKO3qXjemlcCK9nCWImkF06/fBwkj2svs7Qbtz29rihHI7NYNMTGdwv
	2tDXfXEpC81D7olVhnnTkNdCVSYJpFCZw7aPQR/IizDE4gbgnkZDS8ho/uPyidZYSsuyA/Sq37v
	W+U/W4UsDvJnTFTvVQbAFUX6jHS5vf2IVoMk9+ftTgUsnJg4pSinxTTkyD8P3J7sGRav+5W20FR
	ENTlE2dvTDWAeYRJOb6m+SbCNVAsTqwrO+208qWM0tZHjnFkYbS/Nlq0HHzTvtrZfBAEi3iWYxo
	ZTkQuT6gWfub/b
X-Google-Smtp-Source: AGHT+IGCUJe3qahT/OwmRSmeKONrCJWlIh3IuXcJWR0PZDjs/S18F/K6hnXZ0cqxJ0jmc9fNR/1PLg==
X-Received: by 2002:a05:600c:1912:b0:456:1560:7c5f with SMTP id 5b1f17b1804b1-45de24704ccmr71705035e9.14.1757409151213;
        Tue, 09 Sep 2025 02:12:31 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45deff68b43sm6975685e9.2.2025.09.09.02.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:12:30 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v2 6/8] pwm: rzg2l-gpt: Add RZ/G3E support
Date: Tue,  9 Sep 2025 10:12:16 +0100
Message-ID: <20250909091225.128658-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909091225.128658-1-biju.das.jz@bp.renesas.com>
References: <20250909091225.128658-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E GPT support. It has multiple clocks and resets compared to
RZ/G2L. Also prescale field width and factor for calculating prescale
are different.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Added link to hardware manual
 * Updated limitation section
 * Collected tag 
---
 drivers/pwm/pwm-rzg2l-gpt.c | 46 +++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index b247a6c181d5..57621a0bc4ac 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -6,15 +6,21 @@
  *
  * Hardware manual for this IP can be found here
  * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en
+ * https://www.renesas.com/en/document/mah/rzg3e-group-users-manual-hardware
  *
  * Limitations:
  * - Counter must be stopped before modifying Mode and Prescaler.
  * - When PWM is disabled, the output is driven to inactive.
  * - While the hardware supports both polarities, the driver (for now)
  *   only handles normal polarity.
- * - General PWM Timer (GPT) has 8 HW channels for PWM operations and
- *   each HW channel have 2 IOs.
+ * - For RZ/G2L, the General PWM Timer (GPT) has 8 HW channels for PWM
+     operations and each HW channel have 2 IOs (GTIOCn{A, B}).
  * - Each IO is modelled as an independent PWM channel.
+ * - For RZ/G3E, the General PWM Timer (GPT) has 16 HW channels for PWM
+     operations (GPT0: 8 channels, GPT1: 8 Channels) and each HW channel
+     have 4 IOs (GTIOCn{A,AN,B,BN}). The 2 extra IOs GTIOCnAN and GTIOCnBN
+     in RZ/G3E are anti-phase signals of GTIOCnA and GTIOCnB. The
+     anti-phase signals of RZ/G3E are not modelled as PWM channel.
  * - When both channels are used, disabling the channel on one stops the
  *   other.
  * - When both channels are used, the period of both IOs in the HW channel
@@ -153,6 +159,27 @@ static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
 	return prescale;
 }
 
+static u8 rzg3e_gpt_calculate_prescale(u64 period_ticks)
+{
+	u32 prescaled_period_ticks;
+	u8 prescale;
+
+	prescaled_period_ticks = period_ticks >> 32;
+	if (prescaled_period_ticks >= 64 && prescaled_period_ticks < 256) {
+		prescale = 6;
+	} else if (prescaled_period_ticks >= 256 && prescaled_period_ticks < 1024) {
+		prescale = 8;
+	} else if (prescaled_period_ticks >= 1024) {
+		prescale = 10;
+	} else {
+		prescale = fls(prescaled_period_ticks);
+		if (prescale > 1)
+			prescale -= 1;
+	}
+
+	return prescale;
+}
+
 static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
@@ -443,6 +470,14 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
 
+	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, "rst_s");
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert rst_s reset\n");
+
+	clk = devm_clk_get_optional_enabled(dev, "bus");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get bus clock\n");
+
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get clock\n");
@@ -481,6 +516,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rzg2l_gpt_info rzg3e_data = {
+	.calculate_prescale = rzg3e_gpt_calculate_prescale,
+	.gtcr_tpcs_mask = GENMASK(26, 23),
+	.prescale_pow_of_two_mult_factor = 1,
+};
+
 static const struct rzg2l_gpt_info rzg2l_data = {
 	.calculate_prescale = rzg2l_gpt_calculate_prescale,
 	.gtcr_tpcs_mask = GENMASK(26, 24),
@@ -488,6 +529,7 @@ static const struct rzg2l_gpt_info rzg2l_data = {
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
+	{ .compatible = "renesas,r9a09g047-gpt", .data = &rzg3e_data },
 	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
 	{ /* Sentinel */ }
 };
-- 
2.43.0


