Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B582372A1F
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 14:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbhEDMdI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 08:33:08 -0400
Received: from mail-mw2nam10on2072.outbound.protection.outlook.com ([40.107.94.72]:56929
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230245AbhEDMdH (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 4 May 2021 08:33:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hfu+NuAFQ/4BtlWeRlh++QLcAY5hFx6BF7iEH9hcTQc3u7CKI338CjEV1cwY90zCBduLfdiM9nufWHhAv9JVtfv5YAGtgpDHLirvpHSFUWdAe9sFX7AYmuxKzHdkpGyQYG8GdAwsBoDOdo4GDGtLFCeMCINX6/SBHkBgfMbmLXA2+5/BrWooKcD0EKjiCILeCb+YKiMCNnHL3Tr0d3bp1+6dSuytL25hRekgIgEim+hZ0rQFoVRLRZZompDwuhhWCpQcioFprTRv1u0XXBBYGJDy0jWLIrE8NA2fOwzz/I5QM5It1y4rV/i0UVPVq0697qwHnDoDgSdjA2z2mjUqnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBIs2665pQmzrIjbR+y+Dkp5PXvPE4V6seZj4Y0tYHk=;
 b=ShLdoWfoRyuHkgXezzL9Q3kerlE0Rf8H9Uw5JHHI1BbOTrXg1hgKi1ZMTcF59O58eVv1f4Aokzd112zG0wKS8NfeHqSb04TkTDCoI32an8WOvSIGSrKKPJK7NEBhtuPlbxQ8bzZAFZrPJ54VkhIh1GYHtOH8AhoJ7SSz6wsZpsB5PqIsN3TJmEYP8uZY4pPldLoib5ADX7zotNOjSQz0KwhovNbl5EzwdQkUAFXAIT3/5yy+OJaqABM+MnMYcxVnHAGPinZlVFtcmBmbd1+04iqJ791+AfXjNdZPPBfcfwzPJj+YKoI1NId9ygfxORlblHbiFuuG6WNQuJigApnJfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBIs2665pQmzrIjbR+y+Dkp5PXvPE4V6seZj4Y0tYHk=;
 b=lIU4qdIGJdpecAUCEUhYruwz8UmJBbs2xTWmeXFfKEu6LSuU8vIydyCrY7PrZNIOTXY49Y4dk25LvHLuFNSirQCjY+1idRVEb6G/rr7vm6W0vZGE+AfcBDxqnS1kzZExDft2riiSNWnMu3a646aJJzZWBeRjW0r63y/WuhGEWz0=
Received: from SN7PR04CA0047.namprd04.prod.outlook.com (2603:10b6:806:120::22)
 by SN1PR02MB3742.namprd02.prod.outlook.com (2603:10b6:802:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Tue, 4 May
 2021 12:32:09 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:120:cafe::b9) by SN7PR04CA0047.outlook.office365.com
 (2603:10b6:806:120::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Tue, 4 May 2021 12:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 4 May 2021 12:32:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 4 May 2021 05:32:08 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 4 May 2021 05:32:08 -0700
Envelope-to: thierry.reding@gmail.com,
 lee.jones@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-pwm@vger.kernel.org,
 sean.anderson@seco.com,
 u.kleine-koenig@pengutronix.de
Received: from [172.30.17.109] (port=44810)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lduDg-0004WA-Jr; Tue, 04 May 2021 05:32:08 -0700
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sean Anderson <sean.anderson@seco.com>
CC:     <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michal.simek@xilinx.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20210503214413.3145015-1-sean.anderson@seco.com>
 <20210503214413.3145015-2-sean.anderson@seco.com>
 <20210504085112.edyy6loprfzejrjl@pengutronix.de>
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/2] pwm: Add support for Xilinx AXI Timer
Message-ID: <dc6d9f40-a913-90c4-9675-0f84f789ab61@xilinx.com>
Date:   Tue, 4 May 2021 14:32:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210504085112.edyy6loprfzejrjl@pengutronix.de>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11d99a59-0576-497a-2733-08d90ef8a2e7
X-MS-TrafficTypeDiagnostic: SN1PR02MB3742:
X-Microsoft-Antispam-PRVS: <SN1PR02MB3742804520DDEE7963FBAC3BC65A9@SN1PR02MB3742.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 874VhArfZtKRpxdETvhrzfKott5M7tbpBWFBAK5yy/jeFiF3KknzKtDHPHqBzAA1Jx2YMhZpxf7yQm8pPR6kqOp0RHhtJK0p94WP9J5G8y8GepadciRjaYJdh8MUkETz8rUOGt8tOyKNDWUDnhBtRyw76tFBU1bhBYT3S8FAlZd/5VKU13rUhMk2AagmXILwc8c8Bvw8notFQXp1Y0CBIoTYKNcZz6+nYY7sM1FvRA+KnbAMTzh6E0zL8nOwTjhd46xX9+us/a4R2WV8dwIDzaqZacnVs+ywgPk5c4PSou2/hiyVWqDEgY9eSWxvmU1nTap68nXVjYDCYF8U6YqCok1f7drGGQJGoa1CTGj4QSAozZy6rMrcB8yflEUHTe6NKUvvOxi+Sm/zzJnwo4ov6Qg1s2fjB27GM+pksBNzvwSi7Cd76I9Cf1UTDYjGxmGQF6JK3ni3HKKpV/th2J+xAaH1V3+3AweNOFDx6B2BS2AxFfXjeQsp7hTzKrnXbOpjBuvVhYJOcqPqX+aA00mn/3u5u8F2u1FMq9n/7QgTFREG41jRi2R3LrDC2SruXvOYzAcoSuJnzmNhQ0MOYkSAKLHz+EkDGFuWoYfH3AgHRYDlGLfiMy0ngqzb5TshZvvMW4XvgA1qeyGCCql/giuxX5GnZYdXce5wxVJNQK6JVoi4jWP3JjFM0Xxi9Xe7SUH2zqUfmiAbyD6S292ZHTFO7qu0UZmJ8LgVF0xEAe2NoV0ayhFMSyqjsc9OS23O9dYE1GAg77DbwCVODrWsUy3tep1oIxtM4o8QZpHU5NMUubY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(46966006)(36840700001)(966005)(5660300002)(110136005)(8676002)(82310400003)(4326008)(31696002)(478600001)(36860700001)(36906005)(2906002)(316002)(70206006)(31686004)(54906003)(8936002)(36756003)(186003)(7636003)(47076005)(53546011)(9786002)(44832011)(2616005)(82740400003)(336012)(70586007)(426003)(26005)(356005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 12:32:09.6572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d99a59-0576-497a-2733-08d90ef8a2e7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR02MB3742
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/4/21 10:51 AM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, May 03, 2021 at 05:44:13PM -0400, Sean Anderson wrote:
>> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
>> found on Xilinx FPGAs. There is another driver for this device located
>> at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
>> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>>
>> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
>>
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>>
>>  arch/arm64/configs/defconfig |   1 +
>>  drivers/pwm/Kconfig          |  11 ++
>>  drivers/pwm/Makefile         |   1 +
>>  drivers/pwm/pwm-xilinx.c     | 322 +++++++++++++++++++++++++++++++++++
>>  4 files changed, 335 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-xilinx.c
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 08c6f769df9a..81794209f287 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1083,6 +1083,7 @@ CONFIG_PWM_SAMSUNG=y
>>  CONFIG_PWM_SL28CPLD=m
>>  CONFIG_PWM_SUN4I=m
>>  CONFIG_PWM_TEGRA=m
>> +CONFIG_PWM_XILINX=m
>>  CONFIG_SL28CPLD_INTC=y
>>  CONFIG_QCOM_PDC=y
>>  CONFIG_RESET_IMX7=y
> 
> I think this should go into a separate patch once this driver is
> accepted. This can then go via the ARM people.
> 
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index d3371ac7b871..01e62928f4bf 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -628,4 +628,15 @@ config PWM_VT8500
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-vt8500.
>>  
>> +config PWM_XILINX
>> +	tristate "Xilinx AXI Timer PWM support"
>> +	depends on !MICROBLAZE
> 
> I don't understand this dependency.

The dependency is clear here because microblaze has already driver for
this timer here arch/microblaze/kernel/timer.c.

And that's exactly pointing to the way how this should be done.
IP itself is single or dual timer and in case of dual timer you can
select if there is pwm output and use it for PWM generation.

It means it is timer with PMW together.
I didn't have a time but Uwe likely knows this better how to design it.

I see that gpio-mvebu driver instantiate pwm driver. Maybe that's the
way to go.

Step first is move axi timer driver from microblaze to generic location.
Figured it out how to add PWM (with DT flag) and then write support for it.

Thanks,
Michal
