Return-Path: <linux-pwm+bounces-7370-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1632FBB0A30
	for <lists+linux-pwm@lfdr.de>; Wed, 01 Oct 2025 16:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C381E1883D69
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Oct 2025 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1C6303A09;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtO7jG/Q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA130215F;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759327463; cv=none; b=AGgKZutMTIYthHRHUXj6WfKxV0vcIDVwNfYyrjEBv1z+1609th4XfzddxnevR9Yco47HX49aaPkDZ2/NDl1AVYCUgMysvzFlI9trE82c5ndGRjRSHR0lL6x+EnE+BQ9mZxeYK/W0Iv1XwaPgjoNXbOLZxnRvsIHVcS2hBJW0Hm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759327463; c=relaxed/simple;
	bh=0X8oUOXsIRzH2zgPd0Uh0/EmsaE80nw57dHhVkSuTnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRnHbg0NgDUPyFw5EsXYKfz4v5AoUr9XVRkQNC7bJyCjEEbMDtpd/UPEennSuhbwc6DFeiNxJT1GVDn/nLyp7lKfFzf+OaBbVGStyDPDPtsbYao0ha+XQl2nIYGiFwksPD2m8eHbe1UBtAcpEnYKHSeWFsna3rW+Eb3Suf/CILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtO7jG/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23114C116C6;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759327463;
	bh=0X8oUOXsIRzH2zgPd0Uh0/EmsaE80nw57dHhVkSuTnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PtO7jG/QXpAQbSrZXpsoxkjg3ICH+c9MQJDhY+RL+XIMR9wkwxMEHjI58z6FzTj0H
	 v+Wqbz11CbBvzIXLQXK/+tPztStzuTRTH6fl1pDCoZgkhSlU1MGk0c3RJrkQGhoWLL
	 6ZBATuaI0NLlixl7L/JSHX0AbqZ0WFYnMRc69fSVjchzQMp1gQqETU+57kWkfj0gyG
	 sp02iQsGehryWiZMO1DPcp/TdfS9qqZmXpeHNoMM3yz8wRnlLDq65dpa2RMBH8H3q6
	 HuTAm8WAgCSq74jBjuUCrvCvPF8L4SeAnkEBbORwf+AqJrEvxrBzKYsA6n/CJthwlf
	 FSOoWdQOVGjyA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F2ECCA476;
	Wed,  1 Oct 2025 14:04:23 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 01 Oct 2025 18:04:19 +0400
Subject: [PATCH v16 3/9] dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible
 for ipq5018
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-ipq-pwm-v16-3-300f237e0e68@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759327459; l=1027;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=A2Jt3NeWTdpQUpS3pQ9NsEueZ+KtHb8levqoaMhjNmE=;
 b=3L68oXSys8aKJlQ15Z266p5eTIw9pGZs79GlDUpJDiS2JOTpA+W/RtFIoTT6gxDo3nZJM/sxv
 FcgFBymqjy8CNJBuIQ2eKZOAHHYxf2jYWMN7ADL48OCGP/2YE8xTXWx
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



