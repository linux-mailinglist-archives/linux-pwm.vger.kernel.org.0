Return-Path: <linux-pwm+bounces-7027-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA6AB2397E
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 22:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278A96E27CF
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 20:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571782D063D;
	Tue, 12 Aug 2025 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yv0Tzctc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0082D060B
	for <linux-pwm@vger.kernel.org>; Tue, 12 Aug 2025 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028886; cv=none; b=DjIJ+kd1VETFaJQZ+Z7t8jQy5LPflicj0EEeOXIruGU+8ElDadaHM6WiTbGmnz93vnl3PTURx7amePkGqUFRjrKmpShZhS6JhZQf6v/YJ9ROBYotVJSkQX1UxfYOKvtj8iYffXpXf+z1V80Z57ozg27yCuFEGtFwTX6equ5B8YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028886; c=relaxed/simple;
	bh=tpem3ugXEXY+sza7Z065QDPEzGqVly+Nz2CDIYGjz8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bubMruCBp5v5F53OzfmfKSuNv/CiGaCsgcGGdGzQ5arg76IQwyeu3n4bQAvJWSkU1dY2Ehic6JX4oM8RjuuDa7f7UNEmpi+mFdx4PLKd8rCQtIF+5UFeXvV9lt8LA2z1Ld/7vAsG4GxJ285I3GVYOp38eUpHfqtNmeII5j3VpC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yv0Tzctc; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b78d13bf10so5945980f8f.1
        for <linux-pwm@vger.kernel.org>; Tue, 12 Aug 2025 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755028882; x=1755633682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZIFIadWiEXjzSuKWo1v9+wZy0Xasz/GeS9q0g0hnKc=;
        b=Yv0TzctcM/hTIm5SgXxsYKiP49iK3e9oy84XRdFlDKGxfoD4EJLxntIg43WFhcE1HX
         nuz312eFvRpGDhwmZ+mZEFYxs7UY4qf2xM5emIkINzLvzi3yPJIqBsrvzMV6OJ8ykZvz
         dGy5z2FDDxZiR8nHT/m9zGVKOv5mASa91XB/W82FiCEQiQ1UABuMH+q5SaePqwnuOtI/
         +U1ZxhbAG6UuEXTQgb+TelIB8hRtLrHkJxKTVlvPQvjL0Zrbdw1vfAQVLANPeSCFy9mF
         Gtm8VwsOmgPAr6IQd8Ff6bv6MGnKyYpHysuv4JmKkqClk0ZolZLdII5G4XADZ07lB2+y
         RHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755028882; x=1755633682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZIFIadWiEXjzSuKWo1v9+wZy0Xasz/GeS9q0g0hnKc=;
        b=DzicFIQBlROaBRRfE28UFruU7qzYkCsM8C6kAWB9osUm2GFjlG9/c/y5w2Hc94zimS
         7biuBvx8XIBnhuYkweHo9D+CTQ81fCcG59DDaXVofR47UdD8sADJyMDigF9hiWQGK2IL
         f4ByQnEzb/Dv5zWSw1VWNMeRHvRo804XgGOrlcHfMcSt8hX+Ito9fgGcYhpGEvaXconW
         XeTytFPv3uPAs54rLyZZoOuKKBgumBdJXD/r8ffBBLnauVp2SZugFQNADwfWKHm0nqVC
         ON+OMKia2GzFKeNXL9KlsHxJzoQxTrAtnatozWKzCOfBQVi32RhE5UhsilLdIAhrR+7m
         AceA==
X-Gm-Message-State: AOJu0YyygzkI1WGwbGCvu+VLzhSeC850SRCFV2mEdn4qYNfmwBEVzHjW
	pJO2nmRE0NEdaACF4NgYNFqs6entoC+SHqr3B4+lBdyh3Fk7NqpaMxsLKnUhjJTs/Uc=
X-Gm-Gg: ASbGnctS9oZbDel423oN9RbMJO6ppm3JUW7YKmRlG/i0H2C02CmKoJqSJzNNy8pyEWk
	YypSeoCH1rZ+ivEVV6Z7wG99wlnG+AqIQovpJ263gR4TfARJVr+kMtjBNLZKJNcQ7hyW0vQ2v6p
	QKt9Nncbl/7EQtkIGhQKLQM3BS7YhaIOUeDhi/9ypMxLD8B128L2HGIDhBb0kAiABPELewsQ48E
	wAKwbmBbVkUh9Bn88y4kL/NAFKfp09hOI2PefTIl0ywEWTZHGZqWQBDP2VvbmlQtCXEdoxyhGVs
	1Le3DkuSsy7GBklGmr8WeqFXetOvy+JQUIOBzPXaJvUD3wZd2nhTf3GFEka1DC7DAmkvOHMq1CK
	mVHcB8LtmhnpOIOrrWn+sdQMeVDN2LmgStf2onIXUsKyK6ZrJ
X-Google-Smtp-Source: AGHT+IHYvFBKyRBNQT4SWy4ddmhtgjeZuvH8xiyy6GkD7MVBNItPLtFOXFw2Iy1w8kyMUzjogW7vMQ==
X-Received: by 2002:a05:6000:4285:b0:3a5:298a:3207 with SMTP id ffacd0b85a97d-3b917ec5064mr177688f8f.48.1755028881970;
        Tue, 12 Aug 2025 13:01:21 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abed3sm45143947f8f.10.2025.08.12.13.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:01:21 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: pwm: fsl,vf610-ftm-pwm: Add compatible for s32g2 and s32g3
Date: Tue, 12 Aug 2025 22:00:35 +0200
Message-ID: <20250812200036.3432917-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812200036.3432917-1-daniel.lezcano@linaro.org>
References: <20250812200036.3432917-1-daniel.lezcano@linaro.org>
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


