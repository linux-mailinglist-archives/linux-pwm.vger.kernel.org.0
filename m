Return-Path: <linux-pwm+bounces-6045-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B08FABF524
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 15:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B137A2663
	for <lists+linux-pwm@lfdr.de>; Wed, 21 May 2025 13:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095242701DD;
	Wed, 21 May 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shyGufyg"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9322B59D;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747832588; cv=none; b=HGe48Gjtt0lN0vtC5UGNZFEt/3jwDrfQrpxcJ2TbvYVNd9Q2o8ln34zzryHqGZyrwWkysseqhTlu8VgU49xGdPmgj/x7J0tTuhsJqNW/1cnwFId9GA1WUAqIYKt6nGMO1Ib1gEQG29XUEy6EwD795wTz3dfC7lQm/xtBWfJiSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747832588; c=relaxed/simple;
	bh=qXfPxK8iv4HT71BwVc8bhCncHX7rV2HtucsltCoXbLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rQNWbX/PQAHews2UuOX5mMlatooFpuh61+kObOMWOgFi7LAedmKNvnCOd7jz8+xTEm9fScFIuc9VTpKAjm9Gh+yLxaD0sETzanCzU9jGMOjFLRIkeHzx8WOzRb3CpuzGYN7+CnCq/AqlXgy0QfpedoZ8nvA+N22ibUKqwys+NuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shyGufyg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 330A8C4CEE4;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747832588;
	bh=qXfPxK8iv4HT71BwVc8bhCncHX7rV2HtucsltCoXbLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=shyGufygQVJ/cvrK1vNxaywNryh6MOQ4qLNtNQQH9ITmFDMRpdwk0VyjAuHVh87J5
	 LckZkY3EalwlByvslvxGwOeyE6oY/YfeO/UqAUxJAyDz45/oGeSwQwwH2kQSXZjv4z
	 5PlIVux6KpeI8CkFtioxsqunL4sop70aBkdgJ81YhfYkRjHnDvg+PMjSqoGJu3+uRx
	 n9ZjcGWh/isiykVsEmpPyZN2yntBYSmDh3Inm/murNUIMyznOcQRldFS3zQ4BBBokn
	 Sp61t1bx5dYgE4ugG3kAg8vPZRcfS8iK72N4UPu2af83HhvJthUWF2MtlnEkSwbSzS
	 zsK9XC1DJl5Gw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25488C2D0CD;
	Wed, 21 May 2025 13:03:08 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Wed, 21 May 2025 14:02:51 +0100
Subject: [PATCH v4 01/20] dt-bindings: mfd: adp5585: ease on the required
 properties
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250521-dev-adp5589-fw-v4-1-f2c988d7a7a0@analog.com>
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
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747832588; l=1054;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=HMDwWGXqEZmH5tU21NJ2ISWhkpP+9+F+CVII73zXj8U=;
 b=qMh6yLW0Dc0GfUGWC46fjYjjlqlBoOl7HjcCH9cjyYOOpCca0JNaKEhQx14xqKA7hRI4jopyM
 j4folpXzlQYAKdMEqSWs5OktJwkFUw0D/Asi3d7osdl7jUaEXJ1GSxT
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
2.49.0



