Return-Path: <linux-pwm+bounces-2214-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AEC8CBAE5
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 08:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76E4A282C38
	for <lists+linux-pwm@lfdr.de>; Wed, 22 May 2024 06:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FF054784;
	Wed, 22 May 2024 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="UCY6ZJPh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11021007.outbound.protection.outlook.com [52.101.133.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA3360;
	Wed, 22 May 2024 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716357770; cv=fail; b=ZcnvlCemgfBT/S53aNtMsU1Wac3WFUbXbJVFKDw8HjF3jMOubgpndsQaHQVUpf5mnWeKQ6dkYfhFFhC/A3mcQrxrRJ860On/r90UlRPRAm3JTKWenbZnig5JmxRMFGLbSt+GwkJleozDwZ+SrxCrNXpkLKHs9Ow6xoD8OZSNxDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716357770; c=relaxed/simple;
	bh=MoGUUatNV5L8nk3dyhA1zAV+ydPMsUr8x39yW0oKpco=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mg2LHThTvN1TxST31Ps1YHa+IYqyquwGKuDLtOts0j7IvkaruqdSj08nCh6IF2BVsgtJy0GSgiSLgtuco5cXKQJ5itwqUpAxx/0vVJFVqgdIyOB8wl0aE9VwUwvLJokJGQGy7OZINct1woG92h4N+KqBoj0jhHiWuchkcRjSR88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=UCY6ZJPh; arc=fail smtp.client-ip=52.101.133.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7l6jHua6bmXSeXb9Yb+RpsnxDiPZxRhi+8u8kjXvCtNvGqZ08eoaI4+X1YxnqRDrcYWFX6lbHgScMgDbyj/+obhnH7WU1mXWPopEiiwN5tCcdtXnvCinHNaoZoujMKAG9/PM9bCOhl9c7R4VVhsDPEGI2aoCLBCCAtSqZbVHSFxAhR+vB4LHgBcRamNO3k3gOVJ/x6NrSLNydD3Qon/TnVWrS+c+rOFEMhDJWF3aCGPMfqcQyTF26yc4DCFLn+NDnIVNJF6jEQx/NmMAXEP65sOOhci8fRRQQ3EcjPODavPH307XH0/tFoMR1Z6Z6ZbmzMeqR7FIoNXHoPv8fYS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NdsCMUFEMUP0t/WCjrjOlu4+egumM9O4MZe0kqf+jc=;
 b=TN7+2Zv6fSX1EIISRh1J2B3imXxbm/MTBMMybwagt6gtsEQnmapkRIM7lwkcgp6hKeIqAcPIf1P/mHF1S2OQAHKhruNiUoBNLcfTK//oSwYpvxr5cjzRfOqmani/SmE7juFENSb34F5k+EFEzHbTMMqY/916LndvoP8ATnLAkSjHR+YPcX8gayNPcsSL1nX2DOVusVTdxRPLGaPXSprrpHITMYHZ8V7ksAC+y+WXiQT92mdM/6EJTjCeKLLtkNge67+m2ebBMkgxBRAuJ6pvZuEUwa5OXSG7CyaD4KuZa9y3NoIEBlFwlIH1AHIDSPECwJpvptkQpfeAUyUIhUv1yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NdsCMUFEMUP0t/WCjrjOlu4+egumM9O4MZe0kqf+jc=;
 b=UCY6ZJPhKB+ML7r+SXs+Ban/qHzPnVTvAi+kvJUmrSxJfU+udnPwdUGP3xvNo1VS+4+qa4zfM8UUvmzdVBUw7mLaXN9e2AXOMmNCM3GYMHNgM6qAdc1yxJcFUpW+qImrlRoCDJvTLSBYtzHmO4x/jFmTtEkS/y9h1COlnavXxl/z2YwnpkT2I0PhVXcr4BP6kewvLHDnP6eAAeawAbS49ke8Uuwwgd+yUSP62vIQRDtVMULt8mbZ4obuEEw7v2gRoZmYMSdUgFQ3YPc+3j494iJHsFs53cxMs/tNOMq5nDgDgOdse14mQ5S41y/UZNklD2Cu5mpUrgtICF/nklK5lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
 by KL1PR03MB6899.apcprd03.prod.outlook.com (2603:1096:820:9e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.16; Wed, 22 May
 2024 06:02:43 +0000
Received: from TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::340d:421c:7221:56e6]) by TYZPR03MB5743.apcprd03.prod.outlook.com
 ([fe80::340d:421c:7221:56e6%7]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 06:02:42 +0000
Message-ID: <7e8d7140-b119-4d12-a10c-216c1426c40c@amlogic.com>
Date: Wed, 22 May 2024 14:02:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH v5 1/2] pwm: meson: Add support
 for Amlogic S4 PWM
Content-Language: en-GB
To: George Stark <gnstark@salutedevices.com>, kelvin.zhang@amlogic.com,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 "kernel@salutedevices.com" <kernel@salutedevices.com>
References: <20240521-s4-pwm-v5-0-0c91f5fa32cd@amlogic.com>
 <20240521-s4-pwm-v5-1-0c91f5fa32cd@amlogic.com>
 <4fd9fe90-1da0-4b8c-8bc4-18b7a4dc38ab@salutedevices.com>
From: Junyi Zhao <junyi.zhao@amlogic.com>
In-Reply-To: <4fd9fe90-1da0-4b8c-8bc4-18b7a4dc38ab@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To TYZPR03MB5743.apcprd03.prod.outlook.com (2603:1096:400:74::7)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB5743:EE_|KL1PR03MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 926daccc-b809-419e-9cb5-08dc7a24cb34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckdieXh5MzBPR1p1ell1MDYrMFVSRWNJcGlGNDU2L0l3V3JWRUlYYXc4ZDZZ?=
 =?utf-8?B?M0IvZVFlMWYrNDNWbVJ0eU5oRDR2dU5rbzJ5aVNzNEhpR0laMXFWQ1NsempC?=
 =?utf-8?B?V3dlYlY4WlI4Zm81bUFrbk1YNHltbUFUcXV3WittRVlxMVdFenZKTmR0cllo?=
 =?utf-8?B?bjBDWUhqR2V6Y3BycEJ1Ui80S1NMKzdTM0hlOWRzTTExeFgydXprcnViNWNZ?=
 =?utf-8?B?eVUxNmxVWHhKMHpzSkV5TjBKSFV4NkdqWTM5Z2NoSGhQRUdVZ29ndTZqdWdU?=
 =?utf-8?B?VVBkdWJsWFplenlwdHpzTVArMGlEN05WcWw0YVoybzNvZ0l5cXZYV0hjcjRR?=
 =?utf-8?B?T0pLZGtMd1VCb0hsQXk1VjRGcnVyTW5pTER0Y2ZKZXhaVWdxQldubjdNYWRi?=
 =?utf-8?B?QUdNakhPajFUZEsvTm1xcVZZd1c3K1VJb3AzK2txc1FOalBubHpVY1hNRG1j?=
 =?utf-8?B?dDBUenJ3WWVIczQrb0JoZEI5cEFFQ2hvcDJUSEZNeE5NZnF1UGpwc1pySWlv?=
 =?utf-8?B?MkZDTTZNbDc2VjExLzBhSjkxVkdHYnNEai92dm44QkV2dUFKNlNNaE93OElF?=
 =?utf-8?B?MzA1OTl3ajEvUDdSR2ROZ3lQblJUdzJ5K3JVNXcxeG9IUVh1Tkt3cUZ6NmpV?=
 =?utf-8?B?WTFoZHlOeGJkU0xuclRFR2V0U3hDSTNxYjY5R3ZFaHl4bWwrbWFwTmxzc3NE?=
 =?utf-8?B?SmtqU0YrOEdqeExJNkptRUg0Wm11ZXd4Z1QzcSt5NHFmMHhtdk00N2JZSWRQ?=
 =?utf-8?B?R0p6Mjd2WlUvNE1COU5qKytjWUkvYy9iSnA4cFFCN2VXd1NKQ0tFbEQwSzNM?=
 =?utf-8?B?NVpsb0pPUDBWSGZ2L20wZW5WSDJkZGtwYmNWV3N5WGNBYlVjZVhVK0xoZktN?=
 =?utf-8?B?N0pxY0Q0aTlrL3RmQ1BtQm9MYy9jMHdZbmFiOW5teXlEVUkvaGJFS0RRTzFG?=
 =?utf-8?B?UXAwdEQ0OWExR2ZKcWxwY25jQVJBTXFRaDlYcG5zZUE4UzNjNVRxbk5FRk9l?=
 =?utf-8?B?TTlweTNPMmlEUkJQdmpJcmNIOUI2Z2pvVVMzWkd4WW9ZaVdUR0h3bzc5Zkd6?=
 =?utf-8?B?VThiditxUUJHcm5zQ1JEZHBWcTVvYnB6cmJqRHQyQ25oY2pDV2dZV1M3WUFE?=
 =?utf-8?B?SldHeitWU1NmaGVBSmk4eE5Wci9ZSUlQY1FodTNONjcvNVEyNWY2bDY4SkN1?=
 =?utf-8?B?c3pXTWJyR0ZCL3hkcTJ5WTErdjQyQVZPVDRiNHZDaWFaZmVUVU9IbHFsLzgx?=
 =?utf-8?B?Rmk3bTVJZzQ0Nll4dXVlUGtIVlhXT0xGUkJrcUNpWWkvVmxobkxFK1Rma0tD?=
 =?utf-8?B?czNTSUtMaEFSWjJGamlHVjF1bHdNVWl5YTdQbHF4cnNmeHZWQXFxaFl3ZXdF?=
 =?utf-8?B?OG4wcVRJM3NCN3Z3V3RhQ2dhQVkxRkUzU3o4WlRScXhpWmduOWg0MXMwMWFx?=
 =?utf-8?B?UFRtR0ZuZHlLeCtacW9xS2lqL3l1Q0xNYzd2OGplV0NTMUlUeVhqT0p1RWFQ?=
 =?utf-8?B?UG5TdzljWHRnRzZ1SnJSaHBsVVU2WS9YNjJwMUhRTW40WFpvR2hoV0NqUHZQ?=
 =?utf-8?B?TVpiRTBzbHVEdE5TZktPNkMwLzBvVXVUU2tMRjlKbWxCdGt1Wld5azUyU0xy?=
 =?utf-8?B?RmNYTTh2Skl4SzhkeVZtdjZNTzQwOVVEdWNjd0YwTldzRVhJWXFaamYySTN3?=
 =?utf-8?B?TjVCQlk5K01tMEMzTzJ3bHByVHRGQ0s1eElBZmw5bjBORm1Fa3ZCQVNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5743.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTIxREp4RXM3ZGtUUjNpQVNXSisrT0Qra2todzRIalo2dDZpWThjYW9TVEJt?=
 =?utf-8?B?TUlVWnJXYU85V1F4VWlxUS9ISGxJN09TMjBaa0p2blB2eEFKcUs1cCtpRHMv?=
 =?utf-8?B?alRrSCtESjlrakovbXR1Y0NCTnZyNFljYUV3QnRzY3dGN2pWcHZnUlBEMVl1?=
 =?utf-8?B?aU02YUJoQlNBZFpuaUhsUjc4bTlxZjJDanI4TnltYkFpbG1IaWNqSnlDbldQ?=
 =?utf-8?B?TFVFL2NWdnpRdGtTYnQ0cHBrc2E5c0J6alFtcFlqUS9KV2sySXlwU1ZWY1li?=
 =?utf-8?B?OVZUWldUWCtxMHZEZHVYYzZVUzlBRllGUDFRc1V1emY3WldncnR5b0VwM0xm?=
 =?utf-8?B?ZG9sV3cyNytDVmpZSXN0bi9tM1JDd05UOWNSbjdvTmhrTkdXbng3MUNxdTJx?=
 =?utf-8?B?cUU3dzZRYytrNFVwUXRTQm1pS3FwTXJjc3NrSzRSVTBjMk1WbnJYTmJaMEcr?=
 =?utf-8?B?Nzg1b1ZhZFdMeVpUb3VZd3dTWDRPZ09hdGo2L2EyaHVkZ3JIdi8wTmNKTmZB?=
 =?utf-8?B?Z3U4dmJhdXZpdDY0UDkxdUNneHMyclhzc2ExRUFLT3Q4ZWRneFlOQUxJRFVI?=
 =?utf-8?B?NndhZ0lsb1U5ZnRxZVc1b29HY2JXYnVNaSt4Y1M1WVlEcUhJZzVVL1NtdEVB?=
 =?utf-8?B?KzV4S2Y5aFpQVVhtN0J2Z1JUY3BudzdKVmgrZWFUUTkxVE4rQTU3R015RUpR?=
 =?utf-8?B?eXk5TjRxbEdhQmIveDN6dXBCUTZiUW5EenlCZGIvWjl2RVJQR2J3U0prRHNG?=
 =?utf-8?B?RzBkYS82RTNtd1JoUThlTGYvL3orZlVsbEtVWk9kWHVsWDVTL1J5aVFDV0VT?=
 =?utf-8?B?ZWpSS2tVNmNoRjlnUG9XaUxDeXNYM2JUUTR1eWhWWUI4Rk5SUFlNTUV6aEJO?=
 =?utf-8?B?eGxjSzFTcWtCVkxuT1V1TVVPSjNnTHJ1TWc3aVQyZTVFOFdONGR0UVVmV0pP?=
 =?utf-8?B?UDk4RFhKdnhVWFkzcjBURnJZemtDcnZLNWJCcStHWEcvQmkzMDE2TlV4M2Fm?=
 =?utf-8?B?bjVQYjI5Z25xR3JpOHEvT1M1WWpoR1FrNXd2ZURHdjFHSDJnS290RjFFZC9M?=
 =?utf-8?B?SjlOYXVSZGszT0YydmNaZ3UyNDVFZ3dGaUxtU0M3NnRkSTdiWXM3WS9iT3Rw?=
 =?utf-8?B?WjN6bHZBN1Y2V0ZhcXd3bk16K3VDWlhTOUpYRXpsZERUTFVydlFBeS9DNFAv?=
 =?utf-8?B?QUtoSGxDaUJWS1llNmlVUDVJcHV5WnZCZ2UvdmszaUdsZy96cldEcnJHT2Uw?=
 =?utf-8?B?bUlUSTJvLytBV2liSVJ6L2xHZlpLWHpwS0NmK203R0c4d0V6VDFLbUphZlA0?=
 =?utf-8?B?Y2JoZ1pKWDNSUXMwbVNSbWhCTGRRN2pIVjZGQjc5NDcvTys5Um5lQTgzQmVm?=
 =?utf-8?B?N3EycVZja2M0K0Nwa1ZOVjhCWHhLZGhxekcrUTNmRHRJeHdac3ZFSnJ1SHdv?=
 =?utf-8?B?ckdndTc2SzVDRWxraG13SEE3aXNjSVRrMUpTUDRVcVNaRzhPZ01IR1JyM0tx?=
 =?utf-8?B?TGo0enFMczdMR3lnbTZTVzZNYmRTZnhvdDhPVVJXQTgzdGFFMWMzNFZWWUUr?=
 =?utf-8?B?aStsdjRiQlZVM1Ztby9SSTZzZlhzQ0FWZUhCNnBnMmtJSCtCZU0vM2hhVi9K?=
 =?utf-8?B?Q1FodVM3dGwzSkZ3V25jaUw3L1F2bUw4bVJsNys0OWRoZm9KZjNpbUtyemdy?=
 =?utf-8?B?eXBGQjZmNWZITTlkczVBUXRuLzNRNlUxZGdHSG8vK1RCQUdUR0FsQTZvTGlh?=
 =?utf-8?B?T09pMXlqQmlJK1A5VUphTVZmUmVRdVBNeFlwR3RpM1U4dUFyTElKS3F5VHVq?=
 =?utf-8?B?K0NmR0x6ZzJ6ci9rNXh3SlVpRjMrOFltU2lLZHB1TE5zb3lIcURaalNrc0dX?=
 =?utf-8?B?amxUUmUydExDTjNoZk8zdTVEL0tXY2dCZVZRSC9GclJsbFo4Z29KcVJ2dGt0?=
 =?utf-8?B?WWpvQTdtOTNyM2VEZzJ3MWQrbDhYUC9LVEp5Y2ltWVF6cStSS1VVTklWbHFD?=
 =?utf-8?B?TDNSdlZvcGRiOVVQSVJLQXY1R1BrdDRQdDUzTXZpYS9RR2k4Nm13UWh2K0xR?=
 =?utf-8?B?MERETUkrQVhCWStOUXhvU1VYaHpwTkl5djJWTTRGUlpHaHZ1T2IvK1RiaGZk?=
 =?utf-8?Q?8iwd9ntLjkkeJ/fPYTrlpk0+B?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926daccc-b809-419e-9cb5-08dc7a24cb34
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5743.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 06:02:42.8776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGQ8lV4Oqamdmqp5pRNsbIHGI4GZUW7H0CRWVICF0GChnaX6J3hOaC7YujwFXELCgFqQy1EkpTLaAm2jugWSbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6899



On 2024/5/22 2:50, George Stark wrote:
> [ EXTERNAL EMAIL ]
> 
> Hello Kelvin, Junyi
> 
> On 5/21/24 11:31, Kelvin Zhang via B4 Relay wrote:
>> From: Junyi Zhao <junyi.zhao@amlogic.com>
>>
>> This patch adds support for Amlogic S4 PWM.
> 
> Please take a look at
> https://www.kernel.org/doc/html/v6.9/process/submitting-patches.html#describe-your-changes
> 
> It should be something like
> Add support for Amlogic S4 PWM.
> 
> 
>>
>> Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>> ---
>>   drivers/pwm/pwm-meson.c | 53 
>> +++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>
>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
>> index b2f97dfb01bb..9fea28a51921 100644
>> --- a/drivers/pwm/pwm-meson.c
>> +++ b/drivers/pwm/pwm-meson.c
>> @@ -460,6 +460,51 @@ static int 
>> meson_pwm_init_channels_meson8b_v2(struct pwm_chip *chip)
>>       return meson_pwm_init_clocks_meson8b(chip, mux_parent_data);
>>   }
>>
>> +static void meson_pwm_s4_put_clk(void *data)
>> +{
>> +     int i;
>> +     struct meson_pwm *meson;
>> +     struct meson_pwm_channel *channel;
>> +
>> +     meson = (struct meson_pwm *)data;
> You can initialize meson variable along with declaration; type casting
> is not needed
> 
>> +     for (i = 0; i < MESON_NUM_PWMS; i++) {
>> +             channel = &meson->channels[i];
>> +             clk_put(channel->clk);
>> +     }
> you can save 3 lines just by using clk_put(meson->channels[i].clk);
> 
>> +}
>> +
>> +static int meson_pwm_init_channels_meson_s4(struct pwm_chip *chip)
>> +{
>> +     int i, ret;
>> +     struct device *dev = pwmchip_parent(chip);
>> +     struct device_node *np = dev->of_node;
>> +     struct meson_pwm *meson = to_meson_pwm(chip);
>> +     struct meson_pwm_channel *channel;
>> +
>> +     for (i = 0; i < MESON_NUM_PWMS; i++) {
>> +             channel = &meson->channels[i];
>> +             channel->clk = of_clk_get(np, i);
>> +             if (IS_ERR(channel->clk)) {
>> +                     ret = PTR_ERR(channel->clk);
>> +                     dev_err_probe(dev, ret, "Failed to get clk\n");
>> +                     goto err;
>> +             }
>> +     }
>> +     ret = devm_add_action_or_reset(dev, meson_pwm_s4_put_clk, meson);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return 0;
>> +
>> +err:
>> +     while (--i >= 0) {
>> +             channel = &meson->channels[i];
>> +             clk_put(channel->clk);
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>>   static const struct meson_pwm_data pwm_meson8b_data = {
>>       .parent_names = { "xtal", NULL, "fclk_div4", "fclk_div3" },
>>       .channels_init = meson_pwm_init_channels_meson8b_legacy,
>> @@ -498,6 +543,10 @@ static const struct meson_pwm_data 
>> pwm_meson8_v2_data = {
>>       .channels_init = meson_pwm_init_channels_meson8b_v2,
>>   };
>>
>> +static const struct meson_pwm_data pwm_meson_s4_data = {
>> +     .channels_init = meson_pwm_init_channels_meson_s4,
>> +};
>> +
> according to already existing soc-specific named vars and functions
> new names should be
> static const struct meson_pwm_data pwm_s4_data
> and
> static int meson_pwm_init_channels_s4(struct pwm_chip *chip)
> 
>>   static const struct of_device_id meson_pwm_matches[] = {
>>       {
>>               .compatible = "amlogic,meson8-pwm-v2",
>> @@ -536,6 +585,10 @@ static const struct of_device_id 
>> meson_pwm_matches[] = {
>>               .compatible = "amlogic,meson-g12a-ao-pwm-cd",
>>               .data = &pwm_g12a_ao_cd_data
>>       },
>> +     {
>> +             .compatible = "amlogic,meson-s4-pwm",
>> +             .data = &pwm_meson_s4_data
>> +     },
>>       {},
>>   };
>>   MODULE_DEVICE_TABLE(of, meson_pwm_matches);
>>
> 
> -- 
> Best regards
> George
Thks for your suggestion. i will check it.
--
Junyi

