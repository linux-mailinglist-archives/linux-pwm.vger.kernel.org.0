Return-Path: <linux-pwm+bounces-9524-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JjJzMhWxR2phdgAAu9opvQ
	(envelope-from <linux-pwm+bounces-9524-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 14:54:45 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41801702906
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 14:54:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=ON4mu8hc;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9524-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9524-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD561303ED9D
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 12:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF5D34252C;
	Fri,  3 Jul 2026 12:38:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020082.outbound.protection.outlook.com [52.101.196.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49962371056;
	Fri,  3 Jul 2026 12:38:27 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082309; cv=fail; b=U1PQvirTJgefF0fdMtNKgrVYqshl1e5EbdDsf6rdvt1ND3JrD9OtRAq6P4NV4jdtO6xi2XQNCQ2aH8li0Ksk0bo2d3bfIllRP0Eik8ecThH9hzIv91w/q6KdCUkbaQNR71N8jDRk4P//P+tu56SgVT96yCZSLBPLiscO6e55tb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082309; c=relaxed/simple;
	bh=cPpyrgeHs9ZWfL2k1pOesS2DB7LEzMx1tFa0DXLX28Q=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=YlMrV05ZpL3gDhfZknrpywr4LZXY/6TbF3L3F6aXSU/ABU1o5KNA8ZGUuI2BSn+do8ofhcW+SPWDNwfGSCkmEDf/oE7k3ifhu2tRA8dDS236MlLlXr+6wPWYJXKQtLGjC0ttPbZ5ZMn08cBjTDw19PPIJKthFA3TBUqoeseEUTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ON4mu8hc; arc=fail smtp.client-ip=52.101.196.82
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYVTT2OgH7Yuquiwcrh2FmTb9gELplR+TPqi1asXr0/vkR50kE+S3CoTLb3tEVhJBlQ9uJ2AXQJeHwdXc5SH6nTvD2/v6X0qpIwFfNAR7quFtdzRKtbuCGBTvex/eYAP+gEkjOnnkg4qS+o7G84ZMIFOyCWEm/EFLlQLF8ZhBnMxsUIgVtgV67I3vyAn3BxZgm5t7QGK1k5TSmL+eG1yoi1qxOJ350//rddGnMSH9/YWH2wJhRu9kvLN90g4oKXXlOoH+t01US72nPlmykThFls1LCwhcOWckg1zW4Z/fCVRuxJb+CacbSaf9nO65x0b+AxmLFnTYOAZfx4m7gOYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdScHM5ljSn2tPGCXjYYPJgLb7Xc22nSVN6qP15pEhE=;
 b=LeJerEFT66OWnrg/+kMABcZkVp3w42E1ym1ygakPN9WQM4840d+FqtudmmlLSgSwGenV6wA4i9B/ARJg+7whY4s2aggmsPOVnxwfKvTrNYyKZmz3bTPUOLbc5SuGIalg9oAxL3/+U99iQMsEqMyEkY2hQZO0vyXFD4T5auJNXRavJciz1jSj2dfvshm/dVHIMNGArlPb6i/OKDFtx0SqQkrnffcAsLGcZ0hPRpZBtVSgavdJSh+vvb0lnmn5KpwItzZYdey2YcIg3G8Dmd0DJ6BPbfq7Jo+d3T0gOeezrnDvLi6bS4bdtsV2oXLre81sIdSgyhvJRx02Xr19QzVMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdScHM5ljSn2tPGCXjYYPJgLb7Xc22nSVN6qP15pEhE=;
 b=ON4mu8hc/N6A4sxwmBeV+eZuBnDDQbHU78EXT9IbmlgATwI25W/cte5y2gkTc/LLJuNd7XLh7fDx4iQojeOye8/MmpYYu5l0r9YQyDSmN42UJl2qkLoTJVIsLQyDhtEJOMsxEEKJv61C6RkYeNz3qgNThsHv09glP9ScDflSukM=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7930.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 12:38:23 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 12:38:22 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 13:38:22 +0100
Message-Id: <DJOXX9BH27GZ.3TVPSIKR3GUSV@garyguo.net>
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
Subject: Re: [PATCH v5 01/20] rust: io: add dynamically-sized `Region` type
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-1-d0961471ae50@garyguo.net>
 <DJOLZ5AP1SDG.3CYRKS9S8KYEV@nvidia.com>
In-Reply-To: <DJOLZ5AP1SDG.3CYRKS9S8KYEV@nvidia.com>
X-ClientProxiedBy: LO4P265CA0171.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::17) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 01538f4f-93a8-46b1-7f0c-08ded8fff84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|376014|1800799024|366016|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HykSGJk52WEnobOpgaPUzmaHSpTVClisxd8rFCzS/QWJEMwhR9zGZ3BBjv+kvmgZTJ6pTDMuaLFnTQ/IuKtLry6metPu9kRYkpuULLGbKxkqKJA32OBOcMHCtK+7rYOpIjnUDpHnufUS7k8mFcJE+RRkTSPUk+pBBL0t1J2452ExBpuOyMkEodcehvuDFZwJoiN2OqzdlDKkV1jh7wzk0jFpg+9ska/hmQ/fqOztxVcmlgcT64wxm5qkzJ50E3e5DyIBsmezOH3qWrugaG5XRMTgnszWC3oK8hkpdv8C5TfGmlVW30omhyQVZR2Pl2QhhCbgTQyrI5ChMKz/gz1bA80XfQCVP494B5mQbAUdo3yWwoq7HV0+QQ/ruLDNo/5PC4Mcyec9Yt9xOY+1R0WEgcwIEY7xBn2EYDh/BhCxGVsM6Z+2rLmkDyRXkihFucp/Vj0v5eFDYkWxeALC3cD55SdU8k7VtUp1JrPG9o5xXd3CM6uyykO4dRTYOsduupBkTt/tNj860yPJUmybzRQ07elqhpoNx82LL4UEUAuNwk8Qe5pGJStm7Q0xPEYfJCMiyXpcsk/2soUKO+Sddr6y9tgpBYJPkms08czph/QPiTBc+Biav8WzI9qNUD9iKogbsfao5s/BDGJCmnpsQs2kJue/bUwMK51Bn9y9fR64U0s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUd5YTk2RzlvSXZSaXg2VDlKRGluUXJJbW90cW56cmZ3SjdPQWIrZ2RJdU1F?=
 =?utf-8?B?Rm1GMGJnMHNtS3IrVFBBUTdINjZJK1l3YmZkU3pnQzJSTmtTSzBjNXZmbUM4?=
 =?utf-8?B?Tjk3Y3R0bEtuUEt6Z0NjMFhveThxWlgyM0pEZFN4TE8rSUtqMk5IQjErWVdB?=
 =?utf-8?B?QlcvcHdnNHRuSlNLYlMxdTdBQUlvZklnYXFOR1luMHo1aW51VkpERCsrSzFC?=
 =?utf-8?B?TjdzMXVnSXBMdS9haHd2T0xYcFNpNUQ5dnBZUTlKTWRqME9tVFcxS3cyWkhV?=
 =?utf-8?B?ZFgwZVk2T2FpZmt5SVpXeXY3MDhsa0F6UGhrMDE2eTRsSWgybDRnZ1hvYStE?=
 =?utf-8?B?bXREQkNLQkQ1QUdSYjBBVHZiZloxRHhnZ0Q5MWxPUGlJZDVxa2JNNWpvU2wx?=
 =?utf-8?B?cWI0MTZYQmtFbnpGaXR4dUhXb1NKU0ZkQU5EWXF2OFNZb1FRZ1VCdUE2Sy83?=
 =?utf-8?B?aHB1YUVheER6QXRwMktKL1MwMk9pWmxhV0l5aTBZU05wbDMrdlZ1cEV0WHMy?=
 =?utf-8?B?UXJJSmJZWFdHS21LN1VjdmNOSzQ3QkZDc0UwMEFDS3JveW9NUHZHY2c0MFEx?=
 =?utf-8?B?OElSOHRLWHNTMFN0eFBieVRNNllINCtMMTFxKy95bU12S3N0Zy85MEFkaDBk?=
 =?utf-8?B?ZkVadzFJeHIvVkFUQXJvd0lIZ1VGZ1FkUkYzcnZZdDlNQWNlTmVIcVR0RGcw?=
 =?utf-8?B?MEhaV29zNEYzUGRXdVo4RFMyWTdkQTlVU1VZL0J2dXJGUVFrMjJCbGZsWmZt?=
 =?utf-8?B?MFRJbHM5MXpnMHB4RTFwb1BucWR0dDhtMVdSV0xNaFQ2d2lsUWdMRW03ZDhl?=
 =?utf-8?B?bUZDSURLcGRTaDRndlZtenVEZDVDcGk2SGZpTGxUQjNpNktCVERhQ0lwYWVJ?=
 =?utf-8?B?YUJsWitPM2NQQ2J4RkIrRkxiRS9HNWNRaXJwc3NFb01uUEovT0ZHR0s1RzNm?=
 =?utf-8?B?R3BWUk95SWo4WG50Mk1QdnZ1bklaRG4raVdhNGxub1lrSjEyZjJhdENtM2dN?=
 =?utf-8?B?M0ppMUtTTFlDRG91S0dKZDhrbXQyL1d4Z3lZbXB6T0NTMUlnVld5OUw0azRl?=
 =?utf-8?B?YXU0YVMwMmhGUzdzM2d1SkJoYytTbDhWVlBKU1k5UWdISENqZ1BrVlVJbnY1?=
 =?utf-8?B?akxwRUJaT2ZFZE9EeWRiWVNwNWtXSnI1ODlCSGxJRUo3c2hnWHlnYkhGS1N4?=
 =?utf-8?B?K2MyNENRbG9pYlZUbzZLZXJRbUxLRXB1dnlsTzFLME1PUHdhMksxNjZyWXN3?=
 =?utf-8?B?RitYbEhnT2lhbENXMGF0NjBKUUtPMm8wTjl4cGNrU0FEUzk0N2JMcCtaZmZy?=
 =?utf-8?B?T3hnVXd3SVpTRlgxSEJkV3pkdk5tM01yWkJ4dTlueFpqNGVYTjNvQ2tUUDdy?=
 =?utf-8?B?NEsyQUFlSU03S1FEdlZYQmw0UXpNQVN5ckVNa3NEbFhuN3c1dHYyMU41WHdw?=
 =?utf-8?B?cG14ZlVkdXFsaDVYcG4wN2NkYjM5cE5LalNuTm9SUlN4UUpjcmVzckdQK09v?=
 =?utf-8?B?V3dNc1ZFQUZiYUkzejlHSjlGNlFJYnVaT1Zrc2VWQ3JrQ0ErRHR1RVFGdnpX?=
 =?utf-8?B?UTl6STl4T3c4T283UFVRdWk1RXhHKzNjenV4VmZXVkd6ZkMrYkg2ejNLQ2lj?=
 =?utf-8?B?RzBuazJTTkNGdURXZ05vSjVLQTJIdUt0bGNDVzZkNnBTaEhxK0duNTRTUTJB?=
 =?utf-8?B?RUZzSmlSQ3dEL1lURm1DZVVhVUNkaUUrVU83bFV6SW5CY0NJbG5yWDFRTjl2?=
 =?utf-8?B?T0lzQktSa2ZtUTBSZkRaYnlvdXZnQlJLNTVMY0Z5RElsVFpXNlhxQnlZazRo?=
 =?utf-8?B?Z3BCNTBkRUxSd055RzRsQ1pGLzFuMlBmZThrTUs2U1I5THV1QUQ3Z2RmOFMz?=
 =?utf-8?B?SllSd2xrNVQrT2pxbjhkQzdSRzNiTGI2aXRGcXU4UXNlL2NZa0tLOHBmdUIz?=
 =?utf-8?B?bGhjZGtNa3JIM1RQb2ZiL0ZrZHlPbkJMMXV2amsrU3krN1MxL01KaUVtcjdt?=
 =?utf-8?B?NkZOLzNNbDZab01VUUMwSXNnV1orRU0zdlVnbllPUHRUcS9nOGc0cEc3VGRX?=
 =?utf-8?B?V3hVbXdSZ2dxYVNPNmU5b2hmUElBQVpVVExkcUZjVEtHbTZMSHVCdnUvSmNj?=
 =?utf-8?B?RG1JR3JyRHRZb2tuZWRQWkhacGRCVFhsTkJUeGRQZkM3MlRMQkV1ZjlPcURO?=
 =?utf-8?B?QzBXaC9iQnpvcHJMZ1dXV2dMYzJQbkhaNkoxWFJVME9jTnVtUXd2QVFuUGZP?=
 =?utf-8?B?NnRkR1o1dFR0TG16Y0JSZkk5cWZTSk5UTG5sWlJkMCs4RHhneXNtQ3VNUmRQ?=
 =?utf-8?B?UGl4Q2hFNEZRSkh3alhMYWxKQTlDYnBKZGZMbDVrejd1TUx4enFRZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 01538f4f-93a8-46b1-7f0c-08ded8fff84e
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 12:38:22.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCWDj4keifN5gbX67p/dQFh3vwXlEkjksQBFEp4yRa3r7FBjsvKVxQE57hoouypeD5T9DZInOTeTW8u7lmP1rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7930
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9524-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:from_mime,garyguo.net:dkim,garyguo.net:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41801702906

On Fri Jul 3, 2026 at 4:16 AM BST, Alexandre Courbot wrote:
> On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> <...>
>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>> index fcc7678fd9e3..d1c5f0121994 100644
>> --- a/rust/kernel/io.rs
>> +++ b/rust/kernel/io.rs
>> @@ -6,7 +6,11 @@
>> =20
>>  use crate::{
>>      bindings,
>> -    prelude::*, //
>> +    prelude::*,
>> +    ptr::{
>> +        Alignment,
>> +        KnownSize, //
>> +    }, //
>>  };
>> =20
>>  pub mod mem;
>> @@ -31,6 +35,57 @@
>>  /// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit arch=
itectures.
>>  pub type ResourceSize =3D bindings::resource_size_t;
>> =20
>> +/// Untyped I/O region.
>> +///
>> +/// This type can be used when an I/O region without known type informa=
tion has a compile-time known
>> +/// minimum size (and a runtime known actual size).
>> +///
>> +/// # Invariants
>> +///
>> +/// - Size of the region is at least as large as the `SIZE` generic par=
ameter.
>> +/// - Size of the region is multiple of 4.
>> +#[repr(C, align(4))]
>> +pub struct Region<const SIZE: usize =3D 0> {
>> +    inner: [u8],
>> +}
>> +
>> +impl<const SIZE: usize> Region<SIZE> {
>> +    /// Create a raw mutable pointer from given base address and size.
>> +    ///
>> +    /// `size` should be at least as large as the minimum size `SIZE`, =
and `base` and `size` should
>> +    /// be 4-byte aligned to uphold the type invariant.
>
> The second part of my comment on v4 was not relevant [1], but how about t=
he
> "should -> must" proposal?

I think "should" is correct here. Most likely `size` satisfy the requiremen=
t,
but it's not UB or even logic error if `size` doesn't meet the requirement.

For example, it's okay to call this to get a raw pointer before performing
checks. As long as the pointer stays raw, it's not invalid.

Best,
Gary

>
> Regardless:
>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>
> [1] https://lore.kernel.org/all/DJ9JE3I9MCG2.2G88FWQPWRBH3@garyguo.net/



