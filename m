Return-Path: <linux-pwm+bounces-1959-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EBE8A7084
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 17:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B435A2821D9
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC6E139CF6;
	Tue, 16 Apr 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vLrgCwT0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82B139584
	for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282817; cv=none; b=n8Uy8uidBrAMfY9t7UC6vn3z0GhpeUU+U4RJesrxihGdU97nwpAeb/qH+xULV3acDuOqAbly3ivn6vLu0A7zPDDYA0I8I8gsOeV0r/N1Viw+XNegaKjWkKBjPnHGJVNx2MV0mm+ao4IGwhs2sDNXS07UJGm+ozZjbhHBOR7u7uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282817; c=relaxed/simple;
	bh=S+M2sbOdQTSB1ypewlT6uUj7KW4lSf9df5J14puhNjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mRX0SN3RsYioe6xYNdYH01oTWdcChKA+tCu8+7ArgC1eWUWEeIvKRYFR6RXVHV1p8kqYxAwDGlSs3POoc4YhxrBx3Zu5kloz3UVvLm8Jo2+l0bm/2dO5pZUKVlI74nZZvG+uat97V/JFY/hicTCWLx1QUJl64iCkXLPKJFBFSOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vLrgCwT0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57042f84cabso1317138a12.2
        for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 08:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282814; x=1713887614; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifuf640Z6/FimNFqL4hkDSH599Y93aDl+Foe2+I5K1M=;
        b=vLrgCwT0bOisZDKChq3Dgmpwni37agKzd5nw7nqSkrzcJLTLrV09mhTu3FkjRknSBn
         Rw1IoHrnmcYs5RPMyeHGR6BzzJXpJqAyHLxfdFz5BD6XFUh7qDAs7uomv4i/dLHk58Fn
         yWZF4IjpV2eYUnmLHMf/o5DLudvSfBtEL4x3lRpYL4Q9GswE/iA7t3nDMAFXmsLf5NoQ
         qkP3lqDF4S/PjHo5l3ERFCct75Ec5hRce4jTo44r4WWgv0cZGe9rWcJyy/zyqsZxncQ2
         JKjYUI6edsJT4aTMzU/MYIrr7x0mrvo1/FCtFy5AHUNo1KnNzWv57DMq4HCcJfUmSYJL
         ZcGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282814; x=1713887614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ifuf640Z6/FimNFqL4hkDSH599Y93aDl+Foe2+I5K1M=;
        b=TOBa6DTXJb7Ivf67ZC/3jT9t/B7BJ0As/VIWzERP2AzCOcdmfUsyo0WiDmXOINOA9b
         7TghFqVtJXslhy/kZ6+NGLFUYVyrQZmw2KKWqGoKaRW8KezyBoGtt0h7WlbhG3N2evH8
         X8LgJDVug+wamr6SRNvtvC5nXNp3ep+dXIJuVhWXtvxfo1Xi8euKGFygd7o7LCq0DZD2
         1l6HZqFMJvaQ6I0cEROnXa34uMFWmp9Gt2HhGzIXw/rtYYhoEUWYjs5LIjZlLM3Dvm1d
         /3w+aocHJ5QCPNi7MKnQlaOFFY94NuxvdZGozanfjcrTERcs4UR5H+R4WySsxHmBRUHU
         tfmA==
X-Forwarded-Encrypted: i=1; AJvYcCVkdmZdHA/wGbl4R2G7DYXV469CAMm2tQxQEU4SwV265EfBlt5j60ZmmvQ/kY128dXZnBOHJTzkQYn7AvJ/i12iYnNArte4HoSJ
X-Gm-Message-State: AOJu0YwB1Z3AUyF3FYNRFm3uzyhf2wG/TrOT0K15fS4RvIiGoM8hVUPr
	bI1P0dwYHE9lR4i2T/IdYcYFDaghPDOXxpNjvLtb1oLqYo4kXUWX0w1+2ztcjwE=
X-Google-Smtp-Source: AGHT+IHaZwy9kMAt3dKD7ztpcg+G2sCvDptU8sUFgX7EisaUHjQrn+WiEBG8Llcnlpd+7lOam/eEIQ==
X-Received: by 2002:a17:906:dac1:b0:a52:241b:b450 with SMTP id xi1-20020a170906dac100b00a52241bb450mr9001724ejb.36.1713282814553;
        Tue, 16 Apr 2024 08:53:34 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:34 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 16 Apr 2024 17:53:11 +0200
Subject: [PATCH v2 10/18] dt-bindings: display: mediatek: rdma: add
 compatible for MT8365 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v2-10-33ce8864b227@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=S+M2sbOdQTSB1ypewlT6uUj7KW4lSf9df5J14puhNjs=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7qr2gWCpuTFBeOaj15ewJSHHZxXPSf9Bo4Qvkj
 gKnBTqaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURdCHD/
 0QuYwuZums7qlU9/2EkJLGzpJiVlEt1nFkpvD7T7ek4+rNdhFcUe/S272VOXZkgHDDPadRIeC7brk2
 KnBmDy50QVi8BYMTPhPPlkMSlyHkRSLPbysjL8WSRtk/Ubk4EHIVMEHbe7YgN3+d8fEJajI0JSC0oC
 a+s7NmIc6aYuEwB/S5ZMh3L+nul6XIOdxZLcLUWw9fSddAC0HUQaRkvn8z/dMICsjt6XUvHg8RJF/S
 3/9GHRcPJzH2CDKN85jR7ksFWw1AZUAHKTgte8YYiRsLT84HMn3FUStLwv5s8T6hCGGQ61/4ZYTQIR
 MajVritiKuoUAozQwLQ58752Sg0a4elRPKAc+EVzDYQXO4l5E8ZJ3fDlkkYfoTUhRS64OBzPzeQZio
 9/vfIOQao9C6A1HQ/Ceus0mMFZ9NPRX5xuMDSuvcJsBt5WQllOFXRnyOlIgblKP1ljZVShmQSI4zfi
 lJj1vHkrDOEtW14AaNg47zgXNba25RI4YB6y1RlPpaZtfMGR9/pQ38yIHr/Nv7g1S1ju3wT+BVkSH7
 HcM9tBOrMsIU+QxAsOkh8vbdwlYV/PiHzwM0zIVWDWl0V5Ergti+aqOtrTD9rikgy+N5sdgRehK+BJ
 OfKpnEmI0pZM3NDkscihBKQGcmKILC/Py40YmMMGrD1q5gkUZCucc7nfew2Q==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Document the display Data Path Read DMA on MT8365, which is compatible
with that of the MT8183.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
index 39dbb5c8bcf8..4cadb245d028 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
@@ -45,6 +45,7 @@ properties:
           - enum:
               - mediatek,mt8186-disp-rdma
               - mediatek,mt8192-disp-rdma
+              - mediatek,mt8365-disp-rdma
           - const: mediatek,mt8183-disp-rdma
 
   reg:

-- 
2.25.1


