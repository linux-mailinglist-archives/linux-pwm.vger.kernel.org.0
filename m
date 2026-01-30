Return-Path: <linux-pwm+bounces-8022-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGb4KdjCfGmgOgIAu9opvQ
	(envelope-from <linux-pwm+bounces-8022-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 15:40:24 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 220A0BBA83
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 15:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 301383048BE0
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Jan 2026 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBE0320CD3;
	Fri, 30 Jan 2026 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ETZxcdMf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9C2350A36;
	Fri, 30 Jan 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783903; cv=fail; b=rOLlRVoaUBbNONmhn8ZvkQBWdW93rR2J9EjQCH7Z8ZESiHHKQtNKfP8z08c+X02SzfHzF3fzWcunRENE/c5OH/YHRM4jClUUVH14SgEBqm6C1fbmgeq08F1MXbICHNOssih3Qs5Y5w9LEEjz4Ay2qnUViFDTHSVxWMHMz6ok91w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783903; c=relaxed/simple;
	bh=r2Orm+Gd3jsS2hF5LFX/T/n1jR/0/ApxkJ5IDtnSACU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fcoGPFNPITcyhJrcQsUL5+wjIe3xaQ/gnfZng1Ubro4lNRfcZfKF/REiLyz2hHtItTJcpvkzbPwG6ZuFJwvZdDaB6Cv8BWKIr3TaShey6sfiqXupfYe42A04g4Fnq2N2VCg2F5OyfVrl9AvvQrE08EdnIxYM+aR+SGH4wALWzQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ETZxcdMf; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbXBbA2TdIrS5NHL21GfHV9yyAc2pfhCnYzbvSL5YD3Lj4nTBvXOogFUgACV68WwS/gA2yyDdzyE5bRl3ys/WDUxzD3fA16+bCo5hjIFqyi86Ok2URZ7LYUdDL0iXaQquSNAoRNshEhYiWZasUxN26i8f9Z//ejExY4xydXZBWl/NtX6ckTG1ZYTrYQNmGoe3enhYFA62cMMxcCZ87j01BhwS9WeWGSX2fkV9r1fQy/6Pk/aWuz+zAjBONlN2gvfizzHhFcHOhXHXEIRELtyaeFd74LMcpuwpMNk55JU80vmMfb1ILlRqHGOq3Rfw8ydRSO8pVgN/A1wV5I2D1zYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MB4QD/6of8gOS7vFQIOLgVqgYUZMkTloRw9ra+Btw64=;
 b=DLoUI3SfMsOVxbJxT9cOM2SFIganoi0++dvBw86HRN7brNuznrVGL0IqcVEbOS9bTZ5tf14svKq1Ca63D5VrdgSzy36z53c0b4P2rv/1fTRFuegYdrTIktmB1Lk+KemtMxMZGQfQ2yLnoL0uGJ1v+RDfGex7ENG8BNQzM1ntvtBRiuu52p9P6ClywV3lozCpKHV+wjLhZbcXfC5MJXcHnEk3dK5lrC1RxJsU9czFcdQSyCr5ByItdbfx2d2pNDMEbDIv3t1m6B3KR/SPQ8Ivg1SA82tqGaoQ/hpDq7IVtsZeBvBCI8YHimjWR6y45qlVg55j4QLMdUiNXUTxJYEaXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MB4QD/6of8gOS7vFQIOLgVqgYUZMkTloRw9ra+Btw64=;
 b=ETZxcdMfwbf6hzpW5e9NezXDMTmJJ5DntDKWJV0VPG1ypA1KTLjlflRP/aRn0AmoqFaBVTw/FngZAEHhDZS7VyVepzEiss7nMp3AZOG8tPhheSgQAzpqHUkVSIMHFckp67umlScvFUsxN6U369PDrxSPvlaQdvwUWizIxdNfhYzitgutIEB7PgNkP8F78FVoMr1Y9O0mzpMqJwUlc8yh3Lzu2MWaxqYWJrdUkQTZOKC/gT/etJE2bqb1nPuGShbfvmI+e3oD9WWZj7xaSJZvW0j0vkg60h1mGbDafjUBxOtErCX1jnNoIbKuLZy2TKP7dGRf6Af0epfHTIUrfJty5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5112.eurprd04.prod.outlook.com (2603:10a6:20b:10::30)
 by GV2PR04MB11740.eurprd04.prod.outlook.com (2603:10a6:150:2cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 14:38:14 +0000
Received: from AM6PR04MB5112.eurprd04.prod.outlook.com
 ([fe80::a348:65cc:67d4:1fd7]) by AM6PR04MB5112.eurprd04.prod.outlook.com
 ([fe80::a348:65cc:67d4:1fd7%6]) with mapi id 15.20.9542.010; Fri, 30 Jan 2026
 14:38:14 +0000
From: "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-pwm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Viorel Suman <viorel.suman@oss.nxp.com>
Subject: [PATCH] pwm: imx-tpm: keep channel state instead of counting
Date: Fri, 30 Jan 2026 16:37:20 +0200
Message-Id: <20260130143720.778514-1-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR10CA0020.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::10) To AM6PR04MB5112.eurprd04.prod.outlook.com
 (2603:10a6:20b:10::30)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5112:EE_|GV2PR04MB11740:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ddf1526-115d-4c52-d384-08de600d3347
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?WRfkCoJRVr2NmcKGarR0Y5AUgVnOMXgwlkmKhMf2KPYE0S4z47iK8X/yln?=
 =?iso-8859-1?Q?RdCRtd6AC9/6/YC+3fQFke4ibaHpzFIZAQWc6vrz+JG9pyyv48/dGqcYQu?=
 =?iso-8859-1?Q?N4O4RsMLmr6zlYYvigt98IXmli+gZkpSW+5xRLLqzEA8r5gAKfgHqmCJ0P?=
 =?iso-8859-1?Q?ExgES2a7/F6yYhAUTu9CSiLZaWOVwnylMDuVq9aqMOMtuTmxtafw1hZrYO?=
 =?iso-8859-1?Q?crDbsFEQEyQuqjZaLKAE8uRP2ViCUpTMsODriD3cxkmthQlyG4uirUWtHh?=
 =?iso-8859-1?Q?xBEA7pJ6uSjTr8IiKe6C0NYfoKeVB1f9zDMBo7podNbq2L2/3210KUvC/g?=
 =?iso-8859-1?Q?IUPl7dyjcVnNPQeepKiqibbsRtVEd6srExAq/hPsV4QKNpY9ocSjyekb2S?=
 =?iso-8859-1?Q?0u+oqzWgW+65lVvAUyTW1wieTtYjPxotvFvboNlz9Be21fEKZzWjY1whR8?=
 =?iso-8859-1?Q?xy4hleC2+GjFSZKHU1uwF/7RAW86XAaoQL7ImoW3DRyAXTQBebNQY0KrnB?=
 =?iso-8859-1?Q?DiQMcAPTbHF7y2aKGL42UGhW983LU5n0TxFyc//2jntSRkIXmnAREDgIa7?=
 =?iso-8859-1?Q?343uYvq7AeiC+iFopleANNPOanAOAXupVAZw8erF1zkUSDBrR+Y5qY8geK?=
 =?iso-8859-1?Q?cxYE5n/iYrKCv9bBcuIyzeiS0sALpO9vtPXQBvVKsQNsipUjqsdej4w5Zx?=
 =?iso-8859-1?Q?nWrqA/EjlnmP/cReFg6HpivBHxbSFYc41T00Wv5Qe8hEEk5ekm5OBkn3hw?=
 =?iso-8859-1?Q?TTEBQBXxSQPJEXCOFibARQj0IKIaaMCuxwV9hooiLZueMOAsmwN/XLxMNn?=
 =?iso-8859-1?Q?AnzEj27zlEAjMLsF2ID7ibQkLIg9yXtLbaaij5hDy1a3CxlUFAUfgSFlwT?=
 =?iso-8859-1?Q?vvx/jTL8dI2Z1DxwtBVf3/DQ/6/sqptxRkO4fabVPtCQLuMB4NHbKuaNc7?=
 =?iso-8859-1?Q?wbgPGgPVJ3u6NImw+cZFjWIEiNVgzKbzl4mb2gTKGIoWjHbOuR98YU3AN6?=
 =?iso-8859-1?Q?HYXAFPJNSN4JcNlntwhJVkzwZOdW/nifl1/qYt1r7ARbdFx5G+0laJjDjv?=
 =?iso-8859-1?Q?EC3I/j7o/cfKJ2LdN3ZBEKrWWzT+EznUgLlSFfkI17Ur/Y6ob/nUnCtdrP?=
 =?iso-8859-1?Q?XXvQ1sJ6Kl3IpUix0wldef+VxdIAdXla6rf0+TJoIuJd6PTyUzmP0ltDhl?=
 =?iso-8859-1?Q?7VH8JtUPpkrkfBKiQsJcLaW7TCLnjrHXpG9zQaVvM3XIV7TK7NY1VJKqSu?=
 =?iso-8859-1?Q?liLVhWuW4PhYPK1WLDdQnWkdCmII62qjGLHkCh0r02RFZLVvsid++xXREz?=
 =?iso-8859-1?Q?4yGDJQwOiQO7weZLT2zMGd2n+r72VpLdVcU8zl3PhKUA/kW/NUDeKzY6tE?=
 =?iso-8859-1?Q?UamHA2IDlM5RFRunR5aKm6ZWMZd+X+0WBMMVwb7jWnZXDYo4kOhgj11gWI?=
 =?iso-8859-1?Q?DGiN2HudPJU0hzUAZTpdxNELazKwIRoREr+VGL8+Q1bt7kCvN9lj8yM0LI?=
 =?iso-8859-1?Q?d0D0Z7tyysYmoskRjriwybhVJBJiX92VDgRV2UcoOsvvZldeRddl9IA1ap?=
 =?iso-8859-1?Q?7fH/CfwnTIJ0Tejrp6hA915SnCfV5aR0k1CwDN7MGMpvL9vJ+F9CbEgS9o?=
 =?iso-8859-1?Q?yp5zBYR5cyjV7cNEknLFob/+SsrqtZ18bJawSgkb2qvffEKytWUcS4S0EP?=
 =?iso-8859-1?Q?DOS6X8RRjTQZgvhXMsY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5112.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Moh9Oyww3OQe/dQ/hs91HwkIrB8KimiwDXtw1Hshv93DpmZi3rSiZtCONl?=
 =?iso-8859-1?Q?8WOlCBsTYM432rAG9k2ColOl4o89DXzsheq1SjkscxCEVFQZzjk/0GE5+u?=
 =?iso-8859-1?Q?yFMgp1p9WVmXj1udZqnm20Tbrdf8ueAANF/JLEzNIgJp09Krg+ksZnCiTJ?=
 =?iso-8859-1?Q?SYWFEcOvefwSz4FNEV0DIdOfteq6uH+TmYJOqg+HlPlYCSvTHS3ctBb6ze?=
 =?iso-8859-1?Q?vmvA3A8G1VhGXA0evKXbvnpphdL1Ah+YG5qdMvKAELcYLK0EZzqezZnsKy?=
 =?iso-8859-1?Q?SEyQm2Bd3fyMou5BgPXgfhZS276suKvxShWxvHiFvUTSOOJNwYmqZchUr2?=
 =?iso-8859-1?Q?BzSdnZqS+G/SraCAqnZLcj+CJytksb9wGRcaAl6QwOyGWHKIZdWSs5TjSg?=
 =?iso-8859-1?Q?0bmTd9nQuwIDQ/KlZXeUnIAM0toQaV91jNUmIpONTfqItGq3sSb2ZT4hJd?=
 =?iso-8859-1?Q?iAoADomwSSAFP9QlN82Egem/j+K+Prm0NRjigIDUhKtqHueWRlEcx4LYaN?=
 =?iso-8859-1?Q?bhmUqP//9cfsMOAUzblANh8owANNLq4JDk2ZYCwRTL/HKFlSZRuBUhsZfZ?=
 =?iso-8859-1?Q?oUG7xywfLsgo/dB2igTGSLv0pRcccV3xCUDQ8CGKOlcvN6YtTWZrTOYC1K?=
 =?iso-8859-1?Q?ftGTvm1exirT+J3vqu0RNNuaqSf3acw+bc5kziL9ilIWNA0/jgSOAzwruo?=
 =?iso-8859-1?Q?VLXKtJkbKjMbIq2mr+oGRGYdZMpwMIXdAr3SOLxEM2H2zaZme+65YRCyEC?=
 =?iso-8859-1?Q?XTwtzXBOzL7dvC22rjhEvxOy/UlSPn0FXEDxvEPYopJzMZo23uNvni/0yk?=
 =?iso-8859-1?Q?bVyxNYS9ODgRE3V7t82xJf8Gwu3GIjFLDKS+VF1PKIJxCbuC6FOVodZDop?=
 =?iso-8859-1?Q?YoCgXkCENB5zy5pR1vEjgyH1iq4u2q1aQdhpyItCJF547PnlHH0iWpWTvt?=
 =?iso-8859-1?Q?g/sAi+WR2HQH64tQGlYrdUoryVcltTjYXiaiLn4dqxOTyO2sxAVIL8+UJq?=
 =?iso-8859-1?Q?gWES+cpsi8f1LMxu8SA78MysLoud7/OYujGpdnOEVQZZGV8BxeteWzY1L9?=
 =?iso-8859-1?Q?A3HFJvqPHlFM5QdcVAc0aa6j0yqx8Mb2iijDhnSwJYjmjvqDJispqVjC3O?=
 =?iso-8859-1?Q?F3PlbNpoEPrTXiHJ6VwNPUL77CDu0uf+shltLvrOtdOiYpTQsLbOfHkP01?=
 =?iso-8859-1?Q?gHCtMl7Bh+oX96daRm3ZRQlS78jiB5BLjbbysFU+lh15TFXxKToWJHBOYr?=
 =?iso-8859-1?Q?nPbUP75UAeJX7XnfiTWHmXbLwPuJmmzLTsUHroJMI+Y7tHvAJneCv3MSZC?=
 =?iso-8859-1?Q?EMVX+NMnBa3rcwYIRjc/KT9B2mSKQvv/lQX2JkLOdmPHDyx9pDAwO3eIe5?=
 =?iso-8859-1?Q?zD/8V38idv4qHyBtssa1conZBSfLLqaT4BcMiE9SPOf1S1/wujGLyMtr1k?=
 =?iso-8859-1?Q?qXyOqMZWxS1QLJFkXcWGaQvZGQBvhi/0qfh2IthPBVNvuTPN3Y3mH64+Rc?=
 =?iso-8859-1?Q?vDVUr7rWnB0+8IncFoMvhMcxLgULCPKVyq7dscpZ+pxynSDSgnFXXLB9U/?=
 =?iso-8859-1?Q?pHOmug/wzpQE+WOR5gu0kBSc4JwuoRSEU0Huu/h5uMmwyWL3Fb3W2inJfd?=
 =?iso-8859-1?Q?l75T4Uzp7dol2IGWTfzrwPNFFFYWO5QzQQZ9UGTHC47EREZjGdu2FPiwTa?=
 =?iso-8859-1?Q?pcqF18fhXY3dlboKUcAi2E73LlDPyjhpU25svh0PqDBn7ATYybIvE+cmZv?=
 =?iso-8859-1?Q?Vn7VOWrCMxU71RHTjrhv/VOLbRd0GBdK5CFKDdggz5i7XEDdNKmaorYnEf?=
 =?iso-8859-1?Q?W0KEW2SPow=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ddf1526-115d-4c52-d384-08de600d3347
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5112.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 14:38:14.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WVnmUQaeC3c++AKFgV59Ft/UHta3PfJeLh9xyPX0AJoMYtgLyTN6LYSvWovRsEeKRaNrS7Ew49liy9bKx1Zvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11740
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8022-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viorel.suman@oss.nxp.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,oss.nxp.com:mid,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 220A0BBA83
X-Rspamd-Action: no action

On a soft reset TPM PWM IP may preserve its internal state from
previous runtime, therefore on a subsequent OS boot and driver
probe "enable_count" value and TPM PWM IP internal channels
"enabled" states may get unaligned. In consequence on a suspend/resume
cycle the call "if (--tpm->enable_count == 0)" may lead to
"enable_count" overflow the system being blocked from entering
suspend due to:

   if (tpm->enable_count > 0)
       return -EBUSY;

Fix this problem by replacing counting logic with per-channel state handling.

Signed-off-by: Viorel Suman (OSS) <viorel.suman@oss.nxp.com>
---
 drivers/pwm/pwm-imx-tpm.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 5b399de16d60..0f8643f4a70b 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -62,7 +62,7 @@ struct imx_tpm_pwm_chip {
 	void __iomem *base;
 	struct mutex lock;
 	u32 user_count;
-	u32 enable_count;
+	u32 enabled_channels;
 	u32 real_period;
 };
 
@@ -166,6 +166,10 @@ static int pwm_imx_tpm_get_state(struct pwm_chip *chip,
 
 	/* get channel status */
 	state->enabled = FIELD_GET(PWM_IMX_TPM_CnSC_ELS, val) ? true : false;
+	if (state->enabled)
+		tpm->enabled_channels |= BIT(pwm->hwpwm);
+	else
+		tpm->enabled_channels &= ~BIT(pwm->hwpwm);
 
 	return 0;
 }
@@ -282,15 +286,19 @@ static int pwm_imx_tpm_apply_hw(struct pwm_chip *chip,
 	}
 	writel(val, tpm->base + PWM_IMX_TPM_CnSC(pwm->hwpwm));
 
-	/* control the counter status */
+	/* control the channel state */
 	if (state->enabled != c.enabled) {
 		val = readl(tpm->base + PWM_IMX_TPM_SC);
 		if (state->enabled) {
-			if (++tpm->enable_count == 1)
+			if (tpm->enabled_channels == 0) {
 				val |= PWM_IMX_TPM_SC_CMOD_INC_EVERY_CLK;
+			}
+			tpm->enabled_channels |= BIT(pwm->hwpwm);
 		} else {
-			if (--tpm->enable_count == 0)
+			tpm->enabled_channels &= ~BIT(pwm->hwpwm);
+			if (tpm->enabled_channels == 0) {
 				val &= ~PWM_IMX_TPM_SC_CMOD;
+			}
 		}
 		writel(val, tpm->base + PWM_IMX_TPM_SC);
 	}
@@ -394,7 +402,7 @@ static int pwm_imx_tpm_suspend(struct device *dev)
 	struct imx_tpm_pwm_chip *tpm = dev_get_drvdata(dev);
 	int ret;
 
-	if (tpm->enable_count > 0)
+	if (tpm->enabled_channels > 0)
 		return -EBUSY;
 
 	/*
-- 
2.34.1


