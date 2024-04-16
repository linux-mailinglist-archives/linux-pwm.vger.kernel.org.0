Return-Path: <linux-pwm+bounces-1955-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256868A7071
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 17:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96911F2434E
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 15:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DD0137C3E;
	Tue, 16 Apr 2024 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2mvFo1xG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00F137915
	for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282810; cv=none; b=dQB5l9YJZsWTUwqTnufw/BAsH1WkZ3/t0cbHIg6NIafi9NBKcFIi9KsazZpj7gisxnquRC/A+TD1XkNaANlKb2rysllObsW4gsDRw1af7Ml5ghi+Av3Une9xsWVYJ5CPtM/96RDgXZZzBg19UA1xagf+Gu3PECHodBPSAuVNcRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282810; c=relaxed/simple;
	bh=71/hK7M+iGlW9MxCcEOGM/GxmC2HFwhgUk+pNO21FM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JxIA2HcHjfdy5XHVisI2Lodgxln0ACLbUSe2fe1/LasH5TPoZZmlU+gseMl0rUvXx/fGQInxxS2/RXmvUB644eevcP5mcMxKr2Lk/50FbM4NImuxLVifBoQIaTf7PIQQYKLRdvQcQcrwodsX17qoYVziziFAs3kpw4bzK7tUKx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2mvFo1xG; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso7298613a12.1
        for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 08:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282807; x=1713887607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qh9PxU4hB2rhg7F6m0ON5sprlF2NLZLAaf9QKMnEl8=;
        b=2mvFo1xGt3X4ynokpML6GsOJUClY78xQqS3uakcnXNj3lOwWmfIOlC9hSYGDgszQR1
         65BfNU2oks0KKGXIhQBd5RHanjJErmOnBlz4qoMUZQzdoy3VkfBusT1cSBfsNZ2xgki4
         JCGvODgTGuPIugGmP+tHZzC55mH3uzqA4DnxaV3Z6GlOrpXcU6pCM1cYc6Zqk1S7Q6Hy
         LljCO5As5w0x1PRFu0Vkg9ZFFyJHIS//mwTQnPUUT/LFP+zhTeFD68Kf4LiT+yIUcWjn
         V8ErCudG0OkvABG1hPjsTJ8jQUpDaMrQXi23jIpaltimk8qw7HPBLrdDnu1L2WZ5rxAF
         U7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282807; x=1713887607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qh9PxU4hB2rhg7F6m0ON5sprlF2NLZLAaf9QKMnEl8=;
        b=LfFw7wwFQby344T90qkNWiIep9h3+bh64r1UUlCIF1q259l+ikIGzHIWDf3TvhNFq/
         3iHaXmV+csBRNxlB/iZ7jQ4cpO5eH7qlY/NzY/HMjt9iTrayw1WH81YqzdEMqU0E0g+3
         j5boK9WZ1y4EWB1gz8XsrZr+/UI66hh602gTcLcMc5CBiUW3oj7TAPcOfrNFVy+7KnvQ
         WGqwnDQR116TSBmG36CPsasMyl/5xPlHsJ4bgc/CN2MLjxmu01R14o9V5Xb93lgw7int
         FuyQdgaSATtJgYQCcA9TSqoY/KJ5/vokIuhuN79uxy2tL0WNirAhWAS18du5Rgi3pNoD
         6SCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhyijLMP3banqyYGK3/Xd9A2wtz1N0oX4mxe7aJXAh0+R3f++YzNx5R7C6OLc13AKnJ8Osb8D4yu2AOqaU/FiczSmAsJUl1j2S
X-Gm-Message-State: AOJu0Yw+VJ4uz2BFJ1HkwMYNgVFanjDJHWZYXv/QwdubADvWiYHKTFUw
	tFQT0be7OfUOKAo9ro7cIYjQRn01T7n+9jZ6NPtg5gKRMo47cm1bg6DUhVG35I0=
X-Google-Smtp-Source: AGHT+IHG4nMoaKSD57SAIyTlyvLPyxnK1HAvzHuj382xIJFY3e72ktmyLHdo6Y32nrQ9p7F9ZplNGA==
X-Received: by 2002:a17:907:36ca:b0:a52:551e:7502 with SMTP id bj10-20020a17090736ca00b00a52551e7502mr8380201ejc.9.1713282807516;
        Tue, 16 Apr 2024 08:53:27 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:27 -0700 (PDT)
From: amergnat@baylibre.com
Date: Tue, 16 Apr 2024 17:53:07 +0200
Subject: [PATCH v2 06/18] dt-bindings: display: mediatek: dpi: add
 power-domains property
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v2-6-33ce8864b227@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=P6NTpV6Hcl2nq4Xnripe5Czc4f+S/tebkAJSAKKZfY8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7q7A3lCxlMP0/HKhvtUiqGnm0iuZfwyvQOOBOs
 O6ocHteJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURUboEA
 CszLi6XJJcSVfKekD6IFu8zgjjPhyOHS6yOkiwK1inBDCiL3iYY9FBJJODWPA45yDccHp+kS4CM1GI
 NidF35oVE8KzVxPLph5vvUjfTxPpWKMuZwCMiXrOxD4YCqgtruDi6/6+ksSklxTXykiDoXer95bh/Y
 8eMnvUYTqO56etpeuErbtPrUhT4J1A41d3l7pWDN40+/KUnp36d+I/RYO7BIdBHTTQrZ/eJ5Uew0/a
 A7MjRoAHfoL/OEmgEIdAmOsFJKqTR/ixYvBJc/dTN9XshT2UAozJ6LhB4kiJ4ztGMm3xmPyIWeXg8s
 quX+bzYiYIXQnJzLJPL4UG3Y8/TUKzTC3tVajNjQKMqB2464mzI+0hfvz3ENLxmn2/IjN/nTbnkAeG
 V2t4/XyTcFKp+pMx9GgBFYcReVm4R/jYTnSNeCbo+cYKyhWHBiWdsAKqisWBXrduxVPO3Kd5YKHdwQ
 Nan0eLZTWTPJ5EjqQvp1YEM9IiQ1nc06gGpDpZnUJPi+nBGb43mp7BXlRFovjqJi9eB3yqfnLTpucj
 k8/7+2ZXJYtCi5i8D8Uzq6FWSrUUsefx3izGPKRDfNNQUtHjFs+W+C6Nqk4aH7qJ4+GQTkC2z84xgM
 trLY+7vwAgVDrICwYMmqmo8xqFYYrarWAME8lE4m6l1YvqB+8T0sfoZEGCng==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

From: Fabien Parent <fparent@baylibre.com>

DPI is part of the display / multimedia block in MediaTek SoCs, and
always have a power-domain (at least in the upstream device-trees).
Add the power-domains property to the binding documentation.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
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


