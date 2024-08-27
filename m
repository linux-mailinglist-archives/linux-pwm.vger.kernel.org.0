Return-Path: <linux-pwm+bounces-3056-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B02679603BD
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Aug 2024 09:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A571F21B28
	for <lists+linux-pwm@lfdr.de>; Tue, 27 Aug 2024 07:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83D3157468;
	Tue, 27 Aug 2024 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="gd3Px8NY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2050.outbound.protection.outlook.com [40.107.117.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB15713E41D;
	Tue, 27 Aug 2024 07:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745486; cv=fail; b=eIpchdcqnDT+zN8L038d9OBlWNfnGCHePHbDdQL6FV0aVqxXhmcPNJ8yokMYhT/SBmDokO4bmrFnv1d060NVhhMt/0GXCQRoWA4Wpg3F83RB/8MUXAga2Twf45T66j9vE8nnYoy0GYHgewspNnmUoiKYdIsFV45poATGqt5vnq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745486; c=relaxed/simple;
	bh=krmrKtEyKci0YqRg2wBPJFxg9W0a1uTAngY1l5KZHsg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RGkEOH84ywukf0ZcSlTAX6//H22Una47wNk0VGQpar8ZBYgxvW5yi9S+JFupIvLIQ1EL5IRx7zV3aIr8HEMu8AFJWVl8MgBBt1o/1CQMxoubEXuClP5zcGr4y5XoschF8f3FRejgnyjuDkezRs22Ks32X6dV/g6MXtaM8v/psF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=gd3Px8NY; arc=fail smtp.client-ip=40.107.117.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1WKzasL9/+Qh7pIR4+qpVnwkDrgwdPszy/C3IR/k7R44p2f75Bom0ZW3p8GrU1t9pNXXbLqpPimoaBPOSBKP7fAgwWyeeOpdzTgTrJ4Q+MUWV49Rp1mQb7G4fufQArgOm/4MRF9kw/6r0VRvQeViv2R4ujqCa6kAWN2k4tRz1v0CLyZdl/vV+q7A5aL0mrzPRkJun/2Y0+lPmR3ez/voiaQE7XdHELOwAtobG3oPTIW8rJcYDZbD0Lyy7XxtaClO/YfjJef90tZMJdjEqCsAYw7DewH55hNyMKx4QbC8uG6CHmTuVjpJkOC6VwFxqQ57E2ZmAlf47j4LVJ1PG3amg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGkuXpRPlbDxovSiLpJiHD6O9yWg/GjUCu3vXhWI4oE=;
 b=tnxg4DPxlAK7LKROVSf1KBAnPOR4/1JOr8SNOfxNBQ6n+unA6xZ6NgDB3MxRKuEm+eAH9+0A1miqu8vC7erospq0mQln5xGIgsK/xltckM3lun8t33vyMqyqof6o2iaG9C+EHKggjp5Ba1GJwYuln2AEvJdJyaylGIBIdg7KLwG7esD4B5qvvj8pae0c1sIQeMz1ON7QJEoTZ9AjgxNMWy7dalpdE9Uc09sESZ9/3U3k6DDWnSl7v6tygJM5lo43hZCMF9kLJw4bgzOPHfpVqW0jfYyu50Ud8gRfy8FTPe7yMwD3WBrCo+tVX9EA8ZwRyi4lJa5+FweKkx2i/EBaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGkuXpRPlbDxovSiLpJiHD6O9yWg/GjUCu3vXhWI4oE=;
 b=gd3Px8NY2ysCoWhBag+yI3M31yJ6EvDhkfUcdtebIWCiII7a6bWpN5F0+4jE3lZC0KEf8q+G9pRcudqMc+b3FdCPbfNYnbLeZyw2hBeF1mQ38i4enfX1TUjZONb4DwBSfPgWUJsPo40wgrYm7pLugYPoVvoZDJSR7uqV2KRxvucy/a3NHFHtkseLnQI89gggQBVDA5nb6kB1if0yPT3kIgMzS4RrRTBDF0lHHZA62quZno+f5+XKRi78t3uEHRvSoLJXiKC1h0aMHH9ds68GXzo3P3kNTVgWFV2TEtf4K6Rcm3Pv8oS40kqdbeeMHZu1TRyOx3kt9NMf5qyc8In4jw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by KL1PR06MB5942.apcprd06.prod.outlook.com (2603:1096:820:de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 07:58:01 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 07:58:01 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: ukleinek@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v1] pwm: atmel-tcb: Use min() macro
Date: Tue, 27 Aug 2024 15:57:49 +0800
Message-Id: <20240827075749.67583-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0147.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::27) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|KL1PR06MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: fa66dad5-5bfb-46fa-23a1-08dcc66df8c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W+FLR3WAVi5PKHm4sF+62jgqocV/sAMiRvaLiA1lGtrBvYn+OU/DrQVc1cWu?=
 =?us-ascii?Q?kmNRtnZsQpk7Dm2b1lAJ2rPbTXpQ81SPDJsYZmi0/XKb+xDCFVI3feSHcXxh?=
 =?us-ascii?Q?qjEWJVfm2G1DmXpvqmDljqPNAgIm5T9r6/YHvYbzW1yAmLg9OYRg2bIPEafv?=
 =?us-ascii?Q?USHq8/C0Qk/6lNQpR2CIBVnIrEqjpWK78+LGRKcmnsGtzU+sw18m9hRyQK2f?=
 =?us-ascii?Q?4Q+aAkemKp2VgMOzzUc7i7CrcxUnx4yLEp0MxRDFywredxm0bhYYRKWws6LT?=
 =?us-ascii?Q?q8pl57QuNsP8OMXQAbu+iW1/UyqpnQRd4C/oJUI8V5D7s6X0j0hMzV2reukc?=
 =?us-ascii?Q?Q+g/pUW33SzqBH8zVJLFHBXmbx5mj38rbrq10tImbyBTvD9WbGTKjX9V69Qx?=
 =?us-ascii?Q?OejzhanJm88fX/fhSJeidkk6B5iElS6Ee8B3BG/HEl1wbc4ZKtfkNj2IeiWg?=
 =?us-ascii?Q?VJsfU0jIaVUGfZxiBpfw/ia1OLVjfbV6wAtn2EdwmpxnR8CKSpHXw5sk1bqT?=
 =?us-ascii?Q?2QiM+sEYb7cqXO0ygYayOfdF8bx6X+hoUXQNp2tXtX3zfjDCoeO9WmWrcGRv?=
 =?us-ascii?Q?KIAVqNJeF9XUCc0MA1zvOAvaXmy8UErdc+XHqtFqXjuwNSE0Yl7fH3k4n6kW?=
 =?us-ascii?Q?+tcggWv1xJ9+QD0n8o6rIVfuv7ABEZojdQPDg9Va8sMqolm4pf1XmBCcDSKT?=
 =?us-ascii?Q?OZq4iBkUZGfEOuTrImPv0fk+8ZCr6UmxpvIH/g0zaIspxOUbKIfioQ0Zqmil?=
 =?us-ascii?Q?GTY2jr8RrzRV3hNylX2t3/nTs6CXwmhPq8FdbwD7jdFcz7oG9bL4KeGrc8x9?=
 =?us-ascii?Q?Ugk4DDCgqWiaraeOQErjeuZo2oIpBylEP7rTcvnkCDkAKLUTj4AWUeaC7QSt?=
 =?us-ascii?Q?8YWFuEIlGq7bQOowCG5FKezZpJlKxx5SLwZf+y2TuNJyK0BmnxdKAosRjYcp?=
 =?us-ascii?Q?XQroEVjn9aAPAUa7Ib4IeJU5nC83Afve71BabIQLcRTMhwmUKxIXernYDU+d?=
 =?us-ascii?Q?T5QFn6Sn8hjltw7pCow2lfnMlmZhPD/5YwOYcsYReES+vjAVo2RqeJRQhmnj?=
 =?us-ascii?Q?/V3rKr88OghnGMmpoETKNL93FSEdYCeMdTO2Uo8zmOvPR8wpU6pMF36vdTNN?=
 =?us-ascii?Q?ZvmSS8S4kw3sHypGgCkn2F6dpoBRtoqcaLx6VhQpOYjtbPIlcpbrSY3sQM60?=
 =?us-ascii?Q?f+BUq4Rq3zK+a1YG3CY0f8bCXJBWXjwKHOK5B1UJfRCkbZPdYeuWQAqdvPcq?=
 =?us-ascii?Q?8qCVM7MzBcTD+KmO9mBgjSMX6G8JCT0gPhlCDiSSPqfw+DTKN045+uEN5Yzd?=
 =?us-ascii?Q?iqJbqZIqxZD9mE1AwwSL1ipe4f3ag1wGEfSp4EtC15wRZFCW6FjKoBPcWjIl?=
 =?us-ascii?Q?YnzaxuFiEXsuv23E6qb+e4ryzYcM9nUAwcoUYBnPoW0Aua72eA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SU9qLxq7BfCoPgFzfDJvB3GBTNbShfoBfVjb6rW3xTpRjizTfG2V7MvajFK2?=
 =?us-ascii?Q?93Hy/9LOAvSU4y5fpYO6IW3wFb3wmAlL0NygUgPevXbgFAW1va5cqVR4zzwN?=
 =?us-ascii?Q?7Z+lHo3vh7e0Qts7VauLOvo2xJYyrBw6HQQGAmN/s/BJtpBMWkkUuAyK0JsA?=
 =?us-ascii?Q?M838T7m89n/PNiUho/aBWKRaWSbQGWSn76n6IkHS8IJrGtjUWSzTVitPTd9f?=
 =?us-ascii?Q?MYacWjnZ/nsoQmTbHP7W9HEc7bj4QSlbgTAv0LEmJoOowEnu84Q+Ws06e6MQ?=
 =?us-ascii?Q?/64hYTp6CYLkfyn8D0vGylHCSy0EQBaZcFsNEj2JE5QH/l2927P/0a7yIqeP?=
 =?us-ascii?Q?XSxpLjhGQSF1B2rLUPUQ15C2v5SSp3+7Lx7HuS7qJGFCAihM1et8CjvZiHsW?=
 =?us-ascii?Q?H2OJyawT/H1THm3pvpr1QKBEBiYNopSVf3ptPzYhwCnVcLthbWVzdyyJUrRD?=
 =?us-ascii?Q?6O558DTjU9lOQHMcaC6Z8pBCchBH5ylj2hh2MkArJhoIw2ca8xELpAPEb9up?=
 =?us-ascii?Q?KbCX/6+eOhoHys5tam6jwFxIIqJFixYO8OGdjAuw/xiB+mL5INhBbPvHuC6Z?=
 =?us-ascii?Q?iRZteqTP9G3i58O/JGYU4bm2uR87pOYANvG2PpzDdEsJMJeUXB9/J1409zTy?=
 =?us-ascii?Q?oLv7wgPl8KRb7E57ZrE5t2qQ9nlD01b3usjeKpId4eXmRYyjyWr1Ywv7eNIk?=
 =?us-ascii?Q?XNQ6xeOp3jBLajjJptkXbfgQJSgLyMPFtZn68seRUQVjgOrJCtksWocwjNBy?=
 =?us-ascii?Q?l8TPAhGj45XB0BYhMJlGru5czTS8YgGhF2f4aN0uNfxSg7GdVVSg6vkWDlnz?=
 =?us-ascii?Q?du/VinmP/9SKRC/s4zkXCLwsCqX3Ln1mcwZGdzmkNR70hl2ZYx0FFG8vUIQR?=
 =?us-ascii?Q?vS/vSTPD0jzrCLEhNqDh7Ld7OJjgVTcl8IwXJL+y8LaBv43i0WysidiQZc8f?=
 =?us-ascii?Q?ukKHZjQwTDjmfb/Mlge/0dbY38l4YHwOWd/i4DwaFrEGvX6HveoY5I2i6MAA?=
 =?us-ascii?Q?WUCbg6gXTyM9t8UTGFKj0gyabqEZtCDVZnSojBZOsOF9VkTp4PMNdZYdRjtC?=
 =?us-ascii?Q?9NW2EzKBYUslP8zVEy1QEl45ujFnYExaRF1sKJwlPdtjahpesXF27uMdZGnN?=
 =?us-ascii?Q?kv7ZwGceyoT2DTZ0ud/lncOCaoqADdu7wk00xXt7ZasTuQMvpbFJcaVMSA/M?=
 =?us-ascii?Q?x8+X+LNmxosO0mL/y0CXVENxzRs+z8doLJlfvMo6Nu7RMxFcQXW4oicAXCj4?=
 =?us-ascii?Q?0pXCmPjmzMyLjxOBF+G2MzTtgzAypfvrWY+PwEB/v9AK3m9Cgm1HaZ3Ct4ie?=
 =?us-ascii?Q?24Kw9EoiCyeZDovslPPb8dt1tYsmqkq9LOtm0jq9uGrRG8yXmZ0/G9oHTZ7q?=
 =?us-ascii?Q?/9DipFaXtrtccM1cKvntrMNIDb+MI+7C8/MtU50YHqMg/xPz/DxhhTYQ1U80?=
 =?us-ascii?Q?4yHdHXvxFRLBdrpwxMP3ON+1mDTbLbj66oSwR/o9WAecqbhXYIYR1SYC9nix?=
 =?us-ascii?Q?xLlMTHd98PN192YuKfhsmcLIwAS5JZZ5DsvTJtgKBIu8tauDKpcjd4xMo6Cd?=
 =?us-ascii?Q?JvAUXPDsc4+RBk5pXszKCVWDNOJYtQZUOdtlTmzq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa66dad5-5bfb-46fa-23a1-08dcc66df8c1
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 07:58:00.9709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VqOHsE+w3qECxQ93yWQ70X34ekrMj2p2DyWCfIMye0OLLJ5mxaoXGdIgNyrKnEfyarNg45hpWBxwSosJgkIEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5942

Use the min() macro to simplify the atmel_tcb_pwm_apply() function
and improve its readability.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
 drivers/pwm/pwm-atmel-tcb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index f9a9c12cbcdd..386259eba9b3 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -342,8 +342,8 @@ static int atmel_tcb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	period = state->period < INT_MAX ? state->period : INT_MAX;
-	duty_cycle = state->duty_cycle < INT_MAX ? state->duty_cycle : INT_MAX;
+	period = min(state->period, INT_MAX);
+	duty_cycle = min(state->duty_cycle, INT_MAX);
 
 	ret = atmel_tcb_pwm_config(chip, pwm, duty_cycle, period);
 	if (ret)
-- 
2.17.1


