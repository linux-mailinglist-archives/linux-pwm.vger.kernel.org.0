Return-Path: <linux-pwm+bounces-3610-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5F099B045
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 04:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CEFCB21F8A
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 02:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BE654FAD;
	Sat, 12 Oct 2024 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PgYD/w/z"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF87B481B3;
	Sat, 12 Oct 2024 02:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728701780; cv=none; b=Ky2DpGfMAYY/HMliICJitSm5sSMSTs0WV4IXJDubdm41KmisJrY9L6yH/NHaeLDAdAcwpbXdG4EpNqdG7NubcJSUJ2qW20Ffy/eLiBTFm7aepGln5eqGzfk10XQbnj128iK44vOG5YcFmNMpyNPhQMiBcBpBIoInn7rGVxzK5bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728701780; c=relaxed/simple;
	bh=Abbcc8k9DiGUoOkzHxsND0zcdoWgeR778AZ6YENQdio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XgSPFNpkojHFni7PZvr9+VdoPSHEJbptNpNCLHGfdL2AOfwAYdeP4KyCUXEOQJnoUrM0jkgnOE7wwHT2F2GONPEFx68EhWdgmabr3Ii0MFolVdxrT0TTGJ9lrl1/Jze0GxtlGc1/Xmyy8YHKI8QByKH/h41OiVMwrbVLAU/hC/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PgYD/w/z; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 90639C0000FB;
	Fri, 11 Oct 2024 19:56:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 90639C0000FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1728701770;
	bh=Abbcc8k9DiGUoOkzHxsND0zcdoWgeR778AZ6YENQdio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PgYD/w/zculjPxr1BZVdiTSOaT00rYUDn5DsbrVmXmpLGEv2vkISdhcN7De0DGEZy
	 RNcSiNT/fdNMJNEjO0uhv5d5V4idr+r68LbUKU9VC0DmQS2MzYeLc34p4dgHEpXMWw
	 j77CUvKkjz0KV8rRzBNapD1wz43WwyfRUyE1OSsQ=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id F19B718041CACA;
	Fri, 11 Oct 2024 19:56:09 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE),
	justin.chen@broadcom.com
Subject: [PATCH 1/2] dt-bindings: pwm: brcm,bcm7038: Document the 'open-drain' property
Date: Fri, 11 Oct 2024 19:56:02 -0700
Message-Id: <20241012025603.1644451-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241012025603.1644451-1-florian.fainelli@broadcom.com>
References: <20241012025603.1644451-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the 'open-drain' property that allows configuring the PWM
controller outputs in open drain versus totem pole.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
index 119de3d7f9dd..12851c43a612 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml
@@ -25,6 +25,12 @@ properties:
   clocks:
     maxItems: 1
 
+  open-drain:
+    type: boolean
+    description:
+      Configure the outputs with open-drain structure, if omitted totem pole
+      structure is used.
+
 required:
   - compatible
   - reg
-- 
2.34.1


