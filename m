Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878AF4564E3
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Nov 2021 22:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhKRVLz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Nov 2021 16:11:55 -0500
Received: from mail-db8eur05on2048.outbound.protection.outlook.com ([40.107.20.48]:21856
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229774AbhKRVLy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 18 Nov 2021 16:11:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dq3E48+6gVNwXh5upaDKf+qNpq4X9fEyJRYLRpCXAfVE3iSKJrBtLVg1Kq5pDhuCLw1Xchxe/tcrg8ey5Fq+mx+Oh0FWXzU+JVAVq5KfGDfFQfEjUYpoPP/4xU6BM3oxwj3OhyQsoSuXXf+F12wqBjWX+NOa/NbF7PswwBV65gijHIQHDLDWfsbzHQX+jnmZAOraquiE2q4sLUTFBIykiwMp3BA3mJh2kR7u7x0RFoSlDWqzXj88h0DRgSa24T1SLYeHmrdgcO2DbdT/RIN9fjyglDBXgwGJn7cy2T1y0TrhbLC6QGpcu1pLXViKSz1I+Xq8MNprhqahFwUiibUE/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sgr0Ljt/nTnpUVe6I8TouvdVM4WpKi3br5rZzyd4CUo=;
 b=MAIstIUBDX/4h3SF6F6rwoUtS2UTl84q47Yco6e5C7CmrePtMve6v2Gp+hogi7TxdLAONwixVrm23R8noDoUP1lwlYKR25mRa6nYVAPuTRP35CxODdEhze+YU8PpdzBcKMro+EujekRTeG1mbxY6mP3JZfiqATajdNKVIxjuJ5YshjjRnGMg7L0Sw5jPOzYmJtkeLGMlYyoQumSB3QFgLr9ajVVFKgdFGVX4GG9HFdFqvx/tLd3Vqc1nBfvijamklsnzTgJ2Ie9bgGI3/IimhaeGyVO0IqbuoPgurfG55WAONbbhMx3LAWMUOqn9IX+uieWL74/NO/5Cindvu5U7Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sgr0Ljt/nTnpUVe6I8TouvdVM4WpKi3br5rZzyd4CUo=;
 b=f8VbK7rcPiZbqPPFwtjvS90I4ILBx5nxX3pn4ySdt0owdERf6FXRTJDoKFSOS7nl8D93TsiuRW2osk46aRZqvJbwvVAeGreLZKjwKRG39RJy6xlg+/L973zj5eYA2DKES75Im8CnKurTNeijhOXtBr6iy3s3umIvMzEEiEDqAWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB6PR0302MB2822.eurprd03.prod.outlook.com (2603:10a6:4:ae::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 21:08:50 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee%4]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 21:08:50 +0000
From:   Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v10 3/3] pwm: Add support for Xilinx AXI Timer
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com
References: <20211112185504.1921780-1-sean.anderson@seco.com>
 <20211112185504.1921780-3-sean.anderson@seco.com>
 <20211118092813.xhulsyy5l36ukngw@pengutronix.de>
Message-ID: <e826e68c-d725-79ef-2140-365383eaf0e0@seco.com>
Date:   Thu, 18 Nov 2021 16:08:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20211118092813.xhulsyy5l36ukngw@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:208:32a::27) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
Received: from [172.27.1.65] (50.195.82.171) by BLAPR03CA0112.namprd03.prod.outlook.com (2603:10b6:208:32a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Thu, 18 Nov 2021 21:08:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10f5e403-747e-4696-6ae7-08d9aad79e7f
X-MS-TrafficTypeDiagnostic: DB6PR0302MB2822:
X-Microsoft-Antispam-PRVS: <DB6PR0302MB28229E5398270E83F049B4B8969B9@DB6PR0302MB2822.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3L3+OTUGCxyHykJVN0EsaUErOoZNLulQhO2avVwD5c8BclFl4HT3g4aAdbJKbkObJp9EQU9oaP6SazxSn3HAV2CU53P2Nm3BChc0xfJ6EffdYUbIpCqf6A1RqJTWTLEins1ilwc4gXNeXaOpYQkBtTYGS7NeTOA4kVBzMXMU5N8wNgS9aHerK6o+3H6UHVm79vdazSvt6UNASUTrCtS5AfVO/o0dhKAEPxPntBksh3sOHNj5ApZMdhaM5AlWKA2Dw0Dc0lpLG/B8VMpvlBdcmVYfNr2DdkywnFxz0GHYUa9V2OVDKNDwBp5DLIkDq38F7nT4tQfxFjsWcCZUXAUChtl/b/lutiOHCIapsEVaNLfXpnFdW7BfWfyZt0LRT2qLwREv8rP4VW4NIZSIl6IouhYbEJmA7Sh2KAT6sifEdb2icKzA2zTUDugqWVYMHvSqCkuSG+XyO2D9AyhfWaFPrfQ7uqxFGoxquhcdl9SPWESJe0PneNvm+l7YLP3RTfsYmJ8zoJrN7NNzazJiQXss/WR3WaGfGOxXAebu4G833E2t8MXQqW03vTEYohvAaQAYdqbca84gHgQa/oc7mBuVImNzyZn5BkPc4x5YNOI4a02VUvI7Z8l3PTkanE87LbAF1W6i0fYkyddUfbTrZ1C3aOA1ZDtS/+u7AiYJ8IecP7lA64iyU87LYmuopipwFSY9Kcv8yxtHq1Rf1+rFltIAewowNDYkun5m8EOXxZW6m/6TMYGTmjFfvvQ4AuXLTht6Fa0g64xIAptxEuLuiZCb7Q7afyPm0tV+jOxRL9Uj3EC8JWA+kjT//ILb1wdvVhB5WWivIw7IJABW9TOF5sJK3auusYMriQy2mxAEaGSG0ow=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(31686004)(5660300002)(66946007)(52116002)(86362001)(44832011)(316002)(6486002)(186003)(54906003)(2616005)(30864003)(956004)(31696002)(6916009)(53546011)(4326008)(6666004)(38350700002)(508600001)(66476007)(66556008)(38100700002)(83380400001)(8676002)(966005)(2906002)(36756003)(16576012)(66574015)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?02RnnvuIrPSuLnX6T4v79uB5DcZqHzIRvfp7YC5/TrjR83GmjeGp6AnN?=
 =?Windows-1252?Q?8Wq+yUe27hC2QOE+oFcsaQn0Rjhc6bZzqTnYnzraPQI+HAkT+XqZssdL?=
 =?Windows-1252?Q?Dsl4qLtoVve4lyJPcv5WeytDe3EzcmJBrQm13t6b5tM0b5r2BlI/hz3E?=
 =?Windows-1252?Q?YxFiSND+WYEIRl2JhxzAmlAu5IAvwjD2dwXfboHGXvfVnWZN24EpYEci?=
 =?Windows-1252?Q?r/lT4UQq1oY2CD8qRnLida4hWKpkCniSGGT+jwtNhPLEHjk7X3+F5Emc?=
 =?Windows-1252?Q?uqPkde04DaILqyLK8lAH++F+xZmMqygdPZb+bc9ZF8TS8NiifUOHVnTm?=
 =?Windows-1252?Q?H/F76JS1dSUw1KZXb2av+IH/1Lh6w/zEMpjggk4QKSbK/bt0b7w2e2G7?=
 =?Windows-1252?Q?Iq4UT+Dri4R1LJgUK7bRrjyIG1W4Nit3uVcd4yzZl9cnYmVw/cBextzE?=
 =?Windows-1252?Q?Cmmg/2XkZSA/pKR4IICZO2JtAt8DoLs13bwaM0+q+wyIQn4zoEyf4Svd?=
 =?Windows-1252?Q?NXLrEiAm/T11Y+PSpFVeaVdC7XUglj/ryJrK7SIXSrmzOM4NbnvQs3Z3?=
 =?Windows-1252?Q?YRnna+Up8Rsv2eV8dql9OTK9RcFnYpGTPJ/JqRnEExNC31J5RPYVQbRI?=
 =?Windows-1252?Q?aG+4SS8bpN7fiHWYEGcPaeYyxCWru6CXBo3HWbm1wLlQnFiM6jVabrDo?=
 =?Windows-1252?Q?vjapZ/9NbV3kgUrAmuvjO2Wm5/g1T3ELPNj1fv6caHgseAExwA0Duzbx?=
 =?Windows-1252?Q?AV/iXeWUy0tqiolTXPzqxY+ZqesDY0TckNoeEuJZRkLigP7g8uzAl2kR?=
 =?Windows-1252?Q?tdx1I6LDzpB/AsYSwobHrCwumVFUdittXLXwaXXY3PzUsi1JVqfT6I4q?=
 =?Windows-1252?Q?M8RkcVG1uceMWZd0KZAW+G8a3GwVAn0WWblfzyUU8O5f4BJLcw6bSZKg?=
 =?Windows-1252?Q?R6e4VyS2tIk2ArjEWUT/eqb96RwpHWV9g5MspzymFZUlq8g2Lxizz0NS?=
 =?Windows-1252?Q?an+ef1GMo13n2AMn6ApIuaQjyokN5OkVSsWuwiME4pKXGHtzlZcMdpUr?=
 =?Windows-1252?Q?bJDRkX4u8x97HvuKaZw5XLdU4yF2KNPUruAovQKUPGZP2qZYWJSD7XuT?=
 =?Windows-1252?Q?rfOoIJ546dUE8wEAc1y//TEpeNtyU9b5r9wjmYw5aOEUNeFKv+1wPb9l?=
 =?Windows-1252?Q?RehwszkogAxscm0axoo6OUQPW1eRKD+x071u9xxD8QOdsBFfzDLIJCFU?=
 =?Windows-1252?Q?Fu/Op6bwz1WQnXPVDKNm0cFDYCbeFegV3ro45XRO5/0tlY8GEG32gfGe?=
 =?Windows-1252?Q?fmq914Bph9tDtu7YBqhT7ng/Wbu9IeW/8HOBL6u/odK9wasuxxHePYVZ?=
 =?Windows-1252?Q?7j6FM3eftNjS0LQO47ITT9g9VKMxIZRtyQ4U11paleoB1fEHPbHVpOg+?=
 =?Windows-1252?Q?po7fJ9ojLhBr/FXNy5zzcwM5DY8tMnWzu8vCZVgOM80Z8XxfFn4sZ6Sm?=
 =?Windows-1252?Q?DX/zzlue1yYVkt+eg+O+7jB4bRaT3AQ8jjVv6O8+lcb0pEV1OtfTgiOv?=
 =?Windows-1252?Q?OzRqmSgiw7ihmBxoLj4TgfVEC9VrfH4OrBOAjUewili6yYiwSxBBvP3b?=
 =?Windows-1252?Q?cweROJbL/Qo5o/4QtOeAmjkQ3FdxAD5gqCnUpk/QOMHxX22fbJXZBMwo?=
 =?Windows-1252?Q?2STKCtyfWCkEYVm/gV4+wIpSMIyEYPUBuemXsl9dg4FwMw68NoliWpeQ?=
 =?Windows-1252?Q?i40dkWCtlJ7gqvW7qpI=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f5e403-747e-4696-6ae7-08d9aad79e7f
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 21:08:50.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTmQCDjY1eND7apKmKWMB3vImkYjDZUa9lTZNDE/L3Vfsy+GHQ23vooLCYb8cf5Cs/KF9RaltOy1Yke2ePMKlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0302MB2822
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 11/18/21 4:28 AM, Uwe Kleine-König wrote:
> Hello,
>
> On Fri, Nov 12, 2021 at 01:55:04PM -0500, Sean Anderson wrote:
>> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
>> found on Xilinx FPGAs. At the moment clock control is very basic: we
>> just enable the clock during probe and pin the frequency. In the future,
>> someone could add support for disabling the clock when not in use.
>>
>> Some common code has been specially demarcated. While currently only
>> used by the PWM driver, it is anticipated that it may be split off in
>> the future to be used by the timer driver as well.
>>
>> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>>
>> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
>>
>> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
>> ---
>>
>> Changes in v10:
>> - Fix compilation error in timer driver
>>
>> Changes in v9:
>> - Refactor "if { return } else if { }" to "if { return } if { }"
>> - Remove drivers/clocksource/timer-xilinx-common.c from MAINTAINERS
>> - Remove xilinx_timer_common_init and integrate it into xilinx_timer_probe
>>
>> Changes in v8:
>> - Drop new timer driver; it has been deferred for future series
>>
>> Changes in v7:
>> - Add dependency on OF_ADDRESS
>> - Fix period_cycles calculation
>> - Fix typo in limitations
>>
>> Changes in v6:
>> - Capitalize error messages
>> - Don't disable regmap locking to allow inspection of registers via
>>   debugfs
>> - Prevent overflow when calculating period_cycles
>> - Remove enabled variable from xilinx_pwm_apply
>> - Swap order of period_cycle range comparisons
>>
>> Changes in v5:
>> - Allow non-zero #pwm-cells
>> - Correctly set duty_cycle in get_state when TLR0=TLR1
>> - Elaborate on limitation section
>> - Perform some additional checks/rounding in apply_state
>> - Remove xlnx,axi-timer-2.0 compatible string
>> - Rework duty-cycle and period calculations with feedback from Uwe
>> - Switch to regmap to abstract endianness issues
>> - Use more verbose error messages
>>
>> Changes in v4:
>> - Don't use volatile in read/write replacements. Some arches have it and
>>   some don't.
>> - Put common timer properties into their own struct to better reuse
>>   code.
>> - Remove references to properties which are not good enough for Linux.
>>
>> Changes in v3:
>> - Add clockevent and clocksource support
>> - Remove old microblaze driver
>> - Rewrite probe to only use a device_node, since timers may need to be
>>   initialized before we have proper devices. This does bloat the code a bit
>>   since we can no longer rely on helpers such as dev_err_probe. We also
>>   cannot rely on device resources being free'd on failure, so we must free
>>   them manually.
>> - We now access registers through xilinx_timer_(read|write). This allows us
>>   to deal with endianness issues, as originally seen in the microblaze
>>   driver. CAVEAT EMPTOR: I have not tested this on big-endian!
>>
>> Changes in v2:
>> - Add comment describing device
>> - Add comment explaining why we depend on !MICROBLAZE
>> - Add dependencies on COMMON_CLK and HAS_IOMEM
>> - Cast dividends to u64 to avoid overflow
>> - Check for over- and underflow when calculating TLR
>> - Check range of xlnx,count-width
>> - Don't compile this module by default for arm64
>> - Don't set pwmchip.base to -1
>> - Ensure the clock is always running when the pwm is registered
>> - Remove debugfs file :l
>> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
>> - Report errors with dev_error_probe
>> - Set xilinx_pwm_ops.owner
>> - Use NSEC_TO_SEC instead of defining our own
>> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
>>
>>  MAINTAINERS                        |   6 +
>>  arch/microblaze/kernel/timer.c     |   3 +
>>  drivers/pwm/Kconfig                |  14 ++
>>  drivers/pwm/Makefile               |   1 +
>>  drivers/pwm/pwm-xilinx.c           | 311 +++++++++++++++++++++++++++++
>>  include/clocksource/timer-xilinx.h |  91 +++++++++
>>  6 files changed, 426 insertions(+)
>>  create mode 100644 drivers/pwm/pwm-xilinx.c
>>  create mode 100644 include/clocksource/timer-xilinx.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3b79fd441dde..6f0f57c041c4 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20614,6 +20614,12 @@ F:	drivers/misc/Makefile
>>  F:	drivers/misc/xilinx_sdfec.c
>>  F:	include/uapi/misc/xilinx_sdfec.h
>>
>> +XILINX PWM DRIVER
>> +M:	Sean Anderson <sean.anderson@seco.com>
>> +S:	Maintained
>> +F:	drivers/pwm/pwm-xilinx.c
>> +F:	include/clocksource/timer-xilinx.h
>> +
>>  XILINX UARTLITE SERIAL DRIVER
>>  M:	Peter Korsgaard <jacmet@sunsite.dk>
>>  L:	linux-serial@vger.kernel.org
>> diff --git a/arch/microblaze/kernel/timer.c b/arch/microblaze/kernel/timer.c
>> index f8832cf49384..dea34a3d4aa4 100644
>> --- a/arch/microblaze/kernel/timer.c
>> +++ b/arch/microblaze/kernel/timer.c
>> @@ -251,6 +251,9 @@ static int __init xilinx_timer_init(struct device_node *timer)
>>  	u32 timer_num = 1;
>>  	int ret;
>>
>> +	if (of_property_read_bool(timer, "#pwm-cells"))
>> +		return 0;
>> +
>>  	if (initialized)
>>  		return -EINVAL;
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index aa29841bbb79..47f25237754f 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -638,4 +638,18 @@ config PWM_VT8500
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called pwm-vt8500.
>>
>> +config PWM_XILINX
>> +	tristate "Xilinx AXI Timer PWM support"
>> +	depends on OF_ADDRESS
>> +	depends on COMMON_CLK
>> +	select REGMAP_MMIO
>> +	help
>> +	  PWM driver for Xilinx LogiCORE IP AXI timers. This timer is
>> +	  typically a soft core which may be present in Xilinx FPGAs.
>> +	  This device may also be present in Microblaze soft processors.
>> +	  If you don't have this IP in your design, choose N.
>> +
>> +	  To compile this driver as a module, choose M here: the module
>> +	  will be called pwm-xilinx.
>> +
>>  endif
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 708840b7fba8..ea785480359b 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -60,3 +60,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
>>  obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
>>  obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
>>  obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
>> +obj-$(CONFIG_PWM_XILINX)	+= pwm-xilinx.o
>> diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
>> new file mode 100644
>> index 000000000000..d79ef202d62f
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-xilinx.c
>> @@ -0,0 +1,311 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
>> + *
>> + * Limitations:
>> + * - When changing both duty cycle and period, we may end up with one cycle
>> + *   with the old duty cycle and the new period. This is because the counters
>> + *   may only be reloaded by first stopping them, or by letting them be
>> + *   automatically reloaded at the end of a cycle. If this automatic reload
>> + *   happens after we set TLR0 but before we set TLR1 then we will have a
>> + *   bad cycle. This could probably be fixed by reading TCR0 just before
>> + *   reprogramming, but I think it would add complexity for little gain.
>> + * - Cannot produce 100% duty cycle by configuring the TLRs. This might be
>> + *   possible by stopping the counters at an appropriate point in the cycle,
>> + *   but this is not (yet) implemented.
>> + * - Only produces "normal" output.
>> + * - Always produces low output if disabled.
>> + */
>> +
>> +#include <clocksource/timer-xilinx.h>
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pwm.h>
>> +#include <linux/regmap.h>
>> +
>> +/*
>> + * The following functions are "common" to drivers for this device, and may be
>> + * exported at a future date.
>> + */
>> +u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
>> +			    u64 cycles)
>> +{
>> +	WARN_ON(cycles < 2 || cycles - 2 > priv->max);
>> +
>> +	if (tcsr & TCSR_UDT)
>> +		return cycles - 2;
>> +	return priv->max - cycles + 2;
>> +}
>> +
>> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
>> +				     u32 tlr, u32 tcsr)
>> +{
>> +	u64 cycles;
>> +
>> +	if (tcsr & TCSR_UDT)
>> +		cycles = tlr + 2;
>> +	else
>> +		cycles = (u64)priv->max - tlr + 2;
>> +
>> +	/* cycles has a max of 2^32 + 2 */
>> +	return DIV64_U64_ROUND_CLOSEST(cycles * NSEC_PER_SEC,
>> +				       clk_get_rate(priv->clk));
>
> Please round up here.

Please document the correct rounding mode you expect. The last time we
discussed this (3 months ago), you only said that rounding down was
incorrect...

>> +}
>> +
>> +/*
>> + * The idea here is to capture whether the PWM is actually running (e.g.
>> + * because we or the bootloader set it up) and we need to be careful to ensure
>> + * we don't cause a glitch. According to the data sheet, to enable the PWM we
>> + * need to
>> + *
>> + * - Set both timers to generate mode (MDT=1)
>> + * - Set both timers to PWM mode (PWMA=1)
>> + * - Enable the generate out signals (GENT=1)
>> + *
>> + * In addition,
>> + *
>> + * - The timer must be running (ENT=1)
>> + * - The timer must auto-reload TLR into TCR (ARHT=1)
>> + * - We must not be in the process of loading TLR into TCR (LOAD=0)
>> + * - Cascade mode must be disabled (CASC=0)
>> + *
>> + * If any of these differ from usual, then the PWM is either disabled, or is
>> + * running in a mode that this driver does not support.
>> + */
>> +#define TCSR_PWM_SET (TCSR_GENT | TCSR_ARHT | TCSR_ENT | TCSR_PWMA)
>> +#define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
>> +#define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
>> +
>> +struct xilinx_pwm_device {
>> +	struct pwm_chip chip;
>> +	struct xilinx_timer_priv priv;
>> +};
>> +
>> +static inline struct xilinx_timer_priv
>> +*xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
>> +{
>> +	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
>> +}
>> +
>> +static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
>> +{
>> +	return ((TCSR_PWM_MASK | TCSR_CASC) & tcsr0) == TCSR_PWM_SET &&
>> +		(TCSR_PWM_MASK & tcsr1) == TCSR_PWM_SET;
>> +}
>> +
>> +static int xilinx_pwm_apply(struct pwm_chip *chip, struct pwm_device *unused,
>> +			    const struct pwm_state *state)
>> +{
>> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>> +	u32 tlr0, tlr1, tcsr0, tcsr1;
>> +	u64 period_cycles, duty_cycles;
>> +	unsigned long rate;
>> +
>> +	if (state->polarity != PWM_POLARITY_NORMAL)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * To be representable by TLR, cycles must be between 2 and
>> +	 * priv->max + 2. To enforce this we can reduce the duty
>> +	 * cycle, but we may not increase it.
>> +	 */
>> +	rate = clk_get_rate(priv->clk);
>> +	/* Prevent overflow by clamping to the worst case of rate */
>
> I wouldn't have called this "worst case of rate", maybe better use
> "maximal rate"?

OK

>> +	period_cycles = min_t(u64, state->period, ULONG_MAX * NSEC_PER_SEC);
>> +	period_cycles = mul_u64_u32_div(period_cycles, rate, NSEC_PER_SEC);
>> +	if (period_cycles < 2 || period_cycles - 2 > priv->max)
>> +		return -ERANGE;
>
> if period_cycles - 2 > priv->max the right reaction is to do
>
> 	period_cycles = priv->max + 2

It has been 5 months since we last talked about this, and yet you have
not submitted any patches for a "pwm_round_rate" function. Forgive me if
I am reticent to implement forward compatibility for an API which shows
no signs of appearing.

>> +	duty_cycles = mul_u64_u32_div(state->duty_cycle, rate, NSEC_PER_SEC);
>
> duty_cycle needs sanitation in case period was reduced and duty_cycle is
> bigger now than period.

OK

>> +	/*
>> +	 * If we specify 100% duty cycle, we will get 0% instead, so decrease
>> +	 * the duty cycle count by one.
>> +	 */
>> +	if (period_cycles == duty_cycles)
>> +		duty_cycles--;
>> +
>> +	/* Round down to 0% duty cycle for unrepresentable duty cycles */
>> +	if (duty_cycles < 2)
>> +		duty_cycles = period_cycles;
>> +
>> +	regmap_read(priv->map, TCSR0, &tcsr0);
>> +	regmap_read(priv->map, TCSR1, &tcsr1);
>> +	tlr0 = xilinx_timer_tlr_cycles(priv, tcsr0, period_cycles);
>> +	tlr1 = xilinx_timer_tlr_cycles(priv, tcsr1, duty_cycles);
>> +	regmap_write(priv->map, TLR0, tlr0);
>> +	regmap_write(priv->map, TLR1, tlr1);
>> +
>> +	if (state->enabled) {
>> +		/*
>> +		 * If the PWM is already running, then the counters will be
>> +		 * reloaded at the end of the current cycle.
>> +		 */
>> +		if (!xilinx_timer_pwm_enabled(tcsr0, tcsr1)) {
>> +			/* Load TLR into TCR */
>> +			regmap_write(priv->map, TCSR0, tcsr0 | TCSR_LOAD);
>> +			regmap_write(priv->map, TCSR1, tcsr1 | TCSR_LOAD);
>> +			/* Enable timers all at once with ENALL */
>> +			tcsr0 = (TCSR_PWM_SET & ~TCSR_ENT) | (tcsr0 & TCSR_UDT);
>> +			tcsr1 = TCSR_PWM_SET | TCSR_ENALL | (tcsr1 & TCSR_UDT);
>> +			regmap_write(priv->map, TCSR0, tcsr0);
>> +			regmap_write(priv->map, TCSR1, tcsr1);
>> +		}
>> +	} else {
>> +		regmap_write(priv->map, TCSR0, 0);
>> +		regmap_write(priv->map, TCSR1, 0);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void xilinx_pwm_get_state(struct pwm_chip *chip,
>> +				 struct pwm_device *unused,
>> +				 struct pwm_state *state)
>> +{
>> +	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
>> +	u32 tlr0, tlr1, tcsr0, tcsr1;
>> +
>> +	regmap_read(priv->map, TLR0, &tlr0);
>> +	regmap_read(priv->map, TLR1, &tlr1);
>> +	regmap_read(priv->map, TCSR0, &tcsr0);
>> +	regmap_read(priv->map, TCSR1, &tcsr1);
>> +	state->period = xilinx_timer_get_period(priv, tlr0, tcsr0);
>> +	state->duty_cycle = xilinx_timer_get_period(priv, tlr1, tcsr1);
>> +	state->enabled = xilinx_timer_pwm_enabled(tcsr0, tcsr1);
>> +	state->polarity = PWM_POLARITY_NORMAL;
>> +
>> +	/* 100% duty cycle results in constant low output */
>> +	if (state->period == state->duty_cycle)
>> +		state->duty_cycle = 0;
>> +}
>> +
>> +static const struct pwm_ops xilinx_pwm_ops = {
>> +	.apply = xilinx_pwm_apply,
>> +	.get_state = xilinx_pwm_get_state,
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> +static const struct regmap_config xilinx_pwm_regmap_config = {
>> +	.reg_bits = 32,
>> +	.reg_stride = 4,
>> +	.val_bits = 32,
>> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
>> +	.max_register = TCR1,
>> +};
>> +
>> +static int xilinx_timer_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *np = dev->of_node;
>> +	struct xilinx_timer_priv *priv;
>> +	struct xilinx_pwm_device *pwm;
>
> The name "pwm" is usually reserved for struct pwm_device pointers. A
> typical name for this would be xlnxpwm or ddata.

I suppose. However, no variables of struct pwm_device are used in
this driver.

>> +	u32 pwm_cells, one_timer, width;
>> +	void __iomem *regs;
>> +
>> +	ret = of_property_read_u32(np, "#pwm-cells", &pwm_cells);
>> +	if (ret == -EINVAL)
>> +		return -ENODEV;
>
> A comment about why this is done would be great.

OK. How about:

/* If there are no #pwm-cells, this binding is for a timer and not a PWM */

>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
>> +
>> +	pwm = devm_kzalloc(dev, sizeof(*pwm), GFP_KERNEL);
>> +	if (!pwm)
>> +		return -ENOMEM;
>> +	platform_set_drvdata(pdev, pwm);
>> +	priv = &pwm->priv;
>> +
>> +	regs = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(regs))
>> +		return PTR_ERR(regs);
>> +
>> +	priv->map = devm_regmap_init_mmio(dev, regs,
>> +					  &xilinx_pwm_regmap_config);
>> +	if (IS_ERR(priv->map))
>> +		return dev_err_probe(dev, PTR_ERR(priv->map),
>> +				     "Could not create regmap\n");
>> +
>> +	ret = of_property_read_u32(np, "xlnx,one-timer-only", &one_timer);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Could not read xlnx,one-timer-only\n");
>> +
>> +	if (one_timer)
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "Two timers required for PWM mode\n");
>> +
>> +
>> +	ret = of_property_read_u32(np, "xlnx,count-width", &width);
>> +	if (ret == -EINVAL)
>> +		width = 32;
>> +	else if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Could not read xlnx,count-width\n");
>> +
>> +	if (width != 8 && width != 16 && width != 32)
>> +		return dev_err_probe(dev, -EINVAL,
>> +				     "Invalid counter width %d\n", width);
>> +	priv->max = BIT_ULL(width) - 1;
>> +
>> +	/*
>> +	 * The polarity of the generate outputs must be active high for PWM
>
> s/generate/generated/

The signals I am referring to are called "GenerateOut0" and
"GenerateOut1".

>> +	 * mode to work. We could determine this from the device tree, but
>> +	 * alas, such properties are not allowed to be used.
>> +	 */
>> +
>> +	priv->clk = devm_clk_get(dev, "s_axi_aclk");
>> +	if (IS_ERR(priv->clk))
>> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
>> +				     "Could not get clock\n");
>> +
>> +	ret = clk_prepare_enable(priv->clk);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Clock enable failed\n");
>> +	clk_rate_exclusive_get(priv->clk);
>> +
>> +	pwm->chip.dev = dev;
>> +	pwm->chip.ops = &xilinx_pwm_ops;
>> +	pwm->chip.npwm = 1;
>> +	ret = pwmchip_add(&pwm->chip);
>> +	if (ret) {
>> +		clk_rate_exclusive_put(priv->clk);
>> +		clk_disable_unprepare(priv->clk);
>> +		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int xilinx_timer_remove(struct platform_device *pdev)
>> +{
>> +	struct xilinx_pwm_device *pwm = platform_get_drvdata(pdev);
>> +
>> +	pwmchip_remove(&pwm->chip);
>> +	clk_rate_exclusive_put(pwm->priv.clk);
>> +	clk_disable_unprepare(pwm->priv.clk);
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id xilinx_timer_of_match[] = {
>> +	{ .compatible = "xlnx,xps-timer-1.00.a", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, xilinx_timer_of_match);
>> +
>> +static struct platform_driver xilinx_timer_driver = {
>> +	.probe = xilinx_timer_probe,
>> +	.remove = xilinx_timer_remove,
>> +	.driver = {
>> +		.name = "xilinx-timer",
>
> Doesn't this give a wrong impression as this is a PWM driver, not a
> timer driver?

Perhaps. Though this is the PWM driver for the Xilinx AXI timer, not the
Xilinx AXI PWM.

--Sean

>> +		.of_match_table = of_match_ptr(xilinx_timer_of_match),
>> +	},
>> +};
>> +module_platform_driver(xilinx_timer_driver);
>> +
>> +MODULE_ALIAS("platform:xilinx-timer");
>> +MODULE_DESCRIPTION("Xilinx LogiCORE IP AXI Timer driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/include/clocksource/timer-xilinx.h b/include/clocksource/timer-xilinx.h
>> new file mode 100644
>> index 000000000000..1f7757b84a5e
>> --- /dev/null
>> +++ b/include/clocksource/timer-xilinx.h
>> @@ -0,0 +1,91 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2021 Sean Anderson <sean.anderson@seco.com>
>> + */
>> +
>> +#ifndef XILINX_TIMER_H
>> +#define XILINX_TIMER_H
>> +
>> +#include <linux/compiler.h>
>> +
>> +#define TCSR0	0x00
>> +#define TLR0	0x04
>> +#define TCR0	0x08
>> +#define TCSR1	0x10
>> +#define TLR1	0x14
>> +#define TCR1	0x18
>> +
>> +#define TCSR_MDT	BIT(0)
>> +#define TCSR_UDT	BIT(1)
>> +#define TCSR_GENT	BIT(2)
>> +#define TCSR_CAPT	BIT(3)
>> +#define TCSR_ARHT	BIT(4)
>> +#define TCSR_LOAD	BIT(5)
>> +#define TCSR_ENIT	BIT(6)
>> +#define TCSR_ENT	BIT(7)
>> +#define TCSR_TINT	BIT(8)
>> +#define TCSR_PWMA	BIT(9)
>> +#define TCSR_ENALL	BIT(10)
>> +#define TCSR_CASC	BIT(11)
>> +
>> +struct clk;
>> +struct device_node;
>> +struct regmap;
>> +
>> +/**
>> + * struct xilinx_timer_priv - Private data for Xilinx AXI timer drivers
>> + * @map: Regmap of the device, possibly with an offset
>> + * @clk: Parent clock
>> + * @max: Maximum value of the counters
>> + */
>> +struct xilinx_timer_priv {
>> +	struct regmap *map;
>> +	struct clk *clk;
>> +	u32 max;
>> +};
>> +
>> +/**
>> + * xilinx_timer_tlr_cycles() - Calculate the TLR for a period specified
>> + *                             in clock cycles
>> + * @priv: The timer's private data
>> + * @tcsr: The value of the TCSR register for this counter
>> + * @cycles: The number of cycles in this period
>> + *
>> + * Callers of this function MUST ensure that @cycles is representable as
>> + * a TLR.
>> + *
>> + * Return: The calculated value for TLR
>> + */
>> +u32 xilinx_timer_tlr_cycles(struct xilinx_timer_priv *priv, u32 tcsr,
>> +			    u64 cycles);
>> +
>> +/**
>> + * xilinx_timer_get_period() - Get the current period of a counter
>> + * @priv: The timer's private data
>> + * @tlr: The value of TLR for this counter
>> + * @tcsr: The value of TCSR for this counter
>> + *
>> + * Return: The period, in ns
>> + */
>> +unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
>> +				     u32 tlr, u32 tcsr);
>> +
>> +/**
>> + * xilinx_timer_common_init() - Perform common initialization for Xilinx
>> + *                              AXI timer drivers.
>> + * @priv: The timer's private data
>> + * @np: The devicetree node for the timer
>> + * @one_timer: Set to %1 if there is only one timer
>> + *
>> + * This performs common initialization, such as detecting endianness,
>> + * and parsing devicetree properties. @priv->regs must be initialized
>> + * before calling this function. This function initializes @priv->read,
>> + * @priv->write, and @priv->width.
>> + *
>> + * Return: 0, or negative errno
>> + */
>> +int xilinx_timer_common_init(struct device_node *np,
>> +			     struct xilinx_timer_priv *priv,
>> +			     u32 *one_timer);
>> +
>> +#endif /* XILINX_TIMER_H */
>> --
>> 2.25.1
>>
>>
>
