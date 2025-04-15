Return-Path: <linux-pwm+bounces-5506-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 945B5A8A1D3
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 16:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AF13BA369
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A17229E071;
	Tue, 15 Apr 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrUCvg+M"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC43529E04D;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728560; cv=none; b=tc3EIHoAYMM6895VOy2KyBPx9Wkw9yMJcs167woy6E64RFVDXI6p9G6QGtzk/caOb1XKwVrXHpYxqRV3WHbqC/M+azl4e6VeJMgDMtn0bclGwJK7N3exYL5SG3z3yAbFNUXcWff/xxb6foixPmUumpetCvRFE++rrfEjlPQLLpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728560; c=relaxed/simple;
	bh=7bLy2yqLgJL02Ifgj+oyaQLN7+gNm0nPbHLQa+MDOpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLdEW3h/nvaJPYGiaFg5mXj0eAlpeJmG152+c08UUshZnQvX/KTWJ+vPj8hvvtsRtFOaY1WedJQI2t29eLShpPe5mKQZ1S3ZL7E+hL9inv+9ak3IZ/5Xl3ezNNlz0jINsiH7KvDRjn4O0DLUTCSlPTjdWSrrD5BBoqvvljXio44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrUCvg+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 175E7C2BCB4;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728560;
	bh=7bLy2yqLgJL02Ifgj+oyaQLN7+gNm0nPbHLQa+MDOpg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VrUCvg+MA3usMUIeemzU0rNo8QICIhHbGcEO4r+xdOcNR6Me0QXGOPJs+uuPX7X2C
	 Ag7zMUzxqcZSL4bk1D/P3u6hoHJqaHshEW85XniIgbE3/rKdmmCy6VlU+Uv3qYwuBw
	 h4YrMpeVuviE0HEULMj8Hv16WokDE4jEowPkzk9BWZZrz9zoWB4s+Z8tuBlZjnHHZL
	 4yh8urpbdB3i2aMShpsK92k/+tLU5dx9C0E8iy5B22dtoYnaZKyzG7oGWcbVSskK9C
	 woig3sG5mysIQDYzbWtTs0zLKfrkdtwGn4tqA6gCPIljFJWqYisYhAf0VE0N6nDCU1
	 GgFEdlsXRyqZw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAF9C369AB;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 15 Apr 2025 15:49:31 +0100
Subject: [PATCH v2 15/17] dt-bindings: mfd: adp5585: document reset gpio
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-dev-adp5589-fw-v2-15-3a799c3ed812@analog.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
In-Reply-To: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728560; l=1110;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=EJgyFwH5Kj7vzTKA7DA+Bt8uPJfr6RlwqI4q0KXHGGM=;
 b=ui9o5aTwMMpNGflun9l0v0qdasSNMiL+e4YhBBTNP/WYkYMKks+dvdYy7+WOIgvtxgAPX4hzl
 qm/4MqaIx2CDHcQDTO+UeG1662mxjt02TRQ5Y1EaDr68LHU8O5e8mnp
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
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
index b7c36e2d4bfc4e75c856a0b8b9c842627bf3b1b2..218d6d6399d02adf678acff67b4ee246d833d209 100644
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
         adi,unlock-keys: false
         adi,unlock-trigger-sec: false
         gpio-reserved-ranges: false
+        reset-gpios: false
         adi,keypad-pins:
           minItems: 2
           maxItems: 11

-- 
2.49.0



