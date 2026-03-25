Return-Path: <linux-pwm+bounces-8358-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMSIBKq4w2litgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8358-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:27:54 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 982F3322F06
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC98C318FE78
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 10:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9F33AC0D0;
	Wed, 25 Mar 2026 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hLuitlIe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3417C39478D;
	Wed, 25 Mar 2026 10:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433868; cv=fail; b=nKI27XNuP8Qr7YjUMXk9ommtTrmdyD4KQZVk2s96B78OI+Iyk1CYQMTwZtJDlVRGYusoOGgL+1s5a2WRflXSJfr2KkGtMFVzFtWQaikTCyHX6ECeJOOP3hMSL0dconcuDgLCK9aNqlIyh9+O6lXvspmL+ISYq0BMcPWHCmc56O8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433868; c=relaxed/simple;
	bh=ngdychoyzarHOY+vg2bvVWuSGy97KrzqKRoq1cSP39A=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=bwLZp9stGwlu7JF1OAV/jv9oSqyoKzM77gH7Ifi8zb+a7e4Aq65rI+IM88FwVcMf81R0qS3GKkT6u9832+jr7Vgm2CATKA2NQB4QCRAhpFdrZ0Q02OUKBn0WLwD63XfrIQYhKs9I3UQz2CaWyIHcjhkpQWfg0nnR826iu7ne4bU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hLuitlIe; arc=fail smtp.client-ip=52.101.52.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HuLU3BkspMIiLlzMh3Ag09GE25OCUXRbPaoVje6JnKnJV/odgYAEcVHFPTOXwnPRgMkxGc+B8aYrbM/cp/HVL+pcQXY+RK8QsO8Li7fMjrDX7LvxhfYY+iwNtKvwbzs6fJpAcsHqO1TfmRC6xDDq6NZyhtlfITR6RPHMQBnXGUM6wyainlmHVav9V6SBQleLRsgh+S6/zOfv/rtY7UqopXG69aYll/kJIIizN1Ht8u2c/OySXuhnNml2nKODJ5yiHtZQN609G23rC7+hzIf+T2dGttMvaSpeoSDAMT//+39u1OJCn4h6mHcRSnxee/3z3CfTKAnUjtAeRQv8XIxNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssqsClAkDreRd4N+3UZ4vGV+Gisajb5z3aSHCkYcox8=;
 b=RjB0QSUo41OPO3BW/ALPJFOO8RaVIU/ilP0KSNhU8DaY9eUzZdb5ZO0kvv5xjdQP2V49Aola7lN0Bf4PdQ4/hmbjqKcpbgi81jgo5TGAwnancR1j8uCnAw3k/y8dYgbD2Bs9BzH7/v7Ml88ZrEGiCiGktKucKIwQ68ejWX28YTeTgGrvI/FKDhPuHjJeYIUnHyUm5jxY1RmE69M3xxjVc4xyw4nZ2rUbrlQG3NyEhjboDFu070WSyKaO3nUvtJHDTc++6JG0avcQsmUE3bW/D3bNY0lFKo7I4QLaYrXD9eQ0NOjW4GSDuMVGEkVoQLT5LAoPolHEAEBeLvjL6sGMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssqsClAkDreRd4N+3UZ4vGV+Gisajb5z3aSHCkYcox8=;
 b=hLuitlIe0sUiMgcyGtMAqYRqJZBRaVzdfhouvOQ3jVsQLNeCAncPUX2++8ZJNoBYJZHSVACAiFBkrSnUOGlgx6PwHOVmp1Qh2eyyUvOACbVj6cO/QYBzPZBLUL37sHCW+mSiWR9icJEoTpEEjsOEyQOJX4JwnZhY6MUTQij5a3R8LBzOJfZZf2FC+U1awtewpQLzFaP7b6mY2U8Gwh9lKfyCEU0gwP6N32DTHB1E8ydeIeU027NWJnL4qNssh2LVKzYwIsCTW3UzssDpJVayqmoeSaPLyyN1FOECLWVyOh/DdcMgGN1Ozn/2NiPtFWf8eH4YYUcB6d0zwbbBVsX9SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:17:42 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 10:17:42 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 25 Mar 2026 19:16:59 +0900
Subject: [PATCH v2 1/7] dt-bindings: pwm: Document Tegra194 and Tegra264
 controllers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-t264-pwm-v2-1-998d885984b3@nvidia.com>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
In-Reply-To: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TP0P295CA0047.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::13) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 694b6937-8edc-40ce-4016-08de8a57bfdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	H2m8Ikk/YwCnYqGzIA66RfoAvcJ/6xQdkWnxTCrX/ZrA90UFj8Zb8KscDoOjOODptA2KLdSqYM2A1T0d7jxbXD+jlIGgpM7MRf+8Fa3LhSmEJJXn/D85JRtkVWGoaVyS4cQSBuVwQU7xAEFTDmHaLf3rop6USe1dpI0+mUQ84sAvb0bX2LO/zNg5JvFXiIKSqG4PZuAcL6k32TqIfqZLOiqeK7qENoVxr5+YbP0OpWFSb4WWHt+xQS5l6q9PXsI61oGCcoq7H19amWLK+WlWGmcy0TYun4atV/7fNOTO/Tkw/KdxQ4WDXbwNyEIz3rev324mepCRmTU6jTNiXcIv9YL7PtTxf4zT+Yzj1/WMMWOEUnatdJjMhJZeV+B1KENQSwwypFaoCBXTJgVjqTFugmW9cc2zB+V99zwQLVffSyHf4SGmhvcJ0g1mku3QtZOOr641Xbg5edc7K8VSZ8PTtCj6AkfjCjPqFwnujSFEV9XbNte6/jWfiksbVa5sdPS1DI6Qeb2X5gh2yx2zAUyaDehlpY0LYqNhvx06UP6BBBl4YFzdh3C8hXKAnsZTt3GYxJzf4AwV+FC3O339dM5OeZBRpPck1Gov9IDUPkxpfYTPP0w9K1qUrVntROhiChVHiIFCvD5qCdFLGHu+HVRXB5XRvdfA6dhOX8hFyORwrH1ja4wmD+e6Yayz6McFLR+dUfHh9cv2Ypi7c2qchX9tyIO9+SuGnHzkLSNfUREeU20=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TU0wbThVYmlENFh4cExyQzVvd1A1VUhaYno1VFJlQUJqblNJNVU1a2IxdkNU?=
 =?utf-8?B?NWtGVHRzT21taHFkUW5GaHc0Q2dUL0JwSkFyRk0wenREdDAxRVd2ZTR4bGdZ?=
 =?utf-8?B?NVp1ckRKY0RiOHJZZnNkaXNVTmJwUUw2MGpVamowbzJoK1krZHhRd0ZnSXpN?=
 =?utf-8?B?ci9WcHMyQTRPSWtjN1J5WHNBK2JHd0R3bDF6ZDJuOU5sTjg4aUR1Kzl0RXpV?=
 =?utf-8?B?UFE5K1hIakFpWjZ4S3lVRXpOVFBaWnArbU1Xa1IvdmNDbnFBeUlTSCtwaVh6?=
 =?utf-8?B?c0w0NWhjTm9jRVUwS0ZUYkZmcDNvVUpOSUlDdDdQc09EZm53eWhnL00vV0NU?=
 =?utf-8?B?aG16V1h1UXd5K0NNdHgwL3Y1bEpDM0QxK21pM3pKeEcya0lWMkR3VllsV3hI?=
 =?utf-8?B?RUx4U2taWUIxdTFDajBIZWN4aElya1JYa2l5dXZkekNCdFIvaGhpc1JWdFdI?=
 =?utf-8?B?Sk9pRmVNVTc0VWhGK1JBa09WSms5YUhuZXN0ay9JbWJMSWt2cWFFOVRNQm5t?=
 =?utf-8?B?VWtIQkw4V0ZDdWtNcnZWc0E3dldBVW5QZjN6dXAvMmtRR1V5UjNSbk9JSFBs?=
 =?utf-8?B?QWlvU3BKKzdwSFpyV1ppWHM4SXh1c0hHeWFVck5RQ2h5Z1k3SWMzUTVDT2RE?=
 =?utf-8?B?UCtjS1ZqVGVkay9iNVQ5STcxcFBIMnFMTGNRbDZqb0I4VmVReVd4djFOUEhH?=
 =?utf-8?B?Vk8xdWw4TDZJdHBsTkhRV1U1VVRLWW9halcwcFhoUFdUdmtlL25UZGZmYjYy?=
 =?utf-8?B?bUoxUnUwMzFESldCNjdkaGpWbys2MndBTzNNZVJlNmRFYTFWVXV4TzJXQXA2?=
 =?utf-8?B?VXh6akduS2d3MWVuK1ovdzdZQmRWMUM5Q3pDZUZHU0xGV2I5QnNhVXg5Wk5C?=
 =?utf-8?B?VFBibkJSc3RVUzc5RHZ1NnZTVnozS0FDaWlmOWVkRzllZkVXSEkxdjJLejJZ?=
 =?utf-8?B?REVEUlplSXVkTzRmMU5ubE9EaittN2Nxd2ZxSXFmdDJqVjFwU0UzTllPWEkw?=
 =?utf-8?B?czNGZEVLeCtkbFRocE5YbUZHWjZGMjdlZlpSYkZ4TWJmQ0dFUFNJekdEMWpm?=
 =?utf-8?B?T0pYTG5nYzNySjIrZ0hxNHlRVVBoM1o2SHcxdlR4V3ZOeFhOWlRIaXFwWHE4?=
 =?utf-8?B?Y1JBSFFtVzR5emJLa0Nzcmk5SE5RSlQ2TXBkNUVWYTZ1S0RpRVNCWTZqYi9P?=
 =?utf-8?B?d3ozOW5NclJ0M1lTZmo2L0Evb0Yya3kyalIveVZNV3N5dTRBNyt3bVJBcE52?=
 =?utf-8?B?enh5WkhHRm1iUW9LZDdhbUN4UzhtdXRuNFZaUUE2SnJPZHhINUZTTFp5eGhE?=
 =?utf-8?B?eDZ3UWpEbk1YeDA2cXN4TXcwR1V2U3BsQnpKaTd1VHltSmxnQkNXeStYdVlT?=
 =?utf-8?B?SHN1V2dwWkxvY1R3cVBBeWc4WnIxZU1wTUZQZFpFeUdFZVIyWXMreXoyMmNq?=
 =?utf-8?B?YTRhSlFUNmRDUTdUeGdneEpiakJZZ0hRZ1pNM3kxS2NXWkNJWEdXbGFBK05y?=
 =?utf-8?B?ZVBXZi8rbmVZVDNSQnFGUmNsdWpFa0R5VllnaWdNUVVzV1FNQU5MUTk4cE5E?=
 =?utf-8?B?MVl6MDhsMmJVbmdsMkZEeVFURS9DNUROMzNkTGpGdkQzQXFOTUtKd3Y4YXVD?=
 =?utf-8?B?RUFWUURjSE00UGlmMlZGcVNpcllPQ3hiVE5NOFZSYmc5cUwzMTFLNHF1L0tq?=
 =?utf-8?B?clJUTndoODhVQklhSzd6d3ZnN2JVZ0MyeGZDWTMyTkc4NldsLzd6cmRuQUxP?=
 =?utf-8?B?K2RqTjFSbmZzZ3l6N3hGbzJRRGx2UUxuQVhDRkIvdHpVTzhOY29VMmpZRVhq?=
 =?utf-8?B?VGhmY2RTRkJjd3BIb0RqMGIzMUk5SkpPdFErRWI4QWlKTXZxY3AzYTdqWFRP?=
 =?utf-8?B?ZDdKcU50UzNVaVl2VDJ1WXB5ejMyZFlKNUZLK1M2WUZrNk1UNDNsT0dqR1Rr?=
 =?utf-8?B?Z2QrS3FPRjhOSExUK2Rka3B5SSsvR0xaRnFwMXBWWkw0Wmd3N2FJSXNGSldU?=
 =?utf-8?B?RkJHcDNQNnFUeVREeVAzVjhNSXdROU8wbEdMVnNRTGlWRzZsZEdKdDZHRUYz?=
 =?utf-8?B?VGJFakUwZWUvdmRGZ3JnRjg3QXB3UDFXZmQzMFg4andsTm92QXFGdnBoNEQz?=
 =?utf-8?B?bVNCcng3cTlZbEtYenNvOHMwZGRGZnMzV1NhbzBPWXA0SjluUFowWm5MQjI4?=
 =?utf-8?B?ME84ZkV4VTNzQk03Nk81bWJJYWFFS3lsWjVuMDZDd1ZRdTNIMWdZczF2aWph?=
 =?utf-8?B?UlhTVUducXZZZkxtQ1I1YUZKSStNNHVhY1ZnMkdNbitPQUVVTTVDQkQvNzVC?=
 =?utf-8?B?dlZMZFkzRE8rUkZFTEszOVU3Ym9zeUVrUTM5RjRJQms2enJmOGRLUHVUTENK?=
 =?utf-8?Q?iqsKu6+eP40yK3oCN+jiWfWwZgMVVXjfQkT1Jb1z8YIOI?=
X-MS-Exchange-AntiSpam-MessageData-1: PvOl8QRjkpquPg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 694b6937-8edc-40ce-4016-08de8a57bfdc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:17:41.9942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 89hrzUr6kd6913lK6JO+toRBTXm363O3btMK63tZZQhILUwTy9XkK4uA34htARqv1YaA+Xki1QRoNUao0ZedxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8358-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nvidia.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 982F3322F06
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thierry Reding <treding@nvidia.com>

The PWM controller found on Tegra264 is largely compatible with the one
on prior generations, but it comes with some extra features, hence a new
compatible string is needed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
index 41cea4979132..15706d2a808d 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
@@ -16,6 +16,8 @@ properties:
       - enum:
           - nvidia,tegra20-pwm
           - nvidia,tegra186-pwm
+          - nvidia,tegra194-pwm
+          - nvidia,tegra264-pwm
 
       - items:
           - enum:

-- 
2.53.0


