Return-Path: <linux-pwm+bounces-8335-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPsKIlqnwGm6JgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8335-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 03:37:14 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3378A2EBEE3
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 03:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 586F13009CFF
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Mar 2026 02:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87596230264;
	Mon, 23 Mar 2026 02:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JzxhhRAI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3638C18FC97;
	Mon, 23 Mar 2026 02:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774233431; cv=fail; b=uhCSokkRwZaXzEj1YoU3HLJ1CCo8C6HI0R4INMvZwNuA8lWlDdImJZpZA+1aBZ6odXJ7P5adbPW6ttVpE+MZeNPAezyLN+ZHbRnFsHYxpiLOHcTh0tZpkrjVu0e/XDhKGX4UT+NeFK5tK9dnwsSDpEFJJ1B4At94ufIxxRgPDi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774233431; c=relaxed/simple;
	bh=EP+Bm18pPAfjfWaANaCijq2spHdmje5Y1HuuW4moYb0=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=G2ZfLZxi75s3gJoH/LaojBYJ6Zz/p5e+oUAjhdruZpFSBqFeJ8duqH7+3ihHKKOWC6o6gEvEgPowa+WB4eSUG/3DZ9DqA2Qnmb7CJ1BLYRfQFA6+KEWaiGXbAuW0GQ0Q/4ArexIpPrqQZTNQLarX2Q3ONs1PwprUvwde5mYOsnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JzxhhRAI; arc=fail smtp.client-ip=40.107.209.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkrRjZuFQWbjBgl/1iJR7d0gV8zmywlZBpmpevTbS5mB+fkYfDrKpyCzmd7eIlfjS++eY1+G3pnH+A0WH4LQbxordfDkqH1OTet/n9HqqsSQmSQVbEpqPHUdMDjzH7EdvcaS6NvC3sV+ixSAQbGdrQv0NX+QovosfLTlNlXu0HD1vVRi9M4DbQqp8/we62g/hXsdA4IJlWCplbru42WByeWBgbnQvpzKUmarGB6uysoQdk9mboHLb/Q07eXq7gbQJN2SwI+eQyusiy2iBG3fN9eXCLGhQCjsHnSCtU330OBUI7BqNxldePs6Q0WdcIPzAUgWL1rqp9HAjGklExfM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/jtJuBpyR5u27Kf9wPVpbQncEYR8G5ansyV18hhxnA=;
 b=X3QwiwpVvhStioRhQy/iJ+np4nLspkI9gLzQZ6NaTuWTUCLMrkI0KQ4Fv1kfx+pOTaIskcxmGC+duoDPBWw5ifadcr/JsE4Mzf8u17eEY8gTIYyGzjMOKwL14uZDJ/boytCcUL1hvScVjFT8xze7p/2nYYg3CDffMexIpqPYEWoQ0N7iXDpeuml0aa+iYsLbpXOqltfnoAeIsgS9XIYxMrb11CExFR6rXwDwXsUUlijQaqhvd3galVs+i3nQw/7SKZEdayw4bK/BfAvutE68Tzm12PxTHQjhpRiPg1RBuDZSEps30sO+F3O+7pSSg7Ee1aHasMPKUKWpgpLFB4Jm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/jtJuBpyR5u27Kf9wPVpbQncEYR8G5ansyV18hhxnA=;
 b=JzxhhRAIX8AqlZOMg4VIULidrzx5WM8y6QNXR8ytupyCCyiXL09GGxSccRDujvkLSx33sSOJs+kbJj9A+RPtno0uwc5qnX3DKjJe+ZJ5ReGeUiTyOYV3MtSgMRwPuPLR+cFrpYmMtrNfehCxaXqELjpD1RmtPuR1SzmR5HSFHEKkWBzKSUdi+Kux6DBz8seQ58CTUYl3HuFl2Dpe/Yl20xze3whf4sDR7Aj+ELVsyD8vIDEBRIA79Wjd4XJ4oMw5NAm+i41+xUnGSIO5XUNNfpDO5a3sp/ANimTN3D7ZDWmZOpB879azQPEjJ3+/QAhaJ9F7RlrvTDjeoemEqTW4mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 02:37:06 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.012; Mon, 23 Mar 2026
 02:37:06 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH 0/5] Tegra264 PWM support
Date: Mon, 23 Mar 2026 11:36:36 +0900
Message-Id: <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYwNj3RIjMxPdgvJcXVPzVEODFANjy5Q0QyWg8oKi1LTMCrBR0bG1tQC
 bHZkoWgAAAA==
X-Change-ID: 20260303-t264-pwm-57e10d039df1
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yi-Wei Wang <yiweiw@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 3da94743-ae40-49a0-135f-08de888512eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	aaR9iwUbXsHTPreMyjpSa/FhIYwhxxiasnZvHEB/pzaJykkLQbQOpRkeehMifbCaA7gRyGEC8wk/XfpKYVlEan48k9NZle/DcHEz3LiQF/SjK2mCSbLfJj4LBMQ7avTSz89i2SMI3UmX2T7kZv0dEpzUP0m3t+BCpaCyjWsAoNNwl3WNjBsZEPEZUiBQiUpER7A4/uRBuFPx2O7NWFlO3ZdglR91gdPslPjZlMQq1mCsPaBsIGN45jr5S7DT0/CoJKza8gIpsMp9vi/VANCJte1aEHp+zSi6tXl5JBHtmA6kqVEqOSIhwcM87jcaeN/NG5cmc4nc0x2LwBgrNWh1pvXse7OzI65+nQ3Fmh7ndV5yMeGVEKqcg8QXY5KSUo33351e45gv/H7IP8nuS7YoSnqxtVKN0p+Lkiz0+s02+H7msxtM/KyMLjApj7deP7m8iMNUugE4SC3qAYg053AWZPyTW3XoNczvPShTwxYpFmNmzXzHtiMQ1ZBtAbuQlYeTFc31x+4Lrj7wVSZvypsNXqv2xRVJI1BhkZDsSWyWryD9nJiEQjfJu4hReQ15ZNTWdml+qCdAphFnIVodUrQb1af+VknfMosG0DYMD/j2yoZOHn4JEB/V6pJ0ZH/jLTiuCD4KJnBsfSHRw7j5K4Yqe80lHXEsYetk/ahvcQL8SVwICZlgpE5x3OzC/abdzLOiB61RQ4z3x4rof/CdpBvDNVxWvQQpFJHLkp788c2IuH0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUY5Ump2cExUOFpNZUhkQ1JxbUc1aEVYT1hxK2swNXZkQXBkUVhmOTFzRVAx?=
 =?utf-8?B?a2dkRDg2WHVDdWxEU2hCc2RRckhGWEhRNHJBbUtUc2w2cTg5c090WlduQ08x?=
 =?utf-8?B?Wk15cktmWEFITFVDMWd6OFZ3dXRrMFl3NWFjd3RHdDZmUVpBMDFKbm5teE5a?=
 =?utf-8?B?Sy9PSzdKYTFJeHpBS2RLclE5bnRqSldLRXRZUXZ5aTBCVjBXSGx0aytHeGRp?=
 =?utf-8?B?dHZteWFyNlhyQUNLT3N2WXB5bXdxNURrZHN0R1NjOEYxY1pCNXluR080VkpE?=
 =?utf-8?B?MzE0YmppY25iM1h3dytEU0V0RzFZUzE4ZW54UzcyaDRrSjE5azd3SGV2WnNt?=
 =?utf-8?B?MDducWpvb21tUUtTUG83M0MxOU9aRTFsM1lNQURoSEVKZ1BUU0RHTUYvQ1Nv?=
 =?utf-8?B?ZmJSOCtFYkFLUmtVT1E5L0w1aTZyL2dYTUdEUnVWQlJSbVpoVHJWVFR0Mkd0?=
 =?utf-8?B?NVZBYm8yZkJuNlFBditxdXBRd0JsalVTeU9jREZlYU9ta0ZFb3dMTytuSm12?=
 =?utf-8?B?RzNyaXlJT250VDUxWks2STA0bDZIMGpnY1ZwMURWY1NWQk5kaWk5eURNVTla?=
 =?utf-8?B?TTBLSHlJVHMxMlgwRE96eW9PVG1hY0p3UWJ2ZFNTUytQczNrRm5TL0xkNnM1?=
 =?utf-8?B?Njg0R3BrU2FqbHBoWm15RGFKY0I0aXFuZkRieWY5TGZISjJock5FNE1lb2Qr?=
 =?utf-8?B?c09IUnJhQ2xLVlRFbk1jU0lmVGdzYjVWTjBkWmFCWEpmUzJDVGhrVWNPc2o4?=
 =?utf-8?B?V1BuV0RPZWtFMHVYRmtrUjdYMWNtQXpHdDZlV2pZa09GOWlZNFozblhyNlRY?=
 =?utf-8?B?YU5DdlpBTkFpT29na3duMzRlTDY5bXRLU25RcWh0R1QyZjAwbi9xVE9zSENw?=
 =?utf-8?B?dXhGaHkyUlY5SHZaSGJyeUZxak9vSUE0VjJaYjNQNVJsalhQMTZSbUVCcVdl?=
 =?utf-8?B?akwrWXhodlcydlNzN0c5QjZybG9xWlNTUklCTzBUOU8rVUZkQzFjR1JEWVV5?=
 =?utf-8?B?R3JKMlV4SkpEMnQvdFJPL2wzTmJTL1RSaEVqT3M4dGw1UHJudlpFNUlUWERz?=
 =?utf-8?B?b3VhZDNZbHNOMDJQaStaWExKKy9CV2o4QVNPRkk5ZmpRcXh4bThweHFRd0VJ?=
 =?utf-8?B?R3hRdFlCbTBMblJjQ2hUV2hwTFgzaklaZkMzMUJ3TTVsTHhKU2w3a2hFUmVN?=
 =?utf-8?B?Vm5FWHIzTWIxdjE5dmZRMENmVS9ZVVZySDVBdW5CQmk5MzVDQmVrdCtTV0xs?=
 =?utf-8?B?NXpXVFNLTDR3eW5ROG5QajNKNE1PSWE0T1J6N1U4cFNTNGMrSjNjQnlOTjNp?=
 =?utf-8?B?NGN6RCtzeG93WjQxajJrYjNia2sxbUx5T3R0SzB4MTkzcHZLc0dHbFdqcVJr?=
 =?utf-8?B?SkVOYTJSRFNlVXpDSjQrYzJ2T3FWUVNLd2ZKTzBVUHM3TkNxc2x1YWVnZkpm?=
 =?utf-8?B?a1V3T1VXY2t6TzUrWkpMZ2FiNVdjL3FGbzdpSlByREJ1RUlrY0JYVmlTUy9W?=
 =?utf-8?B?QVp1ekIvdFY1UGd4L1BSRTloOUF5K1p3MzVTWUVsWDA2eVV0emxaemFKU2ov?=
 =?utf-8?B?aGhvdVQ3TmZFNzROdi95M3ZTQVRHelVRSkhwUUt6cyt4SmJLc09YN2tYRURN?=
 =?utf-8?B?ZUxWRVFmdW9wQkhZaXZtUGNia2lsWEJhQlNUYUZGNE1KeTRVUDc2bkJaM1Rt?=
 =?utf-8?B?ZTBKN01odWZ1UUV4MWtwL3pLN01vQkR5SHF6UFB1OXBvT2NaMkEyeFN0SmNt?=
 =?utf-8?B?Zy9vby9HN3IwY0EyTFQ0RDl0aTRjdUpIbnBTLzcxMlphZ3o1WUVaazZOUlBL?=
 =?utf-8?B?elBNOXFrWUdrbUhFdWFEcjRXYWxTRHdDQnQ2WDY4UjAwK2JMajBQL3daUjRt?=
 =?utf-8?B?dHZ5Z2kxS0l5bmVFT1ZtQWxaUkZZQi9FTzVqRjZtdjc3NDl6NGx5MUNCbDJO?=
 =?utf-8?B?WGZSSzZCUS90cjZiYUkrbWJTaFI4QzZvVCtubmszc2VjOTVLMkRVZmo1UFRZ?=
 =?utf-8?B?VFhsZUxwRmprcXNLZUNubmNVZnJQbmpFblI2U09ML0hpcUlLWEhwMDJ4aEh3?=
 =?utf-8?B?WXIyQW9GVk8xclpHYXk5UTU0a0FWOUQzc3VqUWppN1gwV3MwN2p2UWhlaXVF?=
 =?utf-8?B?ZEM1WGdabm45UXBOMmdneC9KLy9NUDdEMm1RQTJkYW9MUjBDZjNLWXBwa0Ur?=
 =?utf-8?B?Ykp1Y0tDL1ZZZytzVHREd21zd0I2NHIyRG5WNE1yUmFoSE00aFpHei9GTy9K?=
 =?utf-8?B?MDBVNkw1UlpiaEFDRjVYKzVBYVV6dlRSVWJhY0pobEt4MEptVi96SVVmUVNN?=
 =?utf-8?B?UFN0K0tCZE5FZzhpNGs5M0c3L1R6YVhpNDhzOEFWcDNkdGFTYjFFMkU1RDY5?=
 =?utf-8?Q?7JA9mH0Kwzt7Cw0yYGxaXmu4Wgk0NXJ0bb0EopF4dmZnK?=
X-MS-Exchange-AntiSpam-MessageData-1: +Irf8uaqfJf3TA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da94743-ae40-49a0-135f-08de888512eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 02:37:06.4613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pebnadie4tlqcjvSzkbvPG/cGiRkxMoKq4Mfz1kTRbOf6TKAlhPcLAR9NnzAxNHYZ4GO6IdePFuwPDpfZn2AfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8335-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid]
X-Rspamd-Queue-Id: 3378A2EBEE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

this adds support for the PWM controller on Tegra264. The controller
is similar to previous generations, but the register fields are
widened, the depth is made configurable, and the enable bit moves
to a different spot.

This series adds only basic support with fixed depth -- configurable
depth will come later.

The series uses the nvidia,tegra264-pwm compatible string. Bindings
for this are added in Thierry's series

  https://lore.kernel.org/linux-tegra/20260320234056.2579010-1-thierry.reding@kernel.org/

Thanks,
Mikko

---
Mikko Perttunen (4):
      pwm: tegra: Modify read/write accessors for multi-register channel
      pwm: tegra: Parametrize enable register offset
      pwm: tegra: Parametrize duty and scale field widths
      pwm: tegra: Add support for Tegra264

Yi-Wei Wang (1):
      pwm: tegra: Avoid hard-coded max clock frequency

 drivers/pwm/pwm-tegra.c | 141 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 98 insertions(+), 43 deletions(-)
---
base-commit: b7cac19bc4780fe1156b217a1c5c96a3e23b275b
change-id: 20260303-t264-pwm-57e10d039df1


