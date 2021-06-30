Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615893B848B
	for <lists+linux-pwm@lfdr.de>; Wed, 30 Jun 2021 15:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhF3OBh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 30 Jun 2021 10:01:37 -0400
Received: from mail-sn1anam02on2057.outbound.protection.outlook.com ([40.107.96.57]:1665
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235835AbhF3OAu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 30 Jun 2021 10:00:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fdws9QKHsoETm9YJ3WIfwL/OHMcEIC1LRAPnEaDLmKor6HRR8GpDNtimUHY2XzXerUCOPpoJzb5z1OO73yXU4N37kgj1djaoV07gJlS+6se/mkGpRJG9wyBlVQWnHI4xigm1AS3mMQO9HrTBxCHtOUdSOeViRhc/9q0NLN18ln4YJY+lZisSKqKnLgYCMv2kVSjztiY+b+LAh80mCo7iLjucDZLbnbZ8FZQztrwLNfdiu0ucA6QvW779cyS75b2lCip+j6Yq0G8kkdm72ThpJFWXG9dZy30SSibtF3LNxzxnHFcOt293BvHvhPzjUHOXK3PxKXNEY49D89r8W17yHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwEP4hUod/9y81zE8ZRDfd6gfeZ57tRgZyBjUzZZ9B8=;
 b=Aun+VMktAA2iDK7paYrb0o2lsgeX7+mAtwjo3gYJbdNuceSlFr1LbXHtlEwbqZMyk1KPA+EQ3NFDJ+mkcxJwNqj7nk0jRKi8pxdqkDs2QawxER6ENHfxncBmGffPsrDscFStaY4bZJGozzqhYOMIJsjwFiuEBUjfaOSlhcTStGJgF4aPnEbSEYNwfz7JPZN0dcxYYNu2oXCHDy57pGGgxOkH1QGVhQeCPnJ7pZcNsilcrZ9CpcKoB7Lu8EveCH6LtzE3QImunnC6xgfCxbG2yNIw4rJPo+81cL2eAOIWd5OYdp7RVTx9CyD6DXE7IVHz8RmPX7cAqnSu1w4yv3D09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwEP4hUod/9y81zE8ZRDfd6gfeZ57tRgZyBjUzZZ9B8=;
 b=GSxkTDQyrqneUwo9FU3+F2Ir+eQg5jQfexoegwp4Zh4z21sis+Em56/9a6qyU75SoTWncaR0/YwfvbRVTnifi/gnwDN+0Lh0XnYIGg9Ig+GHqDTNy4aFhdF3qrKUez7jNU+1liE5Ej85GG/4KLtdzU+pb0ELr575iGDH8z5iNLM=
Received: from BN0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:408:e7::34)
 by BN7PR02MB4243.namprd02.prod.outlook.com (2603:10b6:406:fe::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Wed, 30 Jun
 2021 13:58:19 +0000
Received: from BN1NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e7:cafe::bc) by BN0PR03CA0059.outlook.office365.com
 (2603:10b6:408:e7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Wed, 30 Jun 2021 13:58:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT053.mail.protection.outlook.com (10.13.2.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4287.22 via Frontend Transport; Wed, 30 Jun 2021 13:58:18 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 06:58:18 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 30 Jun 2021 06:58:18 -0700
Envelope-to: robh@kernel.org,
 linux-arm-kernel@lists.infradead.org,
 alvaro.gamez@hazent.com,
 linux-kernel@vger.kernel.org,
 s.hauer@pengutronix.de,
 u.kleine-koenig@pengutronix.de,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=38468)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lyajJ-00040m-Uz; Wed, 30 Jun 2021 06:58:18 -0700
Subject: Re: [PATCH v4 1/3] dt-bindings: pwm: Add Xilinx AXI Timer
From:   Michal Simek <michal.simek@xilinx.com>
To:     Sean Anderson <sean.anderson@seco.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>
CC:     <michal.simek@xilinx.com>, <linux-kernel@vger.kernel.org>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
References: <20210528214522.617435-1-sean.anderson@seco.com>
 <13c9345f-b3e5-cc97-437b-c342777fcf3c@monstr.eu>
Message-ID: <7a1e89bc-65fc-76b5-2383-19f0613d0a82@xilinx.com>
Date:   Wed, 30 Jun 2021 15:58:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <13c9345f-b3e5-cc97-437b-c342777fcf3c@monstr.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ddd1b0f-aab2-4b59-c8b5-08d93bcf1d8f
X-MS-TrafficTypeDiagnostic: BN7PR02MB4243:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4243233B558355C23F9F9B2AC6019@BN7PR02MB4243.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4MB5oiXW8BOsKGh211fOsFhxtshr81xVE0znSVVgv20lINJFlFhGrf615oMoj+yeAzacjm+WYnI2F+tjjFRJLrOY8oWadO9SRQyXXBLN6rOiTrl0LycPUjRNOutrTzrA4klhr0sCOL4METaIYhnKPYLIP7aoB2IeTbmK0WuRLD8IKu96pBWiNKaMjBzzvaZPY67PBbzCNSZ2ZSqxZarZHRf1XKLJpTj+tFrK7qPzkyDtH6jG2hLmpFRn5US58e7SIzQtkUC0Pz8H8L2u+hymwrNLy2H60mGk9H2IwlA0nLkvtZqKnrzj7+GPS3gq5zNhHvl09FvzBVc2cVEG2mpTU4Ty1b39+ceJ1aFtQUk3r7dBYXKWGGytIV+J9wUTahDW8Q5ecb6B8RIxgJ1xS7YklxGMZukxYn3DQt2vTk0J9lbqAhyUMjf/Z7gkWQoSIih6o1lJaKz88XhU58mskMZtr5qWLEaP7UmhXcSZeqgNIkQviydHapA+lloYmxVDRCmhLEkvTIDaEfPU44XvAqmM/Ol7VKtZXoFTpJcyTu767FD0/9uu6mzugYfIKoLGs93DauFMgilGviT8NSftvanwEvF3Bn5Y7ruqZl1oO6hn6phV+mrKr2Ue6bdAoI0vyxNr3TkBHbVjsV+wJwlw5COZcri6xJp+Fk7quRNidO+DlJ6VVZogKTCdmFHGav/ms8Is1lixJJ6Mvekildrw2am9fJTP7tuHoHnuK9X/5zPOF2j9t7hwu9/gAT5CY8oL6/afCwdE7GDT17qvcBIMhwdb0L9IzLxQzCPPcxrlrjCXo2jvmAuD9OFH7Su3RNx868+wtV7PD1EWPeeIPsZGena/ahHDzGJ3449EM1zNfkXWTtNUiT/OCCIrvVudF2O4kn252QNW1zv97pw6y+yqUXEKSWPyTrirVALTKIAJngXpbI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39850400004)(346002)(46966006)(36840700001)(8676002)(83380400001)(6666004)(26005)(5660300002)(7636003)(82740400003)(53546011)(8936002)(31686004)(70206006)(31696002)(186003)(316002)(70586007)(478600001)(356005)(966005)(36756003)(36906005)(110136005)(54906003)(36860700001)(336012)(4326008)(82310400003)(426003)(44832011)(47076005)(2906002)(9786002)(2616005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 13:58:18.8377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddd1b0f-aab2-4b59-c8b5-08d93bcf1d8f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4243
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 6/30/21 3:47 PM, Michal Simek wrote:
> 
> 
> On 5/28/21 11:45 PM, Sean Anderson wrote:
>> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
>> a "soft" block, so it has many parameters which would not be
>> configurable in most hardware. This binding is usually automatically
>> generated by Xilinx's tools, so the names and values of some properties
>> must be kept as they are. Replacement properties have been provided for
>> new device trees.
>>
>> Because we need to init timer devices so early in boot, the easiest way
>> to configure things is to use a device tree property. For the moment
>> this is 'xlnx,pwm', but this could be extended/renamed/etc. in the
>> future if these is a need for a generic property.
>>
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
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
>>  .../bindings/pwm/xlnx,axi-timer.yaml          | 85 +++++++++++++++++++
>>  1 file changed, 85 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
>> new file mode 100644
>> index 000000000000..48a280f96e63
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
> 
> I don't think this is the right location for this.
> 
> I have done some grepping and I think this should be done in a different
> way. I pretty much like solution around "ti,omap3430-timer" which is
> calling dmtimer_systimer_select_best() and later dmtimer_is_preferred()
> which in this case would allow us to get rid of cases which are not
> suitable for clocksource and clockevent.
> 
> And there is drivers/pwm/pwm-omap-dmtimer.c which has link to timer
> which is providing functions for it's functionality.
> 
> I have also looked at
> Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml which is also
> the same device.
> 
> And sort of curious if you look at
> https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v2_0/pg079-axi-timer.pdf
> ( Figure 1-1)
> that PWM is taking input from generate out 0 and generate out 1 which is
> maybe can be modeled is any output and pwm driver can register inputs
> for pwm driver.
> 
> 
>> @@ -0,0 +1,85 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/xlnx,axi-timer.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
>> +
>> +maintainers:
>> +  - Sean Anderson <sean.anderson@seco.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +         - const: xlnx,axi-timer-2.0

I am not quite sure if make sense also to list 2.0 version.
There were likely also 1.0 version which is compatible with origin xps
version which IIRC was PLB based. And the same driver was using in past
with OPB bus.

Thanks,
Michal
