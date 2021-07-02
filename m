Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0C63BA3A8
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Jul 2021 19:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGBRee (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Jul 2021 13:34:34 -0400
Received: from mail-eopbgr40051.outbound.protection.outlook.com ([40.107.4.51]:11086
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229455AbhGBRee (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 2 Jul 2021 13:34:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cRuWPrxD2adJr8HR53uvtBoyNShpuEM68aVnmTkvTRqi/yji5QUmYU/W+P08VUP4xTd3Es+04WypNp2nWW4M27k8YJ3XjwtI/KWBBVnYI8X+X/Teu0ii6vgFes7gouhoHpeanYXBjPt3MKe9hsg/dK2s7NqZCp4N1QSf3olLW7fz8nJYkeR/MVeLla9JcETORSpvLMC/zCrs8h9LZvYX1mnBMbLJxoeGGWFVxhojHeKfKvMlME/m9JTT1CIhpJdYVEJkjwOeMk0g6vH6h9QyjlgDFx7msqfJle3VeNxVPmrkrfscLATrb741dvTYkxFpa/BbBcIvCCxxcumAt0/hHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bmcQgzO2qsaweBmOMM5ChpyRK3sDWhzU83moeBTx1c=;
 b=UY1m/rs6PK8NKr0+iSLpvmsKoSVrXLv3pA3CDOcqw5EKsjCYIUO0qCT8EnePLe/7pSktShps06/SCU/yhogpaiw3appjs1gN6d9+5dTv7mRRCp6ta42kLr+NMfqEjjG4f/XUu3CNMjl9p23SjJHg+8NNO6qfWR1HnpJ3rRDLAVC973PbyCpL5FzQLbjIKvPYwEPs99myNe/l5vWo25M52dNgCLaahYfuFV6g0h4cUuE6rCYzRr13ya18gkYW8lW91dAITWSkZAXYyi5HRmAXXVHtblPq5cnJ28z9ymgOYT6gehomRIKwqxfUgyfq3Y+iLms7rn7YtebhKYoqoo7gTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9bmcQgzO2qsaweBmOMM5ChpyRK3sDWhzU83moeBTx1c=;
 b=RZ3jSamGuejtk/RRyowrTdRapGBWc9/i9RHTrOqIl2FHxepVnATWvIeEfvZK7SHxGoHemLtBm09K3F9TCcF3ELeIt/HlFfr3J9D/7nSuCDyAD/PQNaNTYcqyIc+b1sUkIEdKLx8CSqjIXYgMz/bLq8WDAZ3NAlLckobn2kv53zI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB8PR03MB6025.eurprd03.prod.outlook.com (2603:10a6:10:ed::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Fri, 2 Jul
 2021 17:31:59 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4264.026; Fri, 2 Jul 2021
 17:31:59 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Michal Simek <michal.simek@xilinx.com>,
        Michal Simek <monstr@monstr.eu>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <13c9345f-b3e5-cc97-437b-c342777fcf3c@monstr.eu>
 <36b23b6b-e064-a9c6-2cd4-4fd53614724b@seco.com>
 <5e7c9d00-bacb-325a-c8f6-413ad9da5f73@xilinx.com>
Message-ID: <45b3c713-952e-610f-0a98-ed8e48825e97@seco.com>
Date:   Fri, 2 Jul 2021 13:31:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5e7c9d00-bacb-325a-c8f6-413ad9da5f73@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR15CA0026.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::39) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR15CA0026.namprd15.prod.outlook.com (2603:10b6:208:1b4::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21 via Frontend Transport; Fri, 2 Jul 2021 17:31:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c1e774e-3788-4042-89ab-08d93d7f4bd7
X-MS-TrafficTypeDiagnostic: DB8PR03MB6025:
X-Microsoft-Antispam-PRVS: <DB8PR03MB6025139E735E5644D506FB4D961F9@DB8PR03MB6025.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PQ/oQDq+pSwUGSt+PivUTRIskre/miW9tZviO/7r2hWAPlkyrOiO9S2akVE05PySLzw75qpsVvxQdW4atBEn6HCDBXWfVzb/fGHbHzJECtNm4To9Y+6Wcq0nQVhP4yDKFI1vobee5CFQF1RWbVR7RJKFLWzbSiw8EJRmepYHpKAger5Oe2UKPjyt63GzQjqWBkXIOd8eQc/HEnhDxuQJoqAN9eUTQTkPeUrj8ncfCCXkDly6aWmgrlFT7qK5H2oxOEm/bjJF+LZOii3BW4PrFhp7TVnz7a3Zhx2cFMfHwVeHh2lJN1IDVp6Wotl0LX9jf+CV3kdXsufbkYz3AeliN2XKanoq0qfUwTksVTenQVufEDKWaUvw4SFVfpACRZ8skzjtOjcFaH8BiuMGzn8ia0XK9qQxp4pD3ns1zfY/4rlmbYisBswE6YrHmPXW3dLxoddHqiVK6O4+OXh05yIIMthRo89eOEEJsPB2FhkhrHbDh5ydeEa/4IiRX1ZeJ+LMDkPn5G98OKWOXyWoxWwHJwXN7X5CGDCZ783/qOvKEdnNqtHq/mkLq9zOu+g+PtYwI7JD+D8s6epXwLotSjRoRqAJX9Mj/eyzptyFI24n7Ao0cNEE8bb/Q2z5+6WXjIM8bTzgOdhVv0AK7fowuX0pRKdkZAyhQoMVGRixI2W2aJmsbxX3as3Y+/Co1VMYXDuaTxP9RQ69mSJ/emwYVc6E+yHHygfEIFL3knk0k832W088u4geO/Q+vpg0pouG7NmxZQHN2Ag+36KWRUC20nvPTZP2Vojt7ibmqVxV82eVc4XXAJASwMedWIxZTP0dYrbthhdMDm9FhT3iiI2fosnYWwj2/FraYHPKndkyHz4yLRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(376002)(136003)(39840400004)(186003)(38350700002)(16526019)(478600001)(966005)(7416002)(2616005)(6486002)(956004)(86362001)(38100700002)(5660300002)(26005)(6666004)(31696002)(66946007)(8936002)(36756003)(316002)(16576012)(2906002)(66556008)(4326008)(31686004)(44832011)(8676002)(54906003)(66476007)(52116002)(53546011)(83380400001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWo3UEJGSkV3NGhvUDNKeHJHcHMyd3BIaWJYRnorWDRRcXhKbnk1RHpUMll3?=
 =?utf-8?B?dW5UM3Q3NWJiSWlaNmFZQ0RrRGZXZmpjN0pTYlZ0bzhBY1A1NzMvN3QyYThL?=
 =?utf-8?B?Sm1MaEg2VGM1S1YyNXVkL2ptSGk1QTdZMmpvdXpHb2ZNTVh6VzQvQVJsT2lI?=
 =?utf-8?B?TC9qZlBOY21lRTRYaUJBTDlISjlXMkFOQ0M4dGFwcmdWS2tkKzFMN0V1RDZo?=
 =?utf-8?B?eVo2Vjlnd1pRMUFNZ3pzaSt2cURDNDZwK1JqdTl4Vm41RWJpR1RkNWQwUU13?=
 =?utf-8?B?V2hSb3NlY1c1SThyVzdqUTBjS2FsTGlnT3d4cmk3akxzWUc4UzdPNk0xSWpn?=
 =?utf-8?B?U1ExTEduUFRwTis2bTd2ZDhFS2Y2TW5sWEZRRnFGWXhZSklJaVdSb2NEeVZq?=
 =?utf-8?B?cCtLMktsc1V6MXloRHA1ZjdmbXBsK1JLZWhLK09melhzaW1NUitrRXRVd3Zk?=
 =?utf-8?B?QkNNb0xOWE1FMmU1TVRDOW9NY2xxbHU5Z0lwNkZpYmhwbWoxNFB6d1l0UHh1?=
 =?utf-8?B?VFA1anFhVitybjNhWUFLOEJSSFVVOFVidUxuOUlCWUwvTkIxYU1sMExOeG9u?=
 =?utf-8?B?YUpKQUttc0ZBMUtZRS9RUFJnUjFraS9NU3pvSUEwdU5Cc05QVDNEY0RkcSsy?=
 =?utf-8?B?eHJxaERGejBPekVyQkxyblJqOEJTZDNzNmNuMFNGYWtHZTI1TGkwSGNMSENN?=
 =?utf-8?B?WldJRzN1bExFWTRnZi9yWjhIRlhoTjVKSXdaaEEza3FESW01cUt6Uk0rbEZQ?=
 =?utf-8?B?ekRHdzZ4T3lMUTJrMHBycDlLUVA3YTRvb3RGaFVzQWZEdlR1OUN5b1R6UWJC?=
 =?utf-8?B?SE5EM2d3ZzhUNHY2cXVzMTRHTlZmK3Z3U0hOR2xucmFveDdtS2dzODcwMjRL?=
 =?utf-8?B?cUszNVgxZy82R1ltRXU1elh0U1JIU2ZaOWlLVGpxQW81elBmMFJIYWRFTTdS?=
 =?utf-8?B?UkVZZHh6N2RzZlA5alpkRHVDT1BmS3htMm9TakFyTDgyNjIvWGpMNmVKNkYy?=
 =?utf-8?B?Q2g0dUJsVWFwR1V1UVVudkdsekxZZGt4M0laRUd6RlhpVUxqS0hWZUVMTUdq?=
 =?utf-8?B?K0lqSHBnNUZUeE5ZelZCalBiYkJqQmtwaEdvd3JNZzJJNEt4RGI4V3RXODI5?=
 =?utf-8?B?VFN0eWVlWUVyUGxxRkEyWURSQVo0UzBDTUxSTlRwNFJRN2RyQVU4aW9HZnJF?=
 =?utf-8?B?azBzdDRXUi9STUpwd2RFUkJUSkh4dEEyVnlUZXc2dzlJNDdMV3Y4RlhyNkJw?=
 =?utf-8?B?MitXd2NkOVExN2JNcENPaE1FbURUM0tQcUh5b0tDZi90QjZHY2xrMHU0dWRR?=
 =?utf-8?B?elQ2Zm1lUnJ1YU8vMjYvdW9GZnZSS0lOWnc2RWVickNUeHc1cG0zeE55VEIw?=
 =?utf-8?B?aUdHM29sNi94RUpwbzZhU3BmRzJLVG5qVGx1eWN5NlBOclgvU2pvbmRBd21J?=
 =?utf-8?B?eE9NOUI2ZC9xZTJRM29yWTlwZmdmeWxZRWZrL3lObjVZYS9wL0hKQWUwRXI4?=
 =?utf-8?B?a0xqMFR1SWVBK2FXMmVBL2FBcGtyeE5iT1JGcW1qVi9RN1djTkhkOEpBR0N5?=
 =?utf-8?B?VENyOVZueGJXTjR2RmNsUHIraVJJalloeEFhYnRWOUZSOERsbGh0blZvU0Ey?=
 =?utf-8?B?eE1zNjRtQWVhSmQ0VndwS2QzbUZ6QUg1dHBwaEtNS29DWTIzYjlnVmRxZEEz?=
 =?utf-8?B?VG1Ic0ViNEw0cUp1eFNTMjFmT0NDa1d5MDNWWC90aGo3TmRhSHgxb0g2ZGJk?=
 =?utf-8?Q?40reNcDvevY857jFisezC+metU/fQmLBlCmkJTn?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1e774e-3788-4042-89ab-08d93d7f4bd7
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 17:31:59.3362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fy4AHJM2qki6aEigm9Z5HHVycFMCdYEnJqGb9ymYFN+k3WijO3qA42OXGO4oPaHu53XBY3xE1IzfSW9RcS2olQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6025
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 7/2/21 8:40 AM, Michal Simek wrote:
>
>
> On 7/1/21 5:32 PM, Sean Anderson wrote:
>>
>>
>> On 6/30/21 9:47 AM, Michal Simek wrote:
>>>
>>>
>>> On 5/28/21 11:45 PM, Sean Anderson wrote:
>>>> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
>>>> a "soft" block, so it has many parameters which would not be
>>>> configurable in most hardware. This binding is usually automatically
>>>> generated by Xilinx's tools, so the names and values of some properties
>>>> must be kept as they are. Replacement properties have been provided for
>>>> new device trees.
>>>>
>>>> Because we need to init timer devices so early in boot, the easiest way
>>>> to configure things is to use a device tree property. For the moment
>>>> this is 'xlnx,pwm', but this could be extended/renamed/etc. in the
>>>> future if these is a need for a generic property.
>>>>
>>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>>> ---
>>>>
>>>> Changes in v4:
>>>> - Remove references to generate polarity so this can get merged
>>>> - Predicate PWM driver on the presence of #pwm-cells
>>>> - Make some properties optional for clocksource drivers
>>>>
>>>> Changes in v3:
>>>> - Mark all boolean-as-int properties as deprecated
>>>> - Add xlnx,pwm and xlnx,gen?-active-low properties.
>>>> - Make newer replacement properties mutually-exclusive with what they
>>>>   replace
>>>> - Add an example with non-deprecated properties only.
>>>>
>>>> Changes in v2:
>>>> - Use 32-bit addresses for example binding
>>>>
>>>>  .../bindings/pwm/xlnx,axi-timer.yaml          | 85 +++++++++++++++++++
>>>>  1 file changed, 85 insertions(+)
>>>>  create mode 100644
>> Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>>>>
>>>> diff --git
>> a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>> b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>>>> new file mode 100644
>>>> index 000000000000..48a280f96e63
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>>>
>>> I don't think this is the right location for this.
>>>
>>> I have done some grepping and I think this should be done in a different
>>> way. I pretty much like solution around "ti,omap3430-timer" which is
>>> calling dmtimer_systimer_select_best() and later dmtimer_is_preferred()
>>> which in this case would allow us to get rid of cases which are not
>>> suitable for clocksource and clockevent.
>>>
>>> And there is drivers/pwm/pwm-omap-dmtimer.c which has link to timer
>>> which is providing functions for it's functionality.
>>>
>>> I have also looked at
>>> Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml which is also
>>> the same device.
>>
>> Ok, I will move this under bindings/timer.
>>
>>>
>>> And sort of curious if you look at
>>>
>> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v2_0/pg079-axi-timer.pdf
>>
>>> ( Figure 1-1)
>>> that PWM is taking input from generate out 0 and generate out 1 which is
>>> maybe can be modeled is any output and pwm driver can register inputs
>>> for pwm driver.
>>
>> I don't think that is a good model, since several bits (GENERATE, PWM,
>> etc) need to be set in the TCSR, and we need to coordinate changes
>> between timers closely to keep our contract for apply_state(). Although
>> that is how the hardware is organized, the requirements of the
>> clocksource and pwm subsystems are very different.
>
> There is another upstream solution done by samsung. Where they use
> samsung,pwm-outputs property to identify PWMs.

As I understand it, the samsung PWM/timer has 5 timers, four of which
may be independently configured as PWMs. To contrast, this device has at
most two timers, both of which must be used for a single PWM output.
Because of this, it is sufficient to have a single property whose
presence indicates that the device is to be configured as a PWM.

> I think that make sense to consider to identify which timer should be
> clocksource/clockevent because with MB SMP this has to be done to pair
> timer with cpu for clockevents.

This is not done by the current driver. The first timer in the system
always binds itself to CPU 0.

--Sean
