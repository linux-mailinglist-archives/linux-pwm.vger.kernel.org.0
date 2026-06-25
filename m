Return-Path: <linux-pwm+bounces-9384-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VSwcIEctPWoJyggAu9opvQ
	(envelope-from <linux-pwm+bounces-9384-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 15:29:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA96C6232
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 15:29:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=vrJMjOhI;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9384-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9384-lists+linux-pwm=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=garyguo.net;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1A6C3035277
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jun 2026 13:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0BC32E121;
	Thu, 25 Jun 2026 13:29:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020127.outbound.protection.outlook.com [52.101.196.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC74326924;
	Thu, 25 Jun 2026 13:29:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394169; cv=fail; b=X17T7gp1wsB5VrkGaFk3rDdrCjeskqzmk0ASrtz07QxNOXoy9V2/ZBW6KCYQOByWfC0SW9KKQuCBsk8XNozbPWkX8orThIkJnzXgZ6XBNMR0/GKnPMdt0btqQiuS1iEMFPwEPP0a7nD3l7Ax69RMT+6VGYO3YMj6iyisB6qONiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394169; c=relaxed/simple;
	bh=3dTnN5IqitHlTGSUB8HWkk4ZtUG7p0XG6FKkd5tF+k8=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=ucx1QhNZWmy7h4h6QB9XltBoP3zjq9J9PWsSXzUgyJfyyg4Xn7BPk/adx3/5weCAg1WsZKw8wwJ/GLx0omd5GZEYac9w0dsoJ0W0YN2E6j8T24Lgvtplt+V4HeWUi5xchVhUo1V9Ytl7TFxTbY20c+Rrv6C/Fi65Z2fajGAvL8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=vrJMjOhI; arc=fail smtp.client-ip=52.101.196.127
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDgk/WZrbR37/gBCZSiAibhYa4vqp/AP+nxK+FaIRZ/QYfDfJutVeAsoPtPJYu0DGVCOsNDaq2v6oRHrQ7n3wG8JzwB9Ltq43gz9ZvwVjWOJl1tGyJr3LRZfV+yiEtEXQSUKUedQiSKrRl9UuBZpLFAXPpmabgUmul/YWUAGCAuUk9VeiPqIAFdj10+D9YrNEJHSutSke9aLqYSWmzfkiFENB9GyrL3V61kEnJKDHC7YtK+pUp7t31YQWfM5hGqGrLi25D6pOsrjkIu+/gxgzVwvP5RTiGJ/yhn1KLZGMCSactOVaCFuYSNgq87Ydha3rRI0WezgEVwHLCAdK92AZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0es9qWF0Nh369myl9gu47wQq6hd1/WMrxIePp1qfYhY=;
 b=o1ixDs3vDAoxabA6Ub90+4CzCBxck2vofsHcK3a8QM3m1ySV8gzADxYqETflGAySXGd+maqGJOQfCoPsiwoirQbElIxaaS+uJzlwQfR8KXwU4bQS3Z9pfx2HweT52e3kppvikSxDrlQDxFhbwcatnOL52JK79RsUoNJRHHDH2K5HK+Owvr6gDNXYU0Mq3zJ7jumYCGIwPaSTyaJyktxYDKliIX1/f+p12OF+Tz+RL6Bb2Y/J8z+k76d0WcCmIYqigvwXi1V+FlL97fnr9VMRRfKE4eF6G+LlLxbX0FH5JRkQiWW6Xck1XhtVgSofAt6zXuM0yd2TaW7dHNbJnea1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0es9qWF0Nh369myl9gu47wQq6hd1/WMrxIePp1qfYhY=;
 b=vrJMjOhIE5WGn0ivukwwMlyS4cm0iCzqC9Lxa7cFi6kOqbA7jIq9o+/JWGiUENbm8TNfT3JXAPzfqQt3R5nyIvewkT3/a0KCbKVX98diSb6gkDo8xpzJs8w/5gheYjNOwHDb03eQiHeNHDSBDJYRBSOHBhBQ/p5+/fZtUylCSHQ=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3056.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:17b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 13:29:23 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 13:29:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 14:29:22 +0100
Message-Id: <DJI5ZY2TPFSW.BEKOVZYRSTQZ@garyguo.net>
Subject: Re: [PATCH v18 3/8] rust: implement `ForeignOwnable` for `Owned`
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Lyude Paul" <lyude@redhat.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Christian Brauner"
 <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Ira Weiny" <ira.weiny@intel.com>, "Leon Romanovsky" <leon@kernel.org>,
 "Paul Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 "Igor Korotin" <igor.korotin@linux.dev>, "Viresh Kumar"
 <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Pavel
 Tikhomirov" <ptikhomirov@virtuozzo.com>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>
Cc: "Philipp Stanner" <phasta@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <driver-core@lists.linux.dev>, <linux-block@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-pwm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
 <20260625-unique-ref-v18-3-4e06b5896d47@kernel.org>
In-Reply-To: <20260625-unique-ref-v18-3-4e06b5896d47@kernel.org>
X-ClientProxiedBy: LO4P302CA0044.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3056:EE_
X-MS-Office365-Filtering-Correlation-Id: 0856a34d-cd95-4a01-c4ff-08ded2bdc4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10070799003|921020|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8LKznPTof3iVNHmP3pXSHcaUIimErZZWEGHLEfHyFR5+ov7q7GiOx3EerIZJjFd5d7Gwf5i39WIO5F91zXasIcxDKvM86dvryOhmlr42eq2LneL3TFW2ncB7iFBe3ZfKcgts3vhsQqJIjdn0/OrVcbDnvtyMovlnyFg6T3LOiQ9ed7s+ZWKuJzQnfJ7ZkjEFvAPNRyTrjNkUvWYiueicko+pFZKKXdL3fGCLFIVv4FakupZWPqFXOhoABifUrIQ/ZzbmlXwknj9qoO2DOYrQl0OQ0pa4y+oOstu46gAMgLY/E9ro2RaJE90dryyXMGDqTxFuk8vuRgjQFJ8jguZ2y0Hm4uhqsm9goETir5nj3yu4N3EvCsZtM9KmcJ7v6YJhULW80yPITLkd6cDeYtOZ3Ejh3ddnDvB25Fiv4zU7xVV2OH+CbQMuhYme5P+EOxXlQE0Gcrcj5YHQ6AOcoLDF1tnF6tLK3YIbEaKGQLBmPIbRsxTsiRRPh/Y13wLFRNaDjMaktgqCk+Kj8eFO4SvEZczAxgdMXdlU2/qyFO5cvj5FXuCf7riZA9tM+sUS1iJg5Ebdrg0s9qd1zXdwoHsarmewP7pFxQ1yuoQju2HXnb3ott+puBDW77etV6nx/qsyDW+djyzYYEyWzh2FiWI8YemE+P8lZ86crOu0581ieWlSaQdcusWzfOnqTt58RS53bG4xXzcy3BXYXoGdQJWfSg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10070799003)(921020)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDg5VGs5bWdjei9HNC9pSkxXdXVSNXNra0Z0ekNPbmtRTUR1WUJRVGNsQ0tp?=
 =?utf-8?B?bXhLYm42UWpockU0RjMvaXU0aXdwTVYxZDRtU0YycnZON0dKMDFzVDRKQ1N6?=
 =?utf-8?B?QVNJbmRiY09yRDNLSmtQU3ZiS09pMmU2NUNWS0lTTmlGKzAwOHBlcjUwalVM?=
 =?utf-8?B?MlhlcmVsMTdEbTB6RzY5NFI3TVYwQVRaMGNZZ2NZSjQ3KzM2bXBId0NWTzM1?=
 =?utf-8?B?UDNGeld1VGhjN3NNWUlEVUlBdjhTZW5SRTAxSGlnbEZFY2laVHM4RkdoWkp1?=
 =?utf-8?B?U0RQcXFmR1RkYm50Rk9Oa2ZwWGZxZHBMZlJhZ0hyUjkzNHorbEpnamp0VnFB?=
 =?utf-8?B?TlFwalp1NHBGa09vR3kxTm05U21vWEkraDNuQURoRmt4MHVlemFjYWU3T2Jm?=
 =?utf-8?B?MHFNVi9icS93SDJnMmdIMjRFWG4zRkN0eWNSMlpLdXhxdEVNbDZaZ0dJK2FT?=
 =?utf-8?B?dDVvQ0pWV1VWcktGLzJaZzBjWjZnYTNpSkxMTStDWWFWbmdOUW1ORTVUSVpm?=
 =?utf-8?B?Tit4SGVQZTdaRkFYcTkyZkdISms0YzUxNDJySGY0ZHgxUlg3UUhVcWxzZVZU?=
 =?utf-8?B?cFhIMzIrSzlubnQ1d1ZaNHEycjMxZ1JSZG8ycVIrcms1RjgxTGhVTkRSeXVa?=
 =?utf-8?B?Z2J4NGpIem9rUlNZNWNQbmZSVTdDNDJEZ2I5YjJyQXBiVldRaWNObkQ0TUl0?=
 =?utf-8?B?QVhoazN3TUx4MzUwWmdHMmsxZHFWQ29weWFkd0dYQzJaU1lnZHNhdmJ6Sndy?=
 =?utf-8?B?TzBWYXFvSklnbVpwYVk4WS9Ld3Q3NWZlT0dCUFJhU0JBRitld0F2Rk1tamdT?=
 =?utf-8?B?S084V1pKeTQxNTQxZnFLL0lrd2xOWDZsQ1czbVNhMXhkR3JBcEx3WTBoQlI3?=
 =?utf-8?B?bWg1ZlVmbnMyZ2VJU0VJaFZhTjdlL0lLVjlqbHlFSk8zOTFqZlhHdEZCRHph?=
 =?utf-8?B?ak01VW5VeW9yUXBYNWZSbmo2dmU5TDJIVUVOeXk1WDhyN3dSSXo3Wk1VSVpD?=
 =?utf-8?B?WDMycEFyandlVmh5L3crLzZERHZoZVJPZWZIR045TWtGNnoxVHlOTmFYQSs1?=
 =?utf-8?B?M2psV3ZDa3RtS3dEUUtaUUI3RzRXN0oyN0N4bXN5VEJUWXVyTDZjWVZjSWRU?=
 =?utf-8?B?Uk1rMjNMRlFlU2Q5bTR3QUdobnlKd0RMdVJ6eDhraXJNMTFVUkxxSEJQMXN4?=
 =?utf-8?B?c241cWljd0s3ZVNOQ0w0QndlakEySXFlQVUrNUIvYWwxV2d1MW9sbWhSS2xS?=
 =?utf-8?B?WWZjTmNOUnRmOEFtZlFiYWUzNndKRGc3QTg1MkJqQzBWWFBsWHJHSlBlYkdX?=
 =?utf-8?B?aUNOUFdqYTNEZWZzTEJVTmpOYnpNN2RGOTA1cDlZWTZVUnBsd3MveDBEYjVu?=
 =?utf-8?B?K0NmYXYwSmpMbFRLQXA2akpyaTB6TUhaVmNXaTE0anVwbzZKZ2tSVS9YTU81?=
 =?utf-8?B?WWhzbnk4N1JWQit0OVp1T3dHWFVONTIxWEtoOXhWb0Q4RGJqb1FZdnNoM1pM?=
 =?utf-8?B?UUR6QnUyRW8xT1hmeitGOGFZRGUxUW1BZU9tODhxVDNNSlZ6QnltVy9xNWx4?=
 =?utf-8?B?NmM0bXJJNlpZZnVsc05JM0Q1VVp0WExFeGR3dXc3NlIwWEtyTFVaTnRJc3ox?=
 =?utf-8?B?UEZnTGFseS8zazRSOHYxVlhVbytxL3ZxREJ2Z1dSYXJTRCs5WUZyZzQwMGpo?=
 =?utf-8?B?T2ZsMTFHTFdvL01uYXZRTGVlUXphSTBqQnA3bjBnTDYwZG1oTnJldWVocTlh?=
 =?utf-8?B?cmR0SEFWaUVxSzFpZ1JsYmlCMWx1aFJzOVhycU9UVnYxRGNIRHQzaFEwSVNT?=
 =?utf-8?B?QjY1L2cvSTViZEZ6dWhDcWRJNU5TUUZXZ2FBOUFUNGtLaCt0Z3RsRVZINko4?=
 =?utf-8?B?QjB6V29pdEZCT1hVc1YzTmpLeGx2NHliY1Y4Z2pVTU5aSzJsYm8wUUNHUzdK?=
 =?utf-8?B?SnNVV3Q5dzFRZ2N2NmZPMkFVKzFSZTRINHNCWURWSjY1ZlQ5RmVUdVg4S3NT?=
 =?utf-8?B?bHczNDlIUVZRNTcyeGNRbGg1bXBFNEpKRjlpVnA1WjFYZDRDaVhTVnROR3Bh?=
 =?utf-8?B?SkJqWGVrNG5aRFZjVFhGUCtVTllIckdaZThFSTBUQnIzT2RlbWEwTU9RL25G?=
 =?utf-8?B?NklkYUk3eXQ5U0RDTjBzTEcrbVJnSUxWLzE1MVppNDRTbEJOZ1dLSGlUSE1r?=
 =?utf-8?B?NHJVZFAraHg5YWZZWmdZdGNZb21Nc1hrTkt1ZEMzQ3Q1WmtQaXFwUmYzQkhN?=
 =?utf-8?B?VHNXcVpwOXd6WVVXVi91Vlpjd3M5dExxdHJUOWFlQkNpQnBtS2ErK0NRaElz?=
 =?utf-8?B?YVdvTHRCR1RiamJaS2FOTHlMMUxaV3pJYUpuWXZWRVlpYVQ3dEQwZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0856a34d-cd95-4a01-c4ff-08ded2bdc4f2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 13:29:22.9473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86WHaphtrbszSh2qs/CpBttGq4piGrJ0Sum2KFkMnXDqilF4w1V6BMKrXI6YksCIYgDUkbnLok65/SBzWkjhKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3056
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9384-lists,linux-pwm=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:a.hindborg@kernel.org,m:dakr@kernel.org,m:ljs@kernel.org,m:vbabka@kernel.org,m:liam@infradead.org,m:urezki@gmail.com,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:gregkh@linuxfoundation.org,m:arve@android.com,m:tkjos@android.com,m:brauner@kernel.org,m:cmllamas@google.com,m:rafael@kernel.org,m:david.m.ertman@intel.com,m:ira.weiny@intel.com,m:leon@kernel.org,m:paul@paul-moore.com,m:sergeh@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:viro@zeniv.linux.org.uk,m:jack@suse.cz,m:igor.korotin@linux.dev,m:vireshk@kernel.org,m:nm@ti.com,m:sboyd@kernel.org,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:ptikhomirov@virtuozzo.com,m:m.wilczynski@samsung.com,m:phasta@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@k
 vack.org,m:driver-core@lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:dri-devel@lists.freedesktop.org,m:linux-fsdevel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-pwm@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,infradead.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,linuxfoundation.org,android.com,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,linux.dev,ti.com,virtuozzo.com,samsung.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[53];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,garyguo.net:dkim,garyguo.net:email,garyguo.net:mid,garyguo.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 19DA96C6232

On Thu Jun 25, 2026 at 11:15 AM BST, Andreas Hindborg wrote:
> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` =
in
> places such as the `XArray`.
>
> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` =
to
> implement `ForeignOwnable`.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/owned.rs | 53 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> index 7fe9ec3e55126..9c92d4a83cc1b 100644
> --- a/rust/kernel/owned.rs
> +++ b/rust/kernel/owned.rs
> @@ -15,6 +15,8 @@
>      ptr::NonNull, //
>  };
> =20
> +use kernel::types::ForeignOwnable;
> +
>  /// Types that specify their own way of performing allocation and destru=
ction. Typically, this trait
>  /// is implemented on types from the C side.
>  ///
> @@ -186,3 +188,54 @@ fn drop(&mut self) {
>          unsafe { T::release(self.ptr) };
>      }
>  }
> +
> +// SAFETY: We derive the pointer to `T` from a valid `T`, so the returne=
d
> +// pointer satisfy alignment requirements of `T`.
> +unsafe impl<T: Ownable> ForeignOwnable for Owned<T> {
> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<T>();
> +
> +    type Borrowed<'a>
> +        =3D &'a T
> +    where
> +        Self: 'a;
> +    type BorrowedMut<'a>
> +        =3D Pin<&'a mut T>
> +    where
> +        Self: 'a;
> +
> +    #[inline]
> +    fn into_foreign(self) -> *mut kernel::ffi::c_void {
> +        let ptr =3D self.ptr.as_ptr().cast();
> +        core::mem::forget(self);
> +        ptr

I think the pattern in `into_raw` is better:

    ManuallyDrop::new(self).ptr.as_ptr().cast()

Or perhaps this can just use `Self::into_raw(self).as_ptr().cast()`.

> +    }
> +
> +    #[inline]
> +    unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
> +        // INVARIANT: By the function safety contract, `ptr` was returne=
d by `into_foreign`, which
> +        // gave up exclusive ownership of a valid, pinned `T`; we retake=
 that ownership here.
> +        Self {
> +            // SAFETY: By function safety contract, `ptr` came from
> +            // `into_foreign` and cannot be null.
> +            ptr: unsafe { NonNull::new_unchecked(ptr.cast()) },
> +        }
> +    }

Same here, could be using `Self::from_raw`.

However, the current code looks correct to me regardless, so:

Reviewed-by: Gary Guo <gary@garyguo.net>

Best,
Gary

> +
> +    #[inline]
> +    unsafe fn borrow<'a>(ptr: *mut kernel::ffi::c_void) -> Self::Borrowe=
d<'a> {
> +        // SAFETY: By function safety requirements, `ptr` is valid for u=
se as a
> +        // reference for `'a`.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    #[inline]
> +    unsafe fn borrow_mut<'a>(ptr: *mut kernel::ffi::c_void) -> Self::Bor=
rowedMut<'a> {
> +        // SAFETY: By function safety requirements, `ptr` is valid for u=
se as a
> +        // unique reference for `'a`.
> +        let inner =3D unsafe { &mut *ptr.cast() };
> +
> +        // SAFETY: We never move out of inner, and we do not hand out mu=
table
> +        // references when `T: !Unpin`.
> +        unsafe { Pin::new_unchecked(inner) }
> +    }
> +}



