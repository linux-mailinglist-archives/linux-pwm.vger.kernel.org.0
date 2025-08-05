Return-Path: <linux-pwm+bounces-6957-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B6AB1B132
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Aug 2025 11:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C993189FA3F
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Aug 2025 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5072749D1;
	Tue,  5 Aug 2025 09:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="RbYJUtyf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575427056B;
	Tue,  5 Aug 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754386432; cv=fail; b=eGphNxo1Fi2tDh9QZ+FO1O21scSP+QAXs59x3DKtlBqqh2hVGbbt+Wl3ia/ocY0Bp2+aSOhaFXZ71t/Mx9S0EdV1I0ytwPdnoiiBL38fYGvC1KmhF5FC2cFlKhoMlnQXbr1DOe/3vtUr1FOsRKnxWGoG4+NFO0tRZqfg4ves7DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754386432; c=relaxed/simple;
	bh=p9gXHMrpQUcDG0jiTL6XI+OFSDCfIsCT06+BqUz8+Ag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=poanOBlQ+qSj5E9sdQ0IYUrc8DnTt15daxR1tOIbkwkKFicyfnZHglOqmfcZ0j8LfThUq16IvTRWzxmcLoT02j6pRTy1SxMw6maKJxpcbYCkiJ955lZaT6SXc2aY4JSCLjhn0mnKSk5fYsvcQH1N6lr0hbPYyv6BddI+E7/s1mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=RbYJUtyf; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sixmxPrwf6xEPzzSTtnvsbnT0WfwumUJJkU7JiNq3IouPpv+qpYZTVw61+IbPcITT3qDUMcbX7XXeQcCsaDLiuvKEJXUnchhYEC1TaNHNzFIgU3IlEMwqOdRuI81XflkI2Qc+OHH7i1ZcahxfnZV26osreRofHVjK65ZllKAeX93dbLW3Tr9rcE9NQik4r28u+aQzYikS3QaVNYGmGDG1/ddHPuDaptigCD4DUZxnSNJKolMKBMz2X3vMdgoIqP5WI7aB3wIZ77VyAttpn/sm10jRHoK8XMj/ZR4qZp1UW785PpyH9C0afMmGwxduXwF153QldpqAfLAnGm68++orw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESZC5HuzW3y0dHX6V2ROjo90VnZp5KQFMHICcVIIvWs=;
 b=HFq7x0FlvkthjkmMH1F/jn4p4zwKjZ5zOXRulsOqtP9W+7FqUd5CeqPLTPzVk9u6FIPA1Ctox2OQTnb8izOcEXfmQVB3TIXFZAnRZTRH6J9q4AZQIbVq7ZXuH29EXwy2L/L7cqtADrBsxlp/lVfy/+vFK8zgIVVPlFVu5fWDwfwcQNO1WTAsD20V81x+0xeFUAworhXhSzVjvgTWDjaJh4GYmJpxkpj3bonTL88BLvxS9hGrJ7m0PAZ2FGbVKFQwywFnRPX3NfgVYQVaUW9Um54jBuJPK9wdoeXbosQrtklE6oxbAlLcLxJ0wyYRj1fCqos8G6Gvt6tGTUx6liBUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESZC5HuzW3y0dHX6V2ROjo90VnZp5KQFMHICcVIIvWs=;
 b=RbYJUtyfudOqvgj1M2d4PS+mZILKHownpHsS7MAwitS4tWjmNhw5vSGwGMoIz73cNH4BG2HcEL/6zT0pGdAZU4Jf+XNuYkKXAHcG30cC34iMIPhI/ZusB1M6clbEzRoM0JfHXj6W5vZ4tV3FGtMoYJb3oePK554rqWGECQjE/Tw=
Received: from AS4PR09CA0010.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::14)
 by DB4PR02MB9647.eurprd02.prod.outlook.com (2603:10a6:10:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 09:33:47 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::a9) by AS4PR09CA0010.outlook.office365.com
 (2603:10a6:20b:5e0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.13 via Frontend Transport; Tue,
 5 Aug 2025 09:33:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Tue, 5 Aug 2025 09:33:45 +0000
Received: from pc52311-2249 (10.4.0.13) by se-mail01w.axis.com (10.20.40.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 5 Aug
 2025 11:33:36 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Neil Armstrong
	<neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, "Jerome
 Brunet" <jbrunet@baylibre.com>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
CC: <kernel@axis.com>, <linux-pwm@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] pwm: meson: Remove error print for
 devm_add_action_or_reset()
User-Agent: a.out
Date: Tue, 5 Aug 2025 11:33:36 +0200
Message-ID: <pndwm7ikt8v.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|DB4PR02MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: f170bb5a-9abd-464c-d166-08ddd4032ce0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?djxbEymfbn9/jPUfsmPsXSfGkbqYq+LJHC5pSA66/8jNoSL3s8EU6gmv4jF/?=
 =?us-ascii?Q?vLYmcnaZz7V9ofntREqlTTlgF6O3Kg3jldtDxYJ+zWurgrh7vpz0RyCLLmnt?=
 =?us-ascii?Q?TaNqG7QCOy+ReE2HhjUdpiddF7KMddkhQ2Kctseovff1UM6XQ18dkKqqKdfU?=
 =?us-ascii?Q?gnCh2jJBGKECu2Y8l8NM18V73PBfzwHBeI+uLb76BiVRaz/5veNEOObDfm9w?=
 =?us-ascii?Q?izSptRaqWa8ehuV3UF2qZKEfQ0/jpScRmFJagadFQ0qjWJDUFSNCg8Ci65Xh?=
 =?us-ascii?Q?+Sz+TV9bOqwyW3ZdiMCH/SmiefZPOTo7xyIVmQBqe59k/ArM3UE5ebAfZQub?=
 =?us-ascii?Q?zDgP3u+dYLR3YUsYX1SYVsds9ZOARyPR9ZgPdTQuNRHxA8UbCKTLIXaVEE8H?=
 =?us-ascii?Q?0lg8+gJgIKQ5wcTwS2bBj5BrJ5MqvM0tPXM8wQ+5XZfZtvmeiygn2H3/NKJL?=
 =?us-ascii?Q?HkLcs4nxDEw8TnHFsHMWmCrJYNkqHW3To9MTPm/k6I2q93T2Ard3r6OrBbch?=
 =?us-ascii?Q?Zsejv/MOUzXPPYlKYKr6BqIcLvYrxe+eK0gxHE7VAptHwzU3kiYtZmwowWR0?=
 =?us-ascii?Q?po76licq/F7H0VHn3ZB/dwyljbyOmzp8e3plPnGKa6e7QiX60bm29duGn49c?=
 =?us-ascii?Q?6yxEYkM3x514nqAjlkKPXfOEeuePTOP84MEllRQ8eED9BHMTUxXxV1DT3Sd3?=
 =?us-ascii?Q?7DwOzLaTGzH2yFMhN95K/tD1ildrueXgJAvuS9qXZkWtcdE0PTrZ6AVRy5v0?=
 =?us-ascii?Q?miB6pVxQP5eNrpgZWsOQ7TXiPasf3T8i//+HxD4wZdtFshWbTYLYdb7W24td?=
 =?us-ascii?Q?j33ZHPsr9wNJZqY4WJVA9d9tKdUCJvvF5bTwWCANNL6yKXM4c6g3Za/Xog8X?=
 =?us-ascii?Q?Zcral0XWEauQjZgYHBErCyMWo7RyhbKJccA4YSH9PA7vOCKUYt6nIEqd9ghG?=
 =?us-ascii?Q?v4eLDqUBNymQHpBZgip5zkzc7VllMpawmBDxjkyxEf40jlfAymSGBBQnVMjW?=
 =?us-ascii?Q?vW/CTeoia10OcucWezB7ioi7hT9SD/2UbQk7KwtmA2e+egaa/oMVFJQnzuUz?=
 =?us-ascii?Q?6tY6EPG8DlvKR9HbPClc3rXLMMXY/p8C/0sT/iBA8WTEQB1myEjjzWB2o4X2?=
 =?us-ascii?Q?JcIYcesZqTaWQHTKPQOs4ZK5uO+9ke1pJ0phGDbCHCWjVRaoMpe1EFB/zcEm?=
 =?us-ascii?Q?erebP7jT5rPjIDy+wP5uO+VRmby9gkr99aH10a/dm0rNTeZMXpdf/X8QuD2i?=
 =?us-ascii?Q?u+WEhQpDarsvZlIlewtbPF0+Oy9Ds1rS6xhEPeYivZQyteKaOLmQxGb7s+fS?=
 =?us-ascii?Q?XT/mDEXp4fvZQHn1I1S9idnqpyj3+XZ2USi4X2c8txZVZ8CuPW9IJnxvnctv?=
 =?us-ascii?Q?7/c/vqXMUeqYgFVT8v1HpgNK1z+lXEDIDBEU1Frsen4bUzH+nt6Z8RKdJ7Ac?=
 =?us-ascii?Q?wPiSnh7/1FDuIiZJakMKtqD36f56fsg6g4J9agOgbI8mZ/VysJipuGF5Wp5D?=
 =?us-ascii?Q?5P1LSWKKvxjtCbow7Y+ejBs3LkcOfMV88WGv?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 09:33:45.8967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f170bb5a-9abd-464c-d166-08ddd4032ce0
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB9647

When `devm_add_action_or_reset()` fails, it is due to a failed memory
allocation and will thus return `-ENOMEM`. `dev_err_probe()` doesn't do
anything when error is `-ENOMEM`. Therefore, remove the useless call to
`dev_err_probe()` when `devm_add_action_or_reset()` fails, and just
return the value instead.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
Changes in v2:

* Split the patch to one seperate patch for each sub-system.

Link to v1: https://lore.kernel.org/all/pnd7c0s6ji2.fsf@axis.com/

 drivers/pwm/pwm-meson.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 8c6bf3d49753..e90d37d4f956 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -520,8 +520,7 @@ static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
 		ret = devm_add_action_or_reset(dev, meson_pwm_s4_put_clk,
 					       meson->channels[i].clk);
 		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to add clk_put action\n");
+			return ret;
 	}
 
 	return 0;

base-commit: 260f6f4fda93c8485c8037865c941b42b9cba5d2
-- 
2.39.5


