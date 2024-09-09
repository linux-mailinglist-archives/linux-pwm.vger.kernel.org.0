Return-Path: <linux-pwm+bounces-3177-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DB5972593
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Sep 2024 01:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B901F2444B
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 23:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD54618DF61;
	Mon,  9 Sep 2024 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WG+YBXbz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2026.outbound.protection.outlook.com [40.92.103.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA48318CBF0;
	Mon,  9 Sep 2024 23:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725923306; cv=fail; b=aMm1HpqIX5xbUF0j5kKj3MFqfvG0MoKwnIcQ/qNAYoUgNNwkt/HSMbiLMGsOE6tgR5US7nVUtZAgIjxyGYZeT4XMCo/0z5YsZlwI/eOzoJSFDzlPmjs77zjBON0qQaztbp6oxE2HDDpJZQfUQ/Tb8Oi8M3Ly3ik1zDxDFjZ4EwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725923306; c=relaxed/simple;
	bh=NEiZrUrEtdrSIUL9KEcJsBCmbVHKNtjFNi27XS5oS+8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CyPae7nIvtkh0tRrKqfmVghaBkHTW2CXfa4lPCZ4R0TQWLbCqjzCYz0h2ErzVfjor8AvRnUJjqXMRmWUJW/+gaCJK1H4fbSgrIVBejDnxoWDtd7CYIllH/Askd/lyk6sDagHGNMl+aar2oE81EIcDcxk9p+OrCHBxOKSyVHPfUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WG+YBXbz; arc=fail smtp.client-ip=40.92.103.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iWwUhV8+ZRDcgsWlMAijvNOzdrs0dZ6IIGw6tjtEyqRh2Ha6bTrzDiwm3sv1FnxG8BG2IUOykc+7YzTFsNFwXIUu4lGt9Ldvn+43rgxEz9c9KU5N22AFB5TR0prAuJUMaKFX1IVIa3ifX63nYdxVnBrB5xZbpTTzJODBSQ36VCbHsJx92On0W49KSX3n0sxxjbpaV/J6xX1ssLaUd9fmE8nceAux/kz+FYEAcmCnbuM/Sm/zDurkKOkk+aiIJeULA3y0YKsusms0qFvyn7xVJ/mZwTnHbWgOxZ3sx9n8nrhtShPfPZlR4qfeVAGGw0ZWejfg4mK6LDJL1Rs4zdHeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEiZrUrEtdrSIUL9KEcJsBCmbVHKNtjFNi27XS5oS+8=;
 b=HookQElCE36N5nOVT02GFDveSWnz74OGq40ZogcfrC/biDTCYgOwCdxgrrg16/iKsIFnXVNJAS2BNYnMwwapv1uTrzuaxH92yTiRQ0iUlkfuMKuRaiDzZQQlZNyN4xeXS9YA0LpTeeyUa/OUKaM2PGsMPeUy16GQpIYnfMmLv9pfYP2ot75SD5Znqt6POOZSoArJBTkxjJFJjFKCzH1kiM5tTjoWUWkoK/mI1pHAa+EhMo9T0UKskLj9Zod9pv5bRyFn1HGmmY26+2o+MBju2E3Jv0jXY0Cx02TyuKr/9wQNetxnQugT8Q7nn9KZkKHa1cKZQ7eMUQn9Jrh/Ut9hjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEiZrUrEtdrSIUL9KEcJsBCmbVHKNtjFNi27XS5oS+8=;
 b=WG+YBXbzFScP71gvXeWp4LPbL+3n3dc15h2KGvVSg7G0A671W38GOxKR5RCCf0p84UdAdFZEi8ATroVGbHuxIPTFE4APRVG6DBA1PgCbsW8EHfx/bF+5AbIh5t+IKnA2sWd1uM4aRXcVydQMoGazrw5TLGovdejoAwoqmuISkuhVHLYhsszdYOEAYHcI2ot6Jur3T03pNzkgu9GfRuuB9rjDdJyMQuuOR2C0mX91SNOTjkIZ9ImRsmTIUiy0/JOndL86wKHJaL9HR1qVTUNZCwkuUbVD9Ee1ZMhIRgUOysuBZh0U78uCCXgZqdTQV7s1NEAKa7q1EU0umP9cm/IH8w==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB2133.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 23:08:15 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 23:08:15 +0000
Message-ID:
 <MA0P287MB282257F6614C3D43523CB4C3FE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 10 Sep 2024 07:08:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: sophgo: add driver for Sophgo SG2042 PWM
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 Chen Wang <unicornxw@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, inochiama@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
References: <3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang@outlook.com>
 <202409080100.h6lX5Asm-lkp@intel.com>
 <MA0P287MB28225ECCF1D263A20917AD5DFE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <CAMuHMdXOAmCsdcvdo41qD9f4L=K2uZa6nJN7D5YOTTuCnBHtWA@mail.gmail.com>
 <MA0P287MB2822B10767514B3E04E8E468FE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <qcpqwvffln3cb5lxnhwarmeawiudurc4v35rqz7jo6xo2es5bi@2q4e4f4zn2vu>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <qcpqwvffln3cb5lxnhwarmeawiudurc4v35rqz7jo6xo2es5bi@2q4e4f4zn2vu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [pgQpsBM5yz7Tp3fDJcasQ8aQK9r0aGlb]
X-ClientProxiedBy: TYAPR01CA0225.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::21) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <25b44694-0701-4577-8168-9c356e5fe74f@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB2133:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e303450-9b3d-4d44-3447-08dcd1244863
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|461199028|6090799003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	GwpAmNBZaWJuMv1mp8y3pFW4Qv2ss7mv1r9f0r7/biD97t4xjzblJVwy8w9rNfqueCzcC8CaqM3UMZ1oEuSPRSdRY0g76nCeHfgBcfTpvzNp4FP9d20zZXKC1hnaQmaiLT5IQ9tY8w2rcFnyEfGH9hhwvwplTTnWC57jNHy9Qrs1HFF1dWDCE8uU/wHpdDb5zoqWwUvgfj/RmJXPYXL5CcLach//Ag3K6v3swcUdryPPX0rKYkyJcuEBEqPJ6Uy0Uq/crBrnJfPvcBacqdkOM95IcPJ8Z4ufcvzmmyw4KqzTajpR5/qcyM6RQfr3YHRM5o65qpBn0lpKShrsAyRs9Rw+HGICJjqag91qgvW0uLSEoKIJPdZ44GGXjxry+n5BxBTf44B36ISyggv2fsmcjVw5oNj9qC4Wb6ckrW3+LykoEd+s8VHZ/8/wuKyQDqrwb5UI2M1EtK8DA6fhT/Itz89l0h9pJes9x55GJvhTAzcJEf/HHFUJZrcLr7IKKp/ithols+qWM1IFvyBInqDR/p7LbXbbMaGUDcR2Es7Omem99x1oLv8woUKx0UTyK1+h78cLglx8ZaFOXh7seZLCRf+fKK3qzonioioA6z3Gm+7bf5y7dGgtCR3kEmsQoL4b/pmfLt4aHooVA/IEJkGZkglHHsZwDY3JcQFvjEnpn3iYZIcbhRNWqI5PQbM9SlvgInf7LxotTAtmCVCWnnEyv9a8v2TOXRJkUY6VVfRc+2g=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk5DcVg0U3VRSFU4ZkVGcnBCRlVYRXVibXIrS3I2N0N0VzRQNkFCUk1Gcmpo?=
 =?utf-8?B?UXlMWVU2WmY2TG1Qb1BGVkNrSXcwdlhSdGU5M29NU3BZYjBpNm8ycHlrTWFm?=
 =?utf-8?B?cjd0bEtrTUVZZmJ6czNRV1BaT3E2cGxwdVVsVW1nNGxGRzhNYkJDVFE5OG5B?=
 =?utf-8?B?eVpQeEpTYklpdmVtWWRrWVN2VXZYTUt3WDAxbkxVMC8wTGJxbkg1Q1plbXZR?=
 =?utf-8?B?V04xMnlFZWNDL3FsTnNmUlprOHZMYnlzVjlYVXJ3UElKNjB4eENHNFd3NEpZ?=
 =?utf-8?B?eUh1RUwrMU9SVStwMXJjMENzSTBJOFh0WXJvdE8xaWpqVnVIeVl0SllydzRv?=
 =?utf-8?B?WnFCRUFCWnVwd0puUitBM3lKWHNBY1JiT2FVaGllSk9ZdTBmSkRqS1g2bnNY?=
 =?utf-8?B?eGhiL3JuaTNWSHN1L2dKeGJ6WW5kNm9QeVNUUy9rZlRqOEJNajRFV0NBZWp0?=
 =?utf-8?B?dHQvaTJ3aWFETVhkY3BuNjlOTGMxcXAvd1BENXZCVUloZFVpSzRRL056MVlt?=
 =?utf-8?B?dW1ZNDlCUWtYbDcxdFRwdDlCOTNuOUpETUJnbFpQZ1ozOXZwMVhtdDNVQmxK?=
 =?utf-8?B?MEJlc3Z0N01nczdJYTcxV2VURW1hei95RExRb3Z0RWlPejVJRFhjV1ZRdWE1?=
 =?utf-8?B?bFM4YW1ybFdhNWZ3SGZDRHhaWVJkeGx0b0Z4V21rNmFNRkU5eFRRNXVkc1FY?=
 =?utf-8?B?RXhudk5HcE5CYVcyT0ZtUERtelZVa2lwcGlLaTBzQUxQRHJzcUpidnVyZmcv?=
 =?utf-8?B?bWxMVm9OeGxVVEViVEdlb1E4aE1mang5V3Y0MVFKT1hCN1R1amgrUW93VGFn?=
 =?utf-8?B?eWd3TThQcG1wTTUrT2dZZVlobzBWSkE5dW94MUl2S0k4VUxvNGc4QXdVdUwy?=
 =?utf-8?B?S0FZeDhnUVo1clBYUkY3eUF5cjY3V21WazBiVlo2WWxtdmROMm84ZFNudFZO?=
 =?utf-8?B?cFhVVE1Sb2hoT2tnUlViQnAxcEdsTFEyTGQvVUtnbU5PSG1LRHdZRTVKSUhR?=
 =?utf-8?B?dHRnZWtuQ3JlTEtEWEF5c2w3c0tCU3A2MFhJOG9EdXJhakRKMHhRMlM4b1Y5?=
 =?utf-8?B?OHluMDRzeVcyUm1SWEVWdE5QL0hlL3JjUmNnc2JsYlRFbVFSZDhZOHhqU2ZZ?=
 =?utf-8?B?dVRpZjl5ZmVpZnVXK21nQ010aFhlNUliZlltSFVseUhMZVlBOU92UWF6OHB2?=
 =?utf-8?B?emhFYS8wQlB1OUNPVDNLT2JKTFRueHBFV1JsYk9lNlF2WktFR0JNT2pia1cv?=
 =?utf-8?B?Rk1LanFHc0xiUyt3czk1Qko5SjVEbzU2UTNKZDFZdXd4K0dKSnMyZkZHSXZq?=
 =?utf-8?B?NDRhMnQvZVBoV2g4clpZRWFnL0w0K0trb1IvNFVwb0NFSnNEZDRkTzBrSDJE?=
 =?utf-8?B?V3ZrTGx0d3JDMUtVUHRMTHNHTGxtM0huS2luNmZraGZCRVdMcTJpTjRuU1Er?=
 =?utf-8?B?bFZpWllkU2hsRENNZWJWMG01UStzQkM4azk3RTN4eU0rZGpieTgxSVd0S3d2?=
 =?utf-8?B?N096VldsSGo2bHcvem1uZEZvV2hYakdnMVJOcXlsbnNaWlBJQ01ZdDJQeHI3?=
 =?utf-8?B?eHAzQ09pcnRwRHdJYjNhcElCT2NPN2lmYnpET2NLNkkrTWJ6VlY0bTFtQVhY?=
 =?utf-8?B?VGJYWTN1Mzk5OE5vN3RUY2I4TUF1bEtJc3RVd1lZMjYyclRobktSVHhFd2Qx?=
 =?utf-8?Q?XbD/Sp9mkfjEc2Yf9H6Q?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e303450-9b3d-4d44-3447-08dcd1244863
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 23:08:14.7894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2133


On 2024/9/9 19:45, Uwe Kleine-König wrote:
> Hello Chen,
>
> On Mon, Sep 09, 2024 at 05:08:41PM +0800, Chen Wang wrote:
>> On 2024/9/9 16:45, Geert Uytterhoeven wrote:
>>> On Mon, Sep 9, 2024 at 10:26 AM Chen Wang <unicorn_wang@outlook.com> wrote:
>>>> I wonder why CONFIG_PWM_SOPHGO_SG2042 is enabeld for m68k? Please remove
>>>> this.
>>> Because it depends on ARCH_SOPHGO || COMPILE_TEST.
>>> So it can be enabled on all architectures when compile-testing.
>> Thanks, it's really a potential defect when CONFIG_OF is not set, will fix
>> this in next version.
> BTW, the right approach to fix that is to not use of_match_ptr when
> initializing pwm_sg2042_driver.driver.of_match_table.
>
> Best regards
> Uwe

Thank you Uwe, that's what I said potential defect, have fixed here.

Thanks,

Chen


