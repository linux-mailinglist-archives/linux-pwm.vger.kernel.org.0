Return-Path: <linux-pwm+bounces-3163-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 575CE9712FA
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 11:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFFE2878C5
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Sep 2024 09:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C971B29DB;
	Mon,  9 Sep 2024 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JLjQjSfT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2053.outbound.protection.outlook.com [40.92.102.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12D1B29D8;
	Mon,  9 Sep 2024 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725872936; cv=fail; b=LbdFpZP4AlAndWLVFGCbQt5jn4ZVsg9bHZwkVbs/Xw8T3F2WkvVZE6sA5NRuOt40Uk3+Kbu2zyPSZVwRpu4CmqjutueFHS1tW6ci2zMKTZA8Q1pIkyz05MDkylFVecw8v2SeLWHpO5cWih0mJL1elsYT/g21SzOkcLlDimg/TKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725872936; c=relaxed/simple;
	bh=9FphDtfCU1TeS/Dk6zspCvl2PibbNgYewVNouSUAYMs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZQmSegqEFTyfU3p6zEOzZLGfwvnd1cFERyS6ngH1rEapCdQLvwGYwBeQRtbB8a6X7oPn4pZDU7o/8zYD/GdpKXDTlKqgB6F6jCNIS8VIKC80HQTnMROMI8EoZove+fiJ6GeZOIbRULAosJhx+edCNk/krYspFuBPB5I4Ip/frPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JLjQjSfT; arc=fail smtp.client-ip=40.92.102.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aPqO2f1bOQnxiAoXeagO3V5ouTQmQcjwsb4P0pNXbE7I4sabp2E8bVOOLr62Mj3VsOvKmWpn46D9dQ2QoJeIws/QhObE3d4GSBfTlZf06qy2tGAzhxMg/b2Lww4O4u47PKx7RbjLtHIViGJTMFDOctJ0IZXhCnG8+BeEp78HJ388LA3gYo7Q84oFqTwcTICOByjed+Yn4TwCIydPEPE9BMXmNco+c3sOYwc9Vo9jjawdXWRM4dRrHu6Mb2m0/2N4rPKT1ljOjNcW7NQSVLh2nG7DZeqkUJdO3sz9dTaA+iGOLc87Vejxti+JSPQHwlwnAqf+H1zOV6H6SAh71JmW/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaYZzraz/rgDeaFsbCGKt46HfG8hx4UDd8VlvEWmmeE=;
 b=cwIZrdWGFBZTTKsF3Umno4iEnQDsfyj6jmHwmvPtYa2aAEo+1wgZuEdc5ZXgYZIuRIBcAkigcN+Poxwc/IborBLJciENKr6QH6v83oqhEuiXZrS8/7hjr8fs+l+PwLb2EhEIjDlH2pfE7J+pWffmZ7zjorIJ9Sin0suyiiRpOPXOUHUJ0KMtFAvKOWCVAee1EvQUTBiZCrGXPPxY49UO0ErYNvMAVKa9ahyodkrOR64McwSifs6Tl5V4HY6Z1ffgE4XuZE1fAmxBAaB9uUfVEcfSI36YnZs9MXb93t186veTruX5GBWEv3HYSlTdnEzulk6YrUF6zJrxTAT8T/FZww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JaYZzraz/rgDeaFsbCGKt46HfG8hx4UDd8VlvEWmmeE=;
 b=JLjQjSfTqk7FnJZfkoVsDa19znQGVY5XEKz5WlxCBIzlGLWMYM8/6aDxbP85LAGUsN9jf7pe/GPO9Q6hJSrd2z+Jad9Q132zKOzXSWQPVaa4znM+iILZ6AmHJXLVZwn49caKZExwL0PEXzooEhc5tAwl7O6f6fnr9GR/65zKGAia2uUDeJS46IkMGGaNBghhV6hZWxdx09a+IaSjbX2su9axeN/oCzxeQVu7bViWRuXoawXIC4XWTKBeAWUK7CI/wVh4j4uEawrfUsviYM+1QIAshxJzVkNWTi2GSUpuMJO59ZOz4POktWNSpWBcAQQXiyTFuszm/Je+NDRxy7q9/Q==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MAYP287MB3692.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:150::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 09:08:47 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%4]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 09:08:47 +0000
Message-ID:
 <MA0P287MB2822B10767514B3E04E8E468FE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Mon, 9 Sep 2024 17:08:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pwm: sophgo: add driver for Sophgo SG2042 PWM
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 Chen Wang <unicornxw@gmail.com>, ukleinek@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, inochiama@outlook.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
 chao.wei@sophgo.com, haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
 chunzhi.lin@sophgo.com
References: <3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang@outlook.com>
 <202409080100.h6lX5Asm-lkp@intel.com>
 <MA0P287MB28225ECCF1D263A20917AD5DFE992@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <CAMuHMdXOAmCsdcvdo41qD9f4L=K2uZa6nJN7D5YOTTuCnBHtWA@mail.gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <CAMuHMdXOAmCsdcvdo41qD9f4L=K2uZa6nJN7D5YOTTuCnBHtWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [e/0O+3RbRtunEAfwwKOVL7wFkDjiZWvS]
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <54a87aff-d68e-4dfd-94ed-f688acc6f5c6@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MAYP287MB3692:EE_
X-MS-Office365-Filtering-Correlation-Id: 97a3c646-68f8-4c67-e908-08dcd0af02e5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|15080799006|8060799006|5072599009|461199028|6090799003|3412199025|440099028|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	H761D7g8NMAws0jTwlwA+tBwWJw0KPr0bgjoAmINCnTNCg9/xWFD6/WypMTBXQRjqJVKT70B8EI+7vdAC4PAaP8/FEg493wDCCy8eMaI7SSb98HYUZScoZJMPR56rKYHfMTqBQx9LxwLTq0ilmDgIEWS5dCNJOKMMOWJu3RyRjROVDPcd6bY55/st7kbYt7HlJpaXt1E3b8DmyqHqto02frNEYi/4awH2w9iQwinFM995VMnzD+3Xp271jPh0RlnbDGfQiXJKnnIbnbiKOEyA7ANStyowdw0m6Nxp7V2kMxyt1phj0dLv68ta9e+MHutqO6wKMv9KruFiaxtsF+ENrl11G+Y2aNN57EdyJojsKWFxwVA2VfeNBjWZjFLuXt1gStiCda2MtatpY6BmJDGJ9K9FRVmW9/QMBdSPReMyWbdo93Tn/BiFO99GA+CjrEIFUeC3Ken3jrtLPpGCvxzW8IVc1MlNF5IoN/C6FJqV+JJ8C3P1a4j0rJynuU+Bqo6ouIsegbUQMJt5tfARNV83ztys/+lUoPT4u4OaK40xPl7EeJX797p5bd6XYB2AS7b60qIbjEDYcPehJOc02SSrFWSiaka+fn8yROfv6QAbih90AknY1yw+ZHxKGjP3JOBqtAjb/JYKreESMFDq57oZ5ga8GMO7GmVVadZWyU0JfZ9a3/tF7AnEo9eKmdoqOVfncGZ0LT0+hC5XBIvsVu6Zdk8Nn+o4QLC9snEAHhY9I8/MyJageP89RlY2X9RoaM0dwo7gE19WqqreDMYffzQM3NTpc3krMnd+ZS3ZF6UeABMPU3cZFZ0jzz0KqJU2iOpoEuTDFvgvmMK8j8YEL8zqkRZMy/1X4RGyJBCYs6+AbQ=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Nmpqb2JFajRyMnk4S0NMTFltV05yV0ZocnRqcmN5RFNVeUg1Wmh0WjNWamtE?=
 =?utf-8?B?Qys0VDRGZmRrUVJocm9WS29OODZuNVBRNWRlMDBQM3o0Vk9ZWXpPTm04NWRI?=
 =?utf-8?B?S2QzYjhCVkRkRHhnWFZLaFh3OVRJR2RjSyt1dmdudEcwRlVzcmRGSmFXZ0Nx?=
 =?utf-8?B?ZGpBeloyNW03N1dSOURGUkRWQlVvb3l4bEpacTZJL0FDNXpXb0ovS1RkUzhj?=
 =?utf-8?B?RzJtbFc1azNIcHAwZXduZDNPMXAvcWQ1Vm9Fayt1TnFjbWN0WGtNYnhiS1hh?=
 =?utf-8?B?aTFDZVA0c1ljRzNBMG4ydlBIdUh4dXFUcmc4VXJsMEtOT0NNbzhCY3ROUlRt?=
 =?utf-8?B?SE5KU0MwZndwSjVCU2RDS1J6WUlJcHpHQnh6RUZ2eGU2QVZvOWFjMEgyTGRs?=
 =?utf-8?B?UjFrdjZCSXZzRHhLNUZCbFpvQ0sreldBd2I3TjJpQ2JZS2V3ZThFSlFoOW1P?=
 =?utf-8?B?Y09VSC9VSCtKVEY3d2hLZ201eDNvOUFuL29NYngvQ0piTjFGRHBTWDMvRWFx?=
 =?utf-8?B?Wi85YXRvTEI1VlhyVGtkdGZTeExtdzJ6UGdwMzVFeUpyaEdqVHVVYzFMRVlv?=
 =?utf-8?B?NWVxZi9sMzZmSkFNYUJYVmlQSGdobjhnRjR1RlBmZ0N4TkZnam51cEx4cGlR?=
 =?utf-8?B?ZS9hMHgzL2dRSHkrdnF2N3lJQWY0QkVtcUFKcUNNYTRFNmdiYXhBdWNWWkhE?=
 =?utf-8?B?RnpSTTRjaTVHTVpuTk15bUwwbFRCT2tNdGZ6b3dGUW5CM0tmRHZjbE5xZlhu?=
 =?utf-8?B?SDFsWVdHZUhWUGpLQ2Y1aTNJQllQM2diZFhVei9KeExrM1gxMkdHTThoeisz?=
 =?utf-8?B?UTIyTk82Z216ZUhDdnR2ZUpadjV1WGVlZUxXeGRqR1FaQlQ2WFVFbHovWW9t?=
 =?utf-8?B?T0pkOXp6QWZmUkFsanNMd3B5Q2k1TjZtQ3U5SUFLVndXZmk4MTgwbDQ0QWh6?=
 =?utf-8?B?U3VuTzlLc01ud05EbnV6U255V0JqSjI0eTNMTDMraW1Rem1LV2FjQkJweE44?=
 =?utf-8?B?eFRhUHJNTUpyaTdQSnZFY0UrN3dZK3lXMWdBNGxYQWRKbE8wblRxYWllcE5S?=
 =?utf-8?B?ak1UVEVaSkJ3bkxVR2d4c0c1SHBJcm1qRFpkeFFDdHBVbXNFU1hJVXhXTnpT?=
 =?utf-8?B?OWdFRXUySkxFUVpCdVBvTGdORHdpbHBjNlBJaFoydkZZMGpPb0RnMWVSUDZz?=
 =?utf-8?B?K01CUU50LzZ4ZlJvNWw2U2lLSkhONXBjdlpSWDYwRERXdGZVS3lVdTZsK21C?=
 =?utf-8?B?MHV4bGl2dk5WZE1ZSFRma2xRT09yZkJ6MUVOY0l4UGsyd2lKNmxEbjFzVlBq?=
 =?utf-8?B?OUlIY09MRTIrU09FSzZQQk81TWNJUDlNYk5QcktRRTQ3SHhOTDRPb0MzUUsv?=
 =?utf-8?B?SGdyVnZ5UUkyQzRMRFprZVdmaU9xVEt3WUNqYlpDays1dnNEcXZ5RzBvWUsr?=
 =?utf-8?B?djdLUCt4bEExMTVCdmRPSEExWVpjYnpGNDZjZ3VMbXNWbWZmNmc2cWFLaUth?=
 =?utf-8?B?NUlEZVMrLzd2cFVrcnNULzk0VWlqaFNIZnh2RlJ2VGMrMUhEWU9Yc28yTHUx?=
 =?utf-8?B?dnppVzZseFhTV24ycEZQQ3UwNjZ2RlFibitOWEZjY203VmtPUksrbWxWaUlO?=
 =?utf-8?B?dlhiMTNEcFlaak1rd2pjS1RZbkt4Mk81d3RtQ0t5RFFNcDVpdGk4alpSZ213?=
 =?utf-8?Q?n6U+9ICnypGzkY2JZPTB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a3c646-68f8-4c67-e908-08dcd0af02e5
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 09:08:47.1702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYP287MB3692


On 2024/9/9 16:45, Geert Uytterhoeven wrote:
> Hi Chen,
>
> On Mon, Sep 9, 2024 at 10:26 AM Chen Wang <unicorn_wang@outlook.com> wrote:
>> I wonder why CONFIG_PWM_SOPHGO_SG2042 is enabeld for m68k? Please remove
>> this.
> Because it depends on ARCH_SOPHGO || COMPILE_TEST.
> So it can be enabled on all architectures when compile-testing.
Thanks, it's really a potential defect when CONFIG_OF is not set, will 
fix this in next version.
>> On 2024/9/8 1:58, kernel test robot wrote:
>>> kernel test robot noticed the following build warnings:
>>>
>>> [auto build test WARNING on 431c1646e1f86b949fa3685efc50b660a364c2b6]
>>>
>>> url:    https://github.com/intel-lab-lkp/linux/commits/Chen-Wang/dt-bindings-pwm-sophgo-add-bindings-for-sg2042/20240905-201303
>>> base:   431c1646e1f86b949fa3685efc50b660a364c2b6
>>> patch link:    https://lore.kernel.org/r/3985690b29340982a45314bdcc914c554621e909.1725536870.git.unicorn_wang%40outlook.com
>>> patch subject: [PATCH 2/2] pwm: sophgo: add driver for Sophgo SG2042 PWM
>>> config: m68k-randconfig-r133-20240907 (https://download.01.org/0day-ci/archive/20240908/202409080100.h6lX5Asm-lkp@intel.com/config)
>>> compiler: m68k-linux-gcc (GCC) 14.1.0
>>> reproduce: (https://download.01.org/0day-ci/archive/20240908/202409080100.h6lX5Asm-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202409080100.h6lX5Asm-lkp@intel.com/
>>>
>>> All warnings (new ones prefixed by >>):
>>>
>>>>> drivers/pwm/pwm-sophgo-sg2042.c:99:34: warning: 'sg2042_pwm_match' defined but not used [-Wunused-const-variable=]
>>>         99 | static const struct of_device_id sg2042_pwm_match[] = {
>>>            |                                  ^~~~~~~~~~~~~~~~
>>>
>>>
>>> vim +/sg2042_pwm_match +99 drivers/pwm/pwm-sophgo-sg2042.c
>>>
>>>       98
>>>     > 99       static const struct of_device_id sg2042_pwm_match[] = {
>>>      100               { .compatible = "sophgo,sg2042-pwm" },
>>>      101               { },
>>>      102       };
>>>      103       MODULE_DEVICE_TABLE(of, sg2042_pwm_match);
>>>      104
> Gr{oetje,eeting}s,
>
>                          Geert
>

