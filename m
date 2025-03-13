Return-Path: <linux-pwm+bounces-5155-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 044CAA5F788
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF76119C3B0D
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24106268694;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUTQpfwD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898E267F77;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875558; cv=none; b=NamOeId/PJGji1Y+DaL6A/wiay4592tsdSB205JG4h+GVotdXytZClPPjIEkYTDmgn73w7DIyeXCmIuqGlK0oQcon0JuODAkAMTPx3A/whLmWwQHMsP0krQFah2mtJRfkLW0ZSLah7spLM6I2E0KIEP4m0zOUJlS6UbyxcHg2uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875558; c=relaxed/simple;
	bh=YtEjpGrReXVVOC7M4ZbCelu9IjfNeOo8tGBCnUi0BH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N48GomlTrgWUtpMq5ZvU7OTgqgKfI4teydM+vSb1ZeD5ILMIqSe/FcQs7GnC/4gDsmJkHlskBx+DlM7SL7uiMnv7OBJjsDlct0GRDiM66x0iXJ70txVjWpz/J0QoxuQ41AzG7AMCN5w9/6V4PBrQckJP24RdNV+BYscNHs+wBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUTQpfwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 574B9C4CEEE;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875557;
	bh=YtEjpGrReXVVOC7M4ZbCelu9IjfNeOo8tGBCnUi0BH8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SUTQpfwDbNDzFiovKEB+v6Rv/PxJEw6fewrqa0ygvA3ZRvsZq1chqrofFw9BVF9pt
	 SpMRN/yg+G/I8O7wqbOJapEzzYVUl1qjbZNiz+Mdy4uXQ737oCGd4NQO3RXyc1zFlk
	 6aUIFEw70EJdIIaHQ2F/ibzPXpe0FnmJZe4UzlvCdE5ZxeNRxaGYIcwiXuSGpmscze
	 ZWI+5/bhMypcP0fcnsLWQuoJokCHnIYbEfi7crYIdezowbzxx74odQrCDgMP4QrYqd
	 Ks86sdhbJodGHwBuVRfJLcFaJ1/WDgf0MSrfGT7wKFl7DjCVOBldEu2g3G5JHoXjJH
	 lun/9xaBuC1NQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CE4C28B2E;
	Thu, 13 Mar 2025 14:19:17 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:18 +0000
Subject: [PATCH 01/18] dt-bindings: mfd: adp5585: ease on the required
 properties
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-1-20e80d4bd4ea@analog.com>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
In-Reply-To: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875561; l=940;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=T2atPfBGTb1TfWuyPCIna6CG+VGxW5uOUwbdmZcLmO4=;
 b=ZFI7u1RwR+07opm2Y9BPmSivWvT71+iT1KcQNPQIhduLd+InaybjhEAdsagJUZzaCZ+cuEjKN
 0RyWCRQ4TIPBQgmmGMBNxBudwHOHwtj1YqTKbxOkREMVLMucW6L+9FE
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
2.48.1



