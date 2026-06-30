Return-Path: <linux-pwm+bounces-9487-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dLtTAjbBQ2rKggoAu9opvQ
	(envelope-from <linux-pwm+bounces-9487-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 15:14:30 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B53686E4B1D
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 15:14:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=Ti0V+rKy;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9487-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9487-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2F9313009CC0
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jun 2026 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BABE41167B;
	Tue, 30 Jun 2026 13:07:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021098.outbound.protection.outlook.com [52.101.100.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084F7411696;
	Tue, 30 Jun 2026 13:07:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782824846; cv=fail; b=YnEWGC6TlxhU6KZYvFEQTqtvU1k6qlDmd7Mq//7VeBJq/WfuWXZcwPYiqKsHkKXXSdOMUsYrB5ynQqrkXLejZh7zv85FQNtCDb4mxEdyJNDhHWJvvgbodXKX6GR+Rg/zeQdvghmyTmltqnFSq9bNdDKlgfNl+z9VG35R7H94KMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782824846; c=relaxed/simple;
	bh=fpxD1xudezDWU+OJwGnYjVdmKtgdPAd7Sp74OWo2NwU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=AW6ths1atprCSQViZ3u2jS1QZrwW/xDPAebIghjugKmAC1u8JuxTydBx5H+nI1xaRSmaR/+CDCaYARb8a3VTBkvjkUMYjEpYoElcGJET1yfD83YfRoyramYjHHltF5Fh+Epnz9k4dhrp+f0pcrFNHmhQSckCHzN/QYHdszITIOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Ti0V+rKy; arc=fail smtp.client-ip=52.101.100.98
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b/aUQUFMzZweSS97ybWDN3yo66jkt9bOxxZWzMDPCj6xB8Q3iAuP3w6zgUpZKZWgE1RhC9ZctiSgMP8JlauOekJIZd1CR7BPDv2ApH0ASUV665REayaLBMec1ysOzvowNB4Ma4xpBwzdtEsZowAHTFpC6nnk7+D8N1/QVXArF8+QNcjQPYjmMp84xn8LyIalT9PwC0r9Am1o0E0TFeLZyjBQNSOGh7hGbbtWJQkf8iyYHc5PoD/96vcS4SBT48i79RqYutBErPQpdvB4brg/61jVdUSeYjD/wm5M5aSA0VA1Scwjad+S/9tjO9UmkJ+XX5HQO+Ps4Kfi+Pdm4SGUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtgtxN6ylRKrM8TcIusLfonSmrOd+uQxtQ9wNv00PzY=;
 b=xkVkt1kGu+9prGlxHnHeNHMJA1n2qtIN+hq/74LOdfX897FDy0xQtq4aYiYtcQzmBnwyOQrclQdqJJ+oKc/OXuMwBrq6f7jCr6YKTEZRmSxWB9P9kK/8Okhq60alaDT57TZmuBgwiiEiTcWqgut2iQAUrckMlpBUFVq/tGpKiUuR7z1weT3ceaUy7vT915CL+yYCawgoTj5WfVO8Z0fQAtwtTelohJCcY9b1h+Gyr6vIIq1bDdx/LjWj9vtuYh94ztAAx1E0ZMmCCTIV5Nb3VG+dtkNUhd2VK7DucudU89J1hFHSgqpRaM0Md4sYMUuOPfYSEJNNiwbaLsT1JLQobQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtgtxN6ylRKrM8TcIusLfonSmrOd+uQxtQ9wNv00PzY=;
 b=Ti0V+rKyjWU7Nz+BCh6wWNQ9O1jMtdNlCrARRRNkqp6lYrpP4fM9dmByvvedXbz2B5YErfuKZ1Bf33JQRmlsnPp+vDSMbfPgPiPW1Wr1hmLfxn6sWUSDpV0H55JUrD7gE6O/czCpMZWI0Kgi3cYVTNwhKaYfwXa1nJfWNM2POW8=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB2012.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:10f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 13:07:21 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 13:07:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 14:07:20 +0100
Message-Id: <DJMENSZPCTMJ.3DHZ5965TY6V0@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Abdiel
 Janulgue" <abdiel.janulgue@gmail.com>, "Robin Murphy"
 <robin.murphy@arm.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Michal
 Wilczynski" <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-pwm@vger.kernel.org>, "Laura Nao"
 <laura.nao@collabora.com>
Subject: Re: [PATCH v5 00/20] rust: I/O type generalization and projection
From: "Gary Guo" <gary@garyguo.net>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Gary Guo"
 <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <DJL2T5XDC53F.3C2QC5L1V2H6@kernel.org>
 <DJLLHI7FIYM0.2YB1QJ6TB8R6T@garyguo.net>
 <CANiq72==81FEfMxTnUCdrFBtj9fnCnhF6jXgx_eqE-VsLgW9Rw@mail.gmail.com>
In-Reply-To: <CANiq72==81FEfMxTnUCdrFBtj9fnCnhF6jXgx_eqE-VsLgW9Rw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0585.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::19) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB2012:EE_
X-MS-Office365-Filtering-Correlation-Id: 174bbf29-2f4b-4b99-2e35-08ded6a8851c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|23010399003|18002099003|22082099003|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	8gZfuKXANet/+peTLYXe8i/5ODXNMokOk6SX63kHoxFNXNyb0tG+TK4v6f/+YsrfUEbS9tj4qo6blxdjaP7JlydE5MAp9ycxUKfULt5tFTllk5n2N7Gf9EEjLxg+lzS+nQ5bhJjGQsEqhPOhKXdphe8RyEYXFEJ9fg7jHMBEKXdyoM/rqu41zWt6TxMz87zKQeLRYXr3cSf9DsPM5Jz3HGpkLSCArNuaRb6C7LDATx0UkOdINkvWpp/kZMFean3YH3r9IMJZAc1AH8xpqWex5vtnbaWnDS13EEUxnrndJjlKJmWL3LbM+wReiQSLu7n98jOX9AryFnHvtkC2xDLoUy64uIPox5e+IvpBKAeSoaQfuRup0rjEdPgMyCeHIAS54LmycIrpv2h+ceTYkMeBoI147zXDfT2WlcEyzXbqQmUEPZWbvmXGFtewDGRw81MC6ncbhNgBzEFG9n6CjnfkanIrvE95CeZAphDycK+BfQE8EbKQ4U5YAvAqbhb/+6+kve9cMBCaB655XMBCSLbWmvJsHyJRrAdfSYlqfqbJMu0BFJ2jmZhizKedbX2RZZQCrbpqieqQ8Ck/QDwIJFxJ0mQeNOoxyN1Yiyvxq1K0XVSfx0dg4nMDjuocctAr99+YmbNhz9gUCV/kXOF/pPAzUeIjEMByrrjOXDBkOz6xdcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlBVUEZvNmdkZ01GaUFGV292UUpDZWUzRTlMSGVBNkliblBsVHdWYncwZUtq?=
 =?utf-8?B?MXJrWExWdWhqbUxSZFYvNHg3N3lhWTlhWUllalhJZ2RpcGZvWXZxdThHMmRM?=
 =?utf-8?B?bzdxaG54ZjZQOGxHMnZnbkplZzV6NnMxNlgzVEtrc2xVcmNUbGJRSmEyZGlj?=
 =?utf-8?B?OGwzZmpwTWErNDk1TlhDeUdyS2FXemZMYldYaHB0TmcveFpSTmZCLzlJTW54?=
 =?utf-8?B?eXl4blhYR3IwRjM2MVEyc3k3ZFk0eWo0Mi9uUXB0YVVFcWtXbU1JdEZkTjhu?=
 =?utf-8?B?ZGh2K3prYStiazFUdVROL3NiRmpnSXYxZUUwY3hIV1FFbENaVEZpZSt3OC9R?=
 =?utf-8?B?N2pGQWRYYW92MmdMcjFYNkZCSXBabUJSQ2tPNTEvbDhFUnY5VGtzYWhuTzVn?=
 =?utf-8?B?RXoxbDVnR1ZkNTRzbmdqeURGNkw4QklNVDdyNFJqS0R5Z1JQbFhqOUtSVnlH?=
 =?utf-8?B?WmttWnlHdUVlVkhiQkVqdkZldVJ3QlBRbWNRT1pNRG01a3FZUjY0QWtzTlFP?=
 =?utf-8?B?dTI1WkhoMHp3QXRjY1FiTjRTdHVVKysrQ05OY2ZueTROZHByQys3akYzWm50?=
 =?utf-8?B?eHBpcGRxYk1hSWpTQUtwRjl0RVNOZnNsL2xCSzVNbTExMzNOeUUxaldDbk9o?=
 =?utf-8?B?VFZSNVFzOVpHaHExVjQ0bzg2SWI5NEJmQkJaN3h6ZHVSOXF4VFBmNzAzZkRS?=
 =?utf-8?B?Mk5KKzhVd0ZFVFRRUHFJZWFlL0t3ei96cG5QZG90c3Y5OXE5NXdTNDJLcE5D?=
 =?utf-8?B?SWl2d1pmeHFZcjlpT1drbFJIUVJIVlRhQjlnUUpjTEZ5bmlFQzA1WjNiQ1FZ?=
 =?utf-8?B?SzVtbUxIZUhLclJHaTljeGV1MVJFYmdLRUFzd2lSMGdhYlQ4MFUxd2ZaUXVh?=
 =?utf-8?B?REthTE5tVmJEWW9jTlJ0ckx0QW0yQ0ZCUWdNajhDN29rT0VLY3BiZmJxNVY4?=
 =?utf-8?B?M0gxQ2RYRXM1ZXR1RHRSZVovSXFjWkIxencxMGdFeG8zRUVjcVlEOEFwWmI5?=
 =?utf-8?B?L1dSZ29waklJc2FXcXpZR0Z5OVdVeFRlQktkNEg2MXhaRWQvWE1SdVZyWXRp?=
 =?utf-8?B?dStrRVIwR3hQU05lWVRSTXk2cE9oQloyUWVVUGVaYUZicHNnVE5uVi9RRjMv?=
 =?utf-8?B?ZkM2d0dDbzN3OGthYXdMdWpSYWNLRGdhMFJGdi9FZTFYa1dpV0NUdmZXbDho?=
 =?utf-8?B?RlFwMUVYcFlyUHVKQ1dRMm1veWl1TElocUFMKzc0Nm9xV1RLRlBlN0J6aGVw?=
 =?utf-8?B?aVBDckFmNzRMWGx4N2VuVFdyUFRZN1NnbjMybWdtbmRydWJnTHFpa2JTNGVO?=
 =?utf-8?B?amZoT3RNa3lRWEMxQllCbmhxTVgxeHJTc1B2RTI5b0pJanRnRk1BdUNsOVJ3?=
 =?utf-8?B?cnhnRk10WmJjNXRVcG9ZSHJ2Q3VUaktRRnJaSHZMM0hPOUUzYVoyVjZTalA1?=
 =?utf-8?B?dVZiTENIdU92Sk0zV0xUM0FRM0Z6QzZESWZlT2t2Q0hwbnRQaTV5bjZwcW1h?=
 =?utf-8?B?K0lrRFZsSE4rSjZiVlA5WklEYkcrZXJBakd1ZTJiSGlyWU9nQ21RaGUzUkJq?=
 =?utf-8?B?ZDAyY05MMFZWT2xSMkJGQzh2MnlTckVZeFF4SHMrVytKZGJVbTdwc2VMbVhj?=
 =?utf-8?B?MEFKNEU5MFYyQmNhdHU2Zm9aSk0xdGVLdTdrWjkxOVNIc3I3ODFkUnBRWE1Z?=
 =?utf-8?B?SVZOcXBRcUVGWG0wZmUrZlB5cElCV3dsVzR6M3FkWkt0NXIrT0FjWHI1alJ6?=
 =?utf-8?B?WWVBMlJxZTVia2ZNaDNiSnJlTHU5a1Zta2FhVTlpTVhnWkloUVlzaUJ6OTJV?=
 =?utf-8?B?dHh4TFFPTFVCeEtGdVdNWDBHbFFNUWh6bnZjTFhqVEsvUHQ1bkh3ZFlHRjkw?=
 =?utf-8?B?NmlNNlQ2QllaT1hWYTZtRm5UcjJtQXdZOVJjQnNXNlVnQnJETWR0RHp5NkFC?=
 =?utf-8?B?ZGhKZTBhT3dqbkJNbVNNVUtiZmVSSXRRcE1vc2E2Z1NadWF6eUF0a0tCME4v?=
 =?utf-8?B?bCttSnRNcll4cmRiMXpyUE1wUEF5aWJMdm5jM1h0akt1MWNSV3pCcDZ4U1hZ?=
 =?utf-8?B?c3RjcU1XZmRsSXZUdXlETXU4QTNLVnF4bmtaMlZuWGd1NWdIY2tQeGtLWGxs?=
 =?utf-8?B?MUZHUGVpZ3NLS1RvbDlNOGJBY05ZN05JT1B4STdIREd6TXpHN090dDhvRSt2?=
 =?utf-8?B?RFJ2cENSUFhOV0llWXdVaGtPUEUxQU1xODZFeUlTZlJaT3Q5c0V3VTlzNWxU?=
 =?utf-8?B?VU91OHJVbmJxdFFOTXJ2SUVrKzhldXkwajlFT0pIMW9RQjBrY0cyaGhJT2pL?=
 =?utf-8?B?cDdwbGdNWnpmMGs4VHcvYnNySEptTjRnTVp2Z3hjV252MkQvOUNYUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 174bbf29-2f4b-4b99-2e35-08ded6a8851c
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 13:07:21.0062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y44GwmQkSwxa+aTxzs8avPKyNX3dLfRcX7+WfvZj2cHqEt+5B0AVKxuPs6ss6bzYxhY7hV53f3dQD667fYTDrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB2012
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9487-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,garyguo.net];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:laura.nao@collabora.com,m:miguel.ojeda.sandonis@gmail.com,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,m:miguelojedasandonis@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,collabora.com,linuxfoundation.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B53686E4B1D

On Tue Jun 30, 2026 at 2:02 PM BST, Miguel Ojeda wrote:
> On Mon, Jun 29, 2026 at 4:15=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote=
:
>>
>> Hmm, this looks like a false positive introduced in new version of rustd=
oc.
>> I didn't get this with rustdoc 1.85, but do get it in latest rustc, howe=
ver the
>> generated link is correct despite the warning.
>>
>> This pattern is used by other code, I'm unsure why it doesn't trigger th=
ere.
>> Anyhow, the following diff seems to be able to work around the issue.
>
> It seems to me that the issue is this line at the end:
>
>   /// [`include/linux/iosys-map.h`](srctree/include/linux/iosys-map.h)
>
> should have been:
>
>   /// [`include/linux/iosys-map.h`]: srctree/include/linux/iosys-map.h
>
> i.e. not a false positive.

Oh you are right. I checked multiple times but didn't spot it.

Best,
Gary

