Return-Path: <linux-pwm+bounces-8371-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMJnIjGCxGnszwQAu9opvQ
	(envelope-from <linux-pwm+bounces-8371-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 01:47:45 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF04A32DB11
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 01:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5076030226A3
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2026 00:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957F21CEAC2;
	Thu, 26 Mar 2026 00:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pmBYKt+W"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010065.outbound.protection.outlook.com [52.101.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF0813B5B3;
	Thu, 26 Mar 2026 00:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774486061; cv=fail; b=r8IZTfvDW4iqxg6wCAeL71LDHykcMpcx4iDW3vO3Z8YkLGPMDgr9iPM9Id2eNiruQSDofsD1HtSgxqmASvLelaBvpn77GWzuMcYLq+x5wnzIq9LMFx8fhCzmnK5toq+lrpfzavHk09+8v/wDmny9NUVtzi+KNr6BRwC1Fh46XRI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774486061; c=relaxed/simple;
	bh=3lP5lubRtlH6JKMsphHeFwBUTLyfTgcP08PyEm4ewu4=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=MS9eKpxrBpJec8fPxPYH/ZBbs0cS4w0Vxe9zUST2RwglYhR9qmqWEzEsM4IeHRonct8eJTMJ5TANWyitCMJjHuKwuoUvkGbGfQdc3gxecWD49BLUji99DGsK6kAGJLXn95TEKWBT5KMnbzMd+GLYK6C5V8OLXDfD+UF54LwlOK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pmBYKt+W; arc=fail smtp.client-ip=52.101.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALyiS+of7iYpmCcMWZnwDqby1iecou30t0ZQrH9ghBSHSyuxDMSWm35db8LaAsRl0mOGi1emvFIXABjcH8AQIEIpisbfqMF4pLAFiUMBNl8xngaAhKcCQA8yqg+hlKeVLaMcsIwOEVJpf4YI/aNnTdpa6f5E2E1PNC4EJMWdbKxmpS3zYcI0dYaUUmG+4BzGqFiELkibx2KVaiQM14F8dEhZ/RncjAbwgoZ7GIe/CpZrB0Bj4pUyU0AK271xdifa/emvtsqclrn2tFBrb8hJ4bTbFrRKz+Eiqiq+P19bvIWy5oo5V2R4vFb9oty6xwdRsNQsu5qpDQ/KKWiG5Te2IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4QG/tK/pHb1Qt++D1wRTl3B+usucQP4K3R1xsDvV/c=;
 b=F/6OyuVeWHlkv/cgiy8RxJ8z6EfqyVCCCs7SneTKCfznakVRyRArcoilJEBwDC70HSW0S9dzG43+MSnHWjOqvxLwa2ohqaGdF5jJxTbhV3I5qtLkzhZRir9+g2VXF/jG/omibCtqh3JC2ti6SXSNaJxKyrvmt4H5BnCC8YtEFRQOEBcn7Nhht9+Z5TtEbTuFMXSzJXswdSt5YeFV/TA2kI1Wf6rPbxu4iM7S31FXMGW1VXHOntu0s+WpIrmG6iSLPHTALAJmTHbh2s+OwxGo8kkqG5eH4IqrGkGP7ltpB5z4UlcRQnsdj1SERPkun+msIvtfedS6fNAwjbQ213jdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4QG/tK/pHb1Qt++D1wRTl3B+usucQP4K3R1xsDvV/c=;
 b=pmBYKt+WQ6tfpRdDTxi/aH9wORk1RUVeacTOQlP7I84zjaVGZ37FP9gHlJmgvkQHWOK44f1yWlo44sYLfAKL5Hia/fAC7a4Voy8u+aE71LcsaNOQa1u1VfG5esrehFRgDP3RKyxl1z3EKusMBBQxxXnFX8rm4sKadiSDDhN/pNIJngzNIMVl/+i53+EjD5/3BXWZDx6R75lHIWky6NHTgAoLDPj/YGAiP9qIwu2U9cjkYpbrvDrj1j5cSA3xhEm46gaW36KjuhbCNkaFEGWXk1lB1rJiN+yQic2B5DegSJnkqp+n3F9jePMyC8APwtnI49QWYGtMeRpUKmuPDRZyEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS0PR12MB7656.namprd12.prod.outlook.com (2603:10b6:8:11f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 00:47:34 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Thu, 26 Mar 2026
 00:47:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/7] dt-bindings: pwm: Document Tegra194 and
 Tegra264 controllers
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-pwm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thierry Reding <treding@nvidia.com>
In-Reply-To: <acPuMGhPw74roB1E@orome>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
 <20260325-t264-pwm-v2-1-998d885984b3@nvidia.com> <acPuMGhPw74roB1E@orome>
Date: Thu, 26 Mar 2026 09:47:30 +0900
Message-Id: <177448605080.767719.1955302882683123394.b4-reply@b4>
X-Mailer: b4 0.16-dev-ad80c
X-ClientProxiedBy: TYCP286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS0PR12MB7656:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be0beda-3178-4e22-7376-08de8ad144dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Cn/TQwW9BfHmi+FdJMYcYNwdSRoSdEurpdSBaD2ETLJ7pbGvWSwm4IzldUcCl4FK1J0PmsaITClPxuf12bNC9J9zcyZEB5MmDQICYE32UiiJ6ga3GF4Gy5BrYznOTMPLOkQmlDFBt19qVWtv169oNLoC+QW6PfRWik6HilQKO2XVCtZUlrQpKPuv0RBOXAq5vSqplHTai8GSEGo5NJsphNarFy4qE9A7MXBx1m9bDRWXJv6xhLKKzrSsWM8ylgMVJFj/4gscvxBJETQ/vGjz7Yck4AKpxh6nsMb8SDGe39Sh+WwknOvE3PelNxMKWshokhi5FXVlBhGdsAgQHoFCj82p+Ju6vBH7o0KCWP3wUTp/CvdOAunFMqX19CJsb6EyYPMOmrgVGdmfJrWoirk0OGUiBFKww7gR9fXqOW3HuJ95u3tD4fKuI47vzJrplUXP8GKN11jn2i9N1g4SJWjI5ApBUUDqX6dgnfFewzU1eeuM9BxENuvNmWuAOYj49paO4wstqljAevzQb8dlZQTMtQmK+4/nAu3lRU//0B6ucqVHJ9qkzh/94OzJUVD2wZSETo+1zbQ9hm1jfzFWO7YVhwrtB/KBwUHCcjOc8+9Yg7nGEx3X960QRjV5NXzITp1jruc9yAd8i97lWLefbE8zP7BCvmUNa5p6QIU5osFsQnZe8btEuGSRQ5wwY43uf+kiGVpR4WnakysDSRKfDaj9UI3xJmCND4i0O6wfnZm+gaI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ykg4MUNGalpwa281R2ZTOGw1UFdvQVlGV21FV0g2RVlOcjQ0S2lHMFhHRWl2?=
 =?utf-8?B?aGRXSjdHZnhJMXFzSTB2d3I5TndNQ2ZvSUtCcU1UVWs3Y2FzMm4xR0RmcEEy?=
 =?utf-8?B?WVFJQUJ0MExoaGhzOWN2cjErL0Rzek95R245NmQvck01bmVvYnpTSEJEdzhq?=
 =?utf-8?B?Rk4raThudWhpOWtTS3JVN0d6eE8ySDNhVGMwRml0VE1wOXQ1TE82S0s4c1Yz?=
 =?utf-8?B?MCs2Z2IrY2pSOWFjYXdHanU5S0FLZjU5dzN2S2hnTTNGUTFDbTQ1NG1FOXlI?=
 =?utf-8?B?Um5UaEtoRjk4UXBFQ29vMTFmN1NyRWthZGRNMVJ6cTVKR1ZQU3JHWkNTcTEw?=
 =?utf-8?B?WmhRMlRPRE96V2x3THliZ0VMbTVGbUQ1OTRMU0JoV24vdU9reWxGUzdFTDM5?=
 =?utf-8?B?d1RxbWVERDYzVjk1NzAzM1dTd2RvRzcwYUNRYnNoUFZwZW5ZM3FJbDhWa0tq?=
 =?utf-8?B?YzJHZUNqU1pTMlhKeFN2OTR6M0puVkMvSTg5aDZzUndPbDQzMHF0LzI1U1My?=
 =?utf-8?B?eFhpeW5zdkU2TXFDQzFxMkV1TzdGRzc0M3dxNHU4aHdWeHRrZHZhbkNDZDJm?=
 =?utf-8?B?YmhPYyt5bDVDQ3ppWUtPdXMvWlBHTDFaNjFBUTlNRWY3cGpSR1ZZNzBlalpt?=
 =?utf-8?B?Z3hJcjI2M3N0U3FlV09PRlVnU1YwSUdVaFhYb2tjbmtDamRPMTFEQzFKNGlC?=
 =?utf-8?B?ZXlqUmlmSGhlV29tOWhpWjJDMllnbmhYYW5BVXZzTFdXTjlScm04YUtjbXlS?=
 =?utf-8?B?Y2xwOTdUTFBBcWF1V01jalg3dHY1Y2VORWNZWkw5K3JDMTNIdjVDUjY1N1No?=
 =?utf-8?B?R0Q5OWgvTDNSK052SC9UQWNXS2RzSlBiMW1kbDhOR3lkNTl5RTdienAzcWs5?=
 =?utf-8?B?alhUUTFnd2JSSERlRzYxU3dxYytZL0NDdjNvZ2hwVXErT3ZyNVpzYkpSSWN4?=
 =?utf-8?B?UkhQWXdFRkZ6bVJManlhTlc0YzVRWTZNMmN3dkdjQWNDUWg1NlRITytmQlp1?=
 =?utf-8?B?VVZKb0tTRFRRQ2o2T1QvMXlxV0hvd3doR1lTays4b0lKL1FjcXg3WXJmMmNV?=
 =?utf-8?B?Wkxjbitvc0luRWFuOGVTRlZqN0sxcDF5MnhXZldsVUpCZ1lhd1pmYzJQZWxV?=
 =?utf-8?B?cFBGVWY2VUdzNEhhd0psRkpvTmVVMjF5dzdlS2xFcVRhK2h1MGswQXdrZElu?=
 =?utf-8?B?cDBLT3hCSkM2b04xQmtSL2ZJUmNpREtlTnovcEVsVzZlSmQxWlpyQVV1STIy?=
 =?utf-8?B?RG4xTHJKZVNLVTQrN0p5UGtaN3BLU3RxT3pSa0VWbnJHem9GNjlnVUxTSGZF?=
 =?utf-8?B?amQySUNveUQzOFlWRTFheGtORmw1eTVXbGZkeGVmMzJZSjJGYUN5WXpPQTMw?=
 =?utf-8?B?anNMS1lCSWRSQ1FMd0NrUk1ub3o4dWNyN1hDalpTd3VyZXNqSDFvTWsrRHVI?=
 =?utf-8?B?Nnh2cHJSYjN0RXMwa24zN2hVTVdZenFOTWJOQjJ2RHR2Z0lpNmNQRERxa0d1?=
 =?utf-8?B?NU81TEZYaWQ5WFJtK1BtNWwxSTNNcmZTRFN1Yys1N25YTnlGYWltdkZ0M0l5?=
 =?utf-8?B?M2RDL0dNS094VFdUN200ZlZUT0tiWWxrV1ZYQ0MwUVEwd1RxcGZ2NTlCZWR5?=
 =?utf-8?B?ZjJMaGF6eVBrZmRKcE5GMGpyZ2lEbmZmM2hFYzQ0Nll3UWQwcFhHOTNjdjlZ?=
 =?utf-8?B?ZHhMR1pyZGw3b1ppenNBWkJrQVJYNDFwMUI4OXJJL1Z6Z2ptSGNMSlpHNThu?=
 =?utf-8?B?ZVh1YnV0TzIyRzV2Y1FSVXgydGhPSityaVFSbjRtVnd2WnowemFHcHM2RHlQ?=
 =?utf-8?B?RStPMWVRSmF2TThsZExDcXJ6SFA0M2pRTnQ3em1jQThsblZNSU1VWnJia1l1?=
 =?utf-8?B?dm8yeTJtOE5zcGdKSlZKZ09qNTg1Tys0clAwNnVmYWdIMVhzakZrQzNEcWlY?=
 =?utf-8?B?cTcwUnBIWDMyUWpydVVUaWQwTC9MeDRNbXdQK0d0WXA2THo4UTBqMnAvL3g4?=
 =?utf-8?B?VnZuTytaRk9JTnRYeTA4bGJUbXdkUHpwTnRaVVVVSW0ySnVPYnYxSHgwQlQ4?=
 =?utf-8?B?amdFQ3JpNlhnMndYVmttVUs0SG15SXpQcUJGaCtWQUg3cUVlUnR2K2ZkMjF2?=
 =?utf-8?B?YmtycXltVDF1eVFkaElOcTc0SnY1RmFKZlVhNHlpNEdWc1J0KzFnSEsxaGhL?=
 =?utf-8?B?elI4RmxPWG9QbVZLeWhWaGFXa1dpU0VDRWd3QnN1bW8zbElidzliMkt0aUJS?=
 =?utf-8?B?WFV0V2NvbGRYMnVSS1huN2I5OGc5ZFM1WmNyWjNYcVlHczZmS0R6TUkrbmxC?=
 =?utf-8?B?RDh0TGpmMnJwSGV3ZnBRTm02LzQvMVJjd1Z5WWZaRTRHV0QrUDFpM3hoYXNR?=
 =?utf-8?Q?zyUWMT1crNaXVGTHAtF036D6ovBBaEkeEDq1yV0xt3snS?=
X-MS-Exchange-AntiSpam-MessageData-1: DY37qynPNEyUQg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be0beda-3178-4e22-7376-08de8ad144dc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 00:47:34.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fbNbXhALBb00OOAFBGUDQg1GUL9OgRbkBeGFMbMmORgXsm76qJuYOjlfp98K7RMZdEH9JnX+xvSnwMiT1b9Oow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7656
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8371-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF04A32DB11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-03-25 15:22 +0100, Thierry Reding wrote:
> On Wed, Mar 25, 2026 at 07:16:59PM +0900, Mikko Perttunen wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > The PWM controller found on Tegra264 is largely compatible with the one
> > on prior generations, but it comes with some extra features, hence a new
> > compatible string is needed.
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >  Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> > index 41cea4979132..15706d2a808d 100644
> > --- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> > +++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
> > @@ -16,6 +16,8 @@ properties:
> >        - enum:
> >            - nvidia,tegra20-pwm
> >            - nvidia,tegra186-pwm
> > +          - nvidia,tegra194-pwm
> > +          - nvidia,tegra264-pwm
> 
> I think this was lost during the earlier conversation we had on the
> split of these patches. Krzysztof had pointed out that tegra194-pwm is
> now a duplicate entry. I don't know exactly how it ended up like this,
> but I'm pretty sure what I meant was:
> 
> 	- items:
> 	    - const: tegra264-pwm
> 	    - const: tegra194-pwm

Ah, I see now.

> 
> This mirrors the fact that this is in fact backwards-compatible with
> Tegra194 but also has additional features that we need the Tegra264
> compatible string for.

The Tegra264 PWM controller is in fact not backwards compatible with
Tegra194. It is close but not quite. I will drop the duplicate tegra194
compatible string and update the commit message accordingly.

Mikko

> 
> Krzysztof also requested that we drop the latter part of, or reword, the
> commit message because we always want the compatible string to be added,
> regardless of backwards-compatibility, etc.
> 
> So I think maybe something like this would be better for the commit
> message:
> 
>   The PWM controller found on Tegra264 is largely compatible with the one
>   on prior generations, but it comes with some extra features. The new
>   Tegra264-specific compatible string can be used to distinguish between
>   the feature sets.
> 
> Thierry



