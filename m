Return-Path: <linux-pwm+bounces-1964-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D118A7098
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 17:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE141F25B5A
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E7313AD19;
	Tue, 16 Apr 2024 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rRMxwnmE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69E513AA35
	for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 15:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282826; cv=none; b=VMh42LUR7MSRnRK/yIY0bNxVK13QTmXOMZRBnciBG47da2PTTEMCTKboAy7SQwEgt6QrciTdZk7eltGRjG6qZj5Jvx1/WX9zbhr24KitPHG2DSA5fRaleNbdEeMXnyZb1EB86RyspSqjxIfFaO9OsI6fRfPnNjlOQvw1ccXYWMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282826; c=relaxed/simple;
	bh=ojxXgu752EUVlJd1wDMQRlXHtGQrZ5ZPRG8jJVphupw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iVKC/qAz4/g++yVge1vNdQ13gKLZcPe3cO/bYdJSGadtv0EjWIlISM8CtG4LtwON260YsjFiqgYJR6oKqTOabce9O6dJG8GhPKE2yT9XAwFtrlrha7whq/WZ0Ao3btp1AvGRL9dX0v29bJRGCwXywXXCtaCYDVTl48hRz58asF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rRMxwnmE; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a526d0b2349so289335966b.3
        for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282823; x=1713887623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGhN4tMDnWFook0es8LuAXt5ZA9TrdmyBXYcCQvtS3Y=;
        b=rRMxwnmEk3TEEE99r0xUG+k0oVv/WDYATI8rmd8SEYksWwaWc2mG9VkKLaoy00+eDi
         J9lODRgoByE9iSYbM1aQ4im5Dv9vHiiuSxPL/MW6QqJN4NHlKPLrMhHQppkWGZ8RoQVR
         ngcK9XyhOqxODtQRXDnnhImj1Z5qsHsv+rzroj8ZGhs7yZxwycEfbAsx5YBkhMYruLnJ
         zXHUzIz2GJ52cleYt29lgWzhrzftiJDyIhSSSPIjddRtu4uu5ZxyRdVAwsJnoY0M2TqY
         9m/H3VOCsQ25ikgZrOVq6z7hLtIA+2VD/82JsZOAGgHrrZSntBI1ERzN1WEUdS5DPS6/
         i8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282823; x=1713887623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGhN4tMDnWFook0es8LuAXt5ZA9TrdmyBXYcCQvtS3Y=;
        b=hYXyA+i21rNcLI5WzLb/kNsFIoG0uUK7PE+M4N8AYgKbeO8mmjBBIhnitdDTzu/4n/
         uUWrlPlbS+FdPNfyB9dwJcwpX1ZWojnFxeEL0xieE7ppXJFNlaz8naX9sXecVKeNUvEc
         XAtq5KOOevzem931vUMoK23IHcpy6Xz9rqlMPgTMnBZlvP9GAMt5bxU3jZrrVmW+lHQV
         Jm90kW41YSw0OMGwy5BHb0H5f6ye36ILEslTtmDzChcjE2lM5eGZePcph0mvJ32nknC2
         xbo0dUoXansBLD2SBSBNMFKZ7C0wQXsLvQShgf2rPSyh/xwLYQaALqlkNfvKaYJZRXqf
         JRVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7GXTXz+QlEcMYzy6t1FeCKzTve51MJRhCBax25o6sgiHmk9Zg1zqYk2kXOE7LpHEGDh9cAfqvucekKwy2RkXoAecfKjnSN6ia
X-Gm-Message-State: AOJu0YwS/GuifTCTNPjAWtqJI0P8Tr4LEupvAo7zo04Z4l7Kr0DMM2Vc
	irweROx1ev6gTBh2WWsEs3JEz60ZR5bK+Xco/EOe1iEh/BKLiv/vL0hoVtbDxYQcTgdXSkT0oDD
	6dXA=
X-Google-Smtp-Source: AGHT+IHE3IMPQIqSmq6KIJpD1JErkwc/ZC6yokArJ+CPVqxWkiFzKoESqoTqA+wQ8DzRyw7HJwxPgA==
X-Received: by 2002:a17:906:815:b0:a51:ff7e:7a7 with SMTP id e21-20020a170906081500b00a51ff7e07a7mr7894409ejd.31.1713282823327;
        Tue, 16 Apr 2024 08:53:43 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:42 -0700 (PDT)
From: amergnat@baylibre.com
Date: Tue, 16 Apr 2024 17:53:16 +0200
Subject: [PATCH v2 15/18] drm/mediatek: add MT8365 SoC support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v2-15-33ce8864b227@baylibre.com>
References: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
In-Reply-To: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jitao Shi <jitao.shi@mediatek.com>, CK Hu <ck.hu@mediatek.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>, 
 Fabien Parent <fparent@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2801; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=r/rf6DH3u4/RIc/AgVSnOwA+TJLknIEXoBhT9allVNg=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7qMFH+7sfSqeWLXOz/HUS4LGcd89tLTKMjKVO/
 0NzGpSWJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURYmZD/
 92TsXLF05lBYvoV/0KqLPJzeJU4k+zDii6If4+OxnLLmQj/rTZQICYhBS+7EDJmQzZfqau6EvpxklL
 iWd4cz9FNDLn97xOw8qS6XS7a+gZdP0YKxg2ifs0+suc6UKmw//n26Hq5MhL7y1pwebRsv9RV2OqxG
 jeuC5azqD53hm3WT5KLxS3LHpH+6f63na1tFgZnY34Sevc7Q5/E9gUVCjV9K79Nh4Rj3Ai5YLtUKFE
 fUp8KD44okwab+ALRkWRrQocbXZITXD7q7+eAvwDJ+ZchHPpv9mi45qbuPIdm3CMQ0yqzy3ohLfg+I
 NbmgIpXCC9E4dry6GEbCiEGi+C4S0YSx/0skFgKVYWdMXekpAYkZXhoxPVQhXc56tiuWYxUCRo/UE1
 ARFQbEja65OF7bPPtE5ga46JcEX7AGNIC+ycAKk9TMzA5+rEyzIjAeMFydRrRwBRENYVg4/83Ji3eS
 E+uMdRQQAjxOxN6hCvuyBo8U/q+mfMAZjMz5I9J6u0nqkqeUGMBJwJMSeaKPYiljCQMnPmpjb0mdTJ
 +gOUCPWxYPVbdeNBZHFiosO1ZMDPdz3vkybZ6OnMqX3YBuuVgvBKaznDvvayRiqD0T9seflYAXLcuS
 IkqmHyuBsh9Cx/edcgOveyIcGywpSXm94jO2vKGVQpPm/LEJlbJVw/xhIAcQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

From: Fabien Parent <fparent@baylibre.com>

Add DRM support for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 74832c213092..427b601309c4 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -230,6 +230,22 @@ static const unsigned int mt8195_mtk_ddp_ext[] = {
 	DDP_COMPONENT_DP_INTF1,
 };
 
+static const unsigned int mt8365_mtk_ddp_main[] = {
+	DDP_COMPONENT_OVL0,
+	DDP_COMPONENT_RDMA0,
+	DDP_COMPONENT_COLOR0,
+	DDP_COMPONENT_CCORR,
+	DDP_COMPONENT_AAL0,
+	DDP_COMPONENT_GAMMA,
+	DDP_COMPONENT_DITHER0,
+	DDP_COMPONENT_DSI0,
+};
+
+static const unsigned int mt8365_mtk_ddp_ext[] = {
+	DDP_COMPONENT_RDMA1,
+	DDP_COMPONENT_DPI0,
+};
+
 static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
 	.main_path = mt2701_mtk_ddp_main,
 	.main_len = ARRAY_SIZE(mt2701_mtk_ddp_main),
@@ -317,6 +333,14 @@ static const struct mtk_mmsys_driver_data mt8195_vdosys1_driver_data = {
 	.mmsys_dev_num = 2,
 };
 
+static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data = {
+	.main_path = mt8365_mtk_ddp_main,
+	.main_len = ARRAY_SIZE(mt8365_mtk_ddp_main),
+	.ext_path = mt8365_mtk_ddp_ext,
+	.ext_len = ARRAY_SIZE(mt8365_mtk_ddp_ext),
+	.mmsys_dev_num = 1,
+};
+
 static const struct of_device_id mtk_drm_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-mmsys",
 	  .data = &mt2701_mmsys_driver_data},
@@ -344,6 +368,8 @@ static const struct of_device_id mtk_drm_of_ids[] = {
 	  .data = &mt8195_vdosys0_driver_data},
 	{ .compatible = "mediatek,mt8195-vdosys1",
 	  .data = &mt8195_vdosys1_driver_data},
+	{ .compatible = "mediatek,mt8365-mmsys",
+	  .data = &mt8365_mmsys_driver_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_drm_of_ids);
@@ -729,6 +755,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8195-disp-mutex",
 	  .data = (void *)MTK_DISP_MUTEX },
+	{ .compatible = "mediatek,mt8365-disp-mutex",
+	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8173-disp-od",
 	  .data = (void *)MTK_DISP_OD },
 	{ .compatible = "mediatek,mt2701-disp-ovl",
@@ -793,6 +821,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8188-dsi",
 	  .data = (void *)MTK_DSI },
+	{ .compatible = "mediatek,mt8365-dpi",
+	  .data = (void *)MTK_DPI },
 	{ }
 };
 

-- 
2.25.1


