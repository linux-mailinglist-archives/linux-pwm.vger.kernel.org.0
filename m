Return-Path: <linux-pwm+bounces-7003-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DC3B21871
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 00:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4905A1A22A16
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 22:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958832D8777;
	Mon, 11 Aug 2025 22:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CJ02Psy7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24211C1AB4
	for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 22:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951459; cv=none; b=Be6aKeOkvuxNNfdsfT3WlJlwpbIl/yBXIkzEqNriosrdjmRHMTGitk3rabAz+IsHFgakEmRLEY7s5zt5YbCi1JExZYNinUUnTcw3UCpDKQESU0mNu2sN/g6HVXNPM5rzTXGzOtXY48B4lRDpCnj5Oy0cEHHBV/zBz8mi0WGr0dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951459; c=relaxed/simple;
	bh=tpem3ugXEXY+sza7Z065QDPEzGqVly+Nz2CDIYGjz8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGt5RXFcADkNIuXMEBBAHtzAE1vte6QLUtk3VQGjo4RTlCcd9gGmEoHeOWUUbH4Gwja/ckPzilrs4YWhLUqW3ltw6Vwoepw9nH+VLmqlANtHszO40icA3HHEeAeb+DE5scCH244hu4I+zGArw4o10R0Ae0AA11nBqr/W6dNIrdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CJ02Psy7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-459e794b331so29175695e9.3
        for <linux-pwm@vger.kernel.org>; Mon, 11 Aug 2025 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754951456; x=1755556256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZIFIadWiEXjzSuKWo1v9+wZy0Xasz/GeS9q0g0hnKc=;
        b=CJ02Psy7Jod4NwL1h9x7R9ck1PDAdi09hb75rniHQFZauHJ3TC5sY0Z6F5iP+Kfvnd
         zpK4b83GXHRaF9pnHRChwMd36YiK1+Ns2vL9o5dL+wIoR8W3qvzo5xV0c9GRSeCu0+j+
         RzU3mnT/14V6I7NMTE3mcZG08Z1JuF4ouhx3h8Rmq7Y6cHhvyJ+xKBHqA/G2kP/Ons3l
         f8ZwOTHVuuD1WGtrTQLoUEGlikqWLt5fLrgXQYeoCD1eQHpUFNVKV0urfGimxAXEZMa+
         zdYopxPNe//7/ZEOJCH3/ejJebWFwNXzQTIqrfPsAS2pV+Wespt+tSl4p8VQv1G0gqni
         AVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754951456; x=1755556256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZIFIadWiEXjzSuKWo1v9+wZy0Xasz/GeS9q0g0hnKc=;
        b=BYku3eidapxv2mkCi37oZHC7npemLQfYVyMsZwCO8xC6P3WfIqoT/NvkFyY4kF/s7W
         ISBqlgpLm1Mlc4q5jKrsiMGK+NxjsjJlprppVyLq4qaDrZ5D9/QAXjwXLsM1oGtcYP3a
         SyPu08QkRjg6lsKPk4r2K61gvbeJWGvbpYS6lgIV4n56xTG2SkU0ZS+T7Q5NCgwNVPAE
         N4FfKte46JxdC02QFgTHDdpAYdU+H3PhQ5luooE0Fd3Az2zsrWNFad9znmNUXxwLlbN0
         n2buwDqfGh8iqW3dNjN0qSgpqjFDmITVGoOGXrzZAU3dekJnn5A3o7wl3PRjuN9dILcj
         vW8Q==
X-Gm-Message-State: AOJu0YzgolEm5Cyr2fPWE57SFDhRBWu21Snc5ggWebn4QvAeaeSaj41C
	27UMNA2g3eUs4L3z4tWNv2eQ2hCTY/EBtNloi7MB/iwiQBDZKwTKV6nN8oEdjvr21fs=
X-Gm-Gg: ASbGncv/eoAQm1RY27e6s0FObjiBSuk556eJDVyknk/7v4nUgDuRKHrKAo7vh10GmL7
	NauKtT7OJbeOOWMIM/IcceoFejWhn93cTuooPwlkJKACrB5VrpIQQIPheK7mAxgbSYNmC4aquPx
	3Cx9e0CnUwOxQc6Rr37U68dnNUP98DqcW/1TW5Mu+HjbZ2jX7Tpjp0tAU9TYjf9iODBd56szGvj
	VwiQmzZg6u2IMDvTg7FfhNQo6yWsByHjBFgvY3uLyQmb6kSX+knBv4qyhC4yFNQho0JoKy0HRA/
	+dci6t+shSHeh4NtVBH/q+kGDe+eqjJJmK/9cYrkdu0mz7kSigQ6sMnnjxmtEjQh89DqdINp1Xa
	PsQTdapOoRltJq8XRW4EQDfBgJQ5GHE3JFZa1nvJPwXe0JQMJ
X-Google-Smtp-Source: AGHT+IEcfijsud9AJbAlisLtBCp6+CvVN9xcBIcukAdH0F565A40twZxHlhK+3nczktPx49heHuU+A==
X-Received: by 2002:a05:600c:c493:b0:453:66f:b96e with SMTP id 5b1f17b1804b1-459faf4758bmr98113305e9.11.1754951456086;
        Mon, 11 Aug 2025 15:30:56 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e5853104sm271557715e9.8.2025.08.11.15.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:30:55 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt: bindings: fsl,vf610-ftm-pwm: Add compatible for s32g2 and s32g3
Date: Tue, 12 Aug 2025 00:30:39 +0200
Message-ID: <20250811223044.3087090-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811223044.3087090-1-daniel.lezcano@linaro.org>
References: <20250811223044.3087090-1-daniel.lezcano@linaro.org>
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


