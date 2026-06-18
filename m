Return-Path: <linux-pwm+bounces-9317-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6A4FNTDkM2rdHgYAu9opvQ
	(envelope-from <linux-pwm+bounces-9317-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 14:27:28 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 384806A0063
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 14:27:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=axiado.com header.s=selector1 header.b=ldP5JAip;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9317-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9317-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C6263046D79
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2026 12:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDAC63F4DC3;
	Thu, 18 Jun 2026 12:27:13 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020108.outbound.protection.outlook.com [52.101.61.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F443F4854;
	Thu, 18 Jun 2026 12:27:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781785633; cv=fail; b=NxQZDIIcMjc//8xyKtSDg8f2dfbWrSsjhDrjpB4ajX0vk+vSO5x0WMo7uC0kxiHtvv9wr2EzGOPm84WtFZLeLuwjX0SUzS2e15e3XCtrQdj8pefI4l17XAvPJmhT5is9l3knkBsRx2vD6WvixLuIjfljI48LA6TMsr5QDuTU/wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781785633; c=relaxed/simple;
	bh=87gvUjSMK5PQr2yt6Z7luNLbGcs+2FueOZy/VIUrxo8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dUwHuYNyl8KS6qUGUPqvYHGrwk5ypE0lsIdQ6EfPXF0ERbugMb5OLzJHizc7ZWsZSZKsa9kt3VD0i2LNvJRCVX4aMrbmxlQ43exOZLaNXEItcJnO+2rCFUXy0NZBbuvKZZ5VCrGFcmQ2GVk9BDHWURtyonLkoVazo0woQK0tOnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=ldP5JAip; arc=fail smtp.client-ip=52.101.61.108
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5zug6Wub/bVwOMAWCTVO3vPbxFG+55n8dAenFigtdMEBGynqhcc1IAyV/GlHqQEad2pfX+fT/O5lg3cCpNUetkhcZuJ+EueHTV/ASreGXD90R3Nw+rFpgb0lvjKQk+596Sw3GRqp8m96K97bFS3xyRfCDO+OKJmYMBXAe4zCDIYduZEpr67lsBaSQ3G3btkhdFGZI0qEacQvxRNsGn2gLkn7KSQi9nuurtrfRHuPq+whHb6sLncTgpbfjaaMvaMPYnAc5xnjir/IKu2f1pl2mnRQesz09/jr4n4GJJUDzTjqyLYZnPB4PqzvS6jCiyKxECPWJRM1Ib+hxQ1KlRIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0VAwwvYAplGfv2GepazNPNWcmyy3t/KoG94CgWOdWc=;
 b=m2dogJ9pFhqdSmyJrl3PHi8cgw9inh/iC3ORXymK1Z8w8Vf2+y8y8rXaiZ5ZOnuzpuox4zdCFObnn9n/XhwBbp9FtY0j/Nso8PyNSLd/H5HBq3gdDOiVUHRLdlR+706u6XKpCqW2ZqzIktfnuB7OPgWIMvsKsRE+Dsm8bxcjTnO00yK/FnSLs9yNHwP09FPVDIcWF+rDN7i5SE2kkPkKtIqnyirzDeRLKy962ILejAkXcr7+Zn9xQ5CcSkk2NA5lSsjg7IwzvipMMZ/jl59pzLOfDgMt3yDXoZKezu3dkEc8M24ao444G2BUAMip3rEEJ1UgCl7d1K9TlMT/DAdYQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=axiado.com smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0VAwwvYAplGfv2GepazNPNWcmyy3t/KoG94CgWOdWc=;
 b=ldP5JAipsxwK9vgRvW3PiJceV///BwI31vdttwRsSEZ7vP0ZCadHqsGa5BiJOOILpcBdmgYsGXFIpdcvtMB5z/nYZLuxuYTNi0Ge/40p7Sptgf09rBMvCimE4Nd/XkC0HuLa0OTdRBScTocUigcOj/jZbDngoBYvnhl/oi/QVdO0VLKMQRu+WRZ/zkUgDpisUovRIslrEtP8pOEA+opYGdM4cWX27BHzcnGLEdmAw3S/GO5DEOkzq73sthP5tj/sWlIXTt+Wj60czgUH4ZFzU6ior/rWLXjj4Rx7bAPe/qzzGOWNVo03l4d4nDeYtGivtgfuVH6W1Mr0Z8uZNDvsDA==
Received: from BN9PR03CA0414.namprd03.prod.outlook.com (2603:10b6:408:111::29)
 by BY3PR18MB4564.namprd18.prod.outlook.com (2603:10b6:a03:3b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 12:27:06 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::a5) by BN9PR03CA0414.outlook.office365.com
 (2603:10b6:408:111::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Thu,
 18 Jun 2026 12:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Thu, 18 Jun 2026 12:27:05 +0000
Received: from axz-uw1-build-vm02.corp.axiado.com (unknown [10.14.1.22])
	by smtp.corp.axiado.com (Postfix) with ESMTP id 16FB04186B58;
	Thu, 18 Jun 2026 05:24:25 -0700 (PDT)
From: Petar Stepanovic <pstepanovic@axiado.com>
Subject: [PATCH 0/2] pwm: add Axiado AX3000 PWM support
Date: Thu, 18 Jun 2026 05:26:55 -0700
Message-Id: <20260618-axiado-ax3000-pwm-v1-0-c9797a909414@axiado.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA/kM2oC/x2MywqAIBAAfyX2nLCWPX8lOohutYdSFCoQ/z3pN
 MxhJkGkwBRhrhIEujmyu4rIugJz6GsnwbY4NNj02MlR6Je1dQUtIgr/nMLYwbSqH9W0SSidD7T
 x+z+XNecPGxoaKmMAAAA=
X-Change-ID: 20260518-axiado-ax3000-pwm-cd7c346849f1
To: Akhila Kavi <akavi@axiado.com>, 
 Prasad Bolisetty <pbolisetty@axiado.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Petar Stepanovic <pstepanovic@axiado.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781785625; l=1645;
 i=pstepanovic@axiado.com; s=20250916; h=from:subject:message-id;
 bh=87gvUjSMK5PQr2yt6Z7luNLbGcs+2FueOZy/VIUrxo8=;
 b=zI5BnmTeoEXCSPO94viVFgIirch9LW185TDZKTRpEM2u1z2aO4fLXEPPAxBNuq5rprjoaLkXR
 4ZCFy+cGDduBPBBz5t7nONPxjNJlOglH9tGQsLSN2C79ruTTy9ZCb/d
X-Developer-Key: i=pstepanovic@axiado.com; a=ed25519;
 pk=70f1UJOGT9U11ZK6o+ENXtv0I5wBE3e+Y9YWODzRsdI=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|BY3PR18MB4564:EE_
X-MS-Office365-Filtering-Correlation-Id: 203d0a1d-b776-4e19-dd9e-08decd34e8ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|13003099007|18002099003|56012099006|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info:
	B1Vv68HBeuXlKN4gQhAyGsoTVzGPh6utOYx8tk27IPrEnr59MMjSOwmH4llIHdaoX7ZbDlussFFqK2eafeRlaxzaorCfRWxKqEma1KZVWXPro0+m5uzkQFdINJrz0HN2BkAuLADSmCs/GqajwFdmpwLpHfNYuW1OgeKxyK0hZHvQPOucElB+8/lTcoHBuJMDzPxZ5nS7G4U2SWbt++gXeflSOtMkudCCXawikexzufGnnqATjbRSW/wWT5jtXV9KL6AQBOMGwB3WGc5aujxQf8y0CFCgxf7fWLSI9aGPGVFVX4v4XXAO8vyKRfBibhr0hEfb0GfzsgenhOD0aViPuvQcPEmTZ2IUZ8dKS9xp4EJ2i/rZBMBnOy3kQaoZ5/1LoIxt3XK5kM6/JEdJd+8P3CvWtrOKvtaEtng/iywsDjdahse+H9K6kr5h+AlHOopvpu9zuvjSRkbtOu2zR3h0CPjTaiZBzIWdLwFHMEDDgBpbUBe+Q5LntxdVmg6KlX8D8r9qAEKccoI5JD8Yo04JOAg5Uh0Ck1vzb+gYHkQvT17lDrHgZtWb0x+f3LCbPcNrnfbvXsHWVQrjuhkYrId1+683NgHGqEEmHNsqer4tnyYMfyCFKSEdI/9DVquSl+to2AE1M4Xv2OjP8R1Fh7AZEki/fdbfRVtOEWDnjbB0VnGWVYEc611OuYWd1w4OP+kp
X-Forefront-Antispam-Report:
	CIP:64.62.143.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtp.corp.axiado.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(13003099007)(18002099003)(56012099006)(3023799007)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tiY/sfi/6gNJRgxNBXY6bT6mf1pe+pqxw3iQFoa7ELmSvVbK2p6b5Ar2Oux1K189qpS+WvF03VcKOjm2iSVa5ih5vZwC5gU+VZYSs9O5ce9X60qWhHQdS/HvgY/ChRZRyFr6cDhF3aoEtHTRpO5ZDNqhguqQfkcl0W3kMrY8cuMQC9gT8U08UMTdFF6L1X10iPpb6Zo44AH3uJcVmzBbCq828l/ERUvD75taRN89YtbTKnkR/k5YX5qERw3KcUAHns1qkXmTkzNFBljvenSGedSSySEIz9PINAzvW5Bix/4iSQAPKRdWyWuagjmXs0mzXZSf/VOPogcDX6/P5r0tHL1ntxBrGy0SGYeylF41EX2INqvAr5UQlth/eLeFGKv5pvRWxN2ma69DM0ZSvrCfjOP7jr6An6WSYSkbVWFyELbYkT7iFHFpjeGj0WaZPsLC
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 12:27:05.9298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 203d0a1d-b776-4e19-dd9e-08decd34e8ce
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[64.62.143.114];Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4564
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[axiado.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:akavi@axiado.com,m:pbolisetty@axiado.com,m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:hshah@axiado.com,m:linux-pwm@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:pstepanovic@axiado.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[axiado.com];
	FORGED_SENDER(0.00)[pstepanovic@axiado.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-9317-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,axiado.com:url,axiado.com:from_mime,axiado.com:dkim,axiado.com:email,axiado.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 384806A0063

This series adds support for the PWM controller found on Axiado
AX3000 and AX3005 SoCs.

A new driver is needed because this PWM controller is a SoC-specific
hardware block used on Axiado SoCs. It has its own register layout,
enable control, period configuration, duty-cycle configuration, and
does not match any existing upstream PWM driver.

The controller provides configurable PWM output signals. The driver
exposes the controller through the Linux PWM framework and supports
period and duty-cycle configuration.

The driver converts the requested period and duty cycle from nanoseconds
to hardware clock cycles based on the input clock rate.

The datasheet is not publicly available. Public high-level product
information is available at:

https://axiado.com/products/#AX3080

The register definitions and programming sequence used by this driver
are based on Axiado internal SoC documentation.

Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
---
Petar Stepanovic (2):
      dt-bindings: pwm: add Axiado AX3000 PWM
      pwm: add Axiado AX3000 PWM driver

 .../devicetree/bindings/pwm/axiado,ax3000-pwm.yaml |  52 ++++++
 MAINTAINERS                                        |   9 +
 drivers/pwm/Kconfig                                |  11 ++
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-axiado.c                           | 193 +++++++++++++++++++++
 5 files changed, 266 insertions(+)
---
base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
change-id: 20260518-axiado-ax3000-pwm-cd7c346849f1

Best regards,
-- 
Petar Stepanovic <pstepanovic@axiado.com>


