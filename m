Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7374318AE
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Oct 2021 14:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhJRMRX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Oct 2021 08:17:23 -0400
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com ([40.107.93.52]:36960
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229569AbhJRMRW (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 Oct 2021 08:17:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXIpzFMBNbRrkt2k1ZRn2XriNMHwSB0fpcxwd6o80OoO7G3Hs0q99EUwuwLA3Htle75yV5BANhW/3JXDYZoQJrsd1Xhrrlhuf71K99wvr4CvJ3Bi7Ld/XPGZOBfWkEP2h07ZNjgXbIEvEZAW5qoHcFY8Dv/CHOt2fh+ec5BIVftmmJrpAD10JxllVfd9luI9mJdY9SJh++tXRjehj7yXfzsJKLJx4070qSE1ALW1rD5rL5R9xJmOzpWnsR5QOJeiCIbyVZuLxO+Nc37ysaoVMRnRod8xCwGm6A82AnaJnvIymYZeDw1VBGc8J7F9BY7toOAvcw+piFDe3N+r79ynWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vdFTwTJH3m5xaNjGHzlntDlisIK04aBNAg16SARCEdA=;
 b=I/HE6fdOoOWwndetMPqWmZkDJFYfpXbJ9nlj5mCU3dLw1Bx4r4/EGHQFCddD2lIsUNASaGDffyEUpAcsrZ6MhoL/n17/VDXECm3urCeLJSlSm+Jw7cwYh8lrtQ1iACAH2TM+dSbOCec3x2us6X6pVtYLnxr0QZy++tfTMYlHPuWzHc/9VGFB9dqwd1uuKibmocYIkMey6KMJY5iFzxdDP0N1j9KPyOYx76DqUhVsUM1Q8lCV/WDDIfVZBBi1+m3KO0haQgx1uxhH5KESsav8tZP3ZZwm7kTZVRTozGkKRATQTafE1cIeX0ZO4VL7hc3NxbkF4Xa8czNcZVIePPQpsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=seco.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vdFTwTJH3m5xaNjGHzlntDlisIK04aBNAg16SARCEdA=;
 b=e917YiJ/L8co0Uya7DjVwxGwyxPlJks0QvKV2szRUuV3Aq9ttU0rS4tvmxXuYVmhuDChpjzVlnM4JW3CPs5ujfUP6N/sgMVFlvnrBGML+mXcm0jPbXTaJz5DoujNZea97M6y+LzARknuzuKJ2y/Pzxhv9vM0uU3aNP4TgS+U7aE=
Received: from SA9PR13CA0083.namprd13.prod.outlook.com (2603:10b6:806:23::28)
 by CY4PR02MB2360.namprd02.prod.outlook.com (2603:10b6:903:9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 12:15:09 +0000
Received: from SN1NAM02FT0063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:23:cafe::f3) by SA9PR13CA0083.outlook.office365.com
 (2603:10b6:806:23::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.10 via Frontend
 Transport; Mon, 18 Oct 2021 12:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; seco.com; dkim=none (message not signed)
 header.d=none;seco.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0063.mail.protection.outlook.com (10.97.5.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Mon, 18 Oct 2021 12:15:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 18 Oct 2021 05:15:08 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 18 Oct 2021 05:15:08 -0700
Envelope-to: sean.anderson@seco.com,
 linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org,
 thierry.reding@gmail.com,
 lee.jones@linaro.org,
 u.kleine-koenig@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 alvaro.gamez@hazent.com,
 linux-kernel@vger.kernel.org,
 robh@kernel.org
Received: from [10.254.241.49] (port=52278)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1mcRXo-000Fod-JR; Mon, 18 Oct 2021 05:15:08 -0700
Message-ID: <676342e6-b174-ad81-7a22-3e3e27090654@xilinx.com>
Date:   Mon, 18 Oct 2021 14:15:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v8 1/3] microblaze: timer: Remove unused properties
Content-Language: en-US
To:     Sean Anderson <sean.anderson@seco.com>,
        <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>
References: <20211015190025.409426-1-sean.anderson@seco.com>
From:   Michal Simek <michal.simek@xilinx.com>
In-Reply-To: <20211015190025.409426-1-sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 46f66b1d-1bb5-46f3-34f4-08d99230edb5
X-MS-TrafficTypeDiagnostic: CY4PR02MB2360:
X-Microsoft-Antispam-PRVS: <CY4PR02MB23601F2071C2239345592B79C6BC9@CY4PR02MB2360.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gh11m1uWbxtVnx+bs/0tbzxC0boGCIUmSo3PYKqPw9DdszwR2SS7ghKasUti8yu5HpyDrROLIcBPr7/pITEq1ewOSr/MfuLaPEBnmZXq7RsNCnI6+Tgjyulem789OZFCeDFg43q9PuoALdFGl4yKxQJG37yiiPEFOJAfNLQkIDiBqH6qQT8x07sM+j/+3qCbmBMvjHwkjVBk1pqjbBTMhTUYBd9Nr83xqVVxwW6fpTKDhvyyNkZJiKyd0rlCOAu6mItPpx+Ts6P40XXzAI32W0lJxAy1ae0kN6rapgNOPDqq9abVhqfTCRsWbJwr8eJa+dEf8bMOdHngmDTv4lABFB7GbKnhN6yaQqlMgwu81qUKwZxUqjSbrIMt9khVG02VvvDcgqFb7JWqWQbiWz2qvNSs6cYZIBnffcCrsy0juWFKMXB1odK8ZecFebKVkeOKqb6iOFHwRzsHuliblT6Se7p37b2Yvt9jwMznEppH8BuHnUo4jnTcsBc1VpHzvzqW8uBUBo4EP+Kd9du3bKwLXN2YEsqfUP+0/DqD2eqbTzQKWFSN4J/hPXJhWxrOmvkbxjxwNRKlWVpmPorV5K1OP0nABjVCVkViy6GZXj4cqLqx7wc7ZWtD+Yg/JLxtgbjPe4pqToeZ9+f7vdvGOEqYBoE4H8mm6hQQ0scexaKTW3hy4l8iSK2XwiVLRVwS2UUTn6lrVGjS4QEwbulU9GiCOWZerFuk7r2BaVQ/rE5r5FqrLjlY+CrsBLYiUBcS57Tw
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(36860700001)(31686004)(47076005)(316002)(8936002)(83380400001)(36756003)(53546011)(44832011)(356005)(336012)(6666004)(110136005)(9786002)(4326008)(186003)(5660300002)(7636003)(508600001)(70586007)(54906003)(82310400003)(70206006)(31696002)(26005)(7416002)(426003)(2906002)(8676002)(2616005)(36906005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 12:15:09.2987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46f66b1d-1bb5-46f3-34f4-08d99230edb5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2360
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 10/15/21 21:00, Sean Anderson wrote:
> This removes properties not used by either the PWM or timer drivers.
> This lets us set additionalProperties: false.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> ---
> 
> Changes in v8:
> - Remove additional properties from microblaze device tree
> 
>   arch/microblaze/boot/dts/system.dts | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/arch/microblaze/boot/dts/system.dts b/arch/microblaze/boot/dts/system.dts
> index b7ee1056779e..22252451ec09 100644
> --- a/arch/microblaze/boot/dts/system.dts
> +++ b/arch/microblaze/boot/dts/system.dts
> @@ -347,12 +347,7 @@ xps_timer_1: timer@83c00000 {
>   			interrupts = < 3 2 >;
>   			reg = < 0x83c00000 0x10000 >;
>   			xlnx,count-width = <0x20>;
> -			xlnx,family = "virtex5";
> -			xlnx,gen0-assert = <0x1>;
> -			xlnx,gen1-assert = <0x1>;
>   			xlnx,one-timer-only = <0x0>;
> -			xlnx,trig0-assert = <0x1>;
> -			xlnx,trig1-assert = <0x1>;
>   		} ;
>   	} ;
>   }  ;
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

If you want me to take this via microblaze tree, please let me know.

Thanks,
Michal
