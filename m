Return-Path: <linux-pwm+bounces-1686-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD2D86FEF4
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 11:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AD061F262E4
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Mar 2024 10:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB7C2577E;
	Mon,  4 Mar 2024 10:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RaGRMThS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3787B24B29
	for <linux-pwm@vger.kernel.org>; Mon,  4 Mar 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547706; cv=fail; b=cCwHmmDMIi+mfjUPduDx//juWpba6NFU65MFxwI/5hX8OVqyAP1UYYhQIZ1U0cy35EuBEvM1lkiTAAg4y4LMK2ZCBfb9ScYMmHECK2YbOarh96cvQnWBKYnH+qPEeRsnwJdlYLMdJinOBRdCT+g29NZV35UPsR0jKBf2OZ6tRCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547706; c=relaxed/simple;
	bh=6XRGR0i5+n1I0HLhg9Xpt8lVpvxq1lwm+lHW7kbYIX8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oGXw5n0cxJ6N1Q1tbeEifKawHWL5Wr9bzXa9uDCWvmNTGjNEbSmbqK0EA/l5Kztc2kvypHEd8RDF++XUt60mqE8h8v+ai8A+lnXAzor59X/FyBxpvG/vdouAOEjiyXI9zwyG90oX+6peG1XRx210lH2rY+pFkakXu7SDL6T5nMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RaGRMThS; arc=fail smtp.client-ip=40.107.104.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+7NZAWmPDfsSMZmo3/x6N2GrRXTJwbFkuN4K2El3Y2Iu7hjEgCBGqr1m55MMj5N/GYY1cih0D6CvrmLglSymChWYefCGGTpprSPeaZfNK047V2S1EoZDt/YVywhWdd3OiSHfE542e1Q0fhWEtxGN5hwRXp01YNGRYwr4vsZkZaX9bmo7oXagS1pYVnZoLrHQdNFkJ8b6sShQXB1yeHNnx6dtlVNqoZi/f6BHPmO+qQFiTXAsEMaJdMqI5r56iacdBAN41ub7ZWunavRO5LoBV+Zois+3sx7u4Lq7vfKDSq+vYBWSGQ6Jrer9XxXEoyayZXlV/6d0JsLHxHvNXJ2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pl7PYdnflq+71bZUFtfemQaBFvaHsd6WwA0ec8oRhM=;
 b=SfMpTuBLPkxSFgJYRCXobHg3hXZPFVUz8xpKuRBqLhW3v+zDebPPPtIUchR5FGxN2C1SKVLs7iHqaZEYujcifvZ6UnHvDxxVDn5X2YnhxGxsRgvcSa/YIbg6YuidHEHfHOTsOU7Ek/QIkvaABTmCPntvscujH6vmggavGti1CjMSqcIxseqqOQotNxOgierZi+2w5bLr5lIIXguTaE/DUiY9Vrp5ocKebHYRSUz2haacSfMKzCFzXvDAkIFGlqP2a5UJF+x8xTjFng+PBH0al2wygr2LICiXdAwA8bguKEoeJ60BHXRRrFHFlZ5BEq5yJMn2DauKzO34w2FmqeVSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pl7PYdnflq+71bZUFtfemQaBFvaHsd6WwA0ec8oRhM=;
 b=RaGRMThSV7lQWCcsZtuQyOQh6pMNS1CMb2kBBqtss2bIrodX34NPsxInPKLz2naUQRN5XSyhHKXari2H0ZXNU9GVsGFDXyUNycRd1TvtzZhI2qXeTLCruEHfE5MX77xYI4Jwp5VG1Uc9q68AgGZRBLeTySC9qLCAmyTDA0D+Q+4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7)
 by DB8PR04MB7017.eurprd04.prod.outlook.com (2603:10a6:10:123::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 10:21:37 +0000
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::57dc:31d2:381a:df71]) by DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::57dc:31d2:381a:df71%4]) with mapi id 15.20.7339.031; Mon, 4 Mar 2024
 10:21:37 +0000
From: Dong Aisheng <aisheng.dong@nxp.com>
To: linux-pwm@vger.kernel.org
Cc: u.kleine-koenig@pengutronix.de,
	shawnguo@kernel.org,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	dongas86@gmail.com,
	Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 1/1] pwm: imx-tpm: fix probe crash due to access registers without clock
Date: Mon,  4 Mar 2024 18:29:29 +0800
Message-Id: <20240304102929.893542-1-aisheng.dong@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0199.apcprd06.prod.outlook.com (2603:1096:4:1::31)
 To DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9299:EE_|DB8PR04MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: da636d46-dcfc-485f-bf6e-08dc3c34df77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BtgJXqdUOx2/hDED5PyPN9VjHZH59FROnJce/DVfx+9xEmGxlvBCRr9u7AO1r3Nh5bCaUmqIzzt+AxDvg6OGBZeZGxgu7SiwGqsRij4vNFvyuZHi/CzIjI/4IV6XarasGKee/Ir4xPnlAGAm/2kCAnxiJybVGsUo9hHBEE+lq0El1NL8nTeyN5tUlMmJjB3V9j2zX+0cWSjgDkRnwxvvJdwupbjmLMY093yot5udQM1XEPH6+ZrtznNC+b1IhjIWn71pKe9EHqQm1QZWjaSkl1Hk+F+KRQYoAjVWJNZg3kyUQe/tEi0q7B/Vypl3FcbaUvDeliL/vkA0Lk83jZIp/ourPEihfEDriIaFwwAdE1IpCBVFUnG7vs0+wsNCdAt2Izo8U4sdPcti6M3l5AdCeTmVuD6xfkwr2y+FO2z2mYi/LaSf5JY/Kjj9HZ90n6Q7FCK3xxxAZBdzPHL4Xi4sTDK1LNHJhPFBOmZoeFUcIxWDaUiKhoK/7ZZNvbTGAsnmUw1len31WZLvcIMwm6kFLW4jYEZQGoDxtwQjoll3u/KJYxHVQyaZsyI4kM7EJqF9LCAWeQbjEzu+qfVgOpv/ASiippuHalHTvFtejDnaFi31Sdc9Uo415rQP86UgLre3viPyrnuTAXqzlaPEIEsRrXSMeVrjfzZJ/8mJloUSoJH1lyj3VuR0T1FGfHAjb+L7aL0MgNyN0Qynrapr7iowqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9299.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVJBMXhINXJCck1IU3VuQVBqR3RJa3dZTWNtekNqajVFNFlZQXU0M2pPQzJh?=
 =?utf-8?B?OHNQMGVtaENhT0RoRjQyejh3bDZrWThqeVluOWZzVG8rblpoM1RXbVdQZGtC?=
 =?utf-8?B?a1gzUVVaQXNoQTl4Y0M4clhlNS9OaDZOV0xHdFlINEdkaGxkYVJ2a0FWTkNa?=
 =?utf-8?B?d01ucGtMcFpUMUp2Q1djeWNDd0NLWThTRyt2ME5NeXdwdytVYUJPT2lLSm1E?=
 =?utf-8?B?RFFqeFhUNUlsOUN3Uk5CclNNYXlIQXFRb21QTllCUDRNOWhsZGorRHY0UlA0?=
 =?utf-8?B?b29nTzJGU2s0ck1OR0JhamhPVkM3THA0SnZHdUc2Y1FlVFhRbzVoT3lqODRm?=
 =?utf-8?B?Q0hZcytjZHRLd1dCNmdpeVgvTmI5Ujd5MWg5eGQ2WEgzejg0NDdpNGlWbjdo?=
 =?utf-8?B?TUtVUDFoOG8xYVJialNuMFNZbS9tTm42NmNoc2J2Y0lIakhDdmx3OWhlNnpJ?=
 =?utf-8?B?VXMyTkFJRkJtY1ZQQVpURlpuVFJHM0VCZ3dOSWlxTlpMbkdjRnVSVUh6Y1lT?=
 =?utf-8?B?UW1leW9ZRUllbzlObkFLMFdvN2g3ODZTalB4STV3aWg5amdta1lMallYcW4r?=
 =?utf-8?B?NTBhSXBXK0diWFQwLzViMGpWaHN5dU5wbWhlc3dzRHBTbWpDNWl2T2M0aGJR?=
 =?utf-8?B?dmFyZGRyWm9VUXgzemdhUGlwRldKcFkrNHBiREpRU2I3LzFlTmlkYi9zY0FQ?=
 =?utf-8?B?V1Eyc0xwOFZuWTlhQWIrU0dHMEI3cFRYemtjQTUvR1g0OVdreVNVQUw0Njha?=
 =?utf-8?B?UUhlczdQQ3U2UHFBTGxGbnQxdGZnWDRlMmdjRDBtUWxzVzlhUHlaYjZUL0Nx?=
 =?utf-8?B?ZzZkNENxSW5zYk52QkRaSWNZK3YyWUFydGp4Nm54MlFsdDA0SFRLQ0JFKys0?=
 =?utf-8?B?cTB0NVNBWUt5d2h6K3ovcllCOUVOUXd3bXVLanlTWkExRnZMWWxjZDZLeVVq?=
 =?utf-8?B?a1Fid1F0djJXQzRoSVVYQjMwNmJFN1hpSmQySjlnNXZtSllXREtFV0NTdXh1?=
 =?utf-8?B?RnUrNXl5ZFJlMDg1aG1TQ0ZrWUdSeUNCRTRqNDhYVU4xZ3pENjFCWDJQSStw?=
 =?utf-8?B?L1RGdmo1UmsvY3g5alJOcjFwY3NTdzl1dVpja3l1MzF1M0YxblVzSnc4enZz?=
 =?utf-8?B?QWx2clJYdk5rNDZNRno1ZjMzM2pvbmozeFN5V1VMbERpRWMveUFheXZkY1Y3?=
 =?utf-8?B?dm10N3N3SXA3MXBFS1ZZNWNnNUdhd3psZFdRRXdCUzhvZXR2NVAyMitCUk05?=
 =?utf-8?B?ZDdQUGJXRkNXVk4rQ1BkL29Za1ZXQjRWV3J1VjNmMDduQk5WS1BIZkxoWkVw?=
 =?utf-8?B?SHdPMjZNRGkvQTZDT1A5N1Y3bmtpY055R2Y1VDZQSTA5Q294K1ZLb0xJQVZO?=
 =?utf-8?B?TVY5M0laRUpJWCs4NnJHOFgxdDllTFhvR1N4c3BXSWZzOFZZQVdpSjFWeWN1?=
 =?utf-8?B?OXNXbFV0a3pWNDlrdnBzb0VYUHFEMnVtSmlCVTRYYkFVYkxEYkxUS1ZKRUgw?=
 =?utf-8?B?SEo5NHpaR25Ocm5TdGlrMzNoOWp6aGtlNDg4Qm5MWlVnNklWSU52N2tZRE9s?=
 =?utf-8?B?dkJWeXVaRzNOcHdZL3dKNzM1czN6Nk5iRzJDWThTL1ZqMXdCcno3dVB4WUpx?=
 =?utf-8?B?OWpnZC96QVdGZHNNS3dYWEVYK09oZjV6V1YyT0ZnTTdhZ0x3K0dKWk1LS0c3?=
 =?utf-8?B?WEthWGtPUllJSFZGODl1TDQydTM4ekY3a0dMekxxYysvTEVEQ20yR2pYTGc0?=
 =?utf-8?B?dHdhZVlPbkxRdk9NK0tXbXUwSm1zR2hpQzVLbUlCSTl2ZUhvb3hYREhlcnBE?=
 =?utf-8?B?cnhSZllvK0VrYkhmaHZDTzFwcjFLSlN1bWFoSDZVQzRnU0ZBM2xNaFMxRHFF?=
 =?utf-8?B?dzEyK0lhcXZMWlkyTS9KMGQzOE14OTAzR1daRUJ2R0FmNXMrOE5TV2JHOG5U?=
 =?utf-8?B?VEcvU0FuUHdrREM2ejgwRkk2enlaUzM2THBMV0pjZDluOVNtcUtvMWVwOGxX?=
 =?utf-8?B?ZTVsWFQvUUd3c2o3a3ErbmhMRExCZ0lEb3hSN1Q1b2E1ellzT0hzemtSY3F2?=
 =?utf-8?B?SUlWKzNTZDFHYXRqc2FHeVEwSG5NdGxEWDJxUnpnTVZvRkU3UjVtVG9paXlw?=
 =?utf-8?Q?uJ9vKKlLdU7QK6ZE3uGZ23q22?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da636d46-dcfc-485f-bf6e-08dc3c34df77
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9299.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 10:21:36.8057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mjV/QMn9qE0rSlU0/9oVM+i2txQWWAh4SuPAIcbYDs2sOgj6ke3sjSCBIpIKmtx0KdqEZEKGXMv2Q9a0Ywijw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7017

The following commit abf6569d6482 ("pwm: imx-tpm: Make use of
devm_pwmchip_alloc() function") introduced an issue that accessing
registers without clock which results in the following boot crash
on MX7ULP platform. Fixed it by enabling clock properly.

Unhandled fault: external abort on non-linefetch (0x1008) at 0xf0978004
[f0978004] *pgd=64009811, *pte=40250653, *ppte=40250453
Internal error: : 1008 [#1] SMP ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.8.0-rc6-next-20240301 #18
Hardware name: Freescale i.MX7ULP (Device Tree)
PC is at pwm_imx_tpm_probe+0x1c/0xd8
LR is at __devm_ioremap_resource+0xf8/0x1dc
pc : [<c0629e58>]    lr : [<c0562d4c>]    psr: 80000053
sp : f0825e10  ip : 00000000  fp : 00000000
r10: c148f8c0  r9 : c41fc338  r8 : c164b000
r7 : 00000000  r6 : c406b400  r5 : c406b410  r4 : f0978000
r3 : 00000005  r2 : 00000000  r1 : a0000053  r0 : f0978000
Flags: Nzcv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 6000406a  DAC: 00000051
...
Call trace:
 pwm_imx_tpm_probe from platform_probe+0x58/0xb0
 platform_probe from really_probe+0xc4/0x2e0
 really_probe from __driver_probe_device+0x84/0x19c
 __driver_probe_device from driver_probe_device+0x2c/0x104
 driver_probe_device from __driver_attach+0x90/0x170
 __driver_attach from bus_for_each_dev+0x7c/0xd0
 bus_for_each_dev from bus_add_driver+0xc4/0x1cc
 bus_add_driver from driver_register+0x7c/0x114
 driver_register from do_one_initcall+0x58/0x270
 do_one_initcall from kernel_init_freeable+0x170/0x218
 kernel_init_freeable from kernel_init+0x14/0x140
 kernel_init from ret_from_fork+0x14/0x20

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Fixes: abf6569d6482 ("pwm: imx-tpm: Make use of devm_pwmchip_alloc() function")
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/pwm/pwm-imx-tpm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index b04b974c5f32..c50ddbac43c8 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -337,6 +337,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 {
 	struct pwm_chip *chip;
 	struct imx_tpm_pwm_chip *tpm;
+	struct clk *clk;
 	void __iomem *base;
 	int ret;
 	unsigned int npwm;
@@ -346,6 +347,11 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
+	clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(clk),
+				     "failed to get PWM clock\n");
+
 	/* get number of channels */
 	val = readl(base + PWM_IMX_TPM_PARAM);
 	npwm = FIELD_GET(PWM_IMX_TPM_PARAM_CHAN, val);
@@ -358,11 +364,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, tpm);
 
 	tpm->base = base;
-
-	tpm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
-	if (IS_ERR(tpm->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(tpm->clk),
-				     "failed to get PWM clock\n");
+	tpm->clk = clk;
 
 	chip->ops = &imx_tpm_pwm_ops;
 
-- 
2.37.1


