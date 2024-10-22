Return-Path: <linux-pwm+bounces-3746-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D92C9AA285
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 14:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C72731F234C8
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2024 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1516819D8A4;
	Tue, 22 Oct 2024 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oduEVlTU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2014.outbound.protection.outlook.com [40.92.103.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE4619D097;
	Tue, 22 Oct 2024 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.103.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601637; cv=fail; b=RwEOuBCNKQ/+Y7JUI0VX2lA7NCYeCqDp5ERgZe32BKmWzm79TSHKFU0e/SucsW/1x81d2r+LqS1ByHfSxQjk6WliMxhQB9V8ADrr7TulxDMjXGdJN+HSjWKGBcQRfO/6Hoyem/oXwIMDOFTW3r8A8Vn3Dx5ds3TH02k/zFmVU8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601637; c=relaxed/simple;
	bh=iz9sWmSYPPDANiW6kkd5UvaeyOVxUqMoVHV7JtTDUCQ=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nYhyvI1JV13LW50TFlPiAa50qraPqMCb85/PiWhbb71xxePF9AuqDBUhtyUAuJVNw7N7738BnuZYEBa5GgM8+ILlIpFnSUr/EZopcG/xiswWoXBRwGl5n+AOnJgoHM6CPzG3hEi2prs75jjz6Af1FYyRGvDzP9c+xYSV8VMnblY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oduEVlTU; arc=fail smtp.client-ip=40.92.103.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDRwxxXSyFXi4jz6WBwPv7HULd7tgKbR2i0FK3+TO5TcjSmYPjaSC7BD47ZIhgcQYSHbDPyTlW+Wb4HUwNBmYpHpMzLo7URAw55lOuXMpAcSqFGHuD0REuv+dzxJ2BPbGcSyQFI7dTElN++yiqV33CMsTA+Wzq1F+zCwikD6QyAKk5+RScNe9z0kIhRJ7fzsJawr7aTfj74fN5mnwlgC93hq9pMGpPBDGNVPofyYky2nOqR9jGkMCW1iNnEp91mw3CtMVus3ITeAY7twvq3Pdgi5thBNXE64GYpbrny5bCHy9wM3v4QsXBmOuIof/XCp2b4r1DEojWSbdiMNo4M27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gc9L8jv3AwJ7tzrqeIi5ivlpnHBWG98Bq/HCoyWsuUo=;
 b=JSm1mMF233b4z/sTzDhTdBMWmMOjERDoFlF2wa9oUCFOfjo/2kzpyGazyZqqfHvkieZs6lv5l1RsZ6SnVB1/spz3L4Q0cvZr7xFprC0U5QxS3uRKVSX44JYiCCg16fHe++A/v7sDxM3I8vS5sX57sbUKexHV437rDqNyt/HO9oChrDbc0ZpADFGmKvsq7hy7LhejhCgyLA0fkq9kietuYQqOmoCniy40+3WZT/gvlU6X5tNVZ4KEk2JjbEqi/Boc3yQmt9QiVte6d02diwuyXQPkHKn3RL4LChfO9VbBBdnb/Ohk2fDkSNfKFxCoUJDFb2ilS4tTeYHKnmjFJXLL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gc9L8jv3AwJ7tzrqeIi5ivlpnHBWG98Bq/HCoyWsuUo=;
 b=oduEVlTUWdyF1Owu7seYy38mto1HAkBXZ4Pe6Pqg8NoHN4U9xGdhuVOhAxgq4e6/jzF1aPKOWD7yRByus3dL0oPIkD7NPqOjH07NLihrFAsz0SPGh6pg7je1BtLM52V9sg/cBp4aRDVyoPPjOgp8/5Wzwi+K4Z3b+RvKq2oi+m+Lso9vZU+hFcP8xxgaXGzgYvXmdmzQIfvglpsqEm5oPlZThLdgFkS/aBmNLZAAUk+VCUosl23W6HziAISRa8Kzi7RmVfuXNxwY7u+o9zJnjuXdKdUyZRt8tiZrwhcWA3v681yxk/+GalCLHkX9diQQ6wQFG23J1JmXDmhrHeJhhA==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by MA0P287MB2056.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 12:53:46 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 12:53:46 +0000
Message-ID:
 <MA0P287MB2822C080A81F87037F9EE94CFE4C2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 22 Oct 2024 20:53:42 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] pwm: Add pwm driver for Sophgo SG2042
From: Chen Wang <unicorn_wang@outlook.com>
To: ukleinek@kernel.org, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>
Cc: Chen Wang <unicornxw@gmail.com>, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, inochiama@outlook.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-riscv@lists.infradead.org, chao.wei@sophgo.com,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, chunzhi.lin@sophgo.com
References: <cover.1729037302.git.unicorn_wang@outlook.com>
 <MA0P287MB2822808440B26B1C445118BAFE4C2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MA0P287MB2822808440B26B1C445118BAFE4C2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0120.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::24) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <7ffc4cd2-b40a-4e04-8a07-9e4a25a3eff5@outlook.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|MA0P287MB2056:EE_
X-MS-Office365-Filtering-Correlation-Id: fe218854-03c1-4476-70b7-08dcf29890fd
X-MS-Exchange-SLBlob-MailProps:
	cn60g5V53KMxaZkgzVRd+VbJkjx2XhG+T8aAhG3HU87PCd5VbdVCJBMHaeJi7Rw/EMdJg1AgBz0hVfjJRgyAmSrTlqfc9jMLoZwcDnKQNGNqOapzsT/nyZPKvoaqwuJdxs5x8tC8IqQu18FhrFBc4wppFr6L7e/pAVvSS/ZVh52lvNylWSgiymosMIP/uabaUA9s4ZGI2nwPR9Tvwz31VhLxR1/i5MvUJtSsVHAXoJ+UKdyGn4ifdmrXUzWpVmUvJwUJOolym5lFQXhbwZaxc36+rP1n1ao4xp0SpAEgiSeK3plp957PLHpvWhC5Qak2BW/bzMm2XwW48n+l81LSOO4FEG9WkHToUiWYFVss34NedpgrmQeY124V7KrH3D41/6mBIFVD7Cj/+WAiqNHNsgcRxIweHsEGSODPfu87lDr+RZRDU9eExf8eNMfqwpgoE2IhSL6x3smTAEpHEQDfxoz1/h8Hlw2k/xAlO3uxZFi0N4f+4Ck+njo0QPzJmeKLNBj4buWkrao5coADdRcYgUAQcCt4iixRus8tijaLGO//PaY74lZOp1+zuUxYALyU6jEe4v+TRJ80Fetv1XAPlvkaECHFjOmLlpkls19NAmVN+dN+CU2SK1UPsHHFMK06j2fnP3aAFaL38nnRuEXky5qrWkHhAikotPhyvoinyb4y7lDb3EDVZBzWkJ6DlTByOuY4oY7aismUMsjt76e7rAonDMl+P2Oh8H3mcFPdVl8e6mTP791ip3pP7ntzdUKb8Ezxo3xjF/D7ZERpa5QEsyzO1Wtgrid5BFwifIzsPdDJ0Nq4Lj17YyNmduZGaBm4d6Be9ivaVys70L5m5z3TDZLCdsjlB0Zv8SqLNZ41I20tOwUn75YHww==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|461199028|5072599009|8060799006|6090799003|15080799006|7092599003|10035399004|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	RTNwG7LaHoCDJMPq0vFB6o3duGR/8q9br1s48AlfyGu7ZmChrobP5UG3wSAUzIdhGeQXkc2mZpH6XFbZ9iydMKDy5KSdaEgLvT0dATsyS4WT4mmsnmY7riMm09nHBM42p7ZDNT82mgwBZTEyX+lfid/bcatRPM53m4PwdK+XL22tgD9gxS4qTnx+z211lS4VJSWN8x8w8yjHvR/pZ520plTbjQyM9mSlUIdvuO5y4E6zxbHugr52mhhWMg3lrUVY6wAngiuhFWmm30uXo6hfAJbO8yoyug7fgO3eu0tca0cU2dqkZkJ0vas2sZk2J3egB5VYv8jzUSJY7K69QuiHaf5eX+bnm1RxtdQq79mCIy4tilhWQIGTVOp3XCid7ckK4xpehy7s13H37KwaHwFlYfp2TDN3aCLChWWBe1jCG+As7CZFcYHZnX1VgyAQZh5QGkujW11E7jkfeU8Or6MQqfaW4zPE4cGc8xAmGJJUWIb9YAWjXzY0hKmHI9xpEG8tOohC8A5niOdrmdyOV4tB93SqSR/RS+fp5cQBKjvgp6xu/hqdECu+4W+0mkWCtFKgzf6zqmabNASpgIAPjKJpOFRw4poKOP9J60Qx77gYzb/DLGY8oIINZdZxQMzdkA93LyrLKl0a2Ol1lt5Z9vouYNlnFUs4IdrRpwLKX2wYKAenJ+E4Ybv14fjeHAM4UAiIulOot1KgRhlHYZleu86oNdC91CPsOnTbkU9S46Yr9rgV8ZCPw48BsreVEFJT5oVepLKO9y8h4VZ1hL/4BO2ZA5sMtiih0+lKwwAIUzOHvVMHdSwsah7yLOf4kCyfmu6W3zkRiM+y4aemiq8g1KDn1O9MKNuxlGHFfwVf2xMOa6MPqSExV7VA34wa54VvwQGobvK3pSZERVPlje97VY8gRxhZmquPx3QhPgwuR2MpRvg=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzlNNmZRaTd0MFFxd05uMjhESkplQ1FsdW5NOCtwSlhoR1Z4aHRnTXlTTllu?=
 =?utf-8?B?SjNBdzZsbGoxY2ZZQXVCN2Jkdm9BQjB6eXpHblI2encrREZncXAyd1dDQzgr?=
 =?utf-8?B?ek1LV3p6UnVzU3pDMDdwYWhpa1FWckFkQUE3Q05nTUtUa1BqL0tIM0NQWHVH?=
 =?utf-8?B?TzRKS3Zkd1UvdzVUVG9CM1Q1RlBTSkkxVVUrWUFKUGo2OWlscFI2Zklkazdw?=
 =?utf-8?B?eURORTdwS29QYUNEWHRIYjg3akRibWNRL3J6c1VZY2dEZ2J1Y2xramxpc3M2?=
 =?utf-8?B?NHBaUStxUkFYY3ZkY2hqMVFDMEE0dU8vS1ZFWHB2VWtnbGN4S1NDcTBvOW9r?=
 =?utf-8?B?Y1NUaUt4MWdId0w3akl2NU0yWmJ0VnB5Zkh6U1oxZU1GUXlaVy9xMDlYM0RU?=
 =?utf-8?B?aTFtY253K2VNOXZTZWxoTGN5REJTK25Mc1ZRQW96M1pGMUorSDEwMU9YQ3J5?=
 =?utf-8?B?aVVUMGx3R2ZiZHp6T0RUMWovejVlbTJ4QUVCQUJoSFl6R3YwR0pvTmhOVGlF?=
 =?utf-8?B?Qm1scitOckgwc2FvVG8rTXFJTzRyb0Q2NUlwZUdVckFsaldRUnpQVWh5cmFO?=
 =?utf-8?B?YTA3cStyTkZRSW1XNXB0d2NnTnBoNjJFbzV0RVZha0hxWjlkNUw1MkFsZGQx?=
 =?utf-8?B?eWJMcDZidzR0TENXWUxOLzA0WDNUL0ZnMFd1SFU1MGcrLzA4cGU2RUgvRXNG?=
 =?utf-8?B?bUZ4SHVSWE03Nld5YjVXbnRNVWEybitmTDJWb01BeHcvdCsyQSs0OFlmS3dS?=
 =?utf-8?B?d1NuajlTaC8vMyt1MGdLcStQdFBPZXIwWmMySUVOWFBIaE54bzI2U0kzSzla?=
 =?utf-8?B?bDR3Wng5SEJSRE1vdnBHU1V0ck5mUVVVcWJxNlFxNHg2dzQwNEJFVHNyVUdD?=
 =?utf-8?B?THJhWkhKYUdUQVZWRFNjNnNNV1RSNzN1bCtSRjlsZzJZWUlnMkRacitRTFlG?=
 =?utf-8?B?c2NOanBWcHBad3paWHErbEl1RDMyVmIxcXhybTZZd2d4bWhJczRMNGxoUi9L?=
 =?utf-8?B?MWtoNDVwK05qa0JKemZXQUhOOUZLOWxNL3NvdnlKMkZTekZENmdHdW16UHly?=
 =?utf-8?B?djcyMUpmS1hzcXJoV3llNzh4QnVjU0txYUYvOGduNU9TNkdxMWw3VCtxTTM1?=
 =?utf-8?B?ZG9DK3NJQVhaV3VLTk5UNUtmM0xUdWprRXhNNm9sR28zejU5Y2pmUDdaSmNy?=
 =?utf-8?B?czFmU1ZJNFJkbEkvVkhCVjJVVjhpdWhCT25VZDk3cm16aVRVY3I4bVdjNFJC?=
 =?utf-8?B?UU1BMkFtZkdNZkJhcUIzUzB2YnJUMUJBMzNzNGxpUXEreUU5RlptZlk0U0hB?=
 =?utf-8?B?TzdNMmlmS3BTTzg5Y3NPRzR1RE9wRUVNK0NkOWtQUXlsUTlVKy9nczUvM0pj?=
 =?utf-8?B?S1U3Zno4YzFQbTV6K0VXU1FKR3BKTDNCVnlMMXJEUDd4WlhTZGZmcmt5Nkts?=
 =?utf-8?B?cUViL2hoMmFVejlKQldlSkhEK080bjBmdnAxMThmdUtWNDQyakVkdXpXcmph?=
 =?utf-8?B?RzdxSkptaWZ3VzI3SFpieWk0c3ZLQ1Nud1IxbVVrWlNYMjVnS3NGOVoyb1Ew?=
 =?utf-8?B?UjF6SlZNNktnTUQzbWQ1OERJdG04YXRJa0VJT3lDWk9pK1llM1VUMGVQaUhm?=
 =?utf-8?B?UmhUc2twSzdVMWF4S0dvYnVVbzg2VlZmNnpTQjdDRExkRXFqSFMwR0xDcE1i?=
 =?utf-8?Q?6EuJvipXbPWae8/LSJDJ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe218854-03c1-4476-70b7-08dcf29890fd
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 12:53:46.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0P287MB2056

Adding another email address of Uwe.

Hi, Uwe, not sure if <u.kleine-koenig@baylibre.com>is another emailbox 
adderss of yours?


On 2024/10/22 8:00, Chen Wang wrote:
> Hello, Uwe,
>
> If it looks good to you, can you please apply the binding & driver 
> part of this patchset for next v6.13？For dts part, I will handle it.
>
> Thanks,
>
> Chen
>
> On 2024/10/16 8:19, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add driver for pwm controller of Sophgo SG2042 SoC.
>>
>> Thanks,
>> Chen
>>
>> ---
>>
>> Changes in v4:
>>    The patch series is based on v6.12-rc1.
>>
>>    Updated driver to set property atomic of pwm_chip to true as per 
>> suggestion
>>    from Sean.
>>
>> Changes in v3:
>>    The patch series is catched up with v6.12-rc1. You can simply 
>> review or test
>>    the patches at the link [3].
>>
>>    Add patch #3 for dts part change.
>>
>> Changes in v2:
>>    The patch series is based on v6.11-rc6. You can simply review or 
>> test the
>>    patches at the link [2].
>>
>>    Fixed following issues as per comments from Yixun Lan, Krzysztof 
>> Kozlowski
>>    and Uwe Kleine-König, thanks.
>>
>>    - Some minor issues in dt-bindings.
>>    - driver issues, use macros with name prefix for registers access; 
>> add
>>      limitations comments; fixed potential calculation overflow problem;
>>      add .get_state() callback and other miscellaneous code 
>> improvements.
>>
>> Changes in v1:
>>    The patch series is based on v6.11-rc6. You can simply review or 
>> test the
>>    patches at the link [1].
>>
>> Link: 
>> https://lore.kernel.org/linux-riscv/cover.1725536870.git.unicorn_wang@outlook.com/ 
>> [1]
>> Link: 
>> https://lore.kernel.org/linux-riscv/cover.1725931796.git.unicorn_wang@outlook.com/ 
>> [2]
>> Link: 
>> https://lore.kernel.org/linux-riscv/cover.1728355974.git.unicorn_wang@outlook.com/ 
>> [3]
>> ---
>>
>> Chen Wang (3):
>>    dt-bindings: pwm: sophgo: add PWM controller for SG2042
>>    pwm: sophgo: add driver for Sophgo SG2042 PWM
>>    riscv: sophgo: dts: add pwm controller for SG2042 SoC
>>
>>   .../bindings/pwm/sophgo,sg2042-pwm.yaml       |  51 +++++
>>   arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   8 +
>>   drivers/pwm/Kconfig                           |  10 +
>>   drivers/pwm/Makefile                          |   1 +
>>   drivers/pwm/pwm-sophgo-sg2042.c               | 181 ++++++++++++++++++
>>   5 files changed, 251 insertions(+)
>>   create mode 100644 
>> Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
>>   create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c
>>
>>
>> base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

