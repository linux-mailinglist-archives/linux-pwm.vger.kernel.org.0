Return-Path: <linux-pwm+bounces-1965-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7918A709C
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 17:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06F811F25D44
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Apr 2024 15:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD7613B298;
	Tue, 16 Apr 2024 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S59I9O40"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B2413AD13
	for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282828; cv=none; b=UQvsIGZ6Lm7+7JgkM8Lujnfmtu0tBn8pGrgSBv+68Ymo6QCPnFePOj696BLlQcelKbNAFVufyS7FHlgfD9H8LMTKjjhum2LRGTNTTrrWHNI6zlL11xv2TLz9hAXg/pnaNZcAASuXWfQEQilWQiAid909/FhG0FNGk7Uty1AwKAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282828; c=relaxed/simple;
	bh=woF6NgCy9sWp4jU9xhCym7WDVQPI/tzmO1lBDEzOVXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yym73ex7nWALHue0LtoZ5mpBjwACSC7V2PYw7rIIovtFfKHME4e5b6THhDXa4F6Sgyos4FrrziwDPu0I6Z1kIHbqhh2P9cWpDTdjZi/CtMFRAZnHO3YdzGrIoH0uHKsPJNQ2KXi3WNK7o/LBCihZ05NJEsx/VXpyxXAGKjtJs8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S59I9O40; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-570097653faso3256611a12.0
        for <linux-pwm@vger.kernel.org>; Tue, 16 Apr 2024 08:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713282825; x=1713887625; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ngpZb20B2h9Qc9IbX5I/ZiczUNGoVVnils8jWsBLdA=;
        b=S59I9O40Ml9tpQaaizfw+9iqq9I0Woq+8E7VpiC0Fo9SSwjDBbbuNIvob9VvlGGYhX
         K6qqVqOGzllN8to9P/Z7WEvTGEyMYRFnWazgw+6aGX2Y9lLlYF2be2aA3qqJcKYT/n+e
         fuS4Qzov/L7AuIkXRTqrm73RtK2GuUFkGbRAUqvN8+CD5rpk3rBw7Du8B4sNcR08fiu0
         Sj/htLx9wGdDWwN/U8Kb1xsXbf4RKPzR0aBrPLfPbz7AGL1y3viD1Ql5Rum9jd0URClW
         84Bn/H68LHOzdAfcfT2Kqgpc6rOIgoNvtHFG8ddGvHeOPWpuovsskPMG/LUOEwuIRdLo
         mpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713282825; x=1713887625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ngpZb20B2h9Qc9IbX5I/ZiczUNGoVVnils8jWsBLdA=;
        b=XjvmzXUQkfiSGpLp1ZeN0mqRdV6EeT5+ZN4xdCwHmJS8AC/R2GN9XfKihguVV82BO6
         wGOiemJ/jApa1KnYLi3wyG3AeJz86uz8gqoQXbo7xl8GlgHrWahRhDi/UEcOiWTPw9ZJ
         f5/yXBv47cRXzg5nu/ZZ/m/jBcl+JvPsYBIimhVZYV1afiyjySZz1OoYT+AfDn9MvGDj
         8auqnHbS2LseMoAd34zNzcqoCGebYuxxegu/FtSS6EkziA7CXtbJoXhnHXWTXGedfuhc
         dX/622ziKoJL2WiVYq3bKklqdEtthnsqKXYVtG/2jFVq+OmgMVXUwS7hvfp4xiwFLtz7
         0pww==
X-Forwarded-Encrypted: i=1; AJvYcCVLZlhuNNBGHtqzSXDOhSdM8r3tFZgzAYsWiPOdwHMoxgRhI+uaiQKtGPLH8IArcuysve1S4WLKJAvPQWjXoWPGqM+TwZzewsqu
X-Gm-Message-State: AOJu0YydhJrfjhaGABU33zYb9zizqDbnYyNOLQdZoSE6uJb6+pDrYD89
	H5/Qfg/co0zWoejwhWd/u8YQ3lhEuMHnU4eiSEl23kuEhddxF4REoG46cccdWbc=
X-Google-Smtp-Source: AGHT+IHS8gkjj052p63IxLAZQoDwSNpts+GSvD3Ttdv8alHt/Cx4qP4IbNw7Ik0JeHFuC8d5NxqZ8A==
X-Received: by 2002:a17:906:70b:b0:a52:6e54:1c96 with SMTP id y11-20020a170906070b00b00a526e541c96mr3885284ejb.15.1713282825054;
        Tue, 16 Apr 2024 08:53:45 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d12-20020a170906174c00b00a52567ca1b6sm4156691eje.94.2024.04.16.08.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 08:53:44 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Tue, 16 Apr 2024 17:53:17 +0200
Subject: [PATCH v2 16/18] arm64: defconfig: enable display connector
 support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231023-display-support-v2-16-33ce8864b227@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=693; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=woF6NgCy9sWp4jU9xhCym7WDVQPI/tzmO1lBDEzOVXQ=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmHp7qIwtSSbyVpXRpUFOdzU8YlXuq4amJoGc3u/12
 S1MzvACJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZh6e6gAKCRArRkmdfjHURd5DEA
 CxggRzPxIw7OeYNeMDqJ2rnFJ5h7mlJ9X2EP80Dokttj2mIP4Bk+vPXL/6hYoAmzTjqzWSaiekP1h5
 a2SWzg4kNXkdFyooQxYqwPPXjeM0+sJETbmIWw6c8v2ePq8ZYCsJmKO1bqaI99a3OLVwRA1G2jlrIl
 zzBJe4HOehi4zwzV4FFxaDRznY1+sPKrT7fNcham2SDvEeoI5flZvTAm3j1hKMYVO049HUWJ1pNTZo
 dLFiwMlTUHLQJvdFuuzahgPAk3UgJkTW8BVqGDf9vA3wcnlfDrVostJvktfroFrgFd56zqvGUgVJza
 mH2J4qvmYVlaz5wiQZdgtgN8BGQopSjvQCwFacVTz98+UdmmNmEjxp3SC79KGYJdUSZDfLcWORGlzy
 gLkB6ZuHZSJI+y/CEXRz8bdVfKFoYCGZsYx5z0WcRQginyxYUzPd/NOofzxfd6sxeXLE9DJZyrDAgX
 TObwzMlqvAes96Z5e1PUy/juWu9QKPIZmGCNFfjdo/0dpKzTSRI+14BTGvPULQhxrrdu57vJLFVeuR
 MleDRGDahrsn6feV2eDPRhMHNTWBLMGuP10Nr7V6N9yHirzp/jJK5ZIB1ibq0LWVgLH7KSvKmxFiKL
 uwHmdBqyhnNhKh7m6Dt/emc6Hcusn/f0ocbUSLIHNvWwDZsIU4b6ngOBc1kw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Enable this feature for the i350-evk HDMI connector support.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fce98a150014..1df337882835 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -872,6 +872,7 @@ CONFIG_DRM_PANEL_STARTEK_KD070FHFID015=m
 CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=m
 CONFIG_DRM_PANEL_VISIONOX_VTDR6130=m
 CONFIG_DRM_FSL_LDB=m
+CONFIG_DRM_DISPLAY_CONNECTOR=m
 CONFIG_DRM_LONTIUM_LT8912B=m
 CONFIG_DRM_LONTIUM_LT9611=m
 CONFIG_DRM_LONTIUM_LT9611UXC=m

-- 
2.25.1


