Return-Path: <linux-pwm+bounces-8362-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBhNLLO4w2litgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8362-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:28:03 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 300D8322F16
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC0CC312543C
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734773537ED;
	Wed, 25 Mar 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PY0l9WUt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A95396587;
	Wed, 25 Mar 2026 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433891; cv=fail; b=iex1s8KZSOyvxJCxRQhRG0EjD4SkEPmj9lxuEYo6G0GXBITdBtJrUPFhEQ7nTXteAMYl/Dc+d9gfgLgz1e5J4pcxVKC0J7dJXltBAyYrcVKFGUlc/rcFGYUkbkMWw10c7Zt7SfaL84UQG/Y8+2wSKWM0b1XbD4/YRbA4Sx3OO8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433891; c=relaxed/simple;
	bh=CvEDDxhl1fQITOzJwP9B3ngqq6SfzMFb3/Q7UMCe+fA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=uVqXNlAPPRy1qIXu5oqtVGeEAPgWYYVHJDTE7o36z2TwLMkGpiGx81sousQGmTT7f40q7ght36CWkyjYaf4RQJRmPsf1sQ+k1emYHWnOh1zpx6zxo7o0/UXHlShI5JhsAy3JZm5MBwU7DydMVrqw/s8fEp3OYH/1Y6ZIvBzFHgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PY0l9WUt; arc=fail smtp.client-ip=40.93.198.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RC+XTvobae8ZgsOXVWE2ov83zaVmQSWZB89VBEc7ClCwIuhOnFZX2QTupjE0h2VelzUr1f2UxAvw3cvlTtnyGF4CxudvWLKdogL9ZORU7UjuVihuPklOfLncMDLSUme5g9wiqUFOA88Po/snfdRTp8YCztZEapuPk+asCz8HJVWuRQlZH3sPfvY1ge5IQv9SfdmDXXCy8DJGYYxcx9ScBeiDXdig9tGzh9azLL4VWFWFekJldpJv0jOwBDdD8hpl2s4ziHArKW+rdStM24lK/l1mbH0og+ByBEk+yU/Qi+qRz3s9lutqkA78pQ9aAa1NhtccHP1GOBTymlj+QPKo+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWTuFH2ku7rYybzhP0qo9F0sgEx2rGXM3tRrGkq4dlo=;
 b=c6PSgrcD8yV+c74YUWW1DYYQGPahwq6Zk3w2VUbblSCLfESXWnnwT1et/D47TNZtCiPx71X+VYi5ITtdnwNlRXfFHJwIpP0e1DtLxfDeJPT9X6kJSGyuUglafkGXPUqClE643f60Ddlk8dm6vUJdw2pidqnUAh1bXL5z+KtYHYjsvaeoGzljM8I7jEO2HphzRSPxWLt/0eXkhJlcOUS/msRKI+HxZSGxJZDNk/gRkWAaonuD03cAmL4/49NCJGwkPLTH70RNTUrJSnu7vgbgB6amVdFVwVwjfhvibRDLn9TS9MCtxVsN1ZYDNyF2nwRss+A9aaYxNBA+XQzI/zt+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWTuFH2ku7rYybzhP0qo9F0sgEx2rGXM3tRrGkq4dlo=;
 b=PY0l9WUtCUbiZRpdOS3a4dGMHhM/XBlaJEJF7rBUmYJGkrRfvgUFBGId4KAsx4fWEHRjdn4j2Zc8oIrXnsG0UZCksy/ThKT3b94HMi4wvfZ6mdHneY4t6hICBzP5g4WDgxqsrjWE/hO1aaCsRJMVpqwQ2ehew4d6oZ6JafxC/ZfFUYxSzqQ8WPXGXqWO6yLCJ4HwnJ129NDPnGOWvT8ZcTKmXe2WEuEvanYQflT0b1Zt67/QUG2BVACQ7Y1zuBcoWIjuT3ruOi+Yf56QELQrEep6V/KPVOW2P2PwE4Y+9S/A3M7IwCxIpNlH5R95q/q5BN2uIqbhLG1lu/7e3JkL/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:18:00 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 10:18:00 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 25 Mar 2026 19:17:03 +0900
Subject: [PATCH v2 5/7] pwm: tegra: Parametrize duty and scale field widths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-t264-pwm-v2-5-998d885984b3@nvidia.com>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
In-Reply-To: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TPYP295CA0031.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:7::9)
 To SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 08496e34-edb6-4f91-d893-08de8a57ca93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	q2J6NlcpEhpiYXDQYuKOLb4C/xMgwnZBfOZWMdpxJlSrW8MxabboZd8++HHcurPxV4EuditYU14/LTiwir2noxo1BqfPqfGztZtMFBccyRJv5cHCJY5XadMscWBhTXe2O+41Ec416TivVesUjjeW2DS2GWsX0AsuC8vzN0FU75fa4ARGbbjC9BVTjDHQsyAoRL+HtYbJkPdXjK2eoZieAkvctb6VrP//geuzxfcBn7Qo8bBCCwRoKOd1G4G+yEj/J3klV+GGuTAlmyAl6gJQP6SxLhiNxz9F9erxewgbeAmIQDB16S34C+aj58nXyiWVMx4aM4CaTZ2zRwUf6xDFpTqTfIgE2Kr4ZieGDfrEifsiNaTIUQVucoPAzPK8CXEYDHI1vsQPq1QQMwOMU89XxmF+ZWSt9FwcH7YH1nzQsv/5B7JQNGe1336sSEnvaKg7VZTqHaLW17f9KgiFyLpH/7E4gGKKO6C0f0dw5k+HlXfadwDeaWcWGfL3NbnItBuWxVkksCBF+t2RWSWbOHot8FE8oPINniZ8cQzjhddtQBmokEvrCYzzdoB68bN7H8TGaRMbQpbFjE0RO84FN5xMyEnec7yeaDmCPi0PoHAgnyNaJj5sFm6IXkgiNf3T2SinQurxwUZGi8Ayt2bN2m8+WsnxJ4uD0v2gccFeGDH6VHHkgIXv23GPnGsHJ+LnhBB5Ld/zd7BSJwFh8Kf8kr5ARXxjbtRmYzo8ro/v179rIMA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MzlDQmI4NVh5VCtOSkxJRWl6WStaZDdCRUpyTnh6TXZUblBhc2tkcGJ4Qk53?=
 =?utf-8?B?Z3J6a3ZIUXZlV3dYdUp1U2pKNjFxQVFLZHNxZ1UzZ1EwNTlDU2JIbXQ2OEU3?=
 =?utf-8?B?U3dmekR5b1JSL0RuUW1Mc3V3WXlwWTRpTjY3RE9pQ0hMaHpxNk41ZnpRcm8x?=
 =?utf-8?B?UkUyZ2I3VDdlOTZVWkJvbVRJYklWcTgvdml6aXUwYWQ5dEpMNTVRZFdVbDMv?=
 =?utf-8?B?N3l4VUc0RUYwdFFOaW9aT0FXVVhtZ2U1VU9oVmp6YkdJbU1WSGU5dnhoK3Zi?=
 =?utf-8?B?YVFIeThYNUZ1bzBDYnhHS2toUU1iU1JnZUppVVlpV1liOTFpTTcwLzdMYzAw?=
 =?utf-8?B?Y0J6VVlVR1V2cWxmOTQ3ZnNOSXQ5SWh2N1NLTzJlRTFQaGM0djZsdGNWbU1t?=
 =?utf-8?B?WWx4bEtIWFZtWERJdHdmU3JGcXRwMnN5ZUhDM21yeGhnK0JMOWFaWHpGOS9I?=
 =?utf-8?B?dm9KK0o1OWRSVnpmYzc1RlkvaW5yRjEvQWIrWEsyNUxSc050YXdLWk1wSk94?=
 =?utf-8?B?RGZSZnUwdi9tZmVBUUNIWlZQTXlhdXJyK3Q1MWpaUm1vZGNBZHRSMGpiTE01?=
 =?utf-8?B?bis3ZkVaL1QxRFJpaW5tZnB4TUZYVEwwTzlkbHViLzB4cTJaTFM5OXVqVXZO?=
 =?utf-8?B?c2VFZEJPY09xYVJqZXNBWE1hZ01LTWtId2I0cjBUSTB6dVhRK25TOU1LNmhp?=
 =?utf-8?B?aTRrOURuMWtvUjgyOW9hWkROZGk1UnRzUHVlZVlIeCtJY1kwYmxCaGtxQWJz?=
 =?utf-8?B?MmNadjdvMlZYMGFLeUxObi9hWEdoZ1JQejlBR0sxUFJMWnZmcFpVMWZCQldl?=
 =?utf-8?B?UjhCaGUvK1lLdG15aWxoL2NsWlpTeWdXU1pRdmtyMzJTbVgrZ04raXpZNDgr?=
 =?utf-8?B?eStlZHhRWXhNTys1dlYyZVcrelpKdTZjeUREajgwMVJPV0RHbS9FK0w1dG9o?=
 =?utf-8?B?cXdTZVAyNUhBSTNIVWp0ZWFyc1A1MXJveHNTUXppc3hFMGFkNHlqMGxROTk5?=
 =?utf-8?B?U05FMWdCZ2JHOHltT1BhWVhpelVYTzhxS3EyNDFOVUpTOWhCUStrT3lqd2VY?=
 =?utf-8?B?eUppWi9qOVZXK1h1SmJ0THBJN3FORlZOeFE4Yy8yZlE5SFNXSkJnNml1OGZT?=
 =?utf-8?B?QXd5QzBnOUJrNzdNbHRMc29ZQVNFQm9YS3hSZ053SVNNTExpa3ZpUFhwYit3?=
 =?utf-8?B?anhGYkp6L09rQ1ZVRmdra2J4UGQ2S0tPQW91eS9OdzB5RjBiWXo4YjUvS2Vk?=
 =?utf-8?B?cDJQOXZ0WllrdElrQmtNbXFNSlNGMUwyVWhRMFA5NHpxNCtUay9VS3UvMUlq?=
 =?utf-8?B?QUFCRnphS3puSHRrc1FPWG9heEl1M25sMlc1R3VjbSsyckJXdHZHZ3kySzJO?=
 =?utf-8?B?MGZKWWVzOEs5eDRZd0c0MW9MT2dUSkhOM3lvS0d0TFBLcmpvTU9ZUnJTZTI5?=
 =?utf-8?B?ZWx1NzFIT2FxclJ1dTFQKzNvL1BOM01IMUdtWDBZTlAzeTJYUzYzWVcyRU10?=
 =?utf-8?B?M1NZa2pjMUFrZHMrQ21aSUNGUmd5eU95ZHFUMGxXZm9uYnIvaEZuS2lvTzBt?=
 =?utf-8?B?Z01FdFkyRDlGamg1UkhtMzA4SEFNQTUvdkZSbnhXTk5rNm1pNElaSVNnbXBZ?=
 =?utf-8?B?Y0RrSDd5RVdnQ2NUVWp1amZ6c1N5eFVsY1dmNHlWdkVoOTFtZ2NlUGZjejVW?=
 =?utf-8?B?NENqeWs5UENtOTBoOWpnb09JL2tiWGhhN0VCNmp1dWpKSStObHcvT0NpZmFa?=
 =?utf-8?B?UmJjSlBxVkZUekJINHMzdWVKZ0V6bEY3Q0pKUXR4T2JVVDRHTjBCSHVKTzJG?=
 =?utf-8?B?dUJybGNoNmFoaTlRMS9lTzV0YnViOXhsKzdlalIzbWVFNFdEei85WFRMRGhF?=
 =?utf-8?B?V3dMRXFyZTFJSVVwRUxaekVOTDgvVkxHT1UxR2EwcFQ1bDY5OHloaXNnWEJU?=
 =?utf-8?B?UXh0Zy9UcVR4S3BxeFUxT2VRMnVzQTJTVVJnQmJMcm9YTElmZVV1TU5haE9Z?=
 =?utf-8?B?MUJKalJld3VIVDZ4VU04TUtmYldiNFZ0NjkxMEthK3NYcXhET05hREU2eHhj?=
 =?utf-8?B?ZVppQ3dBSUMyY0NxY0k4VnQ1eDcvajNKbFlTRXRqeVV6MnNNTEJieTU4Wk5w?=
 =?utf-8?B?WlF4ZHVzWTQ2eklwTG5KeXhOeVZ3bE85L0lxYmU0SGFtMlp1d3F4Q290dU5L?=
 =?utf-8?B?TEtWcmhNdGRmMFNBdVdad3p6elltSkFnNmdFQktleXVXU2hUckUvcUJ4VXZ0?=
 =?utf-8?B?bzZiVVI4OEt3SGlMVkZYNGZQU1dtZWFDaUd4TGZrdndOV1dBNVBuNXNQaFdQ?=
 =?utf-8?B?dEVuNHJYUXdXdXNrbmtPdnJPajJMa29YN2cvd3hJeVliQkt0c1NiUittQXZ4?=
 =?utf-8?Q?QfcdkX/QeieM2hjaPWWKY6UwgiblZuPRw+/B15cD+cGzQ?=
X-MS-Exchange-AntiSpam-MessageData-1: Jc306IebehhoNKJEyRcTz8UJADtkvWpfe9E=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08496e34-edb6-4f91-d893-08de8a57ca93
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:18:00.1680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qs+WwcOnN/VUFfVZ9qJkV+z4zlPz8R9HrU8PICroB+X1z2KJWFnkL2L4itpjHcq0O0xmPdEs5VgIvYJ3dqBuqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8362-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 300D8322F16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tegra264 has wider fields for the duty and scale register fields.
Parameterize the driver in preparation. The depth value also
becomes disconnected from the width of the duty field, so define
it separately.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 22d709986e8c..857301baad51 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -52,16 +52,19 @@
 #include <soc/tegra/common.h>
 
 #define PWM_ENABLE	(1 << 31)
-#define PWM_DUTY_WIDTH	8
 #define PWM_DUTY_SHIFT	16
-#define PWM_SCALE_WIDTH	13
 #define PWM_SCALE_SHIFT	0
 
 #define PWM_CSR_0	0
 
+#define PWM_DEPTH	256
+
 struct tegra_pwm_soc {
 	unsigned int num_channels;
 	unsigned int enable_reg;
+
+	unsigned int duty_width;
+	unsigned int scale_width;
 };
 
 struct tegra_pwm_chip {
@@ -106,22 +109,22 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/*
 	 * Convert from duty_ns / period_ns to a fixed number of duty ticks
-	 * per (1 << PWM_DUTY_WIDTH) cycles and make sure to round to the
+	 * per PWM_DEPTH cycles and make sure to round to the
 	 * nearest integer during division.
 	 */
-	c *= (1 << PWM_DUTY_WIDTH);
+	c *= PWM_DEPTH;
 	c = DIV_ROUND_CLOSEST_ULL(c, period_ns);
 
 	val = (u32)c << PWM_DUTY_SHIFT;
 
 	/*
-	 *  min period = max clock limit >> PWM_DUTY_WIDTH
+	 *  min period = max clock limit / PWM_DEPTH
 	 */
 	if (period_ns < pc->min_period_ns)
 		return -EINVAL;
 
 	/*
-	 * Compute the prescaler value for which (1 << PWM_DUTY_WIDTH)
+	 * Compute the prescaler value for which PWM_DEPTH
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 *
 	 * num_channels: If single instance of PWM controller has multiple
@@ -135,7 +138,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (pc->soc->num_channels == 1) {
 		/*
-		 * Rate is multiplied with 2^PWM_DUTY_WIDTH so that it matches
+		 * Rate is multiplied with PWM_DEPTH so that it matches
 		 * with the maximum possible rate that the controller can
 		 * provide. Any further lower value can be derived by setting
 		 * PFM bits[0:12].
@@ -145,7 +148,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		 * source clock rate as required_clk_rate, PWM controller will
 		 * be able to configure the requested period.
 		 */
-		required_clk_rate = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC << PWM_DUTY_WIDTH,
+		required_clk_rate = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * PWM_DEPTH,
 						     period_ns);
 
 		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
@@ -169,7 +172,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
 	rate = mul_u64_u64_div_u64(pc->clk_rate, period_ns,
-				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
+				   (u64)NSEC_PER_SEC * PWM_DEPTH);
 
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
@@ -185,7 +188,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Make sure that the rate will fit in the register's frequency
 	 * divider field.
 	 */
-	if (rate >> PWM_SCALE_WIDTH)
+	if (rate >> pc->soc->scale_width)
 		return -EINVAL;
 
 	val |= rate << PWM_SCALE_SHIFT;
@@ -324,7 +327,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	/* Set minimum limit of PWM period for the IP */
 	pc->min_period_ns =
-	    (NSEC_PER_SEC / (pc->clk_rate >> PWM_DUTY_WIDTH)) + 1;
+	    (NSEC_PER_SEC / (pc->clk_rate / PWM_DEPTH)) + 1;
 
 	pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
 	if (IS_ERR(pc->rst)) {
@@ -404,11 +407,15 @@ static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
 	.enable_reg = PWM_CSR_0,
+	.duty_width = 8,
+	.scale_width = 13,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
 	.enable_reg = PWM_CSR_0,
+	.duty_width = 8,
+	.scale_width = 13,
 };
 
 static const struct of_device_id tegra_pwm_of_match[] = {

-- 
2.53.0


