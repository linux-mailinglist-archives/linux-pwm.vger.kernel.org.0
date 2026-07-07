Return-Path: <linux-pwm+bounces-9616-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f5FZGurcTGpsrAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9616-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 13:03:06 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EC271ABAB
	for <lists+linux-pwm@lfdr.de>; Tue, 07 Jul 2026 13:03:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=EXxHVcmF;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9616-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9616-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B436C3006958
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jul 2026 10:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676F03F1AD7;
	Tue,  7 Jul 2026 10:58:10 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBC33B6C0A;
	Tue,  7 Jul 2026 10:58:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421890; cv=fail; b=JpaqXtsDiMIm/g6uff0j7K6G5u0i6p+cv05RDbQ3yCAa7g5dmEzu9n8KY84tI1P1nwFRkObNjrvKwOIm0D78N705Ymjui2WHX8KoCJcDDNxId6JS4zimeX80F+4ZuMFK6XESIo2aJrbpLqDR0XYpmY9bRWU8ueyYNZ2sjuIWxlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421890; c=relaxed/simple;
	bh=U7knnHOmM1VuD5DBr0rHi9UOrdfvwTJ3Mq3+flcWWgs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q8P7mN1m9Jz2VGm8aun62SJ1mRxq4ohYkC42CN60Vi+J3Uq+Cmo48b8JzmG5Fxni2BT+gA4TbD5XfwCvGkq/jg+r/+Ndyk1RmLVCnsoQGiWiWhlUfHkAYx3H2clZU6lBFl7XPIv1bpQSRuGJCGgbpY9mOnG09xEs193LcEW2QdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EXxHVcmF; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYhVVxSCFJrWGQXa+xnVr3RdZLKyAzPVY0pMo0OJvWGOLMRjvAyP56zaMNgFLWpgTb1fkgJ6tYJ9sesQcDDgg/vAEQE+9Ngf41fV1XUFZgBbrUOkAfSAXPG1LGyTuMCTQMbAQtIYlRhEsSkUaW4gSiVR2cWLpyOwX/9pXVeGmaJ7lyXnDHv0wYxoNnQtxBB3N2RH+N8YNcpVhblnFhLOFtRYE25z3O7IbO8iJ/OmR45KIt/LdmR1FSmWYLJHxmD7VWBfVwMfDqUqQV7xq1WvZCGvwqrOQRbtKmOZyAccN36i9sXaU2HFZ45GtDwQki2l7vF6AsiOS+U/B9QdwHloMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCpN0SQNvky23W+ROyRTU+sJSK10gP2aBx4O3YUDR0s=;
 b=Ojly7F5uH8Vbl8zANwi4EDw7CFDXl+P17O+fdLmQbftJl1BrpwsQWm+p5Ly6ayYB1C/gsjd4MxtuGnBU42NJjovoDPlMxdAulsR9hV0UPG/e2DKN78Qz0RgIBv/gWOw+Szo0E4DGe/JHuY9Y11DVrQ/xcJgUIzr1UhiR9Or877LaVgLv9JWjKxSmTnTsn6VeXbZbi/Ax3jDOKMntF/zZo0K2pWiWNMBWPZsqUxQAGMl7z4qSpDigNmVOJlAvXZDpua2v1oHBwtISi4Q8eb14VxbRuZ8RNGRYQhY7vZvimdwpgkeUxyIRZHcopruuixudJORy/Tr3Zl2a6DSz3kOuVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCpN0SQNvky23W+ROyRTU+sJSK10gP2aBx4O3YUDR0s=;
 b=EXxHVcmFmrEEpSx++Lr/swB6l7gTvlhgMZnGDAN2sH2XgKMtXOMf3/YgzifZyGpsUJW2rAsoVQ4DYlG7ma/QWerMaa9t7RWglkAIiwaEqEvkmjG8mz7r/uvmjD7uf6Ty6B8NBmu1uRqhVGqU8m9IRurjlABUlGbSRo9/zHEsr3FLgthX/X+jVRFxVRQ3DSPdGf7Ug7v+5TmCMRidUf3HTCG2XaI11TaXnbZPWTzgh19FPdy0GVtEijGg3iCC9r4/J3fkyTSYM8sWpbeWzP/OOq4qE5SEmlCSPPHtNW8wEt19TzVrOaQHipaWSRVGLvYgMCLrfIOvYA7qk3bBC0U3hA==
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com (2603:10b6:a03:48a::18)
 by PH7PR12MB5877.namprd12.prod.outlook.com (2603:10b6:510:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 10:58:05 +0000
Received: from SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9]) by SJ1PR12MB6051.namprd12.prod.outlook.com
 ([fe80::96e1:b300:7b78:d3a9%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 10:58:04 +0000
Message-ID: <26617490-72a0-4471-9854-3e71014af71f@nvidia.com>
Date: Tue, 7 Jul 2026 11:57:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Tegra264 PWM support
To: Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, Yi-Wei Wang <yiweiw@nvidia.com>
References: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20260701-t264-pwm-v6-0-2718f61f411f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0219.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::8) To SJ1PR12MB6051.namprd12.prod.outlook.com
 (2603:10b6:a03:48a::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6051:EE_|PH7PR12MB5877:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d0a393-d083-4b31-7a55-08dedc169ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|11063799006|3023799007|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	QQeDfIJJL9vHyRpSdzw8bDdprORkyCih8YgwE5vnv47dm9l3JHrJVHQ2Y01P6EUIYSl7p3oV9E+GdegU7cGFfHRXpCoSIbhuXeUhFEI5S8yIviUCw+xsDv9aPFDZWJan1QCDH9m+atpYoVeA8nonDNp0mLqJZWWIML1TJXtJHJsjewo1ssgdXEdiBIx0HumENox+J/Xx4fzJY1mn74VhmZ0d3yh8n8GbkEsLu//OJJdZ/fWq0Eno99bP+13lkk6Rf3UBLhlSF6apWUMcXbDkrAwjZN+1pGzTKIV1hkALl+xAKmJAxjP1g0R3S6Ricy8VwMMjYe5hKsUkOCZrnq7yXo5iJYNm/wpXEQM48DL4d5XVMPN6UEutwMwsTCd/N1KmjWPYbrR3zvq/YqzooeHqe1iTjUjjUjfEFPC9DWB9nki6TJ9O4PI2g+8ZWuIuNqIRK/jwUE/xiL01DsIHCeYUCi6lMi2fMogD7pejrOzTHEDWo2cO3tjGeXJrtnosLeEw7JmlHNDyz/s+7PVznNAD54iFHnEUiaQONqgpDdv0p3j3igdhuPFI6erJDORPmFCXa0FkamJHkaZXBsI4MCzOq0kzMWTYNnE2+bnxMDqF6jhEgL2mmlG7ABOw1Qvb7FSXR2YsHCzYktQtXSRGEIQqD9ovLSD89iX+Nqvsvg5qjDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6051.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(3023799007)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N1BBNWN3RnBOcTE4VWNYTXhVZjIzS0FjbXhLdU5aZ2RKTVk2ZXh6d05URzlW?=
 =?utf-8?B?dnhLUHlPSzJ2SEdMYzg3ZFB1M2dGcEJQSWJCbThWRmRzdGgwWEo4dnF1VTl0?=
 =?utf-8?B?eWUxYTZNVHdvb0tPWE5VZU5WS0dheVQ0M1BXUk9aK25Pc2YvT3l2am5FZW5S?=
 =?utf-8?B?NWQxNWhPSWUvY2xOUGFJWjM5QWJmbnJOTnhENkxJbHprVFltem9XUjlqdkdn?=
 =?utf-8?B?aDZrcU1CZFpBTDVFazdzWGtVdGdHK1lqcUFabWZVQTRPRUh1RnZKZXUyd01F?=
 =?utf-8?B?dnN5eGlMRkpxYTlBUEpqSmJIdThOVURMaE1UemU3RGpBaS9WcTRqWHk1WHN0?=
 =?utf-8?B?bTEydjlBelpraitFSEpvOElNbmtpeVpQOUtOejFuZTU0QmthY2piNWVCcm5w?=
 =?utf-8?B?UnFwcWZCRjBURzRIdlU1N2xabjNlRTlWZWg3dStLMmNwVVcwNUZlNGJRV3FT?=
 =?utf-8?B?NjF0SnZYeGp2bG50QnNIdFhYZm9GU1EwbzE3dndWUzJ6R2ZBY3psd0d6OEk1?=
 =?utf-8?B?Tlc5ZnlxQzcvRW9sQXVlRzlMTlZzcEVlbkVIOEw5eEhPNExKWFZ2bXI1aEZr?=
 =?utf-8?B?aEQ4T0d3UDdnanpHdUVXUXhKV2hGL2RyOEtORzFTOGJsTllJV3duYUxRaTJa?=
 =?utf-8?B?b0RBMFgxbFlJVGp2ZnRaQytnOGs3Q1pMNCtOVjMwdzdNQkx3bUp6LzV2SWN5?=
 =?utf-8?B?Q0UvKzJ5OGpCc0lPNndmVlo0Zit1aUFYRHNUelFnRmM4L05UV05jYmMyZlU2?=
 =?utf-8?B?RHRzanZ1WE9YdzN0QUVGWjkyeFVWb2tVbWM0R3VnRm93TDNmZ0pXWUczWkli?=
 =?utf-8?B?MVYveDMrQ2MwNi9YNm4xczQ0QnF2T2hrbnBIcUJKTDZselU0aGg5MjVWdjZW?=
 =?utf-8?B?Rzk3N1docDZCblFyUm5lNmNNZ2dDVDlTYkJ0c0JzdzVneENrelJ6Q1lzamIz?=
 =?utf-8?B?UStpdjBpSmRwMnh1a0grd0hHdDROYUFRVG9uTDlKNnlwSzRYQ25wMXBQSHVE?=
 =?utf-8?B?QXFiaGYyd2JtcnpIRzNpOHJiUGljM0ttSWtkb0NKenhEemRYWGlHWkp1eElL?=
 =?utf-8?B?UUZ3UXY3VHN0WFVuWVJnQVYxeHlYVTBSSTA0RGtBVk5tZEhQMXNjVitHcFZI?=
 =?utf-8?B?TzhBcVp0NTVGanZaZWZMekVPamZ3UzNGTmVNQUwzTnU3cWVLK2tVM0k3WFJv?=
 =?utf-8?B?ZFlhREFyWVh2NlN3KzZUUTZqWmE4YTdXb0s0cFRCeDBBbHQrOE9GUURRejdq?=
 =?utf-8?B?V3AwL3M4ekFpREtVaHZ3MUJxT3o5Q2ExOFBLOG91ZGdJTjhaQnBtSW5laGVE?=
 =?utf-8?B?eWJMb3FYeFF5Z1BxT1pHMEpXMUVkOXpJNXVGcGF1amtOMmducXdaeFRKbFA2?=
 =?utf-8?B?bHFnUEpBWDF2UlcrWU54dFBjbGtYd2hFUGMwbkx0TkpORzd2VGhkeWFXTUlG?=
 =?utf-8?B?UFZiQ1pEVU42V0dUbnJGY3hJaGNuREhydUhud0Ezb0hhbEhockl1aEhZbjl6?=
 =?utf-8?B?ZmlpdXo0azhHWm9ZU25JL2pRZ3FPV09SRk91bDl1aE0zaFRGNVBMSTZnamZK?=
 =?utf-8?B?Qkk2Wkl4SXVSLzM1RmVQZ3o5QmY2NytZVU4xVWQyQ0hNU1BKcXBvS1dPNDR2?=
 =?utf-8?B?NE9xcXIzVTZWRmNSck1GcmdVN0FveTFuQjJoL1NiejRkSHhKeWVPYnpKYnkv?=
 =?utf-8?B?Q3ZCcnNJb1prNSs3STkrSERrajc1MklBbUJ0clhaajRNbUxDRmpVV2NkNDJm?=
 =?utf-8?B?RVlleElxaFJNSmZJRk13eW9mczh1QTZDSzV3TTFsRjFwblI0ZE9IUUMxVWJJ?=
 =?utf-8?B?MzhNQUIxT29jbEFFV1Y5OHl6ellYaUlWd3lFRkZoUFUxdXdvRVFZZXNzWjdz?=
 =?utf-8?B?RzhuQS90RjJ5NGQ2cGZTeDdsbHprQUtxVlFnRSsxSjUzSnFHSWhnUyt5aE42?=
 =?utf-8?B?cXYxQXUzRFM4ZnlTQzQ3cWU5OTQxWm52c2M5dzV5WTR6clpXYmsweExvajVG?=
 =?utf-8?B?Q0NjWnRFMmlDV3I0UStzcFZRK3pROHZNcjVzZ2luSU1zZEwrLzJUQVVCMmFQ?=
 =?utf-8?B?cms0d1lxaGRpUHZEbWhSelRIUHRnUTBHTWRnYlFHdW5XMzV2YnVzTHhBdzhW?=
 =?utf-8?B?bXR3ZUNjY0Z4SklTYlFSYnZEN2hDb0Uwc3JPWXplOE5wT05CT3hCMFF3bDg1?=
 =?utf-8?B?Y2FuTHlKeGEySUZKVk96RUN4YjFaMXhjbGNNVkdKbXJTOTBHVHhLUVNRc3Qw?=
 =?utf-8?B?VTh6dVA0Q0htc1V6QTI3aGU2amRuOW9hdnJpWjRXd2RyM29kTTZDa1lBbEtS?=
 =?utf-8?B?M2k4a1JGQUE5TFdSSlFzczhwZ05CdlFZdlhacHJZbzlBcHRhd09rdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d0a393-d083-4b31-7a55-08dedc169ee3
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6051.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 10:58:04.7882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52PHE/s0nNoX2m8cXJdrurL8tRrCscKpu8wfbELamBwV8GYKoxfJxm8ZHzu7efPK4lrZExoldhjAuZI6Fsmu3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5877
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9616-lists,linux-pwm=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[nvidia.com,gmail.com,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:mperttunen@nvidia.com,m:thierry.reding@gmail.com,m:ukleinek@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-pwm@vger.kernel.org,m:linux-tegra@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:devicetree@vger.kernel.org,m:treding@nvidia.com,m:yiweiw@nvidia.com,m:thierryreding@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jonathanh@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jonathanh@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7EC271ABAB


On 01/07/2026 04:20, Mikko Perttunen wrote:
> Hello,
> 
> this adds support for the PWM controller on Tegra264. The controller
> is similar to previous generations, but the register fields are
> widened, the depth is made configurable, and the enable bit moves
> to a different spot.
> 
> This series adds only basic support with fixed depth -- configurable
> depth will come later.
> 
> Patch 1 adds device tree bindings for Tegra264 PWM (compatible
>    string).
> 
> Patch 2 prefixes driver-local macros and static helpers with
>    tegra_/TEGRA_ to make their scoping clear.
> 
> Patches 3 to 6 contain the PWM driver changes for Tegra264.
> 
> Patch 7 adds device tree nodes for the PWM controllers on Tegra264.
> 
> Thanks,
> Mikko

...

> Mikko Perttunen (4):
>        pwm: tegra: Prefix driver-local macros and functions
>        pwm: tegra: Modify read/write accessors for multi-register channel
>        pwm: tegra: Parametrize duty and scale field widths
>        pwm: tegra: Add support for Tegra264
> 
> Thierry Reding (2):
>        dt-bindings: pwm: Document Tegra264 controller
>        arm64: tegra: Add PWM controllers on Tegra264
> 
> Yi-Wei Wang (1):
>        pwm: tegra: Avoid hard-coded max clock frequency
> 
>   .../bindings/pwm/nvidia,tegra20-pwm.yaml           |   1 +
>   arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  72 ++++++++++
>   drivers/pwm/pwm-tegra.c                            | 160 ++++++++++++++-------
>   3 files changed, 181 insertions(+), 52 deletions(-)
> ---
> base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
> change-id: 20260303-t264-pwm-57e10d039df1
> 

For the series ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic


