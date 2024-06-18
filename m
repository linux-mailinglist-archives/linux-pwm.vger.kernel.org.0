Return-Path: <linux-pwm+bounces-2504-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAA990D3EA
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 16:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3E91F22B9E
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jun 2024 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9936515B98B;
	Tue, 18 Jun 2024 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThSVVksV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592915B57B;
	Tue, 18 Jun 2024 13:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719201; cv=none; b=mbZw/eUTmZMZ8MkYl3JBqEeEsXh9A3kU84xaJJwtATMd2C+7oyvYoecQzAqAAC+eU9NYiIE2L+AuyPz8JpcQzBANyo8/ha28G9Z83bPsxATZ0qxgn0J6bqLAGu+w49OnmknPlSQbfFW8uiRV+fLoeLiZb5s6mekO731V2yyU6c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719201; c=relaxed/simple;
	bh=qthIpOYuUqEKsnF/WfU6OBlZPhcwRZUIhgo+lk7uE+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQ4D6l88F9L82lis5HryKjmqpG7T/+YnqF/w/Yy5Hv3TL9L2FldJAGEL+2/EMzw0iNFsnd38H/eYh109lVBxKa+JsY4SmLLWV18WkGpdrxhWFEF0f/2uQogAmlsSwkWK4rkbyXdU2H2hvFNELJPpoBA7kPjgblU/KLP3NrQ8Lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThSVVksV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so6833205a12.2;
        Tue, 18 Jun 2024 06:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718719198; x=1719323998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Upy6fBZOR1H2GEGfXG5Z3nttQhCGYdXb6UIkk48wC28=;
        b=ThSVVksVQGJZAq+UH9hyafuc9P0hkGXrkPTDjCSHZzGgwWR7cVb1mX92bUuwMI5d5d
         m7JAa9kwEd3T8IdI+WyEjlDAHaY0sly9i+ijE1NCHp0NNFqk713p7wFwv74tduK9sajR
         9ZlROKtieOd6sHQ7Zpf+h9dkFR5bvF/neXcMojxeV0ClYK29qMxHJk3gf1ZIOOKvTLmh
         2CPD+v5h4C0kAlTrWP3NKrLkxzPm6sNiTQrPLiQcUh7LMc4tsAvndl9lPRKDgUiNfiKr
         7dzbXQg86MXH7+DFBdd1x/bvfXcJ3UDS68E389xPl7rkenCtp0E+zR8/P19iiPJsCzQz
         UgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719198; x=1719323998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Upy6fBZOR1H2GEGfXG5Z3nttQhCGYdXb6UIkk48wC28=;
        b=lK2KAWteDjFw/d1Jyxe0fn/RJ0Tfb54CXomheJLxmyO8LxV5viF1z4VuTBjG+dgT7i
         KKKYg7DJqaBruwRX+QSTlsKRkwNMxBLUf9Sdm3Igvfk7gs6JR0oz5Yqfq1ga8zx/ypNR
         nk6YW8DzT7jlq75gQlvxzH65aTty2STRTbFVhtfjQkZB7DFgwrlLnEUOsGtbSm8MsrA0
         eY8Kfnxq/ECXoNG/ItGlNxYbwQ7f8o7QrowDEqUlLaYlO6A4kV48BCrcepnCWFnqqcD5
         DsN6/RhcIR7GIeKB/Mir4mRc8OEo8dr/Ldx/H7slo+/FuYo1aJcQcWpbnS8qfaNBYDFp
         FeHw==
X-Forwarded-Encrypted: i=1; AJvYcCUS8A9K/FHkFifdy/2Dc7rftqllfk+frb0XDvdTV/gRlgy3jisINxST4wu/ZbwiE1f3GBBCv49oPWE3Xlwq6LetT7npjGQwVCDDOyCDVCChJS8ytfXNsO3hVbfr980gfW9XR1FFhYYkRCdXFqdS+x07apjRdAkSi49vwMYzywxcUyrHRcs9VR0EPJq2kLwWLy+58EwLGgLiPXT9Fe3k1XCd5D6M9AG39McqQjy8dSKU+M5Nvzy0TuUQltWZTs2syW35A4Uje5dqr+3tDbPWmoojWpbLSvFiwe0P+9q+JRZoW0nNNvkpM+g978+Ug1neZgV3g/G2e+SQjuhRkps7FNonev3bfugmPB9Yk1TVJ59c2DXt99jMYYJF0bluzZWydch3aIkfhLByJfjuD4jq/XIhPfr/LF3G
X-Gm-Message-State: AOJu0Yxo3wHNEQON2DN23Xr4xuuKsDV7JAAesO4AP/TVNOIsqbq14gN4
	xHWtoflC45rbQB2b1/4MpZkN+qGvhb6xWdCgvjsi5xpJCjnPBy8e
X-Google-Smtp-Source: AGHT+IHMqfIH2/+QaLV+rotp1RiZdfhBoayjQhqdenR5458icQCIvicX3Uj89frks5W/jGab9ZLt+Q==
X-Received: by 2002:a50:c31b:0:b0:57c:ad11:e755 with SMTP id 4fb4d7f45d1cf-57cbd69c382mr9094793a12.33.1718719198162;
        Tue, 18 Jun 2024 06:59:58 -0700 (PDT)
Received: from [127.0.1.1] (mm-167-232-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.232.167])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da156sm7731278a12.22.2024.06.18.06.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:59:57 -0700 (PDT)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Tue, 18 Jun 2024 16:59:39 +0300
Subject: [PATCH v3 05/23] dt-bindings: input: add maxim,max77705-haptic
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240618-starqltechn_integration_upstream-v3-5-e3f6662017ac@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718719184; l=1304;
 i=dsankouski@gmail.com; s=20240618; h=from:subject:message-id;
 bh=qthIpOYuUqEKsnF/WfU6OBlZPhcwRZUIhgo+lk7uE+8=;
 b=wssyoJ3JsY7QOzBApfw3BG68MDFIQFbKUYMtNH4F4598qUtec5ADE8WPLKSmTw5VIE9HxgqOW
 mZhnDxDmJLQBIDXpX/vHZ8MCzqNHjA8MVN4AIUp8pKkFz6LyoXbwdZX
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=6pMMVVDDReSiRgPCbMOUauN5nS3ty4Sf5b7a2gi4x0M=

maxim,max77705-haptic is MAX77705 pmic binding part

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 .../devicetree/bindings/input/maxim,max77705.yaml  | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/maxim,max77705.yaml b/Documentation/devicetree/bindings/input/maxim,max77705.yaml
new file mode 100644
index 000000000000..8f065a2fe7bd
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/maxim,max77705.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/maxim,max77705.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX77705 Companion Power Management IC haptic
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
+properties:
+  compatible:
+    const: maxim,max77705-haptic
+
+  haptic-supply: true
+
+  pwms: true
+
+required:
+  - compatible
+  - haptic-supply
+  - pwms
+
+additionalProperties: false

-- 
2.39.2


