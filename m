Return-Path: <linux-pwm+bounces-8415-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sG9jIok6ymnD6gUAu9opvQ
	(envelope-from <linux-pwm+bounces-8415-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 10:55:37 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 238A8357924
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 10:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 90C56301345C
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE9F3B47D9;
	Mon, 30 Mar 2026 08:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fTpaYkwl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CF3B38B2;
	Mon, 30 Mar 2026 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860856; cv=fail; b=Z8AkxPIOzneY6SOA+n+lE62BQO1u5eW+ANmrhdRCueLik/b/QE09KFS13BoURvVZZaIm63F+o0x8BX1USImo8vAYvN+YTHU+MeaRZbTiN+iZIUDRWO7liqkpsYwPZj3CEOiVGsDBvCtwky5bgXlpi7E84An3I02FyJwwGQqf09w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860856; c=relaxed/simple;
	bh=R9vITPEgkYjrs8V7eNTrRiqRRDEtB0yfjoIa3pwKg9E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Mvk8L+A0hKYdgWRxlYVbJBgmSf8hdjuL1pxSb5WyabfymYuLlHSl4qlQbQI8y1/ny0A79b5w6/AkmOUO1K8PlFXK1aCjDmhaKE31GPQwVkhx4AOdbwcZnMsLb87zJHDIGNFjOdIFbIc/2JWn6bsH6SdDsrML3XuVut8QqwmD4t0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fTpaYkwl; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SY23d+mDChcJQpzaH0P8G3q3Q+wR/Rom3DUgZ/rPuInxmwRJ43qHvEh0BySWaQglD2VY3q4Ye+wbPvjZ79L/JC5/ecRV/ay8SFUgOIiUpY09Pr0Ctvk4esqkqi9ZKS8KcW3/qH50S5ZHLQX3mYhVyZOJu5PKy4B8kgTpFzzUMNJ8ezAPNQQlomBf/90P8jhV65vhFcN47OXhd73smCfQsZBcIYXCc/IoCk4bVYyVYLU30Ds9yiLugd02sLoTV2MViLgzYZ20jyS22NCOlQQzfJGUZUpCCJHnZE9OGTuzaifdJ16Umh4oQdNN9RLq9YKM/v74C+q21FDvSsYVitfFcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku8IRXIAwsfT2yuAvA6Zy9UcY742OjS5MDgc2pHh25s=;
 b=zUYoci30I1EeQGdPedeDK+Ujo2w1rO0kIIiFX6bqK/0IYh+IVf7jA7ymkWCeD9z7qU5uiOKcweErvoci8CvIzvZAbzalImz2d9oJiKVa/OG33Tnl5vPb6vM6iNnPWnKY3dxDuWBiVPBS4u8NOBFDjWSK6wPaZAs9VzIKqw14H2b5YcZUsSQbaLC6F4fGWucPDsDH65fQchDJ6OcK09rQPF53vtbVSmZs7XnmdA2W55ZzSIh6iJrE8evzZE2gxmhR9F2JG2VkijDzmh3AJCIRTNLlkdxsnjrpe0RtAxiF2T8Ziv/IqYfsj16keexJjpFYWnfrYbwoGPNifQd+nNLIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku8IRXIAwsfT2yuAvA6Zy9UcY742OjS5MDgc2pHh25s=;
 b=fTpaYkwlOYEXYp+gY38esOi4hyuzyTe7RTh0bb+AXsl3753WzVNljv7q0CvR7rGcSLiQr5/n9ULU0sF9Dkjh1VwpD7Ig3ES2+1f8lctAjoV7Fp4ZmwQU0D3cHLjPo2iXBiZrkatjv32lDjCnKE3T92Tj9WDDPTS1vNB8fy4HXSohbhzxEujAPRGHmkhfWCPBQmhp2cbZu3tNubUmLbNxTBraAPLNZzyEK9Fw/iQr9RsxBcWgkqTT9PrvVQZa6BwWM+axjjhqiHs71Li0gRwRWxGRY80Ss7wqP7328geSit2vTKB9zToVNSG/fUc1LQpOksa191BpUafnzDbDmTHAfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM6PR12MB4281.namprd12.prod.outlook.com (2603:10b6:5:21e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:54:10 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 08:54:10 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 30 Mar 2026 17:53:54 +0900
Subject: [PATCH v3 5/7] pwm: tegra: Parametrize duty and scale field widths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-t264-pwm-v3-5-5714427d5976@nvidia.com>
References: <20260330-t264-pwm-v3-0-5714427d5976@nvidia.com>
In-Reply-To: <20260330-t264-pwm-v3-0-5714427d5976@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MW4PR03CA0243.namprd03.prod.outlook.com
 (2603:10b6:303:b4::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM6PR12MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: f78e1590-283a-4e6a-e9b0-08de8e39e87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fMl2YrIor1NYqp9lXWBe0KmkzmX6efgw73tNWCHyqTwfbgUxCjzJjmzEQtVK388Szn+lT22ynH9UnWUU6tLCP76lMN7C1nP3uYlcSKzAxsHYJoIzgH2aZZcr8PuP6kXRV8rgGiqm/LZGrkX/Tazk7QCRav/4MQu9n6fobALgYe0MSeUL6Hpt+fm3WSidHkZygimM5JC4/GbTUJce5mKI1GkRsJAYQ6wObXbbYWneqJ58B+GTLSG7+79cCMrRetvDhKKHClihrV+j4OcqWpwOjipOSZ3DFeVXn/0jPm4GrPswcKTvWbUcw4dRfC3oGbyQikM/euosnon6lQjxIOcrrHPAtor/55N1c7eurjtjDN6AhDvYmKyD/eyHwEV1zuA3j3/IZPJBqAVIwKdjYa1dDioNlvRTWJp8XBEKBpOMDhw27a6JYhk76draDZgcLkjDLl5X2tPbRNRpMxAnC88bb18y7ws6zCui3j8vEAEA9Gw6tvPGScPMBjcfyozZ7i3M9s0D7+3UNo2BwkacZaRpZg1jViunNwNGzoMsatwPniCd3NjguOzCaimkwNbeWlM4Gg09b7K18EdMyAGk9AYGX1g0EByAR+MkqKL1jThYMiedfRlwA1G/ifTIRR6nYYB+Ja9wNIAAQk6AeCFbmYNhz8PEJiWPWofmWfP3grf+7hxqkkJhqLykXnQbpvDdNscZAoNSuR8RT7v3qgCNxWKbrfG3Qf6nz7sh1EGTgT59wy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cStjb1licU45Z1VrOFpWbFVmRkdmazRHZEpVYnZDdjAvdGNyalJSVi9VWTJH?=
 =?utf-8?B?MWJJenV6OEYyZnZGbXpScUZaQTQyaXFRRGtBbUxvdzBOVGtIUXpERWdzNzNa?=
 =?utf-8?B?OW02YUJwNS9jd0hSbU1YKzBzUkdvcXBSK2RWd0JDOGNEZ0NiY2hKN3luTGth?=
 =?utf-8?B?UzdoOWJZbnBUMkJqc3RvU25SK2Y0bFFPb0g3WDhjWFA4R3JOUEl6Qnh6VHhQ?=
 =?utf-8?B?cWY1Z2VBNGhkQUorVllIUVJiVkVrNDBqYjNOTlVFaTJ4THpwYlRKTE9kN21G?=
 =?utf-8?B?UnRRT1BwaVNaN29mR3NCaldFQVBTTzBveEZ3NytjVjdiUkU3YXJadmh1WGNB?=
 =?utf-8?B?OVl5NnBrK3Rrc0VUMko4cEYrakpwbWl3MktZM2p6a0xiS3lBZWtoSGkrVjBr?=
 =?utf-8?B?L1FwNmdVaEVaeWxRczdWVmc1ekIzYXFBbHMwNnJiZ3gzQ1ZLZi91UG1xSnJL?=
 =?utf-8?B?NGJ3ZHJ4WmtjQlhTUk40cWVGUXJiTXgvdkZYWUpzWElzNFhNZ2c2ZkNvcW5n?=
 =?utf-8?B?S3VJRmtiVTV5OHNHd1JwTkRhd3MyTlNremtJSTk0Vmg0V1dNRWRjVEYrQUZD?=
 =?utf-8?B?Q2o2MHNhaU9JeVJtVE1lTG9ET0l2RkVUMFFSVFRacTR1QS9abTd0V0VSR0Mw?=
 =?utf-8?B?RkFEVFVOU0hCVXJqc1hXbjlaQkdMdzd6NHZsQVBnRzhoVExrK3YxenBQeU5s?=
 =?utf-8?B?TjBRVEtQbGF6VkZOcXhuSXBIWkVQSXk4QU1jcklWQ1IzalNIWFhMS1d0L0Zx?=
 =?utf-8?B?Q0RDWHk3cVZITmt5RktXQWQxRU9oTG5IS2tYcUx2RG5xenlGeDdWUTdQb01P?=
 =?utf-8?B?VTNFcWY1cXhMMTkyYkg0SDZBY1U4cEZPMlVROEc5Z2ZNSkRCb2ZRZDJtcXFh?=
 =?utf-8?B?eUpEMnF1em52MkNaUUJLNDBhNGJpQTZkVTkwdDJNZkRrRllWQ3JNVzZWbXk2?=
 =?utf-8?B?d0UvTk9rRXpXeWxZdG5qTk1Sbk1HK240MFFGVlZOdzNGUllwakZUNDFrdlJW?=
 =?utf-8?B?OGpFK3NmR053Z0w0WVJJUzJPSExxM1VwOHpsNFVIS1FPcjM0eEREZkdCRTZX?=
 =?utf-8?B?Z3RlYlFQKzlQbEVKQTJzakZUdXFXOVRLaFJZWXRsbEY5Ym1laExrWTFkR0dZ?=
 =?utf-8?B?Y1NlendMOUR2SUFrSmNKSkh2eEN4NU4xMDU3TU9zSVhISStHY2R1cnRLME5E?=
 =?utf-8?B?WWtZcldiTHFGaDJwL0lRUmFicEwzbVlRSXUyN2VOWkgzQVV0ZnNldWY2OW02?=
 =?utf-8?B?MVc1d3dyTTVBM3ZSdnNlM3ZYVWVKRlh5d0kySHZUUDQzRklVdDRyT0w3Z0or?=
 =?utf-8?B?N3MwVkJMWnhyRDcrTkNDOVlkK04rWWlKdXNuZ1JOaEFXcEUxQ3I2RFpVNHc4?=
 =?utf-8?B?MitrR3JJdFJnNURwbjBncHkzVzM2NXVwaWdacWoyTmJZOTNuRE1Bb0RXSDlh?=
 =?utf-8?B?Y1NVd1RMbXpWdmp3ZitTNy9UcTcwTk5jcmpCQkNKSzJsK2lWMXlkV2l1MVFJ?=
 =?utf-8?B?N1gxb2xBVHd2S290ZmtqbzhUWTRUNnBVN3B4bGRNR1h3OEZXZU1aaGNmSkRy?=
 =?utf-8?B?SURldTJkdmpwTmlocDZUTy8yS3FRWmhlMmVDaUt3WjVGUjMzeFJ3STVxa242?=
 =?utf-8?B?NzZ6TGFRNGRVbU1uaGxtK0VKZDI3R25oTG9kYWJCaTZvd0RwV0MvK3VMKzdS?=
 =?utf-8?B?UXRDdCtlb0VoTEhUS0FZbGtwRmRybFoyNTVrRU9LTHpmR3hUbmpZTXAyVEtF?=
 =?utf-8?B?SmVJcVhOUzZjMUFQanhrUnB1RkFhMHhjS0x2ZFptTEVTaWVPbWpadTQ5a1Ni?=
 =?utf-8?B?c1NnVHFjSU1pSXdqejRFSzRUemIxekNCMmVDdVdIQ2ZsR2xmaUhaMmlMZUMz?=
 =?utf-8?B?SzdUYlRFVXYzT3FvU1BBcjZrS0lzQTRieEZzakwzeVJHbFV6MXdWUVFzRmtJ?=
 =?utf-8?B?UmEzMHZheDJhL3hMSFozMFhyeDRpOHZuYjkwVStQeUc5UUF5cFhKSGV5SGZ2?=
 =?utf-8?B?U2ZoRGNKWDI0eWRoM0pZU2l4OGxFN2Q2VGxkZldaMzlxMU9ITkVmNU90M0Vl?=
 =?utf-8?B?UnNHRUNxRUFHZVRFT2h0ako3ZE9JVXdEbkZYSlNtQS9DVzE3OThaQityTFA1?=
 =?utf-8?B?LzFCNHRPeVQ3akxiYWh5MnB3bkdxNFJTTyt2VStQNDB0Uno0VFJhZVRHU0N3?=
 =?utf-8?B?a2d2b0Y5MFk3QSthVTJpanJhOGRiOGtTV1lKRGdwczVQQkNxUnR6dDBkMTJy?=
 =?utf-8?B?T1ZZQWpKa2NhV1hrTXFXVjBoR2FTVUZicnpyd3ZaMUR2WklNUnpWVFFseFM0?=
 =?utf-8?B?ejZxaU5TOHJUQ3QzVzdJRXVCSFFMNnl6Q3JUY2JYTi9wQVNFeThhcHdTQXAx?=
 =?utf-8?Q?nDFnkfSDzSUjhUKTvqxwFUa+OLT5GgZMGrMIPo3uKNzCp?=
X-MS-Exchange-AntiSpam-MessageData-1: CDlXJi9Rwg0nTQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f78e1590-283a-4e6a-e9b0-08de8e39e87d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:54:09.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjTZ5S5PgI714ypkWho7r+XJ/gbTz9uVaHGAEQMvyen7ItNs3Y5EcA60LGyQ7iF+2W8DWKgnjvxNGMqD/Dltjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4281
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-8415-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 238A8357924
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tegra264 has wider fields for the duty and scale register fields.
Parameterize the driver in preparation. The depth value also
becomes disconnected from the width of the duty field, so define
it separately.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
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


