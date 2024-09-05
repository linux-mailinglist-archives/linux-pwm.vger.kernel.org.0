Return-Path: <linux-pwm+bounces-3111-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D7A96E283
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 20:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AA68B26DDB
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 18:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A281A08AB;
	Thu,  5 Sep 2024 18:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J258Rzd3"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1467318DF78;
	Thu,  5 Sep 2024 18:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725562458; cv=fail; b=BygtuFxMDitU66RPwaAmQwGgOWBklYtUDAZMw6+c2hLd4pdhjyFHZ7XeJ+Lb8roXwrIdFnWGf8bXti0nmkAkCupcU+rlQH4OjFYClbWgeJCvX/XP1YPFU9Vb2P/W60JRMoXhcJnlnM72ejwo5HDJn7SMzaCbt5vpq/8l7c8z9F0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725562458; c=relaxed/simple;
	bh=DyCBjd8cw+M9y/tE+vQa036w2Fxd/aOHX1SD/EK9dlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TNeRVKH8wjrxaDRjZ1V484hVXXAPfgeYiTt7T1XM/W4IOGmXiyasgnu5PvWcLORVs7kB+Jb3Lq+s0Ylubt1rPo4WbrHwrK6jyGFJdsVg52kjjYaL65/sjSb8b+aOP1jWYx5SOaUQO5aAiYfboiS+0336AngI3UEWZxA+bhzRYEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J258Rzd3; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGc8doF3ip/lBJDI6DwyxAAVKKKKnm/cexXF5JVBEH257oo6ntJLefiajRD4gl0IyODSMTEXQ7zVovg1flleorwxSWvJ3pdTMqOA2ZnfhPdSTWLMKvURbigaz4o2pbiltrAY0/iHFPkBKbABXyfBOvS1Sc9czssiaZ1SBFTLd0Nmdk2tDZeO0vchwYf+/XKvR5jroDQ9CQ4zcG8PkMKTZ3+fV9M9gOga+hVj7i1zqItnL7uwT/ijAbKTW3UqCkOFtRWUCtvxQyZBJ4qAhB5yyO6oNXo/7a3G3NUSzD0RQoXEgevV7TvDNYO0KjL2Lto2yUdPYkpkTcL0k2FBpyemSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3dJBX0u17SPWkgQgHvORIovR54kNO6y8HBoe2jcpWg=;
 b=Ec+La6Mb5qpVJVosNkME5BAY4hI5Le9Xga+c4mOl6jG92+D1tsjFpA/nPZ93UCOlnScNiayL2LeSiwo9Pf93u8+jvCxWX8CIyPEnSbnSfIBJ31lPdYOTx2x6XnSy1H9ZNWZPyFANzMZiFCAUv2hZXEgFbfHcUvBYxUG+X9EFt3BpyHrjmz1grJOypn3kfRYaqpMivVCDqAcjwd0CJCs6OmOb221gjODl7IGNieOwRUxvZuZlHJ3dBI3coHVCc86Cb+52pnS0X2oXFSkwaDt/fyfTtKYdT1iUUyEDYahSoZOJIWft+rfeVhzS6hF70lZpIaLLTnqS+LKcYe9yLAAstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3dJBX0u17SPWkgQgHvORIovR54kNO6y8HBoe2jcpWg=;
 b=J258Rzd3D/7BRXHp9Fc8LgrWOq7LLvga6yEHjrDNYeuwpJR2hzAke55Lt+Nj0s3AlxiwHYM60nR3FKILXFpNJBBugbJezc+RkH6sL7xbXZBx0orHFFmiSYuKHAHhokD12XtMJj3awlPtvUQGCdrHKKHceEF2heH1ROtlesKZxiDUwGlgS3Qfj3mY9zyUakGYN2WPgyEeb+H6D/MXKq1voy8DBoT/+vn0zNe99E+PA4SUC+furqcTL5LdVJnhCG+3InI8t7dcAVEQwIwaFvMe36vuMEKhJBYAY5wxN5roDWJJbtXgVtxDd8QXDs5wTbiEjh7WcxfHxqGBHak44rn+sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBAPR04MB7255.eurprd04.prod.outlook.com (2603:10a6:10:1a9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 18:54:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 18:54:11 +0000
Date: Thu, 5 Sep 2024 14:54:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pratikmanvar09@gmail.com, francesco@dolcini.it,
	Clark Wang <xiaoning.wang@nxp.com>, Jun Li <jun.li@nxp.com>
Subject: Re: [PATCH v2 3/3] pwm: imx27: workaround of the pwm output bug when
 decrease the duty cycle
Message-ID: <Ztn+SiBUp0BC5lzy@lizhi-Precision-Tower-5810>
References: <20240715-pwm-v2-0-ff3eece83cbb@nxp.com>
 <20240715-pwm-v2-3-ff3eece83cbb@nxp.com>
 <CAOMZO5DNmHfHWbLoPj9P=_+JiLLQ4tiDd_90+UX+_psN2o+Knw@mail.gmail.com>
 <ac922fd5-9438-4f73-9a3d-08cceb1d7409@denx.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac922fd5-9438-4f73-9a3d-08cceb1d7409@denx.de>
X-ClientProxiedBy: BYAPR02CA0045.namprd02.prod.outlook.com
 (2603:10b6:a03:54::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBAPR04MB7255:EE_
X-MS-Office365-Filtering-Correlation-Id: 906e1815-9b90-4d1c-b574-08dccddc2143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVlIVWE0MXJGZEh3citHYkx6ZXZmRDV0WDMrT0hITVkvZ1FOUlVyVy81bWVw?=
 =?utf-8?B?NkVwTGY0VlU0emtDK3R0S0VJUml5cmR0ZENjTGRZeVNXUTIzdm1PanRmS25K?=
 =?utf-8?B?OTFPOXNNMTJianRXSGdZQm9DSHlIemQ2c0xGOWR6UHlsNGRLSnByVHIvb3J1?=
 =?utf-8?B?NVRhODFVN2NzT29JU2p1c0lkaDZQTFJVS2EwNWdiOHROZUw4VGsyanNnelc4?=
 =?utf-8?B?dllpVENzLzdyOCtEMTd3YXVkcDA1bE1Ta09ldG52cVdyY1Zic3VWYzVQaGVI?=
 =?utf-8?B?bmFXU251Znh0eE1kVDlaVUE4bWJQM1JGMTN1WC96U0FOVStBQmR2Z01wRUZO?=
 =?utf-8?B?QW9JRVRyOE5pSlpGTzVHK3dVQ3UxRXVISjg4YWk2RS9TTnIrRE1ONjJ2RU94?=
 =?utf-8?B?bjVaVCs1SThWeFF1WDNPM2ZESGdLdTN0ZldaSnFpOGZNRk9kRDdUay9OdTdQ?=
 =?utf-8?B?UVJjdjdZZXQwaGJKYmF4ZVl4d09nZGZRalRSU0ZHdE1BVEdIdzVhNktYV0Vm?=
 =?utf-8?B?NDBLTndOeSthNWJRWEZ4dW1oYUhRV0R1RHNyTFM0VnpuNXg0OXdxeFRmUmxn?=
 =?utf-8?B?VGxMUmhHNC9Vb25RakR0K2hkaHFHWG1WaVArK0FVV0NSMWo3SndibXREcWRt?=
 =?utf-8?B?R2RWekxwZXRXQUViYWpxSmFQQTZxTUFLZHdoTzRWNjNEM0x1SlBEc2pvNlhV?=
 =?utf-8?B?cDhyTmJaQ0IzZXc4L3RKa0NUMTlYdHBNdENPbFoyMlJPSWZsZTdJTk9CdENt?=
 =?utf-8?B?WGNsaVhQWGpJZmE5UHhGeGYrWlRzcVAyR3R2QWVQVXM3UTJGbk1MSW9vTDdq?=
 =?utf-8?B?RWJERFRTOEsrak5pOGZYUXpEQnRVRG1yTkpGK05CTzgwRFBLSWlrczAwSDVx?=
 =?utf-8?B?bnNJTHFEcEJMb1lRMCt4Rmg2c2FXNTl0NEoyV1lBR0wrT2hNOW0waHNRNmE4?=
 =?utf-8?B?QjE4R1BZeXE1R0xSVENReUlQTFVmOGdLT3NlaWNpT21yYWc3SkxkY1hvbUxG?=
 =?utf-8?B?TlVSYVlhYzRlVGdhTVh0eFlxdVNKdE9XSFlPZCtuUjhLallvWW1zdC8rbXFn?=
 =?utf-8?B?WFFDcnhDSmVoVVJnY09vcktrTlJZVHU1NlFFc29jSDJ1TEVnNEZrSDhwcks4?=
 =?utf-8?B?bFRLTVNEMUNSUFd5blI3b2w1d0h3YkJlVjA5UEVodmRXdW9qcnh1NWZOT2ps?=
 =?utf-8?B?S1pYNjVuVmhDOGxxMzBiZHR4L2VkMTVBT3AzYTB2K0U2bFYwMWJNR1h6Zmht?=
 =?utf-8?B?YTBXZDZUUE5Fb25qVUNnUFhMRk1MTE1DZ0kyWXdYK2FZbnAwZzdra2F1cmJF?=
 =?utf-8?B?dDl6VllLVkxSck05R3ZPcVUycFlGenR2UGNyUUt1NHZiQkYrUjhhVzRUV256?=
 =?utf-8?B?Ymc1MDE5MEFpRjRBNmpVNUtLUVRqdzJtTGg3aDUvSjdBR1c2UHc0eitZbkxQ?=
 =?utf-8?B?eWVBdHk2UDJYZXJpMzcvMFBIUjE2ZzBlcDFLdkR1bndmakRydjkrUlBhM2VE?=
 =?utf-8?B?ay9YUGlrVjNXSG91OFRKYWZqMWU1Ky9BT3JvdGdOWnlsZGxxUHhSM2dvaVVY?=
 =?utf-8?B?QTREMnlxSTBRa0h2RG9Ock9qMlNFTjZwVTErL05nRmNzdWhWOW9sME5HUUc2?=
 =?utf-8?B?NTQzMDRSbmwzaThUMFpOMEU2cTZybzJaQ0dKNVVSeXNxOWpXamsra3FmK0Ur?=
 =?utf-8?B?Ykd6Mk0wa2oyd1dXMnhNSEQvcGlENVQvcUN4KzRDZm90WEZOVnNObUVEdEVz?=
 =?utf-8?B?aVZWMFlPMFRCTzc3QkNVNnhCSjQveTF5ZEowMHU5YjYvclZiN0x5d0s3VEhJ?=
 =?utf-8?B?MjcxdWw5MkZ4OTMwK2F4Z2F2eHhSdHV3SElCTi9zRzhGWEdycGNEWUNKMGh4?=
 =?utf-8?B?MHZaVlBlaHFudWhReEt3VlFVQllJUklvZzRlUlhsV2djK1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2lYQ25Sa2ZEV2EzZ25WRlVSenBrUGhMbUFucExOYVNKZ1RBK2MrVUJBRTVD?=
 =?utf-8?B?ZUtFS29GeDZjU3BubEtJUG5sTnU3V001ZlYxRko1NHJEQmRwb25hYXpTOVor?=
 =?utf-8?B?QUtGNVdnVkptMG1PdjZZM0RqaXNMbDZEZGZUODFVV1lrc0NKS0ZrQVNGN0dE?=
 =?utf-8?B?UEdhV1FZWnNmdlJjZ2Uvd3FEZUdhYzlIWHBIZnpGQXJsV3hQMnFvdkxrMWZX?=
 =?utf-8?B?bTU3TWtaNDdyZWFoQUJCSnhPdmJUSE9maHFNRWl0VWEwUVZJWmE0TmpnbmZM?=
 =?utf-8?B?cHN6N3FQbFdEN1JwM2RRK2VGWUFaUkdkOGdMUzdIckVuUmxYdlEyencyK2Ry?=
 =?utf-8?B?THhHMHg1cmhkWTFIZVZod0wwUGxhQUZWazFISHVIYnJPODk5MzVGS2RNNjNS?=
 =?utf-8?B?SFE1OEpLMFBWbXRWdVRLenVRZ1MzWmdKUFh1TzN2MjNWbm9pMGtJbXFpbjJr?=
 =?utf-8?B?NjY5bDFNYWRrNEFIVnN2UVlLTU9tbFRKWVVWZ2pjWnVuZGF0YXV5ckw2UldL?=
 =?utf-8?B?RGhKYjN2aklaVk9JU3gxL2tDSkJDcGtjdkZFTEdwVnp2WWU2RE5rSkdtUDFT?=
 =?utf-8?B?L213eHJidUU4WXIxRnNHeFBKeCtYNTMrOFgxeEs5WmwzYWQvcksrSjNYVUpC?=
 =?utf-8?B?L3VuczhQSEJTZFhWRko0dmJFWGl2dXduVFFnbXg5dkRKWHhXcytxYlRGM2RK?=
 =?utf-8?B?ZlpkUnEvc2FWNVIvVTRKNWRoOFhhQndENWxxU2dqcWhzcWdVaXFjeGl2cE14?=
 =?utf-8?B?UXdTVk1rKzJZcXBxY1A0NUpMZWdqaWk3VWU2ZElhOURTUzZSZHZpRkhNNER5?=
 =?utf-8?B?VmN6RVE5TVJ3N1ZrSldsVkpPaGpSeGRoa2pzckdoeStEdjF4ZTdOVWFBMldj?=
 =?utf-8?B?V0k5bEJTR3dYb1VHZ3NYMmJRNndORlJZK2JZRUR4SGJyWlh4OHNrTkNLTWFW?=
 =?utf-8?B?MEh4RnNsaUF6d0Q2anF6ZDlqZUtnMllFTFFUSkx5U24vbVRrOWRtWkowTDRY?=
 =?utf-8?B?TTFGMzRyZkYwbFpRNEdCbmZpZWJ4SlVEdU94aXY1cGh1ZU55NzYvQ0VmM3J2?=
 =?utf-8?B?bG5STTBxNU41V1NtZTBDNGxHVXd4VXcvVUlHNkFxS0FUQ3pkNlFpY3p5TzlR?=
 =?utf-8?B?L0FBSXhDYlNZLzBTMzRnR293azBoeXV4Y1hLQ0FNNUx2dkt5eVZ1L3p0WmdO?=
 =?utf-8?B?NjlpbysrcEdFWkNnSmNEbkFnM1luWGprK2VKZHFlU1EvS2JrVFZaLzZabEFW?=
 =?utf-8?B?QksyQThPQ1hPRmlpQVZOSTl1enRmNVF2ZVRTTWQ3YWFmNWlSaUlaaDFuKzFp?=
 =?utf-8?B?elQ0SHF1dEt6UEI5bEwyQU5iLzhMRGVMeFRGSUJXaVBEUEpwS0twZDh2RVpH?=
 =?utf-8?B?WjRpMGVzcnVQaUJrZnIwMDZhYnRvamZlWFlQOHJzSGpvclNLbXQxazZvQnli?=
 =?utf-8?B?VHprUUllN0Q2RzQzY1JBTGswNnM3aTE2dEdrWG1HSmxrT085S3NXcDBncjNs?=
 =?utf-8?B?bEdqZ2N0cVJzcmMzTHJ0ZjAzQlFOV2NNYnVHYmF5SGkzMEVOWXdZYmIwSTl2?=
 =?utf-8?B?QXdiU1o0ZkdJTmVaWmFaUlIyTUpaY0ZsczZvSlpVN2dJblJvcHJaV2lzejZU?=
 =?utf-8?B?dUZlRzdGY2RkRXZhK3JCYW9zZmRZNno5amtpK2JkbGY0dU1pYzBCU1ltYVZl?=
 =?utf-8?B?dHRoZ2NLcURIcVorWmhVakZJcEUvMzJpSWJqakFZcVI0MmxFMEZaNmcybGZQ?=
 =?utf-8?B?Mm55UEZTN3lENkRKSXZORGpRM0lhV2tKbzBteEhCYkc3TWxEdG8ydElrYWhj?=
 =?utf-8?B?cUtJa040RlFjK0s4ODdDKzVFNGx1TTF1azhsSUh4RldsamdodXlxNVBFa1Rk?=
 =?utf-8?B?SXFSUldWTUliS0FUeWI5NEM3emk0NXducjZDdnhVaFRDb3cvNEdIT1Yya1JR?=
 =?utf-8?B?RnVZYm0raFI3ckZ4VVNIbHkwdk9ON2Y4bGhacGVxSEVxV2tkSC80TERqQ01M?=
 =?utf-8?B?MlFGWHlnV0N4b2puY3lSZldMTnViSTl3MVNiZ2VtN1ZPelNUd3NldHB4Mjh2?=
 =?utf-8?B?U3htR291cy9xMUhYcUZXZ0NobkF0MmZUMHB1SzhnOSsyNTRrOWt6Ly9XSWdX?=
 =?utf-8?Q?bo4E=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906e1815-9b90-4d1c-b574-08dccddc2143
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 18:54:11.5215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dvUxf6dPiw2PwKKhbXM1bkCK4cmPe9TnS2WJTdOhPQ3ict8I6pIS66x6BVyqaGXbazkpnycyyzAgqmrrozsUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7255

On Thu, Sep 05, 2024 at 08:26:34PM +0200, Marek Vasut wrote:
> On 9/5/24 7:12 PM, Fabio Estevam wrote:
> > Adding Marek.
> >
> > On Mon, Jul 15, 2024 at 5:30 PM Frank Li <Frank.Li@nxp.com> wrote:
> > >
> > > From: Clark Wang <xiaoning.wang@nxp.com>
> > >
> > > Implement workaround for ERR051198
> > > (https://www.nxp.com/docs/en/errata/IMX8MN_0N14Y.pdf)
> > >
> > > PWM output may not function correctly if the FIFO is empty when a new SAR
> > > value is programmed
> > >
> > > Description:
> > >    When the PWM FIFO is empty, a new value programmed to the PWM Sample
> > >    register (PWM_PWMSAR) will be directly applied even if the current timer
> > >    period has not expired. If the new SAMPLE value programmed in the
> > >    PWM_PWMSAR register is less than the previous value, and the PWM counter
> > >    register (PWM_PWMCNR) that contains the current COUNT value is greater
> > >    than the new programmed SAMPLE value, the current period will not flip
> > >    the level. This may result in an output pulse with a duty cycle of 100%.
> > >
> > > Workaround:
> > >    Program the current SAMPLE value in the PWM_PWMSAR register before
> > >    updating the new duty cycle to the SAMPLE value in the PWM_PWMSAR
> > >    register. This will ensure that the new SAMPLE value is modified during
> > >    a non-empty FIFO, and can be successfully updated after the period
> > >    expires.
>
> Frank, could you submit this patch separately ? The 1/3 and 2/3 are
> unrelated as far as I can tell ?
>
> > > ---
> > > Change from v1 to v2
> > > - address comments in https://lore.kernel.org/linux-pwm/20211221095053.uz4qbnhdqziftymw@pengutronix.de/
> > >    About disable/enable pwm instead of disable/enable irq:
> > >    Some pmw periphal may sensitive to period. Disable/enable pwm will
> > > increase period, althouhg it is okay for most case, such as LED backlight
> > > or FAN speed. But some device such servo may require strict period.
> > >
> > > - address comments in https://lore.kernel.org/linux-pwm/d72d1ae5-0378-4bac-8b77-0bb69f55accd@gmx.net/
> > >    Using official errata number
> > >    fix typo 'filp'
> > >    add {} for else
> > >
> > > I supposed fixed all previous issues, let me know if I missed one.
> > > ---
> > >   drivers/pwm/pwm-imx27.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
> > >   1 file changed, 51 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> > > index 253afe94c4776..e12eaaebe3499 100644
> > > --- a/drivers/pwm/pwm-imx27.c
> > > +++ b/drivers/pwm/pwm-imx27.c
> > > @@ -27,6 +27,7 @@
> > >   #define MX3_PWMSR                      0x04    /* PWM Status Register */
> > >   #define MX3_PWMSAR                     0x0C    /* PWM Sample Register */
> > >   #define MX3_PWMPR                      0x10    /* PWM Period Register */
> > > +#define MX3_PWMCNR                     0x14    /* PWM Counter Register */
> > >
> > >   #define MX3_PWMCR_FWM                  GENMASK(27, 26)
> > >   #define MX3_PWMCR_STOPEN               BIT(25)
> > > @@ -232,8 +233,11 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > >   {
> > >          unsigned long period_cycles, duty_cycles, prescale;
> > >          struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
> > > +       void __iomem *reg_sar = imx->mmio_base + MX3_PWMSAR;
> > >          unsigned long long c;
> > >          unsigned long long clkrate;
> > > +       unsigned long flags;
> > > +       int val;
> > >          int ret;
> > >          u32 cr;
> > >
> > > @@ -274,7 +278,53 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > >                  pwm_imx27_sw_reset(chip);
> > >          }
> > >
> > > -       writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
> > > +       /*
> > > +        * This is a limited workaround. When the SAR FIFO is empty, the new
> > > +        * write value will be directly applied to SAR even the current period
> > > +        * is not over.
> > > +        *
> > > +        * If the new SAR value is less than the old one, and the counter is
> > > +        * greater than the new SAR value, the current period will not filp
> > > +        * the level. This will result in a pulse with a duty cycle of 100%.
> > > +        * So, writing the current value of the SAR to SAR here before updating
> > > +        * the new SAR value can avoid this issue.
> > > +        *
> > > +        * Add a spin lock and turn off the interrupt to ensure that the
> > > +        * real-time performance can be guaranteed as much as possible when
> > > +        * operating the following operations.
> > > +        *
> > > +        * 1. Add a threshold of 1.5us. If the time T between the read current
> > > +        * count value CNR and the end of the cycle is less than 1.5us, wait
> > > +        * for T to be longer than 1.5us before updating the SAR register.
> > > +        * This is to avoid the situation that when the first SAR is written,
> > > +        * the current cycle just ends and the SAR FIFO that just be written
> > > +        * is emptied again.
> > > +        *
> > > +        * 2. Use __raw_writel() to minimize the interval between two writes to
> > > +        * the SAR register to increase the fastest pwm frequency supported.
> > > +        *
> > > +        * When the PWM period is longer than 2us(or <500KHz), this workaround
> > > +        * can solve this problem.
> > > +        */
> > > +       val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> > > +       if (duty_cycles < imx->duty_cycle && val < MX3_PWMSR_FIFOAV_2WORDS) {
> > > +               c = clkrate * 1500;
> > > +               do_div(c, NSEC_PER_SEC);
> > > +
> > > +               local_irq_save(flags);
> > > +               if (state->period >= 2000)
> > > +                       readl_poll_timeout_atomic(imx->mmio_base + MX3_PWMCNR, val,
> > > +                                                 period_cycles - val >= c, 0, 10);
> > > +
> > > +               val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base + MX3_PWMSR));
> > > +               if (!val)
> > > +                       writel_relaxed(imx->duty_cycle, reg_sar);
> > > +               writel_relaxed(duty_cycles, reg_sar);
> > > +               local_irq_restore(flags);
> > > +       } else {
> > > +               writel_relaxed(duty_cycles, reg_sar);
> > > +       }
>
> Why so complicated ? Can't this be simplified to this ?
>
> const u32 sar[3] = { old_sar, old_sar, new_sar };
>
> val = FIELD_GET(MX3_PWMSR_FIFOAV, readl_relaxed(imx->mmio_base +
> MX3_PWMSR));
>
> switch (val) {
> case MX3_PWMSR_FIFOAV_EMPTY:
> case MX3_PWMSR_FIFOAV_1WORD:
>   writesl(duty_cycles, sar, 3);
>   break;
> case MX3_PWMSR_FIFOAV_2WORDS:
>   writesl(duty_cycles, sar + 1, 2);
>   break;
> default: // 3 words in FIFO
>   writel(new_sar, duty_cycles);
> }
>
> The MX3_PWMSR_FIFOAV_EMPTY/MX3_PWMSR_FIFOAV_1WORD case will effectively
> trigger three consecutive 'str' instructions:
>
> 1: str PWMSAR, old_sar
> 2: str PWMSAR, old_sar
> 3: str PWMSAR, new_sar
>
> If the PWM cycle ends before 1:, then PWM will reload old value, then pick
> old value from 1:, 2: and then new value from 3: -- the FIFO will never be
> empty.
>
> If the PWM cycle ends after 1:, then PWM will pick up old value from 1:
> which is now in FIFO, 2: and then new value from 3: -- the FIFO will never
> be empty.
>
> The MX3_PWMSR_FIFOAV_2WORDS and default: case is there to prevent FIFO
> overflow which may lock up the PWM. In case of MX3_PWMSR_FIFOAV_2WORDS there
> are two words in the FIFO, write two more, old SAR value and new SAR value.
> In case of default, there must be at least one free slot in the PWM FIFO
> because pwm_imx27_wait_fifo_slot() which polled the FIFO for free slot
> above, so there is no danger of FIFO being empty or FIFO overflow.
>
> Maybe this can still be isolated to "if (duty_cycles < imx->duty_cycle)" .
>
> What do you think ?

Reasonable. Let me test it.

Frank

>
> > >          writel(period_cycles, imx->mmio_base + MX3_PWMPR);

