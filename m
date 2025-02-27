Return-Path: <linux-pwm+bounces-5018-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89683A4870F
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Feb 2025 18:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567FA188D30F
	for <lists+linux-pwm@lfdr.de>; Thu, 27 Feb 2025 17:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA56E1EB5E7;
	Thu, 27 Feb 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcSQsCMj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FA11E833D;
	Thu, 27 Feb 2025 17:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678720; cv=none; b=NLqpGFtK1H1v5Z1ngmIrZ5rBX8IKPkTNetTXbrxwyTFhF9V23QtQsBqtFobQKZlJP0c6d40InKGY+91nugNZxMb+qonx+pLVlgb8OMTbWz54JKvTatSr8S8NVVuooKrqayqxMRzrrmuwfhkIHCOjUJD7K+2yy1bXl7bdgYMmFRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678720; c=relaxed/simple;
	bh=/4rYifw7cWKNiMrck66uwKDbuVPIV6lSNQPd5n/hwLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4dktWF6eLyEZkhTAzyBIB/nv6ipvGut0KBcqPdnj4RAxxDnN3rC9KB6cpSWh9/bbLj3BbiRlMNO5x2gQa23vI3D/bNEmZCZ1vXL7VgExvZaegTIpPzLUM+N/c/xGNXlTmGnIJZAJl2UIHNAWacATrkSsHDTrS9kaMqRotOuhsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcSQsCMj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3234C4CEDD;
	Thu, 27 Feb 2025 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740678719;
	bh=/4rYifw7cWKNiMrck66uwKDbuVPIV6lSNQPd5n/hwLY=;
	h=From:To:Cc:Subject:Date:From;
	b=rcSQsCMjbO0ubBQ3WSvGC4PNqlRcBFX3iGlgDq49pGLnwuxMnVpQ2KmSZMfZgCUaj
	 KoCw7qEuipvBy8gLW0wz1iFDW7809jpaO/XlBoBxiQrhFfd77ETYS8EzM6WeaVYswM
	 g2wezDvYo/kjisPePUDtOsmiVnL1zjVfD5sZ9xspd63Hlxod5pZ4aI0IyL+KlDsflw
	 Ljh+1q0mm/Sss7tkgQ7eLgjcS9NDpI2dW4bRc4IFi2MALHeK4Aa64YnGZmpF8ub/a3
	 RWFSVlf4453NyT2Uwn2vEuvlFfAKy4XpHIOaMjOUTkUDv+pBoiWhO3HF0WLUU2JkYS
	 arGldqg//CkHQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: linux-pwm@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: gpio: mvebu: Add missing 'gpio-ranges' property and hog nodes
Date: Thu, 27 Feb 2025 11:51:32 -0600
Message-ID: <20250227175132.3734524-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Marvell mvebu binding users already use 'gpio-ranges' and have hog
nodes, so add them to the binding.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
index 33d4e4716516..7ed5f9c4dde9 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
@@ -72,6 +72,9 @@ properties:
   "#gpio-cells":
     const: 2
 
+  gpio-ranges:
+    maxItems: 1
+
   marvell,pwm-offset:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: Offset in the register map for the pwm registers (in bytes)
@@ -96,6 +99,13 @@ properties:
       - const: axi
     minItems: 1
 
+patternProperties:
+  "^(.+-hog(-[0-9]+)?)$":
+    type: object
+
+    required:
+      - gpio-hog
+
 required:
   - compatible
   - gpio-controller
-- 
2.47.2


