Return-Path: <linux-pwm+bounces-7861-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12848CFC1F7
	for <lists+linux-pwm@lfdr.de>; Wed, 07 Jan 2026 06:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 671033011F94
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jan 2026 05:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ED519E992;
	Wed,  7 Jan 2026 05:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D9ztgYmS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012071.outbound.protection.outlook.com [52.101.53.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF1E78F59;
	Wed,  7 Jan 2026 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767765234; cv=fail; b=s8dFhRzxRyGZCIQdEdG6CSc7x2Au0lLfhE/6esFo+VvXNRbDnqtQQTL45fYG13IBrudLOAMyvo3cQd/NAilvSVTYk2iKo3dKldWLRm+R3QKy/fr/kyVfJNjL00ehrC/DR5026TNE6O3PO8dir0LAAWsJDQhcb4rU6YcZvkYMGfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767765234; c=relaxed/simple;
	bh=fMSNo0HR3wYShRcxevKbw9UBhIPaZZWj2TBGdgLWf/w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gCuUiDcvxK4qQEKmZszbk6ODNi0yHs0EFhkuva4dvvESeszI/2O2LycBpTVIdtZeX94yP3gS+qAWfaefabJJ+LdvTedXoHFo4HF2JSefwWrFGw9X5sTbvhmFpmmCexxY3XLIFsSKJeS9J80E+lVzVycEjoEpCPImxvYYqI+4Lq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=D9ztgYmS; arc=fail smtp.client-ip=52.101.53.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iI8IjCsdKX5CJkK59H6arTDNylAlvnoQT+o675aCMpZB8oApcy/LGtbzau5i3IMyW1KkY9IkWabvMmLusT3yklTBCooNj2OP684jlssyMpVEwQMNOfPxHDHTIs1WzPySPRtDnnhgoyZOEyS5WUruepCrgI8zBt4dX3zODls3YKpAYVITXVGzVnKaXf5gZ3S9vWBDG49W/whMui8eLhxEzggk3Boer7LbFa6/ppuCZAqwOa8/FvkXK8LFkAaBGZIOoMuiXC37Qo9a2DlUaOdt+mzsPTh3NE+1TXD3tyUFil0PLXd3GYuxzN884QJ3XxCDYshICUtjzoBLTpF5mt7IfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h2RvGkPAJvzXtW+D7iIQzl7npI7p6kKveeYyy64wzCM=;
 b=eVoPSnuHk+xmc0DatjgeWCdvr9qyFkDp1Es6Zso+eu1R01rTsN/YrokxaSSpyXJ5CrKbV6Nvj5CK5QhARrJPUSZH29S0IelF1wkb7aXxx068UtJPIB3OFCBy01yCAEuR3JugpNlx057P9xlGaBeJGJK1A9wMZeVXi2BGYKgmGNs9vfH4jsF8AJCWiqGFmRVwxMtJmu1j/jRWYYR6m/nu9bxGiYFADodRGylRSC3e+7oM33rgDd/hwZB0cBMrSJkQK+Wsf/xbQFhGQRECftkf2p+rgQVvkmRTQoFuDWPx3e5Fc7rmk7Kx8v0scb74MJhsnjC5EG+6TA0VhXx6WbZQqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h2RvGkPAJvzXtW+D7iIQzl7npI7p6kKveeYyy64wzCM=;
 b=D9ztgYmSLVDe5Q8gbDiHPSRc9ZaIOI6pLQFrEFqs28Z9vDzmQ4rDRAiI49IFkhEuC+ESy5E42xYPPmuQACKa1RghZwXuGQOpbgBDc7CUsk6wu4HepFPPWvX7tIxW+clvOEoWr/S3EbHyfjQ3eXI6tAwM4k7BmPWMbp5aH0Ogqd4=
Received: from BLAPR03CA0160.namprd03.prod.outlook.com (2603:10b6:208:32f::25)
 by DM4PR10MB6791.namprd10.prod.outlook.com (2603:10b6:8:109::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 05:53:49 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:32f:cafe::49) by BLAPR03CA0160.outlook.office365.com
 (2603:10b6:208:32f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.2 via Frontend Transport; Wed, 7
 Jan 2026 05:53:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 05:53:49 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 23:53:44 -0600
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 6 Jan
 2026 23:53:44 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 6 Jan 2026 23:53:44 -0600
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6075rffI4096191;
	Tue, 6 Jan 2026 23:53:42 -0600
From: Gokul Praveen <g-praveen@ti.com>
To: <j-keerthy@ti.com>, <ukleinek@kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <g-praveen@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v2] pwm: tiehrpwm: Enable EHRPWM controller before setting configuration
Date: Wed, 7 Jan 2026 11:23:39 +0530
Message-ID: <20260107055339.10999-1-g-praveen@ti.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DM4PR10MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: b1299fb6-b247-4a15-64ef-08de4db12100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SZ2OpZxyyl69qbpTtT/9n+pBLn5CldjY2jQ8znRPQVPJ6xYMlWbp09M0Gz1j?=
 =?us-ascii?Q?9DHJ47OgJY5FvxfpYVGp5KORa5Spl9yBBPzMnOTac1XyVG4eatp0kktlwhnz?=
 =?us-ascii?Q?I3erX6VYPeOk/z+WpAqzOHgVk+xxTYvCqyFkZarYhXSrvZupdx0WJSq2dGkn?=
 =?us-ascii?Q?ctxz6jOI+xQSu3HiXkBYTxrVcz4dGB4ICOXomzSZVtvfQMOQwDmBxt/cyyrN?=
 =?us-ascii?Q?pRfefSpiCC55pOYeayOqSRpnVS56C9Hk+LcWhlacLRx2AQ66/0HJh4vu3ypR?=
 =?us-ascii?Q?vnc245z48JMXDH7n+zbuy/UbrSUwYuvgmk4JrpLPrN9GAO+VmD3Nc6l1gZEa?=
 =?us-ascii?Q?Hdgl45s8n/FY7OvfpPo6SbQojHMOAMSs/8Y7h6apebBY28yYlz0nxPpBoTku?=
 =?us-ascii?Q?FbkpkcESjHlwhO4KR79GRpF2l+5i2I8WqiSCQAIWyBq4OSs4MhNEc9DkFwJh?=
 =?us-ascii?Q?F9YFbGAoO/YzxEKiOdOnjygSoHQgrfnHDJTPBXfr6W0jbsDLMqtQVMimyyYT?=
 =?us-ascii?Q?ij6hDNDng5cxYGp0OOIUyuALzKcCZpV4HlebWfu5EqSFEs4C88+DbpGAMtL5?=
 =?us-ascii?Q?ldU7pkA1kT5IC2zhDm0s8f6TDQTrxXfuq9V7ff9aN5WX5b66LfiwWI5x7rm/?=
 =?us-ascii?Q?wcMDyj7AT2f45t7UXay6931pL2ueEc15fi8Zx74BSEfInJmqCqeyvZY8mD3W?=
 =?us-ascii?Q?Fm6lrZ8vGIaF+gia83KC+hx8no58t3Lgx095GBLb6lYyb3YcDqkCKgWZmeE+?=
 =?us-ascii?Q?xkh/pfw4klTeGu8S0hVlwlPhzfqqr/mWWxGwFssUQR0Zaik0dB2AvTZ05guZ?=
 =?us-ascii?Q?/HAf9zXiREcVV8e7lkRl44O3cGeunSp81TXjTdtZZZazLzKJ+RT/04ECF+q3?=
 =?us-ascii?Q?wvGsrd6un3gf25Zuz7ywmXHoz/9S8qusDCcjUuhZ1qbAjSDzUlXoyaQ0yMJd?=
 =?us-ascii?Q?R3/H54t6ZqAYAWEAMk1TG7D8JFBWYJZmexNm/wF/rKdhktxZ9iIWCBs/T2IS?=
 =?us-ascii?Q?Xym8P0Ovm+AxN7YpOq5P07P7bRbVqXcRVzKbpMUfUrpmejE7QRdcZgiVLo//?=
 =?us-ascii?Q?8HLQfZrmQiepbyJwXyOVFxlu27O6vqlO6VPT1qs3ubnL0PU42/t6bOMsI1BG?=
 =?us-ascii?Q?Zx+ukUYLnGKQ3mhM02J/2K1SLv4NfAxdazK4/KNBMykudqqf6eq+PZaGOcE7?=
 =?us-ascii?Q?dwzhRa6K4gmimv4wfZ6ZJx/yd6uoSIgevVgkik7Ehy9SE5NJDErxPXr0IvB9?=
 =?us-ascii?Q?SoPYDoucnS27felj4Oo4ls9a4kUA2+pIwKTl9v8M6FySBbKYCpWauXNKP6oO?=
 =?us-ascii?Q?27ncGkd5WOh/pT52rAMgZCFok5W2hAkeAhyn7Ja836tlCw9SgYzB2ta04pRc?=
 =?us-ascii?Q?1vX+E/1ayNhJVkARy1DA0aFXZd+cRn/l7AR445TKmovWrbap+yAbqAo2y0T9?=
 =?us-ascii?Q?wjlNPTXa6BSkTHUV7H66AkNcWk3Zf9U4M2lcKft7IEZDcU2Y8AWJjbSnzgYG?=
 =?us-ascii?Q?4YEPyoTuvwsNasDP2I7BnMLrU+5BBEjP/BT5TqmbzJyfR1k9fgyjRloIhEbV?=
 =?us-ascii?Q?pDTUFsBe6UhyPwLen9s=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 05:53:49.0191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1299fb6-b247-4a15-64ef-08de4db12100
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6791

The period and duty cycle configurations does not get reflected
after setting them using sysfs nodes. This is because at the
end of ehrpwm_pwm_config function, the put_sync function is
called which resets the hardware.

Fix it by preventing the pwm controller from going into
low-power mode.

Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement .apply() callback")
Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
v2 <==> v1
==========
* Removed space between Fixes and Signed-off tag

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


