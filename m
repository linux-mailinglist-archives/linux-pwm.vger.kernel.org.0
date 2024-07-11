Return-Path: <linux-pwm+bounces-2769-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B11892F0B3
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 23:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4430B21D02
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3C819FA80;
	Thu, 11 Jul 2024 21:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fe/Xt865"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D919FA6F;
	Thu, 11 Jul 2024 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732177; cv=fail; b=pJgfDScwDAlqgXaMsjkhgSGLBQeUafnmzv6UDnB4zEG2iMEkpWdF+UEpd748GCGCyUTJVSL+E2eak1Vc/01/KnN3F2Q2ed830xJ0+qLgYkKhjSnTd9Tz4Lj294wVQLM6ezi5/DhDVWEcorl/4dEzDvrwLGcPc0CTEbTnbsfYGkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732177; c=relaxed/simple;
	bh=pT8hto8jasxqRR1wnXTN31s31kljdhdkKl0kbKVulDI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BwRrjfe83KFgNFcmLo++145xTao4b6wwEhzLrGf1sqaDwVDryXuRsEg71TmRoqx+BHDP+9mwTTAiJgyJqAqoocuuTzllP1Ega4iQTCrubfu0myBNlHUEVwwirYcSp5Qw0wI0FXI1EFu5MtVj/q90YxKP68feaF4H8SFaUYbcXo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fe/Xt865; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KafeuTAR3LbqXJKi44CtsyP8K2Z+XsnHCtWADwaj8O5VjpeVO7S8ZhVKXL21SgkGuJLALlom0YjnXsElR1pSx2PFER1AoASxTUxz3gDeLFaHtukMNDDeT8ysueBWgvGXODV71bwfdUG9sUaSHeq0HNng96xrO7T6btYHq/oyyyEvluwR3kaXF8rtVdrbfLFgvTiFC32JrdmdZrw2RtxbXM0O7TxnnpwyYqhkhbftxH73nAWTFkLQVIdF5ZNyGHTGhSqF9z0101qwlqdR9H6Ehi0MqvEQRbrT79/xcdle91pOz1W4xsOPR6KYeyKgNDSzAzDaQ+h1sgdi2Wbe1Ao8qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HgHy2L/wkqbtzM2UW4DFT752rOoDt7Q/Ojbriar/5k=;
 b=TWn3njzPQD8NVT4UlgHYzkBZgbMpZsyxGoc2Uy1gyeppivBoduVZKNqr1pxLMUdugwmfD+qUhGT9ML6WU4Z2GZt5Kqh1aCZEsQ9pv0Y0keGnEmcJKulYjESjPYWZ3V1xhGwY7MS6Mzzwu3M4leIgWVTJc4hyuB6yopsZ2e89wdWMmOOh0G1gJNsleWj8GW1Mxj3+AeAWmAE/rPS7hQqT0pq4ozXauKuSCcbvH68craSy1pddAyptM6gFIyQygeqTv5C5++c19y/+YlxXRvRmYSh1zKFrNeTpvOpeMIoPr6Au65SLSrjVhlHiIwLetlldKqpqIuWdKwp0wD1bFpO53Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HgHy2L/wkqbtzM2UW4DFT752rOoDt7Q/Ojbriar/5k=;
 b=fe/Xt865OxgoRvns35VmkeEu0fVuZMZFDisRgtSU8TkYmc3Bc0kwAsQor+ZBHsCDBl+MKIzOW+IsRidFHyddTeBzWaiWSmQiTeB9/lEYWSXxneHNSfqKSI8j1He96Hc/QjI8Rifre7r6opbRoKBKr2/FaqX0yXZJ+TfWBcEvRyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7915.eurprd04.prod.outlook.com (2603:10a6:10:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 21:09:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 21:09:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 11 Jul 2024 17:08:58 -0400
Subject: [PATCH 3/3] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-pwm-v1-3-4d5766f99b8b@nxp.com>
References: <20240711-pwm-v1-0-4d5766f99b8b@nxp.com>
In-Reply-To: <20240711-pwm-v1-0-4d5766f99b8b@nxp.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Jun Li <jun.li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720732158; l=5043;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=mKhhcEUhL7+dNPFdxDqp7YsAYZUKeNxwZ1WZHGuoG1Y=;
 b=QTOealos7b6dRVB6aSMOlrsvAtwiqbzE/chmVcBvhFVbo4TLav0qni2MX1J6zWcpUjURCLv3z
 JB4fdwQheo/Baup9p9Z5V7F6cPm8JdQ+Kv6zaHVl3UyY/KQRjQSG+Zw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0234.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ec8b9d-b783-4451-5505-08dca1edc37b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGV2UUVWU0lqUll5Ty8xRzR1OVdtVHA0SlJQVzZiMndpbmNnRUlHVHFhQmlX?=
 =?utf-8?B?UGtIcjU4dy8rV1ZaVVQ0S3FoTGY1ZGV3TE5xeWVGaGRpcTF2RHRmWTYzR3JD?=
 =?utf-8?B?UjJoNVZhL21tcGl5UW04K0hGbjc0K3pJNHozbUZyRVM4ZVdTeW1VbVVrNDJR?=
 =?utf-8?B?a1RlbEcxTG5XOStYUW9xbDJLT1NpMjI1Y2tyYmdzT2FOemJySEdYS0lCYlZn?=
 =?utf-8?B?RmdUK29mandKMXBTU1dOYThkYXJmS2liV3ljVk4zNnpIYm50bERhN0t6eHZU?=
 =?utf-8?B?T2d0QkVMYlBrS0NrcFo1c3hManJoSkdQWHRNSmlZVXZnSXNZNE5NSCs0YnNi?=
 =?utf-8?B?ZjJnS3Z1WVd0TzZ0WXVYMHA2R3lJSGRIUCtMTEV2dU5yMmRWQUEwck1lSVJR?=
 =?utf-8?B?Y2FDR05rYXlOZ2ZFQ3lzVWRHbzgyeFdFQ25RN2FTU2JkcUJwaDNpUjl5QzF2?=
 =?utf-8?B?WnpKQkVmVG9ZUHVrK2tGd3ZVdERTNjNEbHk4aFBidEZ6dm5JMFRiZkxBSXpq?=
 =?utf-8?B?WlFyWG9DSGxSR2JJWDdSYVJiVWloaVllUmdZRnFZeElVNGFWT1BkUm5ndlBP?=
 =?utf-8?B?S21qVXExZFNJZE1zL2dXTnZXeHhwdFhpZUE5NDRQcEZESkRza1ZVU0RkSEVY?=
 =?utf-8?B?QVpBNUhITGlYZWtyZi9BY3piV04rT1RzREtEQ2xiaVZUdmNnT05EOE1LM3dO?=
 =?utf-8?B?THlXREdMaE8ycEpBbm1MWTN4aUJHM3lDemJzWkduL2FTdnlzU2lVMGpMVmdm?=
 =?utf-8?B?M2xyaHduVUNaVWw2ekhJbWo3QW5pcUZ5eURiZ09qU1d1Y09Xc2xaeGFtWGU0?=
 =?utf-8?B?NDZKbmtrcWJITVFwakYwTnRYd2pGbDkyeCtBUytKZlhOMWRmcnkwV1ArWTZK?=
 =?utf-8?B?L0o5QkpGOU1TVTBXV0xiOVVEbklTMStXVWd0RUtMZFR2ZEFCWVVTMUdWeDBF?=
 =?utf-8?B?NXRTT050N3grV0pSYmNRMmZjSzRtMlRwNFFrdUZZSXpyZHp4RWdTd0VyVUQ1?=
 =?utf-8?B?aWE1NUN1eUxpK2pieFZlTnhSSUVKWThkOXdFb2lSU2d6YW45cTFUdThXbzNP?=
 =?utf-8?B?YVNzZTBTOFVwNS8vRUJRajBPMEsyV3JxUEdUSDU1cUZ3QU1kYXQzMHhJU0Ju?=
 =?utf-8?B?ei9MNGJ0UlZHR0k5czhiaitkbWVPSXM2ZEVlRmF4NXRKRkROQklQTnR1YlRw?=
 =?utf-8?B?NDdKNk5MN0dVd1lLMXdJNGY2VElQelBhTndnTzg4b0NSb0hwS0ZwdE9hY0Fh?=
 =?utf-8?B?V1N6RE5QbFMweDZTMW50YmZKSE9OeWgvMUsxeWhVajk0Z1RxaGtRRXo5eWVo?=
 =?utf-8?B?dExTZlhtbHhVOS9WUG1iV1F6MkcrRGd4VUdUb21CVzNGeUJzbnF2dExYbzJG?=
 =?utf-8?B?TTNGSVY4U0Qzell4NGZEOGJWbEJoTUdZTCtUM050blVNUEJDbUYrWHEzUnN0?=
 =?utf-8?B?RGJDSzAzaDZlWW5Pc0E2S01XdVlRZkZSZHdwNktMT1pBR28wVEp3Qkk5cXZD?=
 =?utf-8?B?ZHNnUFFQY0V5WEhZQWE0N0d2b2dVZEdPSW9HYkxGYklweHVkbXNsTVB5ZGMy?=
 =?utf-8?B?aHFIL2IvTm9JcTRmN3hkcWhNajVONHQwVy9vV0N0QXFwREF1Y1ZUOVVZOTc2?=
 =?utf-8?B?TkN2Zy9qQ0pWL3ZaTGprWFNlbUY3QWdyRnJpdVlNNzhBZ3UvV3dIYlB1T0V2?=
 =?utf-8?B?Kzl6RXRsOFJIUHllQklXckZyckdKN2hzak9kNVVZRkprRkJackNvdEppaU9R?=
 =?utf-8?B?d3E5U1ZoTkFOSHFEZnQvNnovZzFPM0dmWUNoMUNaZnRtc3p6R05vTHRwY1k1?=
 =?utf-8?B?OWlSRTJBRVdKZ2F2Mk9CaG5iaWllK0U2OGRNalNxMExzUHVod0YzemxPRU9n?=
 =?utf-8?B?c0tkWFJCZjY1L1dvNGJlemRsMXZxRDZzUXIyZ1hLYjc0RWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGNIYmcrWmVVN0VpdHQwazNuWTJBK3ZOdkFlQ1NmRTZuU2Raby8rS0RXZVFH?=
 =?utf-8?B?L040VFh4Slc4Mm9wNS9wdmtjeVlVSkpncDc2YVZ2TmEyemxycERxUFZQV1pT?=
 =?utf-8?B?aWtGQU13clMwUVR3bVRCTnJFQnUyQUlqYnlFejhXMHBxWFNja2ZWZjA4T0pN?=
 =?utf-8?B?MnA5OHpvalZLbGg0UzJvNHdpVkVZZm1TWmNpdlp6SG5ONEtMV2NvUHpOc3Z5?=
 =?utf-8?B?Qm1VSDlnV2pHRk5PVHIxV3J0Ung0dTVyYW8wVG8zS2J6Tk8va2xDekFldnRH?=
 =?utf-8?B?TDFtZTlOSlNzTzJxNFVZcW1DZndtVXFWK1pNTjRCRlhnTlIwZGlSelpjbmZW?=
 =?utf-8?B?b0l4WE5UbitUMS9xR1E0UUFlTExyYlI0RnIrTVhsQ2xSdnA3QzB1b2c3NnRC?=
 =?utf-8?B?eUNNZ3ptdVVDZG0vaHY5ZW5JTDNzb053SWRHRkh6b1ZqUUFFdmZHVElkenky?=
 =?utf-8?B?YXdwNW1rd3dNRXZUODNTS1RkenUxcFRmeVJjaUw2TUZ4bllocFVnYkhwWkdJ?=
 =?utf-8?B?Mjczcm5GM0JRUzI3SkpJalNoa0lZVm9ubEZIWnpIMDVqWEdZYXp6NndOU01W?=
 =?utf-8?B?QVEwdGxkUnlxNFQ2ZGF2WEdEQ2Y2TEt3amVVcGoyLzh3d29sejdmN2IwU2Zq?=
 =?utf-8?B?eEk4ZnRoZ0NaTHhYQk96VVZaYmJkbjBPNkJXeDNmS1ZGZXdZYlZGSkk3S3M4?=
 =?utf-8?B?RVJFNmpPQWVaZUp0RVhjNFNxeldIWDhiNnJZNXlWSWdFMWtYQWdraWh2MWZ5?=
 =?utf-8?B?RjQrR25icUZKT05JYXZHTi9sZFVNTElwYkZRZlQ3ODFyWFhPSlN1UldDQ2k4?=
 =?utf-8?B?anFkUDNJaVBMeldSUWlzZDR3TDhGWVljUnVPa3o1RTBTaDNId0FjMUMzUC90?=
 =?utf-8?B?TEVDcXdsMFNmQWxlNEpLcW9MS3JVL0hMNk9WWllXVFVHMU9FUzFFKzlNWVBq?=
 =?utf-8?B?ZVhEMy9KNjBQU2tzTFJHQ3dFY1Z0ZlV2N000UHI4dXdVWGUveWlTYjY3c0Zh?=
 =?utf-8?B?aVduUHh6bW5aU2g3TjZWNUJoSWlMZDVEenFwdU11cFJVeHFoUTlXNy94RjZw?=
 =?utf-8?B?TVZxYmRRRzdrVkd2bVBYa0lIYUxIUFk2QWtFd05aeHFBUWpVblFDTGNGWDNi?=
 =?utf-8?B?bkFQK1MyQkdYaTFZcXc1MUl4Y3lUN0tkOVZNTFRmdlpZOGJOVGNrSTVSMllN?=
 =?utf-8?B?elc2ckYyS09rWmpzRDJPSXBPbFkzTEduSk9SS3pKZ1lLMzRQWEdjV1NHNkRQ?=
 =?utf-8?B?bVRIYktZM1lmaGRlZkd5bkJwVjZ6SllwWUdBMTdVNkh5aVFUdzN0L2Y2WUNj?=
 =?utf-8?B?cUh4WndhSEdEZU4wVERTRld2bGJId05WR3dQUU44VEs2SndyN05CUC81RCt4?=
 =?utf-8?B?aWJGWExCTUUrRDVYUUh2bElRb2I1d3VhNjBSdlZHbUt3Smk3TkMzQ3QyeFJi?=
 =?utf-8?B?dVAyYkNIMm5pbGxKbFFhSTByMUhHQXltN0dKZzRmbmRLUkJUeFlYMkpFODg1?=
 =?utf-8?B?VUozVVkzQ1RTdzhPTHFIUWlwSGkveEVwT1lWYlJnR1dzaFBCTk5qdWk0cjBP?=
 =?utf-8?B?QUF5b2o5UEk5aC96bHJISy9YUUZMOU8zQ0s2SDVuSEVUaERmbXFGVEpXR21u?=
 =?utf-8?B?aUdBU2tmZ0VUZFRhb1Q5QUQwVlNQS3lhOFB6eWZlaGpUamtpKzc2ai9MdlFB?=
 =?utf-8?B?VVVRUm1nTnlGVFJ6eXY3RmptMVBVc1dEeFdONFVtb3lpSHgwVWV5WUpXL0s0?=
 =?utf-8?B?bkxlRms2aVVYenFrMHh0bkpSK1lOTTZ0dCtSSm1BR0p6OUxJcVN0cmJmUy9G?=
 =?utf-8?B?b1dtNjZFYmpmWXd1Ylh4Vm44N2tUTmJrVk1ZMUxoVDh1WlAyWi9MSnk2Uzlh?=
 =?utf-8?B?c2NWais2bVJXSllsZDAxS3pmWmw3QXMraTZSb0VGNkM4SWhIeGRteFZHa2xv?=
 =?utf-8?B?ZDN2VFhQVlpBS1RlaEoyWndLRHc2RGE2enAwY2t4TTdhVkNweWdia24rbUpm?=
 =?utf-8?B?cyt2UDQ0a21xWUpsRkVPK28yVjdaZVpmazlGWXgzbWNoUUt1TlBFcHUrTUUz?=
 =?utf-8?B?aWE4Q1M0UFIvTzhoczBYTkQ0UVRaTEdrckpBUHlJL1h0ZHplRTRDMjRjK05B?=
 =?utf-8?Q?KyJItNwy4Yn2G4zVJFELGx+tc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ec8b9d-b783-4451-5505-08dca1edc37b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 21:09:33.9473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BI1YD+Ndd9oUiXpTmVf9U5Hfi0CAQn7kJEJlC5sgkK2QG7dgy2wp9Eh2eUU9CYolrUfTAVO/whprv6hSOeXbEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7915

From: Clark Wang <xiaoning.wang@nxp.com>

When the SAR FIFO is empty, the write value is directly applied to SAR even
though the current period is not over. If the new SAR value is less than
the old one and the counter is greater than the new SAR value, the current
period will not flip the level. This result in a pulse with a 100% duty
cycle.

Write the old SAR value before updating the new duty cycle to SAR. This
avoids writing the new value into an empty FIFO.

This only resolves the issue when the PWM period is longer than 2us
(or <500KHz) because write register is not quick enough when PWM period is
very short.

Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pwm/pwm-imx27.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 032bce7d1fdd3..b817d73effc93 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -22,11 +22,13 @@
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 
 #define MX3_PWMCR			0x00    /* PWM Control Register */
 #define MX3_PWMSR			0x04    /* PWM Status Register */
 #define MX3_PWMSAR			0x0C    /* PWM Sample Register */
 #define MX3_PWMPR			0x10    /* PWM Period Register */
+#define MX3_PWMCNR			0x14    /* PWM Counter Register */
 
 #define MX3_PWMCR_FWM			GENMASK(27, 26)
 #define MX3_PWMCR_STOPEN		BIT(25)
@@ -92,6 +94,7 @@ struct pwm_imx27_chip {
 	 * value to return in that case.
 	 */
 	unsigned int duty_cycle;
+	spinlock_t lock;
 };
 
 static inline struct pwm_imx27_chip *to_pwm_imx27_chip(struct pwm_chip *chip)
@@ -220,10 +223,10 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 
 	sr = readl(imx->mmio_base + MX3_PWMSR);
 	fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
-	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
+	if (fifoav >= MX3_PWMSR_FIFOAV_3WORDS) {
 		period_ms = DIV_ROUND_UP_ULL(pwm->state.period,
 					     NSEC_PER_MSEC);
-		msleep(period_ms);
+		msleep(period_ms * 2);
 
 		sr = readl(imx->mmio_base + MX3_PWMSR);
 		if (fifoav == FIELD_GET(MX3_PWMSR_FIFOAV, sr))
@@ -236,8 +239,10 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	unsigned long period_cycles, duty_cycles, prescale;
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
+	void __iomem *reg_sar = imx->mmio_base + MX3_PWMSAR;
 	unsigned long long c;
 	unsigned long long clkrate;
+	unsigned long flags;
 	int val;
 	int ret;
 	u32 cr;
@@ -279,7 +284,50 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		pwm_imx27_sw_reset(chip);
 	}
 
-	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	/*
+	 * This is a limited workaround. When the SAR FIFO is empty, the new
+	 * write value will be directly applied to SAR even the current period
+	 * is not over.
+	 *
+	 * If the new SAR value is less than the old one, and the counter is
+	 * greater than the new SAR value, the current period will not filp
+	 * the level. This will result in a pulse with a duty cycle of 100%.
+	 * So, writing the current value of the SAR to SAR here before updating
+	 * the new SAR value can avoid this issue.
+	 *
+	 * Add a spin lock and turn off the interrupt to ensure that the
+	 * real-time performance can be guaranteed as much as possible when
+	 * operating the following operations.
+	 *
+	 * 1. Add a threshold of 1.5us. If the time T between the read current
+	 * count value CNR and the end of the cycle is less than 1.5us, wait
+	 * for T to be longer than 1.5us before updating the SAR register.
+	 * This is to avoid the situation that when the first SAR is written,
+	 * the current cycle just ends and the SAR FIFO that just be written
+	 * is emptied again.
+	 *
+	 * 2. Use __raw_writel() to minimize the interval between two writes to
+	 * the SAR register to increase the fastest pwm frequency supported.
+	 *
+	 * When the PWM period is longer than 2us(or <500KHz), this workaround
+	 * can solve this problem.
+	 */
+	if (duty_cycles < imx->duty_cycle) {
+		c = clkrate * 1500;
+		do_div(c, NSEC_PER_SEC);
+
+		spin_lock_irqsave(&imx->lock, flags);
+		if (state->period >= 2000)
+			readl_poll_timeout_atomic(imx->mmio_base + MX3_PWMCNR, val,
+						  period_cycles - val >= c, 0, 10);
+
+		if (!(MX3_PWMSR_FIFOAV & readl_relaxed(imx->mmio_base + MX3_PWMSR)))
+			__raw_writel(imx->duty_cycle, reg_sar);
+		__raw_writel(duty_cycles, reg_sar);
+		spin_unlock_irqrestore(&imx->lock, flags);
+	} else
+		writel(duty_cycles, reg_sar);
+
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 	/*
@@ -348,6 +396,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 		return PTR_ERR(imx->clk_32k);
 	}
 
+	spin_lock_init(&imx->lock);
 	chip->ops = &pwm_imx27_ops;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);

-- 
2.34.1


