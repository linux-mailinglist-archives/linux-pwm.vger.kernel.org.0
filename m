Return-Path: <linux-pwm+bounces-2767-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D5992F0AD
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 23:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F39281E30
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 21:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACAC19F470;
	Thu, 11 Jul 2024 21:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W5xEZhXh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F019EECD;
	Thu, 11 Jul 2024 21:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732171; cv=fail; b=k67EvO4VIx3SoGY8stx9LOJlKVGYW2Z2RbwLO/xZYzcaQCvybbZmnWc6snpdzqLCX61vs7lZhxl/esZsByBKBu07cQe/uhSNkiqkPAjJJGsnKmQHvCicEIBb+K8dRN3N8E2mU9M2DQFQxLppt13CTzueIEw72G2/3MqZb+L9rtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732171; c=relaxed/simple;
	bh=SukjBIaNSW/e729qbf5JpQTbMYwCFShTM/ToQZP4/UA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bLD87y7FFNHuKMkInEeL2viX785PrjmVsDicXvRxbEPb+eNxc+PwNdBROxzpzghjvnVQA4jsK0xxMSKUCq/of1k49C0EKyI24shOgWv+Q9EwPeusQ6bHQvpTFSREjY92asu11TxXw+/mf/a/4z8+IqZHEQsD6o1q59y2eCyirGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W5xEZhXh; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zj0pzInf2o9YSUOWgwSjns8wZpG3iIrVheAfiTY8zsk70ApWstYp0ui3/gwJxRdrprnsfU+nGbYx9FBbie1ATfBxBJAC7mol6F2siy6sBolfyQSJhjMY7SbmO0KTrGQUMY72D0n/8Vztz1r1iatqJq065VyEDJAWJh6gFcoXRH/thkhzYc1aydiJVHFjkqjDRMAuocp22AkwfNRHJ+EL0DmehzpEb/r9NLHFrMMmXa8opznqp4KtXjWyoRNd9VI7wJcg7DJCvwfJII3DhuVmLHVvXa4c9HcOZ5j/mlFWgSXdxtW9L07VeRN2kb8+Dj6f6qxSjsIfvdbPB7OUdPqYaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3wgiv55bGTfOHOPNaZ8OcwIniNnhTra6dIIEaOh+IM=;
 b=NnNLGAl2tYH976XKuqTjjm/SeR2OjuyDD/E/8MjT5AfwIgET7M646kBxoTDwpEcpk/kTmEKiuGzLXd+g1QXdI+8fVasE0/NPyLwJmgcv/8CXPlSbe+gCAWNxby8zcAHxhOblpY7eteq6nr4QctUiRqQQtgjzwJpcGoy0YJ5AfgK/eM7+jiW6x18uvNpgyWsTpkFASNGWr6iJnPDklINcOAOVdw5QskD25Sun6/294O0zGx3LvoduXPbE6hWOskcXnr5wb0weSCeC3k5OsYWz//dRu4ECqgBfZHYugZkdZnbEcZA7i/z9crnIxD5edf++CBdRCSL3hbHhbjtVaiGE3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3wgiv55bGTfOHOPNaZ8OcwIniNnhTra6dIIEaOh+IM=;
 b=W5xEZhXhMOdE5yNM3ZyI2CLEvwvBwwlMpYdc1tofl/ECXgZ/abdMDyyZDWxh8z3LeR0Y9BcT503I3SxvIQ9+957I6JeYhXIpftYaRbZklvXFKp7H/9Hmr0gtshvtRAJDTDAcruaSPWtXIF0g34zWbZvHFx2TNmreqwVF3QKolrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 21:09:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 21:09:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 11 Jul 2024 17:08:56 -0400
Subject: [PATCH 1/3] dt-bindings: pwm: imx: Add compatible string
 imx8qxp-mipi-pwm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-pwm-v1-1-4d5766f99b8b@nxp.com>
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
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720732158; l=1980;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SukjBIaNSW/e729qbf5JpQTbMYwCFShTM/ToQZP4/UA=;
 b=zpZN2XpE/CiIXIIAELnRcV+y+Rz6xSiVsQo2IWWefHTbBaWyiRnnmaXoLo2cBiRS08bYonl1H
 KqhBTJOQ6PRBbTEYfqsRVR8YQMIAbZPogXmQ4hHVfMSkEddIa9QLoxS
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: f006fd3c-5fc1-4604-c85c-08dca1edbecd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1NWRTNFSDJPQzNNYmUxVmhtNnpRUlkyRm1GL2pDRVRicEJkeEFaYStEdzA1?=
 =?utf-8?B?RHdRaHg3aklnMGZ0ZFZuUllIYUF6aENweXdBU0VDaGpNbU5XVTFPalJmWDBJ?=
 =?utf-8?B?RHN0UU9KbXFXcFVKeGZ6OHg0UGpET2tLL1ZHN0NrNkF0N3ZnaHlXWDJqdE1X?=
 =?utf-8?B?YW9JUkwwSGlWc0NHWjR5TVRVN0lDSlc3YUlHL2NZNmtMSzljcFB0clhKaVRt?=
 =?utf-8?B?TGxSSHhub21OSW9rc1NZMFBQQlZpeW1aVnViclB2WkROcjNCdkV5MTBMZ3N0?=
 =?utf-8?B?Yy93MXk3RnhGSmxHcXp6QW95OGRGcEpqMmVxNDByc1ZaV0krRzgydnBwVXJG?=
 =?utf-8?B?OGxiT3JGMmExZnYxeGdWUGtpOFl4S2FiVS9MNTVtUXpoSVFhY0I1MVhpcitU?=
 =?utf-8?B?UTduMEpuM01qQjc1UUNFL3BpZUtLWG1CSFZCN2FzaHU5WTU5MHZlYWFQYWNQ?=
 =?utf-8?B?aGdNRnZwS2llay9jRXlsVkV5ZmlWVUY2dms4MTFpSlltZENpVkxqcHNycEN3?=
 =?utf-8?B?NHFyYzJONStnUy9BOVpiUitQMnY1Qzg1MXpUMGJqOHRyQkdzNm8xdGFIV0RG?=
 =?utf-8?B?WW0xWlNhb2lvYThkTUo3WEU1Y0JnejlKNkVHNXprS0NTMTNLSkgyZUhEendZ?=
 =?utf-8?B?SU1ocDN0M2VRY21LRlRwVlFCVHNJbVFWM1dOYldCOU0yRVZBQzViT09JT21a?=
 =?utf-8?B?a3VpbHFmZDVmT1ZUTHlmSGdLWnNoUzVoM0JWdlJWWVcyWHovcXF4U2EwN2lQ?=
 =?utf-8?B?djdmcndkLzVkcmRJYitDWVpBb0txc3JyZXFMM21hTkVtaGxVaHNsa2JCa2ho?=
 =?utf-8?B?cFZKT1MycmZ6a2cyYm9MMDR6eHRNQ0xSVnYybWJpWTRrK1MzT0JPakN3bnVL?=
 =?utf-8?B?V1Ara1RWWlFqeWpwUzAzc2tESFZJOWtuNWVWYWxvYk9IOUpXMEx2dExhZ3hU?=
 =?utf-8?B?SDFObjhLMFBrZmNtUGp1TnVEQklHMjdrOEE4RCs4Uk9TUU4rR2RGTUJkY0Fl?=
 =?utf-8?B?SHIxeEpJM0t1K3FRRUh2RDFzYmZKdEVmM1VqbzRidmpCZGtkc2ZBcGUyTDd1?=
 =?utf-8?B?MzlQV0NsbWZKeHY3d3hUYzFEMXdGRDZSV1A5Q0pTMGV6d2xQSXNkV0Z0eGQv?=
 =?utf-8?B?ZkpSc0JJMGtIM21VVVprbGs3T2VHNXdIRVFnd2ZXeEhOZlhVQlVvTVJWYVZC?=
 =?utf-8?B?dXlvTWpXQnh2dFhMOURPYXFROW0xV2QyOGFrZGNPNFFvZkVEWDIxR3Bpc0ph?=
 =?utf-8?B?cFQrUHgycWRnUU9mcWxwUWd6cHRJb3pwWFR3UGhyN2ZCT3RjYzUvOE1CMC85?=
 =?utf-8?B?MXQxbTI1cTRSYTNKdEFMVjNjT2FJL0NwemVkcjhDd2dWSVRkOUhCN2tFZW1K?=
 =?utf-8?B?d1JzdVBYNXBKSGtyYlRvTWlLNjNSQmxnV2ZvWURPQXl6c3NSUHIremN5SDg1?=
 =?utf-8?B?cSszOG9JVmhWN3grNFI1UmoxcGE1ZUZMY0Rid3ZTdTJRUS96UjlEL3Q5NFVl?=
 =?utf-8?B?N0hNYllGRkROWWF4akFhRDNpWmFFZmtWa2ROVTZoN2Y4WGcza1YzL2lueG40?=
 =?utf-8?B?UTdvb2wyaWtnVnJVWUhCK3N0M3pjbTFHSWpVVXJwMmhkTEtFZEtCU29QSXVF?=
 =?utf-8?B?QTRGbXV0OWpsY251dWxTODhHYU91VnZGV2RISjhjR2k3SmMvbDdnbWJlRUZi?=
 =?utf-8?B?SEFrbmNXRmdWVkRjUHlEbFRhMGx1a2s2eG5xKzhFSVQxR2ZkajA0NFN3Z2hu?=
 =?utf-8?B?cXMrbUNIV1R0aVc3dXVrSnh3bVNUcHpoZ1MwR3FmNHg1K01xcysyNVEvQW1u?=
 =?utf-8?B?UWYwQ1lqbkREWXA4ejA5d2x5MFpQTVlwSmRBMzhnSjJBbTN3SkZyMVpOdWtW?=
 =?utf-8?B?a0RldHpFb2U0Z1hmLzBDZGJ0ZXZyS3hSZk1idkxOUDZPclE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blQyVXorRm1xTWNQaktSS2pXQW9XMm9WdE4zYy9tTEE1eWlJWTd0dGowemNV?=
 =?utf-8?B?dUtjNmQ3NHNST3NkUzZ6MG4xeFM0MlFZdTRuVG9ZY0Y4SmRqVHZVVk4xZ2VT?=
 =?utf-8?B?a21OR05LR1RSbVYvZm1FWHN2NE1VaXpWMUlETTNyODlSemFTamoxMXN3K2ps?=
 =?utf-8?B?REVuRFJraTVjSm0yZGRNN3BlZFV2dXozcXNmVVBjTjBCZkUreEVRcWJJbTdE?=
 =?utf-8?B?TmFsODR5QStWRHVXRjFhdEU0eDg5UXdNZU9zTmtVNVNsVEhoTDBtVExsdVo2?=
 =?utf-8?B?U0kxRmF2WW9mYktTQ3laRFpJUFFWL0M4WU41d3hhSjFZVE04YVQ1ZXlzdllC?=
 =?utf-8?B?eUE1aUhrZU5QYXdnTWthR1RVUk11R0pOdGk2MVY4ellVMldqY24rY3IvcDR1?=
 =?utf-8?B?RDFET2lFUzBtbm5VbUszTlhRU2JPUnlpcXR6VHdoWWZISVZjT0lkVHdxem9a?=
 =?utf-8?B?TE5QVmlGcEh3VUpySWVKdk90NjFRVXhtU0hKTmp0MTFEUW5jdTlBa2NSK1VS?=
 =?utf-8?B?K3diTTAvT0k0WWJuOHlTdVlZVXY1VllIVnFOOTJ6dXZzTzNtOVZVSU8wN2E3?=
 =?utf-8?B?bzl6SnpHcDcyVHNTellEV09MZWZPcFJFa3lJRkU0WEVNTVBmY1lYMHcvb2kr?=
 =?utf-8?B?MzJJUlNJTklCT1cwazJTajB6VXVjR0lyZ3plS0YwVE1qTWQycDNQWkVhbDdY?=
 =?utf-8?B?SzFqVUg1SVpwMFlxdEE3UzFwbHRmOFlhd3RhWUQvSjNVSkdOQ3dSUjFzNlBL?=
 =?utf-8?B?L1lMZVhEekdUOW5iN1lLekM1MnFuZm1pSXVJRk00QlpEUkcwOWNweHRvbG9C?=
 =?utf-8?B?K0hJUDB2ajJJVFh0R0dpQ01CaVliRXBtazZtRjhJTDYzVlQ0Zm9YaFVSOUw3?=
 =?utf-8?B?RjIvTm1FWHF0d1J6aUFQenlLVUwycjFKTmZ5bmJEeDJvRGJnYUc4STUwTEpy?=
 =?utf-8?B?bGthb1h3ZG1aNTR2cy8yaTk3clFYWWNpajVIeWtvZnd2TFRrbG5MOHdnVEJy?=
 =?utf-8?B?a1dSOTE1akxJVTRhNUpMT2pqb3pSaUk3R2ZwMzNhMG9qK25ITUJESG1EVEta?=
 =?utf-8?B?SEhOWXhlYXBJVFY2MUw4M0hVZFRrcGZVSkYwRFNmek5YQVV4amxPZGxKSHJM?=
 =?utf-8?B?MFlnTlVxUG5nZDJVOXlrTFlsRW9ENVBSZHFDNTZPSUxLQUVPbWt5d1MyTGdK?=
 =?utf-8?B?ZlI0U3ZYdnE1TytRZm53UzAzOGk0NFMvcnhsQnBLRGZyUlJRbEZ6am1EeXZY?=
 =?utf-8?B?enhJa2dUQjNpQXdsSGlRK3ZDOEN2M0ZEWlg4NjFtZnlMUjQzZzF6OFp0THJj?=
 =?utf-8?B?S3RxUk8zdDBpTWovb3ZIcCs1SjlqWWR6aWpIR0MySDhra0o1bzExNzhiT0c0?=
 =?utf-8?B?UTNvalJpaVNnTXN2QzRZTDFMcGJkNERRT2FlK1pVa1JQcTZaVmZTRElOLzRa?=
 =?utf-8?B?d0V0WTl5dU8wV0N3OFhEQUJxVTdNY3d0ZklGem9tQVNMeG85TVUxd2Y0SzA5?=
 =?utf-8?B?ZzhDRkt3TndiNmRqQUt5WFFhMDJOMXRmL3N3dVdrYTZodE9CV3pjU2owSy9k?=
 =?utf-8?B?c29VcDA2ODhuWkt6QytMbkQzaHk3a3RGVjEwYlFpU0Jxd3VJd3lOQVVuVjh3?=
 =?utf-8?B?cnBXbDJONHRDNFJiWEs4bFM2bCttN1NtM3FTL3BYN0lTTE5KQjMrSVJ0MG8w?=
 =?utf-8?B?a1hSYjB5eS9wdk9RTzlPN29VeFpXdkkzK045a1NPRjg2WjF5Q0llZkIrVm1u?=
 =?utf-8?B?d0xXaTBodEhqQmVTRUdDZk9yN0NTRWVJWngzS1Q1M2ZPRDl3YUs2aENiMlhP?=
 =?utf-8?B?ZE9JMlNaWGRHVDZJTlJoNUUxazFYSEdiL0JMUFZ5OEhBcnFraWgrMmNjbDlK?=
 =?utf-8?B?L3FhR3FidGZkRzZEb29MelhocXRtWmsxVmM1KzVIVEVrOGl4NkFBZEx1WEhR?=
 =?utf-8?B?N2kxVDNFa203ajI3allxUytDeVMzNFovLzd2V2FxS2V2UUJjZEJTem81a04y?=
 =?utf-8?B?dHdXallsRUxMZ0oveGdiQUNTN0VCOS9pZlY3OXRUR0ZaQmFtQVZ6YXZ1TVB1?=
 =?utf-8?B?MmoycklqQ28rQlVnOUN2T3U5UUJ3VmJGWDkrVitwdUhkQ0tESytuSGRHcG96?=
 =?utf-8?Q?RLEoNGluyQFKulhig5nNbhqO3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f006fd3c-5fc1-4604-c85c-08dca1edbecd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 21:09:26.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cX6RiFVI1fM6anXixAK2+KJPZ98pjJzqhB8LNXHNYHEmJkvm5yqV1ItiCKWvU7MCNYfaq0z1j3Ms0HzXWS9X4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753

The pwm in imx8qxp mipi subsystem require one extra '32k' clock. So add
compatible string 'imx8qxp-mipi-pwm'. Increase maxItems for clock and
clock-names. Add allOf check to make sure other compatible string keep the
same restriction.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml | 29 +++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
index 04148198e34d0..750636985f937 100644
--- a/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/imx-pwm.yaml
@@ -9,9 +9,6 @@ title: Freescale i.MX PWM controller
 maintainers:
   - Philipp Zabel <p.zabel@pengutronix.de>
 
-allOf:
-  - $ref: pwm.yaml#
-
 properties:
   "#pwm-cells":
     description:
@@ -42,6 +39,7 @@ properties:
               - fsl,imx8mp-pwm
               - fsl,imx8mq-pwm
               - fsl,imx8qxp-pwm
+              - fsl,imx8qxp-mipi-pwm
           - const: fsl,imx27-pwm
 
   reg:
@@ -51,11 +49,15 @@ properties:
     items:
       - description: SoC PWM ipg clock
       - description: SoC PWM per clock
+      - description: 32k clock
+    minItems: 2
 
   clock-names:
     items:
       - const: ipg
       - const: per
+      - const: 32k
+    minItems: 2
 
   interrupts:
     maxItems: 1
@@ -69,6 +71,27 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - $ref: pwm.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qxp-mipi-pwm
+    then:
+      properties:
+        clock:
+          minItems: 3
+        clock-names:
+          minItems: 3
+    else:
+      properties:
+        clock:
+          maxItems: 2
+        clock-name:
+          maxItems: 2
+
 additionalProperties: false
 
 examples:

-- 
2.34.1


