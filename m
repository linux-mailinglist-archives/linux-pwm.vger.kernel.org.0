Return-Path: <linux-pwm+bounces-7174-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86975B359DD
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Aug 2025 12:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 731981B63A5F
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Aug 2025 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9EC2F998D;
	Tue, 26 Aug 2025 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="YPlvu7F1";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="AYRsQ8jT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7017321424;
	Tue, 26 Aug 2025 10:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203150; cv=fail; b=oXLmmTeJwSdZOFBNv3FvtEd8IKBAnBm/xLICDbost56VOEjdtfVosnzxJNJQT3m7gr8nGyGMYfyaZf4RJ7K11TAaqpw8o5nYwCFxhWDps+MbkDpyLQZD5NSCvny6SqRCapf2Xdn7JDZyd6L+Nm31xWTHoSTovdtoL0L7xnSOoX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203150; c=relaxed/simple;
	bh=zVN1rSLj/Pzs9KDQhnLRselgMfbuhkNTGVdA155ngzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAYyd3NknF+b+QZaOXl4dMBm6V42E5qcEKLOsYSd2wvsm2WjsKLSy4AyFX5ByzBtnUSTaKVPo/ey0sJ35i/ly/EQFVH60AJ09FNrWpy+Ur44o2BrgHVr++3i81fZ8hFUh7+48V/bW4joSD0+WtZzQdUDWr7Pa+TtTdLMZl25lzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=YPlvu7F1; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=AYRsQ8jT; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57PMivRt2783197;
	Tue, 26 Aug 2025 05:12:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=KFknLS5MjmnlISAjk/
	QXpa/EbdM6NMd3hss88x7bKvs=; b=YPlvu7F1pTHVAY6F0zQa3XlPCgPjpKCFII
	+H8RcBUWClZDAS9aREPI/qcPnxjI+9wJ+J/qrYEPdFuAzDzPZ2lvw2JHDgWVspG/
	R5Y+DuZ6Ocn6warQga6z0AdxzbT7Wa1VzFTJSSjwCXQ5Ysjp7WO6tatUcnGSpDdh
	/e7ZHaonS+cbGKE8tIB5V3OwGSFG95lGx+e5XWH8m4LvBrxF7H5i8pCqCbbvc6MX
	jhTb4kflt/wQ1Iaa5NXohScTy4YBV6MQ7b33hTIUQt0VBSViUzM4gAK9Y/5Yste2
	inVc0cV+eoKYf0h40DGrKzDEacqXK5jH8iH2o6e2L4CmMCkPL7QA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2131.outbound.protection.outlook.com [40.107.243.131])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 48s0veaemh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 05:12:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqh7zpHYWt+Z1coaIQmuGPV7J7502UWzficwjJvWVz5TUcrIg3uehPIqPNflKKDIU+NdqvG9AvtEiGorRWwLWdtyJqVjRNWMeyl1z0joO4YCnb/0d18J93PZmEuRqLZYsk68bTtq7x3G3IrxLKOezix6Wj1sr5wmdduIaV5WjGMsONNHsZ15RTsbQHP0kHcsEGYpmYP3ljyRHi6Dzc0pe/qlB9pCS7s5ZR0nShAytCLgS3r0quqIJeqwk3dPYpnmNZDo5zyufkB/k0H91X3ZV/YsIzpDdG03eBplUnToqX2Y965aRHmplxe3Mf1CUV1A1Lrgjg7v+8LFZEDxD6kI0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFknLS5MjmnlISAjk/QXpa/EbdM6NMd3hss88x7bKvs=;
 b=GdAjk520DYUO+ajakOuI4QwK+HmhGE8dwB5E3NjLxgaGvrjvKHKb5E5Ju9VpJ0pkfaBsEkwYVH7JOJm05D5G0UTCRvx1oD7mtd+xvs1MvBGEWhX7Xa7ciogKF486wbxfI/eQrnO+Pqp5GrLPUycDul++R1fmQ0jKVdNlGcCmeARvpW2JjciQkHRIDG6SmVdXSIsNVnCbINR19WuAKPUuMz+U9UfIsmxcRkcrItklOGKdaxeBS1EMH1Elh1cS9G+UT4EDjBbgG0U8BMgucue6wThbY/a+EjaZTSUJSpfKIi0nQ24DEGQR1eN+6tWaXMKGe33sshIqsO1anPP1XgLYVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=bgdev.pl smtp.mailfrom=opensource.cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFknLS5MjmnlISAjk/QXpa/EbdM6NMd3hss88x7bKvs=;
 b=AYRsQ8jT5urqbMBsGuWtL/IOJkaRtBB7fpbsKguU3W7x/UFX6OHwyGoKh4mfYroKeKdGFGaZAbSfkxtBaW4oCNQztQ1Wud1HYT5cLMEZuGMogkkHLbLzB1P/Kmn+8rFTSoK1y9tLyio+joR6ql5fL7KNg1pkmcmRVbStXbydLaU=
Received: from DS7PR06CA0043.namprd06.prod.outlook.com (2603:10b6:8:54::25) by
 PH7PR19MB6852.namprd19.prod.outlook.com (2603:10b6:510:1b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 10:12:01 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:8:54:cafe::ef) by DS7PR06CA0043.outlook.office365.com
 (2603:10b6:8:54::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Tue,
 26 Aug 2025 10:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11
 via Frontend Transport; Tue, 26 Aug 2025 10:11:59 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 9E12F406547;
	Tue, 26 Aug 2025 10:11:58 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 83F5082024A;
	Tue, 26 Aug 2025 10:11:58 +0000 (UTC)
Date: Tue, 26 Aug 2025 11:11:57 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
        linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, linux-pwm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 3/6] gpio: wm831x: don't print out global GPIO numbers in
 debugfs callbacks
Message-ID: <aK2IbWIhrADs9dKD@opensource.cirrus.com>
References: <20250826-gpio-dbg-show-base-v1-0-7f27cd7f2256@linaro.org>
 <20250826-gpio-dbg-show-base-v1-3-7f27cd7f2256@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826-gpio-dbg-show-base-v1-3-7f27cd7f2256@linaro.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|PH7PR19MB6852:EE_
X-MS-Office365-Filtering-Correlation-Id: ff931859-6122-4d4b-af1b-08dde488fee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SdnSKwdxBfSNfhjaDGfi1p7LbfMx3D6us7JYQrfrynUK7R803GW9I3scEFav?=
 =?us-ascii?Q?KW0ACUWrUBj4SJzSNzGHjIC+oAF8vjcZ5aoNUQ+D9siyqm6zoH2Upvnuvbwr?=
 =?us-ascii?Q?GXLqhCHK5YvWwQRYFZrHgonsPJKA/Ch9FiChR177U1QVP5N6AaHoblTl7ta8?=
 =?us-ascii?Q?BiCKG6dIjhmBf7Etqvl6gjMKwTf2/azzhOQyoo4gZMGUlIQ0h4Ihg3ilx4Hg?=
 =?us-ascii?Q?NIgUeuHHbR8RRhgG57gIeUVaS9r1DnhPnHqGSjNJbtTyrpmI1JNus6i+g1pC?=
 =?us-ascii?Q?+Bgis8royGJ7lQ/gLK60vkfYAYa/9n988NUvOEsj7GaXVWkn5PeeNDuOVK84?=
 =?us-ascii?Q?uWz094J1vXHpa44yYa8d78+f7BhHqrfKA+pjZ0qKe0lkGdzXIzfDDRgv+p/h?=
 =?us-ascii?Q?2asX10KsIosDHylSxn6KikdVBIzZSEHevIS0isEfTtYpXyFHzmMUSAIzmm6B?=
 =?us-ascii?Q?Pokq37IEQRBiOZKvLQNyLsUcJykYXpPTk2ALh2V7eX7K0wC5HhtkabqDLJfY?=
 =?us-ascii?Q?raMSHFVYMrux2IHUNglSRdRxV6rCfhpOPmsTw09Ve4Tld03fQs3CdQylY0Sc?=
 =?us-ascii?Q?cb5SelPfxHqpbjF2ffZpmnJrK24ZdDUuevxGyx7VoXYhARpwsU0RoUUkFMlA?=
 =?us-ascii?Q?g+Rhp4CTDT7wvM0cF14Rvhi1n4w8rJTdeUeKF5iVvtMtaB7dbDjZ9cx/eEls?=
 =?us-ascii?Q?SU/Q57Tvq63l3Cf9GVpZgWI7Q6/SXuXU++68nmqrAFIyoiL/EloRlWW8g1VJ?=
 =?us-ascii?Q?YWIBoz9OE7L0Ymnqdlok8NyUC/N/b53kdqtIHCK2a1zd2cN9zHaL8+vwPtHo?=
 =?us-ascii?Q?vnguEmdbfc/cYM4lgal4YTQYnPr3x9uU2kWLWDo/0iTEzxAUSeYr0LVysHDv?=
 =?us-ascii?Q?U22wkrXXKlAyLNIRuy4+/oQuoMQAF9LFyiKdZloIMmmJSQGzzVsf40Gu6R6b?=
 =?us-ascii?Q?oTxbFO2VnXyb0K1p+5znmAKKF8Kfxah0dF0KOkdMrGl84BG3qMNT19vV0dGf?=
 =?us-ascii?Q?dK2CIrQq1iEIYVi7wEoy5KNwSquIcLS1SW2qRtXJPGghVrW2xqsTM2sai7ww?=
 =?us-ascii?Q?Hvu/rQvG47malvDjPV0H3H8W1STa2ztZwNhA4L7C9WhVPD6LuPbsxelJEzkR?=
 =?us-ascii?Q?92oSF+9ZrtW5LWu0dOwlSSh7N0mmh5dcK9kG2/rPV1riTZuGHo9fkexsGWJh?=
 =?us-ascii?Q?kK9Mstj5Bvwgc7xFOuQgrC94GHa+TF4Z4+909MM4QcCyhHpYYQjIRn6PjuR6?=
 =?us-ascii?Q?lr55dOyCNz8nGztWu/TSd923fcZlh/x/Covyqp36/BEQNd7O58l/zAMzt5Tq?=
 =?us-ascii?Q?xfjXZAtLEbsvV7Z2B0iBMQT6IbUTqqT5Trv36XLk0brNpWrx2JL4Ojj5OwGz?=
 =?us-ascii?Q?xHWdIXzskIWy04h9fy8wTTd9vuL40jrjifxrW33+vny6rGBx1xVGZ+woLf97?=
 =?us-ascii?Q?+1CNLdEFjdvEEE7WwgTn0mcEUa4BN5dtw/sK4e2g8VocGt6LWMH3exsTTwDR?=
 =?us-ascii?Q?Thw+ZRjiw/VueIKyKyxhLC3t0ZcrMFDhBrN8?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 10:11:59.7300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff931859-6122-4d4b-af1b-08dde488fee7
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB6852
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI2MDA4OSBTYWx0ZWRfX5Td2EjujnzoZ
 KYl52yBW/zxruPQclJyBpW0g9HBTSVBAS+RoV3bDe4oyz2WePOJeLE23kunn+z2xG7S+W3Rn2Ob
 giqzIQcW98ooqGW9k273pQsSXPxYPGQrfc+yFqzx8tvgG1T0pyKkF0Jlm3aySR8GWUpuJ+vWyA3
 HyP1OQoU6vqPiQwf2YCBDK7ACVNuSq0BS8cYvsd3NMYLY4Ms5nzvrdoHBO3cEc2lTDRdTS6A5QF
 fnfykwRNibcd9QzKs8crBswYZHnWcXNAQ9nwfVsNTAhHBrxH8joZvkWVL+Z2OOm5BCKxIuga90o
 DhLlAtN5vAOFsbYC/rcf4Y5Bwxfi0xk9rA1DgpTRj+wakdLE05GQ2hjXj/wIdI=
X-Proofpoint-GUID: fNCg3kX9IP0NkoyOOHlWb9nZh82Lxvbc
X-Authority-Analysis: v=2.4 cv=M5hNKzws c=1 sm=1 tr=0 ts=68ad8875 cx=c_pps
 a=/DofB7ChUv5k5O/52bG9WQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=KKAkSRfTAAAA:8 a=w1d2syhTAAAA:8
 a=CykeHtdoX445U1M9gU8A:9 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: fNCg3kX9IP0NkoyOOHlWb9nZh82Lxvbc
X-Proofpoint-Spam-Reason: safe

On Tue, Aug 26, 2025 at 11:54:37AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> In order to further limit the number of references to the GPIO base
> number stored in struct gpio_chip, replace the global GPIO numbers in
> the output of debugfs callbacks by hardware offsets.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

