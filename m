Return-Path: <linux-pwm+bounces-6060-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3E5ABF576
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A682E8C0A2D
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39EC27AC43;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WimDkYtJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7519B274FD3;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832589; cv=none; b=u5cNanUIlGHbe9nmu8i9lmMbFj39qKS4PkoE3zetfPw8NG+VwYvsq8ToD+U2DiaCl1pRuByzt4LVMjSECgxuB1WqrpY3V/+C+tCtGptuVOAxdaLP3YJojipUKdsvZnfnnEh7vzndW56FpJ3p3qGbv60IXMLBlH0FvezP2sjmxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832589; c=relaxed/simple;
	bh=z4ucjaajEADJBwXGr5mYMiwXBcLcX2/I3GqJ5PM7YRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mmDB7hZtwnU/bLZEHsIl7/fptNtam0vHVQ4sLLqGuzZnWnvMUs55rp6KjCg09tplCxEPaQr4p0MTu+DvAmNKdVNnNTiWjEtHTgkyL8bAlSXUNsfKkYajnM6AeuvEniHGvPFYqCX8FvsFFX+OL5tM6Ru0k2NP766Q/QQ4Vt3WRE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WimDkYtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49708C4AF0C;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747832589;
	bh=z4ucjaajEADJBwXGr5mYMiwXBcLcX2/I3GqJ5PM7YRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WimDkYtJ8OcnA0yIztm48oYiqjwK8ceGZe+0oJKwVhZ/nb5MzophP+Y1/1WWFkCdt
	 v4opzOo9H1rAXd5IjdfM69ps/deYOTeY/yf6rnyWy3fcKcL1GXC9pxTxQHt26M46Ye
	 /uGAa5WlCqfXea6JhBPqjwP+kmE6boKNO0XdEdsYS5KJ+Ndp7yU1/iRmEs4mHeUPZg
	 JLxC+iZdzAml1C1kS/XtHR/lOOi7Ub6Lzi8FjbO7+2wtwHQDnMmm4Q6b2mymcMscBP
	 WwxYmW4/8g0fP2mgBXV12k2mhfmaBJwMNizLphLL8bLC9HmmKJJjTfmjS1Ir6r0AjJ
	 SQPynFnRYBYzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412CEC3ABC9;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 May 2025 14:03:09 +0100
Subject: [PATCH v4 19/20] dt-bindings: mfd: adp5585: document reset gpio
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250521-dev-adp5589-fw-v4-19-f2c988d7a7a0@analog.com>
References: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
In-Reply-To: <20250521-dev-adp5589-fw-v4-0-f2c988d7a7a0@analog.com>
To: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liu Ying <victor.liu@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747832589; l=1179;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=xIIvyKCR09Vnww1LWnAAGLhq9ll42BMKiYjeqCeEyLI=;
 b=ve10s7piIlulUWTxl7XFzZmGPHhRexblgWIOEDdKR4sxWDQPghGcrzwa4QjweQYjVMa2OWCI4
 UzSfmKpdcO2Dq6deR8kVHGdVi+fsiFxkImR9jYoHvNrzOIJFYs7AXQj
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Add a reset gpio property. Note that for the adp5585-01 models, the
reset pin is used as the additional ROW5 which means there's no reset.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
index b3bf2ed586104303fd078bd06683e4f0d3383575..2d4ecee3f2547ad07a0ab8fcbe96f42f526d1619 100644
--- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
+++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
@@ -39,6 +39,9 @@ properties:
 
   vdd-supply: true
 
+  reset-gpios:
+    maxItems: 1
+
   gpio-controller: true
 
   '#gpio-cells':
@@ -166,6 +169,7 @@ allOf:
         adi,unlock-events: false
         adi,unlock-trigger-sec: false
         gpio-reserved-ranges: false
+        reset-gpios: false
         adi,keypad-pins:
           minItems: 2
           maxItems: 11

-- 
2.49.0



