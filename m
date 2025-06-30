Return-Path: <linux-pwm+bounces-6599-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A81EAEDBFB
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 13:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE354167B1C
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 11:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2492857FA;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MkFOHsDx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1A2853EE;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284366; cv=none; b=sOTDi1NqYDUz2g5TCeD9Hwho8z1Zulu38OPv30fUyBNE1Cjns6WRGKOwA2lW2y2Im3XU1dQUd9zsJ2ajeu3w5eJim5rfPCufhn/EWZYJ6zmPBYX2ZgQKn9u+aSbHQWDlA/uKrOVtFUlkZNTk6tsw5tu1mcQEyP6wKkOKFsoxvU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284366; c=relaxed/simple;
	bh=iRAImbR13CxGF96nYOtOGRdYwCZoIWvK2a0xTTJEA2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KjLaQ2a053Ct50xYLhJLmiNNS3ToCxR4JK6b2SHdtY2u75DXc0D/Jyqnta0yJJWB8C+vY4U33Fe3ENGIXigQrD68Ik7v0/my5qG1T63xQAujiKelC0zil7piLPewTxWO3mmKIA50vRTuR3uiYj+9IgK4UTGQNLtgS7iVvWvMHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MkFOHsDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5E2A8C4AF13;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751284366;
	bh=iRAImbR13CxGF96nYOtOGRdYwCZoIWvK2a0xTTJEA2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MkFOHsDxZat3eemrez0pD6SjX7+GPoUHJJjm9YUWGWCQlZbzEj/eI9jz6KIDYr20p
	 uGkZCSTyH8KjrI6EXdK2gH4YqNkbKeNAxSCAXMO6amAarJc/TcA2g7/ML1Lpdr304s
	 rNW7UiR/PLGi74Ac4rGX70uOzTgVWnX0GttpLH2OSTQYeOM1crDj1387WxyE4Qxs4l
	 nhIiOIAHisLl0Uh81SPD2WBukr/jYHCAmMXefYejm+Dghjl5RGUe1uTKc6Be0rAJc6
	 duMhLySBN92XgI6DtI3vvU6KUZWMC9XJ0VBvSuMwJNbg2uyJjDhD6uc2w32ML9KRjd
	 itjungMqeHkqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56466C83030;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 30 Jun 2025 12:53:10 +0100
Subject: [PATCH v6 19/20] dt-bindings: mfd: adp5585: document reset gpio
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250630-dev-adp5589-fw-v6-19-a0f392a0ba91@analog.com>
References: <20250630-dev-adp5589-fw-v6-0-a0f392a0ba91@analog.com>
In-Reply-To: <20250630-dev-adp5589-fw-v6-0-a0f392a0ba91@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751284374; l=1179;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=UAynxy4/11+nlq7EIcb/MJ/fnCbsjiSsCCpEwnAXYqQ=;
 b=Wdyw0oT5+yxutfZcKitcjTeAfvTD9JXj3A7WDNQOsWv2tThgnIIP5jR8HF+a5qfhFlQ1UeFWc
 L6j8e++cppiAgil/zKzndgJ90VrRZKZ5Dlyvv/CPyZl1LDYp43iFYJ4
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



