Return-Path: <linux-pwm+bounces-7373-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B5DBB0A33
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Oct 2025 16:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9653B1944C0D
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 14:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA809303A31;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMuusYAH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78C0302175;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327463; cv=none; b=VX27Uvgrt7W7OuZpjQvrt+IgeuBq1Toavl2GTKymh3zPGRrmj6cnab2Uo7l+xRG0ReqcodKIDMVQhtycRPemb3YHegQJGFP6Eo+DinwziokL7EhSiTI9Ga681ajAjfOBNll4gLQWRB200HRuMr9ytyFTtT/WjRQzmodQnjd6ORE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327463; c=relaxed/simple;
	bh=WYgoggOlSv1+Tj61N1rXTFai3T7w6ajbAxxFTUFbrE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lIFqNmh5a6YV43+pCfRoVP8Tdt1iFHqgA9NaeeF4niFqK3fYrM+Cpflsz+g+J9ilU8k5gNkml9luacMCELd152SFctPvJFwC0Yju5rjJYsomfGRKDSz4AuYfcfFv1prrJWMIrUGoZa0NO2kk4RrDRIs3dzDQvT3eabiH6ovszoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMuusYAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EAB0C4AF12;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327463;
	bh=WYgoggOlSv1+Tj61N1rXTFai3T7w6ajbAxxFTUFbrE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rMuusYAH5Wkw8RJMA7+367vFKAr6mm5yYacp3Gjekn4l7bP0/EQvraZZ+4vVaRpPu
	 +5xfPb8ohVh3Avpbbocm+D8miOUyzYUzmDVeq9rUVuQbQEJE8cjacK0RV/3VN0zlfP
	 P/0wYOo19bn98+6SzH7qIsUBlFRxIUuCq1ic1gHQO7nACcOMHAPDoL4cwsQPIZ4LF2
	 L0v9QgnAVlPHTwlCvfQmgt9uTxREgtvgEy+a4hgyL/yPmVPRq4hGyqjwNQyMGSEw85
	 bD6g3S9N9ze1xHSObO/KQGg0yZ0ZWm+qEe79U39QIzXBQry6B4h2FZUH3IOS2rqxBe
	 LDMXgzkg2Up0g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304D4CCA472;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 01 Oct 2025 18:04:21 +0400
Subject: [PATCH v16 5/9] dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible
 for ipq9574
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-ipq-pwm-v16-5-300f237e0e68@outlook.com>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
In-Reply-To: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759327459; l=953;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=3YfcxJTNETA/GabL2m0Fbhu/ciUPosZ3L8BYDjaDExc=;
 b=yRSyQmclC8ef01qnB1fsqiaASk9xknsxKLAvZvJFodLDJbw1+ywGxqe6NbRuxd1QGwLqeAaki
 Cru/GuNHjuXDdT64OFhKonSTVOgWc87NLsqVFBnrvey4ecdpu/DOCxH
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

The IPQ9574 SoC contains a PWM block which is exactly the same as the
one found in IPQ6018. So let's add a compatible for IPQ9574 and use
IPQ6018 as the fallback.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
index e00b9e01f4f89dd0d08610772c984a0e2725d154..48dd7d1b8f511b0dd2cbebc07f33cafc3655ce50 100644
--- a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
@@ -16,6 +16,7 @@ properties:
           - enum:
               - qcom,ipq5018-pwm
               - qcom,ipq5332-pwm
+              - qcom,ipq9574-pwm
           - const: qcom,ipq6018-pwm
       - const: qcom,ipq6018-pwm
 

-- 
2.51.0



