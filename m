Return-Path: <linux-pwm+bounces-7410-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDF6BC5B74
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 17:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 610A14FA98A
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641542F99B8;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+EQhm0A"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB192F60CD;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937627; cv=none; b=Mpbb/lnMRzjVCCqpbeNCTZPP8h9Qvwcwc6Z+l7G+4EnnesTV+NQ0I1UfCj5MZROqZuHDUOXw5e57qtppgOrMQXjx3VkScMGuA+thlfCQDZ0bIeCHmfJp7jUWLxa0Ds058+XZ4j+Y56ZGsP5MOvNrM20Yz/jMYe2RJx6bBRsWnbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937627; c=relaxed/simple;
	bh=0QoJfs5Lnsn37/3jlLVesWt2hxzQ4YQtbTuTSaAx8fY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ip/hjPjFVbEoCewMQcERXJeo+TirWLNjGs9ug0au2WbkXS0T/J00hnLI0ORcWUwhbHshPbnH2pUXhJuvZgagxEaNs9gz1VMxdoQJQWE8XFoNjq8kgzrXLqHkE8HKChIxRqjf6IJ27TbjNKfytvxo3lkRmIPXCCg2ykX/J/wRa64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+EQhm0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C03B4C4CEF4;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759937626;
	bh=0QoJfs5Lnsn37/3jlLVesWt2hxzQ4YQtbTuTSaAx8fY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=O+EQhm0A0Ri+ue2/EqWlbCrpQyjuPyYaaULu8Ogrr1kNCkkO4JLk5BFP2Dy7rz5sw
	 TSds5D0EH/1ezfE8Nh6H0cNVt5aoZ7U6/GFSdkceQM1k8VuAq7mRzs9EfwJilT9J0S
	 CSPS3vZKNysuboHElljxV71tz/iigz6SlWPByUbmHepbGT8eGJWUXRkL6F5ShDonB8
	 G2aCDM+rJcu1lq9T3U8awsTHcdsyZAcFiiu5zlQsL9qreHSLQ9Fnfsq2Uluuscu4Du
	 0ciub+IRIMZiwDv9+tNL9Scys7UefN13OnCdELVA3KzdsB3wBN36VhySxzmhaqkE/Q
	 nUVx4P+u/V6cA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B175ACCA470;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 08 Oct 2025 19:32:55 +0400
Subject: [PATCH v17 3/9] dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible
 for ipq5018
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-ipq-pwm-v17-3-9bd43edfc7f7@outlook.com>
References: <20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com>
In-Reply-To: <20251008-ipq-pwm-v17-0-9bd43edfc7f7@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759937623; l=1074;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=pFg/KpdU/D7prJHeba07a6q8ARK/xYrCZn9mJ+brTMI=;
 b=B9UjCLsvwGsiCRbH1bk3dRtzIfw6NogaWyqQb6a4MQMJOvq2c+pOM9dt5lblx8UOHQ+wZ7BMg
 ERmUKqUonifDEZ+t+VnwmN/UYuFMuGDUOugxYEs1irLC09wzff/yqXO
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

The IPQ5018 SoC contains a PWM block which is exactly the same as the
one found in IPQ6018. So let's add a compatible for IPQ5018 and use
IPQ6018 as the fallback.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
index 1172f0b53fadc140482f9384a36020260df372b7..acbdd952fcca53368e3b594544df8d3dae8a06b3 100644
--- a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
@@ -11,7 +11,12 @@ maintainers:
 
 properties:
   compatible:
-    const: qcom,ipq6018-pwm
+    oneOf:
+      - items:
+          - enum:
+              - qcom,ipq5018-pwm
+          - const: qcom,ipq6018-pwm
+      - const: qcom,ipq6018-pwm
 
   reg:
     maxItems: 1

-- 
2.51.0



