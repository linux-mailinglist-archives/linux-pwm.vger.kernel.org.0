Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929D03D0409
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Jul 2021 23:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhGTVFB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Jul 2021 17:05:01 -0400
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:7910
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229684AbhGTVFA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 20 Jul 2021 17:05:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TZek1/dTfYVALUG6s8lCIK7OWRCjImJKzsUy3mjdiUK5V6nhfEy9x/ZhOSM0a9nKu773CMIJuhW4xXPsraQq+2Kjt5+JtLL3y2YXyrKvqwgol6EiQgBjb08LcadBM6dhkidkn7VSx4NTsR5J9fn8MlgG0+I84pzcDFqmqc7gScLzdyRge3j0jibajXrUzy7AIPNltf/jZi36N2AGZfPg2jCtjUTeG90AGTPB5swHlq/PBVB0yl8wREftVTzqgRhpOI/3YjsFmp+8bXKloMves2x68L2UKMNzE2MNo2Rh2TOg0qG3JnDX9pqFOESkuSWJ5m8dQUqdmlPsK9cMMLL5pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8/Os1NwiWqlvCH1FzPMPOg0rFtsCwABTUknXlbBCtU=;
 b=YtKr8ubr2FH53bvG3x0IOVe5cmfnuzO603u8kIeEksEco7HKzVfkWSMDLV7/hGscf0HxddNdHRBQRyht72PrjSXgFVC/CAw27YDgCJaKiH1taVqoorzJFVuWP5NPkUJ/mjyVHZ+kvCVfmE7M2vM7INg6Ewru0bMS0tOtFWBK2NP4o/V0SmG5BQK6nTW0NkwiyfpdtMq6Dk2xUvPY62mwbIM83jV3JxjnSxrEgBPFisJgQvojLDn+V9p+gsE4yjTBQ1mR66QPQRex9OdAkzkfsbTDVGBPlmMa07+zgotsRxEgwoskET0eAA4G/8ZvTr9qYTvZ7rXV/5BLHBUjX9dK8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8/Os1NwiWqlvCH1FzPMPOg0rFtsCwABTUknXlbBCtU=;
 b=cUmZhZvGqPVAraZ0mcAnLX2Y7hI43yEg/N0Nmlvs5smbbMkuINM6Xcge4VEW0jNdyuTZHY6ClSbzXrXrt9nOT9+P1wrbbNvb3WRckBvgX7AwaBpIc1u15Cm99wbpc+CaUNWc3L/JcyGEJdrvRVwUS3rKN+KKY23XCC8c6E0Z6as=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0302MB2822.eurprd03.prod.outlook.com (2603:10a6:4:ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.34; Tue, 20 Jul
 2021 21:45:36 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::dc6c:815b:2062:d1f1%7]) with mapi id 15.20.4331.034; Tue, 20 Jul 2021
 21:45:36 +0000
Subject: Re: [PATCH v5 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, michal.simek@xilinx.com,
        linux-pwm@vger.kernel.org
References: <20210719221322.3723009-1-sean.anderson@seco.com>
 <1626786718.716987.4121600.nullmailer@robh.at.kernel.org>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <33ed6e59-ede0-b1ae-cb7b-95b57b65f2ff@seco.com>
Date:   Tue, 20 Jul 2021 17:45:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1626786718.716987.4121600.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::26) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BLAP220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend Transport; Tue, 20 Jul 2021 21:45:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38e4a3c7-3e37-4369-8f9c-08d94bc7b549
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2822:
X-Microsoft-Antispam-PRVS: <DB6PR0302MB282279257DCC0AF2BC1FAD2196E29@DB6PR0302MB2822.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: felw8bS2KH6doVQbDiCtPr6ukGZDNxfemlj9mlrMN/m9fqUkNIH+nJJ8ZjQoGyKGLwcBcs/ELzqOiATJsWgRcAgnv+BUibDTCkv4hafeXddRTI1MQ3yBWusn2LtmYjT+qbCOfhRUORnE/d1a1tDMjG5x2FDErFSiZiGraeTFcEYUfbftPjCw3j6ANfGoT/0oQy8GnPqaEzf7kfz0J7ZbDQQLxtfK5WXwrm2fiIsa0Tow0o2jzBIoHfkN/R67eq7U1mbE6agxVBIbgRg/L6yZYKSH/96b2qRUzbaDVBYC9cn9FG9QAY4teS9wLw2MHqpIbt2iHkMQIXIQWc1mbWG2TblHiMWrsC6vMXLssHY0YmTFfEdl9Ah9bwwp+wKe1ZaQlKfOUpaxzRXMkLFMG7P6wGHJelktIbdocP2GgDJcHSV8ryTim1m4BhWn3QvpDyZZH0xmeIis2Q3gVN8MJ+O9stwkQGMIS1a6oRR1BQKhbShfEHxTdRpWrCJ9gv18beJVokIUPiL53yNiNzD1gvOZrmxW7mYNzFRsP/GllcFdcgTmos77NVatHo+S4+/Ekkwp88v8ddrKvavg7XpcdFT/ECPgrniZHEi6HVmtvvramd0IZ72fKHQirsyHuF4tj21lrejPuv6q45lcduGYuHC112FD7VAj8yFjEn+7pXIvOzuSx5DnqcGbqiFTjMttKAxIS1LjeZuhD4FgcNWtUcNJC8pmDl5kJ1Fcls0e1THTC9aNYUCexS7IJdT+NfSMx1AFjd/KveFz13ami7oS9slRy0B4MLK0z8kmf7ZxTf/lk0SntmqPUorW9Jqb5+443ibY2cUqWBxrVJMXb6nCcsdECu1lw0aQeWMK/hYmVVqLbaE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39830400003)(136003)(38350700002)(38100700002)(86362001)(8936002)(31696002)(54906003)(316002)(4326008)(5660300002)(6486002)(31686004)(8676002)(36756003)(7416002)(16576012)(478600001)(44832011)(6666004)(83380400001)(26005)(966005)(52116002)(53546011)(66946007)(66556008)(66476007)(6916009)(2616005)(2906002)(186003)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTZNTlV0bjZYYXR3a29mbzlYOEMyOXFjUVZZNlZqWXlkcUdyVEt0ZVdOOE9L?=
 =?utf-8?B?S3R2aWhtck8xdk43clczbEZhdTN6b0RsWmRiSnlxdVJrS3FRWlRBZGNYTkkr?=
 =?utf-8?B?QlowblVuK1M2c2FXYjFaMHRsNm5pTmx2SHRUR0VGNzEyd0lKYktMSHpRVzN1?=
 =?utf-8?B?cWNRVEgxdGFINjhydXlMSFozUllqbTRLQXIzZFJiNGYreGdWQXIxVllsZEtQ?=
 =?utf-8?B?T0JyVk1nd3hhRmF3Q3pjbHcxdVladG1IQ3MzQkFrZUluZDYrTWthNURtMUNj?=
 =?utf-8?B?ZkhYYlkzMTlLUVFKWEtETXFwYUpackI0TDM3NnhNdG5qNXhaa3FHdnNwd215?=
 =?utf-8?B?UWNoZnR6ZU42WEtaSHE0V3FaVEQxTStXempBWEZnYTQvREt5ajdNUUZORlRu?=
 =?utf-8?B?MnB5cTZxRUlZVEdHWVorUk12T3o4R3dKWklma2s4UXEvMTlDTm83eHhtbDIx?=
 =?utf-8?B?MjY3UjJZcnM2L085c3hKdk9SWWVDYzJWRmU4SFJnS1hmK29YOUdxWTllMXo1?=
 =?utf-8?B?R3pKcllLVUNwbVloMHQ4UzFtVkRTOXFwR1owRHZHVGxIV01md1N5cHMyb3pp?=
 =?utf-8?B?d0FvL0g3RUZZa3ZRd1ZPVEpMRFJLNllNbzZ3SUUyc0hYSnZVMjFQVm8xZTh1?=
 =?utf-8?B?UWVoQ3RnUXhVRzFjYTRjcExaeDB4cU1sTWo2VWRXYTVVc2NZTjNqdTRuZEY0?=
 =?utf-8?B?d1NXUGN6UGVPWTRhekZYRVlJYk1jVDlDdWx2Z0l6aVIvMFpDUzJ3SEtnNUIy?=
 =?utf-8?B?UE84TEJDZ1IvT3N0L20rWENDSEZXeVVtMjNwUnMvcFhKWXBjVWNDWklTWDNR?=
 =?utf-8?B?bXlmK2c5dk9WeWtmb0lURlVBT3VwdklwVFEwYzZybnRpTmYxZzg5Z3BROFJj?=
 =?utf-8?B?czd0MldJSmNDbXMyYUdRSlRoWHZYcFNHajJXV3lXSzkyeUJqSFNPRjRFVEp2?=
 =?utf-8?B?RXZWSFVEdlVaditJeXVJRHA2MFVnbmdsY293MGM1Si9lS0xGaDZLU3pZNEFC?=
 =?utf-8?B?MWN0a200b0hvK3c2dTlKR2gwYkpYdmlNaW92UHh6UWpBMzl3dXNIZkloSzhq?=
 =?utf-8?B?T2w5Z1VPNDBZOGVaeE9vaWY0WGFRWlZFZ1VIUUZWSGtWMEVQaGtsVWpHSDk3?=
 =?utf-8?B?MmtZQjkxZ1A2OXczdERDZGxQaW0yVXBDTlhVbG95RmlXZ2ZMT1E3WkRvQlgr?=
 =?utf-8?B?bWdJSHdJc2tkVC9uTllZb0ZsYjFJWkoweG1qc0NBWmtqMzZDNjdBeEZHTU9m?=
 =?utf-8?B?dm9EcE43b0V6SWZuLytvVzNJN0JqdDQwNlhadGVlK1ZrSEcvd2hCR2JheVJs?=
 =?utf-8?B?NnFtbjh4aFRSS25nS045SFIzSldHMDRxbmhmbHRWUVBJQW42WDhQMG4rY2RP?=
 =?utf-8?B?TmltdHcxalZ2VDB2Umc3dDV4VXZSOTJpMks3Uk1ISXdaRWt6OXV0blo1TWtP?=
 =?utf-8?B?R3ZNdzJSWTJqeTZ5ZkFkODl3VkVsVWZqc0tqMVBzZENZVFZrcmlJYTRrWlY2?=
 =?utf-8?B?dHc4SDJZTWNOUXJZS3VYcW1tdXhhVUNjc1NlUDVrd3VoeUJQc0hWQ3c0OEtW?=
 =?utf-8?B?WGlqTEgyUjFsQmc1dDRiZU5KNGNMWGNmOUhFdFVjd2tKV2xPaUNTUjZ4T2xy?=
 =?utf-8?B?NzB5MHVHeFhTMTZCdHhKT3hTT3BXckdOcVFFOVdocHNSTGVNcjdlSS9pR0g0?=
 =?utf-8?B?N1Vlb1ZyRGl6YlZyMk5iRHc5My80bUhlOElEV3JVTDJaOWpFTUQ5MG9Kb0ht?=
 =?utf-8?Q?D/ju8TYhbDtb2XiYVni/J/vmdQe8pLD0CBpAH9D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38e4a3c7-3e37-4369-8f9c-08d94bc7b549
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2021 21:45:36.2367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESdaY1c+u00cMWW6812Yk3xhTjHZ7vkHxe5G8c9nhEjW+u0VJzETJjL4TeczDt94trGJRjvQWMsun6j/vSz4EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2822
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 7/20/21 9:11 AM, Rob Herring wrote:
> On Mon, 19 Jul 2021 18:13:20 -0400, Sean Anderson wrote:
>> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is a
>> "soft" block, so it has some parameters which would not be configurable in
>> most hardware. This binding is usually automatically generated by Xilinx's
>> tools, so the names and values of some properties should be kept as they
>> are, if possible. In addition, this binding is already in the kernel at
>> arch/microblaze/boot/dts/system.dts, and in user software such as QEMU.
>> 
>> The existing driver uses the clock-frequency property, or alternatively the
>> /cpus/timebase-frequency property as its frequency input. Because these
>> properties are deprecated, they have not been included with this schema.
>> All new bindings should use the clocks/clock-names properties to specify
>> the parent clock.
>> 
>> Because we need to init timer devices so early in boot, we determine if we
>> should use the PWM driver or the clocksource/clockevent driver by the
>> presence/absence, respectively, of #pwm-cells. Because both counters are
>> used by the PWM, there is no need for a separate property specifying which
>> counters are to be used for the PWM.
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>> 
>> Changes in v5:
>> - Update commit message to reflect revisions
>> - Fix indentation lint
>> - Add example for timer binding
>> - Remove xlnx,axi-timer-2.0 compatible string
>> - Move schema into the timer directory
>> 
>> Changes in v4:
>> - Remove references to generate polarity so this can get merged
>> - Predicate PWM driver on the presence of #pwm-cells
>> - Make some properties optional for clocksource drivers
>> 
>> Changes in v3:
>> - Mark all boolean-as-int properties as deprecated
>> - Add xlnx,pwm and xlnx,gen?-active-low properties.
>> - Make newer replacement properties mutually-exclusive with what they
>>   replace
>> - Add an example with non-deprecated properties only.
>> 
>> Changes in v2:
>> - Use 32-bit addresses for example binding
>> 
>>  .../bindings/timer/xlnx,xps-timer.yaml        | 91 +++++++++++++++++++
>>  1 file changed, 91 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
>> 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml: $id: relative path/filename doesn't match actual path or filename
> 	expected: http://devicetree.org/schemas/timer/xlnx,xps-timer.yaml#
> \ndoc reference errors (make refcheckdocs):

Ah, looks like I neglected to re-run tests after moving this file. Will fix in v6.

--Sean

> 
> See https://patchwork.ozlabs.org/patch/1507329
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 
