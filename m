Return-Path: <linux-pwm+bounces-1953-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D47148A7069
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 17:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 044751C21A06
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 15:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA75137756;
	Tue, 16 Apr 2024 15:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WpaU2LGg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B300513698D
	for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282807; cv=none; b=iIPQsqQ6Qf9hcfTpvnBuLv8qG2GT80K5jfY6tR5dP/SCtY38ezSjsp+UU7gVrJrygv3XjHM94NLiXt3anqQTbLvLBMFDsWTolxXPiThJOXybbzZiTPunhkiyA2EDAXscfUdfDXrKXbBnormyTqHMc5K1gUl2pG3jRCjriXJPlAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282807; c=relaxed/simple;
	bh=r68e1who8MIzDoQBthjo9X95W2QHnDC/iXtL89xaYGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VyOJS/9zwHoKmyL1lCJ5S8gKpCitP/iGg43RWx0MYfDuVUdifEiS8+eSS9eagTPVJcgrdEfgZ+n6Tk7O1urlBXdnrGd+YR5uu56VJLpXsEqX+nRfdu4x8G/2GI0Ed3iNcz90XsrdjE2Bc8Y5wMlXZntS0tw0gRi1KS5cIc8BaRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WpaU2LGg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5200afe39eso568352166b.1
        for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 08:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282804; x=1713887604; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edg7ntX0oubeVIYh5vjQBOw0CX8pMqN2LX3X5tU8FAI=;
        b=WpaU2LGgYzRl3NG+IFSUoXwHITxjB1XmeKMkCptvWxf7G+TUaU6zP2Z14fAZAMBQvj
         4KC+KBktFnPieoAKIT8H9PVVtLf1YxRFuWMVZAA3mheae6Y+vOqIMnZC3Gwmjqs45ESB
         H1GDgHOGPixrjDXaRBKu+j1KPZZ+N/gPDM10Msch3qe4u+4ZdiUICc5ZMKdFCQk+FyTL
         9h1Ugf50FNab8JcYcZEEnSrL5MTjgqnJTcQoQdcVMWiZBe+FAIkW1yWx5FXzgx1XRV1I
         UXPN5/lQvcPla/d+NzCVqXrfqp0QnYwRqUlQx5PlfZh7VqJiAB1t1cUbpJqR79oPVuL6
         HIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282804; x=1713887604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edg7ntX0oubeVIYh5vjQBOw0CX8pMqN2LX3X5tU8FAI=;
        b=jatZk8yKE0Hra+8aOunPQLKZOV3p1LadaGKllX8v7BIb7f0jv5u2vZfKTfg0JyW0FZ
         nxuuFB73MOVkcK7czk3RDHinZuEdEnxaJlT/X3EkiKTT3NFDl5CcgKKu55fPLwBxOu67
         84Jvi/XKbFWjthazRuuXxHRet7v4TdebK6LHezresGSDmnyhMPa3j32EbE8ETbarRBYN
         liXN6TS/RXaHN7ShKGLVmi8pcPa/STmlUW4vBA9GdBZghWfqlaMvXyPRSR+Tj2gIK1/b
         s8t8F2GkecXqZOiqwkXKMvKaak7xz401tBkofCENBiUtGSed+NgIJFeRU/LZT9B471qm
         ZPRg==
X-Forwarded-Encrypted: i=1; AJvYcCWE5f5lFbV/z3GewDO4nvXN8jKSclN48fUEUBj3bwqimdU74o2lVHjg6dQ90LqSN0DRpwJ8m6PQt8516DDoFuAnQV7kWeGKwMpz
X-Gm-Message-State: AOJu0Yyl6hduPVaTEcxvX4wo9cfaaMrfLJAQWOm4Qle6cxNvYPfWB22p
	M6bowr+2IFxQoob8SPtljGsS1dJJK+eCXBBT8ag3dy1wAY0eVWMIH3kbAUZYiGke8DudcwDX/e6
	kBxk=
X-Google-Smtp-Source: AGHT+IESXQOC2i2I+1wisKEvX+KfecwnRuK4o+TRRtDRQMuqOa5FvcWoQ2sFX9HYwV/C43qufmzJlQ==
X-Received: by 2002:a17:907:97c6:b0:a51:caf7:ccc2 with SMTP id js6-20020a17090797c600b00a51caf7ccc2mr13320552ejc.34.1713282804210;
        Tue, 16 Apr 2024 08:53:24 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:23 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 16 Apr 2024 17:53:05 +0200
Subject: [PATCH v2 04/18] dt-bindings: display: mediatek: dither: add
 compatible for MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v2-4-33ce8864b227@baylibre.com>
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
 linux-clk@vger.kernel.org, Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=916; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=r68e1who8MIzDoQBthjo9X95W2QHnDC/iXtL89xaYGw=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7qi3IRZ6AoTAH3S26Bc7tgxEDlvX0zSClY5rSE
 FqixYlCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURW4bD/
 47it9KmX6jUMPorNt/fwXA8Yd6HyIWjHlDU6Ov+ZOq7aNybp+K1Z2ZWa/Id6Wx8n2RADeA8ZyZiHnM
 lHBARvya+AHMri2/Gno2bUGhA6g5XebKqomhEOZBlvyEhs0Sbx8EjK64wr7/Bsvf590gIzwBenBLLf
 gTq4T7hlswVdTEtIK5HVob+1P4pP/SifQGm0GyGVcuvyEGjO8jPmAEzaUgLP+ZIBl2h7ikU1S6YHFJ
 +Ikt70M3YfqB8QxP4AIAVrYiep8Z1kLno9PWvFYcBfzLslx6YqotiQ8mhKvzS8cRD2Q934IAocwJio
 iqY7ZbGUAG38AQ6G8QfYjO6cy92roRY64A2f8CdMsPJKhYfp9msT8wIuSiueIicgJpb+X5rw9sYRon
 SLmCHghPj/DEYgwpPKG45v/Bdh8gWH0AhZRAX+s/mIE+OuWYUPJmt92gcp/ho46+csXkXGKiUUgyta
 y5OmnEwhnstm3Smv4R9hsoKbht8soPnK31q1eHCZyeo8L7t2p/dtCWURvNwsQ3KGR78y6/t3/q6MGI
 mDAkRaGvebNzoS+aSbK6bjvwERLC54boEOWH1GlycC02Mjzoi1IuQlSQK4Hj3YG7LWdZi675DOND+S
 B0qgPjCZaWEgtVB3l8cs1/GQNpsJaAarulInreNNnw+9gZZzXvgCNQ8rX7pw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Document the display Dither on MT8365, which is compatible
with that of the MT8183.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
index 1588b3f7cec7..6fceb1f95d2a 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
@@ -30,6 +30,7 @@ properties:
               - mediatek,mt8188-disp-dither
               - mediatek,mt8192-disp-dither
               - mediatek,mt8195-disp-dither
+              - mediatek,mt8365-disp-dither
           - const: mediatek,mt8183-disp-dither
 
   reg:

-- 
2.25.1


