Return-Path: <linux-pwm+bounces-2023-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7588A9CBC
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 16:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6D61C21C99
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Apr 2024 14:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E135416F29C;
	Thu, 18 Apr 2024 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="QusZX9CP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9401716F0D9
	for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713449851; cv=none; b=hs1tsbM3Dl93oFxQQejFxVckRI6JffBJGJZanHPnVR9nmnkMs5xUCercjsqadljnM5N3Bs+ZZDQyOI2TNPm/lwSjOu349HeAioYDy+KuvFQ3yWZnbuqW3/L4Mr6ghTGeJuesjnttyswz8F28zPxslaJo68m6w4ZCtjGdOA4OCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713449851; c=relaxed/simple;
	bh=xfN+lyYPuhvRvUCTQ8fIHMVrlQBTO9USYU3uQp876/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PbtT0OySYSLbl7eju4A8DqhQEEbElGNnHZVVTXGzsJfvFc/b/GrRI3IHYHskfV7/DXJCwiDlCNVgLC2iYsiH07Y6ebdBToi7dfY73dX4kA/ZDep+/b6hzBZ9tYuqYfKDwucQU4h+JXbUbdqlnDwDSC2T7cwRcqlb0YuBm/ZeDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=QusZX9CP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so5670015e9.1
        for <linux-pwm@vger.kernel.org>; Thu, 18 Apr 2024 07:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1713449848; x=1714054648; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGzmq8QnAnILeJxkfq5XlHyhyuBWc/rv+PBpofcSXVw=;
        b=QusZX9CPBo8uCln9wwVvge4yItnXqm9ZHm/T7VIwePFatI62+ZVSoEnag129EtOe+j
         ePFk/42CNT795DD0mBtTnCrBj9W93mkBkPfmVhGE1mGqTP57lhzSodV33W17hbOIN5Gj
         TWFwX5bbaH/2Hy8UE+K0JCNphagcKRAtsJNJ1UkcvQEB3cOZKu+zt6W+FOQoRmHPg9xC
         zzfvCdbCpx/jglHvfUIJ5GN/GbnB2PJlPPWIgELiw7hfu8Vo2jjso/Co5LpfkT0HuBBm
         QOkvJwvW5DJMxY4jzBoxFKe5yKu1WNLJvCRjt0zzMrQskXe5wblfD9rr7q7hVh9HL5+i
         JO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713449848; x=1714054648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGzmq8QnAnILeJxkfq5XlHyhyuBWc/rv+PBpofcSXVw=;
        b=SvO65ohJd6feWh2TqLZRIr0qjhiYsLgBOAEFONV63uBVrgdSzQQIOTyGN+GTPjIoNc
         smCMnC1jkxVSd9jdsO2NDG3/hNoWpBTSvDMomDhQdLiXyLnQ6Fnha3/o1reRJ4TdKai7
         fU9IorOrW52nQALybWrZcsTS0tT7H6o3ozia0GZsh7YLRL9ptVkzStBXjG09DezZYWhX
         /mWiToKGJcdcjWgH2xR5ZM/Xf/jLQO8QsbbkokUbE7a98NUkeeuC/SFkHM6oW1jRXCss
         mlNGC/Z5YPnrHEMmJLxkexs0CxtmXeNsCFc8w2l3KLEM1o6aEKI9i7ks+/5jdMBrywb3
         LW3w==
X-Forwarded-Encrypted: i=1; AJvYcCX2kkftmXd7Gx2wWXUlMRQB2losLzieCmEM2x0UjsUficpnagE+w9vGqR6mIgDzF1SOsUcIN06km2I8TRbXX2yApupiDB2c6Jsg
X-Gm-Message-State: AOJu0Yz8useBkft7SNVSKSpZyfx832x1TML/P/xuaVfBEUGBKrkHxbD4
	GPAX6Un+QpMDP80ZfVG5lSOw8hzAfffnoCQiMRHGksY2Za0PpQxIAl7HJx0ZxTs=
X-Google-Smtp-Source: AGHT+IH7KCEY/+ul2khGMzI5unaRDPYns3Jufon1f5mBA1gxs8y+0LQ2wo1qRc6yrxJLUkRxT6qr2g==
X-Received: by 2002:a05:600c:5106:b0:418:58ac:7477 with SMTP id o6-20020a05600c510600b0041858ac7477mr2195309wms.30.1713449847851;
        Thu, 18 Apr 2024 07:17:27 -0700 (PDT)
Received: from [127.0.1.1] ([93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id i9-20020a05600c354900b004180c6a26b4sm6267510wmq.1.2024.04.18.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 07:17:27 -0700 (PDT)
From: Alexandre Mergnat <amergnat@baylibre.com>
Date: Thu, 18 Apr 2024 16:16:59 +0200
Subject: [PATCH v3 11/17] dt-bindings: pwm: mediatek,pwm-disp: add
 compatible for mt8365 SoC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231023-display-support-v3-11-53388f3ed34b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1057; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=xfN+lyYPuhvRvUCTQ8fIHMVrlQBTO9USYU3uQp876/k=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBmIStjTCXO/kUbOBJES8/4FPPfBPtu5tsAadASQJ5Q
 ma48FsSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZiErYwAKCRArRkmdfjHURcnRD/
 9fuVuGB/ZNl/NDOctvn/uK8rqOLuzMTsxWThurH5KOOR3wLElRmnLPlCZJoOY8hPH8ky9VCDmvOeie
 Ov4vV4n3KpWluEDpvlytyGy0011ck6nSh1qurg1gM/r07AzRPwTtb5QPI4lzAsI0xu2K6KVhIq0XOO
 olXckfxw3cZE4UGxhRW4GVhnzk0r8DACbnzzUbZiKq2UIjRv7ClEhSEJrA0e+NEL++VgYh93BWo1w8
 kYNsqiKsJA1ISRgkFbnV/Vt7w35U7dDd2Qi1vzSb7ua3SzoDFJdcFPVmXX8K5r32wWoPtCLLv9CGA0
 ZrwAZrQ9q7zcUCuuRhtRB2v8MEligo9yK68lNYH4Bm5x5A+cm54SYPCzRoPBvHcDI6CGYoItoHDROT
 sXb5KSDBSTU9f7THTcdrwWpKjGo3XdWIWe9P769nRoqdMfs72hwNnODLryn4k3sUT6WokdzLv4GNVJ
 rtHB6TLkYhnBk7yVZEcjZhdcF5SWiboLtdAzwbN08A8RT/ITXSyJUvgh8MMB6lCmGRdNL6f6UkveAH
 e5TS2MIPoNyayjfZXq0sq3HdX3jwNakd65BKkKwFs7U9VX41sABjcRKWr+gNedlDD6hDXJSKo6Rgyy
 RbkGMV1CVMQyqFyYPmby/z4U4TxeSVSxS7q4issBY3actLHYQ599rGIehXpg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445

Add a compatible string for MediaTek Genio 350 MT8365's display PWM
block: this is the same as MT8183.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
index f8988af05287..180dd8366935 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
@@ -31,6 +31,7 @@ properties:
               - mediatek,mt8188-disp-pwm
               - mediatek,mt8192-disp-pwm
               - mediatek,mt8195-disp-pwm
+              - mediatek,mt8365-disp-pwm
           - const: mediatek,mt8183-disp-pwm
 
   reg:

-- 
2.25.1


