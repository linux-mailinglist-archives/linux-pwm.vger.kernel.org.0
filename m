Return-Path: <linux-pwm+bounces-5897-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B191FAB3735
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F677A28E1
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247E729374F;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbbyv0wu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D91C6FF2;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=FkJ9I0cNCPy3bDUIMYygGwU6Is3ghKWE4IwnV1XmE9F7sHakl1lL9hzP1pAEGwfq0+STeW0yMXffLhbus6saK04le/C7NiJh7LkqQHFbuSE8fsxJossH24RniynSD9S3CwSDvr2/i0HzfqpRb6ZqqT/hIo5yQd1ikOU6B7UgU3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=qXfPxK8iv4HT71BwVc8bhCncHX7rV2HtucsltCoXbLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mAVe1BTTsvVAmQsfYZIwtbWVJ8zcQnijj6rVvS5ElJF1NKmCn72Qf1E58OTsr75dNhmINdSDhl2pB3QHQXRUIt1+f/5gj8xQPE5btkwyb4MoPvviZwO4f4jKy76GoIcbVUgyUekJgyLaG/BT6NcAVOPdDLeyceAvpFPAnFtyUiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbbyv0wu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B12AC4CEEE;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053538;
	bh=qXfPxK8iv4HT71BwVc8bhCncHX7rV2HtucsltCoXbLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sbbyv0wucWd//guml7BvAhg8Wn88nL3MB+j/KRltDmBQq7lR+10ErtnV84LEcIViH
	 GqbRS72kSNAFArUp2S5OK612xR/+2/N7/B2HSdysqxKYQp03gVIVWlxrW/B1GinU5L
	 Ob4rkorRJY4buaILpH8Ioe49fizZwIuSSA7jwXuenPGMTf1d1aSGsa7j2f3I9v2aHj
	 RsLzegN/7r18NECUQeSJh7MOURIW8QvMdYB6PxoKYvC6r8xaknFn7L+6sGi7lqfh16
	 0ALT1SHQnE+83mmQeuFxZiPWc+kdeD/TqP/56j9Ql3TzKgvaFW/H4bxFxWpMwuUDqV
	 Er7tHjnt6mTFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB19C3ABCD;
	Mon, 12 May 2025 12:38:58 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:38:53 +0100
Subject: [PATCH v3 01/22] dt-bindings: mfd: adp5585: ease on the required
 properties
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-1-092b14b79a88@analog.com>
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
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=1054;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=HMDwWGXqEZmH5tU21NJ2ISWhkpP+9+F+CVII73zXj8U=;
 b=Cv3s6tWhQoxouhMe6TPpmSGdzOKweiTV/I7AWaKfpKPCapgBCxc2HfxMJNHYXzyUKEiUcwmtW
 CWT0sMIZLp5Ckr+UF7j1tmDD6qucvRJ+Vz79DQ9kr9D6g4fKttSExs7
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



