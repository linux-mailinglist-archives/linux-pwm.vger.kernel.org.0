Return-Path: <linux-pwm+bounces-7855-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 681F9CF7EC4
	for <lists+linux-pwm@lfdr.de>; Tue, 06 Jan 2026 11:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FDB83075CAA
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Jan 2026 10:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A828329E60;
	Tue,  6 Jan 2026 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sCNU1msO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8C8327C00;
	Tue,  6 Jan 2026 10:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767696867; cv=fail; b=h1XqfxG2KSb4Uotn8pFuuCY6fSjEe5umK4PHJkAeh/+KDtD/gcKDKl3x1IluzUl7/2HB0Vtv/0/aQpE5XnBNYyQqOjTNLp/2+502qSee9mjDOou/uZhZi3RCR184IyuZamnpzhFFHWYIqO3HjGZSgCdUKHgDpUCgKSp6IxKF8Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767696867; c=relaxed/simple;
	bh=AVtJ/uxfZ1nVVEywEfvACTggCwAX4UYLobfP6SskeGo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L+YWsnVwnwak/92eWzOgOpKM/EaGqr1c6WdZV8t8pFsNPt41b1P6o6UXX8lhp75XW53b527CkKQHr6XGBzpHSlBMh/5ivONPrglV+wkzfS1KVxkEmnDGVYttCgKm6PrwlSjSpTqjGaGdOfFJCVAychSwf1pW3ImmB3UWwYgdsc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=sCNU1msO; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQAbhdjPYUqCw5mwv4MsnnwOSX6GOcSyCPSTwfo1HTYawDCOAF5nj4b2PfS/36FOGEXVg8CJ+aL/FdirV0rpWlKHgH8YYye8LTCqdHevz1TSGNmlqpT7YtrUd2sWANSlY8stXjDshc6lZEigHjpPCk6HVqSoJmDddZACMI5+0UjzLZIAMVeezJluXN06ZAwGvufZhzeOymc18Q/Dz02fwbxEXdkf1EPyZeL8uc7ZkU+s1oAoQAAdnAHS6BaihaB4RurgbKRWo94Rpz83q51Ka4YEPNPwS3vo7t9Qvmc0qNr0FV3JQqmGmPIa9mPc4MhiRO1FpHY/AlluP9Bm2/wdBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRHIdvJ9SFFsFS1qW30jl/OqrQmS9pZv2o9/DQ4tp2c=;
 b=devx2bbko0Lg9XakfylLPflmzMToyataPWdPmV8AI0r6WbiB+FxYBSJpiyu/1W+nc6rqZ+Gu90HZBVx0o3dVhtP+FQ0ZZ4cOWG4eh7FtInGaI4nzOcWCvr8dHXmv8+Uf1DXOvgVwbQu9hdPLUXVa3kifbUu8UZLexrnEsSLsGHEJC5vAuf8LsZHVPMRdW/zIQQ8Au5vfaQLYQJUQV8vXuqaw8txqfppbrRGh+HMT3XD6Bb8ED3QF/nI9fvWqcZEN6eMCVxN1K4NOP1+pymOfXoXFSFDbXPvwVW3aLypjArV/jUa08xLCsJ5j/7GF7xj01vLdGHt9dF4f0KT1RNfwhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRHIdvJ9SFFsFS1qW30jl/OqrQmS9pZv2o9/DQ4tp2c=;
 b=sCNU1msO4JL6RlzONpVx5GCjqxjUzEnlYSF1TGYp8W25eZ56ZGwu9y9mnqC2EFW0QzG+zrxc/f3M4tsz1QvRaCiCDbxrWHCYp+WAWUNNkuD8PaNZkooBDywuZVRHG3EyKwUcYa9Ml59mRpX4yxXZVN/PNJLd5DAFbTJGeZKG1EQ=
Received: from DM6PR08CA0060.namprd08.prod.outlook.com (2603:10b6:5:1e0::34)
 by DM6PR10MB4394.namprd10.prod.outlook.com (2603:10b6:5:221::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Tue, 6 Jan
 2026 10:54:22 +0000
Received: from DS3PEPF000099D6.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::fa) by DM6PR08CA0060.outlook.office365.com
 (2603:10b6:5:1e0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue, 6
 Jan 2026 10:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF000099D6.mail.protection.outlook.com (10.167.17.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Tue, 6 Jan 2026 10:54:21 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 04:54:17 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 04:54:17 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 6 Jan 2026 04:54:17 -0600
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 606AsEsE2896375;
	Tue, 6 Jan 2026 04:54:14 -0600
From: Gokul Praveen <g-praveen@ti.com>
To: <j-keerthy@ti.com>, <ukleinek@kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <g-praveen@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH] pwm: tiehrpwm: Enable EHRPWM controller before setting configuration
Date: Tue, 6 Jan 2026 16:24:11 +0530
Message-ID: <20260106105411.36033-1-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D6:EE_|DM6PR10MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: a65deb1e-0179-4474-220d-08de4d11f2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?by4/tp82NqhOqvrqVgUsLHxq3eQBJ8xXSnA8Y9mO4U1s9Mc5+b0NdCCNtRMg?=
 =?us-ascii?Q?t+lehX0l1dHhkiR9aUYGcxMM2IKbyiiKw6sC5NAG6fqv0duydm7KIq6NE62r?=
 =?us-ascii?Q?xIif+JEWZYNgW0ZHTK3L2QfHHdrtfRqlsK8b7/Cnrvn16knf4s8nf93JlXDR?=
 =?us-ascii?Q?r0ndRqdvEq8r8wTClPfcEJ+7HXBr/7X+atemSSVgo/9hXnmMdEVdgU1V9bAR?=
 =?us-ascii?Q?KBo1LYM35gMnQQCeSx7nNqvpEPk0fFkrwANO/D3rufmugwfIE7Sid3cgTdy7?=
 =?us-ascii?Q?RJPreTvezjjIvUrqanxO1fox/0J9eCz5ZEKDs/IstYlky1br+L51WbGIS72W?=
 =?us-ascii?Q?iTuRAMDsGa61FF4M09RhwLdr9H9m5xIr6fbSnZ8RXpA4TbsQ5X/+g4tctT2R?=
 =?us-ascii?Q?kLa4YLUTRMHIL10baSEWRmzvhDxq9CFQ4oskY+zilhzSZvL97NG08wjANgB+?=
 =?us-ascii?Q?TuLK6HMQ0XzSLwXGOTwSlTuAWstRBhdeJ0EU4zm8jOKtD2B0sPd15SsAUfiC?=
 =?us-ascii?Q?dj+8R4+cDyoAYONu0la2kbVccn//q8q2uLIYrWY5EDXp7xDSXHvPM/giqnPf?=
 =?us-ascii?Q?byDOSsromgfubilf9BcUARHTr+fDHaW72bEHxVys21IGBrtFYd9Z5Ns+92oi?=
 =?us-ascii?Q?zGC+FbykCS6Pb5JLv4HgmoF95R0pJsvbj1z2WdbBkko+TfqqqPfmG7S3H+yQ?=
 =?us-ascii?Q?Xq/5bHGhahPZ9uQKI17hfpScivJkeJO6w5NDE7Dw2JjZz3BhdSmqTfMkI+3M?=
 =?us-ascii?Q?O+7ehuRxN5neXwMavV4o34Dk6nThYib0DBJ6v/PRrr8tT0H22d9lw4uIHwmn?=
 =?us-ascii?Q?dYbVIJXHV10dEwOZ8y9gAlRQ7sWyYf9ib2KMzbItm2TD25ievojqpQUEo42n?=
 =?us-ascii?Q?Xr7yw4huzoODrgHQvkxLQEIT3BsNO/gztn5XP3LlzXyjhUuBSrJwBYRLj/mz?=
 =?us-ascii?Q?hzmo3eLBJfgsuHQ3uQsJrR37mXJ/7tgyvSmBXju4NdQADO70Z2K0AYi+vr5k?=
 =?us-ascii?Q?jlOXULUeDwdQHoWF+bNYDvSyrdM5aGKSFzqjWfcPAUYhBcT9lhQUCJcqhnId?=
 =?us-ascii?Q?0QWQDqu6EXkKTu5F2K5Y1Jeq7jh+7P0NIgoWzfRiVieRdMGGoynyBcMm6/pO?=
 =?us-ascii?Q?jLpL1Cbfbj6RCS7re3fraOoG5Ko1caUgUmKytd/cN+TXdyWtIwliy2gZC3dM?=
 =?us-ascii?Q?0Oqg7RkIQlTAJaSlIQuZVEPodWRhuTlKsyc+D4/braO2tPhoF5/7GLujg7SB?=
 =?us-ascii?Q?5dlROmVJwg0xOHOaPSeCfA4RLQw0mef3eQhdmimCL3F6uYfxrPFNHlVAuAgm?=
 =?us-ascii?Q?0VizDW2WeArpKg4zZa8bA7XifKsWZKA6NSr4futYrJp0tvQVfDiMkbnuXD9Q?=
 =?us-ascii?Q?c4qnp5R7uCTQ2qSZKsocLytVSIR7tyRCFH2sU1fsuLTF6sbEw/U9MmqlG8Fr?=
 =?us-ascii?Q?a8XfwJDYBXVqXpkHLGLOeSOg1IFhmyVPzYbJ8Ow4gvv7GKtl2mV3rXSjpb/M?=
 =?us-ascii?Q?KEyK4TKhBzvQZ5UcY3iS9ZS77pmSXqFDOlhZeugHuAKuVDYr6rqFu4kaN/zJ?=
 =?us-ascii?Q?8+wfCWrIarJ7aUE3jEU=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2026 10:54:21.6595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a65deb1e-0179-4474-220d-08de4d11f2dd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4394

The period and duty cycle configurations does not get reflected
after setting them using sysfs nodes. This is because at the
end of ehrpwm_pwm_config function, the put_sync function is
called which resets the hardware.

Fix it by preventing the pwm controller from going into
low-power mode.

'Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement
.apply() callback")'

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 7a86cb090f76..408aed70be8c 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -237,7 +237,6 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (period_cycles < 1)
 		period_cycles = 1;
 
-	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	/* Update clock prescaler values */
 	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
@@ -290,12 +289,11 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!(duty_cycles > period_cycles))
 		ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
 
-	pm_runtime_put_sync(pwmchip_parent(chip));
-
 	return 0;
 }
 
-static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
+				const struct pwm_state *state)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 	u16 aqcsfrc_val, aqcsfrc_mask;
@@ -304,6 +302,13 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	/* Leave clock enabled on enabling PWM */
 	pm_runtime_get_sync(pwmchip_parent(chip));
 
+	ret = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period, state->polarity);
+
+	if (ret) {
+		pm_runtime_put_sync(pwmchip_parent(chip));
+		return ret;
+	}
+
 	/* Disabling Action Qualifier on PWM output */
 	if (pwm->hwpwm) {
 		aqcsfrc_val = AQCSFRC_CSFB_FRCDIS;
@@ -391,12 +396,11 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period, state->polarity);
-	if (err)
-		return err;
-
 	if (!enabled)
-		err = ehrpwm_pwm_enable(chip, pwm);
+		err = ehrpwm_pwm_enable(chip, pwm, state);
+	else
+		err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle,
+					state->period, state->polarity);
 
 	return err;
 }
-- 
2.34.1


