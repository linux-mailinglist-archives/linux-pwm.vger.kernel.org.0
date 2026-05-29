Return-Path: <linux-pwm+bounces-9197-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEkNFJf+GGoEpggAu9opvQ
	(envelope-from <linux-pwm+bounces-9197-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:48:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E52165FC7C8
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C14F5308A716
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 02:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E7A369D5B;
	Fri, 29 May 2026 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KgNqHDHC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010027.outbound.protection.outlook.com [52.101.46.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00938369992;
	Fri, 29 May 2026 02:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022896; cv=fail; b=ULxT7d802ipf+QY8bD7rAl3rd719ov8AE3ur7+UvyM0KfcY8URNSJD+aI2H3f0TkMfDLKtDcGMyTF+ZGXN3IZQcSM1G7AkT4lPmmbhF7xIKR3MdiAR4I3iK9JXsLJ68cxgBo7Dxclru2JbAsyGwOb9XO+RN/nIxafOHLCAahRv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022896; c=relaxed/simple;
	bh=wy2SClBcVqxgtnVRZaDk00AE7EjTTlz6ZXu9pAh8n6o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Q7xZk+ttp4QgfS95iRC47MyUVsEmDiMa8OsDgY3hRK8wS7516P2L1+vLAwVqxiCgvTbD7qtYju7p/BiKfcy4EwIUjJ+2DiNAm+ZzOR2RIVkiJBd0NdIF3HUShu2uY0neEZmv7bJZPDnay4Ci/lmfnbt9Epus1p02P/Eirx7vPEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KgNqHDHC; arc=fail smtp.client-ip=52.101.46.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wa/V5ZR7xKaXOJ0npN72kPVG1RJUFTZgfksBi+Ud6tDrcFuYex5teeP9W/Rai7uM74vr3Lh+JQQLzYsJho574P6SUOn7z6BLtXvhxkO7uf00RX6bJYKT39DLjmVBiB0LR5GS6Q0Ff+P7dirwiAnGcxUaW05lRk5IB9DvrUkxkTU/HLSqwA5fwGsdQDZ6Mds7nnpnmHT1HPaL7HDU1yL/X2cwsVx59Tp8Sq4rEf2XDuhcfNcgTynHFLmN47s2P9Ecf3ffcP76zmjmdDMcsanOD8x7lJnvWxoRwYPOf+iIbNynRSlpED+D5E2CKPFdJgYUJ4YLqax/CjT381MvlIIwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+tmA3JjSgTheVik71OOy+vakrJSi7GPRu31bKuoctI=;
 b=V+mZuCCJzJ7yVhLYKPogOjTTuFKDPZffQWKlw0FXfPu9o/9foXGs5dR48eYuuBrp74vF7TQoig+A2YgCXznhlzQvBqjzeO7wTGIbJvJuwTWRzEzPS+YgTM5egNyn72HdDpKWDvlfACHtahaMVz4PKuzp5wmTMGNG8rIyqP187Ye20kXVzHmpNFOF7qDw9uoK3OX7i4ikEXgIsYpJSveb0XmNAxut8vS6veVpl6Dy19iDgi7uTBlJ2gpLvVhbBUO8u6BDEJPS8MDGzRYxDUqefyEr0fAeG8ry53fkc3hf7A6R52mq+o7qlcsuLzFd3w/5WMxdYNkV8p2vMy6yXJHPrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+tmA3JjSgTheVik71OOy+vakrJSi7GPRu31bKuoctI=;
 b=KgNqHDHCvWKPNtW18FV0/q8xfibj76BHz2SNL7IFRHga2IcF11hBBicDdL9Q/jqcVqKPRefqrjek4JTxoJ7t6B3+57ZOPWGVmXvJGQNR8yKF5An5yOp5JlYFq2WAPpx7kGEjOuxS8/UIw//VqgMTw2jWQhzP5MnR83Q6S9WGnHQS5diPgjr08oSBWtGXbgA0c1uIqDFggV74pvDca7VskB9z25pZ881Rc/Nk1mQjwwTskSTgCjBtQ0gRKOTnT0CAjCtCb36LZNLHxePiF9RdRs4nw+fYKbIo5vhRj1WlDS5nHOoyxXEVzcTIRuw/qtNGFeZimWm5EXY53A75aHDjJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 02:48:05 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 02:48:05 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 29 May 2026 11:47:27 +0900
Subject: [PATCH v5 6/7] pwm: tegra: Add support for Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-t264-pwm-v5-6-7bf9e405a96a@nvidia.com>
References: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
In-Reply-To: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4P286CA0088.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::19) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: cdcfa5de-d490-4a41-5d85-08debd2cb573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	xk3NJVhFDlSDYG6Q3wcN3gKJvGNFp5SDDCCxAWMIEpwdVPdhqYdfDga42pG3QTOmXFRxgD2J3bc/hGL+yPo+S9dQOX+Nae64TjeVS7lBMByDiWfnIWK9upAtjP5bNWqm8yRF/Vr+96NREcq48f/j4+95WcunuPxsMl+yZ8i8QDHjI9dYOYrlXShJEdRBanpVk1FXqAug7owtfbpZXePC9UJcoAwcS6Pk16Wqo2zP/FWeOxPLLUZdVDr/8uMRiX00mucerBGz7q1RvrKA9MLYlFbsLn0zM6JO8QiHLhJTJuTXS4+gmh5Hm+ZX80w9zLNhLy7NUD+XJsrFkJjWPgVucJV4wMYJLMHsuoabRM9K05twlDilygvzkrJe51Q+qzDeEvLFr/w7RBNl54d3F4totd0FVT9JbZ+zq5SZu7g7Snqj7q6so+woFJKzBX7OuPM1dXgT8D4y2p8hQAX8yMXs/9LhVYgDr+aZ0RCtWrZ/FR9H0N8f22M2hxXVnRcVwYOvSfYhIREW2l3uXlAVzAw1KI2GKqkach2crpgTXlVK3awoehwStjOM0SvIHeWGX/3bXNvneCYu2WaYEhZL/OOG7T5Oqv+jAQ23EScSSWozfK5t4G07f3uEK9L504aShTTP6K8pcHn2n/zc4KIRSbfkD3ej+DUUpRKym0tmQjQdcmcNv7fft3Uo+vw/h3XCLUQZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aTZnaXNmbG9FZ2h5U3NVSG9yaC9SQmtMYnBjV1RaUElDNnBTamJIeEJyeGdE?=
 =?utf-8?B?SzBlV3c0dUJVTDBRYTYzazcwMk1rV2JtYVFtT2dVaFBRcUl1RU92ZytyZVli?=
 =?utf-8?B?dno4Mm02Y3B5SzJEMDU2L3drOGNYcmJyY2twZ3dySXl3cEQwL2ZtWlFpcmJN?=
 =?utf-8?B?T1c2SSsrRlV0VUNFSi84SzNkTkR3dG5idnM0ejhsVTk2a050ZytCUkVqeUVO?=
 =?utf-8?B?TDZEOU1qZUllRjA1L3RJUWpBTXZJa1U1RnZFSUl0N3dQWGd2THdZTlRoZjM3?=
 =?utf-8?B?dlBHZnphNnZ5U3ZSMW5Ga2Y2MHp2WC84L1kzd3BlM0c1Wm9JM2RocDlXck1p?=
 =?utf-8?B?Ung1Q2xJSWRJM0FoUXYrckl1RG1EdG12MU9ERGtOQXJSbG1FZUlUS25pdkhC?=
 =?utf-8?B?SWJ1VVg2Z0NsdU1yWHNhVEhacEdvRmM5RWIxUjloTy80dFFXN0llV0ltTXVY?=
 =?utf-8?B?V043eEl2dURicHZRYWgvV2hOTGlwUGhEWEJIa1lZWk5tWDlUVmxzQjFSOUdL?=
 =?utf-8?B?WkFiaXlrOTE4ak9vT0NmdFBWOFBrRkZYbUR5NTdQeisyUW51SWtWMzl3VDdq?=
 =?utf-8?B?cC9Jd29vQkNWd0wwVjlIUllqbnhvVHVzN2JMejA3UnBLSklwaDgvemYrSjBp?=
 =?utf-8?B?YVlrUk9wTVljTURKckNvVmJneVVxK3FMaEFHZ3ZXVU1tb0RvVU12dWhiOWh6?=
 =?utf-8?B?ODY3aUF0R3BpcHd6cm5xcm92MTc0TDdmVnM5Z2l5bU1CaDZQUGlVNitHNExB?=
 =?utf-8?B?OCthUkJCTzZ0Y2thalRRTW5md2plak1wSzlDRWoxR29aMHNXSSt0VVVKcnN3?=
 =?utf-8?B?QTFrdUxvVkpwWmlwN2dncE52UWdJOGV2N2I5YzFEcXdIZTFJbGNiS2Vqd3p5?=
 =?utf-8?B?RG9DRE9VYTk2d2NGMlhNVHp6d21lL21VOFVyNXBiOUwvT3YrNkFKZjZUN2hp?=
 =?utf-8?B?bW9VWmNLaFUrSVptK1B0dUpkV25DN28xR0JRQjVCcG1GWkgxQXVWa29PRld6?=
 =?utf-8?B?NG0wTVEvTXNDbWRsYTVseUV0QXdoUjZGTjI2Vk93am1qUlY3UlR6NFdZVGNk?=
 =?utf-8?B?VWtTb3I2ekZyUHJnRGpuamcwdm1mbUUydGxUL3ZVMWZZRFdTNUJqUVhpTGNv?=
 =?utf-8?B?T0Z5Y1pMbUYvNUhjV2lNOHJSbm96OUpxK3l5MUJvQ1haVmxPd1RLbkFlNmlZ?=
 =?utf-8?B?Z2t4SEhOODB5WC9ZMlBvcDFmSFdyYzZUaFY5Q0M4TTUycWkybTBDOXFyR05Z?=
 =?utf-8?B?L0lySy9zVzJIT0ljZ2hmVUc3NHJNMERUVmFlQkJ2QjVaYzNvTXJjNVFCaEJa?=
 =?utf-8?B?c3h2Wm5oeFBYWnd2S0VyYnNqY2p1cWh2U2tFVk0vRHdKRERjbWhoZitMNVhP?=
 =?utf-8?B?NWx3bXRhSzAxVUs5NVJOK0ZOaVdpV3JXQzQzQzQwT3NlNHNuQi9PSWZGYitM?=
 =?utf-8?B?eU41b2dIZmZZWnZHUXQ1NDEwZ0VabldCVm0xTCtaT3RNUlM1cmt2SVVEOWp5?=
 =?utf-8?B?UWZEdEY0TkNMQWpGYkhGeW51eThqeit5dlhNQ09WWStGMUF2Wk9VSXBaWGR4?=
 =?utf-8?B?NEhKZExDdi9hZThmRVR3Z1ZvR0JzYlZiMXNzSm8yY1g3WEZmNlpoWm05S2Zw?=
 =?utf-8?B?RVdBOUdyc0RoYmhydkZQK3JVMml4MHFJOEh1RlJsVFdkMms3NjFWdDhGODZX?=
 =?utf-8?B?c0FkNkozTS93blE3bXQrNjlSbEJjTXNDVEQ1VFhYNHo2Vzl5Sk9Ud2h3U2xV?=
 =?utf-8?B?emJEaTF5Wk94NmFVUjV3cGJDNVNwTmVPWjh1KzdaNW1wYURHQ2NxbUs0cllB?=
 =?utf-8?B?OTFNVm9FY0tWN3RtWjN3TThBUFArSENSQXdRb2tiTGExTXRJck1VbVJESUg1?=
 =?utf-8?B?N3hwQU1mc3JCbnZRUjlXYVh3NkhSaEhHdjg1aVpCcnkxaitzR2J2VUNrbE85?=
 =?utf-8?B?R0NPR0krNWlYaSs3eGJ5R29CWjRKdnF4dkRlaVllcUh0VEdCNys3elBCSmNk?=
 =?utf-8?B?QUFkbHQvZjNMSGdwRkRQOGwwNlFmTm1hK3NqNW12WG9xYVFWTWlZRHJFTWFp?=
 =?utf-8?B?RW5uOFkwdnBwc1hGNjkyV3RDWTNHN2p3RXNMOFdRSkxLS205clJJMHg0Vkh0?=
 =?utf-8?B?em1IWG5nN3ZXaXd2Qmk0YXFVaEtMNUNXdEdEaEtLWjhCcHNnMHBFMWE5ZFNF?=
 =?utf-8?B?eDNpOVc5eWVoTFN5N2l5aGVyYkkvTU8yOHIrODlGOW5CbUZWTmJ3REw4eUpi?=
 =?utf-8?B?K09LVFEwV1BNOElHQlNFRUEvV2ZNM1IvL0RlNmcyelF1a2Jjd1htL1JCUnND?=
 =?utf-8?B?Z0lWWk13L25iYXVqdTRBWXdPeEwwWmlOcmx1UFlaVHY3WHFZQWNubEx5c1dZ?=
 =?utf-8?Q?8Z+WCpwkcdk2CTdVKYAZWwGiucJIUFePazv4IVwK111ER?=
X-MS-Exchange-AntiSpam-MessageData-1: HXVtDtIGNNw7wQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcfa5de-d490-4a41-5d85-08debd2cb573
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 02:48:05.5413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsfV/ThuqfrnuxlfKQXyh14uL/YbdqpE6iHPASWRkWnyLMPHK/1o21LrIRHTZfIN2zkhNABbFW3OxOJOix2wpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-9197-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: E52165FC7C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tegra264 changes the register layout to accommodate wider fields
for duty and scale, and adds configurable depth which will be
supported in a later patch. The enable bit also moves from CSR_0
to a separate CSR_1 register.

To support the new enable register location, introduce an
enable_reg field in struct tegra_pwm_soc that identifies which
register contains the PWM_ENABLE bit. tegra_pwm_enable() and
tegra_pwm_disable() read/write this field accordingly, and
tegra_pwm_config() skips OR-ing PWM_ENABLE into its CSR_0 write
on SoCs where the enable bit is not in CSR_0.

Update the top comment to describe the register layout in more
detail.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 91 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 72 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 7c7b884d4436..50e72139cbc3 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -7,22 +7,61 @@
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
+ * The PWM clock frequency is divided by DEPTH = (1 + CSR_1.DEPTH) before
+ * subdividing it based on the programmable frequency division value to
+ * generate the required frequency for PWM output. DEPTH is fixed to 256
+ * before Tegra264. The maximum output frequency that can be achieved is
+ * (max rate of source clock) / DEPTH.
+ * e.g. if source clock rate is 408 MHz, and DEPTH = 256, maximum output
+ * frequency can be: 408 MHz / 256 ~= 1.6 MHz.
+ * This 1.6 MHz frequency can further be divided using SCALE value in PWM.
  *
  * Limitations:
  * -	When PWM is disabled, the output is driven to inactive.
@@ -56,11 +95,13 @@
 #define TEGRA_PWM_SCALE_SHIFT	0
 
 #define TEGRA_PWM_CSR_0	0
+#define TEGRA_PWM_CSR_1	4
 
 #define TEGRA_PWM_DEPTH	256
 
 struct tegra_pwm_soc {
 	unsigned int num_channels;
+	unsigned int enable_reg;
 
 	unsigned int scale_width;
 };
@@ -199,8 +240,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		err = pm_runtime_resume_and_get(pwmchip_parent(chip));
 		if (err)
 			return err;
-	} else
+	} else if (pc->soc->enable_reg == TEGRA_PWM_CSR_0) {
 		val |= TEGRA_PWM_ENABLE;
+	}
 
 	tegra_pwm_writel(pwm, TEGRA_PWM_CSR_0, val);
 
@@ -215,6 +257,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	int rc = 0;
 	u32 val;
 
@@ -222,20 +265,21 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (rc)
 		return rc;
 
-	val = tegra_pwm_readl(pwm, TEGRA_PWM_CSR_0);
+	val = tegra_pwm_readl(pwm, pc->soc->enable_reg);
 	val |= TEGRA_PWM_ENABLE;
-	tegra_pwm_writel(pwm, TEGRA_PWM_CSR_0, val);
+	tegra_pwm_writel(pwm, pc->soc->enable_reg, val);
 
 	return 0;
 }
 
 static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	u32 val;
 
-	val = tegra_pwm_readl(pwm, TEGRA_PWM_CSR_0);
+	val = tegra_pwm_readl(pwm, pc->soc->enable_reg);
 	val &= ~TEGRA_PWM_ENABLE;
-	tegra_pwm_writel(pwm, TEGRA_PWM_CSR_0, val);
+	tegra_pwm_writel(pwm, pc->soc->enable_reg, val);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }
@@ -400,18 +444,27 @@ static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
+	.enable_reg = TEGRA_PWM_CSR_0,
 	.scale_width = 13,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
+	.enable_reg = TEGRA_PWM_CSR_0,
 	.scale_width = 13,
 };
 
+static const struct tegra_pwm_soc tegra264_pwm_soc = {
+	.num_channels = 1,
+	.enable_reg = TEGRA_PWM_CSR_1,
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


