Return-Path: <linux-pwm+bounces-8412-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBPkG+07ymmd6wUAu9opvQ
	(envelope-from <linux-pwm+bounces-8412-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:01:33 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36245357A9E
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87F5530457D9
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D641C3B19D7;
	Mon, 30 Mar 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Fph4WgwC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716AD3AF67E;
	Mon, 30 Mar 2026 08:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860845; cv=fail; b=ouB3g+hr3FHtiMYb06S82CMgkIPyqtTpcsegvjReBPWqxHAXNSWROODgciKtLRs1XSDYXpQPCwU2kIgNIexJIlkQ1sTWh1Zn8dx3byXeBP6QsszM7WKDoZUS2eIA1gHAowp/EbNG3U+P7SSOOGQ8qRjNaJw/qV8ProCAPcBuhZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860845; c=relaxed/simple;
	bh=iCvsuADXSAeyw0VO54tnhRa0/x2jgnJ2fA8IJ0TmwNw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SatHqh5r0cy1cwFCsoYwLFMW8gLuduLGihsjEDjUiqxJsqlPZpeYFlj0hu0WeZyCHJ5iNA9kR/lVVjh9Jn6/wE3/X0Frl0OSJLQrLUqpUgXDQVFbb1lzWakS0rISkBltz38uN3mvhXynH40Ko1WmIf7rQ18d9okKGEk5QzJG6Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Fph4WgwC; arc=fail smtp.client-ip=52.101.61.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFzv505btu2PbfOuiAXa1ij9Z2k3kJNtNzoHxDcs0wOj4bfEgGbauQMxPflv3JeZxBlcU0k/CxYWYRiDiKitKnsqhxuK1EOK2l0pW2zIT2gDAP6ywfgo796a0BIa/9qCffUaR7sa6dfY09eRYAST+hO0hQ0AfPIq4D4PdNF54ay5SMUfvEvH4NWIN4giG6CMMw9hrF6xpOUpMXKNfDnRN+tuwI8V8OfO9CqAsc/KPqGCFWxvs2hIiFJ9FJGJU9t2YdcAUh7mYF1tAQcrMApib6ZOHGiTLS1IJ79eFcyrUyzaU/C43RHAEjat49TOY7X4d6GZOMY94YVnxKiIo2VMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WzpC8XB3r9UwHrYFPsetBhLf+npXX5syYX0SBE7EY8=;
 b=e0U4oE3CFsoyuWKdd+Pq1n5faYrn9v8xsZNQWx0PcV2IShH6thVPciP4cPyIrppHfiQl8CJZow2VRYQcuTlpVFNsRXBhsfYV3u4Fs5gypj3djk5M8AMpH0ddqY3XrPWIHdY1Ia673aWxl9Uq9KbjZITZ6tucZP9yYRR56Ey081ng66wSenxwdRDb4yxrdgphI4q8tBYx21u69Zkbn1Nz001ivm61HFgv8CvmgZ8gGFc1nqJzyKFGAw/aTzVkHXf/wzJtVnh3ZBjgrXtS07AXufhsEjzYOAJd4KxY5beN1UznTC+bdygkB4ZsLOPXqKWf3gIRYbFhFztd6zjUT7df0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WzpC8XB3r9UwHrYFPsetBhLf+npXX5syYX0SBE7EY8=;
 b=Fph4WgwChgy89EKf7hKh/Cz3MkEMabZmIYWVIBgmJefLV3tkWMgIV3w0dNcwyHwGUthhzgLzFSsQWF1gVlUSkf5y9kczFVQfZcij8vUdph+IjhY2JGEnraAjd7L//ZFlpc2GQpqRa4Y2/VJ9IV5Z+7QQdpkjRM3UTgCr0sS0KQq3kVGFx3IadwRH6NSpl3tyXtE/VTiKoyJpVjFBk8Gb/jYHVeh8HI0Ndm5zWiWIml49SJACQW0cMk16aN50yRutaahee1tY3Pu1Kcy+mrsheKLqy+QKkIDK/TEihtyVdAJG6nDzXElGqUEaEEwaILjXghmYWlEvJDDbaeQrCD//WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Mon, 30 Mar
 2026 08:54:01 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.006; Mon, 30 Mar 2026
 08:54:01 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Mon, 30 Mar 2026 17:53:51 +0900
Subject: [PATCH v3 2/7] pwm: tegra: Avoid hard-coded max clock frequency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-t264-pwm-v3-2-5714427d5976@nvidia.com>
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
X-ClientProxiedBy: MW4PR04CA0271.namprd04.prod.outlook.com
 (2603:10b6:303:89::6) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: 14ee3e62-0e4c-459a-d033-08de8e39e3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	BVK25vb7zHwBkwidYkbJqk3dMCiyRLZZk8bsofxKGOcsOywoPyCXv1Zu4ucmqSwMPJ4zJeWqMKNkcgLrgxSdtZDq47XY6H0ncXyzRowvlJ4fHUy4xg5x/YhmW+p948MynUnrPzMXpU2zEf5NFHqk/yRRw2i5iCikATb+q5B5jlLLMZjYn7TwgA3FsnGmKG25GX9Q862SFVKP/VDV3gYbBNrsuA4GtkhCE3KSsKqyKzYRWCw1lmPqSL4+fRlWPv+XQjpACEEy3keMIAvUYc+4ETL2jfdKWOkxwSPGmT7Xf5GOW7oKZXb2/OYo+q4GVk+Yj2OI1/8s3DgLIBdrVNUdZEmvI24Z+bbntRieSkOpejgEToGYp6oD+AIB/Ezh8J416JIXdjvKddxH39GlmhJT3mCstcOWmBOh3lDHn+IY4uA2BEBpJptBs6TxhUi0y8DYVANIL7ZhiVKAj0h5kbIzLW5xSPxQ/biKrN6K/ZJmFoejjXLMYyr28ZMMNu+tK46xHRaxy88HBk2kiTjPoWmIwzyzVv2c2CIFykh0Zz5vtDh526QS8E6nLpc5bSz4UTnHDbuasi8bIbtOWozXmkzMs8ZWv3TVDOhLpqOPOL8BCQXJm41W4QebhSXcUlbQ4zGhu9aVXY+Tb5IJhuhrCykstQE5l0jzpu8KcccxGIaBst3VAhS11RrhUGjEQo38C9VCJyuBFoKnytvD2bMHM+kjYGrCMFdti0TkeUwW0EmSZmw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUlNenk2ejBsUkFiVWNvRWNjSTJQWkJOYlM0aUw4R0M5ZFVJdXZ4WnByeUtl?=
 =?utf-8?B?d2x1dm9WWDdEMXR3cFROS1ZBcmdHS3h4WG9NdkZ1TVp2Ly9HVDJEZ0Z4OEFQ?=
 =?utf-8?B?NDNjUXNNTmFnWVZoSTIyeElUbUppdWJzM01ZWTFnZ0RLWnhsSC83R0w5NkJC?=
 =?utf-8?B?TllxeEtwR0pFSFJDdUF1cjl0ZXVwc0ord2d6SHBrY2M0WDhZWFp1bm9aRmlX?=
 =?utf-8?B?Q1YxRHZyQlNNVVhlcnZid1B1ZXpoQnFvb25QUU1wOE5VcHhhU0crbDVNL3I4?=
 =?utf-8?B?MGZuTXAxZkgrdStOTmNDRWx0UWE3OTYrenBZcnhKRWRpZUtOQnkrN2k2K2dV?=
 =?utf-8?B?ZTUzM0JiYlVJc21GSk9QQUpjeXlnTW0xVDI4Rm4zUEoySGlqaE1IcVdlSTNy?=
 =?utf-8?B?R0lrZkdxSnJXK0tOck5lU1dxTFdYa2RMSEJpcnBhUUl2aG9jRDUzM1hkL1lo?=
 =?utf-8?B?STY1akFha2Yxclc3cVRzaGxBUlZRSFVGbkQrckpLZDN3RUhLZlVYaXplTzVz?=
 =?utf-8?B?SzY5T0pzQUc5eGVVTElBeXd5V0xIT3d4UGhyNTlIRERSZC9QcjJNMlRHRE1W?=
 =?utf-8?B?M0Q1alhkRldWK25DY0h3czV5dktTQ09KRW44ck00UndOc2ZzdWlhTmdOK0pP?=
 =?utf-8?B?VWlDbzh5a2NMb1hDNmhyWlBXTmRSN1pVeXVEWDBUZFRTZitacjdIbzQyYkM2?=
 =?utf-8?B?VE82UnVUR1RqZHBpVEZvdWJLSytuem5KcmUvckQ5c0w1QVlJWFhMbkVCTjIy?=
 =?utf-8?B?UmZBQlJqeDBWTmhEalRoNmlxNXI5L3ozbTBIZ1pUSXdvL09BOUU4ZUNlWmVm?=
 =?utf-8?B?RENwV0JaY0pRdkRVbW1BeGw3K2haaERwR0NiMFllaWdrVGZraXdLN2lGNjhw?=
 =?utf-8?B?RDFYWjdoamt2Z2t1VWpUWHNTUFJhT3RubFpwYVdNd2hleGR4RVFGMGg0aUJr?=
 =?utf-8?B?ZW1lRmZnTDFTeFRvMU5DZit5Y1pOOGJkODI0TENxRzEvZERZRkhtNEhOckZq?=
 =?utf-8?B?U3BHYTB1WkZBTkhzUERKNTBiT24wS2hPeHhqVHh4Vnd0SzlYRmNoencxNTJF?=
 =?utf-8?B?MkE3b1FMYVZGRUt4SjI0cURtdWxYTloxYW1STDl2TndrVlNMK1pyZFJLN2NK?=
 =?utf-8?B?LzEyTVZqSlQyemxYRFBpVVpoakJteHViVGdtcGhBazVudm14Wm8vQ0tFVjRh?=
 =?utf-8?B?WWt4bytucTYrOFNUQnljcUI2ZCtTK2xlWEVabE1ES3JRdzRlMS8xREx2U1I1?=
 =?utf-8?B?VVAySU9ZWWJBMzJvdkMyOTNURjI0VWYya3dlZTFxYXhZWkt6dC9iR2RSV3I1?=
 =?utf-8?B?T3FkT1NhTVduUEtRV1dKRFlQRjc1aE1NU1pjUDBzVFJ1OXFublpCNG9zQVox?=
 =?utf-8?B?Z2FHL2xNRjQ0cER5V0JSRVFqcnVIbnIyREFNcWNNWGhlbjJsM0c1T1F6K1Jz?=
 =?utf-8?B?N2dhbTM1WGl3SE02dVg1YXFPYmdCSXd6RGdqUW5PTUE2Z2xpNUhvNFJJR2Vl?=
 =?utf-8?B?czVzQkdyYWo0WlFsNGw1ckxGME9YaG1rSHZFbkM4TUkrdkVzcVZoU0Jpa2FG?=
 =?utf-8?B?eFdQNW91VnVRWUpwMkZZbHBHRTRaUnJ1UjFhdFdPTm91b2NBYU53bm9MZUxE?=
 =?utf-8?B?ai91MmNKbno5ZnhEMFgyQ1FtRHpGdE0vaW9DNGhFS3lRRGpyZkNzVHJIcTdj?=
 =?utf-8?B?TnozQU81Z0JUSVVadnlJNTBIRjFFVDJheW5MTFFMS1FYc1ArZC96K0ZDM0tT?=
 =?utf-8?B?TmJ2LzBnNVRBRDI3NnVDcmZ2dEY0bDVUSUw0dm5VRTBpSjdiak5zWE9lYXdh?=
 =?utf-8?B?a0kyblhWam4wVkladUQzQ0JDWTg5K01tYUFVVkcyd3R0c3IzY1BoelRXSGIr?=
 =?utf-8?B?L2YvcW1YY0lFRStuajJrTVh1bDVLYy9ENXo1eVdaYUpsQmhld0JtMllsL1pz?=
 =?utf-8?B?b042Sm9qR2NSVWw2YktTWWZZWVNuOHFPdnRUWGs2K051QnVxTG1vNU55WUF1?=
 =?utf-8?B?aFFCd2dXTjhoa2w2U3dSdjgwMnZRQXQ1Rzgxdk5aekFQMjEwZjh0L0QwbDhp?=
 =?utf-8?B?cWFsYzdSR3RLQjMvSFU5aVYyWHpZeWJRbGU4M2k2ejI3bkpWRHpUMjBGWnVq?=
 =?utf-8?B?NTRQMHR3VmpsU0pEU2IwVmhwUld2dE1Ea0dXQUZjRVZ2OHRRa1Fkei9kclVx?=
 =?utf-8?B?eWw1NUJKS3FhUUx1Q3gyZWE2RzF3SktGNW9lbWt5WkViUWdTWjgyNlRNYlFT?=
 =?utf-8?B?dFdaajhBdUxJd2s5VlNFa2dwekNCSkozeVd3MkZWMXNIWHp5U2NXVlRWNCs0?=
 =?utf-8?B?RVVuRzBlbUVEQnpiT3lxZGtqMTlGTzBaQTIvSjFNc3pucWNwSVhOUmxBdG5Q?=
 =?utf-8?Q?Yl5AksCssf2KdgzIUjw4wfmmDFhX3pQelyPFpWYITPv+I?=
X-MS-Exchange-AntiSpam-MessageData-1: SLyjzmae/9vj0A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14ee3e62-0e4c-459a-d033-08de8e39e3ad
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:54:01.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KyF89udqHufdHc4mE3XlagVxlULXmHgYsjhKZxH9k+GbKcPvB932n2yjQQJPVJaKWPQIJQnI2eX1RAaPu1ySUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-8412-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 36245357A9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Yi-Wei Wang <yiweiw@nvidia.com>

The clock driving the Tegra PWM IP can be sourced from different parent
clocks. Hence, let dev_pm_opp_set_rate() set the max clock rate based
upon the current parent clock that can be specified via device-tree.

After this, the Tegra194 SoC data becomes redundant, so get rid of it.

Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Co-developed-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 172063b51d44..759b98b97b6e 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -59,9 +59,6 @@
 
 struct tegra_pwm_soc {
 	unsigned int num_channels;
-
-	/* Maximum IP frequency for given SoCs */
-	unsigned long max_frequency;
 };
 
 struct tegra_pwm_chip {
@@ -303,7 +300,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Set maximum frequency of the IP */
-	ret = dev_pm_opp_set_rate(&pdev->dev, pc->soc->max_frequency);
+	ret = dev_pm_opp_set_rate(&pdev->dev, S64_MAX);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
 		goto put_pm;
@@ -318,7 +315,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	/* Set minimum limit of PWM period for the IP */
 	pc->min_period_ns =
-	    (NSEC_PER_SEC / (pc->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;
+	    (NSEC_PER_SEC / (pc->clk_rate >> PWM_DUTY_WIDTH)) + 1;
 
 	pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
 	if (IS_ERR(pc->rst)) {
@@ -397,23 +394,16 @@ static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
-	.max_frequency = 48000000UL,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
-	.max_frequency = 102000000UL,
-};
-
-static const struct tegra_pwm_soc tegra194_pwm_soc = {
-	.num_channels = 1,
-	.max_frequency = 408000000UL,
 };
 
 static const struct of_device_id tegra_pwm_of_match[] = {
 	{ .compatible = "nvidia,tegra20-pwm", .data = &tegra20_pwm_soc },
 	{ .compatible = "nvidia,tegra186-pwm", .data = &tegra186_pwm_soc },
-	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra194_pwm_soc },
+	{ .compatible = "nvidia,tegra194-pwm", .data = &tegra186_pwm_soc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_pwm_of_match);

-- 
2.53.0


