Return-Path: <linux-pwm+bounces-9017-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6B4mLXpfDGpXggUAu9opvQ
	(envelope-from <linux-pwm+bounces-9017-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 15:02:50 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D1757F3AA
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 15:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF35C303E499
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 13:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB82B4EA374;
	Tue, 19 May 2026 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="mU3Q6/CO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021092.outbound.protection.outlook.com [52.101.100.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E334EA36F;
	Tue, 19 May 2026 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195718; cv=fail; b=cndHMGPD9ebr/DtYkEiyP7GR0GbQVJCK/5Dw+yvbO9L9SsZwi9DPxYN6p1Yrfcn85FA3xxmleOCP7x3r557YK9zEvPMFzVaJzkOpzAhrsU2+bPRlv8gvGrbbuufFouZBRcPHEws+Lo6OEdhgAfMdrcVvTin9OFjzZyzPmuEnnmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195718; c=relaxed/simple;
	bh=KxclcZHe5CL/FKgpoP0vKj4MsuMwuiGr0BrTFspgO78=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=B509RdbCSqC9VdFiTfq89wHo9mmiyIID40nJXmHekUAjk4x8R1lpcT2SpLGoWZX3DNT95e1/LDScPbx61QctNgh18UPRFMDcMn93Kuzxbkn0dB5LeH/RRCdUuQ86crP9UQrG2Dz1nDVGxCo4vE4ZJkGXoJRh2FbgRRvEMGeCHMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=mU3Q6/CO; arc=fail smtp.client-ip=52.101.100.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMp6y4w8Be/gH/SgYPZ9Nfs40e3FjGDqVy3qCfeVqtr5qOCqWrQYJeOvzfD4Je3Fx+CVawGipWxiUn7u3ueJu4/S4gRaRgpyL/wJ1Srugy6lolA514vmiqRb/4zoEIEeBVj+hCVbRP6Jx7UgzS6CzqPUDYFgF64oJvKBfzrOfq3407wDEhq1/AyL9mrJiHFGdHNZMWvoeqmcaKUro3BCmiis+LauJdotZ92oisLx4y3DoarfK9AZ7IOrTrTh1Jp1OpYTiYmogkc69eqMRdo7EpVA5wWUFZ2jbUTmEkf01BJ0AyEuDKnZr2drCzRy3Z4W9Y798IU+0/UFw1M+QAXP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TL7U2gwnWqWibqAhvK+uUYFChMcBxuAZxhYaTv9092Q=;
 b=KPwWhq5SyPbgJJctGfq9Zw6QGv+wPHdZ8NtnhLXTK9AlqsbMLL+TIvvsHymwu5lkYY4jk7t5JIgRCHn6Xar27+CzQG7G04V+5hx2e+oeY8kTFKUEOOENZAgv3Z5dxQX6E9qVqV1e2C6aZTeS5CfyPxXaMnrqZtshJSPB7DCCL+PqisIHwu5nLcFSVi0BLm9mmpFd7pTOPEnSdjTL094WBPonzVv/4dKjPGcfma99iVRG+VdpsLvg6G1leBg1iHPhOLuSDfU6q/uKco14xuzPHKSKiT+nwafA6y8Vjv7RCTSx/U5w4CNZuR9/lD4BQEKJSAZ1ZdRjCjgmv4rn63j8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TL7U2gwnWqWibqAhvK+uUYFChMcBxuAZxhYaTv9092Q=;
 b=mU3Q6/COj5BnKzxvMz2iSSsgJNawz6FbGFGJUAE+Fha0W5uVm/xm0Iouo11DipWp4he0U5daAwlM+IqCw8zW7w3rVPdZE9cKoC/vLzJ6ctGrlQRXktAO0bbGT7tQTBoQt3D7WrCkzvVEjSaM67iIUJqzcW1/uTiLEbSBqTjMpbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO3P265MB1961.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 13:01:55 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 13:01:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 14:01:54 +0100
Message-Id: <DIMO8RN0EFP0.337REQMQ7VW9D@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 06/27] rust: platform: implement Sync for
 Device<Bound>
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-7-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-7-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0379.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO3P265MB1961:EE_
X-MS-Office365-Filtering-Correlation-Id: c01ce6f7-03b2-402d-6d59-08deb5a6cd8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|22082099003|18002099003|56012099003|921020|4143699003;
X-Microsoft-Antispam-Message-Info:
	NjCvr3sIVNbLBtA8WL7KVGkgMAFsIbq7KnZQybkcH5Uyl2n6l1x20beEOUzZvH287J4rXMSLwXk4L14Pl+uHitSr4reJ1+vyjaEROYmqPSYa+tal4umknV3r4SpgS90fbbF4E2+y8pAK88Jh0MfaOUhx++AlUIXw2rGjiMApdqAZnpZ5vxbvx6vJYtISWGg7xz41XXBqNkBEiaKwQWsRaMc49zM1xqYcS5MqSAsh5Lk6VSRcpJHmOqCjZV9yu+3WbfI0kzN3ZnuYswdu+ltUFdZMzkKsF0aGkSNws0bwN7KpeHfpRr6FXXyc98n2jUloylE1M3sc40DdPt9jGLARfAj1NCSZc6J8NDevR9dl2GkwRNYM0Y2tJ5J6xwBFDtreWMmE/66300sJSUHSWmAyzP8LuqP1SDQL/pTcBHn4fbWpZxzSLa1njBAHvENTxnh64hMILetGbNuvRHLQkz815GWhldKm0IEiSO5+Ue/nAqi9W2E9ox589w4b9qeHp3JVq80XT0dYS6wDYOMVAvmwBU304HlK0ke9v6frnsLrhOSADPHcA01Ut6mo8aNBhkmxVkT7UphaMeBxy5m65WHK8xxeJAneBl6m8TsfzgHc1KqKdYm2X0PP4Q5y9fGqPkBNv3GH88KEBo02+Azsq7V3zwWSs9mgzyH3T8YIkU/Q1xy9X1iZCSmjG/xWpPEjMqxqNUExvgRtvnfKzB5GVZ+1Ov3DOu5N2Bw2RnU25IVTuTY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099003)(921020)(4143699003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWJzWXZIRG15LzEreStYbkxlNHN1ZFVNaG9LNjVOSys2eERBUzk0elR3WWl2?=
 =?utf-8?B?Tjc4ZG9Fa3kzM0xMdDRsVE51YmhsRnZvSkg4YXhsMjcxTHh4aVVpVURXbU03?=
 =?utf-8?B?bis5Q1ZrdjJ2RnovQ3M4b0QrenZrOTFQbjlKYnN3NG02RithV0s5QkJ3LzJG?=
 =?utf-8?B?YSt0ZUlMdU9pVG5zWmpyRGQ0OWc4NzczRi8vaHJibHF2ZVFwd3RIcDc5NkUx?=
 =?utf-8?B?dkljRHRiTENLRnBvY0tlR3I2azkyeWhHbzd5a214Mjh5OXlscnlhdTBNUFls?=
 =?utf-8?B?dHVxbk9QU05JTnF5UWhXZjZ3VGVabWVraWNPSXIraGJ0TGtsVC9JaTRORWxs?=
 =?utf-8?B?dkVLNjhxVnZNNFd0R0I1REZyUnFkcXpWZldnRS85VW5WU1ZXSmhudkR2STBH?=
 =?utf-8?B?aTQ5NytyNGtxZ3Z1bXVTRlBJQ2s2MHY0LzlNNko2eXQveGFwdktMVWwwMWl4?=
 =?utf-8?B?dXpoOGg0Vjh4ZnlZclY5SmxIT05tdXc1ejg0S0ZNZ1JRSUtUcFZBUG9oOE55?=
 =?utf-8?B?Nnl3UXZOSmMwV01VcEpBUVVhdnVzMFQ0cUZSR3hzaGp2WTlWaTY1TDVlRUtm?=
 =?utf-8?B?bXRqK2QwcUNob096cldWMm1mcm1EemJ2Z1RWWXJndThMdmJSUm1CTTd0TW5Y?=
 =?utf-8?B?Y3k4czhaemVhbjI0OEpqSk04Q0dBNXhQZkhVUW1xSzVReUt5M3lKcUpCZytl?=
 =?utf-8?B?VjlkKzBjbmw3UWt2SXc1YzlIalhYaWZjK3NLWnVWS3FSakMyVitkOXdtajFG?=
 =?utf-8?B?bmNQS3E0VE1IdkhFTUhJTDg1VU9pVlk4bGtmemtwTEVpd1RPU1hqRWViMEpD?=
 =?utf-8?B?RzFzckNRd0FJM1QvRVVkcU9wc2RPYXg5R21ieGtycEVpc3lvVXVIbS82QS9M?=
 =?utf-8?B?UzZqb2NBMVVub3JQak5tRWNtVkdhWWJZc1pQWGFvMkw4bm9MVUgrdDBaeXA4?=
 =?utf-8?B?Z09sZHdCVS85emdHa041emtBQWt3cHg2WEo4R1ZUWW03NWV5ZTBXMFpYekVk?=
 =?utf-8?B?VWQraExJTlNTRVU1V1F4OTlud1JhUWJwZjZCdWhpc0h4U2htQkVJODBPYzA4?=
 =?utf-8?B?dFpYazI2cEZiVmx0bGtQQkVyd0ZDRWhwOVJIVVRyS2U3ZFlCRkNaeGdmS1ho?=
 =?utf-8?B?ZVNsaW5wbWtLN1VKU3R0Y3Q2MmFHb3lTcWhHNDJXVE9iM0U4QmZieWdUc3Yr?=
 =?utf-8?B?c0Rnb0RWeXN6ZmFFN2pFOFRYTllMVklVT0lwTGVlZWw2cTNGcGtUck95R09F?=
 =?utf-8?B?ajRkOFFOS1RpRTNMV2RMQ0RPbW9iOWc1NmtQdXdFQWZRT1pMdUQvYVdZMmJH?=
 =?utf-8?B?dzIzWWFyZGY4WlNzQldWWjJZWUJ2enJuaXVta1BibFZDN3RCVmgvdGI4dmJR?=
 =?utf-8?B?d3JleXdiRTR2NVdOc242WStkV3ZkaDY1VWdBZCtSZjJybmFuMSt0OUJBUmZk?=
 =?utf-8?B?UFg2SjhEaW1GV3c0RnB3Y25JMmZLZGduS0dIN3IrYVFqUjhCVUExaEVoamxV?=
 =?utf-8?B?VG5wb2o4dWN3eThGQ01XMGpvOUdzTGRJTDFEd0VrZEwwbWNzOWhMYlM4cE5X?=
 =?utf-8?B?UzhmZWp0bFp6ZURLN0xVN0cvRTFKZFBrNkg1RU9WczgyRFFkQzNHK0VWNFlG?=
 =?utf-8?B?WXpCQTVWK25oN3BEQ2p4VXVUZE5CcUxHSElaZmtsNlpxYTllUUkvRlJzWTZm?=
 =?utf-8?B?bGI2TGY3NVJ5VnRsV0RpeEcxVm9TSUgyTlIzMkY2QWdPcXhYRzhUVElPNFhF?=
 =?utf-8?B?OFpVT20rc3JCeGVPQ2RHdGZ0cFlFU3dpYXlnZ1lXYXJPVkhOSEZZRkVBOTVh?=
 =?utf-8?B?YUwvRXBWTGVnQUIrc0R5VDQzb2VSN0phb3R1K2xidkI4Y28rN0h6VXcwN01z?=
 =?utf-8?B?Q0pXQlNDVzN2UTJLRGhDNmNzUWp5UG56MUJvL0lJQlJOK0xka1VMdURJSWQ3?=
 =?utf-8?B?ZVp5Tk9UYWM0dlAwV0RPa0ZzVndFM2VuQ1lQSGFZMGs4OTZSeVp5T21qaDZm?=
 =?utf-8?B?elQ5NDV1Y1dESkJub0FCaEc0RWV0RDZLL2Z2TWRJMTJjVHdTa25QSDh3bXJu?=
 =?utf-8?B?Y21EU212Qm5HenByZWErSnBvdkV2eUNtVXhuR0NVZmN0MmhpZ2pQVHZMNmgz?=
 =?utf-8?B?ZVNvVGVrdGRnY0ZIL01hZVdMQzQ5aEhNTCtxMmJkalFGMmx4THFBdCtJQlFx?=
 =?utf-8?B?R2hxckZJWDJaaTdGOU1TZFVTMVRWOFFqMktkeTJYNmUwYTVrdDlSRVI2cVB2?=
 =?utf-8?B?N25pK1hJczcxQUtxbTB0dlJONkhtTTA2QURiLzRJVXlEN0E1NDlBRGdKczVS?=
 =?utf-8?B?YW9GOEdZMEhxN2FSQW8yek5vZVVGNnEySlNFQlIxekowaThYRCt6QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c01ce6f7-03b2-402d-6d59-08deb5a6cd8f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 13:01:55.1867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCKfCKGftoFGSdvenKktFW8PxAxyx27D+MHl5CF5XwtfvMzTdAvI5lMoFrvgnCUnRmCS0yLgi07jYLsoOhnQ+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1961
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9017-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: 56D1757F3AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 1:00 AM BST, Danilo Krummrich wrote:
> Implement Sync for Device<Bound> in addition to Device<Normal>.
>=20
> Device<Bound> uses the same underlying struct platform_device as
> Device<Normal>; Bound is a zero-sized type-state marker that does not
> affect thread safety.
>=20
> This is needed for drivers to store &'bound platform::Device<Bound> in
> their private data while remaining Send.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/platform.rs | 4 ++++
>  1 file changed, 4 insertions(+)


