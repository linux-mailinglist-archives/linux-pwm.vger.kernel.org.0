Return-Path: <linux-pwm+bounces-7413-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549F5BC5D7B
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 17:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9543B8DD5
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 15:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4B52F9D82;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gd5pC8Uq"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB922F6164;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937627; cv=none; b=NiZjF2m8aDY4j/1WoBzi4mKpYDNqLHoUUBztD1U/Ezw/Df+XZzGLWbnaKs2teuPmzK4mZd4mQcnFKkaDbDEkltKQVXifr4pIa4+ZxtobCN9LBnTAJoaj7AsQRiS+IzRX2gyCpco9+yRKTK2wWnaf3MLIywuIDcEoUnqYsHAAunc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937627; c=relaxed/simple;
	bh=cbJmJOj7a5VPuylskDlyoxqjrd9eNcb2HD/mgl51pKI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bfWYuXtdlMGYzqCpxcM5rYY8eYTlzSJ957bHRo/R0Z+2F65jzlr6YgPoYBRiupOFx7qQGr5gAkBJu6wQ7yqaOChFhjVaVgGbpD2jKvRU1J9FhT3sLyABDn2lBNDklFkYh7w6f4yVNCsQutrHJcSPd+zdGHlwNtFh0EqcB2IjaTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gd5pC8Uq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBDBBC116C6;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759937626;
	bh=cbJmJOj7a5VPuylskDlyoxqjrd9eNcb2HD/mgl51pKI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gd5pC8UqfrQCZQTnkIzsb6a1ciLUB/ViB+OSLYS4viUbIVd8z53kV0jRrzTBmW/2G
	 qU+cVjTYrQSr6ZHbFmXPbQpA3cnK7b4ui1U9LWxeOGSZrQbWYQZjqgG0ocsxKLLV8p
	 f3BtDAoubz+MKaiWxjeT5Tt0qXAU+8zLtU2AsI+IJ5vP+uCVhh9AHDokxdwHlQReZ0
	 EHc9Cg2vzxCw+qT2GsjnZskVN/mh1f+CRWObgqnYWPrwPTOvqlrV+U+izMTLpSWii7
	 83WmRfEEK2hKBtS5sQ5WamQZMA5mIBGivHlxg0W+wxnM4AVsHDFIWsv90ZkPXadsmO
	 0fEN4dKTRmapQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB0DCCD187;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 08 Oct 2025 19:32:56 +0400
Subject: [PATCH v17 4/9] dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible
 for ipq5332
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-ipq-pwm-v17-4-9bd43edfc7f7@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759937623; l=982;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=5aT5CBw2lSNROJYp7Bx6jXZM5n5xJ6CFyAT7LoR2TWw=;
 b=WGy2w6ICUgZFZ5r4cwcTsCL5VdD1zKaEYHOfsrpXLh3FeMwPTKL5VuhuLjCpLeklREn0K2B90
 pzLU6KGGePjB/LhfadkfXTr4cH02yf3QUHfk7wDyl/OuZ39pTeTFlIx
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

The IPQ5332 SoC contains a PWM block which is exactly the same as the
one found in IPQ6018. So let's add a compatible for IPQ5332 and use
IPQ6018 as the fallback.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
index acbdd952fcca53368e3b594544df8d3dae8a06b3..e00b9e01f4f89dd0d08610772c984a0e2725d154 100644
--- a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - qcom,ipq5018-pwm
+              - qcom,ipq5332-pwm
           - const: qcom,ipq6018-pwm
       - const: qcom,ipq6018-pwm
 

-- 
2.51.0



