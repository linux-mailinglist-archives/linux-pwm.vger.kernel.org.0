Return-Path: <linux-pwm+bounces-8416-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFZ+J5s8ymnD6gUAu9opvQ
	(envelope-from <linux-pwm+bounces-8416-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:04:27 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8E0357BB0
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72EEC305A2F3
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 08:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991E33B4EAA;
	Mon, 30 Mar 2026 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MD9IokRx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013033.outbound.protection.outlook.com [40.93.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2084C3B4E81;
	Mon, 30 Mar 2026 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860858; cv=fail; b=pHjGLKg2xfld84fD7svWZm4nYtcPK/a/AORn3+eQ1sZnc3n9/hFtb3Vl41u6S7LZwNHHochsdNB7sTNvyu8a5pm6qNgkpGGQ/0u4y/P38zTHKKUD+7kEdvH0zsOLD4xEVx9lkXBDrIjyXvl80ZpxboUDgpA5uvmb/5eAx0agC7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860858; c=relaxed/simple;
	bh=/Ta0Axt7KJjBrFu00qLjZJNsY3MmjgJ0zry7Jm+m/dw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hJjlYecopcrfe8w9SS3HPzRkQXtwob04udTjncj/8+DKjZeLQ8yVRQpsoVx7u+W/tld7hmkQQxoxOV7v0IXvkNlhzYvFQbSy7nuNg2lkVqF8u3sXzchvRwaQtgfhE3MfaqXRWbcEfK8nCs/kIwnDDp7py/bhI68HTflDlVkhA14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MD9IokRx; arc=fail smtp.client-ip=40.93.201.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vul+Wne24j/OpBN8M9uNd/OKt19o11TlHdrWtKpwDAy1XMpqSQwcinLUdaU2sf8nLn2ZNv1QFdP7+rmZd2KibAXsqW8i+dSk2DJ6oW/8CTDUN0/hfmhmE5UTNYpXzWp0r5rHFSfqKMMfDpz5yCCd/iFFnIpbgIOSIudjwg6Ifnfd798xCELW9N6jjZ3v6Mv4KEbMuTwogqAN1FCNIutYKGK2LvEufTShOB8CuRRdUQrwGaauytL40LzweP6b2nF0FxVqq1aY1PXNFP0FzSoyV7jkd+PJ4iMqDR/WmZZjEg6oSTnilKB2FXZZfTvY0iJwq+S0pGjORBMt0nAPhK6/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lI5vCtTJRWEYYBs6iFamPe8E0USN1Uctqb9jRn6Rgs=;
 b=rKs8O0UUKgIG8NhzEDCPs0FDrsOhsmkJ4kkIbJKlI6fPCm4QWau9RnI89Np6HFOaI2St5jV5gfa88SNiV2yXDQAig0AXCLQ/GG3HALB11uu0E4oPu5KvgHSQvepc+T9pmKQozj3S2VzdfG+Sc40sEWeUovcQ4YdKswtbsb7fTQ1a3P70aSSqxJhimq4ohsQroFZcm2VdsKWtDqd9K1TzVaZNxnmw0UqPfC4luS2oE5GPr5WRCyL4uS4MBdNW0O90tosEI8pmi6ma97Dm+2DlPYOqOn53dIh3W2tqEZHJ7J9BisGXq4tC+QbZqiM/IgPXG20aPMFWd50CFUbFgMxjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lI5vCtTJRWEYYBs6iFamPe8E0USN1Uctqb9jRn6Rgs=;
 b=MD9IokRx9agPQ3LU9grOhxa7XM08LKTrJ+jvF2K7D3m37tKO2VNg3pkDfc2atdi2v8IparfFuOBucSsDc/C3/FOFAoYJ5dfSL/xX4q5Q88ABAmlVxDI1W51vmt7781+mKi3SZ+I1WAINhR8z9Fm1bSQVBliegpgQk3m+qBoztaYpoPULk8n88pDxUArgrEnDzrXMlSO4O9tKKy82OKPlUri9+/L+aiALr63gwKmfacftY21gq+K4ylR6caIygcYfMDDU9EkF5PchpmH7jhX9GUK9ycrSX02ibeCAHPdrt3hORwlXJkOW6YldX24QDFBU45Y8M5nMtMocJPELEKaJzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Mon, 30 Mar
 2026 08:54:12 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 08:54:12 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 30 Mar 2026 17:53:55 +0900
Subject: [PATCH v3 6/7] pwm: tegra: Add support for Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260330-t264-pwm-v3-6-5714427d5976@nvidia.com>
References: <20260330-t264-pwm-v3-0-5714427d5976@nvidia.com>
In-Reply-To: <20260330-t264-pwm-v3-0-5714427d5976@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MW4PR04CA0335.namprd04.prod.outlook.com
 (2603:10b6:303:8a::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 14356628-7557-4f67-a385-08de8e39ea16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ehHxfHp1vExG3cz0mR6RyBp00/YrWONFGo5bJwRQRA7EOlZRI7Po6Bej/Str4ggxt39dINj6cOBL4kFf8l7MASnhgAIX2j5oP6Js12o6Duku+Ldo/osEr5GgzQ2iRUZ5yovAAJzsVER+awcxvHreLhyL+onaxnLdHQnRaACqR1tk2baoTJHwQBC33t1/M6Omi4UAbfwX8snCNf1e/ZqPupwm8BuaGPvuKDVij3ufQCzocLjifescUErCpfCPSNs2JnYuubSD82Wuusmx3unQsSsJQbPvD+jVmF20HmsVjU1svjdPZh2LCM7wKPneIY+RyFP0aMZ3RxgNRnJdS99OQsduY0/X662SVuginI3NCuTW4ZjoW6DUNDJ2EjfhCHTR0lvB0Uu6jEsPsFLyC65iHOs/g3QQFfQyA302OFeoH8mU/NUqzmmCrmuZD+RF5woQQPvOyc3T+M8YgDSoQ6X+LqU2eoZxHWmRt+1kELMOLY1ip40pj7H4pEcc3gqvBamBep+78MiA4x/d97hmVpYeE+tjRYhPJhXop07Hpd2dp7Daj7czT9kribwv0E8EyKcgXcptC5fh7RZAlCdvQ+hI2YyVGpfI5jBMcWb8kMmnxO5OERP8jE7ytuF1C9OexP7pybbivrcki5Pv7C3lT1c0+pQqzJ0f7iu3vstr9alkmm0FtjrlIJM437K+XzndBHTHuQTPmVRJXaizYQT1gsu7KK2QotCtX910SX/UBSsfeQI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW1sVjAraUFBNUJPRkQzQ0ROdlc3YWc4MlczOUlpNlBVditickdadWhsZGc3?=
 =?utf-8?B?UE1EbUNFbTg1UVF2MTB5TVBaektJNXM4ZnZDKy9hMDdzbG5STktMWk9CWVc4?=
 =?utf-8?B?MlZSK3licHR1ZTNnQjNyMTZtZ3JOMGpoaUI0R3JERHMyN2ZZVUdhVVZUS091?=
 =?utf-8?B?TVZ3NnphamJ5NjhFTzYzRnljUm9TK0FXeXp3RjFhNWVTQWxSZWFwMXc4Y2Q3?=
 =?utf-8?B?ajg0RHVvcGNNVFZvMTcrUmRTYU43S0FNMlpuOTZQVStBeUZReEZ2VVFBeDky?=
 =?utf-8?B?cnJQV2lwZTk4Nzd3Q2ZRei9nNmUyQmlYOEpubmJlOFFaSWJlSmUvbXNhaVA2?=
 =?utf-8?B?dDNNTlFDbWpwV0xEREVwOGI0TUZWbHdXQWdYL2VaSHZCNVlLMmJuUmtlY0R2?=
 =?utf-8?B?ZllzZmtGNmNNdGJLRk5xTkU5TGtOaDBJOSt1RVZXdFpEemZ6UkFIeTkwbTdQ?=
 =?utf-8?B?eFgyTkl4QVVOVHk2aWg5RzJEaHptSkxDdEdjeENxYWNBUStrUmcrKy8rNnU4?=
 =?utf-8?B?TktBVHZjSVJyU2o1SURpS0hJbUF3WlNSN1RUVzBMTHpGTHhDUmc5Sm8xN2dY?=
 =?utf-8?B?K0dCbElFcmJ3ZlZDbVliS083ekZ6V3ljQVlRNCtBbXg1alU3dkcyaHN0Vytt?=
 =?utf-8?B?MVdtcTFIL2loWkRhVHRtd0k2SERMQ3YxcVRSbWJ0ejl1ZWtaamNTZk51S1ox?=
 =?utf-8?B?Tk5WNlkwY3NJQlUrNWpMaWhibzM5RjQrV1F0WDY5R0g5SmJOM2FlTStqbmVy?=
 =?utf-8?B?TkxsNFozazZTVlk1WFBEUEM5VTFXOEgvSjAwRWkrZG84amVtS2xTdGJ2L2dn?=
 =?utf-8?B?RHZHOEM2NHQ4cVR5a2ZsMnFpTGE3b1ZkUlZuSHk2a2RWb09aK3NrQjdOcDIv?=
 =?utf-8?B?SDZqdHNxODZVV1hqblJJNkZBWnJoUytDbkhwS0lPOXJSSzhnKy9IUEFIL2V3?=
 =?utf-8?B?aHdaTC84d3NVa0lzTy8yZU9zNTdQMHFFSHRsNzBOdXN6Q3ZvTmI4R1BIVDRm?=
 =?utf-8?B?bk9kTmxubklmcmxSc3A3WXJYL1NDNXVTY3EzS1J1dEVZV01KdWh3b3VJeE1y?=
 =?utf-8?B?L3h5TzJ4WlZsNU00aXZ5YUh0UFVjbGU2R29ub3YxRFU1ZS81OXM3azNVaDlY?=
 =?utf-8?B?UzlSRjJZZUZQdWQxZU1RdXlDNmFLdHRjaW51MFQwc09BZWd3eVRUNE1HRDRo?=
 =?utf-8?B?RENJRSs4Y1g0SWhHTXkwR2ZScmMwUDllVDJ3VnJPSVNvSTFaRmtQcTVLUXoy?=
 =?utf-8?B?amFGbHdXZmpOQlZ2VXZZa0FHdGd4ZDZJMHlQYjNUMHhWbHdaRUYvTUN2WGNl?=
 =?utf-8?B?R0JmU3dyK0t4d3BNaVppU3JUWjhqdWRZZGdya3NxUVQrMFMyc0VNWngwYUlR?=
 =?utf-8?B?QUdabXY3YTB4KytSaWNHcmlBZitIdE9GTGVjRDhtSGhLTjRHYllXR01tY2dB?=
 =?utf-8?B?MzYxRmd5bWlGMlAyWERnczI0Y3lNcW5aRFZDTlc5ekRmVzBOU1NERXJaaHI5?=
 =?utf-8?B?T1JWNzZBVUxobXFacXNEZlhYd0N5S0NDTlNIVjhoNmJMN1lTRUd2d0czdGZm?=
 =?utf-8?B?aHp1RkQzbUFqandvaXNEV2ZZU25LUTVnS0M1dFNvNUUwOU00VXZXUHJHWDh0?=
 =?utf-8?B?STRPMWc5c08wNi9neC9KNjJEY1JRUVhlU0M1SWlDYkZ5Z256dzBNak1pbUJp?=
 =?utf-8?B?NnFpdXlQWk5qVWdZenZrTlFZRGpCNmFKQ3R5SDY2SWd5aHJyK0UrcXBrL3lL?=
 =?utf-8?B?ZUtCcFBTU21hZnF1K3ZsUUR1ZU9EalZuZHg3MlM4dUNnU1NKSkNBMnViblNS?=
 =?utf-8?B?dnhzUFhKc0dvbGwzN0hibk5UMTVsMmJieGFVNEZwVWRwelJ3Tm5rYStESEFv?=
 =?utf-8?B?dWU2NEFKSDJkbkM0Q0dSUzIyYUd3eHNldTVDeTlqS0tnckYvU3R6ODY1c2ow?=
 =?utf-8?B?bGpWUWtXU2RsMHJNbkF1Ym04bUhvVGJ3bEViN1J3cTllMiswd3J5VjA5WHZM?=
 =?utf-8?B?Mk1jRFIvRU5veTNaTVFTUE1CZzFoWDFxUWhHUkMyOUV1eW5vTEdVaGZHOGxM?=
 =?utf-8?B?REZkS2RvbXZ1aXVOb0VXeGRPeGdQTExuTElhSXdyek5pT3VDVmduOE1HL1ky?=
 =?utf-8?B?TFliZVYvcEltakprYW1SVXhvRHFESVdUSjJQa1ZnVU92Q2RFeUpXU3M1Rk5t?=
 =?utf-8?B?ZXhQUDVOWDY1M3RoTE1xOUpLYkJicGkwTnRkcWdLc1BVVlMrOVpwWU9pQXk3?=
 =?utf-8?B?ZUFDNHVjQkQzZ2d2Q2R1UHAwbENkdTNlZ092VklsTk5pNXBMSC9tY2cxRm5x?=
 =?utf-8?B?WDA0MmNMWnVad2J1eDVPeUdhU0dqTDRKZmIrc0ZrcmNHZnZjM2ljWFRtcEJB?=
 =?utf-8?Q?Bi133rTkRcDPUpajoFBk5mkcRRm5IscDXLUBPt3egb/ew?=
X-MS-Exchange-AntiSpam-MessageData-1: Kdrzx7lwAMcGIQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14356628-7557-4f67-a385-08de8e39ea16
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:54:12.7193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9Fnmyi38LzZIZS5VWfBffQSiOP5ngKTDuxH6PZS8Svm2cw4JW1hnpR4a3kYbnwL5G/salQg7KnQWfXQqg7Nsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8416-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:email,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E8E0357BB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tegra264 changes the register layout to accommodate wider fields
for duty and scale, and adds configurable depth which will be
supported in a later patch.

Add SoC data and update top comment to describe register layout
in more detail.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 75 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 857301baad51..c1e8a804d783 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -7,22 +7,60 @@
  * Copyright (c) 2010-2020, NVIDIA Corporation.
  * Based on arch/arm/plat-mxc/pwm.c by Sascha Hauer <s.hauer@pengutronix.de>
  *
- * Overview of Tegra Pulse Width Modulator Register:
- * 1. 13-bit: Frequency division (SCALE)
- * 2. 8-bit : Pulse division (DUTY)
- * 3. 1-bit : Enable bit
+ * Overview of Tegra Pulse Width Modulator Register
+ * CSR_0 of Tegra20, Tegra186, and Tegra194:
+ * +-------+-------+-----------------------------------------------------------+
+ * | Bit   | Field | Description                                               |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 31    | ENB   | Enable Pulse width modulator.                             |
+ * |       |       | 0 = DISABLE, 1 = ENABLE.                                  |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 30:16 | PWM_0 | Pulse width that needs to be programmed.                  |
+ * |       |       | 0 = Always low.                                           |
+ * |       |       | 1 = 1 / 256 pulse high.                                   |
+ * |       |       | 2 = 2 / 256 pulse high.                                   |
+ * |       |       | N = N / 256 pulse high.                                   |
+ * |       |       | Only 8 bits are usable [23:16].                           |
+ * |       |       | Bit[24] can be programmed to 1 to achieve 100% duty       |
+ * |       |       | cycle. In this case the other bits [23:16] are set to     |
+ * |       |       | don’t care.                                               |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 12:0  | PFM_0 | Frequency divider that needs to be programmed, also known |
+ * |       |       | as SCALE. Division by (1 + PFM_0).                        |
+ * +-------+-------+-----------------------------------------------------------+
  *
- * The PWM clock frequency is divided by 256 before subdividing it based
- * on the programmable frequency division value to generate the required
- * frequency for PWM output. The maximum output frequency that can be
- * achieved is (max rate of source clock) / 256.
- * e.g. if source clock rate is 408 MHz, maximum output frequency can be:
- * 408 MHz/256 = 1.6 MHz.
- * This 1.6 MHz frequency can further be divided using SCALE value in PWM.
+ * CSR_0 of Tegra264:
+ * +-------+-------+-----------------------------------------------------------+
+ * | Bit   | Field | Description                                               |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 31:16 | PWM_0 | Pulse width that needs to be programmed.                  |
+ * |       |       | 0 = Always low.                                           |
+ * |       |       | 1 = 1 / (1 + CSR_1.DEPTH) pulse high.                     |
+ * |       |       | 2 = 2 / (1 + CSR_1.DEPTH) pulse high.                     |
+ * |       |       | N = N / (1 + CSR_1.DEPTH) pulse high.                     |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 15:0  | PFM_0 | Frequency divider that needs to be programmed, also known |
+ * |       |       | as SCALE. Division by (1 + PFM_0).                        |
+ * +-------+-------+-----------------------------------------------------------+
+ *
+ * CSR_1 of Tegra264:
+ * +-------+-------+-----------------------------------------------------------+
+ * | Bit   | Field | Description                                               |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 31    | ENB   | Enable Pulse width modulator.                             |
+ * |       |       | 0 = DISABLE, 1 = ENABLE.                                  |
+ * +-------+-------+-----------------------------------------------------------+
+ * | 30:15 | DEPTH | Depth for pulse width modulator. This controls the pulse  |
+ * |       |       | time generated. Division by (1 + CSR_1.DEPTH).            |
+ * +-------+-------+-----------------------------------------------------------+
  *
- * PWM pulse width: 8 bits are usable [23:16] for varying pulse width.
- * To achieve 100% duty cycle, program Bit [24] of this register to
- * 1’b1. In which case the other bits [23:16] are set to don't care.
+ * The PWM clock frequency is divided by DEPTH = (1 + CSR_1.DEPTH) before subdividing it
+ * based on the programmable frequency division value to generate the required frequency
+ * for PWM output. DEPTH is fixed to 256 before Tegra264. The maximum output frequency
+ * that can be achieved is (max rate of source clock) / DEPTH.
+ * e.g. if source clock rate is 408 MHz, and DEPTH = 256, maximum output frequency can be:
+ * 408 MHz / 256 ~= 1.6 MHz.
+ * This 1.6 MHz frequency can further be divided using SCALE value in PWM.
  *
  * Limitations:
  * -	When PWM is disabled, the output is driven to inactive.
@@ -56,6 +94,7 @@
 #define PWM_SCALE_SHIFT	0
 
 #define PWM_CSR_0	0
+#define PWM_CSR_1	4
 
 #define PWM_DEPTH	256
 
@@ -418,10 +457,18 @@ static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.scale_width = 13,
 };
 
+static const struct tegra_pwm_soc tegra264_pwm_soc = {
+	.num_channels = 1,
+	.enable_reg = PWM_CSR_1,
+	.duty_width = 16,
+	.scale_width = 16,
+};
+
 static const struct of_device_id tegra_pwm_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pwm", .data = &tegra20_pwm_soc },
 	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
 	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra186_pwm_soc },
+	{ .compatible = "nvidia,tegra264-pwm", .data = &tegra264_pwm_soc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);

-- 
2.53.0


