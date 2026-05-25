Return-Path: <linux-pwm+bounces-9116-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBycM5JKFGpeMQcAu9opvQ
	(envelope-from <linux-pwm+bounces-9116-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 15:11:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC325CAEEA
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 15:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98082301ECD7
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 13:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071F6384231;
	Mon, 25 May 2026 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Eyy1uoUo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746E43101CE;
	Mon, 25 May 2026 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779714625; cv=fail; b=R6bwKFBtzbX31YZS8EnY7PA0D9huotq9wG0SiFS6SqE3XpgWolDaNpnBgXPsYBv6vM16/bpGnIQ7ntka0VeavHVyF/QAHGPl64Q9oWY0ERmvQeI6K7QxKzljO38gmM9oXlqjIPlmJcHq3mAl0t4dEriTdM/wrqwRxqs5VyCQHn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779714625; c=relaxed/simple;
	bh=tmqJmLzsnubqNqxrX02jcn081FrdUI5DbrqtjwTpsgA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=HCLzdq/46XRH9ZTZJAgIP0t+BFbQuUlldH0DVrnoNGdACZQnSqk+P1PCSkHkHFzG0wp6nuLezS8kU+SDg67tATXmrLa4Sz1R0xw0Fd+Z/toG92gZE/073d20GZ3H7B54auWv9i5OhMldy+r4bzInQpkT8Myxf/XJqaiy2Hv1WVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Eyy1uoUo; arc=fail smtp.client-ip=52.101.56.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBr1AwZD440XcTmHvAJ5d2i9vkbPwGPq6zYHi3q71I+eLQ3iZJMRRGnhYfpJLYuXjZjaxLO3HzNUY9hoXNKdwcuvmWaw0mHfxsL6qQIjwVDIwBfSg1DEtLEVezVfft3uZMNmMJ2ekyVXBpdJPms5/FQ3aK1do6oJGNv/ILmLxY5AnxWEsbyyEbi3TVxGY3f4eqW0M0/qO3ngeThEjnVWrnfngfn9VpcfxTkOiwcEaWkUYKHzHnDKpfy4XOCrELEUlVcBl9s4V6C19nZ/wvsRgCbTQwrfCJ6XLSzpwzrGx2MaulysmqUFIBke5h4CHFoxIz9WoLwutArdFuPfyVEdMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmqJmLzsnubqNqxrX02jcn081FrdUI5DbrqtjwTpsgA=;
 b=RaFVB1FGW81kJvRAjyVykgMfpslRTNe4if7H4KozQvVZyY3xu8lFNXAFyTnIOfgCMV6CzDZFe+0sDcW7JcHYnlAvjxIAgpLZOuIgU6Fvq3l+DU12wDobnxvVMwA+oEkNEquTcwobWm3iN80dweo0CEdz5Tb3p+qXyajKyIOodDPbml8TGTO0/e3JlT/zFQNqoblhnAx+44AS/jLhtUZcq3DfPqNIlX/DDXMfNo7oUfaDc0c7xqFYgXNke72YK/L9BsjXv4HIHum4SjylXgapIKntjzV5l79uM4g6BB866sZFJWrSWq7XLRBhUiChUVPgBO/y6xCHshOiGUIUsbWrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmqJmLzsnubqNqxrX02jcn081FrdUI5DbrqtjwTpsgA=;
 b=Eyy1uoUo/U+Ko5hx4JzRHhgFODWkrdnWCdrkvIsAKwb2OJAG1YlQJsFear8NUJZi9fCOtMezIutpafEG+RJ1R0Iz0QfJkhkVThtsFVBrWRvzzMzkHi+VQKPIBOR5auAGNTZDCcPj0mZg4ZbDYllhLiGZKbzOSape/AVuei+YKv0Vpe2OWqK17XHFMhOMGhKXST22ZGYDshFafrGckUWNvDKGaXgJhNnR+BUHa8gg1D4jIUMMaAxqzr0o2qrP3GAwSd3g9EVMlqtVVagCY3JknEvmKdqKbcf9dNcIGtWI6YeNj7EoV1cdxAxG79i5EUpT6Fyo5MRu3X5QgWjuHsjKmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS7PR12MB8419.namprd12.prod.outlook.com (2603:10b6:8:e9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 13:10:15 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 13:10:15 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 22:10:11 +0900
Message-Id: <DIRS6DR84QEG.2NF6652JTFYAS@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v4 18/27] rust: io: make IoMem and ExclusiveIoMem
 lifetime-parameterized
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
 <20260521233501.1191842-19-dakr@kernel.org>
In-Reply-To: <20260521233501.1191842-19-dakr@kernel.org>
X-ClientProxiedBy: TY4P286CA0118.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS7PR12MB8419:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e63b67-d5ea-4cb6-2e83-08deba5ef61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|7416014|376014|4143699003|18002099003|22082099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	CtOiQm+90op7d1Z2liQuetGBaohaTAuj2wEKGiiGpx8nS3X4JUp2cR+blMdEHokZVYplZH38SV2Mwt5pUuk4qjkRC650rEcWdr7KbT42pkJus6rXR/B2B0WocsTpHIbuPiY6QcmxLiIVvi8Exo2MsskG4T8Bg0/XJJfJXlmuRyLqj6mohEY0H+n3RnDosU5Vhf03BLSp15gcAPNDY4CU7YFtMSl4mcTU2LaRhmpgRNW7gkfpSSQeWn89ACPXsSspXtj+AioZbvTyxxubokFI5K2P02bZDVthS5Fmv3lJ5u9pxeox2UrmjahaIT79hjBFZ3ipYn8YjWTz3laHdCPn6P1MpPeFD2GdF8T128J8BVczDe6dQwRduCqluXEAtGZgjdNFF/iRtX3tacNkVMjrs04WZbBRKizeVAaefyFhAqCU/t941D/yjIvwNy+jotefVmvGWaEmbePpOB6zkS9ArFJS3wB4mrA1OAWoZMok7ywz3c8UWryASkMjOtDDdad1Eql4JJusevJd/n/M5bX/UPt0JtGWhLCj95YrdL9u9v0DIeHmbm+6TLAU/jDuQoryMb5uFnjNeFZQKWpknMn7ycEVllb+AOxWngDAvAugdslJ4oTKvwcE0haiIvVWPekbWNwAigMrEmEDjXFldzSmkMzZCPlWRfsJX2oaTrVWEBckKJ3sbGOYJYT6mlhdqsw3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(7416014)(376014)(4143699003)(18002099003)(22082099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHVSbjl6VGFkbUduYWJCZGVEMm0xbThoUmxTQVdEdkdOd3RWRGtLdDdWdmhV?=
 =?utf-8?B?RnVwUjNReW0zVXhhVGZWMDY1VDFsclJmd050N0taZ2Y1b0MrMXZWV2NnSzdO?=
 =?utf-8?B?eFpweUVac2s3ZUJIanBBT09TNkJobFgvR1lQSmdlSVJLT0tMMFBKZFJqTmh1?=
 =?utf-8?B?T0NHdHFoUyttUFdweTFQbTd0d01IOGJ6ZkdaSGZER29UNENlcU04TzFGaWIx?=
 =?utf-8?B?UCtjR1lVYm5iYU5mN2V1NW9XUlJveHQ1SEJwenMwN0l2YVQ1MVlGUzFnVTlp?=
 =?utf-8?B?MEdHeEpmUTJRTEJITFIxOXl2UW5keFp0N00rN3hnZTNScStwY2RqQXMveEFw?=
 =?utf-8?B?S0ozUEpDSDdoUmpnUldhRGhHVDFPQmRic3hvWG9BQjVMTGppRWtDSi9tdE0z?=
 =?utf-8?B?dU9TMjZXMDNrRXRuWnRXNm45cVgybnBVTHFuSEpHY0JIMjFkRFZWVWxYZllD?=
 =?utf-8?B?cDRheU5ycEI0Ti9QWERiVWtoMmRMaDBKRW9hc0NtZEp6bDlpMVRwaHlmRjVo?=
 =?utf-8?B?dVg2S20vdzNNTHlpcmFZZUFZeHM3bys4U1ZvSnRYdUIyTUY3dlZpR2M5NjlK?=
 =?utf-8?B?Y294N3N4Y1JGaVAvT1N0dWhDSWx3SlVaSzByTnlQRlNDWU9YOEpwLzI3RjVr?=
 =?utf-8?B?OFJIQjQ3MTlNeDZvempoVDNSN0NTYW9XazNKRG9qbmh1U3FZazU2cTdJS0VD?=
 =?utf-8?B?TGFvNklwelN6WFN4Mko0cmxocW9NczBjaWRKTEZwOEVIMU5QODNCN3NOQkpX?=
 =?utf-8?B?bGJLbWFWN2hDa3dCUHZMK3NLcTBDSmNJdjhOVWU2QTNOVlNkK0lYMDFacDht?=
 =?utf-8?B?bHJPSkJOcG1ic2VleE93Q1NqZGpESXlJMXY1RU1nbzNabk02WEN6VjUvenhB?=
 =?utf-8?B?ZDlvTnkxUDdjVG5hWG9qbXYyM3N2L1pQQUkzeEx0N3hSY2R5R1IxK2lZeEcv?=
 =?utf-8?B?ZFNveEVyK1RQK3A3MEg2bERYWmpMWVVQZFVTVVhWWjc2cjhDT3RxNW1FMWlz?=
 =?utf-8?B?L1puYnB4VTkrMk00MmdhM2YyL2JNdnozM3l3VzlzcmhzY2pLTnAwMnA0eE12?=
 =?utf-8?B?VDQwMjBDdFdPZzJtWjV3Y1pScUp0RXJIMzB2eG9SaFVQa2gxdFVQS3ZDb2No?=
 =?utf-8?B?NUlmbm9qbG93RGk4bHZ2ZGlTWjZDOGZCMDc0Z1VQeVJCTEExMndLK04vWXVt?=
 =?utf-8?B?TXBqSUNjZytRNEpFU2QzbVRTdVpIaGUxTUNOTERnenpUQnBkZmZzWGwxMXBw?=
 =?utf-8?B?Q3psdUpDUjA4TjE1TlZ3ZUhNV3Eray91b0RTdHZVNjZOV2JNNzhLKzNRK0FD?=
 =?utf-8?B?TGFLL2ticWM1SU10SVU1MzNyV3k2ckptMTFYOHpTRVhEd1Y5Q0d4YTh0a1hG?=
 =?utf-8?B?WTNGb2RvRmxMZmJ6Q29lZmc2SG1OUXJPU1pTLzJEbWNvVDFQYklTZUpkQ2xY?=
 =?utf-8?B?Vk9yQjdkZ2V3MVpHV09PUnd6dXh3T2d1NmgwK1RLdWxPYTM3R2gzYWdjMGNU?=
 =?utf-8?B?NnFoc21LUG91WUM0OUlYZkhtZzYzTWlkRi96MlY1Myt3RzcyZ2RZb3lmVWUw?=
 =?utf-8?B?dzQxa1kydlhCMlFWWnR6L3RyS2FjZHoySEpZNUk4SW1XKzh0MytlRTVBNmc5?=
 =?utf-8?B?Zy8yMGZWY2RiQWpPMFI5WWpEMnlxNHRnY1oxWThadUdnc1I5YmZZRXpqaEsv?=
 =?utf-8?B?THhOT2x4SEVhSEM1UlpwZHI5R2VRVExjSytoTWEzNEZNWjQ5WldDK0swV2xk?=
 =?utf-8?B?SW5kTVRuNXVSdFZzU1phandoN0VmcG8wYnhIbnBGMnd0TEN4RWRaZktodlla?=
 =?utf-8?B?emZlWGZQKy8rM01ka2RDeTlaSDNUUDQxTENTSU5UVlhvSExVQU93cEpsUm50?=
 =?utf-8?B?WU1XSE8zanhyemtRU096eXpNaTBWdXFibE9mSi9lL1ZoZGxOcmE0R3VxNFhl?=
 =?utf-8?B?M1hYMncxWVVqcEZyamtveFFWbkpuT2xNdzZhbzFZb0hnYjVPRi9yUlRhUUFr?=
 =?utf-8?B?R09TSXJHRCtEQkRNVlVxak96b2dUckkrd3QvdzJLM1dub2RBbjBXQ0NHZllW?=
 =?utf-8?B?YnpVenZNRDBGUDdzSjZTYUlvaGVXTllMaDJlc1JkYUN5SWUrYXNWemh1b0xp?=
 =?utf-8?B?T0graGxVcUY0aVdpaGdjWjl2TXZRUnZTY1o0MkVBSEZuOXF0NjJXaEIzbFJF?=
 =?utf-8?B?THNPSEJYS2VnSGR1UTJVSW9sd1FER3Mvd0hGOWtIK2NDM1FJbVpzM3JtMTRH?=
 =?utf-8?B?em9hZXhSeXl1dy8wOVpWUWJyVUQyWmVLNE5kdjRpSkFRS28zSGEzR2FqZC90?=
 =?utf-8?B?a2ZTcDJhaitrTmY3UTBGSitwamw0TS9CSGcvbThxdUtwalBWRVc3eW1pQ1Q0?=
 =?utf-8?Q?vctkDpdJQIoJozDb8AQ5xo+RM4jXKdCJXXiy3idp4euk2?=
X-MS-Exchange-AntiSpam-MessageData-1: xjhzC+bEqHL+3Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e63b67-d5ea-4cb6-2e83-08deba5ef61c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 13:10:15.4801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Q9ABwVx63UP41yg66888qjIOKofEVRRgIKSCfKIlJAW3bIW28FtLlcr3AoaDDMbaJ5wHI8KLXwYn99q0hlexw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8419
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9116-lists,linux-pwm=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org,nvidia.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 6AC325CAEEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri May 22, 2026 at 8:34 AM JST, Danilo Krummrich wrote:
> Add a lifetime parameter to IoMem<'a, SIZE> and ExclusiveIoMem<'a,
> SIZE>, storing a &'a Device<Bound> reference to tie the mapping to the
> device's lifetime.
>
> This mirrors the pci::Bar<'a, SIZE> design and enables drivers to hold
> I/O memory mappings directly in their HRT private data, tied to the
> device lifetime.
>
> IoRequest::iomap_* methods now return the mapping directly instead of
> wrapping it in Devres. Callers that need device-managed revocation can
> call the new into_devres() method.
>
> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

