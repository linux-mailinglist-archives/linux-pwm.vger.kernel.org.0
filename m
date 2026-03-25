Return-Path: <linux-pwm+bounces-8357-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAd0LsW3w2litgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8357-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:24:05 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 549B2322DB5
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EBF9030B2A42
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 10:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84E63B47EF;
	Wed, 25 Mar 2026 10:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kbXHBaTe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010030.outbound.protection.outlook.com [52.101.56.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC703B47C7;
	Wed, 25 Mar 2026 10:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433859; cv=fail; b=PaHGptiHOA+WjRAbyZMvqMduBxJS3W6FldxBSKTc+phr+oLASW+b8KcaRim0uSezLzC86uvNfAernIaHrFuQ7iAj0feqLRa0QKZVHVKhFK0vR1AIMSRHQ6sWiM7i05/tgErSJcP7aTQ4LDzP5xApn7/ZqAmowpiuESTkVseJ9RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433859; c=relaxed/simple;
	bh=JafSc7EnLsev2EoxlBH6tUQvexYJ9rEV54gDcF1AAgM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=lkAPGmbY/T1Mpx7uIvryGIBXj2EJXEu0O3J/AsAwpk9SMMmBkNMfN+oNLyi2ZuEA/wTj/wQau+wbwxqCz3eyS/RQ4VQf8FCcbfppFGBbq/Nc1ay1cWM+lhNfJaappor4dHisM9aEKpJ84hUNGoAF4Dst3B2eCXc9jfcLKhpkyRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kbXHBaTe; arc=fail smtp.client-ip=52.101.56.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iE3JLxwRGGmBv9qLiKIhLbESdKa80an+bfbuy2ub5vYKpN56AK3ZrdLDChw57T63plAhYSaBFmNHAWf1cc9Lc/y0heEYRjrvS6jmppY4Lm9rs/WkxUu977PAujR/Fgv/V2h0zY5nim57kTUg6hQ+tZRZ7GTRFRQX7+Bf/JfNz0+ScS+1cX7CWWoB9JegX3qfVoXv3X1T2ET+K8MudbrQR9DEXKnl9bUQKJ4KUwJrSbWvqGqQgxbF+csTV0Rb0aS+SWwLmdqVQyFwx7f5+r6kU83a/x85lzAI3BsIw95gia3Ti8EaVPgnIrS33FVM8PKzEcolMl+1LrWmAulkhlinyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYx6BcI5f/wraCUYhJFxHx31QYEkcLZCOZ2VSLWdCko=;
 b=dV3U3Xiu6hiHt2lGY+25H/eyIRoSdSMkgH/JEZ2lyRk63lNthxOSTNnoYA8z7y+Azx8NgzZy0vc1nfQQil+6m8M53o68Oow3u1/yqIeNjq5wIP7fEIiw4JKFeaWq9ejzEbMOoa2dMVrEfGBDjEFHsrKJ1SVT/sehs2XYcFOZfXFh3fpx0y7rOv4cjnFQavU/GtuhI16C04sCNwsXvIdwYvVoSh2JZx7degmIooUAFW71X6FDY34fJyeKyf37UUPeWZXfGwolp2HX5s5imWVoh6yHNpwMWmGPJR8ByqSsk4YXMM2KEvk/W/9jzuer+mbOKD3H/mSGQrHXQVX897QvIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYx6BcI5f/wraCUYhJFxHx31QYEkcLZCOZ2VSLWdCko=;
 b=kbXHBaTeMtBg6o7zrXxLlGpI3MlKOmGHnSlA4PaPGpXPM3UcD1GnD4RvUw2S2XZAjR102z0pzB9Fzux/Webk66Y/aY8yqP+/yTfmH7pJHKZzdveJ8xl84HDkekmauBC2/VnhMk6CtiYN3xW9mhQxDAvX5VouDeGWGFT912BDIwLvFDfUDrCFq4QbrzNnXnrTDNGgL3M5x2RVrTlpoyw6kBferum0wohSlCoR+S3EVh6FN4q8Ivp9g8mneFqlNLXkaBXzBH+AJooCJ4jseE6v6rSgK5B+fzDlnkLJmIjJ5cO9cOMPNIogKKpi18LydE+Z7p2lGYvjA4exFKvotWuM9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:17:32 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 10:17:32 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 0/7] Tegra264 PWM support
Date: Wed, 25 Mar 2026 19:16:58 +0900
Message-Id: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/03Myw6CMBCF4Vchs3bM9AJEV76HYUF6kVlQSEuqh
 vTdrcSFy//k5NshucguwbXZIbrMiZdQQ54aMNMYHg7Z1gZJsiNFCjfZaVyfM7a9E2RJXawXUO9
 rdJ5fB3Ufak+ctiW+DzmL7/pD5B+SBRJqo73vtaKW/C1ktjyezTLDUEr5AFizZT2hAAAA
X-Change-ID: 20260303-t264-pwm-57e10d039df1
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Yi-Wei Wang <yiweiw@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TPYP295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: d00a3ae6-e1f3-4d8f-449d-08de8a57ba28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9M1g13asqfWJcFN77FX27uv1r+Ttmz0VJaytGgpj9UyTF6jiF9nYos2mefKUg3BZ/zkJq2+UQ+p8fLunq8K5PiMFad4AEy8eRBugXqJQa+wJ9lRRlgIGXLIfjYMhp0qUH8kDGHHmr3+wvp5VEkI2zfDBpbj1saKms50557SkR5tsomU0kuPAZZ83aNtm4B6qf54g1Z9BgNq3N6iWCfPFcrm/1TdGIzo41VOTLgy7M7yTUAHIQjU0YOmyv2pCFHTvoL25WraDvqCF+UP/ZiLLmXI18zt61eknqQAl9Ag++5mc4RSDM54uZaO+vu1ST9zLlZqzI8apxAAob8Djk1Cq5u8lEQE6a9PN7rMDJpUpDMgAw23s+tlzgKO8Z7uMwhUOC/uL0e1laQo26G9Afb91UJt+nKn20v1rA+0eg44qXm4A6vUCyR1gXb8iRGf5ppqHG/JZIWFvorFl5Wc9SPcpEh8jTYYtSrKjKIMDuDdVihiQNk00bgq0KcWbPTY2TSVwUeKAP7QjF49k+SZFxCA5UHVwqzaa4zohjD+nivSWig4XLAAsfTwZxt2wepBh12Wk0ApzQJMEfWFvOHwK7TZB/Ec0RlQZrT4/qfvaWFCUOJXMk2o20nnVKNP1vgTAWjSn+iHpSaEd3Dbw+GJCyh4+dB+d+yS+4domC5S4s1JxJvAXy8hUmr8hSBCtzLDr1rFBRrQLh+I1Jed/Z/AqQBiLDf0/a9CK8rSKy2ajfB0MVlY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGtRdVFBdjJNR25jSHQ0d3Q4d1UrN0hYTXJVU2xOWmhxL0hoUmRRblZKdEo3?=
 =?utf-8?B?Z0dFZlB2dS9IZkZQL3NhdDFGRnFYT0JOTk5LdXFxYS9SU1RUemRGRkVaTUpU?=
 =?utf-8?B?VjV2dE5sODR1aFpVUU1sZGxZUnFvNWY4c0hvRHpLZlJVRTZwVjF2OTZxSTll?=
 =?utf-8?B?RjdscGw5WkhIcWQ3WHpnTHpqM2ttT2tpNndwN0d5TDZmMzRLaHQ0YitnTldT?=
 =?utf-8?B?eG5PTURnbUlybit3bGphYU00MElZNUpLVHRwZHA0TTE1WFdPSTBmemw3TG9p?=
 =?utf-8?B?L3lUcVhqY3p6cjZSYnhSVDJTVzl0T0h3VHRnZjJhNk9CYk8ySEp3RE55cm1V?=
 =?utf-8?B?eExSTkg0TGZKd3N0T2VQMTdHbzBqWVM4NjdpUUxOSWRoSVhwbGF6UTNjaWx0?=
 =?utf-8?B?NE5CS1Y3alB4WFcxRy9TK0Y1UjU5WjV5Wmd6VkU2Mlk2cDBTNHNRK2NxVTND?=
 =?utf-8?B?RWdiVlJiaDRmVXQ5S3pDVnhOK0wyc0JYSGphQjVkdFFNclFzdVBYRGtNVStx?=
 =?utf-8?B?U3JKWEVVK2VyYkZkTUYxbEVnNGZkV3hzNmo0WVk2VnhJelZkbmw3R2xyQnVO?=
 =?utf-8?B?NFU4Z2NQRW9RV2dON1VSZ09jUFBxMWhsWFB3dDI2ZXhJbGRXQVNTUExSL0hV?=
 =?utf-8?B?a1VZYUw5Zm5jcFdjeFJ0S2hSQU5xbTlmTHowY3VWV3JDQ1VCOWNVcmo4Q0xI?=
 =?utf-8?B?Wm40RXpjejNCejhYazVyaEdOZEhyd1V1Y2IyL28yeWh1VFlSQ2Y3NUUydzJI?=
 =?utf-8?B?d0pkQnl4ZG1UTGtXSmxJQTN1bXFhOU5udzVXVmdrNFRXbTVZNnpRNnRLYU13?=
 =?utf-8?B?YVJBcFB3QXd2WFp5NktyMit0dVFoWmxxZTRFT01IUFlmNHRqKzBjZWh5ekF5?=
 =?utf-8?B?MXVoOFplbkdpZFRjQzd5YWxEcEJlaWhqczVkcmF2M0xkVlBMWHRkZWpkcHlT?=
 =?utf-8?B?aDUrbkJMUjFRRmUwbThNZUdpOXhocyszUWJTKzBjcnB5ODAxT0l4SDh0a2ti?=
 =?utf-8?B?T3BUWmxlWDlOMHluU2Y1ZS9ud0RpbkJyZno0cVhKbUpVQnNMTDdIcFFoV0RN?=
 =?utf-8?B?eVZsK1pvaE5zKzZiblVVamt5QmIvczFaRU5YN1h2Q2Y4eHdUREV0S21WeW9j?=
 =?utf-8?B?SytTSUQvNEV2a1pnNWN6ck1LZk1lMkc5UG5TV0UxaGNYRWpwYzVNbGxVU2lS?=
 =?utf-8?B?S21ydnpKVVlxYldvYStEUzBjUkIwSnZ2dThJZGpCSC9HOS93eXpCcWtvbDZS?=
 =?utf-8?B?OHc4eTIwaGdHNTZqTElaa2ljVFlQWlJmZjRaRHNCY0RhRnpFWER0MjJGdytS?=
 =?utf-8?B?UFVlTm1pOFZxWUlVNEQxSTczTlJwNEMwTjFuSmNmYnRtWkNrbmYyR1dId3M1?=
 =?utf-8?B?eFlEN3NobndkV1VzSjZlZjlGVHU1VjROUVRzTVh4WU9zMEdDZnU2WmdXRkF3?=
 =?utf-8?B?M21qUWRtSnNGSWE4eVNUaU95cGVMZlRHZVBWMUdObFpxeHJpS0Z2WFI3UGdZ?=
 =?utf-8?B?NnA0QzVkSk1lVVJxM1hvdTJKeE9odWVnRzNqNVZFaVhtN1d3RFFGd3lRQ0Vk?=
 =?utf-8?B?MVZ4Y0ZCUVFvUmRpY25FaVAzeXRrNm5NWEFPYXR6aGNZZ3oxQkxCaGZQZ25N?=
 =?utf-8?B?M0ZGLy9SNzkrdWpIU3lla0JYQmpSNjRlUTZNUURmTXhhdy9UdldlaVFkWmhk?=
 =?utf-8?B?c3grcjQ0bHpLVE9QckRGTnpVaFJvcEpYNTk2WjduRmtqYjhQWDAzU1JiVFI4?=
 =?utf-8?B?OWczOWxJVUdNSWJkVExQMUVSRkJNbDRrdzlyd3IrRG1oZjFxQnR4ZnRRb2ph?=
 =?utf-8?B?Y3lYZWxWTVo0bGhMV3BxS2ZjaEVJV1htZ3ZOaUlrNVducktVSk5wZ1R4bjFw?=
 =?utf-8?B?QWNnVnZmQ1NSSUZKZ3VYWXVlKzVhTTJBb2VPNWo0bjFBMGRYMlRhbWN4NHdT?=
 =?utf-8?B?U3BKN1pyWjY2d1VpK2JvVi80RlllbUp1T0Eza0o5eEYwbzk5RmVQMDF1MkRr?=
 =?utf-8?B?aGJ1cm10Sks5a3ByakFYZ3NyWmkzdkxENWkraTBvdFF2MEwrVTVJTi81cGE4?=
 =?utf-8?B?d2h2SDNNeHVTRmd1TVlOczZ3TStjVFEyVkxEbjNEZkt1SXUrbnh5d1VvUWE3?=
 =?utf-8?B?WWhQTnlJNS8vbHNWcDZaUlZxVVRlS3RTY2daVDRJdyt0bElQZGRpYzlZNEV0?=
 =?utf-8?B?cXh1WWZwNzBaUHF4QXZabW9uSUUrakVUQUkvQk41d3BMUVl1M0xNSTVEVTlL?=
 =?utf-8?B?SlN3OXZvallQaUp2dVpWLzlQVnp4a1ZzT2c5citIdHFrY2xkaFFwR0ttSzhu?=
 =?utf-8?B?Y3htL3hUSGhjSVVwSlNlY2NacFQ5NDFDRXBiWmtrRytXOG9sY2JNZjlycUxQ?=
 =?utf-8?Q?LEyXDjjp/XDjQEzeQoUYjXgAwoUE9Qohf1sRLkRghgYTA?=
X-MS-Exchange-AntiSpam-MessageData-1: WvB/HqxbIEloIw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00a3ae6-e1f3-4d8f-449d-08de8a57ba28
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:17:32.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAKXQOxlnNvIT/5qOEy9wnT2KdxlLHo4la29U3t8SJHcl54c7LXxrqYbs/odX+Y7qJaszPLuj+hndt0as6IT8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-8357-lists,linux-pwm=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 549B2322DB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

this adds support for the PWM controller on Tegra264. The controller
is similar to previous generations, but the register fields are
widened, the depth is made configurable, and the enable bit moves
to a different spot.

This series adds only basic support with fixed depth -- configurable
depth will come later.

Patch 1 adds device tree bindings for the Tegra194 and Tegra264
compatible strings.

Patches 2 to 6 contain the PWM driver changes.

Patch 7 adds device tree nodes for the PWM controllers on Tegra264.

Thanks,
Mikko

---
Changes in v2:
- Added device tree binding and Tegra264 device tree patches by Thierry.
- Link to v1: https://lore.kernel.org/r/20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com

---
Mikko Perttunen (4):
      pwm: tegra: Modify read/write accessors for multi-register channel
      pwm: tegra: Parametrize enable register offset
      pwm: tegra: Parametrize duty and scale field widths
      pwm: tegra: Add support for Tegra264

Thierry Reding (2):
      dt-bindings: pwm: Document Tegra194 and Tegra264 controllers
      arm64: tegra: Add PWM controllers on Tegra264

Yi-Wei Wang (1):
      pwm: tegra: Avoid hard-coded max clock frequency

 .../bindings/pwm/nvidia,tegra20-pwm.yaml           |   2 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  72 +++++++++++
 drivers/pwm/pwm-tegra.c                            | 141 ++++++++++++++-------
 3 files changed, 172 insertions(+), 43 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260303-t264-pwm-57e10d039df1


