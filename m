Return-Path: <linux-pwm+bounces-9724-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T/eKHl4IV2rUEQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9724-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 06:11:10 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB2075A69C
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 06:11:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=n0TFYGRi;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9724-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9724-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CFAC302DEBE
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 04:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E8C3ACF0A;
	Wed, 15 Jul 2026 04:11:08 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011020.outbound.protection.outlook.com [40.107.208.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA853845A2;
	Wed, 15 Jul 2026 04:11:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784088667; cv=fail; b=jwtZmRm752yfaF7e4z3FWJdHuYwgk8fBjeVVeWF+VQEvslwEKmk0JzHL8It3okLonjDVvxHOifWukuzJVo/QmPxrW12Etq1riAOglNzpiXS4jsm/rDO+Erz2EDS1Df3xX9zO6IQo85GWYPlj9BfRB9+MyNJDfUdcYcE89azv8Po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784088667; c=relaxed/simple;
	bh=AakGlgTpjfPU3v1ZW5wz00OY/bIV7iOivbQvW7t/nqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s2eT/MPsKANzlQzi7eiig+WToYVs5NgjEZOV36BJ1r/ahf4bUSALVV4ScxXEBXgFtcvS4U+7QVwwbuCMF/9H7X9O/RV1C06nFLY62tNs0HzfA/mnXm/hNQ8odl8u1+HcFDGyxJe0tnfbNyhp8LXEUPc+YOeVS+oe0CTD+2Dc5WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=n0TFYGRi; arc=fail smtp.client-ip=40.107.208.20
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9hkqFbC0UsUb4jeqYjUpfuK3EtywQK6MDehohhZt73G8t5UWay3pnRWZ0PeoW1AEJqPLIzm6QZAAxKbrp9I9/POdO6OF7LmOW9WddJRFPgh7/wGsBtntJBlFQ+EneQS4bWHfaZX7gW678ylrFdi2+0UWjBTRHQurmmgI+zH9Fns0hjOAbimEYB1r7uurKHv+okID/GgRWN/qeAdriIYI/7Pedj0v1Or73f8SesFYMi/iyLX7jUptOpy8lFvhQeRuuDvBwR6ZCJ7300wKSEf3Ag1hnEEXDgksLu3Uyc+N64DhiD0XA6mHmSrLyCFLFqezSy9ZiS60mAiHQR5tluNFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpgSd+K6tuMw91EmggxhkQQpESgI87g7jFr45xjb2So=;
 b=e9qzZ9mokyb8CNxITkQjSrLtEkobdkegGJLwpaUh6Umbw4G1bpcrdxOgo2iDihf0Ki0WFp7NtoIiHtOZP6txzL810vo82thguPmeWXgRVF1oSrfH2jNSwAbf8izxudDLJJ/vpyp+AiujS3/TeiuNVz5GkqF5Fn6SeUSd8RemQcD3X3oZ4KGvE1C874eCf/2fCv6AkuXOWY/uA/U2m7F6wVCMGW9HQnyVBGDJrkvkFBZzKghibNshnqhyVo4Rh9MhD1wnR0FowwJXCFs/+MwuvwmwI4Vo9yobmpEct66OyV+f814xLUm1ebXvuhW9omPTJfxFxHZ4EBUohJKjDsjj0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpgSd+K6tuMw91EmggxhkQQpESgI87g7jFr45xjb2So=;
 b=n0TFYGRiqVNpV1BTxPZ8HH3jGKaEv9WeK3Nayznzf49ESpruFXrNOt1NWHGsV6CMfv5hksOR9mYHEBy1HTYd1msEbQaWHOkqU8fCkjmQhOqPTHJ4ueUl1bQ2xLL0n41zfKpXHY6npPdM3LWIDJbS5procCDG86G0mp/FztKwqWH34mcAD/nmD3TBAmER9+i7W+0fwGbd552DKVHwSzrZheXSTUPdAYsUoWqf8lRj4XujrqLwWnew7/Pi2zEl5rV9cKVxIwxb+bol9DeZs1YtwdKCG0lR59WlDOmWYAejCZUx8sxUJwTs/tW45jFnSTYoxCBwvxs2RsNqp234aaWl9A==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS4PR12MB9772.namprd12.prod.outlook.com (2603:10b6:8:2a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 04:11:03 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.019; Wed, 15 Jul 2026
 04:11:03 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 1/6] pwm: tegra: Check for match_data being NULL
Date: Wed, 15 Jul 2026 13:11:00 +0900
Message-ID: <Mlcy4yaiRVq9tB-a8gkHvA@nvidia.com>
In-Reply-To:
 <c7d4a3ee8c615f5f6f468c0040fdb0e8864152ba.1784030076.git.ukleinek@kernel.org>
References:
 <cover.1784030076.git.ukleinek@kernel.org>
 <c7d4a3ee8c615f5f6f468c0040fdb0e8864152ba.1784030076.git.ukleinek@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY6P301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS4PR12MB9772:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b13ec4e-c228-4a71-6c4b-08dee22715f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|23010399003|1800799024|56012099006|11063799006|4143699003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Izf1FlXVd5YL1QMHNIEff17XK8Ms3gBqQCufRL9naScR/FNVFlWKjc8I3cKAlVbqDrAEZSZ6MBMdfQMsAuD3fSjdLczuyM40J1dD2msjOFrtJgsqMD8ZQRGNGPd+mT3d0filozz23EsaVzj4jmZboVc5JZt4S9iDPvi0CY9R0bYZjpT+RkrzjphqStiE4nV0M9h3QxIRJhLeLIeUzuYHrDVZxDHydirVOb+DtmMf2hz8iHZ5VZUpyuwPl/0BVrPKwUYbizrI79YZP9m5vY2XpKGMVRDTGdqtknCW0ZIm8GgHmEUJ4FbXtPKP//uUHtuthSTIzKt4EN5s/aRENh8bPgIFRdrRH6t8iIXVJncPHgfvQoe/wvnchMRgaRvQDpkzEqKNdOlx7NFph6eB5f6d537IQ2MiLFU6QeLOyFtG3K+vP3jV4hMbXZIXDDDK2GCGNNXqmfOMhe9B1ssnaBs8G4ilYZsYwRHYYubSmcsZWHejv+gUtLAV2Epl3zgw8PhzApZeibJtUHb6AaDbHdK33+ddPntRzGiVi69bsPALoeBdBraj9tiqqhuALdk0D7eL5IoPJVyZhdDcupbYsA0tN7WbCPsKsUCY6Q2vs7ENXpXgo04jr9HouT7dEXVjpQTHq3gG3hlmg/uT2Fv84GDcmW3mzvwKQXxPzD0/F7n45Do=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODhjVkJGTllPZHBIckUxTlBsd0lORFc2eGxxcTljVW1ZODR2WDllZUtlOTFH?=
 =?utf-8?B?akdLMCtmMkJIK1ZmTTZ6eGlTOEJLVGNGOFhzbWZ2dDZOUmc4MWJBTHE0QXRY?=
 =?utf-8?B?YjZ5N2crVHZCbWx0eU9hZ2UwcjhzU2xwWUd3d3ZOZFdteG1YZmdMSis2OFht?=
 =?utf-8?B?VlM1ZzU0eVhicHRjZnZ1UG51aFpTdFdyVFhrYTQvVWg1QjhJTzYxalVRaXA3?=
 =?utf-8?B?VU1tTWZBcVZaZlNjcWZFQjZrRjJNVURCNldHK09NOEtjWDI0V3h1QTZvR0dT?=
 =?utf-8?B?eUs4QTVBRHJSZFN5QUpsNk4zazJSckhybml0ZDc5KytRQmFqSWdWT0wyQVJy?=
 =?utf-8?B?SmJ0MHMwRmpDVGg4d0ZxTjJUeS80eTVLYUpsODh1SFc2b3Azc2l0NjQvNlNU?=
 =?utf-8?B?cGpaYmdsR211REVFazBJTjErcEhPT1Z4RGNBTVh0bjhNV1NFbDIxRDJ3QVlQ?=
 =?utf-8?B?VDhoTzlUODFINHNwekIxbnQ4NENMM01Nc3FPWHptdng1Z3huY040em9sZng2?=
 =?utf-8?B?OVpqNGZpOTVZbmVyQldnU044Rmhxb0pHYmJzNGd3VURIaGpiK3B4Mko5RFFC?=
 =?utf-8?B?U2lyWUtxZDVJKzU3WmF5RzcydzVoUG9EOWk3N0F2V3E2YlhnRkpyZjJjMVY4?=
 =?utf-8?B?UFQ0blk5dWNHc09MQ3gvSi9JSWh5SDNYTHg1a3lac3FveU85enFPYWZJMXdN?=
 =?utf-8?B?T0NKMDd5SC9sbTBHZUEvdHowakZ3NXpyK2tFR09MWHlVMFVQY29sRjRUWkxt?=
 =?utf-8?B?QWY3N2N6eEE3c3M5ZUMya0pEYzMvemNKTHp0Z25vUS9YcGVkWENaYmZreVM2?=
 =?utf-8?B?c2dnZDRsMStQbkFZS0RCeTgzcjJCMjJ2ZXNzR3ROODh4MzAwZys3YjlIWHVw?=
 =?utf-8?B?dWQ4b256RnV1ZmxXSnhFV1B1cGQwUUp2SXB3VXQwc3FlMUE0ZTdOdkExRzhJ?=
 =?utf-8?B?c2JkTU9qRWxHQ01LOGkwTWpEWkJoeGN6cHVOSGNMS3o4aVlwczNJNDVaSTFa?=
 =?utf-8?B?L0QvTis2cFNmZDVZM0dHZkZvZGt1VExwVmhMdlU1STltZTVBeDJKOHRWVFNt?=
 =?utf-8?B?aXVyQUloSkFpVlN4SUJyOTAyTjl4TEU0akxLMnZBVEdHelVzeW94ZklsQmts?=
 =?utf-8?B?V1BNTFVFZERIMmpMek5rUFBueFJUc1RybElYVUdRdFk0clhjOC9OU0Z0TlpX?=
 =?utf-8?B?Mk55MHlmdE9NMVZmYWNZaVJxbFVwRE9WWTI4N2hVeUFlV2MxRFZpR01IMGtF?=
 =?utf-8?B?WlUzT1p0L0pDS3BITUJ6SFJiK1lnNnBYZEVRRGh6TVpWMDBRWUp5V3MrK213?=
 =?utf-8?B?NlBTZlVpbnJURHA1LytXRHNMcUNxYjVJTTFCLzRRQ01VdVNRL2FqdVhOUlJT?=
 =?utf-8?B?eUt2S1ZWY2VQRFlGTTZQNlUxa2hZYytzaHd4WW9PVU1DdUNsNHVFdkRHank4?=
 =?utf-8?B?K0VUeWwwQjE1cUV5Z2hRVlJ1VnJ6Q25CVU9GUVB3c25ZMVlDbmx1QjZVNVJq?=
 =?utf-8?B?K3dsN3BYQnRQNHVzd3VROVpSeUhXbm9idjVwOHcyZGdyWllTNFYza3dZNHZq?=
 =?utf-8?B?L2pDL2NicjVqbkVYRWE2ZkttZ3J0VjNRZnNKak00TGE0RXpydDltdVRhQ3E5?=
 =?utf-8?B?K0R2VUFMSjNDYUc5d0szc1hoOElRZ1EzSEcxcStrS2lBMWx5aE1DVFgrK1Jk?=
 =?utf-8?B?R1JObUdHUkJ2WmZSRjg1RzgwanU4RGZpV1ZIVXIyNGp2OEsySTA3dlhCUlkw?=
 =?utf-8?B?U3pZelpIZ3MvRnBPL05UeC9UWjhrbGhicmFFNE55UTN6SFNQcU9oaGM3RUQv?=
 =?utf-8?B?MzJpbjBJY0I0bmtXc08xK0pSaU1JeURsa2ZIS1pJbnJrNnluaDN3MUJ5Rmoz?=
 =?utf-8?B?Z24xcU1ESDdrS0hmSllBMnFjaC9LZ0VvaHVzVDlQRlVHajY0bUZFcHlkMDRJ?=
 =?utf-8?B?ZldhS25MbGlqemlJbTR3eE5uUTFTOWUvZ0tqWmNVRlpVNlR2UFNrZlhkMnBt?=
 =?utf-8?B?ZXplbUZ5ekNZYkQyaDVrZkM2eUtBY010SUNsMmRIMCtja0RjeWU4dUEzU3pN?=
 =?utf-8?B?aTFMUVcyUHVPV1FmMlZIL2xsZWZQR0wyczdpbTE1UDVwSTNaZk9hMExFRUl3?=
 =?utf-8?B?ei9BaHJsQUdYQnljSmMvYlp6YmlCNjEvQnFwNmxvc2hsQXFXVWFhNExHV1kw?=
 =?utf-8?B?aUdrRWphSmZDNXNCYWNjVDFBWE4vOEQvQmtEbTBRWXdKWlJLWW5TOGJlYlJQ?=
 =?utf-8?B?anpVYkdoL05lM3NmbUpGVnB2YjczOTlCVzJNd0ZVdEhGeThjNm5lU29CTDVR?=
 =?utf-8?B?cGkrcnNONGhOZmtrUVVLTTdPTjBYTHBVUENsMFh0aWhDaFUyOGc4cVNVZkxU?=
 =?utf-8?Q?/okSCKBPrFNOD1BgRAyYZAeWez3APATvyymX7QvPjcP6p?=
X-MS-Exchange-AntiSpam-MessageData-1: jKWw2ZZLUSygVA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b13ec4e-c228-4a71-6c4b-08dee22715f2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 04:11:03.4627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0IqtPT5BhkPVJfBt06EU/AL3vARPwtbLiDX6PjQukrVJ8WhTS/eB5Q4pWWjmMoGQFzMC1xShHcUHwtpXmyvWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9772
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9724-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:thierry.reding@kernel.org,m:jonathanh@nvidia.com,m:ukleinek@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:from_mime,nvidia.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0AB2075A69C

On Tuesday, July 14, 2026 9:02=E2=80=AFPM Uwe Kleine-K=C3=B6nig wrote:
> It's unlikely but not impossible that of_device_get_match_data() returns
> NULL. Handle this case instead of triggering a NULL pointer exception.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> ---
>  drivers/pwm/pwm-tegra.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 5cdbe120ba2d..53743f83869a 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -322,6 +322,13 @@ static int tegra_pwm_probe(struct platform_device *p=
dev)
>  	int ret;
> =20
>  	soc =3D of_device_get_match_data(&pdev->dev);
> +	if (!soc)

Very subjective, but my preference is to have curly braces whenever the
if block is more than one line, for clarity.

> +		/*
> +		 * This can only happen if pdev was matched via pdev->name
> +		 * (which should not happen today) or in combination with a
> +		 * driver override.
> +		 */

I feel like driver_override falls in the realm of 'root can mess with
the system as they feel like but if they don't know what they're doing
they get to keep the pieces'. So adding a check in every driver, or
in practice having a random mix of drivers with and without the check,
doesn't seem necessary to me.

If we actually want to check for this condition, could it be done
centrally instead? I.e. don't call probe if there's no match data and
the driver's match table implies it requires it.

> +		return dev_err_probe(dev, -ENODEV, "Unsupported device\n");

'dev' is not defined (yet).

Thank you
Mikko

> =20
>  	chip =3D devm_pwmchip_alloc(&pdev->dev, soc->num_channels, sizeof(*pc))=
;
>  	if (IS_ERR(chip))
> --=20
> 2.55.0.11.g153666a7d9bb
>=20
>=20





