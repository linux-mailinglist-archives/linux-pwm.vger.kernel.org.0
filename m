Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020D63B9416
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 17:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbhGAPl1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 11:41:27 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:21568
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233588AbhGAPl0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 1 Jul 2021 11:41:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVkwqbhoaFcQ6LWMw/YINT8cUV/xFNjab/sBJhA5r3ygHUZQUB3UwFYHhmyGXf9VUT8817T8BMx/zqYopcIZ1rDN2TvNHCoLYNGngadg6xyYuRBDxj3GFACiEXln/jQEuQb8DCwixsiGYpYiKjByC2cA+VopfrLsFCj76O8hQFuzhoKto/TOnZwIFtXBcwjiwBAzL6DRljvE4QhqDJZ0KT1Hvtm4Hyl+ICvmHZtTmCMmAogJZzlAVycv1Cn8hk49Ia4NczK3A6qU9s9fGpk084ghMAYfYwN4TQkJeTrtZrqUzm/fPNDiX5bkELjJksQBnnbN+lOvqp1MHMFCwHtpFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf9boRchpsA3VTW5gp4hJkmOx840a3daCwxlAMt/AXw=;
 b=lPUEy9RFDHJpAFDfPJFCNHDwDzCRfYSA/kW+lgdJ84TYCVQF2xP6BnAWeQYjSl5HKuDfp1ncIPGEuZazmIiceCH6PQjL52I4C0h/IirPkD1XS/z9lrCFCt15rsYzuFk+hf60NzVUf4d5ddmi9qKUELI4YSofsP+v3wAqzhxg5G990JdkgIoUKc5PYzK1+zlzWeTH+gE5Wzqg8rr97wWDHNdsCqbw6djk/lV1yfxp0RHY3IYRvEbNbV1gUv1NuE8KaoeH9iGSJHiLsBFjNQvOOP/kmBmKgfIfdOES9cLsL6hNpBoTpHJOwH33CLuJ2dNaRjJzBhDFNKpa14QWHeP/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mf9boRchpsA3VTW5gp4hJkmOx840a3daCwxlAMt/AXw=;
 b=j1gaD8FEcpiTb3gPPIBPCV92ycoGqWIE3ZoSeFxAzQA7AKTV2d9In42//1kVGNt8x5DgoLQbbjS3gMqAvUsqNwwc4cXIXLnjZrBeQi/jdPvbSmmsZwjxdWhqgMkmnJdnJiDEhUa5ci90/uY/taegwBwbKLOrJtW7NOnzpxEbyg4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB9PR03MB7196.eurprd03.prod.outlook.com (2603:10a6:10:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Thu, 1 Jul
 2021 15:38:52 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4264.026; Thu, 1 Jul 2021
 15:38:52 +0000
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
To:     Michal Simek <michal.simek@xilinx.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <13c9345f-b3e5-cc97-437b-c342777fcf3c@monstr.eu>
 <7a1e89bc-65fc-76b5-2383-19f0613d0a82@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <006fcbf8-d79b-3723-9a9c-03c6350f0a9c@seco.com>
Date:   Thu, 1 Jul 2021 11:38:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <7a1e89bc-65fc-76b5-2383-19f0613d0a82@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: BL1PR13CA0114.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::29) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by BL1PR13CA0114.namprd13.prod.outlook.com (2603:10b6:208:2b9::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.8 via Frontend Transport; Thu, 1 Jul 2021 15:38:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0191e9de-d28e-43d7-1dd4-08d93ca65414
X-MS-TrafficTypeDiagnostic: DB9PR03MB7196:
X-Microsoft-Antispam-PRVS: <DB9PR03MB7196B129FF1E588633A041B396009@DB9PR03MB7196.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0z/nZMYuQPQoMd0FF9hRwwo3ooWit7qlLL00+WQG04uh7RKcGhHPk+Zx+AGslSDTIiftjMwibioM/kJANUtF0SDuXEcjvkmcJNo4qKmQVnA4JOKpJbMcHS+HIxtM5rEsrRXB6BcImhS52n+00/+V0uf01X58GWn2BqCo7NfiGfnkQ7qYa36iR1IxQ3SArO7wdIJuhX6CkEfzFcC6UbpuIXmLl3Biu46zwpZegpHX/T50oVu9b9lPn58Krk8Ako7OsiseNudCJn2m8Yn9eVH4MrSKFEJjwnhp39oO5YEygJmaZswfbgDX/+nxjT14HPg6ATH/iowsLwWF5BV5msAZoNXvyiCfOdnv2VS4h4TlLVnddxSUv+vba2rSyUPTyKzronm4WbNLpQc5HgJXmh8qUQkhNFrH4LINfEXU9qHK2A4ssrEtkgUxYiUgujZXraN2Fz9d1EfyE/4Bf6JFQLqHZsFBnerQXzHFfuGvNWW4sUAg54UeXR5aOQ5u6ykg4hG2+vnZlkUVs5IW0cDXQPSdLVafxGmbi6+oxBBvRX96ardcfGRvfNk/GZ4PqoCFlO1CMNnyCDdvbHMNGEk/nbhEy2MSPvB5AJUdKYXB0xRsWPGAegYfA1cWgaSP029pDp5lsP7PM9gzaBLOyIZ8l+WEeCBuQpZRpZyRdTxZHCT5dSxxktpi/Rg+sKPaqSx1n9wLhcROSqQQ4bf+5bMqU6ZzGVfkjLK1H+PMuDKN/lKRk0CDrFXeGriy4qy44LcDCQQ7yTU0bdYCUhmEfUUfhW3TvpVnoWgRnjLL7ATNQjGWFG8CGVTUXB8FkPwHHXPdYePI/RegIYZzT67k3EYG3+og5STGRKzoKnMYkWAuXXSrsZvwBOEsxGq/fOe+sKIVGWwlTL+slDmuqpdjCMzr6xK2bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(136003)(39830400003)(396003)(478600001)(316002)(8936002)(38350700002)(16576012)(966005)(6666004)(38100700002)(2906002)(4326008)(52116002)(956004)(66946007)(5660300002)(110136005)(31696002)(44832011)(83380400001)(8676002)(186003)(16526019)(6486002)(54906003)(31686004)(36756003)(86362001)(26005)(66556008)(2616005)(66476007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkhkY2piOSs5QVN5UUdBZ0t2d3o5Slk3R0c1V3NJc1JCa2loemE1MlZnQ0cw?=
 =?utf-8?B?TUtsK2w0MDYyMklxeEFkSllONlFsUjZ6T05TZlhaemlOUGF1b0tIbGZqamFQ?=
 =?utf-8?B?UlZYQVVKeld1QkM5bDllbHZGMi9VK0x2YmNjVkRuWHk5RSt3b3RrVnNkOHYr?=
 =?utf-8?B?bWNKeXZkS1VPQ1NDMWJKVXg4dmk4c1IySzNtNmd4WU5ZcjVZUXVsUTI2Tlgz?=
 =?utf-8?B?U0RmcmlYdUFmTVVaWGpiOG44Yk4yKzFLcjRpby9kN3BSM1pkcEpiSWt3NlZl?=
 =?utf-8?B?VjkxcVpDRE1ZcmlmbkhobWFjdHV3S09aWHIrTDM5WFowNUovbElFcGRlUndh?=
 =?utf-8?B?RGE0aUh6T3BNY2NXZE91SDlXV1FUU002dGIxQnphSjAyRWNiaVlrb0lUNUFs?=
 =?utf-8?B?MnNnRlJQZ3AvV3ZJV1A4MEFYSGtuMEIrK0wrSmF1SFk5RTQwMjBYUnNHWThh?=
 =?utf-8?B?bzE5T0k3UkdLcnVlV2Y0UW9udHUrcXFpQTNkS0J5eTViT3JSK2lWcFA2a0Y3?=
 =?utf-8?B?YVQvUkFVUGVmeWxYY2VXY3NkdjJZRXE0Y1NOZzV3S3JzdEJlUmRwNDR3Wkxh?=
 =?utf-8?B?UXFrZ0R1eGFHQ0gxaVpNNWNobllVQWFGbmpyaWRNUVFWZXB0a2JtV0xNOGd6?=
 =?utf-8?B?UXcrVklwQnFLOWh0Y1lSM0I4dEVpN0NJVFY2d3hRa3hQOTNKc3R5eVlxYlZG?=
 =?utf-8?B?eU5icmFlejFyWVFjNllGZGZpTFN5S3hEazJDc0I3U0IvYkR5VUVvU1owVUs0?=
 =?utf-8?B?REdiRGRPRWNhRXcyRnVaZCtDNEx0UEN1ZEw1dHJhMXJOUVYvWEU5UXdOcVhN?=
 =?utf-8?B?aTVSOWZUZERpRmNIbFB0b2drVjN1YmpiSzRKTkRiQUlPbnc3dURLLzUxTXdX?=
 =?utf-8?B?SlNWRTcydW9tK1h5VExyVElQZG1tOENSZnlvajQzSUhsb0N2MHZtZXNFeWVY?=
 =?utf-8?B?TUJ5L3FnVm1MZThVS0NHdTJ4NzhlYUVkWEpKNThhTzJxVEZpcFoxQVZsMnVy?=
 =?utf-8?B?TWkrOG04SVcrVUtPYlJ1SzA3MzlBQS8yTldrejRDMldoRFdiSWs4Rk9OWkpv?=
 =?utf-8?B?T1EwZnpPUmtlWW85NEl4U3ZjZWhmckZ4UlpBd1REN2gwYXU5cVI1NDJWVFpP?=
 =?utf-8?B?aWFUN1JmS3dwVVFidUVxaTZjT3JnRTFhVWt4dE13aGp5cXRYOS9ESEtnTEMz?=
 =?utf-8?B?Yk5WbWtVd05ySnltdDFEM2x3TGw4cHhSQnlTOVkwVVVvRXE1K2xKZi9BT2hh?=
 =?utf-8?B?bjdzMFVFcTMvSnpDU3VIS1BZbkdmSDk3a0t0WFdDUzlmUGpoYXBSVnA2dDRz?=
 =?utf-8?B?aE5CRTZaNGZwRXZpalIrUWhjZlB1SUZ6UGs4MDlQQU9NL0IxYm9obTJ3S05T?=
 =?utf-8?B?akFsWnpna09odUVIdWdVRXFpa2s1OGc3WHhORU9KNVpDZjMzTE9FTGhpbE1k?=
 =?utf-8?B?QUZzVHByL0UrcHFMRWt2dlZXZmxqL1JRNStEdWdkQVFHeVFnMmhXcFcwK05x?=
 =?utf-8?B?eDgwN0ZOMk5vZWlBc1dvOFBHTWZpemsyci9BUWt2a3FpZjltV0tPdWw2SUxi?=
 =?utf-8?B?c2JRT2FZUnlrSk54c1pwUDdjYTFYV2MrSENwREhKdWxWRTJ5SEZkSVRQQ0Zh?=
 =?utf-8?B?L1NDckhETnNNMWVDdkNsaTUwdWxmQThub0o0a3ZMTWxzV0lIRklaUjJPOGx0?=
 =?utf-8?B?S01hNUJIcjdnVHRDcTdkUVZLS1JMai9YQVFNb1NmTUNqak9QNlNZUXU2SmZP?=
 =?utf-8?Q?3pyklpDLEK0LiZ6XLQnc3fEnbaR19xWMxNWgwHl?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0191e9de-d28e-43d7-1dd4-08d93ca65414
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 15:38:52.3697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/BdH9RSC/QUHRl3xk2m8oruIiUqT6RHtmL7AryqEDCaUGhbxKZYUeIGeKY1mqYRaqZ0nfzu/5kYDprhecF8ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7196
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/30/21 9:58 AM, Michal Simek wrote:
 >
 >
 > On 6/30/21 3:47 PM, Michal Simek wrote:
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
 >>>   replace
 >>> - Add an example with non-deprecated properties only.
 >>>
 >>> Changes in v2:
 >>> - Use 32-bit addresses for example binding
 >>>
 >>>  .../bindings/pwm/xlnx,axi-timer.yaml          | 85 +++++++++++++++++++
 >>>  1 file changed, 85 insertions(+)
 >>>  create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
 >>>
 >>> diff --git a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
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
 >>
 >> And sort of curious if you look at
 >> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v2_0/pg079-axi-timer.pdf
 >> ( Figure 1-1)
 >> that PWM is taking input from generate out 0 and generate out 1 which is
 >> maybe can be modeled is any output and pwm driver can register inputs
 >> for pwm driver.
 >>
 >>
 >>> @@ -0,0 +1,85 @@
 >>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 >>> +%YAML 1.2
 >>> +---
 >>> +$id: http://devicetree.org/schemas/pwm/xlnx,axi-timer.yaml#
 >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
 >>> +
 >>> +title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
 >>> +
 >>> +maintainers:
 >>> +  - Sean Anderson <sean.anderson@seco.com>
 >>> +
 >>> +properties:
 >>> +  compatible:
 >>> +    oneOf:
 >>> +      - items:
 >>> +         - const: xlnx,axi-timer-2.0
 >
 > I am not quite sure if make sense also to list 2.0 version.
 > There were likely also 1.0 version which is compatible with origin xps
 > version which IIRC was PLB based. And the same driver was using in past
 > with OPB bus.

It's required to list all compatible properties which may be used in a
binding. And AFAIK it is good practice to add a new compatible string
for new releases of an IP, in case incompatibilities are discovered.

--Sean
