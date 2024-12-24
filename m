Return-Path: <linux-pwm+bounces-4492-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B56769FBBAB
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 10:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4137A10FC
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6251B6CE3;
	Tue, 24 Dec 2024 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="cNBvizXw"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-m3289.qiye.163.com (mail-m3289.qiye.163.com [220.197.32.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089141B4F08;
	Tue, 24 Dec 2024 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735034098; cv=none; b=kq6tETUusoe25hkxm6VnipxNDaBUBcXrW3UFa2CTH4s8eN3Ng/mgyMU0WytMCF+b0JLP+zWRoephoWZqXjeIakx4gbfE97WVt94MzuszFKcgrfHqdgstz3O2QEclJVO9PWFQ4ifShkIYnrgEX3AXg1yw0WFFuez8V2u4R0CAiUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735034098; c=relaxed/simple;
	bh=hckWa6p0gk6GNcGRhA+PlXwIad0KLZaOWT8kBhYpWCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JB+644ipn4wPcU7IvgsCdHFVRNahyfuuTpUgaPtpR3CummtxVqN5ECblD9uMw2lXyqr14SVYEy2HtCINfrdLcUQWFiC8EKjlE5VF8KYIKYohhENBBRon1FGsL8uIhFd/J0RTXZE8UY0GGFg/zWZrUoAr3mZeYQdd9/iK0KKb6E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=cNBvizXw; arc=none smtp.client-ip=220.197.32.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from localhost.localdomain (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 6aad4f5e;
	Tue, 24 Dec 2024 17:49:39 +0800 (GMT+08:00)
From: Kever Yang <kever.yang@rock-chips.com>
To: heiko@sntech.de
Cc: linux-rockchip@lists.infradead.org,
	Kever Yang <kever.yang@rock-chips.com>,
	linux-pwm@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 11/17] dt-bindings: pwm: rockchip: Add rockchip,rk3562-pwm
Date: Tue, 24 Dec 2024 17:49:14 +0800
Message-Id: <20241224094920.3821861-12-kever.yang@rock-chips.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241224094920.3821861-1-kever.yang@rock-chips.com>
References: <20241224094920.3821861-1-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUJOSlYYTEweSkoeThhKSB9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEtNT0
	1VSktLVUpCWQY+
X-HM-Tid: 0a93f812742d03afkunm6aad4f5e
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRA6KBw6LTINLko*LEo2LC0P
	ShQKFD9VSlVKTEhOS0hITENLTklLVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDSkw3Bg++
DKIM-Signature:a=rsa-sha256;
	b=cNBvizXwpV1e0xw7155UyKzIz+tVZDUiMSgZtdb3yHjj2jdauY7AUm8yUDhAGDzFd2NL9w7KbZsyeXnJemM2sWNwD0bxw0rbZTXs8AgZ5f7lKOPddhFyO3tlVoOpy6g1mm+V+hgqIwMavzwUmngGp1Hw5rGhLwDKd4xstPKS0sM=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=DTvew9FRb8bcd/cfA8z7sQXsLhbV+v0u07kTJMk/M2w=;
	h=date:mime-version:subject:message-id:from;

Add rockchip,rk3562-pwm compatible string.

Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---

Changes in v2: None

 Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
index 65bfb492b3a4..e4e1976c542d 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-rockchip.yaml
@@ -30,6 +30,7 @@ properties:
           - enum:
               - rockchip,px30-pwm
               - rockchip,rk3308-pwm
+              - rockchip,rk3562-pwm
               - rockchip,rk3568-pwm
               - rockchip,rk3588-pwm
               - rockchip,rv1126-pwm
-- 
2.25.1


