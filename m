Return-Path: <linux-pwm+bounces-7418-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC3BBC5B0E
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 17:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A43718862B1
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93982FB96C;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICZsUVwF"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548222F999A;
	Wed,  8 Oct 2025 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937627; cv=none; b=gagU65eBEZ2DRF08qklGdVi4uNBqgbAI3Am3kChilXjdal8QKWoVZPDJo7GEqpiujb+snlv5/BfTramX0vwHw0ukde28/zY1KatPLoDy2gk3DVJiKzSEw7A2VIFPE9G7UY4Hkmc7y1q1i2I9bLqtLYJqw2AMrrRWJRHOOrVfe60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937627; c=relaxed/simple;
	bh=e2ugSOI2UTAErCdXtASkJNADsZs45cfO9nbqKrgUZzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k7zD8YRPHWSp4pyWj9fiSbBX99u+HzWxsoQhDJVjKVx2k6Q5lXtf5ze2WT1Jhgz7Dxs3ooN0jjBQE7uCRbVEQoY+MiSAgmx+yH4rd+VutVpwzRjBC9N8avQ72CsHJQA5UipLlnpQRm/3uHbJuUuol5fyIWbnz0gPhjje/9OG5iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICZsUVwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4D4FC19421;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759937626;
	bh=e2ugSOI2UTAErCdXtASkJNADsZs45cfO9nbqKrgUZzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ICZsUVwF0BwJMxJQpmWW5OqNoOYUeDZdjmM8CeQEQ4YsDjrWbtH3mLXF64+DnMkqd
	 ZaUXwdUsYZnpT1cOWrYhC02Q3P3GiNYJ4Gd9dr+vOBsyDqvgMKl9R8qK4Pln125uMK
	 3JqAMblVmocsdYG4oyvrK0f9tKo4QT6t7v0sEw9odKF8gC/kApHVS3hpH7CXDHMwXQ
	 aYh+ms22sqdGUq0aNT657qQa8FwrIVgvHtMrSFLudjIgoKfQ77xbT4pO0MTMdEkfCc
	 4VHJfSn6+uRNzznJgmBhamxqLpUSAKMcy0QOHkhi3ZfuP2H1UxQrc5tv/zBJ2tNPtP
	 9cCCa9ihkNJqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE57CCD188;
	Wed,  8 Oct 2025 15:33:46 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 08 Oct 2025 19:32:57 +0400
Subject: [PATCH v17 5/9] dt-bindings: pwm: qcom,ipq6018-pwm: Add compatible
 for ipq9574
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-ipq-pwm-v17-5-9bd43edfc7f7@outlook.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759937623; l=1000;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=hrkECPGJIlhb4smP284sXv3tC5v7hT/ab5fvLg2W1dU=;
 b=36g7JgZ2r2cBC71ovyzzWLy1PdMUxHvB9NOgJRIBxR3UjaNYQ9HfsrwJY8Xl67WlSXM6Hdyaj
 XKuQmkVmiORAh27hDo0ap1Y92DwqWyHvgWauVndQzX69gFRSuP45uiT
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

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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



