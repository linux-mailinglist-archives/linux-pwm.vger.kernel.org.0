Return-Path: <linux-pwm+bounces-2768-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D4892F0B0
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 23:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66E4E1C21934
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 21:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5EE19FA6B;
	Thu, 11 Jul 2024 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sme1C5gM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3E19EEC7;
	Thu, 11 Jul 2024 21:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720732175; cv=fail; b=P7otinCBsdCmvKUHF1XKcyL6/k9HtxSKjdXbHW+T1jizwh5JQW2o08rkWnwf3ZgED69SIe4uNI4QhTPM6SGEyLwWeH3g2NNKH87Khlfh0GNblmP/SJNRAtEGewn9Aeikn0gBVXZoW/j5sosaO7OQiiRF+vazyghZj0wu406QgA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720732175; c=relaxed/simple;
	bh=V4/JiROHKoMNNWNqxA5q5eMS/NJIj1fiSgLqTWOjo8Q=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eYw/lvuJ0S9XyvgWVunuF6T6f8688XALQ19e0ZO75YPZ2ymMM6SzDtgpdytB0hx3E5eOIAcCQDUhyxiSEP83zEkI65s4S6mrz2qSxpSx62+UA3B1En6mcnmi57CNyJjTjfbq16VIjBNNgEBagBsqJTkiHTqgkoOM7t0fNx05XI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sme1C5gM; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVJavxpesJrK65FZXb8CkWYStoP4zVCwKnwnuaVqudF9tTIlIVANT9cgV4pXeKIgf1DsPh/m5omKFwH6f5LY/Hw53fX7DMjrw4TUMKo8FzNiEiHphlQm2vCGev3dfCR9hGQt+YPCOQWu20yOwo0wTUiLRWzdzn/wYCvDZKWjOgKu3CTOhRs9+003OYttNlMEmfXxJStafMU15XddICSkC19Lr+X1LJDPTzwFkQqeI8hEfFxwkm3DVeL5Dn4Ti1sRd4rKDlEduhbWkpoURxI6XjqKMer/aTnLMDrLjFA/sc1zgCDu8U5rGDGkIAPR0hKQx2D1cJ/fZvbsUBhePo+sHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0Rf+LL0Y+RBJFlfxKtCUFtRbaOB6chigoL7jGW+ZHA=;
 b=qbrY8yxrYdRbZeRBaDuPkJINLgv54MWLE8bYocsWpms6V4gPrYiqTyk0cq5SSBqISs0y1nntL2NEL7UmB+SX2NBeVpan1eJ29LRDdcAerGbP3CNdLYeuYDBE8K6/3l4NxBGhVTXiEAXjLRcvt6swYLT+P8U/H0f+iyY1ScS8V/0M/BXrITLQGHRUD51sgu18aOtbIylLi5z3P6aaFzinyXwiD8F8d75TeNYEbtZdRMTQFUogsNpiDdnlSjwIBJmWyLrTHv8ctux0nLLTHahzLJlWSNVTzaQardsI2unObHeWHPCF9MieC1QodFY22ESyfvmtwgo1vjU0wACJsAdnyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0Rf+LL0Y+RBJFlfxKtCUFtRbaOB6chigoL7jGW+ZHA=;
 b=Sme1C5gMxtnKhr4afQPD8HmJsMYYLJtzP62lIiH7053Zes6uu2D3CcbXXP6ZBznUmdGigzZjgKojSqJKPTO5c83ox/QFwstqRUbvV9np9F/MQSrnPHLs4XxdVC0m7ObjmxcfUv9wTNBOBhxeW0cdk6A/FfnyhRCehnD561vED0E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7915.eurprd04.prod.outlook.com (2603:10a6:10:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.22; Thu, 11 Jul
 2024 21:09:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 21:09:30 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 11 Jul 2024 17:08:57 -0400
Subject: [PATCH 2/3] pwm: imx27: Add 32k clock for pwm in i.MX8QXP MIPI
 subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-pwm-v1-2-4d5766f99b8b@nxp.com>
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
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720732158; l=2498;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=T8sTYpfSEeBY2/knCkc7BNYVCAkGkq10MM1DGu+SsPQ=;
 b=laVB2GjlhPvVez/dCnHfiC5J2Pd70yiRPMxc+6YKUpfyC8+AuOQuegC1xFUA2oIZDMFgyEpGo
 M/Fx/nzRQg/DtvkeFX17voA+4+JvrNHYGOKavnjPAEMZGGWSglnUCJ8
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
X-MS-Office365-Filtering-Correlation-Id: d6248656-b608-4b00-cda4-08dca1edc111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qm5uVjZrNTN6bkdKb2lOTTQyM05kWEZLMWc3WWR6ZVIxMld5MFNoNExLcm5w?=
 =?utf-8?B?b3kzVE0wVXRUOWQybm0xUGg4MVJiYWYvV0JLRXZDMWdCTkp2RE5GOVNxWEdH?=
 =?utf-8?B?TXBQUTNYeWlCSzdBRS8xbjRXUUYwcldNQS9pbWkybndEWGRXRW0rMWt2TERs?=
 =?utf-8?B?RXdOZHR6eFpidWZiR2VSV2NEM1d1NFV0NkovYXFaU0JmRTF4R0FVeVRMbW5X?=
 =?utf-8?B?R0NZaFdrakhGMGFmU0ZTbE1QZ3h0QVBkQm9XVHhJVS81bU1QM09kcDBmQzVC?=
 =?utf-8?B?N1ZwdE9yZGM3c3Z4M2N1UEJ1c2kxYWpRZFZ5cDh4QjN3enA5QkJ1ME03dDIr?=
 =?utf-8?B?c3dUU1BYNkdFZTFIVHlnSTdwWTlVT29SbWpzYjJmaEM4TWdCb3pUc3FyeEx5?=
 =?utf-8?B?NitidkgxNFIzM2hCVTJocitFMVFvUkFZR3Q5YS93YkxFM3g4NVpvdzlvTC9x?=
 =?utf-8?B?NHZuSlY1QTYwMG51NXVUZytjVVV5RFVPeWg0TzA4SGcxR1hOclB6QTg0L1ZD?=
 =?utf-8?B?QU9DbVI0cmd5Wjl6eG9Cb3A2Mkx3MU9INEs4NDh6eE53cXFXS3J3Q0ZQTjY3?=
 =?utf-8?B?cDA1dUN4ZHBnSUJNVjFxOUV6T0F5aWFhWnhONkFNVTNRSzV1cUFrenJWb0tB?=
 =?utf-8?B?b2xiVU5HbWhBTzUvV0YxcERLdzJRTk5TVkNQYjNFdGtxeGdzV09FVGtBM1Uv?=
 =?utf-8?B?UW9pVjR0NWwrdTk5WktNWGUrOWtlaHM3MHlHdjlJQWVXSlByc3V0M2pnOGM1?=
 =?utf-8?B?UmFWNVRjeTRBcHRYTFFwWWxTQU1zdFhqZTNvRzFBbDd4MDg3b2kzNlZWL21H?=
 =?utf-8?B?UkVwZXpQYXRzcEFJdDBGWEJubTMzNmJCZEY0ek82QlE5RWpaRmVqKzlnS1FY?=
 =?utf-8?B?WUhCUWpVblhzc2VwSWJ0SFREWndwTS84WUVRTVk0SW9WZnQ3dlFXVWtLRE1y?=
 =?utf-8?B?aEovbkc3VE4vVFFHcHgzRFdwQkU5QUl3NDJoRE00Y1h3WXBPZkp2Ukc5NFRs?=
 =?utf-8?B?aGxwL3A4KzFsRVh6aitOZkZQL1Z2Zm5FVk9IYkRFcWZQcEt6YjVZRDZWTEph?=
 =?utf-8?B?NTUzc2xycURHYnlvYlpCWFdPVm1hNDBBY0Exc1YzekxKd29abi9QN2tJVFpZ?=
 =?utf-8?B?Q3lNd2NUM1d5bnJVTGVST3NYdjZoOWFpU2VjOXFmMFlnNS92WWdFN3NtcE1F?=
 =?utf-8?B?RE5FbVorelhiRzI2WXVDVTBQcmJIVWl2SkZpWlg4ejVvcElJdlZEb3cxT0w5?=
 =?utf-8?B?Wk1lRytXY3BkUUF3K0xjUWgyamVwTUQ5blZidlBaWit2QkFXVWYzRmJnTSts?=
 =?utf-8?B?eVFkY01Fc3JpbzhZRU9OS2lhWVh0ZXZNQnRuNzZ4VGxqdFhST2thS2JPSnhT?=
 =?utf-8?B?YU9FUy8wWnU2N0djRDhxbkdIUEFld3BmYndIUTBDRW0yZHpnL3g4eGFiWDJX?=
 =?utf-8?B?RnVKOTZUUFphNHlEUTZxSVIxR0FNV25ydjI4S2lDNnBOREZhRlRKeXpnanFl?=
 =?utf-8?B?UzR3U0VhRmV6am15NFlYbG12b3BWK3N1UVR1QmlxUnRvRForU2ppOEwvQjVv?=
 =?utf-8?B?V1BGd1gvWHFtb0ZiSWZjZ1ArKzNBUUE4SmNBNFNET2hnaVIxM3hqZTJUNG5H?=
 =?utf-8?B?SDVPMkNkRElwTm4vamIyRStMTVpiU0NFcFBzajh1cGMwa1h1VUVzQ2hhVlRZ?=
 =?utf-8?B?ZUIyV2RPdllCOFZ2QnVUZW1DeVMwL25uU1kwc3dVNWlObHRwUzlqdDJxU2Yx?=
 =?utf-8?B?bTlJdjBwU2ZkWEVKQXRsZ3hIbGE1STdlSVMxejJITXZQK3RkVWtQQWhQQlYx?=
 =?utf-8?B?ZVJSd0VYUTdrcXc5bW41QWdlc1dMcVhDQzFReDVKbDFxOUZ2QTEvbEhxc2ZC?=
 =?utf-8?B?bEkxcGJWcEhScEkxZFpDd1F1Q0hHSTMwRkpvSFM0bzdpemc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlhvNzhNaUlYSHZUcGhGbHlWbUY5bW9Nell1RjVzUlBORGNCczhaR0RUZEFz?=
 =?utf-8?B?U0IybS82REgxOG1UY0hCbGpFVC9DM09jb1RHV1QrblNNR2NReU5KSXlWVzBV?=
 =?utf-8?B?N2pIQTQvL0FmZlgyUGZjV1NMT3h6eUhwbjR6MU5zNXBZeklsMXZtTTBBR2Vt?=
 =?utf-8?B?NjBONDg5cjlwSmMrMjg1aUtwdHp2WGM2RW01QWJuTWpNVWJIQkRXYWx2TkUy?=
 =?utf-8?B?eDVvYUU4Rk02Q0puNmp3RXRNcGd3alJsdUpCbnZmU3JvTkhZSjhEVjJERC9m?=
 =?utf-8?B?MGJPd3VkR3pqWWhiR1VpTW9Dd08vMXRCbmhKYU8vL0RDRFp2MWtFckJWbTVF?=
 =?utf-8?B?R010TFZNQkN6ZmFJWGRqOVJGMm1TMzFCbGVTdkwrOTU5eTVqTXE2STR1dkxY?=
 =?utf-8?B?V1NsMWNSV04yTk5PZnlxWUxQVG83QmtqWkNJcjhSZmc1a3A0VWNkcHFKRkFt?=
 =?utf-8?B?NDRUR2F4SXF3a3IvaUIzY0NQWXVPV0plczVkWW5FVFJVYWRSbExnSEQzT1My?=
 =?utf-8?B?TFFERCtQcjFZcG5HdGNYenIwZVUrOTJ4TFhzcjZJUE10Si81K2FtdkZRMzMr?=
 =?utf-8?B?SlFzOWxnMlV4OFNFbFdFelpmZWNaeGpQZkhtNnZuRVhmblFFRDdzM0JQY3Ra?=
 =?utf-8?B?bkZDdlRvSFN3K1c3UmgyYk1vYStZczlkMkU2bXZxOFRPVXV1V2szZ1FpQ2J0?=
 =?utf-8?B?Z0RHWDFuUG45OWdNcWpYeHZrQTRZS0RiWXFpQWdYZ2E0MGNrVFg2V1ZmWTRB?=
 =?utf-8?B?b2JPWnFrWTFqL3hRekNtaXcyNlFhNDlDS2l1dmIwV2NrZ2E2TVZZK0Q0QXVC?=
 =?utf-8?B?bUY4cFNlKzFUNko3TWkzUTFVQTlJbEFNNlRMRXpMZDdMM1UzMWF4VGl0Skxm?=
 =?utf-8?B?WitaTURBcGJ3QVdGVXdYZkRDR2d3T1hSdUJ4Z3ZXaGJTbVBXcU8vSTZOUWhz?=
 =?utf-8?B?TmJkTlFoWmdjOWZya2toalJZamlRR01YUjVWM1JqalFTcmRJNS9jUFFDQUNr?=
 =?utf-8?B?aDRoc3R5ZDBSejVtd2gwSFFDMFpPbWo4enFMZWF4K3NSUzRZZjczZ1FMdnd4?=
 =?utf-8?B?aFBJYnZ5MExlbCsxK29wNTA1NWFlemU0bHhpeG9Icy9ONFk0VStnNERldDNi?=
 =?utf-8?B?R1RXWmhWc0RVblE5UkdUem9zVTBLd2poc010L2dKV1R5MlArMFRweXpxalhz?=
 =?utf-8?B?TCthZHZzc0YyZmpQSG1TMDYycFRGTGFrRFltWjBrQWxzdjlMMVlaTkk3ZVdQ?=
 =?utf-8?B?UW1LRUdrU2I5cmpCbDBHNTI0UnpLYnJzNXlRenkvRUt6d0Y3ckk5WDhRV1R1?=
 =?utf-8?B?Qkg5Z0x0Nkg0aE42UWxKc2g1UUxrN2U2K0RSUTBBWksya3VzUVo5N3NyME5o?=
 =?utf-8?B?anlsZEtBc25mRm5hZmsvcWpZR2hFOU9vWDBIdGxkaXBqRkY0c3IvTjlNY0pB?=
 =?utf-8?B?ZnYyeDhydlhSUDloMmFtUXJnQ080Vi9lTVllcU5rVHZoZzBrZHJTKzRiTk5a?=
 =?utf-8?B?b252b3IrckFUZUJneHNMYnBKdFE0TWZhdWU5OWlmcWh2NS9KNkIyWXBBR1Zt?=
 =?utf-8?B?b2lWVWE4MEo0blFUV2NNQ0p6bW40U3U2bmdNSkhsaVN1R0gwRnpncE1zRTAr?=
 =?utf-8?B?ZEVUQWNIcXJYbnlLYk9jbm5KMFVYSHFZdmhaMGhCdGoyNXRLYmxnVi9tTGdC?=
 =?utf-8?B?am1iWVhVMlpKR1pCNkFwaVRYQ1U5U3NvbXVlVzVxZjBheDVybjF1dGRQS0hW?=
 =?utf-8?B?ci8wRCtqdGhzdzVKS2RreDVINGtFRmZtRFhrOElmUldkblYydkJGYU1kb1My?=
 =?utf-8?B?Y1J5c1gwTW9LR3lXekc2NWlZN2FUUlFLR3gxSTZieWRwaWRGTEV3bVFyaW5l?=
 =?utf-8?B?b0d2Tnc1TGFFRisrNkQxazFGY21VZEhqOHk0cXE2WFB5MTdYVyt1QjZDYko0?=
 =?utf-8?B?S29zTDdSTUhWRTFpSDlsYkhMWVJWNTQ1ZFVCRklkVEc0bEg5TjRESUxORmVj?=
 =?utf-8?B?UHlVSm5zMnB3bUlpUXFodFdqSEZVaDJjV05aeFd2ZUxYVnVZajBaNW9FL3pa?=
 =?utf-8?B?NGhPN1JYR0NabzlXWFY2dDJwUGM3ZDJ3N08rVlVKamI3Mms4ZFdnTlpuNERF?=
 =?utf-8?Q?mRHHbEbfNWHeUBfyaeyRW8gPq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6248656-b608-4b00-cda4-08dca1edc111
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 21:09:29.9523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9UB1DH+Gf1E2j91kgjYbn7bARr8SPzCTrIiqzGcC01EEahQ1BdrlVCaPf9mEPJ+56pDsApbP4w4Bj1Jyg05Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7915

From: Liu Ying <victor.liu@nxp.com>

PWM in i.MX8QXP MIPI subsystem needs the clock '32k'. Use it if the DTS
provides that.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pwm/pwm-imx27.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 9e2bbf5b4a8ce..032bce7d1fdd3 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -82,6 +83,7 @@
 struct pwm_imx27_chip {
 	struct clk	*clk_ipg;
 	struct clk	*clk_per;
+	struct clk	*clk_32k;
 	void __iomem	*mmio_base;
 
 	/*
@@ -101,23 +103,36 @@ static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
 {
 	int ret;
 
+	if (imx->clk_32k) {
+		ret = clk_prepare_enable(imx->clk_32k);
+		if (ret)
+			goto err1;
+	}
+
 	ret = clk_prepare_enable(imx->clk_ipg);
 	if (ret)
-		return ret;
+		goto err2;
 
 	ret = clk_prepare_enable(imx->clk_per);
-	if (ret) {
-		clk_disable_unprepare(imx->clk_ipg);
-		return ret;
-	}
+	if (ret)
+		goto err3;
 
 	return 0;
+err3:
+	clk_disable_unprepare(imx->clk_ipg);
+err2:
+	if (imx->clk_32k)
+		clk_disable_unprepare(imx->clk_32k);
+err1:
+	return ret;
 }
 
 static void pwm_imx27_clk_disable_unprepare(struct pwm_imx27_chip *imx)
 {
 	clk_disable_unprepare(imx->clk_per);
 	clk_disable_unprepare(imx->clk_ipg);
+	if (imx->clk_32k)
+		clk_disable_unprepare(imx->clk_32k);
 }
 
 static int pwm_imx27_get_state(struct pwm_chip *chip,
@@ -223,6 +238,7 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
 	unsigned long long c;
 	unsigned long long clkrate;
+	int val;
 	int ret;
 	u32 cr;
 
@@ -325,6 +341,13 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
 				     "failed to get peripheral clock\n");
 
+	imx->clk_32k = devm_clk_get_optional(&pdev->dev, "32k");
+	if (IS_ERR(imx->clk_32k)) {
+		dev_err(&pdev->dev, "getting 32k clock failed with %ld\n",
+				PTR_ERR(imx->clk_32k));
+		return PTR_ERR(imx->clk_32k);
+	}
+
 	chip->ops = &pwm_imx27_ops;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);

-- 
2.34.1


