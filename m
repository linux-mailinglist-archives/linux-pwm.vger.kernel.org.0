Return-Path: <linux-pwm+bounces-7621-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFF2C5BA47
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 07:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34F5A4EAC66
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Nov 2025 06:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF3D2F28F1;
	Fri, 14 Nov 2025 06:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C/MuJIX5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80A425D540;
	Fri, 14 Nov 2025 06:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763103103; cv=fail; b=bnQbvxEhN4tN1gCMILqimATrwQe59FK/u2QnrHV/+sY2vPbHQ6OV6h6EyvXmyedSzT91vcJ1ERn8G+zcbmK9pGctLPf5hrFZiw3jrwluOZIxiG2OPr7ryTAtS0zGRXCAc+4+XxTiBU8h7d7GnqWrE3JBzk5AaPd9yhoDUGXRTII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763103103; c=relaxed/simple;
	bh=Eq3o9xXqYmS9fMdToC+P8oM+c7xCh4dSkDH0qZxcIuE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VQGobzMMzYAjEVG068FJuCVVVA5K+IdWq+mYTDU5ozDrK22b+GddlAZW3DxIm+4PxwWNyfyqIWTLYBQMtpPYVV3ests4GL5qRyCo393+vut+JdKNU4RrXGxIQ44CYwL21XCC75WE0hQyZlFDEEYFG3mm3ToCBdG9yp6MwhUBGG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C/MuJIX5; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBx9mqpqPNDCoaRvc0X2TPhi0UzXx7G6aNlJF3kqS131tmGR05Q3p39ErnVcHzVXKqnQzNBoaQj8iSjvCy9Wk3Tj0AIJ5XuqvEusUfWsSa8jCJn6XklTLzPiJv352xvKloaVwaEkWUm6pvHHQmYjrJmX+aogsXjr4cUiIL64CR1WXz0xgFAV5x470d+LfqkdlenOP2id4lytqtzofuHnBz/JQ9nSRgSD7Pvs/1mZb9oNmPJ2yisKbMRDaOem0i5VZrv+4zbdl2S+UZBmh4/DUH7GhJS6WhRbBh+dm/z21fJk7FNSrf9rltBXb47BwNCDvdUDse4+M0ynpj0hNuCKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NNLKcy4Y+RVoultyytqHnlQDnb3XlRojZvwhaJx0/I8=;
 b=LUlf87Gmf9BMyq/i4ZpJVZz3j74ljNaA0Eiy5WMGnCRhJJdjBUmjKd/iZbcgUganuMptzV7WvnQXmVVPP1hYGJ+IWjri+iuhEwZBj6Tnd7sszCMXae24bslqeDzIgNF+tnHPTmUSmItnxzej7osg4fXHtwY+Sl9cZyIoNT7Km5V+Xj7RxgvUD73e8ZFzB7UF/K3xXRfSHrdMWcYR2+S/SSeqm+wRxesMxcB/IRXOyu3NJW5LITGpdqbl0RqURCI1e1lJBkhHeHBul8zTbKwSDD/VJ/sgfYnETZbd4bZB73HOyyELnXPS17P5WUriA6IK8w5jE+o09P0Y3txeY5uNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNLKcy4Y+RVoultyytqHnlQDnb3XlRojZvwhaJx0/I8=;
 b=C/MuJIX5Hu6DcLpn+34M6ZlNuTuPbcYxqNggRephY/TLR+YyyvKQm9KUCxJ54wgmKGZ6Qv4YjKTLJ4UXjRF6v4dVdcseLBV5sl9QmjCagLg8Y+HVSzQRkC3Jz0Y+UpKoO5p9eJx3TSm3aFiR+c6LrzQfSvsMSJjm5yjgva/zFXjDKZRUXIh6VNlZg3kX3n4VD+QwJGNTLXB7SHOrEsgUB+GcHWwoSbIBFeD9VaxpvJxIHIL6j7z3ty5i73TfYfuyXw2BE2R9EG5wiYEuel4LrzRcPO178JZ92RBeuk+A5Va5euEBSXbtYWsb6i6TrS4RHF/rfPoTSuD4I+hTFHq2ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by DU4PR04MB10647.eurprd04.prod.outlook.com (2603:10a6:10:589::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 06:51:38 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:51:37 +0000
From: ziniu.wang_1@nxp.com
To: laurent.pinchart@ideasonboard.com,
	ukleinek@kernel.org,
	nuno.sa@analog.com,
	lee@kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] pwm: adp5585: correct mismatched pwm chip info
Date: Fri, 14 Nov 2025 14:53:08 +0800
Message-Id: <20251114065308.2074893-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::9) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|DU4PR04MB10647:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf7ebec-1576-4fae-0fd5-08de234a41ce
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?yAiRlNT0hGciqb/xmrwwL0Ju43I0rxDFwgOk2t29Iql1lBBm6jJxuj5ia/B0?=
 =?us-ascii?Q?XhCDBiH+CCx4maHbCxGE3IZJNi+kVqT8Tc4SDUwgT/9/O/3+fZ+Ei6MvZyqt?=
 =?us-ascii?Q?l6Vb3Uwin+AYwkZea2nOGtgjfZtgbPgQ2uJJR51RRLYbL3JhP7U4uY3FSWbw?=
 =?us-ascii?Q?5dDekE+GzSvz1cLq9vFU5ryT1Pu2Qh0QlnLEgCtsWvARJe72SwqB3tSPkO6k?=
 =?us-ascii?Q?OUboW3ixMCTE9Ns6RJFXf75rl5+D/vWXGB0qUZ3JN3n2aVuNGsgAFJD0/JHI?=
 =?us-ascii?Q?/txqYZ2VzyZh6TtnazkUZ9RpeBCvvKt7JAQ9AxtFyrDFxm7mqNXWV/H0fDjS?=
 =?us-ascii?Q?VkWAaOk0X6jnsXuhIp2+gXfsH/tOBpFTFMKTMd8iv0UZccfeRTQhuMa8J05q?=
 =?us-ascii?Q?RRoN6XLKaezGN/UVRF3dPybVZ/HWxvA18b1qQz+aqfA/dnzZi7ejsgjH9S7I?=
 =?us-ascii?Q?XTSxZ557+m8oC39kMUAqERJ1/cdnWeky9UCsHf3/n/e5nv+mviKgObJud8fy?=
 =?us-ascii?Q?gNJsDKI0xJEqagGHJxwUd0YGnLPHCFYx7A1A9r1veofsEKlbLuWuw9Pan612?=
 =?us-ascii?Q?QLfOlNEXnTH/95fJNl1yYfLGUc10OrdjkdTUYE1SXOuBtJtmlHcvNwgpqfu1?=
 =?us-ascii?Q?x4UyrqcD7PL+DpGZVff7yhOcJez8j+V0wsyE8obgKNEB3THUx0Ye1Fm9gQfB?=
 =?us-ascii?Q?HGmbIh1qT8wgy5MzbhEM3KpKSLf/IImcVzFu1NWvgPvtAtqOnO8LiwTyL1/6?=
 =?us-ascii?Q?2wv1OmYt/wA31J50W2zRkHqJycEZB+7ydAncvYrYR+fgS0KbnA46tJoGa6ja?=
 =?us-ascii?Q?imV6pMA8mKFyZuNDWVMKxtTYta12Xw4iC7H5WZ2q2sXxkDSfO+Y+vQq1yuqm?=
 =?us-ascii?Q?wFeOIVcMW6YNlkAMrabaBkaqvvtJZu2mLSCZdi48B48FEZzmZAfXfgXD1LFc?=
 =?us-ascii?Q?K5ADOcyp1nnLvNRuDTMGy9GFHNeNDnFcPIJSbs0Q7YzyiZQoK/CfkjYwfkfw?=
 =?us-ascii?Q?R5DpHWGv3WwDmimJkGylcOw5qzwBrE+ns2VfaD06sbRvZNn0qfOlIe56PHaL?=
 =?us-ascii?Q?JNx1StWecbzI183lPhRzS2Tl3W6lMVKJVy7I36cLFNsoCVvxwmyXtQAqfBOj?=
 =?us-ascii?Q?KUXteryFdzHeOmfChgr220DBW2pc7L3IvJIhsp8/J6NkFW1yewC3KiDju+HZ?=
 =?us-ascii?Q?JDP1jnu1AbtBwShWQX/hJ8fiuK+XdMKS16nHXYGTYeugNxwfgcnswGxrElmv?=
 =?us-ascii?Q?T/9lzsuPbOdVAsbBTunOXiFmn5+/t3C1jJ4gVm5sUEWCOvOATVfW22mrSaNq?=
 =?us-ascii?Q?up9hF/IWb9awIdZHJZhNlKFLXGh3gzfY0rb76a69hLY/w0MA88uHH/YM/LMa?=
 =?us-ascii?Q?v1v3fpZ9QVfr7H2WgOxgFioKe9hpTKd4f6PYhRNTHgUtnIYkTaSbXTsxitRM?=
 =?us-ascii?Q?80zjEf7KebHhEOAbFTgltKDwjbNu7vP1QjxkPfg6wxqZFVJKPMhOjOISEl8J?=
 =?us-ascii?Q?FmIQ73wUWP4lJZuLnpuQ3EFJiXYIVtWLXmp3?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8567.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?7bliIc31UHMaBXu5gcieput4vhjF/sDAHdL8LJAnYWYeTaPrjf7tkSQfd7Qw?=
 =?us-ascii?Q?BQp0bPtnX9PxPyEKLHxlztPqYBAZQemobsz1GxCYk1PJBFhZ62lY79ukdRzO?=
 =?us-ascii?Q?egHlZI4oTB4A/HWCaf4ELP1l2fccpuzksT7ge3kYaUEK4EzT7BPU19/MADOR?=
 =?us-ascii?Q?pDGaV0GUVeTzcE+YIUGaC4dBsmL1yzJQlGP6017XTkocnfvNA5GVT5Sk/ZqX?=
 =?us-ascii?Q?hzxezRTokif3NUOxc7u7ob+7UgawXbHKXcaFU6Rk8K7x65lfdvHphZO6fvKw?=
 =?us-ascii?Q?XOF/qarz8CziSbEypR+Ex0gOGS3BB5LkEFQ9NvGg2HgWACCkmXlXXvi43+PO?=
 =?us-ascii?Q?9OhSgnDcVAIzafa3FNKq0doAui/XDuhaJdiT9x6a+2QWCEKkdUn/26qDomB4?=
 =?us-ascii?Q?XB7vhL7SCJUgdu3aGB9RJs4ZX0aPSMjSrzD/fIPAUy7K8cXI030Nn8PP0Iya?=
 =?us-ascii?Q?8ODVuDzarFZeRnLK64ZBLI+04DTXLuiKOuWYuAoQE3w55bC6E1fSXPwCnIwQ?=
 =?us-ascii?Q?1WYaTDTiWkM/5r9uAnsW6B3p1iXrhHIjAMFHEfXcvXcZE0/Jqj2tNwEdU++b?=
 =?us-ascii?Q?pwmnDXPv7BOTefQxJ7NpR7EO89XJJ2X/+7uYInyh8d9r+ZffEEylEe0MpIEK?=
 =?us-ascii?Q?EoI23IQpzRGAMHM+1XqCltWuJA104bpzEMQ+0gMC1hLY8Ty1/St/sAxPjTzv?=
 =?us-ascii?Q?n1qBYoDD13QpgXJTcDirzsj2mHFHv66cMbB9HGGBdbuC8P4AXuMWCc+MjjP0?=
 =?us-ascii?Q?RRN0QxnvQkUa6pQwqM9BaNP4Ev/ZmNi0UajRehRR5FCh5wG8EtGWb8qze0Ti?=
 =?us-ascii?Q?wXcZ2rKa1IhFKCOB9Qgguh1IeI2E4Wdaj1BnnNbkc9CJy0retJ7cC9osOKrH?=
 =?us-ascii?Q?egD83aqYzIsACzSILq8C4OVzUYXh5vic7Kh4yB/DL5xykD/iRnx9SH7ZIp/H?=
 =?us-ascii?Q?WsDy1IaRLhgme7o7gORoxcR8k+Srd3P7NLOJ7vPyviv23khZRvmz3SSMXc7m?=
 =?us-ascii?Q?ZFvaMiVpDmusavQBhcRlA/QfTDInK11tLJlzyCe54dwhCkOWf5e86KOXVhvU?=
 =?us-ascii?Q?rO0jWnequW+qhmAlIie2FzanSUywu/GHupouKezPf3KRhuaoSBXRjygfAlu6?=
 =?us-ascii?Q?f/obppk6S1gcx0OqOZB0Y2BeMRq85MdjLSiwufMVvVJfvc9rrLD1aMPNhmu4?=
 =?us-ascii?Q?LtEz1fa1+ZtIf+sE8k1yUW5vivuJpgHYgO9+yVaBnfp9QQQbsIdPbG8P7v6p?=
 =?us-ascii?Q?wE/fjIwLOszBMBmzcWHVssV44T7TJbOqGzcRMvvBFI3isEAddCYFHM6N5UfG?=
 =?us-ascii?Q?yRxKvAfkZnS97uKQOfYprn7iB0+FoOitoX5857sGEYvn30QNnIxpGKUHPWXW?=
 =?us-ascii?Q?YzEhLNYHdkWuYjwjjbANG4sqkejhJzQIrJ+5dRIvwaV7f93Bscq8xnAkXyuG?=
 =?us-ascii?Q?8K16CfuR8SKj/ztkiZC1NJtKodt4wxRH3jeCqsafrtfcWK3j+MN9Wkm7THKs?=
 =?us-ascii?Q?Rng8JL+X/XDYI09BmBclfK8QY1evRf07oI+vhZHOwDXL9sKK2IylMj0XeTMm?=
 =?us-ascii?Q?vJS++8fHn2bR+WtzalNth80wW/hNKgNw9aPoNbC6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf7ebec-1576-4fae-0fd5-08de234a41ce
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:51:37.8273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0QTitcxJxyYyDR1KQqI+hgc38/iE6U2zSBSxiYfw2vcRv6kFJPaQ9yqe5agH9Wh9FPP8jj5xyLUjbpIBbMtnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10647

From: Luke Wang <ziniu.wang_1@nxp.com>

The register addresses of ADP5585 and ADP5589 are reversed.

Fixes: 75024f97e82e ("pwm: adp5585: add support for adp5589")

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/pwm/pwm-adp5585.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-adp5585.c b/drivers/pwm/pwm-adp5585.c
index dc2860979e24..806f8d79b0d7 100644
--- a/drivers/pwm/pwm-adp5585.c
+++ b/drivers/pwm/pwm-adp5585.c
@@ -190,13 +190,13 @@ static int adp5585_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct adp5585_pwm_chip adp5589_pwm_chip_info = {
+static const struct adp5585_pwm_chip adp5585_pwm_chip_info = {
 	.pwm_cfg = ADP5585_PWM_CFG,
 	.pwm_offt_low = ADP5585_PWM_OFFT_LOW,
 	.pwm_ont_low = ADP5585_PWM_ONT_LOW,
 };
 
-static const struct adp5585_pwm_chip adp5585_pwm_chip_info = {
+static const struct adp5585_pwm_chip adp5589_pwm_chip_info = {
 	.pwm_cfg = ADP5589_PWM_CFG,
 	.pwm_offt_low = ADP5589_PWM_OFFT_LOW,
 	.pwm_ont_low = ADP5589_PWM_ONT_LOW,
-- 
2.34.1


