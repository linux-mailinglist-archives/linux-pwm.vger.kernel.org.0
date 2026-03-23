Return-Path: <linux-pwm+bounces-8337-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OO2aCH+nwGm6JgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8337-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 03:37:51 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 801592EBF17
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 03:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D5B330115B9
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 02:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5642571C7;
	Mon, 23 Mar 2026 02:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b+YA33mk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C6C2475CF;
	Mon, 23 Mar 2026 02:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774233439; cv=fail; b=QiHTLQuZ8MIoeColV/s1lfR0TCvA6eVlMC/2ATCUJmTCuMs4yd2ML5h4iaSM2kfGORf/i/Hz0ZQChb9RiSRX28wnLNRmOiKNrLikj2AwZcvrU9k2URTYJzTqDNniGFh+FukSWyQEVdfBow3YxoYKR1EeNvUWUzxDDDjoXlQY2Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774233439; c=relaxed/simple;
	bh=ucV7O3uQ88HeCUavFZaczBpruvo2XmgQ0OjBCZ3wa2E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=k2TNE4KqGO4WWF8JK5BTZ3olI8c8ibI4Jv/97iMiXD3pRC+b2h3qp735SnTESd/dW2GDlW+6HlYgzsbMydd8mvNOWy/JlnEEM+YEeWMVmjuhEVEbKe79GCffD5O8nNEneeEa+/U9Y8Z87m0Sgn1VDOwCXF4ZsU25/Mxm5duj1K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b+YA33mk; arc=fail smtp.client-ip=40.107.209.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOU1qEoAFlUkzuezGyx7Rmnxg7m12sFUYum46y+GSYLK530Cmp2pzKokLFqMt2eyLvB+wtHRCYilE5cbNG0/hkLly13Wpq8Pv1IaHPauX43WyLB0H8cMCD4yb9jLVmWm/ZRC28PPx+vvusPBsVJuReoBi0yEOoP1L572oVKV8FzKFkqZNUGz4D2CG97KNISPaMXj1pkSBoMeJGBLlJgHsNR7nDvExoIMnRndMfefC7xNcX23YjluwdXDNDKRJx2UJV7muvRTsY0/gy+ZZII+WlvZdBe446T01OJyoevDTyIO1Wte0bXqAUN6d7vE9F/CkpIiDgEs7PvpeIGb5s5FQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg808l5jGFqdOjNqiqmM6dwsAJWgRw49wD8NvoOW2PQ=;
 b=Z80W/B+hS+KoLZGa70R4SHDZQ06JdwOglO6yVi1c41EJJ9uijjX6SRolEuFgV2icYnFqUyZ/FcYQzNLDX7P6mj8q88UwVkktinbVWApV/OeBusvYe/6i14ULHGj4h3tJnQmugEu2m5hymAH4qsmY9MObj4hyxeAY9wtLzrS7Tbmln6X9DaLIEZRfIUwLiOlVO1nH/ACPC4i+3XkN4ftLGZsukm9rdwyf1D9nz4BgUg5h8yvgq5wnjiWhExe3+adbJQsFB6GtBPP9oB2573Nbl3SbNDf0OiKN7EwtywswBdT22jQMy9oTRGad5uP9eQChPiv1KgAGm50lD2FeJ5ieQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg808l5jGFqdOjNqiqmM6dwsAJWgRw49wD8NvoOW2PQ=;
 b=b+YA33mkRcXnSkCc+XQCZrd0ZHwumxoRcHYqnz0OQUYaP+WzNNFA1B7Ow3xJvCLAVVbTM9r/6G3dWHpFhb2SEWNvyYnpm5YQv9RxcDZMfgCUZY1jCio018bxM8Mam6mLRSpr8Nyk81lLlnxbCePMfFAMUrX/8hL/F3OmZUMJ8IpUEXME7CRACaqN+/kNQtMHUJ1+RahOFFFtYMHpzmmqoS6NecTQlXZbWQq8+SsuDn57wsI/mruMAwshCDSzgMBY//2i4Hz3Hb1NCSAs4d1dnpzIKXL+QtCgyHZ/+lTuXgBNTLBnWtkQnOmdPM3vapeYRYFaovtca+Er/Df+NNad0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 02:37:15 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 02:37:15 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 23 Mar 2026 11:36:38 +0900
Subject: [PATCH 2/5] pwm: tegra: Modify read/write accessors for
 multi-register channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-t264-pwm-v1-2-4c4ff743050f@nvidia.com>
References: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
In-Reply-To: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TP0P295CA0032.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::20) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 09466213-d911-4459-3a5f-08de8885181c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Ic5odF4nAPmThmyegCwN+hY9PUae47FkQmVnqDu5MiRSCYTrPjYSdbcFwSRZsugPEaCmszLvJmITd2GKaf2oMs3kImF8Uolc/nETQ1rspQbedzvAK+SLzcanvp/CNOMJkZYZWJi4V6IXfTCCB98ZCFL69yN+hobOPuD987lG7OYBpTZ9T6vh53QFsgKFP6Y/UKIXg/BK24E/lIOrZR5clUd7E9xEYja3pG2qQFyCD18HmMg60vYGucp1zXkdQHzgKQoNhsYs//kKfS29E7pjmlgnv68pm30sD8RMg29V9DzPJuj6tdJd7vVCh7L4Y06HXncKfQkhvK7GBf7heQUHb2ttmTT6k45bdCwjMBjmfoRXd4vM9LCu9yXt+fFkOKxuvPG/wPoNOb+GsJMMtQCmT8UB2QYSdnCtGRxQE/cUSr5XQaOliBsN4QZOlQp0CeZKhpd9OEUQtcie0k4oEUO8jXHL4QuuLQ8JR6xEJOrcsILnjbORYWMX6crzZAQbPvJXYq6zDpXIX0s6Ms/4j+7/yrVUbkl4Kgt4VnMYUM+ZJXBeh5mkFqkZo6++Fir7nVlb1aBp3xtN4+mUW102Yxnq33ldqHEnSD6AE8h/rgP13faXhLeJ6el5qOBFRggCEgT8N5uaC7+op540ItGdOu8BsP2LTnJT4x2HhSrPnB+huPCVO1dc05bpq8k80EibZlgzpev0kvciAJoyjElLGVnj21M7W1K3IMsw9SCd+kdYHEc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjloZVVNUy9NMnJRUVlaQ2k2eU9FU0o2d2lEQ1dxQ08rZFB1Q2dmbzBnZ2Yv?=
 =?utf-8?B?bUhpUXpNTXEwMDdoS1VKNXBzNkRsK3p0YUVWNHVwNnlkbVpCeWp5R1hBcnBJ?=
 =?utf-8?B?eERaZG9tempuRWN5dEtzQVlFaEZhT3pDcE1hT215SEt1TDBFVjU3a1F3ZDRs?=
 =?utf-8?B?a1RCczhuNUpmNU1HQ1Q4RzVhM0Z6ckcvelNJSk56SEVCMzc1RTZTRmloLzBT?=
 =?utf-8?B?WFY4SjR0Ui9hcHRJUSt4T1p1ZElpRTFQR3MyaXlhYlh0WG83Z1dLZ3Q2dGJR?=
 =?utf-8?B?UEY3bFMvVDA2YTRCT3pvNXdwbzBUcm9kMGVyS2V3NmluUmVabWtzN0xRN0FH?=
 =?utf-8?B?QTFndVdzNU53SEt1VE5UOHR5ZXZxQ0h1N2hiMEFMcjJVeWxtWFVYQnQreFV5?=
 =?utf-8?B?SStpQkgxeEdFMzhOUzdlVnA2SDVYWUp1Y3FlU1BRNnJWOTAyYzBnYXQraDhw?=
 =?utf-8?B?c3RIYUVyMWlVUEZLWlRXd092MSt4MHZTaS8wWFRrc0YvQTY3L2ZSb3lkdHAz?=
 =?utf-8?B?UTJrV0ZFdHVCd0pnQ0c4L0F1T2xHWDFSVmFkb2NDd1JoQ0N1ckMza0VJZ25q?=
 =?utf-8?B?ellLYUVmWmIwaW9QMFJQRCs0bVdzNEZYdjUyNU45RWt2ZzJWa0tMUk81NzV6?=
 =?utf-8?B?ZVJrUnpRUE1MS2dyRnBicEVZWU04REVST09wZ1Y4VUF4MWxGRXJqQ1J4NkFw?=
 =?utf-8?B?Q256a2hTMW1BRHR6eEszekhsdXU0VXVncVlBOWNOQlRTNm9EbnJrbjNNWS9u?=
 =?utf-8?B?YlVxMzIraW5QT1cvQnRJTXdjSWQyb3h0TXI5RFYwQVlaakhxc2UzYUFOYU82?=
 =?utf-8?B?TndNeGJSeXBPNEMwSXlyUjBGdElMSDMrNE9tS0hGUWFHMHJDSXZHQmh0RW9T?=
 =?utf-8?B?Q0ZCSjZTWnZTenk1SVo3VHlJdnBHelMzRGk3emhpUmRKTm1OS3Jhcit2cXlr?=
 =?utf-8?B?WTNVMW5oRi9RM1RiK3lYeDVQKytvL3BRZ3A2SzJlSzVPa1RZMGlSTlh6N2Fn?=
 =?utf-8?B?TjJ3a1hNVkNtdUZqaUY5dWZ5WFdjcDRTNGErbFVTalJCN0c0eTFOMHJCUThT?=
 =?utf-8?B?VFpQc2Fuamc5NlVkWW9vTDFmdUdMb0pYNEVhUERONnR4N0ZFUUt4VzJvT1A1?=
 =?utf-8?B?MktjL29IaFZqdE10ZlRLb3R6VFl6ZEc3UlV1akRqaThYS1M2dmxHQjlIdFhE?=
 =?utf-8?B?QmZXNHlUSU5hV2czMCsxUU5IczI1TFpzNnlnUnVxNFZodU9nR0JLQWErWVJF?=
 =?utf-8?B?aEl3enhmNmw4Y2l1c29WZkhzeWFjRTVxSWNxbVlmcHI1czlDY0pwNzVPUzQ5?=
 =?utf-8?B?K2E3NFZGMnFkNTlicVRZdmVSUmtRTkJiTGVzbnlrTDhCMUtZZjR2YWJNRWFr?=
 =?utf-8?B?MnZXS0JRdVJoaGl3cUNJZlRaVEI5WGVIZVpNaFpoTlVOL3FuUjBvVk1UWVlu?=
 =?utf-8?B?V0IzNEtaUkN1Ty9tUWZMN0NPODBCdEFCay91SjYzRXhWSUFJYTd5V1RvZFZF?=
 =?utf-8?B?aVd4KzFYYU1nM05jeDlGQi9LVWs5SFRnelBmTzFRS2ZhOGRMVDU2eWpuazM2?=
 =?utf-8?B?dXRkNjhxS0VyRlpIY0hSVy9tRDFQb2JjVTZnWTBySHBPdCtKa2wrbUIzWi81?=
 =?utf-8?B?UkFleEhxNmFXMmlVMzNJbnlUQkxTcTN0RDZrRnFyZkxYSENvZk15TGw5S3JD?=
 =?utf-8?B?NXRPdG1nZ3c2dDVEOXRRTUZGbXErZ3JxQU9TaFhITDlXZDJKMDR0WXFqZDVv?=
 =?utf-8?B?UHJOd1o0cDdKSHVzeEZOYTlwOVF1NWVwOXhaTzhYOWdjbEtrMEdrRkVBTk83?=
 =?utf-8?B?NDhkRURjSHBjNkVISXA3UzAzbUFUazlYSE10Y1g0RmhBQ1J3VWluaVlxRDhD?=
 =?utf-8?B?YVV6RVc4Ky9UQlhkMGU2cFF2Q01XdmZKcGNScVlWRzgxc3NNSWk4WWR6cHRj?=
 =?utf-8?B?NGhFaTFNRU1tT21rTlhjR1dGVmRrZW1LRzkwRnkwTks2S1FNVkthdnBCckdn?=
 =?utf-8?B?K1ZidGtZUVZ2N25VWTN1aC9pMUEvZFY3V25oWjY5NVhKd2EwbFVVVjNvNUp2?=
 =?utf-8?B?dUptVjV0WEJjOTFsZWR6MWRybGtjcDZhdW9HTTBpdU9rbTI3Uk5sbWZqN2RT?=
 =?utf-8?B?UFF0dEVVTFBPNnJqSEtQeHRCOTNGYVlVendsWEs2bmZiZUF2SnhxbCtlcW9y?=
 =?utf-8?B?eDY1eVJDeTVEY1R6bFp1RUJ5QWtrN3hQU0cvSW5HQ2JWRmtEYTFmRXNYeHZv?=
 =?utf-8?B?cGttWUZnc3YrVmJkSUdGalZHVjVEQkM2c1htMWJlZ0tZN3dEWTRvVHExYzVv?=
 =?utf-8?B?S09FK2dnaWFZNXJNb2VrUnQwSmRsVGIvT1FMYUxPVWQ0U05wMmt6UUFUUmxr?=
 =?utf-8?Q?ETtHxDertPTuAiyj+g3o71OgCM1JcWs7vE08pYuRXqIL0?=
X-MS-Exchange-AntiSpam-MessageData-1: T1McualNS8Y1CQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09466213-d911-4459-3a5f-08de8885181c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 02:37:15.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gCRZDxw0OipPt31yreeH25KctqP3opfB9qH3tlEhSohB1C2ZPBklkWzE/ZF1MkZqfiJcBDR9rEP0j7RBZkhow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8337-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 801592EBF17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tegra264, each PWM instance has two registers (per channel, of which
there is one). Update the pwm_readl/pwm_writel helper functions to
take channel (as struct pwm_device *) and offset separately.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 759b98b97b6e..cf54f75d92a5 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -57,6 +57,8 @@
 #define PWM_SCALE_WIDTH	13
 #define PWM_SCALE_SHIFT	0
 
+#define PWM_CSR_0	0
+
 struct tegra_pwm_soc {
 	unsigned int num_channels;
 };
@@ -78,14 +80,18 @@ static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static inline u32 pwm_readl(struct tegra_pwm_chip *pc, unsigned int offset)
+static inline u32 pwm_readl(struct pwm_device *dev, unsigned int offset)
 {
-	return readl(pc->regs + (offset << 4));
+	struct tegra_pwm_chip *chip = to_tegra_pwm_chip(dev->chip);
+
+	return readl(chip->regs + (dev->hwpwm * 16) + offset);
 }
 
-static inline void pwm_writel(struct tegra_pwm_chip *pc, unsigned int offset, u32 value)
+static inline void pwm_writel(struct pwm_device *dev, unsigned int offset, u32 value)
 {
-	writel(value, pc->regs + (offset << 4));
+	struct tegra_pwm_chip *chip = to_tegra_pwm_chip(dev->chip);
+
+	writel(value, chip->regs + (dev->hwpwm * 16) + offset);
 }
 
 static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -194,7 +200,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	} else
 		val |= PWM_ENABLE;
 
-	pwm_writel(pc, pwm->hwpwm, val);
+	pwm_writel(pwm, PWM_CSR_0, val);
 
 	/*
 	 * If the PWM is not enabled, turn the clock off again to save power.
@@ -207,7 +213,6 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	int rc = 0;
 	u32 val;
 
@@ -215,21 +220,20 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (rc)
 		return rc;
 
-	val = pwm_readl(pc, pwm->hwpwm);
+	val = pwm_readl(pwm, PWM_CSR_0);
 	val |= PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
+	pwm_writel(pwm, PWM_CSR_0, val);
 
 	return 0;
 }
 
 static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	u32 val;
 
-	val = pwm_readl(pc, pwm->hwpwm);
+	val = pwm_readl(pwm, PWM_CSR_0);
 	val &= ~PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
+	pwm_writel(pwm, PWM_CSR_0, val);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }

-- 
2.53.0


