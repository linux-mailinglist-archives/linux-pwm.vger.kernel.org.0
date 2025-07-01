Return-Path: <linux-pwm+bounces-6655-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4ACAEFC92
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 16:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886FB7A6F13
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243F3277C8A;
	Tue,  1 Jul 2025 14:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQgIT7Dy"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1B279355;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380312; cv=none; b=HpoUEmb4JDYKa1rmZLYkvUOUUzXNvi+557rn022369SfJL0QAO/nb1zL1vzRAKm4vZpk0v7IpfgCLdnr3+witn7SYVJmraWbHd7O8EDXlOi2uG1z+FE5Yfy8cw4kPs5DloNv+K73iWVMvR3PBXeOVb62fHEp5kgwAdddkjpZgpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380312; c=relaxed/simple;
	bh=iRAImbR13CxGF96nYOtOGRdYwCZoIWvK2a0xTTJEA2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h8FEHBVj9ntoQJw2tlLlTv3g56jHsWS8eOdCEVpY1hs1Q0kNzrTDPaQjY/sfmwZPViP2oVoOpQsBMfmGR6h2ORB3y5gvjxyI8sTPuueMQ6HgD6R/va2mo5mehZJ1TVmjHEUKH25GNAi+muFjOF9xJhrruusBfVRZr/GIt0qyli4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQgIT7Dy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFCE2C113CF;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751380311;
	bh=iRAImbR13CxGF96nYOtOGRdYwCZoIWvK2a0xTTJEA2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PQgIT7Dy5/mDpH14BVYZk9KDTzNv+LRHcz0rquaym6DUz88L4jqM79O1QNx6I8n09
	 04Rm2+dsjfeTeaZyHE6QttGUTiFPY+hn4E7Mlok5dtpoqGYUCSM0iaF9+Qpzx/haM/
	 mZwpsEl7z3ofVJQ5t+77SnXGjm0MAeUSMDfwBS5XajdByMZirO0NFK2MGAYkOLPRYJ
	 yfv2HSr0QG+z+zbETQJX7ZDvBSg/3WUAnjR88sC06jOlk4QKL22e/WMIHnd20BtOtc
	 0Z0gxAJYWtG1SGfRdkC94W48A2astjAGxyxxs/47hzHw9/Pm1J4hUZa2kCjWpU0+aO
	 6V0KkvDNcHD/g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC35C8303D;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 01 Jul 2025 15:32:14 +0100
Subject: [PATCH v7 19/20] dt-bindings: mfd: adp5585: document reset gpio
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-dev-adp5589-fw-v7-19-b1fcfe9e9826@analog.com>
References: <20250701-dev-adp5589-fw-v7-0-b1fcfe9e9826@analog.com>
In-Reply-To: <20250701-dev-adp5589-fw-v7-0-b1fcfe9e9826@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751380320; l=1179;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=UAynxy4/11+nlq7EIcb/MJ/fnCbsjiSsCCpEwnAXYqQ=;
 b=pINgyBlYK+HdrCTxLLJrgpQpKu6fViakR5ddQho9gKBmfKwfCpIs8jYLXib5FKBSs3Tujm3fv
 Ik7WN8W11O5AeRvAEvKm4EBxgjL6a3kgar16desrNRlQtOtw+Ouurms
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
2.50.0



