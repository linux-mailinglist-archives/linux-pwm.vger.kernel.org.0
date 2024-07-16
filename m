Return-Path: <linux-pwm+bounces-2830-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8179331DF
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 21:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF5A1C23207
	for <lists+linux-pwm@lfdr.de>; Tue, 16 Jul 2024 19:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC53A1A08A5;
	Tue, 16 Jul 2024 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jywizMe/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013021.outbound.protection.outlook.com [52.101.67.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CFB4D8A3;
	Tue, 16 Jul 2024 19:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158136; cv=fail; b=ayC8YWZHCfBsFzcLY2wW8fUZ1C7RWy+akzBjUgSd/eLHxZ3H7NxXT1BFSpP9DWkSIVSWo/ADLR4QLynGZWtuj9SXZtu2L6K45oaXl01/wkd0ejodX7VKs06RKNOJc4txKObotnZ+BYO7VmIqGgWAYmqkaEiN9I11U5zr0+96TOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158136; c=relaxed/simple;
	bh=slLxFF2JOl37km2H6Nx2fTOVbENkujt1PPU/hWLYp44=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=TIs6daKQ4tB6vdqrh6fQObxuavMoq1ojpMWjnobU8HwYLEJCZQUyckGH5TCqly3DPXh+QTwRuX2OtZzxJL5nk4Ly5ngkW1cwb/M7BnrqdXXzuJTjwn5teYA0nMDLyaYEaMtRZaW66qFyw7fBIHYkxrWAaICZ8Y2nYGCNEzGA77A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=jywizMe/; arc=fail smtp.client-ip=52.101.67.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOEePrFnniGVK96BFa6xIK7IFxIT+B+fC5hkoPI5Aj5T/WXi4FDPRPej3EfsDzkEiQDPrfGRzEP1xpsu8Z9jxkT+StIfJKsvKChEDvQBuSLiO3iMfAeb5P0JeRpvj5aiILhwaq/Zs2ep7g4Z1056lfJ58JlzdyAl5XneH3dob1G/ohBzw6UWw/xAMg6l5yR2cVoTFFkRoCEbuAW2FDtwuA/0jkHmrygYCxx4D4weN3VFPfXQ/S4MtzNp72+m6OaJN/Xvy1ddoXAaquUSTJcWcP2UTt/ijtxNkjYxSuuFuGqSaj8IVW6a+Em97+BVkmg64P2wcl8uUZgmHn+lcHXIXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8iJ5HVR3qGBzQjwY63jJL/6+UKP84QQl6mvj1APIPM=;
 b=Qo+PKImyJCf4BHt3jeX+A/3GgZFo39R7XWDuw2BHHsWAbApVeQSxu8AZsU6EJmVfV3WuIVcqpirDU/f+OSSHlfYMt/CD2FhadaKchB9FASId51qqrA8e5+lMSdcJ+nrDXq7bUMIQ+Dx57Yrp7j4Jh1hbzz0ic6Xv1hRk1dfUzzpqP+iohKisW1D5zmu1cATfut7A/bdRqMHesju09KA5ZUDbFUqeygtWR91dT88Q2PnS16VYLVzRSLW/y8ifwBxf3hLA83KHQSJeN0jWrBMgKBoe+eJu7fy5D7vyRPTUTJrQVxKYMfoDuFkB7pjRUyIynm2i/Wf/CKC2T0DBl3adYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8iJ5HVR3qGBzQjwY63jJL/6+UKP84QQl6mvj1APIPM=;
 b=jywizMe/wju2fzfQ/WIzO2QdDimM2xGc/qf/oqM6yp0JHT3+4NusUmpvBNgNo/HdYovcOv47dEd4EZ+TRM0hP4ucQC9YEx61Xw716ETUKTOwW5g2YqVnetHsTeSo9+rD2di8QwPfOwiSrSUIhrCTDNZnMnECE7Scc0x/zhPZTvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7325.eurprd04.prod.outlook.com (2603:10a6:800:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Tue, 16 Jul
 2024 19:28:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 19:28:49 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/6] mfd: add adp5585 gpio and pwm support
Date: Tue, 16 Jul 2024 15:28:23 -0400
Message-Id: <20240716-adi-v1-0-79c0122986e7@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANfJlmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDc0NT3cSUTF1Dw7Q0oxTjFGPT1GQloMqCotS0zAqwKdGxtbUAEsvjZFU
 AAAA=
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>, Jun Li <jun.li@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Jindong Yue <jindong.yue@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721158123; l=1596;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=slLxFF2JOl37km2H6Nx2fTOVbENkujt1PPU/hWLYp44=;
 b=F2cZGSyjNL6CDrjikbEVCCdxw5YlykqnGSqQJVeBxioLtOGazDIqzp2bmZWsaqrlTN0oYPh9h
 WAPwhMT6ZFzCCU/E5rnmi8Iha9mnwQd/SN6oDWFXUI/6AY2dYBMLOTU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: 73368fad-4a77-4832-aa5c-08dca5cd846b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm1KcE5HVFVoTUJOakRWa3FOU2xXZUlLZTIvZnhwQ0lkZ0N2SmF6RVlPanpP?=
 =?utf-8?B?THVZV0E4UlBJZWg4WHRSN1psNHpEYTBlTU9GRXNOUm9yS0ZBK3Q1ejJXR09y?=
 =?utf-8?B?VnJxUWlIWGxvWHRwamYvTUVZcTgxSDVOVFllZkVzem9xWlFqT0tZeXFndmhy?=
 =?utf-8?B?UHFqZFB1R3plWUdWY21pOWUzSnhaQVpjWGRnaWp2UytnTXptcW9TNkZ2dUJB?=
 =?utf-8?B?L0p4Snp2YUlaUkdkOTFnSjNHSEdFYlVFNmlxOGJEcVRZN1Y5OFlmTVFEWktx?=
 =?utf-8?B?eEhQMU1kRFZ1MWVPQkNWQ2FxYnNiZjRlUTdNNGdTaGx4djhWamh1d2x6dFpQ?=
 =?utf-8?B?dmxYUDN0RGJsRDlTempLY2taWk5kelJPSlVzNThTT2lhdktOTkQvNDRTVHN4?=
 =?utf-8?B?Q1lmeHBPQVJjQXdzSlAvNnlwRTNVcnQxUnR2cXFVVk5neU93YVBma0tZSnhL?=
 =?utf-8?B?V0tRdWtPWjJoZHhPS3F4Um9rZEJPUE1zbWZETUlrTCtHbVlpUlVDWTFIQWg0?=
 =?utf-8?B?WHhKbXhCUmRsQjZucG1jN2c4TUV6QVNjRW1PckJCSTZCUytXRUk4N0tXUnBC?=
 =?utf-8?B?WVp4QXhKYWtXUkhRK2JUd1JyMTR3WGoxRFdScjZtY0piSmozcDlITXk1OTJB?=
 =?utf-8?B?U3NkRVRwUGxoTVFRckR2ODVCUlJ3U2UxYy9raGF4Q29rNlk0eGVGSmFpT01w?=
 =?utf-8?B?djhSQ0ptQ1ptQ0dRRDBlUDFXbk51QVFoWmVJbWljbFRSOXFIaTN0ZVZ0UVRk?=
 =?utf-8?B?KzFSUjVlRnUrMkF2Z1ljY09zLytNSTA2aHZIcXNNZXNRK0RMMmkrajAyM2E1?=
 =?utf-8?B?QnIwZmgrR250SkdIbVdQRHRrbklEQ0FKNVpjcXY1VmNPNG9mYVZrdlhHQlVI?=
 =?utf-8?B?ZlI3eGVjRTdWWXFLMnkzaDRMYXA1UURucW1wU1ZtalhEM3hHc0MzcjJEOWJz?=
 =?utf-8?B?RmF5clRaeVFISWlnazhJYWZiVkFXdVhZWGNCTWVwcXpVU3prRWZCTlhqQklr?=
 =?utf-8?B?bTlwS0xaS1hIZmNkenV3S3BVVkpoWiswSWU0V3hlWGJEdkw4NmQzbkc4Y3Fo?=
 =?utf-8?B?WGF3Q2tJcTFoS2VLL1BPMDVUUW5EOC84SjhoNHBtbmlKdWZHYUlNdGlTMzNj?=
 =?utf-8?B?NUxXZmtQd3ZGM0NzQ0FveEpUWTNIaXpmT3J1MDQwZERVSHgzcDQ5WHBKVnk1?=
 =?utf-8?B?RTN1N2hjbmJEWTVRV1ArZ1hrQ1EzVVhWckN4MmlGL2NQRUovZkoyS29QbVNR?=
 =?utf-8?B?ZndJZHNrUnhua0grSExrS3VUYjg4b2FKYStYRGhlanl5RXI5VEMyek1SRFFr?=
 =?utf-8?B?US9icFMrWUhYS2Y2MmFERDMzQ1Vtc1kxUU1nTmJqWmlaZXF0WjFrL2xIVTN0?=
 =?utf-8?B?a09HR3QvMUk2MTZjOG8xN08rSU1lWlpLek1XUzhvZTB1enRHeGQ5ajF3aWNK?=
 =?utf-8?B?aWV0LzBpQWttdW91N1RldjVPQUZLYlR5VmJkZzd0NW1ocVhpa3NLVTV6U002?=
 =?utf-8?B?Y3V6cXZ1MUtUUmFIcmx0bU14ZWhPYWhUMGVrSnFLNWRCZWtiZGh3dkVPMjlz?=
 =?utf-8?B?bE43YWI0ZmxxdWZzaFNDYXYwUWliT0pQQ0JucWgxN1VScTliT0I0eFUzbkFi?=
 =?utf-8?B?QzBwcXRXUlhsYlg1L084aGVoRjdOcjdxZmc1SlFZdGhGL1pQRllpMkdBazhZ?=
 =?utf-8?B?VndjcVdBVFovS0hwTU1nTVBXeHVucXV1ZE1IVU53QnVobmhDQ0hQaGJMbXpY?=
 =?utf-8?B?Sy9sL05xQ1Avb3FnU3lZcGVBWFBiS01VZ0w2OTB4UjVvVCsvNHVGQUhTR2xu?=
 =?utf-8?B?NW52ZWc5aEM3ZURVdkdZQkxmd3gvbzN3MFRwLzBBaFU4bHQwNTkwQUhURVV1?=
 =?utf-8?B?d3pCU3FBZnRtNnJ4NzUxbTB3ZG1qbjl2Kzl6eWxkc2pQU3FIbkUyZ1JITlIx?=
 =?utf-8?Q?ZYyl2fpfGHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWJGdGtuZ2RSVXZKZFhaMExvUFlCaEllbXYwaHppQWo1aU5nSzk3U2tWeEZj?=
 =?utf-8?B?VzVaZ0hTSEpOUW1STE9YaS9OcDhUTFRNV3RjNVdDa1JYSElvakVWZVVjMVZn?=
 =?utf-8?B?SDRLOTIwZlFkZmE3UmZJbDF4NzE5REZiMEx0UTFvS3R5RGFrU2ZOK3ZGVzlC?=
 =?utf-8?B?OS9aZzVDYXAvOUJveFg0c3Z5anFZTGFuc3Q3ZEJ4YjdZMmlhTWFrMWs4VTk3?=
 =?utf-8?B?Vm5RdktWWll3bEZCTUpxRTRVNXk0UWNFOWgvUEJWUFIyblBsR0xxK0VGakhl?=
 =?utf-8?B?a1BzUnBjdWhaSTVZblBBOXBIeGR1VUtVTzRPRWdZQklXOUQ0SUREWlJ1UWxs?=
 =?utf-8?B?Z0k5bmxjQ0ZjbmV2T0VBVXhGUks4SGpaRGI2ajVrQVdLMzN4aDFSZHlWWSti?=
 =?utf-8?B?dTEzdjFXbjdBMjJsWUdHc1VKUm50VGpnTEpnMDN5NCtMcjAxcno3ckFMb1dP?=
 =?utf-8?B?b0IvWUh4M1VMYkhkSmxJT2JCVWQxZUN2OUtQb0tTaTU4L2ZMU3pGcFpzcE9h?=
 =?utf-8?B?WC8rMjZBZWZzbkphOHZoaDU4clZvWjlOeTNCYWtCMFhVaTZ5M3k1SURnb0th?=
 =?utf-8?B?eXY5eWhTY1Naa2lta2M1QnpGWnVSZk8wTnBVWGxiWjJ0bUFMS2Y5V0gzWEdp?=
 =?utf-8?B?SkJkcm1rZk1yRE5IdDQrd0NaaXVocFNkQUJQV1JsbW8vUEEvcjVLRi9RVlJX?=
 =?utf-8?B?WUthL1J5Y0FIWEt0MnlJa2EvQU9IdzdDUFEzM0VxcEhuZk9pMm52UTIySmt5?=
 =?utf-8?B?N3BGMnYxUnE1cTloL2dEUFJia1V2QjNPM0Z2S0FyNG5SL3BlZ3VkSnpuZlZk?=
 =?utf-8?B?YnpIRGNiV2hEM2huZk01bWhzNlozYVc4anZNQXpiUFFJdStNZGlQRFNIUmxm?=
 =?utf-8?B?V29aeEhjc0I4QjNtVHNGTnNHVkZkYkhaTFo5LzlGeWw1L1dDOFVDS1psMFFC?=
 =?utf-8?B?WHJ2L1lac0R0QVM2Z3JDV0p2VE5DeVJxM2ZwQ0ZNOWxoNFZsZExQRTZPS0xJ?=
 =?utf-8?B?alNWNk5NTzJtNExIYVJSL01UNU9DUEhQenJvNTdtMkF0UmVEVHVjcTVvK3cy?=
 =?utf-8?B?elkveFJ3bnh5SndFaVc2WktGSFIyN3pQSlA5bnFSU2NrcnBTUmF0ODhKbTdr?=
 =?utf-8?B?TWNSVDlDZnpOcFhsTS9FS0hjN04rM1BCRE1KNm4zNk1ZblZhNEwrWElTNFRi?=
 =?utf-8?B?bms1Z3QwcnFDd3NEWjNMdUtwdkZQaXlwRENKVUhrbzEyK1krNzM1eHR3MzdU?=
 =?utf-8?B?cE94T29Dam9lNzNOYWRSRHdkOEZOYTRTNEtVeXA1Vko0R0dFTmVWNVJVa1Fj?=
 =?utf-8?B?alFYR08vMVY3aUxjNEFxS3pmWDA5Kzg5K09Jb3p2ay8zQWluQjRsekE4Wm9x?=
 =?utf-8?B?QzVPcHk0T0Vxb2VTVHN4dnRPZ2hheFNZdFdYT3dKUXZnRVQrVHIrVFEzOHUx?=
 =?utf-8?B?aElneFAwMi9rNldSdWNlRzJ4WVFaV1F0bmFydy92TTFHcHpnd2dONG1mamh4?=
 =?utf-8?B?ejRpYVBGWkc0TkxqT2ZxUDZ2TEdLVDc3M2NwOGJ6TDJXQld1bFg4YWhTR3ZE?=
 =?utf-8?B?Q0pKZDJScVVFb1BwR3ZhVGVsV3dhSFN0N1NITVRHVUhBYWJSWjRURWJXZEp3?=
 =?utf-8?B?QTJYNDlFaWtFbFRtVFlLL1RqK3BBTE80T0Juamsva21iUGw1RmNPNmRXbENl?=
 =?utf-8?B?MzA4c2ZJQkM5bVdmdjJXZjZIc3RaeFlUc0UxQVRxOWdBWDd4WHhKcWFsaUFL?=
 =?utf-8?B?OUx0YUxBRC9YM1JTS1l1eXVmQUxjaVJpQmsvbm9lRXhaMUdsVnJxRjZnS2tx?=
 =?utf-8?B?dm1KL0ZqL1JJbTJFYU9IWE9BSmNQRm5XY1BWS3BveHpBRXppU0JySXVFNitV?=
 =?utf-8?B?eUtKc0dGRDZyRjlNb2Zva3B3cWJHY1MrSWlkSmNKWVFWZWQwVlhwMWdtaFRt?=
 =?utf-8?B?VFB6aDNxVmVuVHV2eFl3dExtN3BxL01JcHpTMGRSOFlIT09FY0l5RlR5a1NU?=
 =?utf-8?B?c2E2dEdCS3JBTWM3a1VGSzF2Q1dTRWpKVTlKczFxVGhpc2s4ZDNha09sSm1K?=
 =?utf-8?B?WVFZZGxJWXJjR25JLzFRTzdwK1ZrVnBRSEd6OWNMT3c0bGRLcE1ZRkNJZkw2?=
 =?utf-8?Q?hP0A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73368fad-4a77-4832-aa5c-08dca5cd846b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 19:28:48.9436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MCf8uId5oXIp+Fg6Dv45uN/Tx6cI0RHQbgdOj5VjK+Xvd8YPiOlFYCQiJp5L7RveYEEdK4uOA0f70q15Vvt+/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7325

adp5585 is totally difference adp5588, which in
drivers/input/keyboard/adp5588-keys.c.

So create new driver for it.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Clark Wang (1):
      pwm: adp5585: add adp5585 PWM support

Frank Li (3):
      dt-bindings: mfd: Add i2c device adi5585
      arm64: dts: imx93-11x11-evk: add adi,adp5585 gpio and pwm
      arm64: dts: imx95-19x19-evk: add i2c2 and adi,adp5585

Haibo Chen (2):
      mfd: adp5585: add ADI adp5585 core support
      gpio: adp5585-gpio: add adp5585-gpio support

 .../devicetree/bindings/mfd/adi,adp5585.yaml       |  83 ++++++++
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts  |  16 ++
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts  |  30 +++
 drivers/gpio/Kconfig                               |   7 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-adp5585.c                        | 184 ++++++++++++++++++
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/adp5585.c                              | 134 +++++++++++++
 drivers/pwm/Kconfig                                |   8 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-adp5585.c                          | 215 +++++++++++++++++++++
 include/linux/mfd/adp5585.h                        | 100 ++++++++++
 13 files changed, 789 insertions(+)
---
base-commit: 91e3b24eb7d297d9d99030800ed96944b8652eaf
change-id: 20240715-adi-11ff2d3d35ec

Best regards,
---
Frank Li <Frank.Li@nxp.com>


