Return-Path: <linux-pwm+bounces-7960-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BACBBD3C364
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 10:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2FC8A384760
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jan 2026 09:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7CF36826A;
	Tue, 20 Jan 2026 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h8X6jjz7"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF302E8B75;
	Tue, 20 Jan 2026 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768900774; cv=fail; b=j5cZSPDWcMpfvZ0PWDeRzGHt2wT/OeZZTN/na1G4iM8GU9pMaBrECrLxxcf/cgISabogEtGnLA9FkPVHRmuQO0Gb+an6n1FuDSsj6PTGLn+46lGnEbd4X3oM/VEsENdvQ8mBd2PbavnvK+cmCPL84aOjGooJq1Up3HabV3QUBxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768900774; c=relaxed/simple;
	bh=rtIz+scGm2+7ZInu0TgVVra03OWjNrkjgNS8dXeUaAM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vxrytx1ACKHhcjLZKTn+x7Bt2NyfzCVYMsUsebYrzahrD3HJ3CGmkO+U1J3Qcxnx8s4heqUYRgHy7mXzGfEqJwiQD+sxWupYvko+VmZu2KDG48fvDASv7jdBlRcER3+68GM9XZTj/5xQQSdQot/ApYslCVTSPul/BfpIGWBjiYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=h8X6jjz7; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCp0IDn776PBPJQdIKdDaypGJ6cojaBZ7xl9n4moZkSwbiTWO+ctes/CArvCD46AmJGPkfqvlJ9Kh1ULF5FTBKMstEmhnTZn4yMBzHfQ4phGVpKPRxYmqrAvBhnl5kRair3SgyiLlUqbH712iVOhNmxQEqms9EjVU4/HjDpRZET7I4euL9Ta2piqvSlz67lq0QcWZlRSkCx0mfUpLAaX0QzXaRP0BMKNlYayOnebNwtYF2GvzH2QXO464SWKpItykxoOhASDTml/SPnESX+zAag0L8lAPEPjkCEMaO/984pY/lKgWywtr5gCiIq4hF5Sz2e45LsoMJsY8f+I2YKPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIzI2kmCokb1VUsBVELehucSkHCFHvLxqvRfhrX2z+o=;
 b=Q5QqHXfqzMStq1/nSS0khxwzbThOR3ZI45LRtnd47/Xz3r3Rlvso+fCJt7RyknaW19qUZ1/IbXcKyxXl2RgrlUfnxwwTYhA6SV9hv9ijRVNPPNb51lR6yfitgRgCPHhmuCzX/yfOFq9noyHTQb8BLhzG3OqQcmrh7nIs0tT7BloH2OERhPWK4IKMUdE0RBBIWLhd5UVJAic1iYTFGxUZRehKJqFjLTUBfnbbpOi3qBmudcX2gEVtU6a4FONojlFk0uhiMOx3FISTXceJJ8CFKrkuAnXwxzUzoj3XVTjjHXM4ZC5FW7f57Acr2DxVO1N7O2RkpbLor/zMXsOvsMd0jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIzI2kmCokb1VUsBVELehucSkHCFHvLxqvRfhrX2z+o=;
 b=h8X6jjz734Kme9YZXw4bbd3qud2U+nOSmt55LGR7hXIquEvmYs2xQIL4B4r1zFNES8qjQJua3A81+snFt2tqxHQtvgmZ40wtM2rZ/+Hj+WwPubIilHhRZmTl1+mNxBV/Nhve05BTODTNmaPhYDc4lVCyWidQmPVIwFvyRJIGnVw=
Received: from CH0PR04CA0108.namprd04.prod.outlook.com (2603:10b6:610:75::23)
 by IA1PR10MB7360.namprd10.prod.outlook.com (2603:10b6:208:3d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 09:19:29 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::81) by CH0PR04CA0108.outlook.office365.com
 (2603:10b6:610:75::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.10 via Frontend Transport; Tue,
 20 Jan 2026 09:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 09:19:27 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 03:19:27 -0600
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 20 Jan
 2026 03:19:27 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 20 Jan 2026 03:19:27 -0600
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60K9JObl828571;
	Tue, 20 Jan 2026 03:19:25 -0600
From: Gokul Praveen <g-praveen@ti.com>
To: <j-keerthy@ti.com>, <ukleinek@kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <g-praveen@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v3] pwm: tiehrpwm: Enable EHRPWM controller before setting configuration
Date: Tue, 20 Jan 2026 14:49:22 +0530
Message-ID: <20260120091922.71947-1-g-praveen@ti.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|IA1PR10MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e32470e-f12f-4b46-2c7d-08de580502f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cXOY8xe0rHQNb6cBhFZz3oUZLgmyRDqVq0uzvZ8R9VoO0zC1P5oeBUlyTiaQ?=
 =?us-ascii?Q?pOtez36i9+fdW/0pjLauUopMjfDAm0WwQoCJdgpfVR5bGyVDIyaUmJY9IM4H?=
 =?us-ascii?Q?nL7dUBANLjKpIVNBQT2OCLfjIYS+83HgMCVwpIwbmHKjVCU4GhYSBQwiwtsz?=
 =?us-ascii?Q?bJirj+fCg1txJlsj/XW/CgHpZbJse7o9b5hnhtW/aW2VnCamI/ARk0gdfd8Q?=
 =?us-ascii?Q?IRlshYw/F7b0jq6Q0nmztoTN2/l6edP6W6clsd6oyZ5EG28v8l69NEIsualD?=
 =?us-ascii?Q?kCs/NEanYT6KFmVeGSiLJxJ5GnWorQC83shlKyafKari0Dc4PzOA+E7BwHXT?=
 =?us-ascii?Q?wDXW/X6eV8XYO1JZJkrYsJYVh8a5fE2GLO1w4H3T9qpITyVOnG6zv/x8om37?=
 =?us-ascii?Q?LSTc77yNo0PXu5/MxfrGliDtMdWoEwcU3wWwU5Sns9Go9ZYs/FxxeXTe2bZE?=
 =?us-ascii?Q?hHriaxoNR+w6pQL1CEFBvVfrWHRdDAcm1V15mb3AFcUpjfRW4Qr+iUxz8UnB?=
 =?us-ascii?Q?qWlEr/6kbsyvwNUAAsDmurNjyqsxCwspLN220uOdtpcp7236Gjvi2GQNGfHC?=
 =?us-ascii?Q?sZLXT9m8fcSBrynpwPH6j/CMDzqykdTa+w7pW9UbRJFncLqLCTgzye1wTiui?=
 =?us-ascii?Q?uXApajBzz75OYc9fPWeHHUTkEVnGOYERmIkgsbMENxLhoFRZLk5P8lfOTQTO?=
 =?us-ascii?Q?cqXteEpqwbgTYUlGrRQkLMS5ulftC2B0lkNtiDHNGZtOpS+lVmd9e+ER0gNU?=
 =?us-ascii?Q?hag8suvyrEkwXj7eaT026wur6CI6tgOVPYC/1YcYJOcPhEN2VTCo6Ky8Na6J?=
 =?us-ascii?Q?Thxu+fWLAAHjFFtX2JpdDRmL1+/mS09+LOOuhvdt1Cnu+wxSMqNpPeFDBBw0?=
 =?us-ascii?Q?4PNnzqj8XlrHPjGFRfTGqMommlnR/eh7d7osaqJS/Rpvt0GueAu7rrdIa+yd?=
 =?us-ascii?Q?NhL+FoSCSdSFrq9UrcqRbdmRWcsdxDxCJHe5p6XkC5mGq84JqQ8mf4UwIjUY?=
 =?us-ascii?Q?pkKb+S1RtHboHcw/kCzvJVNiCjehzGlgQnocapLf66q519V8L3GJwT/nhyNP?=
 =?us-ascii?Q?ZrQXXTQ2DJTrvv8p52KDiKTGOzwo4v9A8GIqa94oz2J7ciUha2aWxV5IQch8?=
 =?us-ascii?Q?hdaMPbtSTVKL+Ijfe0gy3UQS/BvTqCCx/+PnAEUeX8C2aHlfUdfSjWGWiKAv?=
 =?us-ascii?Q?0Y/VvIe1A2SiVdvmGRJTqaM+mtFdg7e3jdD5NLlQRCgqKZfrdBdMja9UtiXz?=
 =?us-ascii?Q?wkHldvUYRYtpzfAPJDXgWyUVwu/1+od63AlpYO/uxKZMxoEP0BjWKW5vRCvH?=
 =?us-ascii?Q?gj80HdklqZa8N8kqjbKqIYxVl9X3F8+0/DAOhluBO+DvOUHiAaXZdaekrnPV?=
 =?us-ascii?Q?HfxI7USlnhh/l3AWPQ/l+iL657ag+FjWbLA+AGz+o0EOowhLOO/Z09tnOdH2?=
 =?us-ascii?Q?Io5OXJQvqsLAkcWb1H6GJUdBmK36HGF5460lFx8prQSDeUni/SZq/4RE9mOB?=
 =?us-ascii?Q?LFUHjKxzCW+51EZdwLJauG2Z4LsNotTimDZtDdFC5rd80wsUdYYksEnMXp+A?=
 =?us-ascii?Q?HeNB4BF+3LRDSCB/pZl0WfuGiKpZ1UNH71vqGS4BVobAFlDT9LlMAC8euIVj?=
 =?us-ascii?Q?JMz68KCYf2yds9hr3ysuTpy7ENfd2RM7De4YKSBsFuYFdc/PWKG3VdyjDz/P?=
 =?us-ascii?Q?/Dr77g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 09:19:27.9629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e32470e-f12f-4b46-2c7d-08de580502f1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7360

The period and duty cycle configurations does not get reflected
after setting them using sysfs nodes. This is because at the
end of ehrpwm_pwm_config function, the put_sync function is
called which resets the hardware.

Fix it by preventing the pwm controller from going into
low-power mode.

Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement .apply() callback")
Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
v3 <==> v2
==========
* Simplified the logic by adding guard function for runtime power 
  management.

v2 <==> v1
==========
* Removed space between Fixes and Signed-off tag

 drivers/pwm/pwm-tiehrpwm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 7a86cb090f76..2533c95b0ba9 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -237,8 +237,6 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (period_cycles < 1)
 		period_cycles = 1;
 
-	pm_runtime_get_sync(pwmchip_parent(chip));
-
 	/* Update clock prescaler values */
 	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
 
@@ -290,8 +288,6 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!(duty_cycles > period_cycles))
 		ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
 
-	pm_runtime_put_sync(pwmchip_parent(chip));
-
 	return 0;
 }
 
@@ -378,6 +374,8 @@ static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int err;
 	bool enabled = pwm->state.enabled;
 
+	guard(pm_runtime_active)(pwmchip_parent(chip));
+
 	if (state->polarity != pwm->state.polarity) {
 		if (enabled) {
 			ehrpwm_pwm_disable(chip, pwm);
-- 
2.34.1


