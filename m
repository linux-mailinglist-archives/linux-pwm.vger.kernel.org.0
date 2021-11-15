Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE26E450757
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Nov 2021 15:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhKOOpZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Nov 2021 09:45:25 -0500
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:4978
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231594AbhKOOpR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 15 Nov 2021 09:45:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRriejaWSFnHX2G43gvGoMlK3lFU15QDycIyTLWVJOzRHrHQ9XMTDv/8af6V9AckaogGaFVxCHs4shvOsRaS878F+cqLhsRp0JEw3J2iLaDjChr4V+MEll3C1A/Rqxu6tD32pRwhor3ClDHpyGfVgH/BZNh9AECBIHN1Cj9NtVzu2/jhuLpWX1UoyI5qz4mvq3DWzzdFf7/G66KtU4u3P6P8eRmGRUpeA/r0387Q0FuaX/wDM9wkjwtWyUoguIMub8YPqB06GkNUyMZOf0OMu+nPjc1toB+lYNcYm4B9FeZTR2v8nuDMWJi/+tBPYihn4V6bnDfRX1JLarHkXx/L1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TM7DAkkku4L1qtDLplRHtgglMOGc/Ln9Il9p57Utdss=;
 b=EFRNAnxPonSqdoib3Jr5mxpOlHPYoFsuGrG6BwQe473ueDiDd3GF6OrnvEvzS7P8tt8FWMOxue4vOpeXFf8Dna2HXXE6Hb4PlyIYTYq7Kr1ErrI/3LoNJDvzkFf1AC2083W49646fuLuj491Be3q88UTB9uQowMTZkenmTizXKKV/p4BC8m0F6rSqaTPhWprxGwCnm/dv/B+YDceg1bopc0kY0Yf/9wIq2J/12/oXQ3F2cPYyaED44yihcezgLAQCK4y3WXCsn/keswTvNBCVpFeR50dVQlQaSaxW/to+QmFyzHKl3uOJpAazzPdhgbMVm5DP9ac56gvuBg7tXTwGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM7DAkkku4L1qtDLplRHtgglMOGc/Ln9Il9p57Utdss=;
 b=duonkEGI9pT17sMXCh6bEVq8eUcyr0VAwJuDN5SZ3qaT92gConAzgDxn8k4PKbZKN3e3WkwjtRWpZmg9ChEkQNSgH/ICXv4gPQrAzjBXdKZHTV5Fdy9Boz/fWEkQ8M+NCvO2j1AVoYJyZJTHwWBxQlBt7opDp1icnSJubpDjIxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0301MB2440.eurprd03.prod.outlook.com (2603:10a6:4:58::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.18; Mon, 15 Nov
 2021 14:42:17 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4669.021; Mon, 15 Nov 2021
 14:42:17 +0000
Subject: Re: [PATCH v10 1/3] microblaze: timer: Remove unused properties
To:     Michal Simek <michal.simek@xilinx.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20211112185504.1921780-1-sean.anderson@seco.com>
 <be09f273-d8eb-7d23-c1de-58c38ccbb421@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <5567732c-6bb6-0496-6c11-5885740e12f0@seco.com>
Date:   Mon, 15 Nov 2021 09:42:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <be09f273-d8eb-7d23-c1de-58c38ccbb421@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0061.namprd03.prod.outlook.com
 (2603:10b6:208:329::6) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from [172.27.1.65] (50.195.82.171) by BLAPR03CA0061.namprd03.prod.outlook.com (2603:10b6:208:329::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27 via Frontend Transport; Mon, 15 Nov 2021 14:42:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4ec8275-2851-48e0-a993-08d9a8461f4c
X-MS-TrafficTypeDiagnostic: DB6PR0301MB2440:
X-Microsoft-Antispam-PRVS: <DB6PR0301MB2440AC6867A8BADFC89BCFD996989@DB6PR0301MB2440.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 19FZWimv5B3cJWV1B+9TkHPqt/Xhxp83i23Z3lNQlpmGQijIQPhDf/CN0O9L77ymGQYOWG3v5jh6cL9wImSNn+prq/BLDjjEgkTOXjAaFfXt5XXNmbaAs8nvXP9ykamFixNsgCENuQNuD1Zjpeh+wkzaPbNH4fL9d7/SphiO4/JHez0Z7jzRbmzevj7LSzknt6a1j4edNTQ/UBPps6FSr4w1munSDw1hFj9KwNe9/xcISGkuBQjDh9frHqvVAMFaoI+sPuJvjHvFjdIgfb4bAEc/N2vHFvN+/FsVRZIwPGBJT+PXrU77wKsMdRGS5xI1zzv831Hb9NcFArxBYavUxQHe8lv1FBLNG4xdVmZjW9BrebJ3fQa66ploS7ob6E/wAFoXVaVazETweGAC13HfcA+mYu/0Ed04iP+uNdSs1umHmVM1YmRjR0kxP8J/lAwo8ID7anH+TP+qiLpZ6qeHc6z98Eu9NCoJyUuDhK4exzSIidRoBSBDd2blIc3ReLwSdo2mfqhlFaJDcQmYFHQGflHdPo0cgo057aW+F/g/nZyK0rTykqS14oPOUbvjzcnRI93O5koXNdX6BrsA18ILN4IGbtj17hMZXZLHFRvOeF4g5y2OrzB/cn8PQwMaWgt2xfPfu2Oo/Tbw5Lqw0uelqtrbBTxLeHnHMB/kThfxVD4Od//BFlewT0Huv0y2aZhjrdkCMeLhU0qjNlsfBTw5UraRZx9a/3BW7G/7wt/AasT/+MhsXe180zreWglhG827
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(53546011)(54906003)(8936002)(31696002)(5660300002)(956004)(26005)(186003)(38350700002)(8676002)(52116002)(7416002)(38100700002)(36756003)(4326008)(6666004)(6486002)(31686004)(66946007)(2616005)(2906002)(44832011)(316002)(86362001)(66556008)(16576012)(66476007)(83380400001)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUd6N2JvTEdBR1JzWDA4TitaZ0VlWENRY3JybVkzcy9ERVQ5N1BHaXNCaUk4?=
 =?utf-8?B?V01SZ21GTURybDhPN1BRRWFnUEttLytHclBOTVZmUlVSQnl3OStwUmZVeEp0?=
 =?utf-8?B?YzVyOTVocEcxYmJYWitZL2hPTzI0Sk9xdUNoVkIyVVhZUXJHcXc2QjZNaGN5?=
 =?utf-8?B?Ym1HSStPZmJZUis4QkwxR1dFYjRuQ3FxZVpVZks3SnFNMFpFVmtpT3V3SFZj?=
 =?utf-8?B?Z1p1d21aR29XSG1oOEhCWDJnOFV4QVNmeEw3Z2k2cEtTVC91ZmsrWE1lYzJC?=
 =?utf-8?B?dTYwZVBURzZKNGw2eWpLR0dlU0NxVm1uTGNRakVCTTd6QVFpVFR1YktGSjg3?=
 =?utf-8?B?Z1JoQ1V3M21Ua0RWVVRhZ3VIeDVHV1hxRDVpakpRUDcyRmZIUWVLTkY0VkZL?=
 =?utf-8?B?NG9TQ0ZjN2VpK0dNaHVqbnhRTU5LbWZwYTRlRnhFU0xHdVMwS21wMEsyTVhP?=
 =?utf-8?B?b29ZaXdqRUFZN0N3S1hHVEtpVWxxNTNKdUl0NUZpdE83SGJTY3NFdnNBKytm?=
 =?utf-8?B?UzU1WjY5cUwzanArb3Vsdklva0VYTkd1bzZselhjTGZvYkRzWWY1NUxBbHJ2?=
 =?utf-8?B?ZllZMGhnTjJHTnlRWTJTWnlzdlp0SE5RMTdrTHdPcTRzZHIycVZxNFRkQzds?=
 =?utf-8?B?RktCVFV2dW5ZSlh4emlEYUJwYXE1Qm40NTdPeHZ1NzFDUEdEVWlJTllyNXJy?=
 =?utf-8?B?eXJNYkNWaWJPZTl1Zk1IYWlUZ3RoQUE0emlKSzlGMzVUbHpSa3g4Y3lLeXJG?=
 =?utf-8?B?bXh4Y1pwaUQ4bUZUUDJ0UW42VGNVbDRteGdRSmphRHJVQUVoWjlKaGgrcXRI?=
 =?utf-8?B?VWxHQStYbWRSQW5KQTdtSmZ6M2Exa0poeVIweWFqeWw1N3FKemlTaUlpbmYr?=
 =?utf-8?B?NVBXWlRWZFpZNGhXR2lJZEQvVmlGZjgyeVNtZlZ3a1ZNWTdZSkF1T1FQMTlm?=
 =?utf-8?B?V2pCcXlLemVibXZOampFK1J6RExsYXNVUGlvTjNwWFcrQUNxeDVFdGxFbW44?=
 =?utf-8?B?Y0d2bFkyY1VnSFlxM0kxcml3VEdIbFRjQ1lMd1RCSytibHNLZlZwekZBdW4y?=
 =?utf-8?B?YUhRMTNYdGtOajhDQk9kYno4Z0tPQ2xXNitJWTVWSGo5L3RPZklGV1pTdVRI?=
 =?utf-8?B?WjVCU21SSlkxc2pKWWtXUVF3TlMrNGd6YWY3bDVWN3JqRC8zbVNkK0ZXcUhQ?=
 =?utf-8?B?RFhRdXoweXk2eXBpY3E4QmFhSGFsdzRVQkVzSE4yYms4Y0FDWHFOTk0wNWhT?=
 =?utf-8?B?SjNWdVhNeWV0MTZWbThZVVZqN3kxTXJGcFdYN1VQL1hpSXMwUWEvcTdoa3NY?=
 =?utf-8?B?ZFNuZVppc2h3SWU4OEdSRXRXbWtLcXQwZElob01ud2VSV2hRWGFuVHFVRVdJ?=
 =?utf-8?B?c0pQcnpzRVRVbXFuSU1NY3NpTVAzcGQ2M0R0OU1hSXc5UWY4VmxMdW80c21s?=
 =?utf-8?B?ekVRRFgxSEVPclcrb3hOL1NqclRva2hQenIycWdnNWhRVU10M0d4N2xRMkFl?=
 =?utf-8?B?ZWtZVjdyd3A2SnhiYWpiUFV3MDFmUHlDaDBsT0FUQmtGdVlZbEwyMWsyemk2?=
 =?utf-8?B?ZEtpcDYwUHM1ays3dXdRNFovSWhCeEI0Ymg3MzZaQnArRDR2Zjd1cXdscitx?=
 =?utf-8?B?blFhTExqOHpkc3RJcjkyMWZ6OEtndVNETURyWmpjNHNaKzB3cXduOUJKS3l4?=
 =?utf-8?B?VUt1MFNLVjl0WmtNZkhRNWF1SnM1bVZpRTlKR256RWorY0VFWS9RdmlDYVFT?=
 =?utf-8?B?WnN6NERjMWtGL2JRSjBVaXZ6dnZvWWdiUFp1WjVHYVJZVmFuT3FpSjdpV0pn?=
 =?utf-8?B?bXZVMnRoSnNYQTBTUTZWUjl5Njk0dmN6TU5TZ21BNkpTemxmMW4wSmIvK1RG?=
 =?utf-8?B?am11TnJHT1BMbkFlSzROMkV2Y0ZzajdMckRhMWhodk5zQkxRVU1zMU9sUTJ5?=
 =?utf-8?B?RS95VVFzbkFGS1FpOWNPdVZ0LzFtWGVMaXVLaTY2WEFxNVZBNjRSNiszc1dY?=
 =?utf-8?B?UlNzSTNkQmJwYXU0SllJclMyNXpKY0hUb28yTFp2SzFTaHpONU5odjYzcmV1?=
 =?utf-8?B?UFlzMlY2SmF6QlBwNzFKMjhJQ25mMHQwWm9kRnRKK3hxbS9yS3BSajRTYzJr?=
 =?utf-8?B?VHpCUHozcjdic1V3NENuNWZVZ1ZxMkM5Snl2dmpRTXlmWjZsTnJJZTRRL3kw?=
 =?utf-8?Q?LKDKmxtHgVJ9QuLVeqzRAP4=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ec8275-2851-48e0-a993-08d9a8461f4c
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 14:42:17.7238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XiOo+ITsvTyP9IAjDRb4PNXRURh3M3m5WR6bVQbEERlrH3s+k5m7m3ibhIuQrfgB+mVLtlgNom2KsbcaxVeDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2440
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 11/15/21 4:27 AM, Michal Simek wrote:
> 
> 
> On 11/12/21 19:55, Sean Anderson wrote:
>> This removes properties not used by either the PWM or timer drivers.
>> This lets us set additionalProperties: false.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> Acked-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>> (no changes since v8)
>>
>> Changes in v8:
>> - Remove additional properties from microblaze device tree
>>
>>   arch/microblaze/boot/dts/system.dts | 5 -----
>>   1 file changed, 5 deletions(-)
>>
>> diff --git a/arch/microblaze/boot/dts/system.dts b/arch/microblaze/boot/dts/system.dts
>> index b7ee1056779e..22252451ec09 100644
>> --- a/arch/microblaze/boot/dts/system.dts
>> +++ b/arch/microblaze/boot/dts/system.dts
>> @@ -347,12 +347,7 @@ xps_timer_1: timer@83c00000 {
>>               interrupts = < 3 2 >;
>>               reg = < 0x83c00000 0x10000 >;
>>               xlnx,count-width = <0x20>;
>> -            xlnx,family = "virtex5";
>> -            xlnx,gen0-assert = <0x1>;
>> -            xlnx,gen1-assert = <0x1>;
>>               xlnx,one-timer-only = <0x0>;
>> -            xlnx,trig0-assert = <0x1>;
>> -            xlnx,trig1-assert = <0x1>;
>>           } ;
>>       } ;
>>   }  ;
>>
> 
> 
> FYI: This is merged to Linus tree already. It means you can remove this patch from this series.
> 
> M

Ah, I didn't realize since I had not seen any message about it. Thanks for letting me know.

--Sean
