Return-Path: <linux-pwm+bounces-2013-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B438A9C91
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 16:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA7D1C235C9
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1832516C455;
	Thu, 18 Apr 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0MHs0XoH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E25165FD9
	for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449835; cv=none; b=IFf3f4UtJYw2C5xLecXCVYN3teafoIBBMk2AWha+0ZuQ390FVihsAuYRrLjhpvVURAncBd6Banra90mcGUgfHQhG/OmGobPu9sVJob9sWGdj8OmxXZM1uU3i7oUr7JIr7r7Ybg2wPrtWkajR0SccEQeMDW2MRAl1de1+Fm1C8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449835; c=relaxed/simple;
	bh=k+btns924mgO0ndeMmYcNT303bVziMBQNLMXrYRxVa0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S8JVn3yCw70sV1XkE/AhLSXlXgBnkdBc5rC/xgNeaNbQjhKkOw/8XmOYGg5jq5PD0UF/EBlI36FqjHa1LdyfVVE2SgcZ72aWvaiRWGG0oV3ZkfSF5DD4eBtrd84pLCf/r9QSsCxfCacCIxeJQaS/qeNA9YsD0Np0kBbq+nWtKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0MHs0XoH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-417f5268b12so10069265e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 07:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713449830; x=1714054630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qSFnuWZU02Pj+jNQxOwjPB7Yh5V2Ct2ICa/Ty3dFlQI=;
        b=0MHs0XoHuCX8zVdULVmaCBbyR3uIBNL1DGc3twwK/9v2RYPKR22h5r4p8x6kd9gbC/
         sx6lVONtb3queVrMrv2/lSjoRl2z5WvmOnMa+t4ttOSU2GPfuC4Lf5b9whHSbslv1+Mb
         P59TCthXVFb18ct3ZzzAR7q+6YTMPNWn3lHjGk8nSZTmReNi25mjnbeaAzrdYOlTe1ZG
         uziusRSYTXs+e2n99qvcHldKaXY/cuZz+iVY0HaSzJgSfj75NlyZyfRitUbTNtznh3t0
         TBDloFG0k2ORcVVnLc3TkxtqEdWmChO9pw1Wx+WtXsXXMOtZIdYhreTkUyZKS9sRsJYZ
         T2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449830; x=1714054630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qSFnuWZU02Pj+jNQxOwjPB7Yh5V2Ct2ICa/Ty3dFlQI=;
        b=LrXBvn/id8XsB4EBh1biGfSkl6AiCLGDYwrGKy9f+Dh63dT5MoBknsJ9HG7f899G2u
         uHU01441osIO1rj8b3veutXobVlqdsgUW8LykaMwbiNyFgwzcHOeP+e/uwBj8E9+32HV
         wGwscqF0JjSSC2gDux0PlfB7mPZCd08P63BAMHbqEKAHIeYkevErns64TgWJ599bJ97c
         pmt/smiVZHB/9jSTURnQvyMFV9i6HR3oRBwmR20HUZA6EXfcwGVsDhyGJub3rPJHKcai
         Nf8MozDwW/x5hPtUYQi2qsc7Mw3XQnYMsq26gnoIquDzm3JpcG3pMZfaJHXcK1VsZ14X
         7/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVww4ZZa6RjDhIYewKcKO7kob3PrYWEFZMVqAqVEsd1n7UwjGdAftKL9MNbdHZdmb6Xz0bj4nrSgFVG/AOUETI2aRRj+Ptd9K1K
X-Gm-Message-State: AOJu0YxyxMfTG0RVaQmFHywiql6TecmVP01C3eCjxAT3KKnqjd4QIwoD
	bQ2pm00hrVI1zDbIjLU5kty0CtieKal/VOJBzKq3XZc3TczjTDMaHpiEtSNBVbw=
X-Google-Smtp-Source: AGHT+IFH5zwg0DYunY8MHTPUkoUZW6jYQiwpcrjw84bDm8QBlcdfSqPva29r1m6tFBZKlPW0GU48tg==
X-Received: by 2002:a05:600c:3ba4:b0:418:f6b7:429a with SMTP id n36-20020a05600c3ba400b00418f6b7429amr730099wms.27.1713449830604;
        Thu, 18 Apr 2024 07:17:10 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id i9-20020a05600c354900b004180c6a26b4sm6267510wmq.1.2024.04.18.07.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:17:09 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 18 Apr 2024 16:16:49 +0200
Subject: [PATCH v3 01/17] dt-bindings: display: mediatek: aal: add
 compatible for MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v3-1-53388f3ed34b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1032; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=k+btns924mgO0ndeMmYcNT303bVziMBQNLMXrYRxVa0=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmIStiwjjQsGMtkIBC4BIIe8mmC5l4Gh+lOg1h4Dhy
 Wl9VXL+JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZiErYgAKCRArRkmdfjHURUjxD/
 4g49trsbsJN/Y0FHB0Xht+mvp/FZBOgNuCfI+SZcbNnEti9L32hez80bpcp3eUQFn+6zjwkUYkOhUt
 xnKm8fkxFakHCTmmKVpP5PzjrJEi35Vs183xIQGs21+HCLShJuyamUu2PwMx2eEPKjuzeOdYch1pDV
 KWmwe79GtpBowp9iLGCh8tfwd6TzXFSnJw/LvGPNl4WaQ+v9kbzF8d6lAkp9QvLG92ZePSrWlNaqFs
 6HsyhyFT/nIFIUiJyxp7buN5jj/XEYQdo5IcXE4fsYvsTXyI2UPvgf2DSCawfMAhy9W0HGB1cpxOfg
 Sde0gOULET2QSf3qIHvyis2FYE8sLn9Qy6n6eDWqusXKelWS2S+mj7q1zbjLiibDDYuNzdw2L7I3de
 /akgPlmPvmQxMqkSmxj2CvCF/NkzfBLxva0rXJPwtGbk0vJ8scPqofhiA53B7qSO1I5xDD8BEQsHoT
 TM8XStsqw6o2O542hSJ5wXolsYXc7O7LT1XVr8dqgSMVel2XaYiLi3MDSUkx8QxWJfRbQukUNHWimz
 i16o0brEt4WAu9rjERbWeT0Vd+cDN4mz34E6XqY5IxqJd3GMin99psmzCT+x7jGOFy45XxpVKX9IZi
 oh9FtNak9KhKad/TRYV+tzdn5WpciFi53tMAlBmJE1k7idYTGlXzuscWMagg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Document the display Adaptive Ambient Light on MT8365, which is compatible
with that of the MT8183.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
index b4c28e96dd55..cf24434854ff 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
@@ -36,6 +36,7 @@ properties:
               - mediatek,mt8188-disp-aal
               - mediatek,mt8192-disp-aal
               - mediatek,mt8195-disp-aal
+              - mediatek,mt8365-disp-aal
           - const: mediatek,mt8183-disp-aal
 
   reg:

-- 
2.25.1


