Return-Path: <linux-pwm+bounces-3124-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDE096F483
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 14:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA101F26C34
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 12:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EF41CCEEE;
	Fri,  6 Sep 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLNo9AEJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492921E49B;
	Fri,  6 Sep 2024 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626788; cv=none; b=cA294pket1SRFEzUFk53hnTswjtI+lDhVrqKu2jaLjFvcf5i0Uj7frGwN35duJX9AHy3KHHjS/j7yeh6JihAScjo8ovkv1OPRCKx0VEGVRVzZWlD9UCYhVWC8qcOILIPi5h6xA1N3kbpIR9QF/1ooKIUHMVqNvgU8IS0E7Dfu6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626788; c=relaxed/simple;
	bh=BnPFHWuU9ITav6gZzvi15hJTlIdPoiLYGWVSlobaA9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gz8kK9SLFqKNg9TOQIXgD2LiAfAnVlm4xpUQsO+xB65VRyUBDdPNkT57owwRY2t8Lz4BK80ids6NcjKoBKUrzGyhzUYRlT/Rtf4cqPgPpyaDpZWtmBQ4uz0f3aQYBlutZARlXpMHZFx80byrmW79RlaH6nJiswX3fFUp6AJJoc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLNo9AEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4206C4CEC8;
	Fri,  6 Sep 2024 12:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725626787;
	bh=BnPFHWuU9ITav6gZzvi15hJTlIdPoiLYGWVSlobaA9s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VLNo9AEJgunAHOrC4eMHBfi8ictN6e8ftTcynwLnpRn78fZ2TA99CnhQcQVMbkJCn
	 bB6cMSF8Xsod/gc2BbMKD5uSe1Yi8+2X/elkBnROE607KG5ubyq/Jzc46+FepVK/oU
	 fQyMPxp1uanwUX+pz9T3NSE6FizrCqybg38+wJcM9Sfr2uLoCctek41le+1QakYCsp
	 gD4QEtewI+cNgCvPxHl8Qx7GocYy51sM+caPqJs6/rA1P0CBafY8Fz3E/9xu55aEml
	 BM1yht0nKd0MEaf8VT7B9Vin4kMV0Ddi5KABaV1T2bZBr7nLbWvl9E+5vFKDDSPtO5
	 /zxUKX4LyCdXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43E1CE7B09;
	Fri,  6 Sep 2024 12:46:27 +0000 (UTC)
From: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>
Date: Fri, 06 Sep 2024 20:46:12 +0800
Subject: [PATCH 1/2] dt-bindings: pwm: amlogic: Document C3 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-c3-pwm-v1-1-acaf17fad247@amlogic.com>
References: <20240906-c3-pwm-v1-0-acaf17fad247@amlogic.com>
In-Reply-To: <20240906-c3-pwm-v1-0-acaf17fad247@amlogic.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, Kelvin Zhang <kelvin.zhang@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725626786; l=856;
 i=kelvin.zhang@amlogic.com; s=20240329; h=from:subject:message-id;
 bh=IKxQCbqCymKpXimBeJjfJfj63RpeX53D3eg20nkQmNk=;
 b=zqPcIqkIxj3orOtAbzHPmrmAGEPra58zMaXLyWATX9mRAm6IjFmYHGUNAd25JsmKjUHvjgUiI
 viXPz7Wg/OPCNrukKifurjyz913UP/iVe3RzlrQOXnIGlSYLC/SNEqZ
X-Developer-Key: i=kelvin.zhang@amlogic.com; a=ed25519;
 pk=pgnle7HTNvnNTcOoGejvtTC7BJT30HUNXfMHRRXSylI=
X-Endpoint-Received: by B4 Relay for kelvin.zhang@amlogic.com/20240329 with
 auth_id=148
X-Original-From: Kelvin Zhang <kelvin.zhang@amlogic.com>
Reply-To: kelvin.zhang@amlogic.com

From: Kelvin Zhang <kelvin.zhang@amlogic.com>

Document amlogic,c3-pwm compatible, which falls back to the meson-s4-pwm
group.

Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
---
 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index 1d71d4f8f328..356371164acd 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -44,6 +44,10 @@ properties:
               - amlogic,meson-axg-pwm-v2
               - amlogic,meson-g12-pwm-v2
           - const: amlogic,meson8-pwm-v2
+      - items:
+          - enum:
+              - amlogic,c3-pwm
+          - const: amlogic,meson-s4-pwm
 
   reg:
     maxItems: 1

-- 
2.37.1



