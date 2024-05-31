Return-Path: <linux-pwm+bounces-2306-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5E98D6431
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2024 16:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 307281F2659D
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2024 14:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6469E17CA09;
	Fri, 31 May 2024 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QivFVmbP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33BE17CA00;
	Fri, 31 May 2024 14:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717164757; cv=none; b=d8OQDD8LfS3IFk0m4rl9MmZt+EUHl2tfuK7FZP75mCh6tPrWmzs2s5H2VEpwI7RZaHLZbBaxmkHiWRGE8rquM/icn7I6yzRrhoQWf0MNxO7kc65XZo7rVREigsdrzb49YncXdyF5Ca++n+2eLEsovfvvyq9MqHij9iIMKXl8zT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717164757; c=relaxed/simple;
	bh=DmF9pN0adUq7Y61FuW2i/zWhZEm2BHUOkdLHuctMo3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ntkwi4h2UqIrrCgsc7O0wxrhu17qBack1e/8L3dXRqFS82Wpu0nAU5N7tIXwk7l9LwiAZA3RVMONw3UXKQz8/AZCLYEnFwhnfUmJDTktx4FM8sCxeQXd98sTgdmO/YL6LTgoxXxn/ajxae2EqzjaX0dpGfAP0vsFuc81VW7PeiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QivFVmbP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-702447766fdso890881b3a.1;
        Fri, 31 May 2024 07:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717164755; x=1717769555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOcPgbtosl6aPaHyurBEDKVmEjsqOQ4R8FjC6nla/j0=;
        b=QivFVmbPX9DTm3O3o0R98juRRWl9dm8iaC+99kWfV8sKCogV8n0BgCkrpVMmQ0Agzu
         a/w0p9K4e+74Dsg4RHPyhd25Klk7CmWk/i/fP6XbEApGn0FBYLa1pLdPNScD0PF1xBzO
         XMyjFtWn80UEkuVRXqGB7AzfOn7KHf2JwZ4jDl8FzaWiZDCqxQZJVIUBr0A67McmaKHg
         mqeDrWo2Q0aj+PXzYycLkoVIe8p76n9hjvwlRtYWJjUQnx3QeOfccRXdljWL0JqTUgUP
         TIM6G+sFQ2J5DBNevHlbqfUknkCcleFZyLW5dHxZu4AYVD3Q+73GDHFD4WmNJisqm/xu
         V6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717164755; x=1717769555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOcPgbtosl6aPaHyurBEDKVmEjsqOQ4R8FjC6nla/j0=;
        b=xOiAIRTfze9yfWKfyVJYtFtQ12ePJjidbv9Ots51Tze1ahPVuMMcUZt4MM+M47LtXa
         CkNcBIxBzB+3YZjVjYdFK2HaSXKoeT1FjR+9vh8mfgy0oFH82t2886Is9ZYyMoiytTc7
         lBE8X6bN+SnD1yl5bJC0+nt01NgtboPMsuIGV1mDS4E2fnclgVMTIcpRfddwqangsRj4
         7TNUdmFrAEdoG5gTskTHG1KfD6IQrs9IKrQGkmyw7lArdKULwNnyZcTJQdd5zWX6IZWt
         Jf3cgK7Yza9jjrhIOWLUMZhPSR/7yWOkJjY9vZv86eNSpzNlIG+CMVyH1b6NoB7Ur3Kb
         ywUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHNY1xYMcenS8AxZH/KqPBUVj7VGuwcev4GVBThc1bvJWUoX/+czw5Joq3S226sgvqUHcbacl5lFam1hOellhjDvecqNmNzR6qPtFCV76tGOydUT46Qg5q4f3K+XQ3S9s2ArklJQ==
X-Gm-Message-State: AOJu0Yyv3c6fUkYC1JvxJbStKa/I+0bgRzPQQGk+EtcS4U4mMAQaSR9c
	R0GPqfEmiOqI3hemt9AyLkYdXsiPngAp2t6eWzPE2zSlvmq++2lA9bnglMgl8Jg=
X-Google-Smtp-Source: AGHT+IED1pv9oGjdH+Ngk5fD7H3whpkkw+4F3I2DkC4Ur7bEQ6LnfE0ADN36jmtn6xY3QZI+rCQlyw==
X-Received: by 2002:a05:6a21:33a3:b0:1b2:6b27:5cac with SMTP id adf61e73a8af0-1b26f1f73b5mr2415856637.32.1717164755418;
        Fri, 31 May 2024 07:12:35 -0700 (PDT)
Received: from noel.flets-west.jp ([2405:6586:4480:a10:167:9818:d778:5c14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70242b057besm1418103b3a.162.2024.05.31.07.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 07:12:35 -0700 (PDT)
From: Hironori KIKUCHI <kikuchan98@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Hironori KIKUCHI <kikuchan98@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Aleksandr Shubin <privatesub2@gmail.com>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 5/5] dt-bindings: pwm: sun20i: Add options to select a clock source and DIV_M
Date: Fri, 31 May 2024 23:11:37 +0900
Message-ID: <20240531141152.327592-6-kikuchan98@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240531141152.327592-1-kikuchan98@gmail.com>
References: <20240531141152.327592-1-kikuchan98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds new options to select a clock source and DIV_M register
value for each coupled PWM channels.

Signed-off-by: Hironori KIKUCHI <kikuchan98@gmail.com>
---
 .../bindings/pwm/allwinner,sun20i-pwm.yaml    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
index b9b6d7e7c87..436a1d344ab 100644
--- a/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
@@ -45,6 +45,25 @@ properties:
     description: The number of PWM channels configured for this instance
     enum: [6, 9]
 
+  allwinner,pwm-pair-clock-sources:
+    description: The clock source names for each PWM pair
+    items:
+      enum: [hosc, apb]
+    minItems: 1
+    maxItems: 8
+
+  allwinner,pwm-pair-clock-prescales:
+    description: The prescale (DIV_M register) values for each PWM pair
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        minimum: 0
+        maximum: 8
+      minItems: 1
+      maxItems: 1
+    minItems: 1
+    maxItems: 8
+
 allOf:
   - $ref: pwm.yaml#
 
-- 
2.45.1


