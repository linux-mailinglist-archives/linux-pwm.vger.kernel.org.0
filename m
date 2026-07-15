Return-Path: <linux-pwm+bounces-9728-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id waxPFG0XV2puFQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9728-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 07:15:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF5F75A9F4
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 07:15:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=KWhslrB5;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9728-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9728-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE0563196360
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jul 2026 05:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB0B3B4E80;
	Wed, 15 Jul 2026 05:09:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010053.outbound.protection.outlook.com [40.93.198.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFA13B4E81;
	Wed, 15 Jul 2026 05:09:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784092186; cv=fail; b=rLeIgaD2EdaSTjZCwOWuAJrrgP4XEvFGCyiPq2T2M2V/fBTvvaV+TlMzeFfAw7EeEoAfudjjPjgganj6iENmbwRUOTswZN4j2nsWoKjpuQtcXBYbCw31zPbla+04f46PJayZDHlF+2g7ToKsaZzmabNIg2NABCXc0K7lxaRfeQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784092186; c=relaxed/simple;
	bh=6rPGNHIn72RLPp+G/YRrVsMlFyLlUm6SipnEKlNFngo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IQoq9W4SKkDp6EPq/deQrYp491HS3pxb1hu8VNQHbhOTnEMJZvfkX18QwbWjYhfILdDe7GpbeJkCVPibLucD8K2YbfN9CaNgxC84JKsqHXTNI2OcEHMa0y3V9kvinkNlGm2jBh/OeqLxQzJ2comHlEIB5KoNThnTywFHedBjMo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KWhslrB5; arc=fail smtp.client-ip=40.93.198.53
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3HAFXv8Cra/9EZzGkLuNVCvtGYQxfmEQ1zPaiL7IPAm9x6scMsEdd+CHs3XinfWqP5iAXMsJ9fejjouEqT3Z3T7vAzCG++AQxFhuTJoH9k/y3cV6bPRN7x/DwJaljytIGrYV7ho2wS+0T2404szMIOpHTktNaCXIKDXLO40n0L6JADP1yzqs+BJl1yJ8MtZrPHiAf6YoVU4kicHpNwSyXfEgG6BPJfey6UHpCc7ffhPMAzz4lnQudvqL2ZhdWA1+qgK0ZCoUBbsCqFz6U++P8BKX1pNFbLvt27/bsGdsXD7BdoRcADrB33lc/DvUpnQeGhzh/BKTDG6AYsCNC548w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDR/IelohHNjcVW54DWEjEVh8MO4sD6c42fXoORRr3c=;
 b=cBDUIMnkUDduHJNlVkdX5J6iywCXnhsE3OFQl56Z0z6QTdsmao8t8XZ05Gv/PgjX0oDdcTg5o3IOKe2ZE7fec8XwcIqeBu5N25BPIwtj6eIgLfBOK/xCpUUyhRei1rT8GD79WHuDEMg7rcOBas7/mK7XYwdibK9IChZ5nTjfaC91KaUBlyKiRgGwMcLgJNlZhW4AQ/8vdAtiVIbWu8IhVLmDNpmzuw0wAPyQhtLZAiNi9rrWTr4OEEPg+mxs5s+D4ZE9M//BzBz0huXajM5fxfu+iR3NLey8c1tLj9ezz5ge5+i92qkyuC9E+opgaXRiryTltTDYTwNTphsDFnWxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDR/IelohHNjcVW54DWEjEVh8MO4sD6c42fXoORRr3c=;
 b=KWhslrB5kqohv9KZgMEA/dLUsAjAlaSzMJVObTLpxjnfIRlkrxvZ3cA2eCuD8ptMXM3NhsdYOPLOsROlVcfLUMkdmduxpZBN0bFAHBDs0tHHkMt3zq8INAsOOJ9yaSGc/UexXGid3h5Doo2VntsqVqT4WWY/4iEittgsUQCj46vZUWyVi8xx7LmvjPZ/iIg5W6T+/Hv8nexzvLL5SABnMxrkLC+54hwAnyGgmIb9mnxE9aIW9CqIrWdQ7I047RMBSqd46+DW5jovb/Qt2aad2f8ltKZF0WGiw1ec1qI0WuTKgTHroU/VptGz/LibAtAa91fqRRbvE7MSUmXgUdL6VQ==
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA1PR12MB8466.namprd12.prod.outlook.com (2603:10b6:208:44b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 05:09:31 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0181.019; Wed, 15 Jul 2026
 05:09:31 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 6/6] pwm: tegra: Implement .get_state()
Date: Wed, 15 Jul 2026 14:09:27 +0900
Message-ID: <nEQu20cHS-K6rBZ3Lhz3eQ@nvidia.com>
In-Reply-To:
 <33b13f17d7135923d08e2ff40c867803e19609b9.1784030076.git.ukleinek@kernel.org>
References:
 <cover.1784030076.git.ukleinek@kernel.org>
 <33b13f17d7135923d08e2ff40c867803e19609b9.1784030076.git.ukleinek@kernel.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0344.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA1PR12MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: ecbed591-fc49-4193-c891-08dee22f40c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|23010399003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	7AAdImJlCmFw8mvMYICApm8d8FWbym2eO5HEn1OKx7ZGWL68Ao52S8+P2kRLLrDhEmSGvtWF5qAmvJMylZ98xdP4Ju4iPdwUp5vIHS8CAtf//TX+pU5KqmZG4G+Fg4okWUnkievE4Gj/59VXAg1ivmBT3L2P7VcgAhnhUOvojo1DGrZC6snI1R18mF5C1R7TpraToR4oIGUkAZTHtyPDEDxNuv3HyEeOCy+vp0xrASfMUPc70RfWl/m/o/OZJA0CSE2QFsE7gbF/C0OBwqEHoqmfiRLVq7ZIO2XN1w8uViPU+Uv7UDd5IrFNvSOfC8fwzGdjqk25RbzRyJj9B7HptlULSSen2IUx2xUskeByKN8XHddD2OQKXHFtiDClV/hZlTry0KdkoSykbJeA/AcsN7wQfkaZcoJpHsFQT7XF4+bo1mOVxK2FHC3RsqOa1iW0mV2P36G/MDxiWH77Yv4D0o1zvUycLS1rszJidrREq3Ocp77LU8sqe1YvgANpPt+avYl/MBpBYikYWX6zO+7yjvO31oKJTJc529bYBAjARBx8KX5Q8vGnzsIwIIvRVg3HcT921KYqWZEM6ABJmQSYrQmG1Vr10IdoyA6jF5TFf/GB+Atzj2RsPV1gxDMYVArExTLSkM6z9CGxcnHMR87kPtoPOLLm3q9Bcxl/Oj8SS7o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0FmZGNCUnM2K25Ya2NrbXdpdENxY1Fxb2pXSEJZSGw1TGtjbUVxVUxRQzdR?=
 =?utf-8?B?RVB1RWN1d0pjdXZFdlRTd3VpcGtjaGcyVUp4VEFWL1JUVFZBcWVvQ2JTNno0?=
 =?utf-8?B?eERjMnl6aDR4RGcyblBzQnF0SytiWmQrSG80SWU2OGJDQ0JVdVljdDFUWWY0?=
 =?utf-8?B?TnlQSk5JaUpUNFB5cmdDN3ByQnk5bXhFRU1DQnY0Sm11TFdLd0liSEt1TnR6?=
 =?utf-8?B?TGRBWWNFQngybzJSMWtLUTNTSEVLZjVIQkZiUktnRHNlWm5DSzNLZnpod3RI?=
 =?utf-8?B?dVp3SWlJcHE3TGtubjZiSUdHVnE0blljbmt4d29TQWtyeXBtWHVIQ1paVUVz?=
 =?utf-8?B?R0hOTzBWLzM3akxSNWh1ZmhUTVZwcVc5em1EeVBCcTN3d2JpV2FCL2NKbGlK?=
 =?utf-8?B?M0FCNlVsSFRsMHdtT0xJM3p0U3B0TUJiYWYwQW02OWNSbTlndUJDYjFlOGJ2?=
 =?utf-8?B?S3BIbDZON3E5aDlLWklueDZYK0NOMG1wRGY1cjBISytjTndrN1JpaXJ1M3dr?=
 =?utf-8?B?b1p2WHNMcERjYmJCTVJPZDF5L0xQS0lQN3lkWkJqTE1TWFRRdW5wcjl0ZHUw?=
 =?utf-8?B?cEZ1RkpreUdlb2RtOE5oekVaU0lXb1ZCMFg2SFpoYkQvQ2h5YmVscHp4dlZF?=
 =?utf-8?B?NnpQY1lVUFY3dlNqWUN0ZUoxK0EwZkJma2JsYTFSR1ZJcVJ4NWNQZEtGVnJ1?=
 =?utf-8?B?aHZvbE1QT3RMQ29MZ0NYa2ZxVko4aCtLNFZ2QkRGd2ZpWlM4OHp3NzhMNU13?=
 =?utf-8?B?MThHN05BNE41eEg5U2N5M05ZVlUwTEdFamxNRTkvNDZPbGlKQWp6VmtFejhm?=
 =?utf-8?B?Y1k4UXE3NDN3TkZkNDJMVk1NemV1RHJLK3pndWhwclZCb2JkZ21jTW9CbWgz?=
 =?utf-8?B?QURrM2pHOEdrcnJWQTJqaEtQL1E3WUJ1WS9oMXBtRzJFNUxWd1EwcUgxKzdT?=
 =?utf-8?B?VGs5MFg3bHNqeHliOE55dlNCV1pXeStZQ3dXR1FwU2NtUFkxN0FFUC9XL1Zq?=
 =?utf-8?B?SWlYU2dUTUtMb3VUTmRWNlY3Qy9DaGtEZ0VzYnpiSVBWc245bEtvcWszYmdJ?=
 =?utf-8?B?T2FpSnFFdFNLc25LSVEzZXl2b2JGcmxsMlVVMDdEOUFPV01MVzhGWkYxcElv?=
 =?utf-8?B?QWFqNk1iQ0ZQbGQrc0h3OHZKOW1ZdkhlakgvQ09qZGtyaDNFeUJNOGs2bXJF?=
 =?utf-8?B?d3dqMTdyQjNCdWlpQkNWeTFIekFETXcvdzA5VjI2dTh3SUZ3YjJUNndEa1pQ?=
 =?utf-8?B?SjlGOEhLMXpaQ3ZITnpCTUl4Z3FjbXdSRU1DUlZZM3loUUVRTTl1dWptRnJj?=
 =?utf-8?B?cGgxdkdkL21MUitqYkhuN09HMTFZOXBnSVpuUlhaVHc5T25FbjB0aG5PdnZh?=
 =?utf-8?B?dHhSRytkVE1RZ2R1QXRLMEdBZUZaQ3N3ZXBsT0w1MzV0a1RFaUNBY1lET0U4?=
 =?utf-8?B?VlQwYUlwdHVlQWtoT0NoYms0MUhNMFhqOE0vY2Q3UitIR1dUVTZOcVJVOUlP?=
 =?utf-8?B?ZVFIWDFFVGVJNjNhUWpCem1qNHhjZ2lZS09CbFN0Z1pCSDg3RW9nTURoN2hK?=
 =?utf-8?B?SkJ2Yjk0ZFNsamRPS1FucUYyOFBkZFpkbWpNazJjN1d5K2xxdVpFS05HT3BG?=
 =?utf-8?B?ZHBQMWZOYU5HZWRpWm1qWWc1ODgzNWoyYmJ3RmFodGdJaEhGc3NCeXVucXRY?=
 =?utf-8?B?ZC81NzhXS0dycFBXOTl0R3k3ZC8wSHhWYjZFakc0RFhEZ3Y2RDMxNmI1dzdV?=
 =?utf-8?B?OUpaQmhjU05pZXBPR2ExcFdwMys5R3k2d0M2WDZNMHpydmhqU1REVWdxUGFC?=
 =?utf-8?B?dWJpWDAvKzhqQ2FURW5DOFlBNTBmVFFRck1ZOUNiZmQ3endua3lybjFZbitO?=
 =?utf-8?B?L2ViNStCYUZZdlFFUjIvWHhZa0lyakJTZFFocGFYb21TNDd2RVE4ZG1UbkM1?=
 =?utf-8?B?cWNrYkFqTTBEN3g3SEpDTlZVNG5wVFVxL3Y1N0FzdWF0Wjg5UnpZZnpBWHJj?=
 =?utf-8?B?NUEzVmgzU2JqNWszNWd5QmZRRDkvdmJBTUE1Z1M2cHdxQlM2YmZDcDNlV2R3?=
 =?utf-8?B?alUxaXNYU1VyNXFhWFZMbHY4dmh4SkpsdGJ4Nk4rRnE3dVBlWG5LMm9jVE8x?=
 =?utf-8?B?R0xpZ3dVK2Jjb2VHR0tFRDA5WmN6aXY4WGZBR3RlbWJuOTFkNmpQS1VjdlVZ?=
 =?utf-8?B?eWZweklxR2d4bkNydG1BWEd5QWFxRmprUFZ6TkpTckZrRk1IQzNQOEp6b1Fk?=
 =?utf-8?B?WWJZUUtkclF2Y3RjaDliaU5rdE1ueUE5N2hWWXU0VUN4NVNWVk5LaUVUaFBI?=
 =?utf-8?B?dXRNbGt5Vmo4NEN0TTdMVEtUd3lOV0c1cERyTVl6dVZjNWxtM0RJdmkza3hp?=
 =?utf-8?Q?lfibcTzdA7v6HUj4qohOSe1YtoWuT2PoMlINUzkbMtjgg?=
X-MS-Exchange-AntiSpam-MessageData-1: 6tiYn6/9ARFRXg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbed591-fc49-4193-c891-08dee22f40c8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 05:09:31.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWrgyqujr+gkVuSoMESOIA/LETh9x2rO+QSzzf4s5LoruqVjdzaAy7MvHDTDTUk/5ssY3eYl+xsQwR9L6xL8SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8466
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9728-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BF5F75A9F4

On Tuesday, July 14, 2026 9:02=E2=80=AFPM Uwe Kleine-K=C3=B6nig wrote:
> The registers of the PWM IP are readable. Use that to implement the
> .get_state() callback.

I swear I was going to implement this after the Tegra264 series was
accepted, but I don't mind this way either.. :)

>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> ---
>  drivers/pwm/pwm-tegra.c | 48 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 8e5e7e37f4ff..79bfc7589db8 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -309,8 +309,56 @@ static int tegra_pwm_apply(struct pwm_chip *chip, st=
ruct pwm_device *pwm,
>  	return err;
>  }
> =20
> +static int tegra_pwm_get_state(struct pwm_chip *chip, struct pwm_device =
*pwm,(((1 << pc->soc->scale_width) - 1))
> +			       struct pwm_state *state)
> +{
> +	struct tegra_pwm_chip *pc =3D to_tegra_pwm_chip(chip);
> +	int rc;
> +	u32 val;
> +
> +	rc =3D pm_runtime_resume_and_get(pwmchip_parent(chip));
> +	if (rc)
> +		return rc;
> +
> +	val =3D tegra_pwm_readl(pwm, pc->soc->enable_reg);
> +	if (val & TEGRA_PWM_ENABLE) {
> +		u32 scale, pwm0;
> +
> +		if (pc->soc->enable_reg !=3D TEGRA_PWM_CSR_0)
> +			val =3D tegra_pwm_readl(pwm, TEGRA_PWM_CSR_0);
> +
> +		scale =3D (val >> TEGRA_PWM_SCALE_SHIFT) & (((1 << pc->soc->scale_widt=
h) - 1));

There's one unnecessary pair of parentheses.

> +		pwm0 =3D (val >> TEGRA_PWM_DUTY_SHIFT) & (2 * TEGRA_PWM_DEPTH - 1);
> +
> +		if (pwm0 > TEGRA_PWM_DEPTH)
> +			pwm0 =3D TEGRA_PWM_DEPTH;
> +
> +		/*
> +		 * scale + 1 is at most 1 << 17, TEGRA_PWM_DEPTH is 256, so the
> +		 * multiplication for .period doesn't overflow a u64. With
> +		 * pwm0 =E2=89=A4 TEGRA_PWM_DEPTH, .duty_cycle is also fine.
> +		 */
> +		*state =3D (struct pwm_state){
> +			.period =3D DIV64_U64_ROUND_UP((u64)(scale + 1) * TEGRA_PWM_DEPTH * N=
SEC_PER_SEC, pc->clk_rate),
> +			.duty_cycle =3D DIV64_U64_ROUND_UP((u64)(scale + 1) * pwm0 * NSEC_PER=
_SEC, pc->clk_rate),
> +			.polarity =3D PWM_POLARITY_NORMAL,
> +			.enabled =3D true,
> +		};
> +
> +	} else {
> +		*state =3D (struct pwm_state){
> +			.enabled =3D false,
> +		};
> +	}
> +
> +	pm_runtime_put(pwmchip_parent(chip));
> +
> +	return 0;
> +}
> +
>  static const struct pwm_ops tegra_pwm_ops =3D {
>  	.apply =3D tegra_pwm_apply,
> +	.get_state =3D tegra_pwm_get_state,
>  };
> =20
>  static int tegra_pwm_probe(struct platform_device *pdev)
> --=20
> 2.55.0.11.g153666a7d9bb
>=20
>=20

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>





