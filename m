Return-Path: <linux-pwm+bounces-5846-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0331AAF08B
	for <lists+linux-pwm@lfdr.de>; Thu,  8 May 2025 03:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5A69C7B78
	for <lists+linux-pwm@lfdr.de>; Thu,  8 May 2025 01:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D73A2CA9;
	Thu,  8 May 2025 01:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="aZgXpU0J"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011042.outbound.protection.outlook.com [52.101.125.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEDE28F4
	for <linux-pwm@vger.kernel.org>; Thu,  8 May 2025 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667019; cv=fail; b=NngTZfMEFTq9GU4FnZc6n8AkVbh3j6Y8Mukb+DvvHalsvM4aBtlD7FKWyO5w1+JDc/exAsDLu+2KqmaqHiOe2iy3AoBfErCkq8adK2HYmxvOyhbNqk14btQBLOhiC2H1Qz4gvMEORkgiArSOlXXup849MHHHApQNVopigXLY/qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667019; c=relaxed/simple;
	bh=45ktiPH/e9oTmaMgONjUaDBJV/YQFPblusg8c9L7Hx8=;
	h=Message-ID:To:From:Subject:Content-Type:Date:MIME-Version; b=MWGmNO2V06kOl1vcxKHRvGHqrUVrB0/2wZa6HfBcPHfHhPA5mIMUyiaDrpkCsJxUzQyZz6pkzqnX6nbcGfkNy/X+uGwOJQFe/fXHtWJ6MDd82mLL9kwHaqE0ftnp9CkvLrOj0y3hAtKHL2ItdHct6NGqheHfuCxtrwePv+D3gSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=aZgXpU0J; arc=fail smtp.client-ip=52.101.125.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elj58MEq7QkWpot8aXOP4eAme/JGNzGAe0MJasZ3+HBX08ElfP5dXN3O2smR/9urb+v0MEAW6kAQEg4lomZHxRuxxnMdxVOmJ4ZYwkuVK7Ybi0X5rPOXiX7juG3d6OG2aDuW49BHnPBEDDzZoMlS4+G7mOYTUN6bmsN6JqbqDlyryHjKfnyQPxXzgHcApZBinO3z9vKxdfXxG8p2qgmPRRw2mc2Zs1krkz/2d+epJueU2OPNDNiK6lFXdlSVV9jJo6vCJcRt7eCUvRMb+YK8l8EwyNWkX+gTu4PWG/RB1L9gdDTXgtyFUFDSK/DzclytzEMpcTq+LhmtRzDCvNudDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqVxn+BwkvDOM+OWXZ6juqhI7jXYFJroQylU23h21jo=;
 b=AnE/msGzi1lc2OPuC8coQtu8znmow+htxFpoLjgnY1XCpI/4AespDoN+OaePNVd89EXXNfWDP8WkboshjREe0GqATSm4WJX7pPVAncJIdmbeaxJPBxhfcH7E8TvCeo9hb77BYjK8jYyEgdXq68XQEcH7BjZLQDwzTcJDOEcBroWdPEIk8ISLmtkfrU7rqm/7LopFSMNt2qmsmxNY0zqmguC9hW8Ac/eIIL6vWAs0zdje/RdwA1KeEQtbT9ddAhApUiczdtI1BwosapMr8696ck6fzFUYiODBcr310gQIHN8koKDlmAgCrbDjQz7X3/knI6ZHEDIGFz8Uol3H6SrNcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqVxn+BwkvDOM+OWXZ6juqhI7jXYFJroQylU23h21jo=;
 b=aZgXpU0JxiiWhRGfrkONDeYk2povZSxrOa+TTylDYo6zwO7iOTPm36SwNm1OW8rwjICrCwaymhn0hYn9o7UN+qTK68az5BZ2NpZ5W1st/+lyOhszJv0cm+QnK7MAIDFAgyXZuJFm21QNblK736ZCgmkFZCjor66bNCMT5Kx07YU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS0PR01MB5748.jpnprd01.prod.outlook.com
 (2603:1096:604:ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 01:16:53 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%7]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 01:16:52 +0000
Message-ID: <874ixv3nqz.wl-kuninori.morimoto.gx@renesas.com>
To: =?ISO-8859-1?Q?=22Uwe_Kleine-K=F6nig=22?= <ukleinek@kernel.org>,
 linux-pwm@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] pwm: tidyup PWM menu for Renesas
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 8 May 2025 01:16:52 +0000
X-ClientProxiedBy: TY2PR0101CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::15) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS0PR01MB5748:EE_
X-MS-Office365-Filtering-Correlation-Id: 925f71d3-a592-424f-5132-08dd8dce0405
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?disuNS8eVS4Augd/wF4zksSLAEa/VP8qRt3O3Tj0p9iHlsNDdL+90hBRia9a?=
 =?us-ascii?Q?ul7gmB1yoBzeQMSf4cOvZ/aAX4O2A86YNxF331enIFqj1349ll19IyIC1KmK?=
 =?us-ascii?Q?6DEMSPrgwfbi43Ak05V8wZpWLiJRMKShhRqF+7gkuHsLVZhRjtDu7BZ4V/ZM?=
 =?us-ascii?Q?v8jqIPU5MeBlSD4ES5CzGWqFrgmEXrthwSiVmI4vS5IsJe/rdKWhooBuMsHp?=
 =?us-ascii?Q?x++hkSZYuo4Az3utwNK2XOO7LN4hAJz8Q2tdK/9sTDIZ/BmCmqLSB//fiOFz?=
 =?us-ascii?Q?Le3k9CrnIJZmhO8rziA1irpQrKphj6wtz1lQVt2MJOIQWCM5zqGxHWiPRwLk?=
 =?us-ascii?Q?dX7r+8o31kdjv2KbOqKpibttSEAB0A1VECDmLYPyDQUc1iiuhg1CSvNLTPa9?=
 =?us-ascii?Q?GXWyt+ZrPsVexMauFS8YvpmQfY0e3pMhypV+fX5ErgxIvrJuemW0Y6Lyt9ss?=
 =?us-ascii?Q?NOBTZpZAyxdlV36EwH18Vcwk6fic15A9OOfqzZ99fouVkYFA31RlaiqFaP6s?=
 =?us-ascii?Q?WOjAkYvCWnNChWbClgbrXz43igbsPrhHcBSGt+2J8/IBwwuVErk+eYxRSF1/?=
 =?us-ascii?Q?TzOVAA39YnzYNzcvLW+1MqubuQYHUleXboWamfNmDQaX5G+F5emYnETo5Mov?=
 =?us-ascii?Q?7vK3asziwqF8RNQRx5RDr4Q5TsVMScLx2SSa5LLtohvzT/pfL7mfjDm4EVrQ?=
 =?us-ascii?Q?e+g//530fft/g/wSEuwEynX2/srHctNcaxukjEZsQTw2WU60qWyD6y2dwDN8?=
 =?us-ascii?Q?6CKFVCXqcGpJnGLAyzBkwsA3d3CUX5fTzsAenmAhilgR/BI0fEoBQquSyObs?=
 =?us-ascii?Q?MDpDFZ1jLxxaOjLNqI9CIBUP54vwF4k6Qf/9dRA8EY3f8L0W/DiYArZlQAWq?=
 =?us-ascii?Q?pZw6KRws826WCmayA/1taufkcSxdBdg0fjMVkEbhPSu7B/F+iXlUXlV/I6Po?=
 =?us-ascii?Q?SBWvVf29n+3iylKHcAJphZo2pUR6hY1FuVkIMlp00y9HDlDvzKvDGY+4jORT?=
 =?us-ascii?Q?AJltCT7RPbpku2HDS2b3TZqb6c+yhWJgN+xnJTXRs6mct/XD5uTruE8pyrJO?=
 =?us-ascii?Q?vCMbEN4aXMUsGXcH1QjJzzb5AfjGrLthgyZb0BYpGSMDn5pBjvdpUy5QAAew?=
 =?us-ascii?Q?IncIxmrAou386z6gjloD2L+ZzANEbACj9onVzyTdJOfL49r+oWXrtzzfnhcM?=
 =?us-ascii?Q?xHH0cGCXV68HlVC4WIqJ41cS0WoSGH+fdWXoBTnjol0nRqFWw5+o9YyGDDGf?=
 =?us-ascii?Q?WgL3VM2MUDvx9TWW2wlIaxcznt5RtPCFgJaulwqWNGmnovX4OAR8+kXkYXgQ?=
 =?us-ascii?Q?vBLBH4PW8JelfQPGczDqThIYclU2RygCj7cIHrYrfaA8YKZDRJj+x3PTLzeJ?=
 =?us-ascii?Q?02ivNtLO6d+m/7CelM0h8W+FQVjH3XEbkeCNErKW3C/BfuVac7N0jD2QC2HJ?=
 =?us-ascii?Q?954bLWDlaxQ8tJg4VwjnHTLFv5ktcAfEE2K2xTGCq4RijLZIe6zprQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lVgrFrDgPzImxUxxcJR4ZCKWh8kycdblAEcSX7tvOU6D2TWfdwpYG96cVOYS?=
 =?us-ascii?Q?VNw2VPPyKZEXvd+HasvhDsnnVP7wsiOZ3wtVF6Si5NI8+Zi4YV5Ixj8YLJA4?=
 =?us-ascii?Q?Gs6qAOPoWWwrKTTf3jTu5w/ESSAEh746pRhs3GVnb1pGULYvLjjsmKIOa0pL?=
 =?us-ascii?Q?OlzyJf5ucoG1oX2pYID77usBGTVfoGv+/KrxbATZXOH0kOjFxFLILmqLU8xw?=
 =?us-ascii?Q?B2BFps4TzhDZo0JaDL86aKelVlWiHP+v1Nob+VzBva7PjdwWlhlXWGhYka+2?=
 =?us-ascii?Q?jsMkqV5fDfEB1W4p2rQM0bLyibUAqmHahJmAbTQtjXoXG+MUr3/XPCuJtGxs?=
 =?us-ascii?Q?Kl2eCSWIN4L3fwbAO6NFcaSy+kV79hcm8O6G5z4ls/XUNt3N68eopwnufXXg?=
 =?us-ascii?Q?EWy++0C54bj31FzyE3FxLEWwQUojwyMy7ZCFxouRjL6PQAsyP/8OxZiFplhy?=
 =?us-ascii?Q?ZUA84MappyRGpYEz1+/4pEQornMT7033LMQ5MVD6RkNm4mdC3XNydQg89N+J?=
 =?us-ascii?Q?qy0QZu+jY/UtF0gyJ32UyEL57RDhZ4K7fdnIsg2NUCIEgBFwz3B4MCYKzXty?=
 =?us-ascii?Q?6+Dt9r+vayj86Z9hkYkE3xwsu2B8cDRQRGSCD/aKDaOwDrqzvWyNgG3Eqr+2?=
 =?us-ascii?Q?Ri9dL9aIDtpnh73qX4+KRV4BL1f1V8hRG3Yo0UEiavf58U1wjXmTs/n1CLIC?=
 =?us-ascii?Q?dzZfeNXPVrrQC4qOx8sjGKkqHfW/oEiE+nJwJfY7sn3PmswfWPdjw/C9Ozlr?=
 =?us-ascii?Q?LtXTaDyiFC3td09louta2kBe+95FnuQ/6rlBCKnjXCZrt2tt+1qk8g2pYLlX?=
 =?us-ascii?Q?/2YK80+HQ0si+PKT8II4xC7QSZRJwH8UigaXDJ56LBsIMrnf3hxkexNxp77t?=
 =?us-ascii?Q?dL2NkY/HWC1667CHWxAce5nszF34VyAylkQzwwSO5MOtimCrUKU4fPhHD1Ic?=
 =?us-ascii?Q?iUw7YtPMEKEV9N9ERcfyGkNnITMw/6ro4vN+LMQA3rkJNj7j3j1kqMCAmiEY?=
 =?us-ascii?Q?Y2HWoVK6rN7ly9oKA/BxTEzkwmXUtYsc3WzRebrzv4bcCJSnsxFiQKyBAnaF?=
 =?us-ascii?Q?DdbJ2F5G7OK9CGZ28SVG3pDJlix1lHg3ya6Gi3m2Lh5BZyBzucSEfywh4yhf?=
 =?us-ascii?Q?Z5VBaBp0YNP20m+m+OLO9GijJdk12+dJ/MRb9wTEhyCsN3XDVMnOUwx2kpJk?=
 =?us-ascii?Q?FVn/XDsVpb0TAN4uJugVIEfNz/6Psz4+aP2wLJteN1+qUNRs1Erx9YOX96yt?=
 =?us-ascii?Q?Ox60Nn6OEKqNXFIIUY8RG8bvnG0XO6VZtRYlN9Ne6TYWFw4m5Yio/bsQ27Pa?=
 =?us-ascii?Q?Zc2gG7pSFeXNEqBTvpZv12KcPqx2vpg1hdHXp8aPDEnv2L5M+W71o/aPyc7O?=
 =?us-ascii?Q?QvgNbvEGVoTDGk0ln3YOF1e0yTpXQtvKe6TWudvds8rtxjz9HWP9DcEnLuKw?=
 =?us-ascii?Q?LWVXmfPbbVYIsmQGXEvH7+yJEnkvbZv2vD7eJJnzvd1IlC7NvrWZJ7oS4I4W?=
 =?us-ascii?Q?xDTIwIN27qdGxbNTnwDREGoyTv/B6D+5bpTzMQcq0XTBvJeN5DE37OGfF3x5?=
 =?us-ascii?Q?UP7sXpaimR3lWnnvpRAZXvABjLQ4Rp8XZCBBo6JyZbRPO0EmLEyMD2MamqWB?=
 =?us-ascii?Q?dMm4G0MjQYJYlvoDJEyonLY=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925f71d3-a592-424f-5132-08dd8dce0405
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 01:16:52.8548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8bAiyoax0eLJcVbJIVUA2o4MD5aSKj7cjf7adi1MGb7Q/YiLwde31mvdRzgo2z/0NDPB8S6K3DXCh4Y7b1sT+vkN/e5B2iY2+wH0N9BfTosALkbUzYx9Wtu+IRHOVZG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5748

Current PWM Kconfig is merging Renesas and Rockchip. Let's tidyup it

=>	[ ]   Renesas R-Car PWM support
=>	[ ]   Renesas TPU PWM support
	[ ]   Rockchip PWM support
=>	[ ]   Renesas RZ/G2L MTU3a PWM Timer support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/pwm/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16..6cfd1172a727 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -532,14 +532,6 @@ config PWM_RENESAS_TPU
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-renesas-tpu.
 
-config PWM_ROCKCHIP
-	tristate "Rockchip PWM support"
-	depends on ARCH_ROCKCHIP || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Generic PWM framework driver for the PWM controller found on
-	  Rockchip SoCs.
-
 config PWM_RZ_MTU3
 	tristate "Renesas RZ/G2L MTU3a PWM Timer support"
 	depends on RZ_MTU3
@@ -551,6 +543,14 @@ config PWM_RZ_MTU3
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-rz-mtu3.
 
+config PWM_ROCKCHIP
+	tristate "Rockchip PWM support"
+	depends on ARCH_ROCKCHIP || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  Generic PWM framework driver for the PWM controller found on
+	  Rockchip SoCs.
+
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
-- 
2.43.0


