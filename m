Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768B53BA09C
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Jul 2021 14:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhGBMne (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Jul 2021 08:43:34 -0400
Received: from mail-dm6nam10on2085.outbound.protection.outlook.com ([40.107.93.85]:27616
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232026AbhGBMne (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 2 Jul 2021 08:43:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doV5xYSEah825xBhHxTBAEpILtL19ngsHuy9H4woyVMh5Gxa/RWOFSTgxZK5fG9mbWkSVbXycE0IOJUXN7S45udCr/FsMwqRPKNBO0f64DO8CY31uhOdZHMs5zNwA5dnRgL1Uni4xGbCCvJbXoSTRuOhhthGjiJk6T0pkSfNg60PguMC+/zL67XpgyU8mrSEX3PAMbVFVsipqVYOdFSdMHCKr7E+k5oh5Iyhzspm6K3fFun6niNlZMRVkEDiHFq6K5vPuSN/CQSJWMCc0pJjP8BLoQqeeU90hVeUF8iWQ56fAD9jIiBk3cz+zwJn2Y55bPnQlZO6e/Fdg9iccnDcUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOo2Bh7EFs7tFMOR5iXj4/s7OZ6ZAOzqNVncj92rDjE=;
 b=K5oKOYKzF6dY/qkqq3zIyO5DuZbpG6PXWk1nPdjHIEZemMV2ylFA25dIHCsYWXvQa19oNm7p/bNMZvVCBfxK5PJeT0M2Sg7qtJrspA1v/XBNrUUxYgtDFzQNO5TsS2c585A6pVSXj+06HMf8iA9Xdd9mYqu7wNspQe21GdB4VeyLOcbreMXREfUPc2mYWyd+GPOpbM24aIA7bh8CF1/JhN7/TLFGeedzrdwV/6+trmcjrv3/z+6UeZ/8oqsgnncMSaNFwh1wNOSph55jrgNpgKeXrvuQPDSMa2fbugRjpmKNlSlHFYxzGCGlrAwpZ18rTAUYgQ1v7eNXZ2wpNmggFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOo2Bh7EFs7tFMOR5iXj4/s7OZ6ZAOzqNVncj92rDjE=;
 b=DAH7J4zFFyr55VRxKGEtSlpH+riA1ZkLqqdEIzd6m33NkbcHINY1iq2L4tIx577yqL7yxEgxWVv6FhicJI2bGyJ5DcLzMVpkRK6Vu+KbIaxvi/jPNzxxA1tdW6EUgUjg+IRP+h9m//z6uYQOeatwQtwoqJ4RD2P3jYz6jKQxv0g=
Received: from BN6PR16CA0023.namprd16.prod.outlook.com (2603:10b6:404:f5::33)
 by SJ0PR02MB7472.namprd02.prod.outlook.com (2603:10b6:a03:29d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 2 Jul
 2021 12:41:00 +0000
Received: from BN1NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::4d) by BN6PR16CA0023.outlook.office365.com
 (2603:10b6:404:f5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Fri, 2 Jul 2021 12:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT024.mail.protection.outlook.com (10.13.2.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Fri, 2 Jul 2021 12:41:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 2 Jul 2021 05:40:59 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 2 Jul 2021 05:40:59 -0700
Envelope-to: robh@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 alvaro.gamez@hazent.com,
 linux-kernel@vger.kernel.org,
 s.hauer@pengutronix.de,
 u.kleine-koenig@pengutronix.de,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 monstr@monstr.eu,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=49258)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lzITa-000E83-UH; Fri, 02 Jul 2021 05:40:59 -0700
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Sean Anderson <sean.anderson@seco.com>,
        Michal Simek <monstr@monstr.eu>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <13c9345f-b3e5-cc97-437b-c342777fcf3c@monstr.eu>
 <36b23b6b-e064-a9c6-2cd4-4fd53614724b@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <5e7c9d00-bacb-325a-c8f6-413ad9da5f73@xilinx.com>
Date:   Fri, 2 Jul 2021 14:40:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <36b23b6b-e064-a9c6-2cd4-4fd53614724b@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fae810a-5698-4923-ed1c-08d93d56a579
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7472:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7472BA7BBE679E44A99FC0B0C61F9@SJ0PR02MB7472.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ocOu+TVHyPIzFoDoYbr6/sWUFpK8Q7ggaEs2DG1+joKw911p4hAoj83ixsxgK9MKS01Oa2C9ns3YYo1xG9UEtyGvArKFJ2jcjuy+nLd4Pu+Ou/S2T7It7ZKkGq2qlAKpSfG3rx6APJyoP7O4MV76gZ8VLYm2syULOV8vmmLcTXKz4O7qTIY5K8p2QKsEeHQF5DA3X6W3zHHxxgTcnQzJj4e590k4SxI1nt8iQOYEAfMfoWsws6x560+hVbHr1Natvr5ccWAD4LwJCQDuO5O1eztmg+1JhDt/0V7Ub6ZfBwE0aY+bSH0rxx4HFczAvD4Rspc4dp8Xi4sjjV0V9AAQV4oZa5myhNLwWmF+TCYmY3r3wff/2+Q7bLrPJw9GcmeQrnP8MEN7KxHRSfUS4HraWV1Fo3gZUe9kzVF1S2EefzxFF3Oq5x7lVRZdnHhxouM4BIhRbq9R+0QACzz8h/HRaYxvQvA/0CboIDwq+wrI3cjho1kkoCsjdnMD1NomYbHvGWztoICZWfFbHqkbhHjOmzmQk8p/leNuOXWp7Iv3mPn0UoyPyXeqW5jS6ks4nqOo5RweV5uuFX/W3StnaFPMGaTZXPXpAdReDBkJ+e3Z4eNvNQRfWomZ+E0W/BAXF+fHld4EE8hByEYsHLY7bXm878ttd8Epk2mmSl/H4+Y4k7K5n1SIlGmD5bVvEApZHnjZqhfysGrsSrrbGDCP/MB47/kb5uKf6gPbJXoF0D3qrtOvANfR+AFfBTJU9w7CICZwYPrCp5FANXuauAyImoP6vzGKEft5SlWqr10SPUJcddjtCRl93KN91nV6ND/APkzTPjoxwvIEJ0WcixG/rdNbYJSxfI3+ZUM91ZFB7dIpi9MmYS1MiO8ghNTD9KDmupI
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(36860700001)(82310400003)(31686004)(7416002)(47076005)(44832011)(82740400003)(356005)(478600001)(31696002)(966005)(2906002)(83380400001)(70206006)(6666004)(316002)(26005)(54906003)(8676002)(2616005)(186003)(36756003)(5660300002)(36906005)(336012)(9786002)(8936002)(426003)(110136005)(4326008)(7636003)(70586007)(53546011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 12:41:00.0929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fae810a-5698-4923-ed1c-08d93d56a579
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7472
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 7/1/21 5:32 PM, Sean Anderson wrote:
> 
> 
> On 6/30/21 9:47 AM, Michal Simek wrote:
>>
>>
>> On 5/28/21 11:45 PM, Sean Anderson wrote:
>>> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
>>> a "soft" block, so it has many parameters which would not be
>>> configurable in most hardware. This binding is usually automatically
>>> generated by Xilinx's tools, so the names and values of some properties
>>> must be kept as they are. Replacement properties have been provided for
>>> new device trees.
>>>
>>> Because we need to init timer devices so early in boot, the easiest way
>>> to configure things is to use a device tree property. For the moment
>>> this is 'xlnx,pwm', but this could be extended/renamed/etc. in the
>>> future if these is a need for a generic property.
>>>
>>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>>> ---
>>>
>>> Changes in v4:
>>> - Remove references to generate polarity so this can get merged
>>> - Predicate PWM driver on the presence of #pwm-cells
>>> - Make some properties optional for clocksource drivers
>>>
>>> Changes in v3:
>>> - Mark all boolean-as-int properties as deprecated
>>> - Add xlnx,pwm and xlnx,gen?-active-low properties.
>>> - Make newer replacement properties mutually-exclusive with what they
>>>   replace
>>> - Add an example with non-deprecated properties only.
>>>
>>> Changes in v2:
>>> - Use 32-bit addresses for example binding
>>>
>>>  .../bindings/pwm/xlnx,axi-timer.yaml          | 85 +++++++++++++++++++
>>>  1 file changed, 85 insertions(+)
>>>  create mode 100644
> Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>>>
>>> diff --git
> a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
> b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>>> new file mode 100644
>>> index 000000000000..48a280f96e63
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>>
>> I don't think this is the right location for this.
>>
>> I have done some grepping and I think this should be done in a different
>> way. I pretty much like solution around "ti,omap3430-timer" which is
>> calling dmtimer_systimer_select_best() and later dmtimer_is_preferred()
>> which in this case would allow us to get rid of cases which are not
>> suitable for clocksource and clockevent.
>>
>> And there is drivers/pwm/pwm-omap-dmtimer.c which has link to timer
>> which is providing functions for it's functionality.
>>
>> I have also looked at
>> Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml which is also
>> the same device.
> 
> Ok, I will move this under bindings/timer.
> 
>>
>> And sort of curious if you look at
>>
> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v2_0/pg079-axi-timer.pdf
> 
>> ( Figure 1-1)
>> that PWM is taking input from generate out 0 and generate out 1 which is
>> maybe can be modeled is any output and pwm driver can register inputs
>> for pwm driver.
> 
> I don't think that is a good model, since several bits (GENERATE, PWM,
> etc) need to be set in the TCSR, and we need to coordinate changes
> between timers closely to keep our contract for apply_state(). Although
> that is how the hardware is organized, the requirements of the
> clocksource and pwm subsystems are very different.

There is another upstream solution done by samsung. Where they use
samsung,pwm-outputs property to identify PWMs. I think that make sense
to consider to identify which timer should be clocksource/clockevent
because with MB SMP this has to be done to pair timer with cpu for
clockevents.

You can see drivers here.
drivers/clocksource/smasung_pwm_timer.c
drivers/pwm/pwm-samsung.c

Uwe: How does it sound to you?

Thanks,
Michal
