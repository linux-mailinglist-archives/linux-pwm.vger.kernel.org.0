Return-Path: <linux-pwm+bounces-8962-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OqkF1AnC2pAEAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8962-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 16:50:56 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD5056F3FB
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 16:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87180304ACB5
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 14:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8115B2765F5;
	Mon, 18 May 2026 14:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QSSXdYgz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CDA26F28D;
	Mon, 18 May 2026 14:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115673; cv=fail; b=sckqN5mMnGyFa+Ggb312KcNOIGfsBwQfo6NYR/aDANnlGtvnWQe0kdnreS6i5gxQRq0utWCIjjfH5N6msSRojr+Ll29AeL+AzIxvzQxfwaKgeOgS1ecOS0aqB8x92+Hk3eWznsn/7x2knJXzBtu1QUNx/K+eZkwMH7YqvT6niqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115673; c=relaxed/simple;
	bh=PuxAkzjoU8mY1EF7P/W3P/vlFZXcYPYRTrsoNRUUzmU=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=Aqma7jw0YOraxObLDZAuoMRxQtsnqls5bOWiHlGyUVqwTrJQX6Ceh+v+UrMFAQNi8YWmhkuUMkGaxBclm9jYXCrLKCdjUaQNR/0x1YiMflz8UniqHo31Cnnpohak0vxPNk2dF0xondpSzn4rmhASDMKurgm9aFH4b9VNkOIwwR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QSSXdYgz; arc=fail smtp.client-ip=52.101.57.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJX/ikHWqWps8edeH/+SP79Ow5Lj6YApNi4iv+E0LYGyOB92Y7w3rJqPnVzs7HKSKH7Px8jHru3FiOexH2WM0xh2f5yBX5y4LoL5fLFm2roXqI6zpcqrM6/JClbteEtjKmcOV05sQ283XVu+LP36e0a8Gzx/eXL5vPCMsZbSocWRUOBeD4GX4oiru5X8URmyxqo/hQZHjnKdfcGDK4TA9Ztr2s9iJ4GF6zLjzjfKeyton3fsw01jtSaY8ucBH/ru/0KXuerdRKgBhQoAMQhgJOTNXPLVT+faHzj9QE+Uw5VoHlZClTuXj9El4+CvP6k9HshCqr+rMSna2wSLDEDgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuxAkzjoU8mY1EF7P/W3P/vlFZXcYPYRTrsoNRUUzmU=;
 b=S2xfgVk8+V1CQq5DrpTS6dAWOohNbcKmMrhSKxsQRKzwdd7/MA3B7im83CJ+9HO1/JK0Nr9bodMgG4EL3QsNB7v5xbo9E/mMXtBiC0WW9cjLAXkLhjLFTSwuU465U8ltCS9TZiD6XrvDMVOLuJDsh9XVY0m3+Kh4rylZbgBDyOlwwY34b41g/yKZwk+kgTeD6zsN91DiN90QWuR7H+TJVvJ6xE4O9ZlaZIErjL+LpaDF+K32eiqPUD6U1vPWieC9OtefjtUnutW5zyymha3O/wnditr/jceJuWj/wT85Obzbx6PvpH1SJlrZWMXo0qwceLbLbmcqUuCjH0f38nuI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuxAkzjoU8mY1EF7P/W3P/vlFZXcYPYRTrsoNRUUzmU=;
 b=QSSXdYgzKkFFLi2SsB/wO899zjuJ/Fk1sDrMG80Qhe+XGv13XuXKdgRy8bNx8nE8E80P3qB+rN6hZGb085P5lbFBlcJUNUDaaBTRDTBEQFKePM3/DSN/4r2kjcwjUx4BmE0NA260EfWMDtCaMTtnlOZ2N62hxfPaKXrrC8OIsoX0lN4HkXhmj8pOCwsH9mDa4tCZ3cbRXzU9qIS5/SZzj6V3JrACpYevvNQ9vyvyJbtq1f91jws9/ADxg7G9puO8iKEssXdLZm7SjzX3LximLdmMEJz6bIF01iUMYO4uHO5ivPwPJmDCv5qBMZFXECZ3dPPK25kxVbwUz7NxWTNM6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ0PR12MB6943.namprd12.prod.outlook.com (2603:10b6:a03:44b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.22; Mon, 18 May
 2026 14:47:43 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:47:43 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 23:47:40 +0900
Message-Id: <DILVV77G3VOB.TC0SP9ZOJEZ@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
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
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 08/27] rust: usb: implement Sync for Device<Bound>
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-9-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-9-dakr@kernel.org>
X-ClientProxiedBy: TYWPR01CA0040.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::9) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ0PR12MB6943:EE_
X-MS-Office365-Filtering-Correlation-Id: 857ed859-a0f2-45d4-c522-08deb4ec6b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|18002099003|22082099003|56012099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	xSGMJCwnQ+iGDd+OJ0aAsKS6c4AxjlwpjPsWvyMfA+7Nv8KGigNyvOuV5PRfS7bqYUdE5fquBb50JWtzzgpgnf4BPY8et8Kn749E+6GUdkM+8Hg0jxF3NHjUXUJcBrSeaKKWWyOsP5YTI9Cecu9+c/9Ki3bxXY507BTqcNUP27DE4QqETXLVEUuuIy4YY+VrDhjOqAG8ehciB9EBAVjalCsylGCFWgcGOWEZ7ptFJlpNpsx3iKHhKXjpyVeRSyrUEzfHNz2HSc7WVtenNDpfNpS/ApOX39QjeCW+JXEwXHjHEydINKwh9oIfjYR2h8fvq/P32bWN0vbe8mJ+Bu60Wz1pfN42uMHDfM17mA/HzSld/Mnx/jPdcmO11de9fQKG9vd0SwJEBSwQXFVH8SWx05j5oPdJUvy1fZeaNmMFil15qzZfk2JQ83+jp4LZUtzGRnfjDCqP3TW/9iSXnO0LOhljq8ieg0Kxl4O9EHFAUHC2ZjsBgc/oevryS3hyz18cWRjXlMsd9i81VMHbBBDxuVLhiHdKRsr/v9XZBJ2UQ6jYB/pvHqxIXNuQ0g7++rTVF/pm/aMFbgdwtSRQaNUU+UX9wu2BA0GFKgyYvOnRFO2G1P/6QwG6HBn97Vl4fttG4t4p4px+xV0r+L9l2ONGOiVkiIsuUtYMS1s3wZhz7HZUhijekYxU6VHKxHuJwe+k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(18002099003)(22082099003)(56012099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW1PbHc4SURhY2ljZUhwNGtPNmRYcDZ0bWhwU2s4SWJVUGhON0lYWllvY1JB?=
 =?utf-8?B?b1lXQnBWMk9WU2dhb0pXL2lOOXVlSThkMkcwSlpVZGZIT21uYTZ6K25IcDJ0?=
 =?utf-8?B?R1R1bkI3OHFtdUxSUC9WQ2VvTk5YZEdsVDBnZmdmbEdzWCtacVlkS01pZXBl?=
 =?utf-8?B?RXBwS2JrVEdYTE9qMkVLTTFFM0wzUzZoZ2J4QWZXN25LTU1ITk1hMHNBYWFs?=
 =?utf-8?B?SW9JMmdPZEdrOGZ0WVhSQUJwcklNT21XeEpnWWFMTlNjZTBMc1ZZYk5wWGU1?=
 =?utf-8?B?blFybkxaM0oydXRSaDlxMkhtcFNQbzJvWE1GaEtqZTdOYzFXNGh5eWNKRENs?=
 =?utf-8?B?c2Z4bXlwZkRPbDdjbFcyVVJlQlNZZ1E3eElZd3lpWlZGVjJNMWpIcjcvTktC?=
 =?utf-8?B?bG9FV29mT1NINGZIQWk2TDdPbWEybWVyRGoreldtMkdGWXpQYWhSbnR6QkRq?=
 =?utf-8?B?c2F5M0c1cnZqV212NzJxb1dlWDQvdlY3RTNqRlVNdXJGbDJBK2FSS05weSs1?=
 =?utf-8?B?UGdPd1BHUGl6dVpoclRVWTFOOEUrb010RUVJaVBEdmxKTzd6V2JIbXpXWVJG?=
 =?utf-8?B?V01JWUxKVGlsMldTcEJsRU5BMUFUVkptL1BZaU9EWExqcVpOUzBHMmU5L1dB?=
 =?utf-8?B?cEFEcHAyelZFa1Vad3dwajZKcHhIL2RtZDYwc0lNSGsvWFNraytNNlZ1Q2ZP?=
 =?utf-8?B?WGtOdlBmRVMzbmNJZHVkc3FEZ2hpbDJpZUtBK3cyeWxMK1FKUHFFU0dvZXBy?=
 =?utf-8?B?Y015Uko2TUxxT2pGMnUwU0Rzd2Z4ZGFzZGx6YXZweFBmbEVid0FaOUFITnlC?=
 =?utf-8?B?ekoveEJockw4SWYvMURnTFMyRFg5ZUFkMndMZ2Ria1R1SXUvSW5HNkxmKzNh?=
 =?utf-8?B?aEs0Njhjejk1U09IbW9veHlmbFExYzFGbUc3dWdtNWxhd0VBTEpaRXUwWHlQ?=
 =?utf-8?B?WVRxeFNlNFkrOCtYaTZUUjVxTlRZRi9wcTZtaDhESFBDZTF2Zzgyc2NrZ0NC?=
 =?utf-8?B?OUcrdkFKSUFnb2V1WE9ESUc2dXFEcWFENWY2ZjN5WVVxV0REeWpITlA2RnhT?=
 =?utf-8?B?VnBEZlFyV2xhVmYwbXBjTHYrSDlVdjB6bkRhSHp6Q0daWVVKT2hNM29SYjFy?=
 =?utf-8?B?T3BKdjlCRjBaYXRFWlpoRWZHWVpxU0hoRVI3TWtYajgrN29iNzlWN0NOdTZq?=
 =?utf-8?B?cjF5SUI0MzNFajNkRVZUeDhyVmRQc0VJT0pURm5FQ3FTeFh3OFpQbENvV3oz?=
 =?utf-8?B?VkVzb005dmplSE42MHk0YjFzMExZQWRTVEJmb3JyVUluL1NOUHliSnJWUCs3?=
 =?utf-8?B?YVdDY0RXaDJQWFZ4eCtQK1RUSjRJSlJuMi9CVmlnZm5sN1YxT0RxdktOK05R?=
 =?utf-8?B?eFBZNEJGKzVoZkg2VjhlRTM5NzRtZHV0Y1dETElBeW9ROTBuNlpoR3hUOUJI?=
 =?utf-8?B?STl3YUlXQjQyTFE4TmM0Q0E2bUo5azh4Ny9nNEtPSHJxZUlQeWFQc1NKZnZV?=
 =?utf-8?B?dzBZd3M5UzJzSElCbmlLcFo3Z3BCT0VldzZBejV0YjFLS3hzWHZoUmJ1Rmtj?=
 =?utf-8?B?R0Viam5NdkI5UjIrbmlDRWtOejAvT2RLTEp6LzNxbjJnaVVTNkZvdFhyQkZI?=
 =?utf-8?B?MzJOWGRuVkNQUzNDU21RMW4rNm1sRHg4L3FqUFVybkZiajl1bFRvb1RBOVpp?=
 =?utf-8?B?R00yVHh4blhaU0RTL3NpcVZyVEgvaHQ2UkYzQzZwaFh6c1U4eEVrTHYvYnIv?=
 =?utf-8?B?OUlJQWxtKzBUZzhhU3g2NGhhVXlBNVEwSHpoYkdrQ3VVa1ZHWDZVRlJ3Q2xi?=
 =?utf-8?B?MUhla3llVFJiUUF1MFNTZzFnNyt2NU5JTmZubGZncWdFSmE4UGZxUEQzZ3JZ?=
 =?utf-8?B?ZnA3Rnpzd1VwTzNvbG02Sm4xS2dtRjlob2lFRGJnVDg3eU1SRXpyUGJNRWpS?=
 =?utf-8?B?SmdlWGFHTnBQQWtVYWtoWE5GeXFaMDZxV250VEZXaFc0cHpOQVQwTyt1WGxR?=
 =?utf-8?B?U3pVSHRHQkVDY0xSbHlETWc3N3NUSU5nMUowWmcwYXhiemcrb2oyV3hLYm05?=
 =?utf-8?B?S3VJVkpRellrZnY2a2lJU2t2Rnl6WC8ya1JVMlRQQnAwOEJJNG9wOG45a3Fx?=
 =?utf-8?B?bXZZZkVxT1JVdU9KYnFoczJRb1RwbXI2bGhWUE0zZWVHd2RuVkpxRkNudnJt?=
 =?utf-8?B?Qm1GdFdOUzB2U21LaUJTWStwSWF6bjQrWEpnVDAwWTRSaW52OFZ5S3UvazdP?=
 =?utf-8?B?VVVNNlVPMzRZSjlYV3l5Y1pubmtyWEdrN0RlaE1vZDBOUmZlbzQwWWd2U01h?=
 =?utf-8?B?YS83WHZ0cVR3bm5ZMitwckpyTkJmZGUya3VWUWdJelM1UUQwNUkra0tPMUdG?=
 =?utf-8?Q?DopV+qm+xv89hX3DpIGsFyI4YrRlEsUfq/cB2d7AEG4Hm?=
X-MS-Exchange-AntiSpam-MessageData-1: P05vePaUKgQbpw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857ed859-a0f2-45d4-c522-08deb4ec6b27
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:47:43.7782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLXaMpDZAqkjIia4RE5b0Xv1pD3EhHs5jGcKiKL0pS/UmfmnsbVfRN67TkFZgniBizLV+uPmSbHvWjBdOOW5Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6943
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-8962-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 1DD5056F3FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:00 AM JST, Danilo Krummrich wrote:
> Implement Sync for Device<Bound> in addition to Device<Normal>.
>
> Device<Bound> uses the same underlying struct usb_device as
> Device<Normal>; Bound is a zero-sized type-state marker that does not
> affect thread safety.
>
> This is needed for drivers to store &'bound usb::Device<Bound> in their
> private data while remaining Send.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

