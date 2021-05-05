Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0924373509
	for <lists+linux-pwm@lfdr.de>; Wed,  5 May 2021 08:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhEEGrZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 May 2021 02:47:25 -0400
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:40801
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229611AbhEEGrZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 5 May 2021 02:47:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlCm5wwtkXsFBlJHB+2ZcW3IJp5KYd8x0PLm67glfnHJ0F2ZTxYi7VmKcZBeEymywIu9/Hdd1ozgBELlcQ1JoXNYVlekFNpaYKa3OJC/NWyXB2X4vVtTQcWtogDF2BetJmd/ADXphG1tae1YYtkVmI5h1hQ9Zs/8CPTBXBLjC1WRMxOveZAl2M1NMCvwjzAdMyvOdaXix5HIF60WIsnIpgiMTdw6nj1r+ZwUE+lXcAoxe7T8UAh2v+dThz5Au1QKLereb4BeT18Yz3V/mzcKb4FSKYVxPAViIzOfnAD3HR1PNXNijurgMBErxyl2Q+OcYKhT6m3H/Fu5Fb9H9X5CCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTVNLfdZLyfKh27NN8YwvyZy2KhOpTfeS0QXOcQ8IYg=;
 b=Kqzqkkxj0UQ3NgPEek+KF36paJztPEk+9IgWTOsc/b5Q7YRHUdfhmYu9jGKY8LugUsfVmMGDezKXUnYjce+7kC1F0deMwUHu/xweoeGsCMM3dCJXv+TCjBdeRSTsyOjJnVc+xuElP6fFiYT+hRu+Lo7/ox7S9gG1bJZlK7vXYyZjXvYF7wM+nkiNkZNxDBMltblBVijMJe/ceOuYYu0sXflMn5AthJOWmA3z69FEyvqCKxpqKNdoRULwr9dJNg48WgaohGjYJlRN0bLA2WDMj76za0fxtYlf6TddeHngZBZRu6WzCPXTWoa2oVVYdyQrBJayBdE01lt3mXN8i+BNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTVNLfdZLyfKh27NN8YwvyZy2KhOpTfeS0QXOcQ8IYg=;
 b=N7XdBP7LfRchBYuEleFBB8UIobcBJ8aFQfsPuYFOZW4DdP0HueYUngi4dP11P72gvEmmzyWY55vGNpCwKvnX/eLOwU0aSJl+ZogNa7Tum04BqspTqp/j+w496QEHgPbIjiftPnzb3QDPlOR0dWcxaEBHKJgsAQeiGpMHA+/WeSM=
Received: from SA0PR11CA0079.namprd11.prod.outlook.com (2603:10b6:806:d2::24)
 by SA0PR02MB7242.namprd02.prod.outlook.com (2603:10b6:806:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Wed, 5 May
 2021 06:46:25 +0000
Received: from SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d2:cafe::82) by SA0PR11CA0079.outlook.office365.com
 (2603:10b6:806:d2::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend
 Transport; Wed, 5 May 2021 06:46:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT016.mail.protection.outlook.com (10.152.72.113) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 5 May 2021 06:46:25 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 23:46:25 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 4 May 2021 23:46:25 -0700
Envelope-to: robh@kernel.org,
 alvaro.gamez@hazent.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com
Received: from [172.30.17.109] (port=47298)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1leBIf-0000mM-1m; Tue, 04 May 2021 23:46:25 -0700
To:     Sean Anderson <sean.anderson@seco.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Rob Herring <robh@kernel.org>
References: <20210504184925.3399934-1-sean.anderson@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Message-ID: <0326a217-e6cd-d2b3-65a2-4285e9342418@xilinx.com>
Date:   Wed, 5 May 2021 08:46:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210504184925.3399934-1-sean.anderson@seco.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 873e3989-4f1a-40bd-dddc-08d90f9180f5
X-MS-TrafficTypeDiagnostic: SA0PR02MB7242:
X-Microsoft-Antispam-PRVS: <SA0PR02MB724209AD8B8616CCC16B81D6C6599@SA0PR02MB7242.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfI0lWYUimHtKiVczDCefmScbzPYLY8mnRJhqOI9WT4wy7Tmf1f2KYAwbJauqck5bs1gsUFCWf2hLwJRiV/FEuEqdERyG+PwLLOKoWxXUMM2DuFN+gcmEp8Q9n03t2FrnEpS9YPbMDa8+WrgAAjUEks0QQqlC7dTlu+taaljdTmU9gcGPncy5wDj4RqxckIJIemtfCf2R2opRchF5avlry+Sm9kTZwBTPLgW659ISHq3DlVVmjbHsrx1kd9gDj+3DDYLsE1A41gLklfQtKTAopr3sujqq2veX5NF7RDt/qPYH4o7fNfuOY/L2EfX8xYRDITyFtPm2gEk0WJCUO+rrCxK+W33jmFrCkLb26bcz7o1daUBAbZDS1aEq6ujYQIdupmyktSbkqxJg1nxowCNBlZ5u2R3MXgTllcJUEYpEwKVJZ5uvyV6sBbgNMuQGupQp4Oe2wGCyzI/UXpQ+tK9dK/KzcWQjm8uIvkBGFwHTm6v8pE3cy1eiyvnJ2CkzO6oLa6crzckgCgBcNaB2IpZRsAMsEG6DanYHHH6e4KCNmnjFdJUrn+DW3KGEGzBiawGwgssIXa5AlWF2/NhT2MhkVm4LKuROKVGwe5KzTRsObTX2QD+bT4UT50xru3BxO0u5NEVWXwYxV0IbM7IGhJwfksJl+eX2WmqL3mGLhJ7DDcEZiiKSv8a2OHDt4uzTikdJt4zlHclJec0i4PTYuh1HYZTVcOdeabpLQw7k37vKbT7BvDb6LywwPi07HRvIYdtT+aTRqrCLs7lhnDl0jEnplr8WAbb3I+G9cpuNejtKHc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(46966006)(426003)(54906003)(8676002)(36906005)(110136005)(2906002)(478600001)(44832011)(7636003)(82740400003)(356005)(8936002)(336012)(316002)(82310400003)(26005)(36860700001)(2616005)(9786002)(186003)(31696002)(966005)(6666004)(70586007)(31686004)(4326008)(47076005)(53546011)(70206006)(83380400001)(36756003)(5660300002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 06:46:25.7097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 873e3989-4f1a-40bd-dddc-08d90f9180f5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7242
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/4/21 8:49 PM, Sean Anderson wrote:
> This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is
> a "soft" block, so it has many parameters which would not be
> configurable in most hardware. This binding is usually automatically
> generated by Xilinx's tools, so the names and values of properties
> must be kept as they are.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
> Changes in v2:
> - Use 32-bit addresses for example binding
> 
>  .../bindings/pwm/xlnx,axi-timer.yaml          | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
> new file mode 100644
> index 000000000000..bd014134c322
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/xlnx,axi-timer.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/xlnx,axi-timer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
> +
> +maintainers:
> +  - Sean Anderson <sean.anderson@seco.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: xlnx,axi-timer-2.0
> +      - const: xlnx,xps-timer-1.00.a
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: s_axi_aclk
> +
> +  reg:
> +    maxItems: 1
> +
> +  xlnx,count-width:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 8
> +    maximum: 32
> +    description:
> +      The width of the counters, in bits.
> +
> +  xlnx,gen0-assert:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +    description:
> +      The polarity of the generateout0 signal. 0 for active-low, 1 for active-high.
> +
> +  xlnx,gen1-assert:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +    description:
> +      The polarity of the generateout1 signal. 0 for active-low, 1 for active-high.
> +
> +  xlnx,one-timer-only:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +    description:
> +      Whether only one timer is present in this block.
> +
> +  xlnx,trig0-assert:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +    description:
> +      The polarity of the capturetrig0 signal. 0 for active-low, 1 for active-high.
> +
> +  xlnx,trig1-assert:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 0, 1 ]
> +    description:
> +      The polarity of the capturetrig1 signal. 0 for active-low, 1 for active-high.
> +

Based on xilinx design tool selection there is also mode_64bit option
which I expect will be translate to xlnx,mode-64bit [0, 1].
But any coverage of this as bool property should be fine.

> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +  - xlnx,count-width
> +  - xlnx,gen0-assert
> +  - xlnx,gen1-assert

these 3 shouldn't be required.

> +  - xlnx,one-timer-only
> +  - xlnx,trig0-assert
> +  - xlnx,trig1-assert

these 2 are also not required.


> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    axi_timer_0: timer@800e0000 {
> +        clock-frequency = <99999001>;

I can't see this listed above. It is allowed to have additional
properties but I don't think it is good to list it here.

> +        clock-names = "s_axi_aclk";
> +        clocks = <&zynqmp_clk 71>;
> +        compatible = "xlnx,axi-timer-2.0", "xlnx,xps-timer-1.00.a";
> +        reg = <0x800e0000 0x10000>;
> +        xlnx,count-width = <0x20>;
> +        xlnx,gen0-assert = <0x1>;
> +        xlnx,gen1-assert = <0x1>;
> +        xlnx,one-timer-only = <0x0>;
> +        xlnx,trig0-assert = <0x1>;
> +        xlnx,trig1-assert = <0x1>;
> +    };
> 

Thanks,
Michal
