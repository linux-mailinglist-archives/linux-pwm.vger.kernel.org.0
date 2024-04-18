Return-Path: <linux-pwm+bounces-2015-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4212B8A9C9A
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 16:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EE291C23B8B
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BD0165FCF;
	Thu, 18 Apr 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vCmiDwVm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557AE16C6A3
	for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449838; cv=none; b=RyA5v6jxFgh3KBabCwK72PiNocx4bjvDREoqPHRnmm9Tj1M1ZfJUtrkV1/qgrDkMVFyPucPuopPudCBtWKjRNrSxK10p83ZCcvFYtVN6G0J4EJVlFyPb0Skk/2ufBiNyDi3A2va0hNEg8YEV5pLcpGPZ9FQ9YHOIemz/jMJFXww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449838; c=relaxed/simple;
	bh=YXHTuzshsIEn0rNsq24IlHvsgB1HSvJsHYliNaoUyEM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q1fzcP7gUmnFLXLF+8pPjCpai7rQ8KfXXkzNyjVWUpFyadcFBe3yo7yb1KWKsaVQml4T8xbixjcZpy4zbtpDVUiQK9EXBWybpZSRUdfh9Dw8q85Nr/5TA3ioJCg0Pw5hXLPplPeIvESc8kJjFuavaqnUsZTlGviLA5ymsAEBDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vCmiDwVm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-418e4cd1ffaso5420375e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713449834; x=1714054634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyegayfB1y9965dzTGr/j6svW4ieRpTfgrhf50HfpFk=;
        b=vCmiDwVmG4/KlNXOwH3d49vfrVhkT2dlu+I8NTSxrIaz3v3cB+77MBDpGbUgz8Xa0X
         jKrpmLIByW0CuHyMuwXXMzex9ZmpH+RNtLpwOEsDv4drVQz1FQDVHmpFAEEMtc4Nog4s
         Al8JaRbEzhSzjGpB/x6W+unhLrmhzU4ysGkD7rLK9E/6+L6e3C5LkUwwIb7a/cJ1pRqb
         /gDgD6QKpUjv70Z9ftxIKbyRgwWrvuEPPOvRc2WW6WMtZumQuhWRvTOqddzr+ONFTVC4
         j0e8gvBJjmy4RlbWpkDTUGyGS2se7H84Vn3EdIbT+TbXA2V/ocZBKdqwXQeEZiNfca8j
         ccZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449834; x=1714054634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyegayfB1y9965dzTGr/j6svW4ieRpTfgrhf50HfpFk=;
        b=fHb5BVPgQqE7PIkHKvqN0fAeNznE55H9jGaY4wh28gurSmupqM3Upz4oftOAYDYRJq
         /+Zy63zdoGLf/nNnhgXnKg96/S4pQctoq78qC3BccS+jn9lmA5VdPjGn1hXWcMJpnjVE
         stIEZ0BsPFDdatX3RWviXqs2KEDsnQdYMDrc44PNFITMIXr9FViA/iMcNx8cfF/d0xK+
         D9qSHfe9T72jNCTLZP03XKV1sRU9sun+dqPtJWWsA+IRddTVGenHe4iL00OW+tA9sOri
         Ykk7PvzBoijflfNN/nnM/QFz3urTkm2bw41B5FXjQXllDMMrdTfuqF2V9dTLGWQLtZDs
         6fbw==
X-Forwarded-Encrypted: i=1; AJvYcCU9Wdy9k5JKqqd7q1Xx+iFOHUaJQeyopsqca03D7wC41MpiFtzx/XW0q3UyuBSSO3sPd9CcyHUMZjBPA8ByDECpRRnuzA1lV/um
X-Gm-Message-State: AOJu0YwWNWhG9cXn/KJZbI5/LlwnYToO+p7+5pcI16f6yFOWHgX3O4RS
	PEyeX5VkxObYroZ91j53swjMfsfVDoJ+dcTdb1fysE/DSZruNHWdN8KzZq+Dycc=
X-Google-Smtp-Source: AGHT+IEsM9iGSZG6iMHAcf9KGu692TY/H0uIe2sVr5xtzSaWVovohbIcJe5VQO0JAYzGjB4DDgOfag==
X-Received: by 2002:a05:600c:a12:b0:415:46be:622f with SMTP id z18-20020a05600c0a1200b0041546be622fmr2167234wmp.14.1713449833987;
        Thu, 18 Apr 2024 07:17:13 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id i9-20020a05600c354900b004180c6a26b4sm6267510wmq.1.2024.04.18.07.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:17:13 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 18 Apr 2024 16:16:51 +0200
Subject: [PATCH v3 03/17] dt-bindings: display: mediatek: color: add
 compatible for MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v3-3-53388f3ed34b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1050; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=YXHTuzshsIEn0rNsq24IlHvsgB1HSvJsHYliNaoUyEM=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmIStiBs53eAY3DeO13tdL6QI+Znbz5FwIwD/YoB8q
 OCNZARyJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZiErYgAKCRArRkmdfjHURTRxD/
 4gQQKtDeVST7qS57VlXtgagtFc35imlFj4VzD0seKTLL22adDD+Ip+d+eb0gMs01I7sN8dXFEh5bvg
 YHauScLtPi02KVPxokKXYmQlf2Hnia3Ac4U2CIqQn9qx7ESmnekahSlsMSi/ZDGNJe2E3jC0Nouumr
 2GoLrM+cEvvITmIQGxQ0qBYTBFfozVIOnREKwm6q5u1hFe4qm93B8LmboqwV7vnhREXHIpV6jbrNM7
 fBILeMgLC9B2iVowiB85EkDYAFkSVRDwLIlPrxWyV4vzmBJiMqKrUxxiZBucBBnDwuEMCCEk45jicD
 gpt8ZNl2Su+SQ0eZ0II7t2SQAwq/QU3gqqk9bQ0QgIGTZhXXHPd77oOQN79mBqp+Bv1g9kmE0njfQ2
 PnxBPb54W6L3g8wPEKq2rpY5FXHfmX8jG6aegE+zbORBnFCapLwB//4rRsRwgT2mOsuIQHZPmYjdfT
 9PIwunu5UQr3olFVkGjxPcUpa39bUs5PQzRDsAK3Q0eqixnGSaPsfYJUPUiCx2JjN+TLjVdhT7nIHh
 6z83C+zeIX6GFmoqhiGvaA9OtHzgux+kntZFd+kage5z3q2BASkPXoQlxIJpeuNJoMVsgU4k6FmBRY
 j9+0Orj4mpUdqNvzLk5YXv6L+BccO9fYqL9Hc979dnUF2953s1vxf74BTmKw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Document the display Color on MT8365, which is compatible
with that of the MT8173.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
index b886ca0d89ea..7df786bbad20 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
@@ -40,6 +40,7 @@ properties:
               - mediatek,mt8188-disp-color
               - mediatek,mt8192-disp-color
               - mediatek,mt8195-disp-color
+              - mediatek,mt8365-disp-color
           - const: mediatek,mt8173-disp-color
   reg:
     maxItems: 1

-- 
2.25.1


