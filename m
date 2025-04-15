Return-Path: <linux-pwm+bounces-5491-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFCF4A8A190
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 16:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49BEB19007CB
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7330296D18;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGBxZ9z3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53701B0434;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728559; cv=none; b=siZzUVw5rFIj6XBoB9Sep8tbzSEOo8MruypfsFjf8Z5gI+RML0zySrtn1UbExwd789UiD/vhAEZt1zKEa+xjGr213Oy5xMmuwhJME1Xe9LSZ1FIzuI97sXtR85IS0AQfCYX2QPZ8X/jR+qUVs/MmVseVMDKGAUDd4rJXEqrtqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728559; c=relaxed/simple;
	bh=t+MFC0OOW7FL9P3NBvk9YJB1PRIqCHoW3sBDq9L3ph4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N9xUp8EZSheFCqeHbyptTx+GyHl9I+/O7UBVzWXrm54mat6+YaNhMOMEkZbNBa2neHjc7d4RhrBrPZODjL94J/hc8JtsxXWNphyLQcwN+r9iroMgFEX1AcVdBrpwJvwfysNWjGgTLKZkXfs82sRUJcDrWm6JgOiyVUAm8FjHFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGBxZ9z3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 340E5C4CEED;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728559;
	bh=t+MFC0OOW7FL9P3NBvk9YJB1PRIqCHoW3sBDq9L3ph4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XGBxZ9z3xXNwqTeXiO339vy9J3qyhWE+lqTVjKpfzQYUzY03RiVoMvRPOaMjr7c0d
	 6TX2+req5MKJFoa11WDATCp/hBEndaMg/x/k2qFY34VVK8hrtlwbHC+WDrfSsUAYz5
	 qBsKVxcPupcMvPUd+gAJWFATi2cmpN/iCYZAWi9K/cSr5JIoCIs1Hgs+WU9fs2Eqja
	 vBv8x8QImvGDOq3JkC2Q5G8DEppHwzzC62pTylEOF4COEDISYAW2AKryK/dNd7undZ
	 ELfSI+h2j0ZOzKKxLwtvWwPUUtKUbqrruoWZzTdA6pIZn9o+3lRntYW5aNq4C2Mlh9
	 rBmqDqy+aVDSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262F0C369B8;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 15 Apr 2025 15:49:17 +0100
Subject: [PATCH v2 01/17] dt-bindings: mfd: adp5585: ease on the required
 properties
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-dev-adp5589-fw-v2-1-3a799c3ed812@analog.com>
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
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728559; l=940;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=/k0WMsS4BWsTpP8Xx6eyHKSypU/ajvWKXfPISoK6ADU=;
 b=5rQS/8anAWBkFi99wDH783dhTAdGT/yvGR5RdywD0rSufCQ56NKmImnw1uPKEvZerGW4IcSak
 sZfqwfNZ+ggDVi+TAxCexIrMjM4GIm68YotXCsQqD5WU44zd+9/nNJP
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



