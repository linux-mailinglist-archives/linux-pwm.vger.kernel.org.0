Return-Path: <linux-pwm+bounces-3268-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D998978E19
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2024 07:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDA8CB23E3E
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2024 05:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E97F49630;
	Sat, 14 Sep 2024 05:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irJHXsMd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1404175BF;
	Sat, 14 Sep 2024 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726293026; cv=none; b=HyH5AsfBSfoStBqzc1FyBREMqrSOaCoSC9iYiGVkBKrhefMdajvHBiVOzAlmfHj5HkHjIlbeg+goufs+NNepbhG/jKmfXPWng+b/g28LfyAGTIBNtscDGa1NbFymzMghmTzATGjfuo21OBnIseb+XofF5aNHiXT6kXGoWt1GSvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726293026; c=relaxed/simple;
	bh=x84VoDhpUp6vwVHhsjYCPB3VVl/fdTE7vFAsQK0EwTc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KjdQUPyXgvK+4QmgKSTwLEzRKhY8GXn/M5girnhTy6OcahKIm/+u18lza7e4P2PlBw8s3bvtRDfBSbRFW/clFFh68ialU+Je1fwGEt0egbNyvU8pCEhrnYl/MLpEYf+1MpOBRwJ+aSBu4JF0oGufv90pCVZqbtyy09kVEWM3X8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irJHXsMd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D7DCC4CEC6;
	Sat, 14 Sep 2024 05:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726293025;
	bh=x84VoDhpUp6vwVHhsjYCPB3VVl/fdTE7vFAsQK0EwTc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=irJHXsMdb/0SBC4n8kvDUpxCe8gpdkCzrnKbZCOfBdXwT0F7F9OFqIVul0QOxGh3V
	 R+sZijhp2HKu04y8jKNg6iLqz6uWllkymUrwgFzaF4uw2qxF3u5jcvaac/gr9iimP5
	 MxitkrDKOHusdWTWVi8gRNwmmLKI03OmZ1fo2lBTC58Qm5dTg/v+UrAFMzY0ahn75D
	 DsNn37BZbBiwVJhwHSn8pYO8Uz/AlQc4co/akcC0CVI1/6NLs7mXP1nWVM0qBIYq/g
	 q3eLJ8Gcx/KbVBQKDstZ2eDuWmRJfR2wQa7BnIN+WCM2wuACtPpvwefBUksxBk5/p6
	 48us6ysH0bfYg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD61FC6197;
	Sat, 14 Sep 2024 05:50:25 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Sat, 14 Sep 2024 13:48:58 +0800
Subject: [PATCH v2 1/2] dt-bindings: pwm: amlogic: Document C3 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240914-c3-pwm-v2-1-ac1f34c68ac2@amlogic.com>
References: <20240914-c3-pwm-v2-0-ac1f34c68ac2@amlogic.com>
In-Reply-To: <20240914-c3-pwm-v2-0-ac1f34c68ac2@amlogic.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Kelvin Zhang <kelvin.zhang@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726293023; l=850;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=jkkwhfD2HY3XpEmv2fppIWZ7XRYKVWP9wFrzIH5jMmg=;
 b=upG6pfE3Oi/FBjPRU+nkf+zdeEhsAdpdeHrLcqCTpPSv3WhaQKJWpzfP3mOP+jyOCt3o8qCmx
 dTJOXhQwUHNCVliqzt/TpaRX7jy9c+xh7Pn3xQKZ04ZLz3US6JflIHn
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Kelvin Zhang <kelvin.zhang@amlogic.com>

Document amlogic,c3-pwm compatible, which falls back to the meson-s4-pwm
group.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index e021cf59421a..cc3ebd4deeb6 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -39,6 +39,7 @@ properties:
           - amlogic,meson-s4-pwm
       - items:
           - enum:
+              - amlogic,c3-pwm
               - amlogic,meson-a1-pwm
           - const: amlogic,meson-s4-pwm
       - items:

-- 
2.37.1



