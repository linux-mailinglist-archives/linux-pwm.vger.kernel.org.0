Return-Path: <linux-pwm+bounces-1949-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9118A705A
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 17:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1B40B23A83
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 15:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A803131750;
	Tue, 16 Apr 2024 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NenMJ9my"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBCE134406
	for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 15:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282800; cv=none; b=F0F6dM0mChiXrj7ZZKlGZYtIk+MB1sj9JvszEId2VT3KbsnBMZ1N0e8VGbLISOQAdln9OdNhrcrtpxPKXhDbwswGW8SFbwG8TPb52cZ3Wc8QBiWV9tifuieE8V+MixkhzC4hxyZqQeOBXcsrYX7guxMGuO1AdudQhQlgFdLymdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282800; c=relaxed/simple;
	bh=cSRtZ8VILEnO8kxIOGOQMbqnDEouxobw2b1bWxUvmps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VKC/9OMb8hvxnWdI/tVCP0HRKKKb69aL1EjrxkOh5Xl6EVR14ZFlF37EbXnntFMVsVdLzGdn42ZpmSW0ojfQuomW/5NzEcnGx2RTi1Btpq3025YnA8MzYqDRzDkJpZGT91ODlSp+zh5DbI8aJFnn+wvSF4rf+dx27UPZO9h8kXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NenMJ9my; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a524ecaf215so402148466b.2
        for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 08:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282796; x=1713887596; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HplLWGZ3hQiKWDGM7/znOJrIFY9in8L3w1MlCrmBNzg=;
        b=NenMJ9myjDr6iWsKf5jdP4sOnqjj+A/JrWvioNiF1Gq3SdBIvyncJDFzL6bitESQdh
         Ya8v/LNa1M3bNci/T0E6ULhnuiVOuqVzp5GJWxutpFxKMM3BtnUiXBkBeW7PL5m2RqBh
         hZzCg4PDOwm5wksLh+o6BZBKlf5VbojhMAOHn/YpglAogNyYuOcrXeTkijNLRFcuzTjR
         I5s0uCs38mmFTryjLOg/RbRBMqJlUpfh+Mm3GHlARYByWlq9LWpy2pSDj4jr1fb7CEad
         i6qblnofch+kNdiYflAc4L/T1UWoKHu5J1iNxD2I4wusczXQeFgkLq6qHEnv8HyTEkBX
         Hn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282796; x=1713887596;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HplLWGZ3hQiKWDGM7/znOJrIFY9in8L3w1MlCrmBNzg=;
        b=caIM/p+8J1/U327ghPKT/B8SZIWmw1ucFfKu11aMI59o/N5H6puY0z7Y1cJP7h0rqf
         54nE3fo5GFCnHecB8z6VQ1dMap8Z83BJB4fOgXgH/Fs6vwNJszAddavXtSysM4dHLcUN
         KH+0UfS6+YSPs4hEOpaMyMiRoQt+8kwUo0q/pAsdaxJA44+VE/BMnuUFbYRqGrAWaRVk
         iztbJ2ht/yypOjT0FQUonKIav+tyta1R252rRFSUXwbvvaDXBXCn2v9nW2oSNP/0ZrMn
         Ucq/0650vgMxCCT46zayD6q9Y2N3FScqEan8f42UvIOreUJ1AvslfSTFt5SnE3dnSlNL
         Ipxw==
X-Forwarded-Encrypted: i=1; AJvYcCXdF/GFPrKq9UzVIPQsgTVXFNrgKuPStfKnQ3ekNgNWZgm+rlIO3rBtaOtTEIbNn1iccxVcgkhC2S1MCWsiMkjufpZKtqnQrYZt
X-Gm-Message-State: AOJu0YwH8G8w/qKxDuccJEbcVxPUDYURxyz3In69kBT3PiG7C4oQ6GDA
	11apkO0XwUYjYVIEy9qbLrWCuH93juJXWyJlGBIDtqyQTSBS0xsT+IxpKtsKKaE=
X-Google-Smtp-Source: AGHT+IE1a7X9ujLgTE8OD9sh/zhC+2PlA42XHKknPSEtUkJRf5RO3vAbemAhl78sG5LDOziPFTMPhw==
X-Received: by 2002:a17:906:d0cb:b0:a52:69e8:297 with SMTP id bq11-20020a170906d0cb00b00a5269e80297mr3489058ejb.23.1713282796301;
        Tue, 16 Apr 2024 08:53:16 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:15 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v2 00/18] Add display support for the MT8365-EVK board
Date: Tue, 16 Apr 2024 17:53:01 +0200
Message-Id: <20231023-display-support-v2-0-33ce8864b227@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN2eHmYC/3WNQQqDMBBFryJZNyUxKrYr71FcJHFaB6wJM6lUx
 Ls3uu/iL96Hx9sEAyGwuBebIFiQMcwZyksh/GjnF0gcMotSlUbnyQE5TnaV/IkxUJK+qXTrjIJ
 K30S2nGWQjuzsx8NLwEkffyR44vcsPfrMI3IKtJ7hRR/v/8aipZK1bxsFQ+2NcZ2z64SO4OrDW
 /T7vv8AY3SskMkAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3812; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=cSRtZ8VILEnO8kxIOGOQMbqnDEouxobw2b1bWxUvmps=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7pfbtsXBoyKnpXRXIQYrCvJPBKWQhh2dpgUO+S
 tJaRjXGJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6QAKCRArRkmdfjHURb4+EA
 CJVvFhuBQ0WIxxDyH4ccz/F1AEoTOQ29tz8h97MmzWNykxCMsl7FBcb38j8u+2xXlTToLi41netQsO
 wZ2nO4n+GPzP8+JpXnDizacvBKiB1qAjcOtvW1Cy8rpro7lDVp/u9XFxzTZvfNFMMnXOKKE3VZ4a1S
 e++0aO3I8KrobReXfiWdodhv8PQepIN/bwvOPCqfZgb0pefpY3T0L4BFvpfr4gw9K95ZClfFxFAX4C
 2pS3XVk0aNoy2bcNgxsY4UVzwOxKrIt3Txd99NQ7UgMCNfJygDYwhMzoMhgZpAwZJOV24UU4hhmVYR
 aLnm0IJIpb5CW/2od3K5yTbIx7sGpQ9zqKVkr3l63inYSWeWWEUPnYcCR4gs614wl8JqaFpgF2wkiO
 HY2QW8D+YzCnkzgYiq9Ozy2m7cJpqsIjkLxgUgEQLM/zlsW7EYxr7dWw6Ngk0rG2kKlXpgUYaXK53U
 mrILo0+qsWgWkWtaEe/3k0wJ+Cwbl09ilnllXbNHLDzz+izuO2HvjBcmn09W1K3iaHpef1cxHy2Nxh
 k2I6ftfAqvjaeN+tYw7PswrAMClpmKD5nOnwHtjy71VLyRURJzU0E46UPfDmQV/RSzsCsWGjo0Vj8k
 1BxThQtqnj7SkCZN7g9IEmhiE9T+xWcoXcms8/Omg4oOlYELlIKluZ0FBqLA==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

The purpose of this series is to add the display support for the mt8365-evk.

This is the list of HWs / IPs support added:
- Connectors (HW):
  - HDMI
  - MIPI DSI (Mobile Industry Processor Interface Display Serial Interface)
- HDMI bridge (it66121)
- DSI pannel (startek,kd070fhfid015)
- SoC display blocks (IP):
  - OVL0 (Overlay)
  - RDMA0 (Data Path Read DMA)
  - Color0
  - CCorr0 (Color Correction)
  - AAL0 (Adaptive Ambient Light)
  - GAMMA0
  - Dither0
  - DSI0 (Display Serial Interface)
  - RDMA1 (Data Path Read DMA)
  - DPI0 (Display Parallel Interface)

The Mediatek DSI, DPI and DRM drivers are also improved.

Regards,
Alex

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
Changes in v2:
- s/binding/compatible/ in commit messages/titles.
- Improve commit messages as Conor suggest.
- pwm-disp: Set power domain property for MT8365. This one is optionnal
  and can be used for other SoC.
- Fix mediatek,dsi.yaml issue.
- Remove the extra clock in the DPI node/driver and fix the dpi clock
  parenting to be consistent with the DPI clock assignement.
- Link to v1: https://lore.kernel.org/r/20231023-display-support-v1-0-5c860ed5c33b@baylibre.com

---
Alexandre Mergnat (16):
      dt-bindings: display: mediatek: aal: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: ccorr: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: color: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: dither: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: dsi: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: dpi: add compatible for MT8365
      dt-bindings: display: mediatek: gamma: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: ovl: add compatible for MT8365 SoC
      dt-bindings: display: mediatek: rdma: add compatible for MT8365 SoC
      dt-bindings: pwm: mediatek,pwm-disp: add power-domains property
      dt-bindings: pwm: mediatek,pwm-disp: add compatible for mt8365 SoC
      drm/mediatek: dsi: Improves the DSI lane setup robustness
      drm/mediatek: add mt8365 dpi support
      arm64: defconfig: enable display connector support
      arm64: dts: mediatek: add display blocks support for the MT8365 SoC
      arm64: dts: mediatek: add display support for mt8365-evk

Fabien Parent (2):
      dt-bindings: display: mediatek: dpi: add power-domains property
      drm/mediatek: add MT8365 SoC support

 .../bindings/display/mediatek/mediatek,aal.yaml    |   1 +
 .../bindings/display/mediatek/mediatek,ccorr.yaml  |   3 +
 .../bindings/display/mediatek/mediatek,color.yaml  |   1 +
 .../bindings/display/mediatek/mediatek,dither.yaml |   1 +
 .../bindings/display/mediatek/mediatek,dpi.yaml    |   6 +
 .../bindings/display/mediatek/mediatek,dsi.yaml    |   1 +
 .../bindings/display/mediatek/mediatek,gamma.yaml  |   1 +
 .../bindings/display/mediatek/mediatek,ovl.yaml    |   1 +
 .../bindings/display/mediatek/mediatek,rdma.yaml   |   1 +
 .../devicetree/bindings/pwm/mediatek,pwm-disp.yaml |   7 +
 arch/arm64/boot/dts/mediatek/mt8365-evk.dts        | 182 +++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8365.dtsi           | 146 +++++++++++++++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/clk/mediatek/clk-mt8365-mm.c               |   2 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |  18 ++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  30 ++++
 drivers/gpu/drm/mediatek/mtk_dsi.c                 |   2 +
 17 files changed, 403 insertions(+), 1 deletion(-)
---
base-commit: 890c94ce8a456aa4d7ead5f5fd2603b98dfe7b7e
change-id: 20231023-display-support-c6418b30e419

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>


