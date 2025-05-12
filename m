Return-Path: <linux-pwm+bounces-5914-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E47AAB3771
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3623189AB24
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264222957A5;
	Mon, 12 May 2025 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/2WgpNB"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB36E2951DC;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053540; cv=none; b=uWLRN8G5jll3c0IhNxiQe2Iq8Ob66sdN3AozS6r+s6+XTNvCBXjNLa6sKCNBI7kdb9eUDNq9LO9ytjF3GGoxSWTQnstCofhqAkwwzfpH2Q4FY0AKWZ9pK/oZXpSD2hAx9zZWCprnrPKDteKxNHW2Up00Lw9W0nuZX4HBxOigR40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053540; c=relaxed/simple;
	bh=z4ucjaajEADJBwXGr5mYMiwXBcLcX2/I3GqJ5PM7YRE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GH9vSpLCsBO+HitKpj6WxhS57weHbHdDi5VzkWW96CU8O9TBmx1mNf78/cKv5T8RNpYrNWQrgJvRtHMP1ZHLTMlhk6ETADB0gpYDin6yKcWAfyYGv0oPsaOv4xkE0dUvKv8HRSvUpbJON44nw9n9VRIRmLFnes2f9X2LaySgCjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/2WgpNB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D0BDC4AF15;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053539;
	bh=z4ucjaajEADJBwXGr5mYMiwXBcLcX2/I3GqJ5PM7YRE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R/2WgpNBM/cPnihfjMRg7cUsh7OyUawmN+8y6dyGQlu3cD5vz4/qyanbWRJ8pma5b
	 D93eMtMjp4fjORn5W4cigwkvy0yfSigDQJiAZHPuPG8xjdhZTbUrX2PBdYbIlIGjTz
	 ZgQ7srQJb7lyb2rUAT0RoZKydE7gIU50P0KSD4ekEPGq2K70Vw001rngoytHUScqnV
	 cHAsGE95RyMiLCS1vDuLiMi78zlpjHD+M1JJAJXgfbe3sd5zMWntrpbBKzZH0m7Rdg
	 WNgKSwZTB/giQwBsu4Gxozkuj1tvjCpNuk403BNOMffXT/nyR9T5up5bBOXTuBzomT
	 mUXh7L4ctgajw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF4CC3ABC3;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:39:12 +0100
Subject: [PATCH v3 20/22] dt-bindings: mfd: adp5585: document reset gpio
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-20-092b14b79a88@analog.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
In-Reply-To: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=1179;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=xIIvyKCR09Vnww1LWnAAGLhq9ll42BMKiYjeqCeEyLI=;
 b=gnwzino4/l1Vn9DYmuDETOJOwy4SQW2URlsFNMNz43nHILXrhr6Dz+T1oF6VQUSstcfhML8Gz
 mNFDO7/h/+PC+5eDOhEs7BZ02htbTw32QDH3TJjc0bsx1iZza3qR56m
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



