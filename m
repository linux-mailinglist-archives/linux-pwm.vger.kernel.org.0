Return-Path: <linux-pwm+bounces-2505-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AA390D3EE
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030C11C24975
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE1415D5C9;
	Tue, 18 Jun 2024 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTuzwGtm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1E15CD6D;
	Tue, 18 Jun 2024 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719204; cv=none; b=a1xdWSel15jOP6buTqZJfX6Zdd6M+WRbUSpW5E9KlR8+l8wKpLaMWahKiEthRUWKMNBB8jTPQA4pYJExO1+ejMnc0v8i06kn/+gTYHd/TxklHRKHCZTvhG+WNh0KRYhkTHw+pm2Aftp7hxV9o4nXNWfFbE5dCVawAOeLk1ahBMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719204; c=relaxed/simple;
	bh=dgJy+BucY6KOgzZn5R8UqVuWZVsOdC8WyvzpCfw1lYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VaF6sxutMk20Ys8t6zFraN3MOQhns6YSjT7Hf5GSA/RiD9HbdOjxhp7LrM8r9LP2g9GtCz2663rXgeRfrL7pXMulD6+/F4PrAG/pRrHnSZLisqQ/qcMyKjDo8QOY99SNYxv0zeFXpSCGcctswX4HyJjcL8XjcQ+PU4QO2hgCpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTuzwGtm; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ebe3bac6c6so60712291fa.1;
        Tue, 18 Jun 2024 07:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719201; x=1719324001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6A3+2iwaC1/XVmavDthDLZ4K+/3BScbJzSpnb3NVRSs=;
        b=GTuzwGtm1X2zQmLnQ775UkuIrEbeNs1VFnkVM3eYShGexDPtkq1KLikd+a/fFOdLme
         mrWoovsmXl10X7+VHYU3gQ7f6CJhXbRLLvb45tnqrfrqz7vSW6EC87Cvzs46WBtPTTSL
         IfEjgwEcgxnHF5moQr625vVHHhEzDoGvepEe+LtbiDC/d1OkNu61VUPzEAm02JfLIgaS
         0tsEs8oU0m4DSrmP0FtPHjYvCre5R9NQsQVND75du8yyzFrZ3wSHKVv+6//ZcSZa13WJ
         +no1puNddh1xPvG8Yi9e/15vTkU5Qc0itONgoAx9vulPLEH5Li0LdK+6is8X6qYWc062
         nDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719201; x=1719324001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6A3+2iwaC1/XVmavDthDLZ4K+/3BScbJzSpnb3NVRSs=;
        b=U1ntsd/Qm/ZWPtGV1lGeNY2aRJyMIGIoGFE5OTKYxMIzGK6PXD9G5uPgjI9CKUdDCM
         ibWBCF/jqoCw7UbG21H8bBY3y3Vb00nfBe6dbxkwPbqSk9EsXPngsVe6UqjMyW+rsVhv
         n5QcEFH3TeGa0GwVcNyMlxZ58fXbNNWpmY/je3GEJNIW7fDu17dZDNnlFQVT5CHrA/Se
         fpjVoQ9GQg0ARk80rvZKB7D0Hz/JO0Q89lN4jPjcZFnrOHwWeZPuDtdnrXI0etSnjVdR
         CjGXZDfiLQBXAeJD96YrDVMCoVxvOlwisxIQhVDfuW8A7nm/hFLYb7Ve6Ac197O4sa8K
         fzgg==
X-Forwarded-Encrypted: i=1; AJvYcCWraS62uFkmwUIJaoS/ftS+4+iwVpMg6h1jckEKVANUCba7J1uKq8rtcmsvf4djhWbp2ZfWhlPWANPy6gWitEPYGGf3JHeQrjvLPknLllyE0nfIMmGbEm7MBPC5SM/O0Rs4mznMJyNE+lHV4PvbwB80Le31/45loWiSHIXMMHQgNs9l+LB/Sy8XYnZ4r9xDRVb8ScwW3Nv0A91j5OTwHS4cAb51FAZ3giO/SvLwu+DrfgE7huYdOOdC18VPure07YJz8mp8+sOzURFbhY+RlL8n1fWdqT99lK6wjL2MVQsULcekezfVMaNRgThrRsLUjMMcxkX419z7V9yuXAzoubxpl1269KGL0eZWU1dz4ODyxTvoe9tEOffEVdd8X/NrfBZImfKOia4/RwmD8mnqRy0D+phF2KSM
X-Gm-Message-State: AOJu0YzacK5IvE06AQKEhxD8c+izTObSuSF6FxJgNTtAsFNnycSFrC58
	Sior/iwSN0UgmIjwg6cRym7/eJ8rWQF57I9qbHJgXB8p/rCuxFjb
X-Google-Smtp-Source: AGHT+IFlmX/c4ZFv+qoeEd0Kwe0J+as2CgfWHsxDLcBiN6HGFbLvve0i3HX+10AQGoM9rdBOnoEHpA==
X-Received: by 2002:a05:651c:10c4:b0:2eb:d4a4:42a1 with SMTP id 38308e7fff4ca-2ec0e60e835mr100649901fa.43.1718719200637;
        Tue, 18 Jun 2024 07:00:00 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.06.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:00:00 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:40 +0300
Subject: [PATCH v3 06/23] dt-bindings: power: supply: add maxim,max77705
 charger
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-6-e3f6662017ac@gmail.com>
References: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
In-Reply-To: <20240618-starqltechn_integration_upstream-v3-0-e3f6662017ac@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, phone-devel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719184; l=1332;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=dgJy+BucY6KOgzZn5R8UqVuWZVsOdC8WyvzpCfw1lYE=;
 b=ZwEhTU12BEK6xZcNcocP5DTvk5amgaqarmU36A5zA3ClN0GV0Z6ITAzUiQWgH2ylIrVpipKEi
 es6j/VVP+FPBYMiD8HDlU4v3vRWPnI/6v5pYPLRLup43GxlOqtUOW5+
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

add maxim,max77705 charger binding part

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../power/supply/maxim,max77705-charger.yaml       | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max77705-charger.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max77705-charger.yaml
new file mode 100644
index 000000000000..2b805da2a328
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max77705-charger.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/maxim,max77705-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77705 and Companion Power Management IC charger
+
+maintainers:
+  - Dzmitry Sankouski <dsankouski@gmail.com>
+
+description: |
+  This is a part of device tree bindings for Maxim MAX77705 multi functional device.
+
+  See also Documentation/devicetree/bindings/mfd/maxim,max77705.yaml for
+  additional information and example.
+
+allOf:
+  - $ref: power-supply.yaml#
+
+properties:
+  compatible:
+    const: maxim,max77705-charger
+
+required:
+  - compatible
+
+additionalProperties: false
+
+...

-- 
2.39.2


