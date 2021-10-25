Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3869E439DD9
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Oct 2021 19:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhJYRtc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 13:49:32 -0400
Received: from mail-db8eur05on2073.outbound.protection.outlook.com ([40.107.20.73]:11835
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233136AbhJYRtb (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 25 Oct 2021 13:49:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijj2JCIhytShfPfUe9T/L8tXYNDuoXn7KrqakvsOyYQg0YLK3k9jdyt9dI1OVRn47doBwI3z9HYtcnfXYKu8vq3impjWZ0CvNCQdzipg0QkamDr6zHz96w+ZORvgpupY8ZJ/X6Kze6GwgGsP0f+qN/RJc4k7o3D+b3/QpyoFHKQLPYuSYGCl1cajdo0iNQRNLdCzNR19b5WbpvB6hdNuPO0kwiZ3gulmDmJF8ADbqnlnjtutdwE0u0ZVD9SuG1sUx8f+t48Oyq1X1DF+cDEdlC2OQUKj/hNJStmWKGNWLjlh34HR57ZVcTI2doGUjTlBVoduQ3Pr53Tf1bKV0zS+sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lNZ1zEqFuhhJkzv1XD8tHZE8Ur0AEzlJ0xt7qlWZls=;
 b=exEM2UJo/ws0KoF0CXEC5DSGqN0gmirvpejQGJrA7f2FqtDhGZohbP07NAGeBlNQnNGdZ0C2hRuEVSw1YoqBCJc2X4BpdStx3kUkuw5l48Dp2kYKntC05BlCmI6kuLgY1iw/mWqla1eGGjM6+bdR9Wdxdz/Unaj61D2hvGWepGeXzLayAaF8ePKcjYCRl0PpWZ3FAez/JJf73XpGQxs2vOJEe6LPbK6vmDE7ugepEmcczgJVI0CO22PZt5wNWv3+o/MmqHTpPgx8ejDHzeCBKo0hadG20M10dFh7zGO6HzlBiIS8dI4BLpeD+YcEFO0zo0S54Tp7DhrNXiz7qJHr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lNZ1zEqFuhhJkzv1XD8tHZE8Ur0AEzlJ0xt7qlWZls=;
 b=u0xe9iny91urcR2Ldlps3MYaX5mAvnNp7x0QCl2hPlBFYuyWvwg78NnsSgt7o8Pynqp+B8cLxWkdPEvixjUgmJNWsztisbwGcIRR5f9SvuuCIeSYcbjrozKeNSIthnAVVjB5oBkN4XZYUnVoZuuyrQJzaprytoj20YjBsRL7Unc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB7PR03MB3964.eurprd03.prod.outlook.com (2603:10a6:5:39::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Mon, 25 Oct
 2021 17:47:07 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::a9aa:f363:66e:fadf%6]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 17:47:07 +0000
Subject: Re: [PATCH v8 1/3] microblaze: timer: Remove unused properties
To:     Michal Simek <michal.simek@xilinx.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20211015190025.409426-1-sean.anderson@seco.com>
 <676342e6-b174-ad81-7a22-3e3e27090654@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <925b0285-1cf3-99c5-e489-b9fd9137a972@seco.com>
Date:   Mon, 25 Oct 2021 13:47:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <676342e6-b174-ad81-7a22-3e3e27090654@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:208:fc::41) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from [172.27.1.65] (50.195.82.171) by MN2PR02CA0028.namprd02.prod.outlook.com (2603:10b6:208:fc::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 17:47:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3d8b917-7c7f-4132-8621-08d997df7651
X-MS-TrafficTypeDiagnostic: DB7PR03MB3964:
X-Microsoft-Antispam-PRVS: <DB7PR03MB39647A7F4BBCA0AB5B32342796839@DB7PR03MB3964.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0AFCctNsTYWtwUx6cTqmU4SgSWI/CTgMnLscEPk763Qopca5NkK5mYePTrnjrRsm788Yn5cG2HMPXYhzYeBc9dSP/vTf3+HDQOvuwi5JivDgt8dqG0nM7S5tXLBts7ttAZ8bHdfACXuwodEndgMMeAFVaYDNISnZurUetDXYz8dkpHyXRFNKLQ2i9bNMCtMi4wczSsRaEM4B/KHAAt66mB4MXeV9oKXFvVdXjH/ErQ18MssW5oAsy31NvTRvzYO0IDEnxch8wV3aXVgrsZWhR4XQL+wNlkI9h+/zpDsYmHdJ0U/IlAEty3T+0CCEZbm1GiHTbR1L3DfyOgj/x56TyVIpaMBQeapXiPFyKt6vfMGqTU1CBzhvwrNSrvnam7DtXp+DSE7VFLETXjl+XruPaZ6wB+1wtHE/VYMh0B5PNfd/LZ1pogTyDpOt5TOLwfX9GdrrTo70Th9+S9FugI/EOUUSH/OjjWulK7WRIQ11LS5Osd3kIZU3PSA5NiQO6V9bP98m9cypPADAZIYoHQnyOagQVJXbtlXC32h8n2X4oWY2i8756m5+SbMkQBxBuoOHnHsg4fCrx9hoOkzCl0rYnVjtSy+TohtXf5F94GztVxtZza31qRwvA7TI1jHhqnvCotR5JiW/cJRvxsdJgQemmRfXYCXY2zrfML0TyCQOg4j3MBrTXc+lfgmy7yZvgXFOP5Z/DlwNtfHxQD2ddwDfrhA3LKDU7V71ZZAPM2ui/gNmQ2fDpJK/fuyUA9Xl1A4eCHu6D55/3yqSMOGxfJtMeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(6486002)(54906003)(6666004)(956004)(31686004)(66476007)(508600001)(66946007)(316002)(66556008)(36756003)(52116002)(26005)(83380400001)(2906002)(31696002)(38350700002)(38100700002)(8936002)(186003)(4326008)(86362001)(7416002)(16576012)(5660300002)(53546011)(8676002)(44832011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VS9iZjMrTlNxalUrZG45dmYrb1BNbDJsSU0zREdhNElTN2JPZXBZd2lpaDha?=
 =?utf-8?B?TzllWnZHS3hNbGdKZVcrWXdoaTJ1dFYzYlVxd2lJdlJkTzl2QzZKOVhzSmdR?=
 =?utf-8?B?bTBkSWd2blM2ekhyRHpZRi9WTVdvcnQxbjh1ZWQzbXhpUTVvRTY4UHpRN25y?=
 =?utf-8?B?blVBME5kRVVzNzc0cHpWZHNvZjdXUnlKVFhOYlF5d092ak95cVFCMmhyV3JQ?=
 =?utf-8?B?dHYwT1NyZHAwMFYxWlg4T2NlK01DSFloKzNHQWZ6SDdSSVU1WW9DMW94Zi9I?=
 =?utf-8?B?VjdGWXkzZmE1TnJocVlZa0pBYWxaSUNva3FBdkFWcVZwdGUyd2VoVEFGS2dI?=
 =?utf-8?B?ZjFOMmRWM2gwK0Z6Q2xRWFc5UkdGS3kxQ2pwYTNGN0tMcDZEL2c3VzlpZW1W?=
 =?utf-8?B?OWtSR3JheGdPWjBNcG9vWWg5aHh3ZDN0UWs2Rzh0SFZwOFdLei9yRGlXWXlV?=
 =?utf-8?B?TFVEMkVLdzEzc3NDVWVCdWRmY2JIaWVLTmRDMEM3dk9GYjdia253WW1pcHJ3?=
 =?utf-8?B?VURYKzNxSmtJSGZZYjlPOU5iWGdNTEUrMXBSTGFWaGxSbTdaN2pUK1dTVVVE?=
 =?utf-8?B?VHVuMk1tQkZDay93K1Q2ZW5FQmlqSWVmVXZ3blpIOTZkU09BZUJZN2VuYnBP?=
 =?utf-8?B?U0VmcStBZUZCUk5PYXRONmFLL0J3eFc5bDFJVFhjSDFKVzR2cnFjMGxvOVlZ?=
 =?utf-8?B?bnl0TVFMSmptRDFZZHQ0WkhCdmwrOUhJU3g2NmZZRVY1ZHRyWGlBVnp6MTdk?=
 =?utf-8?B?NEpOZWo3c0NQTUFrdWdJcFlEd2hqTVA0Z1ZCdmpBNkU4UmVSRHZvRVJNbW5p?=
 =?utf-8?B?REo0ZE9veXMrTHBsRElBUTVwSnVFeVpjdVorSFNUYkNIb3ViUnAyeXpQMTQr?=
 =?utf-8?B?c1g2aG50NlhKRTZBWHRPdUtjc0hSWERTMFNvS2dRNVcwVU9PdXpUWjhNOVNR?=
 =?utf-8?B?RDZLMlNkajNla1R3cEpvdE01MTl1bEcrTm0wTzdSdDlQY1dzZnM3MWFBR1lT?=
 =?utf-8?B?Z3A3RWp6aUtma0tZTVhSbmR3UlVweFJYdVQ4OUhWZnhJWlZCL1ZDei9ma2Vy?=
 =?utf-8?B?a2YvdWNPNDl6R05qQW5ZdHVmbmptSnFvOFk5QTBKdHMvTVk1VEtyWEZIdmlV?=
 =?utf-8?B?MmlRdzJjaThnc0VUSlV1YmVmU0l3OS84SWthaUFzQUw1QzlDWld3cE9US2Zw?=
 =?utf-8?B?a2VOWW9ySytIRkZ0WWhOdHBlL3Fmbm9ZMFE1RU9kV0pBdVZ6NzQxV2o4Q1hM?=
 =?utf-8?B?WjVlNmxjakM5ZGJ5NGpqRVpOclBELyt5aXduaExxNlVzNU1zS2tVT1ZrOFBC?=
 =?utf-8?B?VEFEbysyQno1dkFHSDQ4aHR5V0ROZGlZMlU2bndYZWZoMlVJbTJncGVMdk5u?=
 =?utf-8?B?YkY3bTMwNDlFV0ljR0p1YmZ4TW12OVVBK21NaFZkZDEwTkIrMkY3VkRJK2ZL?=
 =?utf-8?B?WkFTSVRuV0MrWkIrSE9IZTVCL3ZGTXd0dHVhMWlFbDkwN21oMEhyR080aDRO?=
 =?utf-8?B?U3RTRXhUV3piM25sajJDcHErMjg5TXBEamxuSlJScThUNkFjY3NIYkNZV0xm?=
 =?utf-8?B?eEpRcWFtQi9XcDZuK1ZuRWR1SzBLN0pLMHkveEZFRXhEWm1aWDArRzQ3eHN0?=
 =?utf-8?B?VlVaUi9CMXpoMDRFRmtwaG96ejZvRDl4ZkRFK3lKVGFFTFg1ZythaDFOcEVl?=
 =?utf-8?B?K1MxOHJ5QkNtV0REaWw3dGdrQXNDcE1kTUVRWnpSRkVRMVprdnFZOEJGSWtE?=
 =?utf-8?B?TmhYWXVQcVAxMTZ6NWFwZ2dIOG5zVkpSN0h4ZGNhd3VGMHlRb0FiTCszc05Q?=
 =?utf-8?B?UnNwV210QUh2MTVuKy9RYkZiZ3BtT1lteTVJOGlnKzNXbnBZTlZKbGJpSHpy?=
 =?utf-8?B?dmNVTGlnWDUzOUlyNWN5V0xyQkZPaG5qRjlHU3ViWUh4WkVtZlQ1a0xXVHhT?=
 =?utf-8?B?OENQWkFDYkZZYnNSaFQ3elRwbXlFeVE2bWlXOEtmU0c4TmhlSXV3b016VCtM?=
 =?utf-8?B?TU5QVU5la2E2UURWV1Btd2sreDNzd051M1owdmJqbWNxTytLV0VtM2hCOSty?=
 =?utf-8?B?aFdiT2U5dGlYNXRzQ0I4dS8wTkRmZW1lTG0vSys4TWxDQXdzcXkwUWtHanhR?=
 =?utf-8?B?V21yYlpCdVB2OEVjdm1mbDVUTklFTHZMOE9SY0duYnY4Nis4Ykp3UzZtMkw4?=
 =?utf-8?Q?a4w2N0loMKWQCmpYA9kknwI=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d8b917-7c7f-4132-8621-08d997df7651
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:47:07.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IMXx+4U3XfDho4eSgdNKzitj2ZxsRm4B4mDVnL9B6RDOeXHj/7nk/kFWZ+MGbD9AknHAwQsElgcRsxhg7tThNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR03MB3964
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 10/18/21 8:15 AM, Michal Simek wrote:
> 
> 
> On 10/15/21 21:00, Sean Anderson wrote:
>> This removes properties not used by either the PWM or timer drivers.
>> This lets us set additionalProperties: false.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
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
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> 
> If you want me to take this via microblaze tree, please let me know.
> 
> Thanks,
> Michal

That's fine by me. This is independent of the other patches here.

--Sean
