Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21923755A1
	for <lists+linux-pwm@lfdr.de>; Thu,  6 May 2021 16:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhEFO3X (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 May 2021 10:29:23 -0400
Received: from mail-eopbgr20072.outbound.protection.outlook.com ([40.107.2.72]:45779
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234002AbhEFO3S (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 6 May 2021 10:29:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWn4sIoNsWS0QAgsiXDQ/NcwiYPxJKhxwpIEWL3itt1dGlIvE4NT5bzoxMtDJG02xcO9dFhqKnOphpTo4+zAO+7tFe7C6+ZFYiBULFM6ZUqpOwAZKZ1ZitBVr0LEv6PLMEWg29AAOWx3+fY/GUJFjjeB0BZGe4IGbVd8HA4ePpPP7HJATHY3MHTAncyk0pZdSz+ib++scTX3JA6MbSEeWSpBqsvgRHTC4tPxvkyo4pGlPr7LGBpBZw18RwHPe5jm8ZQXgulhlXUyOblrzvyONDxHbpZHf7pFqva9e7CM1NbuyUrHcAQqG92NoigkD9NpkibFpcOcUjLyh21+Fy6WxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbI7F/kVtQSSLlS1Ir3sTp6Ao/lI2J2Zv8KPXE3BY+w=;
 b=b6b6zMycX37eQ4KBZyIaPliMKIGPhypLPTo4prA5hux6tzJ7o19GM+6cgNg7U+AQg/jDnueUmNmSS2kZHdZY6W9/TRVb4g27HXLF4Wd4l1GOPh+PhpC5FbW0Yusc5yIZ47+yXtY2+CPnANTTeXlcyUcocG7z9Gzej+kTZhnI/5vTkSG1sOAUPVV5y4TLA2pBHqA5ygJxjHB0THhXE22woTnKvcrAiETT1OOfm3KF7p15V4Yu5asxLMePVduJtj7JCD2Ksn0GtHbdcp3OEeNVSA/AAOjwxzgXI0KY+Y97yel0pFoXuHUWUtiANLzaAX2ETVhUPM37uxfU/J3Z+bKvrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbI7F/kVtQSSLlS1Ir3sTp6Ao/lI2J2Zv8KPXE3BY+w=;
 b=j+gj5YS+gcQbt85wktnUilMFvaHlixOjfMveMaFxxq1IPM8f5cprMYsJ4jlnE78wkMrh3puOL9KKGJSB/9qc6874tD0S2eEMqsvv6BZPo4ceQyQm4//NTfNhVPpYiFDnGU+JbvObGwor4jnKHlGakOcJAaDGbdXdtZA4mzykR+k=
Authentication-Results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DB9PR03MB7196.eurprd03.prod.outlook.com (2603:10a6:10:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Thu, 6 May
 2021 14:28:18 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::40d5:3554:c709:6b1b%5]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 14:28:18 +0000
Subject: Re: [PATCH v2 2/2] pwm: Add support for Xilinx AXI Timer
To:     Michal Simek <michal.simek@xilinx.com>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20210504184925.3399934-1-sean.anderson@seco.com>
 <20210504184925.3399934-2-sean.anderson@seco.com>
 <e3782bc5-bcd9-5eb8-e89b-e4e52ed2e3cb@xilinx.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <1bfde199-617a-343c-10ed-4c436bfd908f@seco.com>
Date:   Thu, 6 May 2021 10:28:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e3782bc5-bcd9-5eb8-e89b-e4e52ed2e3cb@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.195.82.171]
X-ClientProxiedBy: MN2PR22CA0003.namprd22.prod.outlook.com
 (2603:10b6:208:238::8) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.1.65] (50.195.82.171) by MN2PR22CA0003.namprd22.prod.outlook.com (2603:10b6:208:238::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Thu, 6 May 2021 14:28:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a64e0a9-2222-413a-0906-08d9109b3107
X-MS-TrafficTypeDiagnostic: DB9PR03MB7196:
X-Microsoft-Antispam-PRVS: <DB9PR03MB71963CFEE37D85BD4F32A6B096589@DB9PR03MB7196.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N9+hZUMEutds81SEhP87DocUdSAQg5PXmRkajI+NB/ldeD07OMGbCmWeJBMaEuffenBGh9WRs7scHBEG266J+NqL3vkbuGnBvE43bgaWFXqGkEDGQQWn9X324obry3T88DzGTfQlppxuat7l1agMmY8mlBeghJHM0jZIRspKovm5sF8CHbcbYZxA3zRrZL5jzSPyi3omd+LgSaD5oYdD7Y4rRu/pRNRiIJY99sDX511OImDInOnvLOZ8L+OFAUPtJZWlFv34/RC1GZ/u+a7pSaFlKdhSGenPBDGOan4BKbq112DX/UAp2IRv4GgfGUjggicTK54/nFalhjHoOdXgRUKKXig93WdVWhaQUOjFai6m9d2LLgY0jfpGz3slmpA+l5KZ2Jwr4NBgmvXryvXXU13IcCzHA8VxrCplwmHo4sWc9WBgX+R6IiCgwgk5kkpHDOHXlyZFEjB7Kp1b+ETRSgxfHIqFnBFjxKBwe0bXoxj6gbZhq0mX1mZIFnZMvtJGVcHWEyebrhymyJTe6o4W8q8FQjIZGtxM9vqULmMjiVxp4ZeFIUI6gmJA973x0+thqgsbJqVocHv9Q8GGJZl2m/SkyVOd5LdreQZRal6C3fzetAbcathz88IL9agVKcrq6asmWyKH96NSgLtc0bmo/Qp9FIpiP6RtLnh089VDQGVcJYZeOqPRWg9zwIgx/lhhgG+eQF7zrCkV0R4zymF31cAj2CrRerkJyC/hNgAZoiwMc6UR+bsyIDGeB0XDldIwbhouTVPCzQythDXs7cb9hyLnsgAy0inc4sJ7KpjvDOc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(6486002)(966005)(2906002)(5660300002)(498600001)(66556008)(83380400001)(26005)(36756003)(186003)(44832011)(8676002)(66476007)(53546011)(16526019)(6666004)(31686004)(52116002)(66946007)(38100700002)(54906003)(956004)(16576012)(2616005)(86362001)(31696002)(8936002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dVQySlBtUi9wcURvZDlvczZ4OWY2c2VJNEtQN0FGVGh5dmx5bUFISVBnc0NV?=
 =?utf-8?B?UzNianM1czdZWGxRU25JdjNycUJIaEp6ZlRqbmNtempDeE1lU0cwdDJ5NVFL?=
 =?utf-8?B?cHJGTzRpYSsrayttY1VDMlBZMmNLK0JqZlJ2Wmt2WXNUR2lrQ2J5UFJoYlR6?=
 =?utf-8?B?cnRHTFNuakxFd3hnTHlqRkYzODZ3VWJyb21NZmhEV01MMzZWR1JpSjQ0a2lC?=
 =?utf-8?B?VHlYei9vc2FQQ21zREh4cHNBQUJHSTRPVUd6bUJuRGFjLzU0NWNtV2V0ZnM2?=
 =?utf-8?B?QmJ3cmhJN1BQVjEzeEFoMXhWMWR6VWJYQjd6eUR6ejBKVytMZE93eVZVVWwr?=
 =?utf-8?B?WGo4NXE5R0Z0LzJBNWlXcVd4N04waEVhTldpam5FSVpiK2FtUkVVM3BTcW1k?=
 =?utf-8?B?K0xvY2kvY242STN6allyRUdCd1J0bFkwTkNuN01tUmpnNy8ydDJuZUJqK01i?=
 =?utf-8?B?YTVYUUdVeTlDSExlOS9YVzVlcXZ4YUM2UkhZdVNXei9UVWt1OUJKS0kycWxF?=
 =?utf-8?B?R1h5aExsWCtaMmNucEVKdy9yWW9kN0FLdFV1UHZ1Yk9kV1FqQmxmVzA4YmJJ?=
 =?utf-8?B?T3NYcnRtdXJVaFB6MDBOaDBXVHpBZ0dPc3lNb0crR1FpVVJUVDdSQkx6QVNz?=
 =?utf-8?B?MEpsL3RTM09DZEZFaU4zdDFZMWU0Qi80S2JDbGd1TlluRUdsTmgzWkswdkJJ?=
 =?utf-8?B?VEVSdC9xSDE0aTFJOVV1ZnRBWTVhYy9YU3ZUMUtBTUFEN0dDZ3liaDBCWlZC?=
 =?utf-8?B?eUdGMjFZU1dKOW1BV0ZIQ2R1T3pseUp0Q0FzZ0RhWjdybldueVErV2VUdmtL?=
 =?utf-8?B?UmVhODk0WUpvYmtrVSt1YlRod0JYbWQrK0VldlZQZ3BGN2Mvb0JtS2JHVGdP?=
 =?utf-8?B?aGMrM1ZpcXBrR1JuUHJ0eHppdklCaTFkaWF1WU5zM01ZSUVYaHZsbVpPcTZB?=
 =?utf-8?B?V1l3UzlHVEl0dTdzcWhUZ3FMamNQczB0QnJOclBSNkgwVUwrUjJUTzlCSFVJ?=
 =?utf-8?B?S2ZSejhCVFhMS1BxVzRvZEt1ekxkM3plMWR5Z1RqWXMzODdOclpaSHBjVFlw?=
 =?utf-8?B?TlZhb2ZlNUZIeU5GdUhqMXFUOExPZTJUTzhvS2htb1ZCS1poU0VFZWgrR1JL?=
 =?utf-8?B?bXFWNWQzVXovREVXcEgreTlrb3doOWY4Zk9TcGNyejFRSzlGZjRMbENKMmhC?=
 =?utf-8?B?aW1QRUQ1UzZIM0FwaWlhWDJxOFNCSTBaZWRYYzlSRDJ2Umd6TW5QUnQ5V2tz?=
 =?utf-8?B?R2dKSWN6RnBBQ2pzSmF3SXdnZ3JNaHZrcFFhUXlkSXpTaG5LZDJpd2oyK2da?=
 =?utf-8?B?dW05ZEg5Ym1OZC9rWWxTMWMvS0dRUEZESXlWR0RMcXBZTUNPQjBQb3dhcEhh?=
 =?utf-8?B?R1lrTFVXcEtqaTNpMXVoMEExM2R1RndYaDArU2RtRHorbWkzeFVNWUNoZnVt?=
 =?utf-8?B?Nmw0dUdGMU80K3NCNlpOYnJKbXk1d09zaDdkWVFpRUVXN1B6YWVWR21yRlRr?=
 =?utf-8?B?c01ubTltWE01ZVlHRWJ0OURFU3BGZmoxNE5YaUE5cDRyQXhiUVNqR3JzMk9C?=
 =?utf-8?B?bFpDR3M3bjBWYWY3Z0lKTFFSTkhqQjNrWHp3MkZyN3lEanErOUhaNjU0UmxZ?=
 =?utf-8?B?c0dXL3ZDbTBlR0huRGllbldYbG14eXBQaS81cStNdHhLTi94dGRjdktHN3Jr?=
 =?utf-8?B?b3dYZGpjY3gza25oRDlWY1JTN216YXhsamxZSHRYbS9rREU1QnhWbTg4aW1j?=
 =?utf-8?Q?EcFQYN0i+MZD5qDJ8KYg5Sg46D0bpnMPnmV5U3c?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a64e0a9-2222-413a-0906-08d9109b3107
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 14:28:17.9405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlq+An0lTMF+tcmjl1/sSHcDuoUrgZn84P46n1nraR6O3e6Vd8zA4Q0HhkaIcu/R9VuJgCENb+e5qFZzN79zww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7196
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 5/5/21 2:37 AM, Michal Simek wrote:
 >
 >
 > On 5/4/21 8:49 PM, Sean Anderson wrote:
 >> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
 >> found on Xilinx FPGAs. There is another driver for this device located
 >> at arch/microblaze/kernel/timer.c, but it is only used for timekeeping.
 >> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
 >>
 >> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_timer/v1_03_a/axi_timer_ds764.pdf
 >>
 >> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
 >> ---
 >> I tried adding a XILINX_PWM_ prefix to all the defines, but IMO it
 >> really hurt readability. That prefix almost doubles the size the
 >> defines, and is particularly excessive in something like
 >> XILINX_PWM_TCSR_RUN_MASK.
 >>
 >> Changes in v2:
 >> - Don't compile this module by default for arm64
 >> - Add dependencies on COMMON_CLK and HAS_IOMEM
 >> - Add comment explaining why we depend on !MICROBLAZE
 >> - Add comment describing device
 >> - Rename TCSR_(SET|CLEAR) to TCSR_RUN_(SET|CLEAR)
 >> - Use NSEC_TO_SEC instead of defining our own
 >> - Use TCSR_RUN_MASK to check if the PWM is enabled, as suggested by Uwe
 >> - Cast dividends to u64 to avoid overflow
 >> - Check for over- and underflow when calculating TLR
 >> - Set xilinx_pwm_ops.owner
 >> - Don't set pwmchip.base to -1
 >> - Check range of xlnx,count-width
 >> - Ensure the clock is always running when the pwm is registered
 >> - Remove debugfs file :l
 >> - Report errors with dev_error_probe
 >>
 >>   drivers/pwm/Kconfig      |  13 ++
 >>   drivers/pwm/Makefile     |   1 +
 >>   drivers/pwm/pwm-xilinx.c | 301 +++++++++++++++++++++++++++++++++++++++
 >>   3 files changed, 315 insertions(+)
 >>   create mode 100644 drivers/pwm/pwm-xilinx.c
 >
 > Without looking below another driver which target the same IP is just
 > wrong that's why NACK from me.

Can you elaborate on this position a bit more? I don't think a rework of
the microblaze driver should hold back this one. They cannot be enabled
at the same time. I think it is OK to leave the work of making them
coexist for a future series (written by someone with microblaze hardware
to test on).

--Sean
