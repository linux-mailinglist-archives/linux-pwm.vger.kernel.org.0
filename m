Return-Path: <linux-pwm+bounces-7981-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEeVBDNucGkVXwAAu9opvQ
	(envelope-from <linux-pwm+bounces-7981-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 07:12:03 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8113451EA6
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 07:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2FF3384BB7
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 06:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510A543CEEE;
	Wed, 21 Jan 2026 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fkauc25h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013046.outbound.protection.outlook.com [40.93.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181133C1986;
	Wed, 21 Jan 2026 06:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768975917; cv=fail; b=XBLqY9dQkMpKEtvbBkAlggRe08EZ2zzcUExuA88aZAnO6d6IA+7q6unYZlDgBsohzElCQICM8FmArM5EW57RIZ3/RrSc8M53/b5cFMVsOWLwoRKM3XpoTdZym/wLXKYKxUITtBAbFwchGtgUoo0ahmQkjgt2MC2nhwwxaTvjJ18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768975917; c=relaxed/simple;
	bh=ch6peQ9rCavGmEYV0+lJZTmNNG2qOWHMkHndHTawXJY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jN9AIw+bwQIQjZsXe+BYpq3Pvu6PhMmJEVNc0cIIy0Wu3R0E4lq1XrIaGRhErO/1cD3rb7qUlczQTQ6oB6NGie9Au1Oq8O6G2i6xFPBzhHFE1Hv3JFEzMUxCblFECPejQE32up2AJEfoFKOrPmoOCn90ty3P8eF6lAjdI+BL0jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fkauc25h; arc=fail smtp.client-ip=40.93.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLQdKYyIXLYsf4gGpgQ5tMGCOfX+wvkX0H5NpjzC7AvXkfabywKIvbq0u+Ew6+dTPWBHRZGlLgIm6ppMHPA3TrbtVm9qIDs3ClwkVvMFsk8V37uv1na3ZH98T9pRkUgR6WVf5kdiAfNJEdgPCsdRI3cuZSbQOnmRp7OVQjJsYi+1Il6vESkOJcxIlc17sTfyumtWOEbOGOGdCVDti0qi1Ss5pbPdL7S7W21aiHGNUyaWbJ6/1CyT95nH2rmtNMPIzYEcc3dGJH20vLiYXm9S1Z6Ra0XDspMfmbreCGxTA838hAuTSodouckh6L94aJHRfkYwf1+kRya+QiBB+O9azQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiLHzwqyJyP/wMxbIQawJq1LKdjZGxKJEvS1UsSULhM=;
 b=RjAEQfp7tmYf532fA35oAN0X6SDHWP3aQI0Rx3wAW7F1fFQ7uoiTz9LJXLhZH4tJeEwh1qVjXmC8NVN0V+y9jq4Lkkk48vVTrazoPfkrbpppR5aAHw7DKJUbW7KNqv8W+QGyPg+2yv6q0BuEZ3ETkQW42XAJviu+hONk1ZG0uqIzdycD2OWDDDgEeJLXB/4SQ3d8o/dmALfddBAqN8G1pTMevAgcov1Tj/39mP+KJnyHhMQvFmQQOhlswpHz8ZsVqjtdYXaKR2R0Ge6S6T76IKFRIlq5aK4G4Z9BRoW+3X1ZCEwyAGqVTVuo1w3OttKm9LiqAxJV3hDUnJL7IJmrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiLHzwqyJyP/wMxbIQawJq1LKdjZGxKJEvS1UsSULhM=;
 b=fkauc25hrxBXe57QO5VzWh5RSXAT8WEgiA1q/TqIjc3e0g/NCGL5xOfaOiadqpbN0/Sj+DNHPpvKN4GDGZ8IdYMSaUbziOShqCUOQrlSp6sbzW1bmwCEMzr5HWuaKXNFkKBGHV4stUKBYxG6hNlZ4UMxG4iESgG9XlX3skt1l6I=
Received: from CH0PR03CA0278.namprd03.prod.outlook.com (2603:10b6:610:e6::13)
 by PH7PR10MB5880.namprd10.prod.outlook.com (2603:10b6:510:127::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 06:11:46 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:e6:cafe::36) by CH0PR03CA0278.outlook.office365.com
 (2603:10b6:610:e6::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 06:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 06:11:44 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 00:11:39 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 00:11:39 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 00:11:39 -0600
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60L6Ba9R2361918;
	Wed, 21 Jan 2026 00:11:36 -0600
From: Gokul Praveen <g-praveen@ti.com>
To: <j-keerthy@ti.com>, <ukleinek@kernel.org>, <linux-pwm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <g-praveen@ti.com>, <u-kumar1@ti.com>, <n-francis@ti.com>
Subject: [PATCH v4] pwm: tiehrpwm: Enable pwmchip's parent device before setting  configuration
Date: Wed, 21 Jan 2026 11:41:34 +0530
Message-ID: <20260121061134.15466-1-g-praveen@ti.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|PH7PR10MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af96814-631c-4772-998f-08de58b3f3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o3QxNoOS1ECd7n/zNxeJc1VVhLqLDSoRUi8oGrEazKx7Owgd3Y6xjyuS+yFU?=
 =?us-ascii?Q?Mwq1XD2LzPxlj4FvW+NjuBG3qhafH+RmcqVxxCDZUvYEA/3iDZw5zjMfMO1l?=
 =?us-ascii?Q?ervR1zZzjmqwGDM7tTmHh/tmsh45JyXFYJRGx+K5Lbs5MvzfmvDZlOKXwnUW?=
 =?us-ascii?Q?0nDzcZXvdVRWEj9eqUQUDl8vxll/vUdijgPN1fKU21nR8cDJbE23i24sQxtb?=
 =?us-ascii?Q?vp830rvQF+Y4gWZO44aE4wlIMom5fqRzq0xn6hp2iNg6ArCmS6YtOG9CtzNR?=
 =?us-ascii?Q?HKDr3I+eDcpuGKikMEVrCoFni64Z9HXkC6lKDTjVurBY+b2RAcfWvKbyNYu3?=
 =?us-ascii?Q?JrfE9yKm0j2rFJaKDqoEOPqjdHjlfK6SfQ20rS3Bb7xVgcr1rbx8IMkWGh3z?=
 =?us-ascii?Q?r/SDi0Cm+isLfOmP3Ut5O6mvT5Ok1iBHFC4/IkDyZEH9b8Qv4yZHsMcDTq0B?=
 =?us-ascii?Q?/UdNhvAw3eyKU+qQfkpD+b43ZpOuQO5j0UNQOl60Jd8m0Uq3TKZlOPIpjocQ?=
 =?us-ascii?Q?kxM2JpoLvBSLG5VNex1AmeNdBcpJkuWMkOu6Toz5I33JGVVzZl3hW2MpJ/03?=
 =?us-ascii?Q?lzDgQexqt2w7NgtgW2gjmGVw3N/bmTLSm3SeL/0vFHGeUfnxxnK8lHAr7vmu?=
 =?us-ascii?Q?S7Kr2ScUwcKfKIn9GBoTIaGeo0t7OL7g238tQjoNz3g5u+1doqZHbzA2tq4R?=
 =?us-ascii?Q?G3VAScnZ5R5Xtu6BZwFYC2dJPmqmXEgXhW6iH5vNZDTxTlABZxtvkKz2Wdhy?=
 =?us-ascii?Q?HwfkyJ2fqjSXWLng0/WORg64sFg8eAMCJyeTj7+QwNk9ZO/zvyuYvwd9QvRo?=
 =?us-ascii?Q?fUApH/QC9a+57CAJFZUplQqCXgzPRGo6IqfRG4kMTeonm4e9YOpZ5Eug5aUN?=
 =?us-ascii?Q?Y5mmgoKgNGd+53/AUAZlZ7KdtKVjcIzLVdLC+OkkvJ9IPmplfhVMHLmDh+Mj?=
 =?us-ascii?Q?hDlZouuhg3VaiicPOiJ3nOhx1BGyhd/8ZqtzHMadDEW8qg3EVJj+dpMzo6qQ?=
 =?us-ascii?Q?WyBYz5+TylcY/f+ELy44npVmX6A8QGiDiB55j9AiDw0jrnjcvFjC8ZDNTY5W?=
 =?us-ascii?Q?hP5RP7Vjmio+3VeNd8qYJNCzLHu8Q09NNlfJmWS1krxmaiPz+ojFX2H3Bxup?=
 =?us-ascii?Q?WWKZlhG7KIcCqvGHGnSpKjbhcbv+E9mFCrAG8E5mePDXfSN4R09w1Zmdz/3f?=
 =?us-ascii?Q?m1F5cgEmAbrqqDcOhjKM2+/X9bOouqTKldjlvvMQhaBhomQ9Ibn5MT0UgvoY?=
 =?us-ascii?Q?Wlf6lsnGNW8q7GNjuk4it3koJXtwCnwkz3Q4bX/RMh98JBUocZtkjkZrvHII?=
 =?us-ascii?Q?FgE/9j/SB2P+cEN9MmxvJ187U+Qk01kpcl5YPwwOLgxtUPNogmf5VxRuoolW?=
 =?us-ascii?Q?0pKE4v9J6gFvb3QBdYrE/U3/1UV/VAXEJe4h/xxHCbrJ9mgTeLT+Ll+c9eYl?=
 =?us-ascii?Q?scl0Gw0nmITj1mPpSdvitwTSBieNtpH+X6nwakg8KujdykkYLRMTebZ95F4j?=
 =?us-ascii?Q?qvxkqjS0nCYmpgCkRO1kxXcVHMey2xRYEj/W+xrJn8I7e68xtqb+c0AcvztV?=
 =?us-ascii?Q?7MOk0uT99mZhmP07ez88pT9119sRNZlmIiyhIn+FMYpe45MWQH5A2g7ovYRE?=
 =?us-ascii?Q?GOfNxsfSVEoNA4epWdnA5EIcE+573HXeRqq9CcZjPpYfvUhCsBosWZk97WxM?=
 =?us-ascii?Q?0QBVWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 06:11:44.6336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af96814-631c-4772-998f-08de58b3f3e4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5880
X-Spamd-Result: default: False [1.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7981-lists,linux-pwm=lfdr.de];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-pwm];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[g-praveen@ti.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,ti.com:email,ti.com:dkim,ti.com:mid];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 8113451EA6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The period and duty cycle configurations on J7200 and J784S4 SoCs
does not get reflected after setting them using sysfs nodes.
This is because at the end of ehrpwm_pwm_config function,
the put_sync function is called which resets the hardware.

Hold the PWM controller out of low-power mode during .apply() to
make sure it accepts the writes to its registers.

This renders the calls to pm_runtime_get_sync() and
pm_runtime_put_sync() in ehrpwm_pwm_config() into no-ops, so
these can be dropped.

Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement .apply() callback")
Signed-off-by: Gokul Praveen <g-praveen@ti.com>
---
v4 <==> v3
===========
* Modified subject line and commit description for better clarity.

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


