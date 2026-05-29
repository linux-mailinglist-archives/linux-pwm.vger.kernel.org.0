Return-Path: <linux-pwm+bounces-9194-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aA5+JF//GGoEpggAu9opvQ
	(envelope-from <linux-pwm+bounces-9194-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:52:15 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADE25FC829
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D98253150D3C
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 02:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6134A369D5B;
	Fri, 29 May 2026 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k7OTQLmp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013034.outbound.protection.outlook.com [40.93.196.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E20B368275;
	Fri, 29 May 2026 02:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022880; cv=fail; b=eq74amwFgothFrBcyVxdJV0CSrCbdBYEi9UEsBGAtEAm7jWAKOlqrKSaAi+sGA2S5FlnO0+ERKCLLHe9myIasyVi56DRavGfaaPtSPE/zGyZ52ElyDRrPu6HaSjaVEGOB5J+fhyOiiuDwX9PoAbS8hQm1Nbxartmic/uFz/xaEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022880; c=relaxed/simple;
	bh=qtEGMV2/Ydr6F//x50HaIWGMG66yAakT7k+6Kp97sQs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ceNIDIGzUSgMvE3q5LXwoLGIwbrpQiH3BDTglwI/t3SNn/WtAXMHKM78wHHQTPLaKzqRrw7873Kp4OFwAf+PUJZsu9AyTRU6nbA3R3/hxCwHJElnyLFqPgn58b4iMZz2TOkyt3wzpOb1H3ooqOzb1j34gOsH+L/DwWJsabcnyeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k7OTQLmp; arc=fail smtp.client-ip=40.93.196.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQxwTx57ivz31DVbL4CS9cObynJf2Amr5KSIcdSlUNU4FKoBGrli2gieS+6WoBqLhcmHjGSFQU3vGZ9D0grp5cXftoMda83/q6tgPJ6NR3txqIrLWRKVf91QJN7CsoZ+X6PBwzsVGDIBYQxwquF3db4R5XF2PRIqezBVmVb9XdTUPhx4anNBEbPvfkHI+PLmLsOGaTGWAKwucImT3FH/UCatrbINzuzCP/N9tilnX12bfwlSSBkKJu7zMkCcImkYtZgthwWdMmIf8ezxf9ZqC1t0FB7ocGoZngCO/9eSNcEDVP3teSWHBD/HTi9/qK3MNjvu9qaWK/vAUEu8e9joQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9wSZyUjJ/nAOefappF92j40YCLyxl1d/WBdeY3Rxeg=;
 b=xBFSCK4DmuPZo0DDY1dmr72rJik0C11glN9Z7x2pvUJo4m/8LgkXiiRjkbgbDgsIh6cpKcC07fggWhP8e+dP6DHV8fOY1Dn8lQvUKbj/fplgrJbtYwBEleUCdkhWG7xYEPk7BeBjRhAORWhRlNfntV682hFYO3Osu3sEmgVOiLNhl0Yh+OKPyYi19S59dIJC0P7wThrNlVUovlRnN4Ea5R9vHBlfuQmG7fjaoCzNMDgw+oUfRCuMtiIqLXMOmcPbO2HIoOK26Idx8CsDviETdIzS0ENlEHDUt67hpha8RNXXIoCQqOHsy1mR5Cu4DQZRqeBtl6NfuGj4xmHjGutvqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9wSZyUjJ/nAOefappF92j40YCLyxl1d/WBdeY3Rxeg=;
 b=k7OTQLmpaBIji22CviqY9sZTFjpO0VzMWXaFWfKdQJEeEYVRoxV96tHYs7Khhwa87FayXnLOOo63qAP8IJdDPq8HScCpGVO2M0S5AnFlMTNFR8klK5osJZ+3VODN1kub+oh7pGM77Bb7VK0MxFoHifNAbP44R0phkCs0lTZqyxiL6CtWvkp788AEn6ivuxTHtZMlP/SvVmjLxqvoosE9aLZNQJ2ZKBBLWKNMZvqaENF+dAHbKqtNfW7gnr88SB51Rr3PcYWrtzciwmo+Jj5tcdHY6ttUVcC6Y/gw/ZNRfxCiC9G0oVxCAkl6Gv0k5A6wlfK9TynxXGi/XgMKyOLduQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 02:47:55 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 02:47:54 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 29 May 2026 11:47:24 +0900
Subject: [PATCH v5 3/7] pwm: tegra: Avoid hard-coded max clock frequency
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-t264-pwm-v5-3-7bf9e405a96a@nvidia.com>
References: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
In-Reply-To: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0084.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b8b699-7704-4eba-53bb-08debd2caece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iIQ5xPUmOnc4ZLuoRqjHeSZsHUB4/WjI+p9yofv6cpOhAKhkFNmHRjm0inK2aP1L59QW3MFEWClRDxxxJvdBEVtqVlFWLv/3jX0JcP2qw0p3407ezLYrHyjViOA8/fkhJ9xRnxH50v6OjVAtDioyGjNbqYrJUoFkN445cOiiDE6BtXla4DcMVnXbFd4PnpYtKZUu+TPcFJsZykK+5B8VJBoDqvKOhbk5OQoKu03wwrjcxXBL12Ut7O5BBJiphFFg+ZqFyHRzk3aiXHaTjd0a8WDv5EI4dVhKp4BZ041nwI+mTmsThQtBdofYgj+HYQjB900fTIeJtMviNqecYfscNBvG1LbOQs0YAXQ3AXVTwbcT+XlrNQTPDe/Sud0v64SeEZo060X+ksTH99+xVr3XowgacL9t+b7dVkiz3KGBDIL88zJWY22pyVZ0+h42GYK2e0bI7xfsAxjR4D8s1U0F0exOZzqsFW+28Lb31H+CGG9v3keUC/Rl572qFpIOU17hfjooqX1nBkNnBrdCnVgLdVItgvi4HYCV2R/saCQQQIntLl2h6HEqYjy0lIVdRh4pxb9x0IcRvP1hqT224Wd/zmQ0oO8o6xN+EHIzMT+AYCCp4OR30/3H+c9U+zyC8ImG4FT6Ao8CxpCkw/uQsb8rekXVeY6Xh7VPnaVaU3b2KKkTMGeSZQSkARdsAiQ9GRn2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NG1qWWplQlZxUjlBYmExRGN1eElTWEx2WE8zWkczcmhFS1N2dzd2OTFMNGVG?=
 =?utf-8?B?WU9pODkvS3JQWS9yeExqM3dDeWtMVytmYVNQbkdPcGN6TkdKOWZiOUZSWUFs?=
 =?utf-8?B?M0FFREdmODB2aW5UYU8yMHBuVE1JcVplcTVKRm1GaFo5amU4dmZ2KzNSeVlV?=
 =?utf-8?B?TnJzV0VtR29abHZ4aDBFQjlMTGlBbkFNS1plREJmMTlVenJCM0Irano4clRB?=
 =?utf-8?B?czIxcGt0RHNKUlJXUkp2UkVXYkcrRmxrV3F2L1NwK2FYaWhkSzZseFBSclRl?=
 =?utf-8?B?VkpPQXNQaTlFczEvb2NNbTZUWVV1RGxvYWJhamtxSk5MQ05Sa2orV0syVyth?=
 =?utf-8?B?ZjZpQmNqcStZVUJYSm1sZ2I5VTFtN1JsNXpkMVFXMkRvUFBBcm9QUHlhR0pn?=
 =?utf-8?B?Q0lrcnZud0hpMW9nb0JFdDl6TjBTUlY3ZzFPNnZ6ODhBeW42cW8wUnFvK3cz?=
 =?utf-8?B?N2EzeVcwdHcvZS9uNmFYbytsaUdRbFRzMVJlY0ExRlptL2VLZk9vVXU3WVQr?=
 =?utf-8?B?REZnWkFqSnFkc1E5Rlp0dkhRbkpvNXNvb3ROMUE2VmdVQ05PdTZpMGdISVZ3?=
 =?utf-8?B?TXBzbEc2QWhGR3A0bjNBUi9CUVdoZStaTjNUSkNRaWFBN0EzKzdvU3NqclN0?=
 =?utf-8?B?ZEVvNktqWVJPV2VHeWxiRHFhTm5CUzNQV3JMRTkyYUljM2lxRVJhcmJOaUQr?=
 =?utf-8?B?b0RIMC8vSzJVMmN1enQ0ZWVGdnhQaHd1T2lwVGNIMnBwMGRraEs5ZEcrYXMz?=
 =?utf-8?B?V2NyVUVlQXpqZGttQmpLVVR4T0pOLy9QUmVybVhpelNhdzh3dnIwRUcyQU8r?=
 =?utf-8?B?SjlPMUlGV3ZRMVArRTZSNFBXS1Y2SXpIVUcvVXNGd2pjZWNRZUFGemF4TXZE?=
 =?utf-8?B?dXI0TTZ0WE95RjNKZUlqdi9iRVozQVl3T0xUWkxsbTgwRVdrbVRES1MySUZT?=
 =?utf-8?B?VEdHNjlrMk04dXpET2Rlb3RMNHZKcmh6V1hsSC9wWWt5a0dSN0JjazdVNDl0?=
 =?utf-8?B?QXA0MXZWVXdBUlpQY3FtdGJINVV3Qmx2Q0xncWxtUVp1YkszUkUwVW1XelBQ?=
 =?utf-8?B?ZkMyd2NHSkIvU29nMjBzblhmcmpOdlEwNUFmUmRMNVltcnFKckxlbDZ4YkJl?=
 =?utf-8?B?a1FhSTdIL1UvMkxhcEYzZ2t3eklZY0ZobWdEZklpZEt5UDJ5dmRmV2VTdGps?=
 =?utf-8?B?dWRNOEIvRDV5WWtBemcxWWxWamkrdHlPWnF1K2ZqaTIzYWFhaE1CZ1FkL1d3?=
 =?utf-8?B?VVpRK3IxbHdUMktyV1Q3MFZ5Z2VKWXBJaGZGWVd6YXZYc1VNZW04RkxmNzdC?=
 =?utf-8?B?czliYUlBQ1NVdWdUUmZEUVQ3LzhOSzZrMWxxQ1UwallCZzdwWE9OM2VmK2Fr?=
 =?utf-8?B?ZWVPdG4xVWJFK3FwUEk1UGJrS1gwVythV1MvMXFoUGdXYzF3WnUwVVh6V2FQ?=
 =?utf-8?B?QmZmRnhoQm1kTjBlcThlS3BUbEp3MnVJUWI0V0srelhkWDRrbjdiKzhReEZF?=
 =?utf-8?B?bVRZbGlGS0RkcUpYNExjR1Vpd3hLM3BLTEIwdkkvTmtleVRtSE1EOFR6REF4?=
 =?utf-8?B?VnlCaTBFckV3UnlreTd5QTlrREFqQ2VMMTkrRWsyQksrWXZqSTRzNlc3Umd6?=
 =?utf-8?B?SnBmOHl4czVDTG5IejlON3dLVm05QVlKWTEzRFdmK1gvcFMyM2dEcTlJZytP?=
 =?utf-8?B?SWdNM0NhWHQzR2l1Zk9zamR0VkZaNCt6N3AyM1Z1NXFBVVFnZVhXUGxZdllP?=
 =?utf-8?B?OGhxRGxGOFJ2bEFLYjZ3cmoyNCtJOVRJOWNkNDk1dGNqM3VXQVgvY3BoWXc3?=
 =?utf-8?B?aTNORmZ4VzNyWGNKVXk1SkJEWGc2QlVOYjhzenlrR1RndUhEOXF6QjE0R1Fa?=
 =?utf-8?B?QjNIVDNxTmp2aUNSa053SEg3WncveFJ3dnBzS3hmeTkrN2E1ZXdvZWczdlpD?=
 =?utf-8?B?OS8wSWRPNTVXZ2VubUJZNUUrVUFPNGdLbVlGWitDR3NiS0EwSTVxVUtkSktV?=
 =?utf-8?B?ZUNqc1g1RVAzRXNqZ3BaNDdENmRxbVd3OXpNb0Rzdk5HNTQ4U0lHdUl6ZGZR?=
 =?utf-8?B?WFRZZXk3RXlFZVA0VHRXdG1kYTBkRmNJcFNHVzBsVWJHZ0k0aFJ2d2VWRUNZ?=
 =?utf-8?B?ZjFvYnJEa2RpMnFVM1RmWllJc2ZJNk9EODQwR2lIV1dvdUkwaENGV05WQVpr?=
 =?utf-8?B?djExWVhIdXV4WHBQcmhWVWM1NXpDazVHOFJKZU9QaVova21XT1dqc0FNWWJj?=
 =?utf-8?B?SDJJckduaHpkN1RXSk9IbjBjTFRLYnIzZkpKSkdUZmI2RzVuMitNNnV3K0I3?=
 =?utf-8?B?N2NKUXpmS2FjamFRV1R5VWVVQ0g3a09oLzBnSEFxcHpTbk9Kb3NHNzB3MG5T?=
 =?utf-8?Q?jIIo9DwPQcHwE43NuS2VMY+yim9kxZocfhie55xZUuuHb?=
X-MS-Exchange-AntiSpam-MessageData-1: 6fRxFmBbx/o32w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b8b699-7704-4eba-53bb-08debd2caece
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 02:47:54.3413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CuoXt8PmkSnoaqznCD89CFvRWK8pi5hPj98y2By2QJvQ1Gc1ZevgN2BdDFUepCQ9ZkWwvOrSXw6JLcbdry+1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-9194-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 3ADE25FC829
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
index f8c5495a56a6..303e2720034d 100644
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
+	ret = dev_pm_opp_set_rate(&pdev->dev, ULONG_MAX);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
 		goto put_pm;
@@ -318,7 +315,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	/* Set minimum limit of PWM period for the IP */
 	pc->min_period_ns =
-	    (NSEC_PER_SEC / (pc->soc->max_frequency >> TEGRA_PWM_DUTY_WIDTH)) + 1;
+	    (NSEC_PER_SEC / (pc->clk_rate >> TEGRA_PWM_DUTY_WIDTH)) + 1;
 
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


