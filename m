Return-Path: <linux-pwm+bounces-9569-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id je2yJRZjSmrECAEAu9opvQ
	(envelope-from <linux-pwm+bounces-9569-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 15:58:46 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E1070A2E1
	for <lists+linux-pwm@lfdr.de>; Sun, 05 Jul 2026 15:58:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=UId68lxb;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9569-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9569-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A36DE3007E3B
	for <lists+linux-pwm@lfdr.de>; Sun,  5 Jul 2026 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5852F37FF7B;
	Sun,  5 Jul 2026 13:58:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAE337882E;
	Sun,  5 Jul 2026 13:58:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783259924; cv=fail; b=Ov+xkXRyENtMlNhXsm6x71xVeqwkn2AjJ6hYNK+Jp4StAuw3twGdxG40ZnX2jJoRlvcnKul78SY4oeA905aXGZfJBxgd1+uQx3eeKJbnAnMf9mQrPYTkat8Fc/VrTTzHJs+RqEAD40UIszBFp9SeL7mPKThKvECw1WmCBQFnlgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783259924; c=relaxed/simple;
	bh=XMn72Ve4befZOQW9/PkRqf27wi0HtUYdt8gBCI7+YHc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=O6M0ClJFGMTxPbyX23LV5soQDlIih6+ImSpC0g6/CNxmGOpgG2pD+ZtA2wlv6hLUUbEXV74tJWJ3WaeUgOjH/RINcFCGMgjYDkSXdtjgzDcb+nTsNQSwbvN+SUa9AogCPpiIC3zRzr39Ht9x5rHLmo26cbb5oGDSQtyfM/wBFEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UId68lxb; arc=fail smtp.client-ip=52.101.61.38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS5KFzY1OMv3dLxc4yNDcc7j0hAzy1T4XradFydiYSI9EhQIrqXhHq8LHobD9oAGw5FT9Xs04oq4yusAS8wFAEqVGdjgHLFO3+xIDRaVj1F2Daqlsd83Ig0+TEP53hUMo65hdqAhkDHvltLR5VXxzk/b0ttN+nHjL6ZU/zhggVAIz877EmuhDwBYLq5rtiNwwhH5TenwJ1raGJJ0u5xBo5W3/QL+mpSAr+rPFFAYm0H04pRbIhhk+OjEuljKrrymL1+b5GAMWEDc5AAg9G7oxQ021MMRWf6MtXL2E7fHzQ8uz52DKjT+OBEfpdsPWcFrGJTWb3X/hazpdcDiot5FCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK4CI3iPNaYR6BBgSNrUpU8Mjm+1GC016yBG8fg2DXQ=;
 b=Q/9RFL+rCpblR3BIP4LnuheAGgphvu8+8Ztgx/LUtUl+8Mxh2YH1aoh0p1I38W9tc+um4dahCOyqtMMWdukjWFBeVMD/ftslpnDp8WhDrOTbO+ORoRksTIjdZqvUo/M3feytLyoJ/Qstg3tqeiIYCZAQ4N0GvAyktbO1jbr9kMqHbLbGQsDohoiPLmLC5Rtb9/H589EgS6cAQB6Xrj7YubWdBLC/eGwSwA1dR6oQoIKJXGypphz06LxOEC45mC+FNqWPAwlmYs6yTUaNsQpjp//n84l5skH/tHNcJ1THZbngvKpGhHa56igGjZKS/fqkbtnvUVhey6qwHAMkb/7KMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK4CI3iPNaYR6BBgSNrUpU8Mjm+1GC016yBG8fg2DXQ=;
 b=UId68lxbUGIdVqrDJUgDg2TOZP3DwNlb1l/Swp1tFE5VbmQj7JGOP0DHujBGTMWv8P4Jdt0SpS896znFIbZlIqqXlrba5uS5AZy3memzQN9gXbHmyvcSa1FG93zNEW0rGPQgeqW62O9BbymutgAC58Ik6wbTM2+dOpSWNur305f+ySV3EgfSDjaCp3yMyMOiyHbXkkJnImCsi78yE0IZRWkO6Ejd2/elHJMcvwJxphEH4duhodTzg64bhqaRQhXaf/WkHhcZv0Vi/ZG5DiHLhmnfuY/8/1AL6J5+VLlErDiY8BH8cThZc7wdGXYMLVC+qz0PyVpA/UCJtYK6VPBN0w==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Sun, 5 Jul
 2026 13:58:38 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Sun, 5 Jul 2026
 13:58:37 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 22:58:33 +0900
Message-Id: <DJQOVQU813BE.YEOLP9RLAFK@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v5 19/20] rust: io: add copying methods
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Content-Transfer-Encoding: quoted-printable
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-19-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-19-d0961471ae50@garyguo.net>
X-ClientProxiedBy: TYCPR01CA0202.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::15) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: d527dd10-83c0-41e3-f3a4-08deda9d828f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|23010399003|366016|5023799004|11063799006|3023799007|4143699003|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	n7YQP8dGD84dGE1IoOrw/q+9p2vTzTuFV1NHNns8zYrkNu/ZRavrTI/aiOqCcOUED0ZtR2Gsqs/jb68b1qbH7E2zFBzhroAZvr9mov93EZPHx6qlH6SbREAQcG/qENXBBaaAEx8yCsjPKnNmJwdhQSCbTB1kMnuLhs4D3/HnowyISAbFjHfEhaaUlyNEw+rrGz2BgIuNw/YEaUS9Q0b6FJhQdazJfeLjp2CyxRL6uzpVl3lSQcNMRmHAtjinnxUYPs/g9DDbZ7TJwBVc3PJJzvp12GgyRfPbJCCZJsSr/nPsNViLPte2ZdZt3MFdxcJi77ugqe/cJE2f2KFdzItiJRam3OWUBxeoVB/PPt8v+m1OdCQVNtIT14uuMNEXbXVpHse66Fctz3HO+vij55nVqslvlI1+ZEzGM2BiF6/53T8QV7BbB/ehQt2HJxI+vAfveouN/vVlfZJ6CJ2ecfDY5iqeKsD6hrk25KZnq+9qhltDzRdQok3rj6mP4JjY3A/Q0zkkAgctfGEJOg3mW/UW1CcO3tLeWLoz9922/zHHfbJ5dOX+GTyJGMDjoqVp28CTUm3Zlw9BGHrGg9NTHzLzGicTPTEHx+FPZeh1B1Er5XQlXwcHv09ybthNR4ld6Nw5FsgvhGob93q+kfxH1wPnLnfs5R+xfFaB4VZ85kTbQg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(23010399003)(366016)(5023799004)(11063799006)(3023799007)(4143699003)(22082099003)(18002099003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFVQQTlWcTUxVUJud3lNSTZwQVlDckxRYW9WU2hkYlc3MjZ4cVZydmFMOE9q?=
 =?utf-8?B?dFFqRkEwL08rL2wwQ2pZZ3NwRFp5d3h5cHpqK3NIZ2VWT25yUTRiRFVzWHYx?=
 =?utf-8?B?UW9FWjVJcGdyRWxoY0VUTTFzY01QUEZLSU5XRmRtampsTC90SVR6NXlQaVlw?=
 =?utf-8?B?ck0vc0ZCbG12UW94a2pDMjB6MnhJbDBTSGRBa0liME5QSHJ4UmxabkdDcjVW?=
 =?utf-8?B?UGI1a2Z6eGFHSkpmRTQ3U2c2dk1pbENqRm9oL3RXM2E5L2YyU2twcFdDa3hN?=
 =?utf-8?B?MkdyRk10MFN4dUVIUTVtS3c2SlRPWG5iVFRuUmhVekt0Wnhxbm9sZUt5ajRX?=
 =?utf-8?B?SDI3RXYralEwcEdaS0Z1WHNHTEZYYkNGbU8vWlZZSExZd3R1MCtRZG1COUVL?=
 =?utf-8?B?b2VEakVyeXRhWUdNZVdRaEl5bnRBTkFoNnIxa21xVWdGemdSd082cDhDVW5k?=
 =?utf-8?B?cFJWR3dKZlUxWEF1Sms2YWh2ZlVuNnJna3FtUzZEOUdzZnpXNXpObDZLaFpj?=
 =?utf-8?B?REQvVWtKZDVlUjdnQldyeXRLODZERkU5NFVKckgwMTQ4SGw3aXdYVVFERXdy?=
 =?utf-8?B?VHpERS9Mc043NHVhM1lmUVl4TjdhWnl1amlMZUhtcVpNUkxwR1JHVE0weG9u?=
 =?utf-8?B?TGJ3ejFVVFpPT2JQcS9BMlFwTk5JZXlQS3AvZ2YyQU8rR3hySmlZbE5IcUUx?=
 =?utf-8?B?MFlBeXFjbjl5dlpabXZDcUNkbFhBQVhZWXArdnJnOXNUMGlacmg0Z0lXalJl?=
 =?utf-8?B?QmMrK3RtR29YVEVpTnBIVjlaSmFnUmxqYVE2VzJneEhtZU5yS3lBMGpweDhu?=
 =?utf-8?B?N2NHb2dpQVFsWXcxUVc0SkVlYlRDVWpwaU85MmovdGNRbmc2SnRpT3N3VzFv?=
 =?utf-8?B?WmlNYk5haXZPaVB4VENGbXVHKzNoUjJNMytDUXZ4RDgrVzlOSUxCRkRoSzF2?=
 =?utf-8?B?SGs3bVN6RVA4cWpoNzQ4VGRreWxweEtBNFJuNFAvR0g0VzcxcDBTZWxjK2xm?=
 =?utf-8?B?L2phTnFMNDNHYmhPYXhNTDdVT2QrQmFRTDRRTGVOdnBLOUUxNlZOUU5nWjk0?=
 =?utf-8?B?TEdrZHRpWjQwSWdlVjlCN280MmVYTnFnUnNmaEVJU3lEMDJNcmR3RFg0bE1o?=
 =?utf-8?B?cVNtWG95eUZpZkJzQXVxbjg3d0dwUzlGdlcrWm52QkkwaVRYY1RXQ2lpYlVv?=
 =?utf-8?B?aEZDVTVYSTRhVDc5NndNb2N5WUN2anJZdk1xT3dnMXZ5OUVQWkYyZDlXZEZG?=
 =?utf-8?B?bzBERG56ZmU1eEdKSmI0dG10djhDRUxJRUJUenBhNlI5eCtkdUNMUDhmSG43?=
 =?utf-8?B?ckpFRUVuYi9DRnF4VmhZcm9Ya1dVd2U3QXlUUS9rKzRZMmVLaENzSm8xOVhw?=
 =?utf-8?B?R1RHcHI2SmVMdlQrVWhSWlVmdXBsU3NtVzVlaTU5ZWZiT2RkbkhuZEJYenU1?=
 =?utf-8?B?MytKMnlRdlNicmxxVndLaXdLazh4dmp0czg5TlpZWVFXY1gza2lkRTNTdEln?=
 =?utf-8?B?WjZBWkg1bmdNNEFSQngxenE0SmpaQkZWUGgyYjZmVHhIb0YvNzgvMU9Bd0lp?=
 =?utf-8?B?NWx4YUdTb0F6REtuVEdqOERqZW1MQXdQVEp2NzRObG5zWFNXOTBRZFlmd2NP?=
 =?utf-8?B?UnlSZjJCdkx1TUV6c2RTRGxoWGZJNyswL3dSSTJmN3hyY21SQngrdUtKcDBy?=
 =?utf-8?B?UHpSbG54TXY4V0o5Z3NhWXhRK3Vra1RiNEFCcFlzSTh2TEUwUnYxSWsxY0pV?=
 =?utf-8?B?UyszRjlTY2orTG16NjM3TTRIVXNnY3R5My9PMkh0S1JUU3VyV3Avb0x3YXNk?=
 =?utf-8?B?MTlVNEkwMjhnWmVadjYxU3V5NWtLRTBjem4wU0ExdjF5TStZRlVvOUdhVm5j?=
 =?utf-8?B?Yi95cXFTNlVOM1d4dFBhZDkvWmN0VUtLb3VqWTRLT1BKdTVRR3R2aVJsZzR1?=
 =?utf-8?B?SXVKR29IaTNDbk04QTd1bytVWkxXaWtVUW4yendzek50VmVNVEhPaUlqdCtY?=
 =?utf-8?B?aVM3ekhuQXRkQkdKa0pzMFJVMEdicEN1T3RFN05OWGM3WDFJTDgzeFF5NzJ1?=
 =?utf-8?B?SWtlQk5tL25RNnFPb1FNWkJDaG1NUWtjbjl3RHdqWnVob1BrTGZBaERoVlNu?=
 =?utf-8?B?SzRFK1YwWVpzZ3IvdGRPQ2E3SjIzWEdEWk9VbmlNVEdmUHZQMkppcFNwbExY?=
 =?utf-8?B?YUxyZ1ZGRHlJTHd3R2g0RUVSVTRDV0dwVEM0aG4zRmQrQW5tSzVFcFhDRjlm?=
 =?utf-8?B?VFI5THRVZVdackN3TTZyWFk5OXR4a2hjeWNQR0hqZ3BjU1JaWXdxaHhjcldi?=
 =?utf-8?B?QlNBaFdUemUzOWtZTUN1TnFnYzdwd0dwQ3l3ZncvOWViUXFrclNvZW9rMjB1?=
 =?utf-8?Q?eIeaR4kGr1Qp3DSoCNZBSe/mQgbRsnxxaDpQQmr5630Cl?=
X-MS-Exchange-AntiSpam-MessageData-1: lxdPU9b4EcaQlw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d527dd10-83c0-41e3-f3a4-08deda9d828f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2026 13:58:37.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EGcQohV4+aoDNX5TibrAZBFJuC/z5VWl0+XRWWfbZ0xgUOOKyZqZyXqG/Kj4DL8wAbhAztjtgbgDNOSmhmtwwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9569-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E2E1070A2E1

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
<...>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index aa82736253ac..b5ac3ac86bbd 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -5,7 +5,8 @@
>  //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/i=
o.h)
> =20
>  use core::{
> -    marker::PhantomData, //
> +    marker::PhantomData,
> +    mem::MaybeUninit, //
>  };
> =20
>  use crate::{
> @@ -271,6 +272,61 @@ pub trait IoCapable<T>: IoBackend {
>      fn io_write<'a>(view: Self::View<'a, T>, value: T);
>  }
> =20
> +/// Trait indicating that an I/O backend supports memory copy operations=
.
> +pub trait IoCopyable: IoBackend {
> +    /// Copy contents of `view` to `buffer`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `buffer` is valid for volatile write for `view.size()` bytes.
> +    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8);

Should we also define whether overlapping regions are allowed or not? I
guess the shape of the API assumes that the regions don't overlap, but
it might be useful to state it clearly.

> +
> +    /// Copy `size` bytes from `buffer` to `address`.

There are no `size` or `address` parameters.

> +    ///
> +    /// # Safety
> +    ///
> +    /// - `buffer` is valid for volatile read for `view.size()` bytes.
> +    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8);
> +
> +    /// Copy from `view` and return the value.
> +    #[inline]
> +    fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
> +        // Project `self` to `[u8]`.
> +        let ptr =3D Self::as_ptr(view);
> +        // SAFETY: This is a identity projection.
> +        let slice_view =3D unsafe {
> +            Self::project_view(
> +                view,
> +                core::ptr::slice_from_raw_parts_mut::<u8>(ptr.cast(), si=
ze_of::<T>()),
> +            )
> +        };
> +
> +        let mut buf =3D MaybeUninit::<T>::uninit();
> +        // SAFETY: `buf.as_mut_ptr()` is valid for write for `size_of::<=
T>()` bytes.
> +        unsafe { Self::copy_from_io(slice_view, buf.as_mut_ptr().cast())=
 };
> +        // SAFETY: T: FromBytes` guarantee that all bit patterns are val=
id.

Missing `.

> +        unsafe { buf.assume_init() }
> +    }
> +
> +    /// Copy `value` to `view`.
> +    #[inline]
> +    fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
> +        // Project `self` to `[u8]`.
> +        let ptr =3D Self::as_ptr(view);
> +        // SAFETY: This is a identity projection.
> +        let slice_view =3D unsafe {
> +            Self::project_view(
> +                view,
> +                core::ptr::slice_from_raw_parts_mut::<u8>(ptr.cast(), si=
ze_of::<T>()),
> +            )
> +        };
> +
> +        // SAFETY: `&raw const value` is valid for read for `size_of::<T=
>()` bytes.
> +        unsafe { Self::copy_to_io(slice_view, (&raw const value).cast())=
 };
> +        core::mem::forget(value);

Maybe we should mention in the doccomment that the destructor of `value`
is not run, neither by the end of this method nor at any point in the
future IIUC, because the `View` doesn't own the object that has been
copied into it. Or we can sidestep the problem by taking a `value: &T`.

> +    }
> +}
> +
>  /// Describes a given I/O location: its offset, width, and type to conve=
rt the raw value from and
>  /// into.
>  ///
> @@ -350,6 +406,24 @@ fn size(self) -> usize {
>          KnownSize::size(Self::Backend::as_ptr(self.as_view()))
>      }
> =20
> +    /// Returns the length of the slice in number of elements.
> +    #[inline]
> +    fn len<T>(self) -> usize
> +    where
> +        Self: Io<'a, Target =3D [T]>,
> +    {
> +        Self::Backend::as_ptr(self.as_view()).len()
> +    }
> +
> +    /// Returns `true` if the slice has a length of 0.
> +    #[inline]
> +    fn is_empty<T>(self) -> bool
> +    where
> +        Self: Io<'a, Target =3D [T]>,
> +    {
> +        self.len() =3D=3D 0
> +    }

nit: these two could have been introduced alongside `size` in patch 12,
or all 3 in the present patch. It's a bit inconsistent that `size` stays
unused all this time, while these two related ones are introduced right
when they become useful.

> +
>      /// Try to convert into a different typed I/O view.
>      ///
>      /// The target type must be of same or smaller size to current type,=
 and the current view must
> @@ -437,6 +511,115 @@ fn write_val(self, value: Self::Target)
>          Self::Backend::io_write(self.as_view(), value)
>      }
> =20
> +    /// Copy-read from I/O memory.
> +    ///
> +    /// This is equivalent to reading from the I/O memory with byte-wise=
 copy, although the actual
> +    /// implementation might be more efficient. There is no atomicity gu=
arantee. Note that for some
> +    /// backends (e.g. `Mmio`), this can read different value compared t=
o [`read_val`] as
> +    /// byte-swapping is not performed.
> +    ///
> +    /// [`read_val`]: Io::read_val
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// # use kernel::io::*;
> +    /// # fn test_copy_read(mmio: Mmio<'_, [u8; 6]>) {
> +    /// // let mmio: Mmio<'_, [u8; 6]>;
> +    /// let val: [u8; 6] =3D mmio.copy_read();
> +    /// # }
> +    /// ```
> +    #[inline]
> +    fn copy_read(self) -> Self::Target
> +    where
> +        Self::Backend: IoCopyable,
> +        Self::Target: Sized + FromBytes,
> +    {
> +        Self::Backend::copy_read(self.as_view())
> +    }
> +
> +    /// Copy-write to I/O memory.
> +    ///
> +    /// This is equivalent to writing to the I/O memory with byte-wise c=
opy, although the actual
> +    /// implementation might be more efficient. There is no atomicity gu=
arantee. Note that for some
> +    /// backends (e.g. `Mmio`), this can read different value compared t=
o [`write_val`] as

"this can write" I presume (copy/paste omission?)

> +    /// byte-swapping is not performed.
> +    ///
> +    /// [`write_val`]: Io::write_val
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// # use kernel::io::*;
> +    /// # fn test_copy_write(mmio: Mmio<'_, [u8; 6]>) {
> +    /// // let mmio: Mmio<'_, [u8; 6]>;
> +    /// mmio.copy_write([0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF]);
> +    /// # }
> +    /// ```
> +    #[inline]
> +    fn copy_write(self, value: Self::Target)
> +    where
> +        Self::Backend: IoCopyable,
> +        Self::Target: Sized + IntoBytes,
> +    {
> +        Self::Backend::copy_write(self.as_view(), value);
> +    }
> +
> +    /// Copy bytes from slice to I/O memory.

"from `data`" maybe.

> +    ///
> +    /// The length of `self` must be the same as `data`, similar to [`[u=
8]::copy_from_slice`].
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// # use kernel::io::*;
> +    /// # fn test_copy_write(mmio: Mmio<'_, [u8]>) {
> +    /// // let mmio: Mmio<'_, [u8]>;
> +    /// mmio.copy_from_slice(&[0xAA, 0xBB, 0xCC, 0xDD, 0xEE, 0xFF]);
> +    /// # }
> +    /// ```
> +    #[inline]
> +    fn copy_from_slice(self, data: &[u8])
> +    where
> +        Self::Backend: IoCopyable,
> +        Self: Io<'a, Target =3D [u8]>,
> +    {
> +        assert_eq!(self.len(), data.len());

I think this one deserves an entry in a `# Panics` section of the
doccomment (same for all other asserts).

> +
> +        // SAFETY: `data.as_ptr()` is valid for read for `self.size()` b=
ytes.
> +        unsafe {
> +            Self::Backend::copy_to_io(self.as_view(), data.as_ptr());
> +        }
> +    }
> +
> +    /// Copy bytes from I/O memory to slice.

"to `data`".

> +    ///
> +    /// The length of `self` must be the same as `data`, similar to [`[u=
8]::copy_from_slice`].
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```no_run
> +    /// # use kernel::io::*;
> +    /// # fn test_copy_write(mmio: Mmio<'_, [u8]>) {
> +    /// // let mmio: Mmio<'_, [u8]>;
> +    /// let mut buf =3D [0; 6];
> +    /// mmio.copy_to_slice(&mut buf);
> +    /// # }
> +    /// ```
> +    #[inline]
> +    fn copy_to_slice(self, data: &mut [u8])
> +    where
> +        Self::Backend: IoCopyable,
> +        Self: Io<'a, Target =3D [u8]>,
> +    {
> +        assert_eq!(self.len(), data.len());
> +
> +        // SAFETY: `data.as_ptr()` is valid for write for `self.size()` =
bytes.

Should be `data.as_mut_ptr()`.

