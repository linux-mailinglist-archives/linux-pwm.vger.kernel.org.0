Return-Path: <linux-pwm+bounces-7831-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D71CE584B
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Dec 2025 23:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A72873006F6A
	for <lists+linux-pwm@lfdr.de>; Sun, 28 Dec 2025 22:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE30129A326;
	Sun, 28 Dec 2025 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="uQ0Yznem";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="uQ0Yznem"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A22299A90;
	Sun, 28 Dec 2025 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766962153; cv=none; b=cd/K0P79drRVDPTxqDgpbyXU/0twdrWBDb8rfMpdFRZA8G53Gr7zhkTNo/v71DP8kwsPC3e4zfnDob1QOGCy6DZKhliMffwCl2KzdZpT40sC9QcYd7naD5h7PoGvu/wKcwKG5KHSAPVdt+JPYYnj9QpISG6G1owPr0/WGejP0QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766962153; c=relaxed/simple;
	bh=smAi/hi3Lxzeb0o1tPh7+QbJ5fBaBN7MJgWw45NPl6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXm3gsZj8JFToWiUTMXFKvio+W2rr6Ri70rQFd8vA/RJUeQUAt3GT5f2VmBo6eIbfDXs5dG7JoU8jBEwMQbIGH27Wx5TTv8wJYNWvT5MMG8/M/kjybKfMJx0l/+PYa8bG6p0bJouBoPVhvaJVsnwf3bNh2jwP6h95T1Smvw57Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=uQ0Yznem; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=uQ0Yznem; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766962150; bh=smAi/hi3Lxzeb0o1tPh7+QbJ5fBaBN7MJgWw45NPl6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQ0Yznem70A8S1DSJUCUy14MtJ94LTVeZx4n5hjlP7zxKr+qu76q+2ZvNLmEc5+/w
	 CjY1F/CDadNchQHM57XZW8xpkFS8uEV2XrP74iAx2WEfGCRz+vSB4/DRdgRMvcwK2K
	 eAGnPtbuYeVtNpDTqmtMthg4v8GG9moHRO//d5POyNYNwUs271cBomyVNbZtUYHBNc
	 u1ELI3xhe6eGdWb6+oB2F48yLgG1KhVdkQatGuZ4YX3gT0RIf3eNPYdbyOsOEyERx7
	 7dQlLNR86+KCTrN9V73BNT4+MGmeGBQU/DOVEFEGbDpaKEQR1es2mvAhsiwZmvvJBg
	 rvaROzrCytUtA==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 4783F3DAF7E;
	Sun, 28 Dec 2025 22:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1766962150; bh=smAi/hi3Lxzeb0o1tPh7+QbJ5fBaBN7MJgWw45NPl6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQ0Yznem70A8S1DSJUCUy14MtJ94LTVeZx4n5hjlP7zxKr+qu76q+2ZvNLmEc5+/w
	 CjY1F/CDadNchQHM57XZW8xpkFS8uEV2XrP74iAx2WEfGCRz+vSB4/DRdgRMvcwK2K
	 eAGnPtbuYeVtNpDTqmtMthg4v8GG9moHRO//d5POyNYNwUs271cBomyVNbZtUYHBNc
	 u1ELI3xhe6eGdWb6+oB2F48yLgG1KhVdkQatGuZ4YX3gT0RIf3eNPYdbyOsOEyERx7
	 7dQlLNR86+KCTrN9V73BNT4+MGmeGBQU/DOVEFEGbDpaKEQR1es2mvAhsiwZmvvJBg
	 rvaROzrCytUtA==
Received: from mail.mleia.com (91-159-24-186.elisa-laajakaista.fi [91.159.24.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id A4E4B3E915B;
	Sun, 28 Dec 2025 22:49:09 +0000 (UTC)
From: Vladimir Zapolskiy <vz@mleia.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: pwm: nxp,lpc32xx-pwm: Specify clocks property as mandatory
Date: Mon, 29 Dec 2025 00:49:06 +0200
Message-ID: <20251228224907.1729627-2-vz@mleia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251228224907.1729627-1-vz@mleia.com>
References: <20251228224907.1729627-1-vz@mleia.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251228_224910_309175_4C9CB169 
X-CRM114-Status: GOOD (  10.08  )

Both described in the binding PWM controllers depend on supply clocks,
thus it's necessary to specify 'clocks' property in the correspondent
device tree nodes.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
index d8ebb0735c96..cdd83ac29caf 100644
--- a/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/nxp,lpc3220-pwm.yaml
@@ -27,6 +27,7 @@ properties:
 required:
   - compatible
   - reg
+  - clocks
   - '#pwm-cells'
 
 allOf:
@@ -36,9 +37,12 @@ unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/clock/lpc32xx-clock.h>
+
     pwm@4005c000 {
         compatible = "nxp,lpc3220-pwm";
         reg = <0x4005c000 0x4>;
+        clocks = <&clk LPC32XX_CLK_PWM1>;
         #pwm-cells = <3>;
     };
 
-- 
2.43.0


