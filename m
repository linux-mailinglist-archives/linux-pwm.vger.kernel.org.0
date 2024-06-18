Return-Path: <linux-pwm+bounces-2501-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0402490D3CF
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0101F2493A
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A4515B0EB;
	Tue, 18 Jun 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNVyyMl2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675AC156C70;
	Tue, 18 Jun 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719195; cv=none; b=Bc54u71HAuPuShg+172HhqAJMkLCC8KQEyKpRBNozuUgNsVd8MbzEInq+ZDIq9a0kebQlvjpXeJbXzX7Rc0fh/fTgQYaJOg3/m0ynJj9cNGWHmvX60X6HC2qiX/rvO5Pt+mzcdt3boNJL+0EWW2HR6KEJh43CHJoxXpedBY7O+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719195; c=relaxed/simple;
	bh=3HcxN0k0ztF3vxPnK9xWSo9UBEsozU7BSPW6y11+ONM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uwNQlUxhkaBhM4I5TNW+DqwGYdsSZZxX8aZ4nGcVN77LqjTTR0sYhYHscEcS1MF/Pka8fF27kYZbcF+LiJJTq1nrHxUzWUFoXZS07LXnFpxGpWaqTSqhVV6+5ggz3U1uwSEdLgu1i7vw0H4JE86+6TgyJATYU43hrVDRCRa2mMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNVyyMl2; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57cad4475e0so9142765a12.1;
        Tue, 18 Jun 2024 06:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719192; x=1719323992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7M7fPS8zpDvWWWq0XONmDDcbsza5hIcH9aw/hhjckE=;
        b=HNVyyMl2CMBVwursNQlmfCzTeNwcNFLOn7d7IcXXBxVwR5W6oAHUwOPS6O44wm3FML
         P8RGG8X6VFZaY65pf02sh3MOMBwnCyNUrLFI/VL+lReNjqzzeDI02963AZZyGCgpz//P
         CS6W+oZB8mCPploFBUXCzM4Ck1TXUsXriW4Ty7i+194tExvmtmv3TEU1og8KKsJWC2Yz
         QvDq+ghHydh5UQ9/DzsNoZr921xepG8tdM5iccejbYoCVN/jkU/I11suUCfX+HZaMJfJ
         BNzEp2JgbB3x/HaMAaBSzsvkKIkFtPzydWPOz1fvvMZ5XQl6qL80K245Jbqom4DmqgRB
         dwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719192; x=1719323992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7M7fPS8zpDvWWWq0XONmDDcbsza5hIcH9aw/hhjckE=;
        b=J1nTehkzQ5oIpAJ1oVN1ugbr/Wv+JMT/0issE6VFa6wR9qrPjLG8/YrOWBYHeOv4fb
         vIZH2XoP4Z6yE8zaK0eChB6/rlRnpJQDMMmQayHNSqaDYylXFQJKxvzKmtabdWUJA2na
         UlqW/sxwvbYSPgqyLP/KYdXJ/baKOuaEB+bDokAkURyhNatdV8Tu2AEt6hkfrl+HifRn
         Rm4G+5VoxpeD7JAkXeavW3jOVfrTc4HBzxcwE4MDGfDGmvpdKfg/y5AKMo9gsmmnOM0i
         YYMknAOJAx3YZBg7U+P74TxH/dA74tQIJoyz/Vat2hVpcPCmeI54XgdgTjtfbPq/qAoV
         a1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvxeIf6Sy8uCW/9Oc4sn5n6CB7AJgMC+bdiSiO6fx7yFQMl6dAJTe7dU6lFrfyKSqNVg6mWTnn37JNO0irWBmobXgOtuoW2cFq4dH32gLaplSQepKjUJ7XikZJ7M0fbiR8wmD3XVD1wMt/f4KAkFVwIFJZljR7YfCVTf2Bcocy2wIkNikrqxvgOULx/12hqVe8SV9WZ28oEiVCwy8NU9PoZgTSdEsBJAkyr7dY1526ip9ppFRmc/wDAZzA8nvd8wRQB9D77K5iAgyXXqAfZ2xJbxCMiAQhcy5c3Jr+vI5Z+nx2VOaId3aWNzvVCAZFVKEJ9MJY95Y+KmV0kkAeK0cXP3vkrPLARb2q/ImDA5TgbbXKHCdedD7OdUSrSDUVoOlWHB1m6qaca2b4+eQ2uftjvdDDXYko
X-Gm-Message-State: AOJu0YxycwLmNmR+8gUsTfGi8XMJ2tPysPLXt6Ph21PfG1sJ3QXynwqI
	jx+JLrtvxIEEBJRJr6s4bM/xOIBhOUz4pv/7Ou11OkabyQjISMbu
X-Google-Smtp-Source: AGHT+IFxrH/zkhSdk1MaRK4E+l+p5JQYX08C4NcBilAVk0Op8+DaFkNWiaIzFFcE4tvs1PLeBwnIkA==
X-Received: by 2002:a50:cd1e:0:b0:57c:a4a3:f1fe with SMTP id 4fb4d7f45d1cf-57cf7a926e9mr1837021a12.17.1718719191602;
        Tue, 18 Jun 2024 06:59:51 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.06.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:59:51 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:36 +0300
Subject: [PATCH v3 02/23] gcc-sdm845: Add rates to the GP clocks
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-2-e3f6662017ac@gmail.com>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719184; l=1529;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=3HcxN0k0ztF3vxPnK9xWSo9UBEsozU7BSPW6y11+ONM=;
 b=FrDsj3ETUaVVQUOm6LFM6D0nBF+hdet963cj5SLvZ7Hei+IvuV6/EU9kWQmVy5U92Zb8ZIbV0
 dOFifsD41gAC/4qNSbNS6FuI5+bBgsoWvtPrvXOm97raYLyZG5Ds/10
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

sdm845 has "General Purpose" clocks that can be muxed to
SoC pins.

Those clocks may be used as e.g. PWM sources for external peripherals.
Add more frequencies to the table for those clocks so it's possible
for arbitrary peripherals to make use of them.

See also: bf8bb8eaccf(clk: qcom: gcc-msm8916: Add rates to the GP clocks)

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 drivers/clk/qcom/gcc-sdm845.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
index ea4c3bf4fb9b..0efd3364e8f5 100644
--- a/drivers/clk/qcom/gcc-sdm845.c
+++ b/drivers/clk/qcom/gcc-sdm845.c
@@ -283,7 +283,21 @@ static struct clk_rcg2 gcc_sdm670_cpuss_rbcpr_clk_src = {
 	},
 };
 
+/*
+ * This is a frequency table for "General Purpose" clocks.
+ * These clocks can be muxed to the SoC pins and may be used by
+ * external devices. They're often used as PWM source.
+ *
+ * See comment in gcc-mam8916.c at ftbl_gcc_gp1_3_clk.
+ */
 static const struct freq_tbl ftbl_gcc_gp1_clk_src[] = {
+	F(10000,   P_BI_TCXO,    16,  1, 120),
+	F(20000,   P_BI_TCXO,    16,  1, 60),
+	F(100000,  P_BI_TCXO,    16,  1,  12),
+	F(500000,  P_GPLL0_OUT_EVEN, 12, 1, 100),
+	F(1000000, P_GPLL0_OUT_EVEN, 12, 1, 50),
+	F(2500000, P_GPLL0_OUT_EVEN, 12, 1, 10),
+	F(5000000, P_GPLL0_OUT_EVEN, 12, 1, 5),
 	F(19200000, P_BI_TCXO, 1, 0, 0),
 	F(25000000, P_GPLL0_OUT_EVEN, 12, 0, 0),
 	F(50000000, P_GPLL0_OUT_EVEN, 6, 0, 0),

-- 
2.39.2


