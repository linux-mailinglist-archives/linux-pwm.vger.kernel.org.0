Return-Path: <linux-pwm+bounces-6639-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B63AEFC57
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 16:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019F21898B98
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Jul 2025 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C26A275AFF;
	Tue,  1 Jul 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJQ0GJBR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3492C859;
	Tue,  1 Jul 2025 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380311; cv=none; b=XgycVY7heS0lrftrH4Pd1F5+jhjVjZ5ZBhWrx6gm2XgxqCUDYOnJAcb3NbBNUpcHbCeT+xAN9iSaJIC7jqjCdC9Am88f+ZDnDFCoZq0tw5XaG/2mz5JYvWRfCDmsx0TMbdxML0vzRvhQEP8UoecznCefefnw2NDEyriu1/rBuUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380311; c=relaxed/simple;
	bh=xE9LEXnv+f+pNg2IH3v72SIq7f78Vz1orUlvYd/H3bA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qFJFR7b9gXM/oOAXzvI3pCpDxuUFuHx0v5FlNm7LIL1XPPuKYzVpinvbNjfkQBBr4+4QpqLt/bHrrmZaiuyvyuHaC9gDGTjGa7SciLHe2WIQ+S3Kz367MxdJAnXeGDySg2WPEzVhgD1r8LkFU39OiXCxl9mLawqavvDvO9Q+bsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJQ0GJBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B999C4CEEF;
	Tue,  1 Jul 2025 14:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751380310;
	bh=xE9LEXnv+f+pNg2IH3v72SIq7f78Vz1orUlvYd/H3bA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QJQ0GJBR0U1kfetG2uyVBjfZ5W63Nt/V8c+/Jg5zaAXzkVQsQ+qR2O1liw9Li2i4e
	 yMnkO0y8/jl6T1Xbt4lbiP7Jr7npTSwLl39Z+HdxXuBF1GWR5rWMksBz/ZwreuwZoZ
	 aWPU3KVmaibp0jXxmXope55o5kMaVDxL4fgkwpbnpKagHwg3MZth7zxp4vav8XjBmw
	 nW7E5bQ8NaX99hB7VZV0wm3b6lAidBfGrSc7lMtEWrapjxY4oSoUWHU8C46pG+980A
	 XTUN5PspxnQgLvpkCED2CLBiIHELcltTsmsrbH/7gc14oh7UTzpg5Ad+80f6C/VPDl
	 kdAuqQYCKbNiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCC7C83038;
	Tue,  1 Jul 2025 14:31:50 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 01 Jul 2025 15:31:56 +0100
Subject: [PATCH v7 01/20] dt-bindings: mfd: adp5585: ease on the required
 properties
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250701-dev-adp5589-fw-v7-1-b1fcfe9e9826@analog.com>
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
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751380320; l=1054;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=fiqzA9oHr6utDnbinR+jWc5MyikFuofO+NDW02/Pf/k=;
 b=o+PSJdFr5dWxcowKAMvAiCrBfmIS7LrYCenIVhDwPOLdRXkuzaLIFxe6Gk11SEaNAqZAJoKF0
 y7o6uiCuJnzA3F7maZodeomTE27ihBABdg9gEkTH8zM2CWbgfA+HSHJ
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

It is not mandatory to use all the capabilities of the device. One can
very well only use it as a gpio controller without the PWM support. This
will be even more evident when support for the matrix keymap is added.
Hence drop the requirements for PWM and GPIO.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 Documentation/devicetree/bindings/mfd/adi,adp5585.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
index ee2272f754a339569c793102928ddd13249f8fee..e30e22f964f78519b2ec207e9415e4897db5c702 100644
--- a/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
+++ b/Documentation/devicetree/bindings/mfd/adi,adp5585.yaml
@@ -52,9 +52,6 @@ patternProperties:
 required:
   - compatible
   - reg
-  - gpio-controller
-  - "#gpio-cells"
-  - "#pwm-cells"
 
 allOf:
   - if:

-- 
2.50.0



