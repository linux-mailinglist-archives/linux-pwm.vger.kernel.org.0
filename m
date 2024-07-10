Return-Path: <linux-pwm+bounces-2755-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C39C92D6B2
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 18:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D46F1C231CB
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jul 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2D1990C5;
	Wed, 10 Jul 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mZ+/U5Eb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D2198A06;
	Wed, 10 Jul 2024 16:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629428; cv=none; b=fn2NLhBLuBj1ekACakgWm8ycTQWN6+p0XkZyYWQ7z9pdIP9XIN56c3ESncuxGYIeL007xwZ/B1bzYwZa9MzzakQopaZsHSGQGebMLEkAxxXPiB+Y1AQTNAfJX9912d/T0b5C+fhKiBCrpPCgT9EQpQtc6cjTfo3I7o8OM8Strh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629428; c=relaxed/simple;
	bh=1g8hzPvd2UzxG9OMx/Rv4dhInp4CWnW1AAaOfa9+jWY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n8VA4+ufY8HBs+4XFWMFMU5+bYmcTNnEtaPSZWf8S5lL9QocjZJGalrQr749jMMQvpg7N3+HO9KSpScD+ZucklVkR0DpYpUCAaGnuueuJ7CE498u3ZT88shKEs1RwZ19f7TOVENlSec2SlnqW4lWIYolOmIAlWdbeBO6FUoy9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mZ+/U5Eb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1720629426; x=1752165426;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1g8hzPvd2UzxG9OMx/Rv4dhInp4CWnW1AAaOfa9+jWY=;
  b=mZ+/U5EbkIdE0VKaSPqEHjjf82YNSkEFXjwsT4Z1mOi0itv91pTGAP54
   FrEvdV/TPxNF+w8hEXvrcYpdMECstuj9b4HtGDk0Rq8u4xgaQhRFiIsm7
   xmBJIJRPspod1bZ2enTl2lf49E7aZgX/T+zShUqKNVBg1AXYAYxvtIpFo
   7j3Dsdg34HQEnwztvMfH7SB6CrHVdFg90IApW5x0vywsA2zmot7nnzUv0
   fagCE1+lKCVy1IaOUMDAjovMh5AW/bI6ydFMTtfxWQxw3U4ApaAbGBa7/
   ctuGlpOsQaM4c1r2Bn3FeEJIK42gDHD7JlgMBEJYcJwJ6hKzHTHmgW+FY
   A==;
X-CSE-ConnectionGUID: ickCQRjXQnS7WGcoTl0c4g==
X-CSE-MsgGUID: LTIQOG2wTne+AFjBWZqzEQ==
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="29044327"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Jul 2024 09:37:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jul 2024 09:36:35 -0700
Received: from ROU-LL-M43238.amer.actel.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jul 2024 09:36:32 -0700
From: <nicolas.ferre@microchip.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>,
	<devicetree@vger.kernel.org>, <ukleinek@kernel.org>
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pwm@vger.kernel.org>, "Nicolas
 Ferre" <nicolas.ferre@microchip.com>
Subject: [PATCH] dt-bindings: pwm: at91: Add sama7d65 compatible string
Date: Wed, 10 Jul 2024 18:36:51 +0200
Message-ID: <20240710163651.343751-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add compatible string for sama7d65. Like sama7g5, it currently binds to
"atmel,sama5d2-pwm" compatibility string for this driver, so add an
"enum" to reflect that.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
index 96cd6f3c3546..d20ad27657aa 100644
--- a/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
@@ -23,7 +23,9 @@ properties:
               - atmel,sama5d2-pwm
               - microchip,sam9x60-pwm
       - items:
-          - const: microchip,sama7g5-pwm
+          - enum:
+              - microchip,sama7d65-pwm
+              - microchip,sama7g5-pwm
           - const: atmel,sama5d2-pwm
       - items:
           - const: microchip,sam9x7-pwm
-- 
2.39.2


