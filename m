Return-Path: <linux-pwm+bounces-2017-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884B88A9CA8
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 16:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DDBD287859
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB9B16D9CB;
	Thu, 18 Apr 2024 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R+v6Xa+s"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D306C16D4ED
	for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 14:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449842; cv=none; b=rvQ/L8hBJfLur2Um3UuX/ha3ajrLL5COrzgzc0OsPgDtUksqt2JDRrzvsJ1rdgqACXp4atU7zjNY0+nq3y3RGJ9eHtpCc7ykI3zDRhadWUoILkDaf12uKMGjfCMK9R0MU2d1eAcBR2PtBPUXoaApU3XLKJPmgsfR7bxEVEg15R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449842; c=relaxed/simple;
	bh=omY7y/1K73eHoGSHd76iDOimy36Qyn+XVl7JiEAeYb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISNHfOqTMllY8da1VWoMY3vRs0m5ydb4mkKNkHuc9UDfnD7pSx/KUNTOsO1GzAmq9T6u4hDhZG5ee71sfibeD9TaVqeWE9j986bn5Gg80mGfLfkxbCbbRh3VYDcDCe+W32+qvSdxoNixeBQPLVat+iV9hyO+gL2OKucpvRASiXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R+v6Xa+s; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-418c2bf2f15so7935495e9.3
        for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713449839; x=1714054639; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0DG0b/DfAuQ0lpoAh7wbcZZOZxcaD5fpXedR92n3Ro8=;
        b=R+v6Xa+s93M7xfmascl6phroMUjXVyQBpK7UjDxbqEa2iLWI9b05a8Nw1Jdru7Y/CA
         1xYsHecth5UqwpdyGDsUN0xzd5uZR044JUM1KuzUgR/GbMFobc2yzhmSRJ+CBSWPO0qt
         1wGOHtTQ3Be5gWZIGsxkLti0FwePWC7+FGThSIftkRtmnKUayZjlH0qDb2bvyem9Or41
         OX4Gj6UIRPvXSgLXfwFx2fVFsIqTfUQnm84qIRKteuvnOui+KYOL7Wdc/A1cs0uhDEDq
         OTuuSMHGez9rK/IxuVfzCEIQaZRyNfWf+SpzgGeFCY1FOJ3SO00ejN33CYYq3DFb+yZH
         C+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449839; x=1714054639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DG0b/DfAuQ0lpoAh7wbcZZOZxcaD5fpXedR92n3Ro8=;
        b=Wad6rg5KAz9bnPIy/BVQe9dWOpMwsa+A56fcBDBRDGghjESKVvLQYmxJjPksgx8r7i
         d5AeHysSou+/h/1UQTjm/cWuyNrVQgf+Dni09mwDSYiQE1ZNtoli4C9eIr1vIVXwyMKf
         YCWT1KbKYU8ztrpTOBVDBz/T49r1Tn1ZJbVCCdO14dle53OI+I1/5h0Jscj+wvlQ9XuP
         QAbAPV2XFcPJYK5xwYV2+uGb1YInOdEQ/wgPbY0EmSUpWzRac9cnq4aVGKaFpI2kUxqy
         ZHfJpDkmwz0MOpevfUMBWnlsAfPVoO/eKjRRt8uwg1sXb7k2plaXU1TeVHhFE+zPD7bs
         8AoA==
X-Forwarded-Encrypted: i=1; AJvYcCVDjIRlmBvP4Ymun1szf0hXe+7MBT/eC7i706LSCCBrCCLxDqGSaw0ok9j8UcJKWTsxGlxQCNcB4wy+zaJMBS3PrOqH/CIH2F61
X-Gm-Message-State: AOJu0YzMQ2MxPy43F4u+bLAe8LUVGX1uAyldpf6iF1ROrzpl/yJyWrGI
	Bmx4Hbk0iY1BJFI/kxf0+8oxm5nQaEfQeSSa3hpplXH48uO/4tQFXrLn6OecmhY=
X-Google-Smtp-Source: AGHT+IGc8UkY5hUU0SOlQ+WIGwXJnRwFCQFFnKe6zffCNG3YDmpTofKmmzPBVeBk6KtCqcf7OWNn7Q==
X-Received: by 2002:a05:600c:3ac9:b0:418:d3b3:3188 with SMTP id d9-20020a05600c3ac900b00418d3b33188mr2065709wms.27.1713449839274;
        Thu, 18 Apr 2024 07:17:19 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id i9-20020a05600c354900b004180c6a26b4sm6267510wmq.1.2024.04.18.07.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:17:18 -0700 (PDT)
From: amergnat@baylibre.com
Date: Thu, 18 Apr 2024 16:16:54 +0200
Subject: [PATCH v3 06/17] dt-bindings: display: mediatek: dpi: add
 power-domains property
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v3-6-53388f3ed34b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1829; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=l0R/nimPplfZesZQ5psmzigcqOrK2Svu7sgk1YEc9To=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmIStidrUSXn2C+2OPoqTCEjrSs1uAvZ65nuZ80U5B
 +oCvAVKJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZiErYgAKCRArRkmdfjHURXPdD/
 9udyeGAimjp0d/Gvu/tp2AHHzp9p4lotNsBdYQo+coQVnqgTR+wMNASNy7Pxt7p9VYRl+Yk8W/H8cl
 NulRyeef2F1tZPU6nE3gazrF3fGfYmQSe67RTNOp+2mPp7ajGRXJ3MDqabyRxd/qIK/+1W1IsFIYk1
 lQuwS4SYghHk4zjZbnVCchG41jsC+O1QzZubAQBmK5HhYWlC/taQ4kWm9oOS/BxDNeuR2yy+jWG7fV
 gw80gssGmUjFytjwnUERWo9oOnHcAVkCUGxy1uXeyAZ+URnebbF0kz6as9XU0jIBrVnTIP7fRv5byf
 yWsTpdf9AzdPBQRTXIxIpbWatMvwpPqx2PFWrYmCrRDQc3UY9jA1xDiI6sG1Q5KZ1x4ioqobcPCesy
 LGzYk59OaS8jSz2CV3saEWvQY8fBrmXhVDUmIL0FkHjSiJzRGOyTU5UaZ/jHVp9tGjWIXu+GxDwb+T
 RsDgKIzWTpT7Zo/TG0zX1Nbz2CClnooX7PGI5+Vm2CpzQ3ZDPhE/JDdsbnitH/1CLTM3BVKXHJnpWQ
 iQzNRo2m/H6vOSjrtYOcTXhQWUkDX/l8mTEOlyxfNH+DOyBiMf0w2CrXWp8Q6l07whJnb11QdvciWm
 pxZCrSkDVuLRY1uvTSbKhR43wBa9+fVtMKoPU9V3C3DhvaC+AcICx3aEC6bA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

From: Fabien Parent <fparent@baylibre.com>

DPI is part of the display / multimedia block in MediaTek SoCs, and
always have a power-domain (at least in the upstream device-trees).
Add the power-domains property to the binding documentation.

Fixes: 9273cf7d3942 ("dt-bindings: display: mediatek: convert the dpi bindings to yaml")
Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 803c00f26206..e126486e8eac 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -64,6 +64,9 @@ properties:
       Output port node. This port should be connected to the input port of an
       attached HDMI, LVDS or DisplayPort encoder chip.
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -78,11 +81,13 @@ examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/mt8173-clk.h>
+    #include <dt-bindings/power/mt8173-power.h>
 
     dpi0: dpi@1401d000 {
         compatible = "mediatek,mt8173-dpi";
         reg = <0x1401d000 0x1000>;
         interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_LOW>;
+        power-domains = <&spm MT8173_POWER_DOMAIN_MM>;
         clocks = <&mmsys CLK_MM_DPI_PIXEL>,
              <&mmsys CLK_MM_DPI_ENGINE>,
              <&apmixedsys CLK_APMIXED_TVDPLL>;

-- 
2.25.1


