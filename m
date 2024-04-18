Return-Path: <linux-pwm+bounces-2024-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D898A9CBF
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 16:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABBEC285C6D
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 14:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CA616F83F;
	Thu, 18 Apr 2024 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iY7UUnCO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C65216F826
	for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449854; cv=none; b=RhfqXGD5gR1X9xuvMAmI1Gy+Vksv40v+DNl9nVdYYSfa9WOV2Xr62ru/Fruxk5dFA9P7Ui0EN5kudhyifu2nk9lryIqX15Scm93PtbOD/c9h5JGPbVL9h5b6kkywHWYpdXc+PGMu43uMMUF0AaGXR4FpBmD1OBiciGbEU4Hi2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449854; c=relaxed/simple;
	bh=CxkLUlifqvxz1G/Eho8b8T4Is6DgFjTZfGPXl6VYPH4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ldEXVHNHWofzqG3kNXCS2ArE4D4LEviaMNa1af9a97hlv9VMvD4Ws1Lil98eu+CqxBM1ziksTv2QMZIvtqd9R72aK44rzRfP24Weh29NNc0p50uJlmG0XrK5e6XAE0rmzvpDioUk8t6oUamaUBqSzccFzag4SFZECELsu5dS/mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iY7UUnCO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41551639550so6571065e9.2
        for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713449849; x=1714054649; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3otSZuiUA0RBdwKSB/5nO1/TIttSyxWSp9sd21V3FQ=;
        b=iY7UUnCOCDIfuaWkby8F4OSsYQlvwKhUME9P7I90NOrEdYT4W52xM1QGV9Ik7G/975
         1u7qM+qJy+fw8Ypa0FbfA2HniKV/bwLlbKrzG+vl11htogEzd7Geco3pkfTskR2WgEcw
         ej05Pnxw9AJCvlZGjbBMiKzFAjyx77Hb1cOA3OvN+neN6o3ZGufO5McrL3pKmeQsGh79
         qXXgPklJBUTD08xpmv1nWBfyU0ekr2xnUG9G2UdpAaIlu2uflacV8PriiybF8g6Se8IL
         zfcbv2QDCh2Ft2HY8SZ/wCY1irk5IKlgqGfnl6doqdDpK5tP1QojtfXqAhAc6yx+KwS1
         EYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449849; x=1714054649;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3otSZuiUA0RBdwKSB/5nO1/TIttSyxWSp9sd21V3FQ=;
        b=MGu6OIn7qWNIjP7XRStohm8e0Wz5YDoIS+GqoNpyR7hxtEEj5AP6lrSl6QVX6Aqchc
         +VpjFirgvOgFvNFRFiw3qVfjU50xKHD5PQQv8WpD54XCCU95zN+FFMljOy/WEDlsCgf8
         pCEBdlBv4K2WDdiLvfY5kwSYjANbJkg+oQupWKY93jHIev3idkJ35wGbUdMK6gi2ezv/
         DTDiSvqCApmg2pc1nd6/PIFvFZMPkMp2VH3OU3kL0VDy4YtlHMSxzVBkXSRY1shrhnai
         kuwZhsutWjAKxn7aqx+6O8l2mymcKxI0tyV/Ol25+rEKzmbGQppxudAVFv3nToY8Lvaj
         wmjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlDlpP2MDAghF/cSXdHNN4CEdvi6znBNfLpr6e6qez9naJCBkbozqsjShzxPJGk6GRJWMmtS0SvDiNUM7yWm7JL8n2UrMC8NAs
X-Gm-Message-State: AOJu0YyT/1f41ngdm53yUPqrJ2+N4VDAPspk2Ukq5CZUxmf2x3SoKDCz
	yEFUC3Y6lDu6i77v/W0DtkZeLDmFXdWBR7KRcyvejMWUR2RdcdgIld4t24AatGs=
X-Google-Smtp-Source: AGHT+IEiQUufXTv7FJcYkp/QB82CY+QyZl0A6G8qICn/+gCfoWDUcq8617KoBHtq/0X/7mU0hAwvqg==
X-Received: by 2002:a05:600c:4ed1:b0:418:d2c5:5c65 with SMTP id g17-20020a05600c4ed100b00418d2c55c65mr2438790wmq.37.1713449849699;
        Thu, 18 Apr 2024 07:17:29 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id i9-20020a05600c354900b004180c6a26b4sm6267510wmq.1.2024.04.18.07.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:17:29 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 18 Apr 2024 16:17:00 +0200
Subject: [PATCH v3 12/17] clk: mediatek: mt8365-mm: fix DPI0 parent
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v3-12-53388f3ed34b@baylibre.com>
References: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com>
In-Reply-To: <20231023-display-support-v3-0-53388f3ed34b@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Fabien Parent <fparent@baylibre.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=CxkLUlifqvxz1G/Eho8b8T4Is6DgFjTZfGPXl6VYPH4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmIStjTlVje5tb59O8ee6DHe2YEYRuzYS3qUOt1aEr
 ArPtZJaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZiErYwAKCRArRkmdfjHURQqNEA
 CYVXzwd+84f6xIO7EyRZqTIThqTCaSd0BOLeBN/VzpJk8gHezkxoYZHgiCRin94aHkjaR7VSMB/Quk
 qBq+TiWTMhA1/zaXb41ylAI+Dyew3JUPmpZ2M5T8yDYNnbEjiOAmGrAM9/+9bsp18Y72CDZgcRkkT3
 +VyS01NGZZsojIayz9SpoHYeJfa/MUxZ3tUyle4MMHJYbvkMs9MNQ619sgiQTWiE2+Q41Fv9dY9VoF
 mbVjtEs7R3f79z7ueli540F92j2WQZ4oJZ6LuQ0fGsXezsTGv/qfuoTmBHIVXRVY8p/9ciqrrnl8BP
 LVfYA2WXi8SJBZxYMYEOspJ2EYlIQyIZ03FG/bPJsvB7CYsuC0f4yqlwA8ARd2T6uoG0xHT3VeKS6Q
 sLNan3y/BScJLyDClVjWhMQXRW2CjNcSRVeM32pj6Ja37+B3RfnaAE9k4jf5pfbRkWxvsk7QPDCrCu
 IvPTDwRJhuyrC7BFmfac8T3JAUirPF00v1tjMXILiYfeA3K+Gm2K4SVmd+9EWgjEJcbf6ucCjlQU/p
 Mz7gTttZFPwcSGfcOzz67IGjCR6OlEXErvSLeC7em/u4Sq1gQIleQ5ecPpwKcZ2V5k4TcHwQn1/IyQ
 AREJ37OCcknpY2fMYZGW6FkM6el89Lz6S94SzjFiEJxeyBPQeCxEds2+saJg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

To have a working display through DPI, a workaround has been
implemented downstream to add "mm_dpi0_dpi0" and "dpi0_sel" to
the DPI node. Shortly, that add an extra clock.

It seems consistent to have the "dpi0_sel" as parent.
Additionnaly, "vpll_dpix" isn't used/managed.

Then, set the "mm_dpi0_dpi0" parent clock to "dpi0_sel".

The new clock tree is:

clk26m
  lvdspll
    lvdspll_X (2, 4, 8, 16)
      dpi0_sel
        mm_dpi0_dpi0

Fixes: d46adccb7966 ("clk: mediatek: add driver for MT8365 SoC")
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/clk/mediatek/clk-mt8365-mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
index 01a2ef8f594e..3f62ec750733 100644
--- a/drivers/clk/mediatek/clk-mt8365-mm.c
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -53,7 +53,7 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM0(CLK_MM_MM_DSI0, "mm_dsi0", "mm_sel", 17),
 	GATE_MM0(CLK_MM_MM_DISP_RDMA1, "mm_disp_rdma1", "mm_sel", 18),
 	GATE_MM0(CLK_MM_MM_MDP_RDMA1, "mm_mdp_rdma1", "mm_sel", 19),
-	GATE_MM0(CLK_MM_DPI0_DPI0, "mm_dpi0_dpi0", "vpll_dpix", 20),
+	GATE_MM0(CLK_MM_DPI0_DPI0, "mm_dpi0_dpi0", "dpi0_sel", 20),
 	GATE_MM0(CLK_MM_MM_FAKE, "mm_fake", "mm_sel", 21),
 	GATE_MM0(CLK_MM_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 22),
 	GATE_MM0(CLK_MM_MM_SMI_LARB0, "mm_smi_larb0", "mm_sel", 23),

-- 
2.25.1


