Return-Path: <linux-pwm+bounces-9525-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CcYrJGGuR2qxdQAAu9opvQ
	(envelope-from <linux-pwm+bounces-9525-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 14:43:13 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E38670274C
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 14:43:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=L37+edxU;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9525-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9525-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D0453006B6A
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 12:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C973238A73F;
	Fri,  3 Jul 2026 12:43:11 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020083.outbound.protection.outlook.com [52.101.196.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC733B951;
	Fri,  3 Jul 2026 12:43:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082591; cv=fail; b=fdGkXwktERPTBXG0ss+Os3uV2wYhPMpnCkzRryVCABKC0GMOQB8x0RY3RhKVuxSFZpdJWsD2bsWQtBftXXbNBiJumBgFVgC55yYbxWi+zlFWnbe+lzH2ltH4YFNxQgBafpZ3xo+qwTyRTkwXH5rmXV8ze8tKasst9uCLRs5UzVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082591; c=relaxed/simple;
	bh=WnoAmhd4oKLyOcWvtZ9h0hw23wpqjZEe9WCCEao4LEA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=j0tOnnonMO/FF4TCf4FtqI01wed2cDGmiAqC2aBrJmCjf1cuosf7byhX+taslJaO8PneG79H4Aneob7p+7Qjtnrir7nRhL8MiVQRvE5P9GmgprBxBxxWXVwfGN53c+hC+8a4pcb0G/K/mMSS6APctoHhO2mVoXJZQdhSiKLnyWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=L37+edxU; arc=fail smtp.client-ip=52.101.196.83
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgIVnjUD1q4xFyAS1uplojUS5pqW0MyM8X2LBzNEHKs1SZFk2qEGPBtoblPJWesGFiGzpJX3McZkIJHs2fB9BQ1uLEx9iC45Fh58cSqB5KdQ4xnL+FxOU9JFJeeSA2UYvWAgvipi9GiIpOzbBBN7I26CUvgjf3LwVncQOCUVOwjzkkRQM2cqMvpMnQuwUVoL6jDLlI/lePDQAubYbmVJ8OmGG6qS9uG1ahXslJxgAVRni8Ai0wrZCJcKVhR+KwWZX/CfuG3kjeIVLQTogJ984LfIlvlo6NuYlW+cYqz2wdk9G3t3lcUwuZ3kYrr8rze5PUWXPE01LIZXYLHWagnLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lv21P9hgUATnyOEW5+QgamrtjtsOflAw2CmDThsLCeE=;
 b=Dghu2Ov3KX6ybWcqnf9+CLkjLTSrPV9jEkrOLspoQfq9ka0y9ox7iokpbNjviXGJT77Is0FLpp24/AKJLIbeX73whoxcAabcZQCFEKJoZUfYCDohrCcu41zbb0GC8tviuKkZz5KiK8qmZTQZZRHJNMOg5JuAfZQ2WlZJ454sPik/kqRFfW9ccrL/vOCLmkj/rdWGgLqbJ7ZXIkFJyd7ozOIrlKPKA8XXUlbn59dhXv0r0Lo1WHzLBbHjMqx0Zl42tB8rBVGMZDUUXyhk0frD9wnDYqGy/PBhXRPAemSkRw7cKhv0izyw/vZRMftVIcXsvuZ83uRdmRoovJROpYTKng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv21P9hgUATnyOEW5+QgamrtjtsOflAw2CmDThsLCeE=;
 b=L37+edxUppKi75rickavpCrHsP397qlBwmpM/cRMUwWzZLQi0lEQAUjym2OallNq8l8liy6sluBHoZehKiMNMm50vg9DtdluNCMO29vMpsV2AFOUYJvwfj9HXJHTXqoLS4gDpbjZUNTKyHp2mFut81F6YPec9ts56xmaak9MkEs=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3038.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:173::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 12:43:07 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 12:43:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 13:43:06 +0100
Message-Id: <DJOY0VTYTXGV.131A1QNJEAPLU@garyguo.net>
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
Subject: Re: [PATCH v5 12/20] rust: io: move `Io` methods to extension trait
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-12-d0961471ae50@garyguo.net>
 <DJOPUWC8C7GU.29L05GZVLOLO8@nvidia.com>
In-Reply-To: <DJOPUWC8C7GU.29L05GZVLOLO8@nvidia.com>
X-ClientProxiedBy: LO4P123CA0342.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3038:EE_
X-MS-Office365-Filtering-Correlation-Id: 411b1d00-9edd-46fc-2978-08ded900a1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|23010399003|366016|4143699003|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aTdtPWx4AUFGHLp3/V8a3CtGWgEtbIL9mFraWVYHaV5kqXpk9hs9bfJXH0MhQde00mXDVn7I/3EbGJEOvYdf3yxcRqfICgwL2w9B2LkkcvmoDI9ZHETkiVTX33S4p+jOmYo0Xtjma048civ01uRjXtPAk0TI4/tJnJSURVfrAubVBjfeqax0VrXZBn4J7/hIPl7s3/NFiyySqOSmh4R98BKi5bjyfjB6Yizl4G+RxvTyTN8G5DEuGwZrvIFdS7k54VxlgTifl4S4xM1UH+FOwiHjGcgNsrIGHA42ja8UN0LPsK048ASFBxe4/abIR0aNSj07cHvGtO7fr1NFqymKL82UHXyKVRw/ykMTZ8tiSg4V4ZiYSFKK/N2UjaohsuqOUwCmfL3+a6/GUKRpFl4uDX5AUkIAPbjYjQR46XYnBX0zdcFqxO2/WodwA+IaLBg5DxJ8BrbQQ3Geb/E/+46RXHZAPLYxN/0SjF8FZ1/rpHgpMsXSKMNaoGovOQoCqzLz2M3HBAqOPhVZyoVBHQfL4MjMkwvahkEN7/pAL8KY6xR252/1NbioCKXhreL6vX+k4s67SLzwgAJu2b+NXCWFYMd8CKCzfGK2y401eg+a5I/1CzK7pJd5Xl225+RRkE1EO3KUBJBOnfsj+mQ1cbRiXc1Oo0xg4YQAkOWTD8kY1f8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(23010399003)(366016)(4143699003)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUJ2N0xvcVNzbUI3ejB3UjlMN2xUV3dvUHVBWEkwdVpldFFsUkR1bnI5Z1I3?=
 =?utf-8?B?R3BucjB4MGhTVis2MXRialdUQnhWaUdSRy9ackQ4RGdtQjRBTTcrTEhBUGhP?=
 =?utf-8?B?QzBhblY1RGI1c2ZJOXJ5Ny9QbTRHbC9PUE9kNm5uMVJBLzJlNE51aVFPZjQz?=
 =?utf-8?B?K3M3T2dsTkFZVk5vOXl4ZDFrTnZETmRJRUEzT3VuVUVIV3h3dHZseEhXWG5p?=
 =?utf-8?B?ZE5LTDRjcGNiUXdmbHpzdENFdFIzaThBa3VIQjFWd3dCZUVKL2lUS3puajhz?=
 =?utf-8?B?Ry9uN1dzcTdFVE9xWm4zTGMvVnh4bFhSR3dTYXpVMnFOT2gzZk1GKzkzblVB?=
 =?utf-8?B?RVFiZ2krSkwvdE9oKzdhRTBxbmlLaEduYkZVOU1GWGV4N3pjRWQwR3NRSk9Q?=
 =?utf-8?B?b2VqcGRQMjRJWkNBeFZNQzVneEN5b09JNjJiMnc2d2I0ODlUR1RBcmpHWWJh?=
 =?utf-8?B?cGlmR2ZuNSsrTkQ3dVFtMWtXSG4vRmxqTUgyb0szWXVtdTc3b0lEOGtJWm12?=
 =?utf-8?B?ZWk1V0pOS2pwT1Ruck1VRWk4bk5KZXRFUnQ3eThZWFhIUlNmWGlLY2lEdkEz?=
 =?utf-8?B?U2VSZktLVlBmRXF3TmdoRzluU0o5aEFpOFlrR0JWOGFTR2Nlb1ZXY09LdWcv?=
 =?utf-8?B?b3g1LzRLZXNSeUhhWE1Tckc2bE9tTFE0ZjNjTzJFMlN2OXFYRXZuS2FiRVEx?=
 =?utf-8?B?NGpPL3Q5TEUzMm1YTFhDUGhFOWdtNUVCK1JHRlcrTnJhOVV2Nlk0M3RGNWRT?=
 =?utf-8?B?THYyaXI5NHV1eXdGTkdsRmd2bk51REFHU24zcHRnYnpwbmxGb1FYYndWQkpO?=
 =?utf-8?B?R3RERmM1N3ZTSWs0QnJoODZmRFhxY2xPNXh5bE4xS0Q0TStwaEFEZTMwWVhL?=
 =?utf-8?B?Ri8rMlBoa0twVkYrTlUrZEJGZUpPbytGa3ZOZnMwYjVtTkJxelpzUWtwS1F0?=
 =?utf-8?B?RWVkdnFLZStSZUEzckdvdUxOeU1OSEFpektNVDNKY3lpK0pzRkZ5RGdQNmxZ?=
 =?utf-8?B?RnFYbmIxaUZ2SGRWL0tKVnRaVFZOWS81bmdWSEVraWxtTWxZWGtiemI1MGdF?=
 =?utf-8?B?cE9STDV5aVpXN1Q0d3d6STRSbDRva1FiaVMzSXJZcXo4UkIwU2lSZ2x2WGFJ?=
 =?utf-8?B?YmF5Y1V5UUtCYTRycWt1WWFKS000QkR6SlM1eG5Ec2cwclpuaFp5TXE1bC82?=
 =?utf-8?B?Z2ljSzFPVFcydjQ2RFRHYVNPZDl0MVpuWElPMWJ5RW5icmdzQzlxVDFQTTBP?=
 =?utf-8?B?WEVVWGpJNWVacUY0YjF5WlFRYmR0RUM3OVFhRGZubndHU1Rpa0VDejlyYXRO?=
 =?utf-8?B?QWZoYjVHY1RETmVmZHcwRjNNZUFnaXlWbGY4RnB1aVFJcjRya0taVytBM3pM?=
 =?utf-8?B?V3B2c3hrZG1jeTlyUlFvMEVDYldvVC9HeU93dzJEa1VKK3djYnAxb2R2T0ow?=
 =?utf-8?B?VXJScDh0c05WclJDT2c5RExVODVEcVB6YmFwWGpzc204YjhFUzhyVi9DQWdh?=
 =?utf-8?B?NXREa1lHZi9VSUhmb1IyRzkydWJ3eC81ZHd3R091TXhGM0RFMXJIMFVvSWJ1?=
 =?utf-8?B?R0hCbnhDY0dWZTcyM2lhMGtySVRXNDBLV29KRU1obVlMbFJqbXR3VytmVE9R?=
 =?utf-8?B?UFAycWdlSFFSY1lvWVFhdGNNOTBWTEdYdk1YS0NmZjdsamNCd091TE9BbERI?=
 =?utf-8?B?RENla0tDWEFNckRkcGdoMUw3aElIK2tLTjF3VU1yanZQMW51eHJ4bWo3dFlZ?=
 =?utf-8?B?QTJLRm16RWZOTGFjck1jcUNqamdKaWhSaDJBZ2FDS3hOZ216UnZkVHVDd2Zn?=
 =?utf-8?B?ZkdtZHZFb1htSWJkYzNla2M1SGJheHhjWXlDYjR0QllKWkJ5bDkrUWFvR1dV?=
 =?utf-8?B?L1lOQ1ZIODZvV3oxMUwyZkVVQk83S0hFS3NkSFp2Ym9QN3NNemhxTk94R0Nl?=
 =?utf-8?B?MVZlVWpOQmtoZWx3YUhEQjhOeDZJdXhjTE5iTTlVYWdSRGZORnd1eHNJRHhG?=
 =?utf-8?B?NXprUitCZUpjdDhiMCtISzI1ZjE2SmFCM2FLVnNBN205WWdNUjdZUWc4U1Rh?=
 =?utf-8?B?ZlREZUJRZmJKN1Q3allERUJYdldtaTMwM1o1UEhKUTBCM05tRGVtSUVOcm5h?=
 =?utf-8?B?U3VoWEd3SVBibGd1TDZ3b0pHVFRhSWlvZUxOOVpxeDd5WEhjTHpodXNLM0JX?=
 =?utf-8?B?ckJZREFQRVNzNnZoNVJSaUx1Z2ZSU1NLMlJDSWphelVrRWlxOGlYeTg0bGJF?=
 =?utf-8?B?SUVIcGYxcW1wV2EzWEs3dGdaY3VXTTN2eFZTcGVwTUY1TFpuYmk2bU1DNGp1?=
 =?utf-8?B?cDVXZC9yb3hUOGt6SDRsYitNdlM4aVNBMkxwMnBvbGpIRGxJWlJNQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 411b1d00-9edd-46fc-2978-08ded900a1a0
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:43:06.9096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmIajG3+4oKq+8vtgUTNi3qZk04ya1I79E4u2Myn+hIMLI56l4FlgPR26GiCSEbE7RH5XpGuWFa+AsZ8+abOOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3038
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9525-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:acourbot@nvidia.com,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,garyguo.net:from_mime,garyguo.net:dkim,garyguo.net:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2E38670274C

On Fri Jul 3, 2026 at 7:19 AM BST, Alexandre Courbot wrote:
> On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
>> `Io` trait now has a single required methods with many more provided
>
> nit: s/methods/method
>
>> methods. Provided methods may want to rely on their implementations to n=
ot
>> be arbitrarily overridden by implementers for correctness or soundness.
>>
>> Thus, extract these methods to a new trait and provide a blanket
>> implementation. This pattern is used extensively in userspace Rust
>> libraries e.g. `tokio` where `AsyncRead` has minimum methods and
>> `AsyncReadExt` is what users mostly interact with.
>>
>> To avoid changing all user imports, the base trait is renamed to `IoBase=
`
>> and the newly added trait takes the existing `Io` name.
>>
>> A `size` method is added as an example of methods that users should not
>> override.
>
> WDYM by "an example"? There are already all the I/O accessors that we
> wish not to override; this looks more like a new method is just added.

It wouldn't be incorrect if I/O accessors are overriden, it's just that we =
don't
anticipate these being overriden. On the other hand, `size` method can be e=
asily
relied upon by other methods (like patch 19 where you mentioned) and it can=
 lead
to UB if it's overriden to something completely wrong. The `size` method is
actually what motivated making this extension trait in the first place.

Best,
Gary


>
> Besides, it is not used until patch 19, so how about introducing it
> there?
>
> <...>
>> @@ -326,6 +323,21 @@ pub trait Io<'a>: Copy {
>> =20
>>      /// Return a view that covers the full region.
>>      fn as_view(self) -> <Self::Backend as IoBackend>::View<'a, Self::Ta=
rget>;
>> +}
>> +
>> +/// Extension trait to provide I/O operation methods to types that impl=
ement [`IoBase`].
>> +///
>> +/// This trait provides:
>> +/// - Helper methods for offset validation and address calculation
>> +/// - Fallible (runtime checked) accessors for different data widths
>> +///
>> +/// Which I/O methods are available depends on the associated [`IoBacke=
nd`] implementation.
>> +pub trait Io<'a>: IoBase<'a> {
>> +    /// Returns the size of this I/O region.
>> +    #[inline]
>> +    fn size(self) -> usize {
>> +        KnownSize::size(Self::Backend::as_ptr(self.as_view()))
>
> nit: the documentation for `as_ptr` says that the pointer "should be
> used for projection only". Technically we are not projecting here; maybe
> the documentation should be updated to say the pointer must not be
> dereferenced instead.
>
> In any case,
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>



