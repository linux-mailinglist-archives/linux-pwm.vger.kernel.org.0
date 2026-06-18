Return-Path: <linux-pwm+bounces-9316-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eI4HAiLkM2rYHgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9316-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 14:27:14 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B836A0050
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 14:27:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=axiado.com header.s=selector1 header.b=knOutZi8;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9316-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9316-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 264C93004623
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 12:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B231B3F4852;
	Thu, 18 Jun 2026 12:27:11 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11022126.outbound.protection.outlook.com [52.101.48.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46583F4858;
	Thu, 18 Jun 2026 12:27:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785631; cv=fail; b=PpK2HjVIdGIGhX1zu98QrBnoyM3PBNC6vAzhW4uc1u25nJ5+0LeK5E7XYizEnE8gREmv8pNN2z37PGVmeiEvNiojOAmRVMC3epv/1C4nYYzGlVxpD8OvzyR7eq6BlnoTqP3+R2C3cjfeVDSRB6thVn9dJHH11o4CCrvYzHYhzM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785631; c=relaxed/simple;
	bh=fB6OqkwD3VuTzM7s1o2boXxQp5KSUCJ3LUcI/EFeg74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HO696v5oh9GhQMsPOOOqem1XiqCDoTBJXzFQlq0tOFKGM4Y26bEx1Qf7etjKVi0qIXUhnnRkIfvWl0vJtX1/kG0FAf3w792NP+vGCA8NVnKg3MiTdnXLeuymEIYrd04qH/HXAV2Txmj1fzv3Vfxp+0O2hiviK3S4odoO8NXxVwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=knOutZi8; arc=fail smtp.client-ip=52.101.48.126
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ahpgc3kxgRXYp6wu7XN5ylgxXX3Ei9vCQyDyqeHZAs7S/yGvOrSjutzFRTucVFtGY4VqPEGLHXJ89g5SMD/a2ecndxB57W8mQjPZ7qev+FSPRB+J1rAlNhC2AGB0BYJdfx779b93EliSwQCqzvlXSqjQ7XahkthOkZhsTmRUBWnZNquifpmzj0hc2DH8dV+ioqyuOwemma041tHHinNd6VlDNgoQFzyT09en4SArd9pm+TsvCPmfPA9AZR+5oLe1b/fwDkMi6JDHMBTorGbFvfzxV4mO3GCQBt8EEIugEgnr1xcuaa1vHt1v6IMUGNjJh2rm2ZXzax2Fkt7SvR/8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AOKPQRNVAUfvAad/R4m5lxPbYH6rpBP0u0SGGAkuRY=;
 b=x0WJ3h7kt/0eQUvhcrMNUtPDlwGpo9ejzhFRUTXWOCF/d8p7tffF5NQH1SqHb1LWD1bjHXemu+c6ANA302C574ECYzgjjLWi1BWd/LueHgJD9qnHrhd60BuOd8UfKv1VqWWgZF89afUwnXxseeXVa1ICmPjnmvtWdGyJnB0hgk209qrob74lz9KrWOQyyCJeqZIJSmwi0wDWvAF++e6nXkUAlyHfDNLVZPq345unCDOiKurnmBqhV5ybLq64iKGQaYf1uJHZY8GZsDkNUIHPwZpY53nvDIbkMvrA7as8YusBxSx/VSp+CIj+j1npT0tyW7VFZd7aG1HxWo7zLH/PqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AOKPQRNVAUfvAad/R4m5lxPbYH6rpBP0u0SGGAkuRY=;
 b=knOutZi8t8Lu1LErcLMn24peiyKXL7uYnHd5zwihHGnomPcXYIxSTl5URdm5NY9EMxwmAugduHMpEMzgD+OugihuhmHTziVVWfK1oJCnPArEoA6u5E1F8Ln9efJpPVx+LtMgRjDZ0jImiHJb030YJ7aCf5miQPT+digBTPkcVpv8XEPKutVnkzuvrctCTOWRDrlKEJFdbMgYelVjRWRl71IyPyuaHqmAI9eC9UihtWV++QO50+AAMsiya/WTBab8CVsa+HlZW04roBqzh77dpYY56tVlM4QyiJhj1RUoQINPFTV70yJ4e1LMWHoNM78kBdpNE3uwYW1E/1Xin9KLPg==
Received: from MN0P223CA0024.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::31)
 by IA3PR18MB927582.namprd18.prod.outlook.com (2603:10b6:208:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 12:27:07 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::3d) by MN0P223CA0024.outlook.office365.com
 (2603:10b6:208:52b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Thu,
 18 Jun 2026 12:27:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Thu, 18 Jun 2026 12:27:05 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 226524186B5A;
	Thu, 18 Jun 2026 05:24:25 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Date: Thu, 18 Jun 2026 05:26:56 -0700
Subject: [PATCH 1/2] dt-bindings: pwm: add Axiado AX3000 PWM
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-axiado-ax3000-pwm-v1-1-c9797a909414@axiado.com>
References: <20260618-axiado-ax3000-pwm-v1-0-c9797a909414@axiado.com>
In-Reply-To: <20260618-axiado-ax3000-pwm-v1-0-c9797a909414@axiado.com>
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781785625; l=2327;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=fB6OqkwD3VuTzM7s1o2boXxQp5KSUCJ3LUcI/EFeg74=;
 b=OBn3pYFS21aE/lgtc9seaYeW+ZWY+M1FQJZIFOMKhoULRt3iMHJ000RwCzyqRanMcTJLPBcq+
 iUcwUoCDuhaA6CxTrLiu/fL/xEmRRefCZAc917lYpJq2l8SVjyEdDwh
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|IA3PR18MB927582:EE_
X-MS-Office365-Filtering-Correlation-Id: e25dcd07-94b8-4ccb-3522-08decd34e8cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	3bMi7MkR79ynYVy+zMB2UqsNSZ+r3Hlkp7efa1Q85Jk60wtu6etfK7L9a0ijGyDRURBnY+u+5+DNzMSWWmyYgizp2SikNUuaiSNVjO0BNgqoxrXCnWQwuzrYblfYFczf8UYUaZFTBwKGgYGLcM9JszAw2aBcfH2apPMCImA+3KlZswj0x5GbgOV1NS/0lk7d+lY6Pr5vUZyMajSyoqBxAwtDtotrgLe5oLy+FFlJnLsSo5nfnNQX1DjsijByuvsQVGhXKiqj3iKETiOj7+ILHPMQuw1MQY1BFJFwrfXn8XRb4NyscPY6IHJYFgqXsY2Y94hwT+r66XBGVu7n0hAz7JYQvgRpB+26sflM3u3J2Mq1jvif+vMA+ZhmB5hh2nMn4cmtBrdzo2xs4OG4XIEOEZ4wjUgiuLpLCMF1z7XQ65I6lINLr23Nk+L8cZh8nQR94LuJQV+L0ML+1SIlyrdv5CkNKammOYQqCId+bc6KJPL25f57cPkuP2Rn2fBgaV4Xsne1+aInYuEv96OJ4jMhmdLE5PfOOeWXAL9Ez/7xPJjnPhaSP0zmju88MsbsyJzUglmS6uFQBf9B5ar5bhC0HlsdS/nM4iCaPvYUsS6j1oj+IDxntJ16wszoPhXdnjEa//Ywo/szlEgoSG8aP4c8HRHZeBYStf0ra6ro6rZFkvUjWhmpEXQKJ+8cq2KSDL47
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UuZK1THWGVFqtCUTkgu9PZe/eY+hlYc8/pB2yNDfsWzW/cB8zipJIQSTQaLYxaPGyCdXAryVTX2edSO0myW129arxupKH5BI8n5tnXzSjkjHpB0ngYUBITRsHH582py/gqVOkdkCAon66k9hBB6cqzGCyfx1VCjKlwrRX0OwIswYJo33xJNH+fMCVODsG3ONPolSSa2kySZqBRpuTDANlH6tDAENhAbo+444wlK3K6I3jV9LxViAHf/4DhFF2ccCUmsgYUrVV9g+eRllysd4VLKBE0NNbXWk8B4HIfhf3k0JQUQKBXDkhe7cfLUeCxTgVADH1mM5bRq6pU4Momu9areU9ulExjoBZHqQ9R4NoA20Xf0bt2fgg6dD2R23bJ/ivGJwXm4WBMFoby7Dizzwf66H+IdFgFoU3TuRgpyND+ouY3AiFr5ptK1+d2ox25/E
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 12:27:05.9306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e25dcd07-94b8-4ccb-3522-08decd34e8cf
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB927582
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[axiado.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[axiado.com];
	FORGED_RECIPIENTS(0.00)[m:akavi@axiado.com,m:pbolisetty@axiado.com,m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:hshah@axiado.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:pstepanovic@axiado.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pstepanovic@axiado.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-9316-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devicetree.org:url,axiado.com:dkim,axiado.com:email,axiado.com:mid,axiado.com:from_mime,axis.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pstepanovic@axiado.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[axiado.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 54B836A0050

The Axiado AX3000 and AX3005 SoCs include PWM controllers that can be
used to generate configurable PWM output signals.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
 .../devicetree/bindings/pwm/axiado,ax3000-pwm.yaml | 52 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 ++++
 2 files changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml b/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
new file mode 100644
index 000000000000..8e5fee8c499d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pwm/axiado,ax3000-pwm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Axiado AX3000 PWM controller
+
+maintainers:
+  - Petar Stepanovic <pstepanovic@axiado.com>
+  - Akhila Kavi <akavi@axiado.com>
+  - Prasad Bolisetty <pbolisetty@axiado.com>
+
+description:
+  The Axiado PWM controller found on AX3000 and AX3005 SoCs.
+
+allOf:
+  - $ref: pwm.yaml#
+
+properties:
+  compatible:
+    const: axiado,ax3000-pwm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: pwm
+
+  "#pwm-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    pwm@80801c00 {
+      compatible = "axiado,ax3000-pwm";
+      reg = <0x80801c00 0x1000>;
+      #pwm-cells = <2>;
+      clocks = <&clk>;
+      clock-names = "pwm";
+    };
+
diff --git a/MAINTAINERS b/MAINTAINERS
index b2040011a386..394c4a3527e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4312,6 +4312,14 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/sound/axentia,*
 F:	sound/soc/atmel/tse850-pcm5142.c
 
+AXIADO AX3000 PWM DRIVER
+M:	Petar Stepanovic <pstepanovic@axiado.com>
+M:	Akhila Kavi <akavi@axiado.com>
+M:	Prasad Bolisetty <pbolisetty@axiado.com>
+L:	linux-pwm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pwm/axiado,ax3000-pwm.yaml
+
 AXIS ARTPEC ARM64 SoC SUPPORT
 M:	Jesper Nilsson <jesper.nilsson@axis.com>
 M:	Lars Persson <lars.persson@axis.com>

-- 
2.34.1


