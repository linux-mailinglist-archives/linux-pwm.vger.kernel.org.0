Return-Path: <linux-pwm+bounces-9489-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d2d5CTnLQ2rEiAoAu9opvQ
	(envelope-from <linux-pwm+bounces-9489-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 15:57:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF926E51DC
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 15:57:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b="KfkQ/u+f";
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9489-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9489-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 501E530316D2
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 13:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555AA3655CF;
	Tue, 30 Jun 2026 13:55:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE3A2F549F;
	Tue, 30 Jun 2026 13:54:59 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827701; cv=fail; b=uj7BcFav5pO00v/67iB+3z7QEMOo9KcdivHNr5bCwxsEWsuc8CZpiRjA66nmo8mcsg7/73aNT/wO8//5JwWAqYaZLglmcTSi/sp3kph0sY5tTBmLv/zyzRbJfrXaQT9rPwtoG3omx0fAr6G0PJHtx8aV8AgH21ipppPAfoUwS+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827701; c=relaxed/simple;
	bh=tXhHpzF/XZQOf/w8llCaUjmng5o2Cwjc2MJnx9R/4rQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RohaZXFZfUrhYgswqAbQ+/gasTHMV0/lWNum4P36q0fuzVXFQCvsa5gRJMc5OjfAG8QR9x1OrWTzPgqimG+5CLW+FSq4cO/YOrSP0IfcPXzt2nhhcHJzS/88TEaJ6LylVyROgEMhuiRS/afd1q9CPIMzpLyUysBUQNLM5wc6Aro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KfkQ/u+f; arc=fail smtp.client-ip=52.101.48.24
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZMmN8BWvVxGoYcuXymzbA2r56h4gxifVC83EHWwDGvFBCgNStZ6nwgos34GKPNtwWlwnxuRqSjP6EcBqaTT1v38qJNh25rMDiEQg0QWFVlgzUAdv1pMiowFe2eK6TSioyf/4mWmtz3jBzBZkpraocUXqGFXMAjU15SLxtOrEmUD/M03FMjIyiy3gL194Pm97Tw//yExxaNKrQNlYUZjbNwk02FuPnFfACV3bgq/Cyia2Q4Ul8WVaO+6AV315XqjF+SoBAY/BCrQhecMkGmPFF9rHnU4wHzq+SW2ep2mobds1vl3lnrF297QgsaeIJkXBvI8jL2+MnBu7xpyTJf+Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+6fRogA+1otDqC4QvbggXGGvS815GiITFR1fcdPsAY=;
 b=uZc1NK1FkoWdGWJy54wEuHLe8uXs6Hoq6OD/p6fMIifP1knvFhPlhxxPNxzjJhyhjP/XGfI6ZA2DzgLxFCCwwdKaXhKQ1vV8gKqmGtmxgibiB+gtW+mJY0/94lZSAhm3g/Hxa2eCQqlUArgYS/S59JazzQxQnx+00LUIO+wZWzZoHswLkftPQsSsCpic01QkUICqUeb4V0otlrIfQmQCQApIRMCF5+tHt5cJNj0yPvpMefYZaXfAWaAB/c/YUQV9v9QOzI1tVw/lKq4IqtdJvxqOtVx0Al/g6lQfhKAHOr3iBVNwCab1IjgCaCZmmYvzKBlY1pgdFpPkW1e8NXlgdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+6fRogA+1otDqC4QvbggXGGvS815GiITFR1fcdPsAY=;
 b=KfkQ/u+f+LbNfEh9guwENl1O3loOwosV0iEhB6bj7iBMOhL9h0V1f2eulVECdaG9NcZqcb4Drmgxv0/eH4r84BagAoMkHsaG/NbSjc4StrShG1MAtDaz1XDfFgg7UYrr+m5mnTIxRyl0rUtdiiabh9XlqEtooh0pXmitsRVUN9FquhC33cOCMmyl0ZDmx4xQNgIZ/x82Wf1atJV6aQN0OfETW5WK07dCVRiEIl37NFxZGJENPH/4Oz2XtxKuokqW8gahfVxwU6vkt/lT2kqhztakm0KQWGIF6KIbhA2tWPCu9NspffkgW77j6avwsnG7J/Lpx0kPCnLCpylCAqFy/A==
Received: from DM4PR12MB6063.namprd12.prod.outlook.com (2603:10b6:8:b1::19) by
 DS2PR12MB9566.namprd12.prod.outlook.com (2603:10b6:8:279::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.8; Tue, 30 Jun 2026 13:54:56 +0000
Received: from DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06]) by DM4PR12MB6063.namprd12.prod.outlook.com
 ([fe80::c06b:5df:6a68:1b06%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:54:54 +0000
Message-ID: <add09636-7b0e-4a99-8503-d98a75c14f4c@nvidia.com>
Date: Tue, 30 Jun 2026 14:54:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/7] Tegra264 PWM support
From: Jon Hunter <jonathanh@nvidia.com>
To: Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, Yi-Wei Wang <yiweiw@nvidia.com>
References: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
 <e7b0d66e-ef2f-47d8-8844-38ae63eaf7fb@nvidia.com>
Content-Language: en-US
In-Reply-To: <e7b0d66e-ef2f-47d8-8844-38ae63eaf7fb@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0104.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::8) To DM4PR12MB6063.namprd12.prod.outlook.com
 (2603:10b6:8:b1::19)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6063:EE_|DS2PR12MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: aeafce2c-e7b2-4772-e4ab-08ded6af29da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|3023799007|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	p8uIHv8QTNk23DkZ0zWXvh7+6qBwKrprnT+tSYdTlX4RmCTt6lqvRS0QxowD3iNwzWJpsEh5K8MeB0O7mI1MZl00KUq5ZxCfY7aKAaWUm7wDeW7fm6CRMTgyOXjgQeEg0831wDgNr8ktOxbqhQ/VzxMw9inkR2Hj0JDRyiHVSIkXjtPCWbCuu/5Ee/ogV2qpIALcrSRPX0+Wjq8TOjEBb3JQCjJ32ToCpMdi4/FF86W4ZBWD5ge4kDkA8/U/mJJ7z3NfjX8AuhPC2mo4G+ygm11nhzb9PaKOr7kf8PouExsc88n0Nvtcd9hdHK28Pt9uvPbk9Bys07HJ6GuDoN0bhIVtmplfWUIWgiksBNkOa9zyy1LRC3stbAbC8fry2advEpOcck8JvmeLUMDu5mduBaPaT2/AXB9qQmD6pc/NzuI57XdiwVwUFHR8Z5pZPF2Aw6Ugzk5hmUnnAVd6JLQoEQ/8WZ2hU2LnKfaOG9Zk3539N4rMALKfTUZZEtJfcBdZTJMS2yV/ibEOAJUB6uXpuKXL4M7zAsLteoq0M17OefGPWGpHG4DpgBv1xbw4rmmoFuDZvU6AbVoRI9QjkmoRTAXMuDlxWwogG36NNVlnQZOHzp2an2V9gtFciXleHGo6O7hpLWeEQdNFyKHi0ufmwb8Bne561pBJ0Qn9RMAOS0k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6063.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czkwaStqRUcyTStpNDBnc3V3RXpoaHZXc2pHVFJIM2RXcGRFT0EzT21WeHpC?=
 =?utf-8?B?bTdqa0dZS3dPclR6Ukx6MHVIMUNDcEZrREIwODZwd3JjN0FIWmF4OU9FUHZD?=
 =?utf-8?B?bFpyZVpHVFhFeHMyN201MG9MM3ZTQ04rWE85L2tNWDFMZ2ErOGJURWNQOG9t?=
 =?utf-8?B?UVNJMkxnQnB2aHh3bDd2dUg2SGFRZWNHUFhERzdRcTh2Ymo2RmtSUmQwTnBj?=
 =?utf-8?B?MFRpWXd1azRZTFgrNG9IUGR0SGpFaXU5WHQwaUkvdHNVN3dQalZnKzdzMFUz?=
 =?utf-8?B?dkFpSi90clNOY1ZaN2hZMDhLRm5hQ0JEOGhyTkRLNVZsTFJKT3dxN3QvL3hH?=
 =?utf-8?B?NWNTb3FqZlpPaWJkWkxOWjh1WEF2YmdxMkxBbUt6YXdUQU1IcVZHbDdQUUxG?=
 =?utf-8?B?RmJGVUllREFFUDlpQlJUcmNOZXFuUWlTMGtQNWZTam9YampQbnpXNXZjVDQ3?=
 =?utf-8?B?WGpXTmdtdzVGdkFHL0VtN2plNVBiMTFLUU83MS8vbk1HbEZhYU11b2Y1a1la?=
 =?utf-8?B?aUw3ZG9RNktCNW03NDNqU2phOXJMenNzMnc2K2tpK2R3OC9aRklJNWV3REV5?=
 =?utf-8?B?RVIwemk5THh3WDF3ek5raGc4VXRBYWhLMzZNWTdMam9FTzNKWGFBSkNvY2wv?=
 =?utf-8?B?b1ZCNWRFTjduRGIrblY0bGJuYVlrM2RyZ1VkRGNGa1NFUUUxU0xnWitNZFk3?=
 =?utf-8?B?QkRyYmFVbDVqOFVXNUdKdDgybFRRWDhKVDJybVM1Z0drYzl6K1hmK2I5bGUv?=
 =?utf-8?B?ZG0rOXh4Ty9SWVNEbzdBT1BqRTVDeHMxcWF6bmphV3RsNUxsbGNnVHh5UmZE?=
 =?utf-8?B?NTdGM1ZTWlkyMHYvK0MwaVdJWUt5SzlVZEo2WlRONURjZ3pZNWFCTmVFU0w4?=
 =?utf-8?B?VG5CN2ovakV3NkxWaGJQV1lIcktlVzl3eWVuUFVGOWJ2OTRjVDg0MjA5V3d2?=
 =?utf-8?B?d1BsSzgxbUdJUU5rd3QraEsyVE4zZ0pqRFp6Z242dG9VcEVXcDZQZDhUam5m?=
 =?utf-8?B?OVU0Tkh6L2Q0dzBNYkp3WDNFcWpuNlM4SmVjUHE1bHpxMnRKanZ2RjFhVU1H?=
 =?utf-8?B?TGhyWDUwRGpFNXoyWmdhREliYnhJRHNXdjZQTWxCYm9URDRFNkRUM0VxVGJD?=
 =?utf-8?B?RmNJUzI3Z1IwQVRta0RFU3ltWVlWZFVyYnRyUHFTNUxPVlZON3k4VlFLRktz?=
 =?utf-8?B?RWZGZG9WVEFGQ2V5TU9zcVdlOGEwbXo3TUtOb0JmRWgzanNodlNGMnl4dnlI?=
 =?utf-8?B?UkFBZHJ4c0xtVGpXR2NCOU1NM05PM0h5dkQwT1hPcHNGK2ErYW81RDk0enh4?=
 =?utf-8?B?b0ovU3NVZFphdVNueCtCZGxlTi9lMHhESWpoVW0wNWMxb1IvV1NzRmRwM242?=
 =?utf-8?B?djVYVGZ3cjFDTmFXSUZYbUgxUmZVMDJHL3JyS3QrN2FRd1Bsd2VQd3Q5RFht?=
 =?utf-8?B?TmFRRlBBb0EwNnB0NklGYmxMV1lyQ2pMNWFoS2llR2Rvb2ZTTjZSUW5LSDFn?=
 =?utf-8?B?cys5REZzRDlacGVTMzhFQjlyOTd2eWdkb1praWxTbzU1djhDOG1lRlo1ckd3?=
 =?utf-8?B?WEphWVQ4Y2FETGZ1M1FWbllBdk5qamVrdm9TOHZhWUNGV0c0TzdIUDZvaWJ2?=
 =?utf-8?B?OWtjd0c2YVRjakZ4a3M3Z29FZEFLb21tczZ6ZnhyNlh0R09KTG1PSTcwa1Jt?=
 =?utf-8?B?VU5HcGZnSDBoSzJxeEdKZzhiTzBwRlJldmFLMFVJYjZvanQ4RWpBV3FnSlhp?=
 =?utf-8?B?RG9ETlhwVmkwd0dzT0RFb3IzVHFBWVErUHBvUExvR2hGbkpiQmoyaUhVa0RT?=
 =?utf-8?B?NVh5OU1VUzBxWHFCWUcvMnRIWHNteFVZRytGODVtQ2laQlRia1Y1dUV1SmFX?=
 =?utf-8?B?a3F4NzhBTERFOUNpdjBCZkJReVo3Z3ZjSWd0ZTY5M2JURW1IakJCVU50dzRB?=
 =?utf-8?B?OVFFVDVoeENOb3dBTURoR1VuT2ptZkFMd1hnNm1YZFI3RW9WeEJqNDdKclBH?=
 =?utf-8?B?bDZVMksyb0o5NGwrNzZUOWZSVXVNalRWbHBHNHhUWWRhQmN1aG1odEp1UWtL?=
 =?utf-8?B?ZEMrMzlidExPd0I0a2RPM2ZZR2drMk1Za0xmTGJlMTcxeWRUZGxWR2VPanN0?=
 =?utf-8?B?L2RNRWhkOE15OERHNVFkRlRQS09WWTV3TkVnRUhmbU9wdFJHcXBPSmFZSW05?=
 =?utf-8?B?R2MwcXAxVnA5RGN6Q2tOUnhmOHh6V3I1TEcrUEFNajJjYTJjYUVzU0tXcllj?=
 =?utf-8?B?akdlVUE1b1JBbGEzU09WVnUwVnZOWXFpQTBpOHFIN1A4Zk5uZm5FQzBxZmVy?=
 =?utf-8?B?bm82SDd0TUJLaHVkeHhIdTU4c3FwbmNMcjJxNEpjZVNsZlZPZ1BnQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeafce2c-e7b2-4772-e4ab-08ded6af29da
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:54:54.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACbOQ8tmakVHmdv7svXcmHhEzm1HWXdxNCsc3Bw2nxwFph8C4Scm3A9P7/SrbKGO9ZelMtZmfF8f41Oo5XU+Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9566
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9489-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AAF926E51DC

Hi Uwe,

On 02/06/2026 10:16, Jon Hunter wrote:
> 
> On 29/05/2026 03:47, Mikko Perttunen wrote:
>> Hello,
>>
>> this adds support for the PWM controller on Tegra264. The controller
>> is similar to previous generations, but the register fields are
>> widened, the depth is made configurable, and the enable bit moves
>> to a different spot.
>>
>> This series adds only basic support with fixed depth -- configurable
>> depth will come later.
>>
>> Patch 1 adds device tree bindings for Tegra264 PWM (compatible
>>    string).
>>
>> Patch 2 prefixes driver-local macros and static helpers with
>>    tegra_/TEGRA_ to make their scoping clear.
>>
>> Patches 3 to 6 contain the PWM driver changes for Tegra264.
>>
>> Patch 7 adds device tree nodes for the PWM controllers on Tegra264.
> 
> ...
> 
>> Mikko Perttunen (4):
>>        pwm: tegra: Prefix driver-local macros and functions
>>        pwm: tegra: Modify read/write accessors for multi-register channel
>>        pwm: tegra: Parametrize duty and scale field widths
>>        pwm: tegra: Add support for Tegra264
>>
>> Thierry Reding (2):
>>        dt-bindings: pwm: Document Tegra264 controller
>>        arm64: tegra: Add PWM controllers on Tegra264
>>
>> Yi-Wei Wang (1):
>>        pwm: tegra: Avoid hard-coded max clock frequency
>>
>>   .../bindings/pwm/nvidia,tegra20-pwm.yaml           |   1 +
>>   arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  72 ++++++++++
>>   drivers/pwm/pwm-tegra.c                            | 155 +++++++++++ 
>> +++-------
>>   3 files changed, 176 insertions(+), 52 deletions(-)
> 
> 
> For the series ...
> 
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> 
> Uwe, if you are OK with the version, we would like to get this into -next.


This still applies fine on next-20260629 and so unless you have any 
objections could we get this into -next?

Thanks!
Jon

-- 
nvpublic


