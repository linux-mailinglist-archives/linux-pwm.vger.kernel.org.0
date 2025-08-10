Return-Path: <linux-pwm+bounces-6979-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB06B1FBC6
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Aug 2025 20:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA763B7D9F
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Aug 2025 18:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30571FBE8C;
	Sun, 10 Aug 2025 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kc1B0KO3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE5B1F4E34
	for <linux-pwm@vger.kernel.org>; Sun, 10 Aug 2025 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754851974; cv=none; b=TOSyXD8HL2m/ultqczpUhKFM1GNAEI1cLuWYHOOamrfs0DeNi2snJwGN71k1ibVAjtJuoQjJyn7B0OpK24MZaOhLQtVkfpjKSiZ6AKGFsCx7cPgFhkeaYYPz7V54dgAeVfB5rkbw8Zyjm4v3JO/3XP1Dr0aBR8qCW72E7L+1yEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754851974; c=relaxed/simple;
	bh=tpem3ugXEXY+sza7Z065QDPEzGqVly+Nz2CDIYGjz8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYqwXroQrkSWZj6pBE6m/mrNr1k9J+moj2nzyPMFRUF0r5+lqDj8+aR+pu7LkumIoFkCa5JxECnG3t4JywkqnBmb0ivq5Sbu0By+bqizMG4IHVC/BjoTUWL3tqUxgeLjbBi07HpGsXUS+VBx5ccvwKAH7Jpv0jJh7oPtcy/wtGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Kc1B0KO3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-458bece40fcso18590835e9.3
        for <linux-pwm@vger.kernel.org>; Sun, 10 Aug 2025 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754851971; x=1755456771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZIFIadWiEXjzSuKWo1v9+wZy0Xasz/GeS9q0g0hnKc=;
        b=Kc1B0KO3AIEMZr4RRS+X7Ql1Ru3LFBiWy6r6TCgsypIMi8DZUXFL2PKzhR1vNnbcim
         gufTGox9CgXY3VvQC+4ttQr/b6Jmp/8Xa47Ct4kI3lQHcd3wqCT/0rm2Ck98tIDYKm2L
         TQpz4p0T5dp4bIi44UFL6ta5Hbi38lit1PNjE30wBb/zXY8l491VrtivtcQge/glr9mt
         iCDBC5pGVB/zGteJsaZnzgxUIflG3Rgb7x9WZuT7DcwPP6fsp3jrOMwlSPlqfyUyOq/W
         PZ0xplf4e32ibBYMY3F0G2KjQrLLfeKSb6TIaachekGAk8o201YMo2Qg7C09LMWhG7DO
         trMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754851971; x=1755456771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZIFIadWiEXjzSuKWo1v9+wZy0Xasz/GeS9q0g0hnKc=;
        b=fBfP0DDETCR6iHx8jkCd9MBUxcW3Oja9QMAnyzVYDNGsQrbAqHj6/DWtuk/UHu0hA0
         THe2reeSDpKRzCw/JaBjb2wHZx2ClSXdD36o3f5l/tjPqVhob6i3SKwqOp+7BNEykklf
         As4F4crleov5GpuzVIXP46dBCojIR4+6g1eopBsGs4++sokHfNrdczREuVWcoRVn3n3w
         n7KGsRMSBq1Y5tRjrm3NxAvQuYReCAg2DFuoj9TQHR2zuEAU4ggsBoQt6WIvCNde/tDy
         HkOBV4X1q870WYCWrz+C9P3M825EVZSA21VNZa7Ew/llxQY2ow41YE6lG64TvQR+y+7X
         uNrg==
X-Gm-Message-State: AOJu0YwfqXv/oqk8OpNgh3YPS72c8rKiZavWL3y+Zu5t0AdBO/xRy8JR
	3fAFtv8W5lB6Mcp4YzVw4GFyB0n/PeCozUapd+g3htmIStTI9xU8mls7UY6oeHLWdbo=
X-Gm-Gg: ASbGncvouOMgzkXhMIIQgml6QHhRgivev0ZNG+KzuyoqgBQwDeCgOrWoVwbPlmtRbXF
	8qJ7M7ti5CtQlmypZ7LXvZ+59kLUHzzAvSu8k0G1aFrBAdSxPVruL4vCdTJcYsjaEPyyAzBTBJR
	cnIheRjE6xr4tyVVp5Z/9xI9QmeS/9Vv5kJR6Dgk5yqF4vOEpwDH6/NPTRAbIEYhdONat8bs7AZ
	8OHDnIeBC6gCJydwMdW72FEv7KfLu8hj3QHBclf+mgf2tneaM92K37omOO8lxWyhoFMYSn5I1hq
	rbRnzxsYbvahOOcaBasJKvqQT5MNwTiuS0jasGEM2UoXjt3KDVr+V6cj/TJ4ifOhGopdMugfDWT
	pfpvZR/+fWf8vAkjP9ZgNFZfjTgk8bTVKOmmo1qSZygm1wCzQ
X-Google-Smtp-Source: AGHT+IHPiH3KOLHizWDnjfL+XzIReIg2rRjQJ1/ssMocHQ1ajNiUB1BrXhh5VbtJAuaEQ8OJc/8s+A==
X-Received: by 2002:a05:600c:4fc5:b0:458:bd31:2c35 with SMTP id 5b1f17b1804b1-459f4fafcccmr81128145e9.25.1754851971156;
        Sun, 10 Aug 2025 11:52:51 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm319461145e9.22.2025.08.10.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 11:52:50 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi.Procopciuc@nxp.com,
	s32@nxp.com
Subject: [PATCH v1 1/2] dt: bindings: fsl,vf610-ftm-pwm: Add compatible for s32g2 and s32g3
Date: Sun, 10 Aug 2025 20:52:17 +0200
Message-ID: <20250810185221.2767567-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250810185221.2767567-1-daniel.lezcano@linaro.org>
References: <20250810185221.2767567-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G2 and S32G3 have a FlexTimer (FTM) available which is the same
as the one found on the Vybrid Family and the i.MX8.

Add the compatibles in the bindings

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml    | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml b/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml
index 7f9f72d95e7a..c7a10180208e 100644
--- a/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml
@@ -26,9 +26,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,vf610-ftm-pwm
-      - fsl,imx8qm-ftm-pwm
+    oneOf:
+      - enum:
+          - fsl,vf610-ftm-pwm
+          - fsl,imx8qm-ftm-pwm
+          - nxp,s32g2-ftm-pwm
+      - items:
+          - const: nxp,s32g3-ftm-pwm
+          - const: nxp,s32g2-ftm-pwm
 
   reg:
     maxItems: 1
-- 
2.43.0


