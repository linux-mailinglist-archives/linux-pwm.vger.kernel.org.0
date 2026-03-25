Return-Path: <linux-pwm+bounces-8353-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB3FF7otw2l6owQAu9opvQ
	(envelope-from <linux-pwm+bounces-8353-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 01:35:06 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C827831E04F
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 01:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1BA4D304FE42
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 00:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401931C84DE;
	Wed, 25 Mar 2026 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LM+tp3B/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010029.outbound.protection.outlook.com [52.101.61.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D5A8287E;
	Wed, 25 Mar 2026 00:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774398904; cv=fail; b=LJgAznJVbe5EkrDoefDwBZ1PAe/0kMPzFponVdZc9X3CqiKG3fYDdDi5R5cMuMf6B7fZcFb8SvMws5ilcoVHbUj9f6DfKW0idahkTEfAS2HR6gEnFCgrH8eJfrL2rYXmG65HNUbKWL5Ts7xN9ysX0mk4mSDfw7pDOvavt73BYoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774398904; c=relaxed/simple;
	bh=CGn/RkfQIvU7ZZr/ZsNL699Cy5Od3HfP1wHXGYDNIhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ohn4Ifb1ETNBvWxc3ksCrawejJGVXOjZzdLulLCysVNIEyGx/5ukGtKlpswSATr6sanPPeCEewCIjipxC4ou5wq3XMt7dD0I2UNlOziBH7xhxIyFYF0RKCJ5JVLWS0N0lZrbdnpvwSXIEzIIbQvKLQLf+AacFlT/sBeqzVD5bmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LM+tp3B/; arc=fail smtp.client-ip=52.101.61.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WriHTxHxwaCqVqKr3XqqJaqZxcJ2duxGrJTh2bOxHucE96uuKyMqvbeMxCsUfUxVh9RwsLIsafHyBC7X1W5E82XUb/i/anR2S/41MBEBE3cQjpATqQAPT+FUxjrQyW/Wa2Ie+feC+btnhnDEoufGGzhCWnaTBMxlLkyggf22U0twbY57MPggXG/oBPoP5kXoYVLRh7UWvKc6HtDupZmkBD14/GB0h6xEI2ckKU0ympelG77HvDLR+JCnPdVAkICTPahZsoSEYYQOn7ymkkD8WnuXtkRDmaOlkh9QzkabTKq4lYraZ9TQux+UQUCudqujx9ouX+4t2ahb4nrqAgcM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6oyYxXje3j3BX10ZnMnl5l5yAuVTRSOSaN+bQkOn8Q=;
 b=wO9eLCBy2/sj5ROzcc4Dx/e0z7YdoI/hbUMjXF/CVmpx7JLahAWLok5fryDUp5a8iiyRtFQ4qEhUy38TPO1aFvhuUX73yBs7zi0ojY2+7KXfY8H5Ifiy0St9ENLXG/KsuPrxancH6n6cOZXg5COxKUA0Mk+Fvg6YWllwZvmgQ2h5Os4cTmFSMd54g1BncRmEFGVKrkOk+kyfyzPxCZFgZvMry+z66M7fBhLsPXw6C8Km+yp/dJ9eMw9pTcPJezvShIR09E1DkjMj1WHAImtLQ6PoaoriYseH3qV2iLyzfDnosxj2wdYYxuXBg05MybmTxNGZ8n1MrE6ylc1YoViIXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6oyYxXje3j3BX10ZnMnl5l5yAuVTRSOSaN+bQkOn8Q=;
 b=LM+tp3B/B1iA9hL1P5ba7djk8siNQnGuoXzNbV647Do2BgpEg1ylXCWQXdmvsriBT/sCai87EvThEDZfZXZkFRplbuREKqB1FuCH9b9N96MON+3UUNTQ887b2ctAjEakdhK7kUGYwHh45WOV8axVl9+PQUKAnsaI6LJkzCfsxQ6JvUTZ7UlWuiW6BXoFOvGiOByGFjrlCWZAkdw5lOqhKVQQWx6Bch/zGMCs65k+vcVRJMRmZHs34vhdaNbQYjBmEEmiey2j8DW8FaJ3Re3WA3+waSrq1aIZNBM/WceYHIQOEooXkaLEK6+MmjRslxylAhJpvAd3Pfd4GsjFDimdng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by BL3PR12MB6642.namprd12.prod.outlook.com (2603:10b6:208:38e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 00:34:59 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 00:34:59 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-pwm@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yi-Wei Wang <yiweiw@nvidia.com>
Subject: Re: [PATCH 1/5] pwm: tegra: Avoid hard-coded max clock frequency
Date: Wed, 25 Mar 2026 09:34:55 +0900
Message-ID: <4405239.kQq0lBPeGt@senjougahara>
In-Reply-To: <acKggw9F7oULLEuJ@monoceros>
References:
 <20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com>
 <20260323-t264-pwm-v1-1-4c4ff743050f@nvidia.com> <acKggw9F7oULLEuJ@monoceros>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TP0P295CA0038.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::11) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|BL3PR12MB6642:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce93f10-9135-4dfc-8d6c-08de8a065829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	b3DnBp0dB7X0KWtoDq0/YWiFzwRe0t8IORO9KoroNiYnAQ9A4FwAXpAfTyNuVFwiCsvHnAsyyAgtlm8pM8QPRJxCsN4qjZsUPaNjshL2eDfOdEh/IY74BnR6/aiYEnMhxyM+HOL7aG/JXQM1IxbpZ2Cyt/Qli7sjf+EX8wb2o+mXHygfcdpgWH5vCkufVoMVGRamTJ/kMyYtSCMkaluj5WjcFrXPxsxBgJT24WmZLLfmqBIDLYXNoRtk89Nm+vl6elhRNENgoHft/4/P7u6Pff/ucFCGZkHwtsUUw72rOauv7RThTuZKT7gJ6E343Kv3uY7iWz9i2jqSGC0rkl2F97Cccti552KpHsEeWR+BxMIlZjOYsOzBC++n4EHkZGgxN4Hi/bM/YUF3Pj5b0Feb2/hluKx/DjEq8QwY94pBR9ACEqsGZImurVTvzvgvCAC3H8DeGfyDb7BIWD4DmvMrXIlSha6wWGS60BPvxAmBhw7Ct9YQoSAveHbM625xbloHQohITF+WK7KhPmIJ9aIOGkgbibkPn8TMZTAvycpOlI+4N5qdMGMObUIfaeOOK1lRYQPsIsRrwOl3p+FLSAkzyM/LGoCTjmOHiIYBwitATs8O+cPC4na8hKnL9KblfQJl0ixjcIioGw9Mw+QoVW70DV1HTHUv1+rNsrhQ2iMkPmriYfnrS3Mi1j+tptiqU8kevOU2sBxQZAcIfl39X7pkVYPTgpJERP5py83YybTxR6U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2c3WU5VR1B1alZFL0VQNjhoUUQ0RVFjem8vb29oQW56dUMxVVNmWTM5aExq?=
 =?utf-8?B?NmVEeWxBMUhmbzdzUVlJelpYRjdxcFJEc1Z0WmV5QkZxS2RyeXJ5MFpFcDBa?=
 =?utf-8?B?SjZSblJ6b3I1MENQVjJxUEVTUVBaNWR2TjJ0djR5aERvaXRtNVVtd29RSTU1?=
 =?utf-8?B?NVRWRlFUNktRWVNEK3k1ODl6SkRkK0VrOFF3NW9qVlo0RWtTa1duV0VOSWxu?=
 =?utf-8?B?UUZDQVp3MW80aDFiOTdJY2ZoR2l1dGtDMms5Ry9PZkNJWGp1TUdMbnNhTEJl?=
 =?utf-8?B?R0VGNlNXYlFWTzRyYTJ0bTNFNHBhdS80TUNpOGYvd2FReXBKSkNLb0U0bWFa?=
 =?utf-8?B?ZUtFMDh5blNkZ2JUdUVhWkthMjlrZVZBSVdZbXQ3SXl5UkdkQUYwYkRYaFNm?=
 =?utf-8?B?VlRvSmgybU85bGd2V3ExdnhkcUl6RzB1L0JQYk5jaFJqMWgyVW1TazJYV1Yr?=
 =?utf-8?B?K0pnMGE3aHBBRzRCbjhyOC9RQ2oyemtSZ0N2RnVZSFMwck55NjJJVEJ5ai9D?=
 =?utf-8?B?ODYvWURtK0d4aGdjK2pKd01WMElIYVFDWGRIQnNyK3orb3Vjb3VwblB1aHUv?=
 =?utf-8?B?ejdhaFdLQXNlbGpGL1crQlN3dVhhY2lnYTRkN0RCcjhBL2syK3MwUDByNDNy?=
 =?utf-8?B?aVRUTFZFR2xRRTI3dUtYbTlibm5KOUg0V2xRZ29IdTdpN0NtYnNydVlkQWF6?=
 =?utf-8?B?anRGMkdaOXNrTkd2TDJmVm0ralhmazVPRFZTSHQvSWFvNm42WkMvdk5yVURR?=
 =?utf-8?B?aHVoakc1dGNUcGxNaUR4TlZRYUVLT2F5OWRqY0lXQmFLK0F3YXRSUzhKYVo3?=
 =?utf-8?B?N3FESGJHcVlwVVJ5NldCcW45dzZybmQyc2h3ZUVncm5yUDVYaGgyb1VVeUZo?=
 =?utf-8?B?OXBQbW15Wk52cXhGUklpRXNYUDl1dkxmWXdvc080Mk9TSzhVbGUxQ3lOQzh2?=
 =?utf-8?B?cDFNbHpEc0JmdnIvS04zTFM4N1ZURWFqMVNwNi8xdU5pREV1aVpBbFlOVGxH?=
 =?utf-8?B?S0pocVRIcUpCRkxjN1NvRnI1L1Y1QUhFSUtxQXFvVytmTUQvbmVXN1doRkZn?=
 =?utf-8?B?ZzdZVWsyd05VaUo5M0tmS1MwRFRtdVRFY2diZWNxYWNZbDBVK3habDZxMm5Z?=
 =?utf-8?B?WHA1bmllUC9tMW5Yb1N6UDdJZDlBVXROTHBMajNjejRMUlNnSWgxWmZRa3ll?=
 =?utf-8?B?bHU1aDNjbEJJOUVlQ2ZPcU45aUZsRVArR0Q0NmpBTnh3YlFCbnh5bnVkR3pr?=
 =?utf-8?B?U2JyVUFOV1B0c3dXRXJPdmxaV1VwOHgzZDVxbWVQNmpNZE5oU0JvdnhUdDNG?=
 =?utf-8?B?UUp3RTR4MTNxa1NnNkpJblQrd1RhSWVVdHppdkNKZ1VNbnN1VkV5Qy9SV2R0?=
 =?utf-8?B?T05LUHJjQ3RxWHlTVlhxeEdUa3pHVWExVlY2MmovNkwyWGNzQ3NoZVBLbmY5?=
 =?utf-8?B?NTRDQ2p5am9MWkVJMGk4UzY2MHJJc2ZtQ0w2aitiMklGbGR6M0tHUE9vSFkw?=
 =?utf-8?B?bXNJdllENFhJcTQwVkZ5NmZ5bVVGYnZVTWVVV2pZczBaMEs4MXYyUFFRbGhu?=
 =?utf-8?B?K3I5RjZEZXkzMWZZaHlGRVJqUG5rU1paTU11Qi9iejkraW9DZEFBL2ZPMHZi?=
 =?utf-8?B?aVpIU3VHMWhwMFcwdzd6UXRNdndKS0N3YmxTZ0lPSXlVWW5zbUI5WFVsbUNa?=
 =?utf-8?B?SkN0cGd6Ym5WTW02OG8wZldzZ3VSRXVET2xwcUMyWUdLajAybGtCdmpxd1Q5?=
 =?utf-8?B?azdreWF5em1rNEhjdlFxcXFuaTk3bXd4cEx3MEtEbGp1MU9kelgxTlN3Rk0w?=
 =?utf-8?B?ZDBlR0lDM2lTeHhWeUxMbEVxWlQ1M0g0ZTg4TEo4ZGdTb0s2WmFLWFFsb0ZT?=
 =?utf-8?B?dTR3V0pYd3U5WFdCSGovUGRsbFFRamk0NzZSN1ZIZlcxaVdBNmkzS1QzQ1Ar?=
 =?utf-8?B?aWg5K0ZpTTM0WllhUjkvTzA3OExBMTAwMCsxdERseXRTY1hHMFZTVVBTWERi?=
 =?utf-8?B?dW1nTjJ6bVI0d0F0YXRSZFpadFJXbUMyWkdLazdFd0djU1FFSmJUL2dCbUpz?=
 =?utf-8?B?cnZpUVBMdUVkK0VzcDdIbytlbGF1c2dxbU1jU2puQmJXWm91aEhBZGEyVXp0?=
 =?utf-8?B?K0lYL0thTi9MWlBDbnpRaldpWDJGNEphV2hER2RoemFEUXZwNHdRalYrdVY0?=
 =?utf-8?B?eUp0REJzTDkrV1NxNU1IOXNsTm1GSk40MmlWaVlXclFET2VHOElBdGhoUnVD?=
 =?utf-8?B?R2FweFQ0WWhKV2tBUEVQaUtoSVdqSWdWdXdjSCtWdXdGOU9HMDFWdXhTZDFh?=
 =?utf-8?B?TkZ1alo4Nms5Q0FWY2F4MzFVVGtRd2hWUlZ3c1Y2QmdCRS9aZy9jdlFjdEl2?=
 =?utf-8?Q?NwF7NIgei6E5VluG5MUDeoCZzX72fMMbpfKvSXc108i1o?=
X-MS-Exchange-AntiSpam-MessageData-1: cJg+o9uJQPQqdw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce93f10-9135-4dfc-8d6c-08de8a065829
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 00:34:59.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LkZ6GMUjaUjwt1RzKb+qo453i4EMaYdplPTczbpn5WVfenSelIbTQ9PUTpja2k3KrdotcQH4rXHTnWELkwHfsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6642
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,nvidia.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8353-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,chromium.org:email,Nvidia.com:dkim,linaro.org:email]
X-Rspamd-Queue-Id: C827831E04F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wednesday, March 25, 2026 1:45=E2=80=AFAM Uwe Kleine-K=C3=B6nig wrote:
> On Mon, Mar 23, 2026 at 11:36:37AM +0900, Mikko Perttunen wrote:
> > From: Yi-Wei Wang <yiweiw@nvidia.com>
> >=20
> > The clock driving the Tegra PWM IP can be sourced from different parent
> > clocks. Hence, let dev_pm_opp_set_rate() set the max clock rate based
> > upon the current parent clock that can be specified via device-tree.
> >=20
> > After this, the Tegra194 SoC data becomes redundant, so get rid of it.
> >=20
> > Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
> > Co-developed-by: Mikko Perttunen <mperttunen@nvidia.com>
> > Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> > ---
> >=20
> >  drivers/pwm/pwm-tegra.c | 16 +++-------------
> >  1 file changed, 3 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> > index 172063b51d44..759b98b97b6e 100644
> > --- a/drivers/pwm/pwm-tegra.c
> > +++ b/drivers/pwm/pwm-tegra.c
> > @@ -59,9 +59,6 @@
> >=20
> >  struct tegra_pwm_soc {
> > =20
> >  	unsigned int num_channels;
> >=20
> > -
> > -	/* Maximum IP frequency for given SoCs */
> > -	unsigned long max_frequency;
> >=20
> >  };
> > =20
> >  struct tegra_pwm_chip {
> >=20
> > @@ -303,7 +300,7 @@ static int tegra_pwm_probe(struct platform_device
> > *pdev)>=20
> >  		return ret;
> >  =09
> >  	/* Set maximum frequency of the IP */
> >=20
> > -	ret =3D dev_pm_opp_set_rate(&pdev->dev, pc->soc->max_frequency);
> > +	ret =3D dev_pm_opp_set_rate(&pdev->dev, S64_MAX);
>=20
> The documentation comment for dev_pm_opp_set_rate() reads:
>=20
> 	Device wanting to run at fmax provided by the opp, should have
> 	already rounded to the target OPP's frequency.
>=20
> I think using S64_MAX is technically fine (assuming there are no issues
> with big numbers in that function), but still it feels wrong to use
> something simpler than the comment suggests. Am I missing something?

Looking at the history of the function, the comment was added in the commit=
=20
below. It seems like it used to be that the opp framework always used the f=
max=20
of each OPP even if a lower rate was specified, but after the change, the=20
caller has to specify the fmax rate if they want that rate specifically. As=
=20
such I don't think it should be an issue in our case, as we're just using t=
he=20
rate to find an OPP and don't have a specific one in mind.

commit b3e3759ee4abd72bedbf4b109ff1749d3aea6f21
Author: Stephen Boyd <swboyd@chromium.org>
Date:   Wed Mar 20 15:19:08 2019 +0530

    opp: Don't overwrite rounded clk rate
   =20
    The OPP table normally contains 'fmax' values corresponding to the
    voltage or performance levels of each OPP, but we don't necessarily wan=
t
    all the devices to run at fmax all the time. Running at fmax makes sens=
e
    for devices like CPU/GPU, which have a finite amount of work to do and
    since a specific amount of energy is consumed at an OPP, its better to
    run at the highest possible frequency for that voltage value.
   =20
    On the other hand, we have IO devices which need to run at specific
    frequencies only for their proper functioning, instead of maximum
    possible frequency.
   =20
    The OPP core currently roundup to the next possible OPP for a frequency
    and select the fmax value. To support the IO devices by the OPP core,
    lets do the roundup to fetch the voltage or performance state values,
    but not use the OPP frequency value. Rather use the value returned by
    clk_round_rate().
   =20
    The current user, cpufreq, of dev_pm_opp_set_rate() already does the
    rounding to the next OPP before calling this routine and it won't
    have any side affects because of this change.
   =20
    Signed-off-by: Stephen Boyd <swboyd@chromium.org>
    Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
    [ Viresh: Massaged changelog, added comment and use temp_opp variable
              instead ]
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>


>=20
> >  	if (ret < 0) {
> >  =09
> >  		dev_err(&pdev->dev, "Failed to set max frequency: %d\n",=20
ret);
> >  		goto put_pm;
> >=20
> > @@ -318,7 +315,7 @@ static int tegra_pwm_probe(struct platform_device
> > *pdev)>=20
> >  	/* Set minimum limit of PWM period for the IP */
> >  	pc->min_period_ns =3D
> >=20
> > -	    (NSEC_PER_SEC / (pc->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;
> > +	    (NSEC_PER_SEC / (pc->clk_rate >> PWM_DUTY_WIDTH)) + 1;
>=20
> Orthogonal to this patch: Should this be
>=20
> 	DIV_ROUND_UP(NSEC_PER_SEC, pc->clk_rate >> PWM_DUTY_WIDTH)
>=20
> ? Or even
>=20
> 	DIV_ROUND_UP(NSEC_PER_SEC < PWM_DUTY_WIDTH, pc->clk_rate);
>=20
> ? (Note, the latter doesn't work as is, as the first parameter has an
> overflow, I guess you're still getting my question.)

Indeed, it would be overestimating the minimum period right now. It's not=20
quite part of Tegra264 support but I can include a patch in the next revisi=
on=20
if you'd like. Otherwise I could include it in the followup series or as a=
=20
separate patch.

>=20
> Best regards
> Uwe

Thanks!
Mikko




