Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7757846A9
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Aug 2023 18:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237533AbjHVQOe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Aug 2023 12:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjHVQOd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Aug 2023 12:14:33 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2123.outbound.protection.outlook.com [40.107.113.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2026137;
        Tue, 22 Aug 2023 09:14:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=By8oNc067MA7OYV4s6SBYxYBVv7HavhtEO2jXZNaeI0/hp0hUamLorVjSwYCHYeiG7Jdd5PuevT5Vh/bIs/73FonHNWrzAckswL4WgUN6mpaKCM7YC7+iKXQk0cfewVVUGCLAx6nd/6l2MbxJA+5+ZINrfItNHtzsyJhKT86LeAzeQtKSjz+yVhVVJpM0mT0ZpP1RdX/f7Zb0SNn1Gp7hLn4a1rXnMIeeOoLS93t/to0oqOQCF0h3adkxrTOFUkOh8VKGLHxGd/zTsBAEBQYdeQlulivLBgoGJiLdlkMaofRz/WzulZpHRUv5MIF3qbNHBaZ8R3lHSen+viARmUPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxZgMfTdJc3Jse4I5YsuN1yOU6WIGTESJtmYNUwbgMg=;
 b=cf16KOf5a4hgrhbLXXZcgNS4sIguaGGRMWLIezbYuLXKoAwJVQZwF429W/9XwXlG2gzi3rmH6OBcFRjpzKsb/s7CgU08g+9hA9/3qQ5N5XYqSxxNiGvlCP3DWckuTJca9gclfJn2kfBWohrjBRRbVSqvxwxwTi0RjSfJLbcQdyNMcLByV22h7EVx4nSd22l6mN75LPmpDM7ZCGCk3a6Mg/kDuuMwglBC37ITEE95SixACZ5hb+sSNDaz44qTq2PmnGs9MBuCZlqJ2z1drN9/XqSWqk6Q29IdKo8De5gnF2sYfgRxZ/NrdA3Ss7AVEuqAp+a3NWYSXkaxpiSy+y5nHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxZgMfTdJc3Jse4I5YsuN1yOU6WIGTESJtmYNUwbgMg=;
 b=XYXGlj3dM5ZjkKTo/S6hnvMWqAXpMZbPb5YnGVcLnRO6+KKoTRDXSo/tECuepzD1LPXCiRJ+6c5OeJ5/tkK4x/2b6H1WQh8ritgIVmyM0xfMbXjGsjbpGiICY5Z6z3/et1oELR3WRK5ma503ocIFTt9WZ/tSndseOXwQr6ZXSBI=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB8872.jpnprd01.prod.outlook.com (2603:1096:400:16f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 16:14:24 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::2168:623e:e186:4cf0%7]) with mapi id 15.20.6699.025; Tue, 22 Aug 2023
 16:14:24 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v15 0/4] Add support for RZ/G2L GPT
Thread-Topic: [PATCH v15 0/4] Add support for RZ/G2L GPT
Thread-Index: AQHZu5nRS9UEj1xjhEKw73iL/YoZtq/e00cAgBfcz4A=
Date:   Tue, 22 Aug 2023 16:14:24 +0000
Message-ID: <OS0PR01MB5922300A2784C863C4276D2E861FA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230721060840.8546-1-biju.das.jz@bp.renesas.com>
 <OS0PR01MB5922774DA08EBD836460BAC8860CA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922774DA08EBD836460BAC8860CA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB8872:EE_
x-ms-office365-filtering-correlation-id: bb549e03-e799-456f-6e77-08dba32ada12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z+9cce94A3sgh+EB3F4VH0Vv6nTa2dQGPOkHOxA5xw/ERvPnQdGLA3fVUOeKRaAbdXIWSZGs/lqIDyugqsi94NzTtBS5ALeZYCxTt4iIwnr0kClnaq7135QSGDDtQzfTU59FB+j8PGKloQoxVs+IukI1by6v1RL82aIl3xriBU4mx8glRWc1eYtaXxi17qfzrr4gC6Nzx9bUVKPWi6UHi8Vknt01agToQAu1rM1uBPXxtVapkXCGG6AzwXxyZlR0BI3ZNEM8M/nCPZ8O51EOJAZNGuNyi4KYCCy0wBcyJ5Nq1f/A1q4VvYpYgpx0ZaDz9pDNfrtn0D6/HnhXppiH2nczJu9eEj7TYXzC63J/h2XUNuq8rSjaAPThFNYkXgtbzWeV5QFy7clEpn6Wr8TdaZOEVKKo9iedDIVxHdht7x4J2ONKGtmfemf19eEdys2uQwTdqKfJJxsQLIWo2Pip79dr08x/shP/PFXm0ujp+Qqr17u+QsdQhHcMgAYvhFHolNuK3KSdDtA/h9a2fob13OJMc3XNvJE5iUM9m2XgtOwgndVHR56Kyet6ifJegX7KNAR5OTlv6SCC0CKz7fgcySQiQ+rJr+L0BUWmdG6t2IVLwafcCjLIcqMgJEtrr+1A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(186009)(1800799009)(451199024)(33656002)(86362001)(55016003)(122000001)(66946007)(316002)(66556008)(66476007)(478600001)(76116006)(110136005)(66446008)(38070700005)(38100700002)(41300700001)(966005)(54906003)(64756008)(45080400002)(9686003)(7696005)(6506007)(71200400001)(26005)(8936002)(7416002)(30864003)(8676002)(52536014)(2906002)(4326008)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gr1n8Z67Vb9qk/08Qm1s7cZErZ6gx+6Fjb07bmef6kxdsAWb/e+m7I+4SM?=
 =?iso-8859-1?Q?j7FtDPZFpYmDg3338Ae8x3ZzQQl2po/fAFDveqHyHS8TkpEw5E4J0ijWtq?=
 =?iso-8859-1?Q?3x41wRIqoJBjs+VUdqLJfAKVRr7IvHp+FG2KxmRCpogQydmZvJy92LmbQv?=
 =?iso-8859-1?Q?xgYmSwaLKrzRBdtsppC/FIl8UC4is+X+8lw//7PCXDL/iVnLyk4Nql6EKn?=
 =?iso-8859-1?Q?jwFQxah+mHpHHtsCLziykdNiW+CQv+e42qaN6ZovD7pjdpVhcrm8mkeuAP?=
 =?iso-8859-1?Q?/BUdFATnaxZISwhbtmCD3ObbD23w4BRbzYKANj93b9kL8l9h7OzBpdsHk5?=
 =?iso-8859-1?Q?qYsqo32ZssqB/eUgoTpXCGjpSQdaB6qsx5sQVh18i0hp2duUgPHoMm/QvQ?=
 =?iso-8859-1?Q?SWnVyGSlqPzialmyR362iALGg/MVqU1IpRdnionsORaJJ0CjDIu0bYqKq7?=
 =?iso-8859-1?Q?QLL8qKJaWddfBIIZH+C9fiZt/d19xDQPIBqkxmEROn33mM7vLNNwqZURM9?=
 =?iso-8859-1?Q?9pu+oO4C7XoE7m8ggG/Tc8SVydfLApyF7C1KqUj+vGIpu3uH5Z5o5kFhFn?=
 =?iso-8859-1?Q?eBVJiYQ3fSqZCUMqGU4n+tqeqGGKOCKPp1KHvnsHTwT3ybPDe8CnPaiTDX?=
 =?iso-8859-1?Q?I8+44CH4xA3/L3nW5kyLjjlAV0rhJ9daJZ1Egf637r6eiK78s8rnixwxdf?=
 =?iso-8859-1?Q?eLzK9POlEIN8cHDDOGZD+mCdO3nio2rRlnXPgzqFLHKGJBNrxbfk2/Vbzf?=
 =?iso-8859-1?Q?zKp4ZH2qLJWRBNcWdeJvnZW2H5+3kWGmmVOQw/N+BXZT7GFjnHvTPwUEWY?=
 =?iso-8859-1?Q?V+GDuv1XxGp6KUOtznGlQTB7BR00iRaqhN2EN8UIsT9G+clGrcQSLfP+MY?=
 =?iso-8859-1?Q?0BIryIvynBEP9B32FewmZ2MknUs/6b5baeHXt0BLErKQYD4u8F7lM4ytQN?=
 =?iso-8859-1?Q?DQOFPHsQZlHjhNrQk+U8Z/i5L9Ss0p2hOel2BhFBPaGvvnMOGv9uMrJiKQ?=
 =?iso-8859-1?Q?mExohMF/YYCoAxjH+EaYWC6uKzW6xSpMZyiihUC3Tx0LiohdXrCwovyVoM?=
 =?iso-8859-1?Q?4GKM3tQSWSqauxhWKqy0BQmD7xMC5Z8narXRSlbTo61aWnG3l+Qg4KeqFh?=
 =?iso-8859-1?Q?rNK2VbMSOruwJ9XX8rIxTSGzFVescVbTA8Guzh/Wo/363CTwTkvjFzeY41?=
 =?iso-8859-1?Q?K1JENatN6WFyXF2gic6mUbhROuWJ5La99qTC1B2Vpv+x1S13Ukwx0xeNBw?=
 =?iso-8859-1?Q?3rdn2OnlEDppcai7g2iHI1laYqEkYuDsDNBOXADF+vzKDnjz7J2LiaFuir?=
 =?iso-8859-1?Q?qeOJu7qtJYBUIkC61tNZDf7C7vtHGev+kdUuhu09IAg1a233NqqZicFpNx?=
 =?iso-8859-1?Q?DEohSpuN158urpgbKr5mlPlqrJaaIDP2Qpy6fWFLSNYDDza+i9ukr1wNVq?=
 =?iso-8859-1?Q?ZypNqZ0wSDmljE6uV0hmZDDMxqFGpdY3t4T1+KhrLSJYDX3IiZXdBKifAo?=
 =?iso-8859-1?Q?7MZaNVBalfHJk75MXDN93lk+Cs03PijFo0BP5YZ4VOOrPlpLOiWOUIwD1k?=
 =?iso-8859-1?Q?NOi6IBTG/RGBAM9I7ML1ypFbBy3y66t2nN/2mmecyv3DnDn48aitegCRET?=
 =?iso-8859-1?Q?TqKpQS63N5C4n0VlLOV3OsYLgJGtB702ae3WGTZ0DaKwZaS+NFtUp5mQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb549e03-e799-456f-6e77-08dba32ada12
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2023 16:14:24.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H3gnYpf4T+v4mmCXWkdUo9gJhxHV9l1ITiXsN4+xZLybEAMkA4UusD3byEYSd+uUh2YOYsZaa1CGGoU+pXruHq8PRnHE1LZyfmyvE+CnYkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8872
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Gentle ping.

Cheers,
Biju

> Subject: RE: [PATCH v15 0/4] Add support for RZ/G2L GPT
>=20
> Hi Uwe,
>=20
> Gentle ping.
>=20
> Cheers,
> Biju
>=20
> > Subject: [PATCH v15 0/4] Add support for RZ/G2L GPT
> >
> > RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit
> > timer (GPT32E). It supports the following functions
> >  * 32 bits =D7 8 channels
> >  * Up-counting or down-counting (saw waves) or up/down-counting
> >    (triangle waves) for each counter.
> >  * Clock sources independently selectable for each channel
> >  * Two I/O pins per channel
> >  * Two output compare/input capture registers per channel
> >  * For the two output compare/input capture registers of each channel,
> >    four registers are provided as buffer registers and are capable of
> >    operating as comparison registers when buffering is not in use.
> >  * In output compare operation, buffer switching can be at crests or
> >    troughs, enabling the generation of laterally asymmetric PWM
> waveforms.
> >  * Registers for setting up frame cycles in each channel (with capabili=
ty
> >    for generating interrupts at overflow or underflow)
> >  * Generation of dead times in PWM operation
> >  * Synchronous starting, stopping and clearing counters for arbitrary
> >    channels
> >  * Starting, stopping, clearing and up/down counters in response to inp=
ut
> >    level comparison
> >  * Starting, clearing, stopping and up/down counters in response to a
> >    maximum of four external triggers
> >  * Output pin disable function by dead time error and detected
> >    short-circuits between output pins
> >  * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
> >  * Enables the noise filter for input capture and external trigger
> >    operation
> >
> > This patch series aims to add basic pwm support for RZ/G2L GPT driver
> > by creating separate logical channels for each IOs.
> >
> > v14->v15:
> > * Added enable_count and ch_en_bits variables to struct rzg2l_gpt_chip
> >   based on feedback for pwm_mtu3 driver.
> > * Updated copyright header and commit description by replacing "This
> patch
> >   adds"-> "Add"
> > * Replaced macro RZG2L_GET_CH_INDEX->RZG2L_GET_CH and replaced
> > ch_index-
> > >ch
> >   throughout
> > * rzg2l_gpt_{enable,disable}() enables/disables PWM based on the
> >   enable_count.
> > * Replaced pm_runtime_get_sync->pm_runtime_resume_and_get and propogate=
d
> >   the error in rzg2l_gpt_get_state() and rzg2l_gpt_config()
> > * Reduced variable scope in rzg2l_gpt_get_state() by moving most of
> > variables
> >   inside the if statement.
> > * Updated rzg2l_gpt_get_state() by moving duty > period check
> >   inside the top if block.
> > * Added helper functions rzg2l_gpt_calculate_pv_or_dc()to simplify
> config.
> >   Also Improved the logic in rzg2l_gpt_calculate_pv_or_dc() by using
> >   min(period_or_duty_cycle >> (2 * prescale), (u64)U32_MAX);
> > * Updated rzg2l_gpt_get_state() by moving duty > period check
> >   inside the top if block.
> > * Simplified rzg2l_gpt_config() for updating registers
> > * Dropped pm_runtime_get_sync() and used bitmap variable "ch_en_bits"
> >   to make balanced PM usage count in rzg2l_gpt_reset_assert_pm_disable(=
)
> >   For case were unbind is called before apply where pwm is enabled by
> >   bootloader.
> > * Added error check for clk_rate_exclusive_get() and clk_get_rate() in
> >   probe().
> > * Dropped prescale from struct rzg2l_gpt_chip.
> > * Replaced of_match_ptr(rzg2l_gpt_of_table)->rzg2l_gpt_of_table in stru=
ct
> >   rzg2l_gpt_driver
> > * Updated commit description of patch#4 by replacing "This patch add"->
> >   "Add".
> > v13->v14:
> > * Moved the patch from series[1] to here.
> >  [1]
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .ker
> > nel.org%2Flinux-renesas-soc%2F20221215205843.4074504-1-
> > biju.das.jz%40bp.renesas.com%2FT%2F%23t&data=3D05%7C01%7Cbiju.das.jz%40=
b
> > p.re
> > nesas.com%7C5e49c1dce57a4fb65f8008db89b0f2bc%7C53d82571da1947e49cb4625
> > a166
> > a4a2a%7C0%7C0%7C638255165297945656%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> > wLjA
> > wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sd
> > ata=3D
> > zS%2FQnDta9svTRgCKwNQzxIZnK7ie8QOQufDZ6K18hc0%3D&reserved=3D0
> >  * Add Rb tag from Rob for patch#2
> >  * Removed parenthesis for RZG2L_MAX_HW_CHANNELS and
> > RZG2L_CHANNELS_PER_IO
> >  * Removed duty_cycle variable from struct rzg2l_gpt_chip and added
> > comment
> >    for cache for prescale variable.
> >  * Fixed a bug in rzg2l_gpt_cntr_need_stop().
> >  * Reordered rzg2l_gpt_config() just above apply()
> >  * Replaced pwm_is_enabled()->pwm->state.enabled in config
> >  * Replaced pm_runtime_resume_and_get with unconditional
> > pm_runtime_get_sync()
> >    in config().
> >  * Restored duty_cycle > period check in rzg2l_gpt_get_state().
> >  * Added error check for clk_prepare_enable() in probe() and
> > propagating error
> >    to the caller for pm_runtime_resume()
> >  * clk_get_rate() is called after enabling the clock and
> > clk_rate_exclusive_get()
> >  * Simplified rzg2l_gpt_probe() by removing bitmap variables.
> >  * Added pm_runtime_idle() to suspend the device during probe.
> >  * Moved overflow condition check from config->probe().
> >  * Simplified rzg2l_gpt_reset_assert_pm_disable().
> >  * Removed the parenthesis for RZG2L_MAX_POEG_GROUPS.
> >  * Renamed rzg2l_gpt_parse_properties()->rzg2l_gpt_poeg_init() as it
> > not only parse
> >    the properties but also implements the needed register writes.
> >  * Added acomment here about the purpose of the function
> > rzg2l_gpt_poeg_init()
> >  * Removed magic numbers from rzg2l_gpt_poeg_init()
> >  * Fixed resource leak in rzg2l_gpt_poeg_init().
> > v12->v13:
> >  * Added test logs in [1] below
> >  * Replaced Kconfig dependency from ARCH_RENESAS->ARCH_RZG2L
> >  * Sorted #include <linux/limits.h> alphabetically
> >  * Added a comment for mutex_lock to fix check patch warning
> >  * Replaced data type of duty_cycle from unsigned int->u32 as
> >    the maximum value stored is U32_MAX.
> >  * Improved rzg2l_gpt_config() by removing unwanted duty_cycle related
> > code.
> >  * Improved rzg2l_gpt_get_state() by setting "val =3D rzg2l_gpt-
> > >duty_cycle[pwm->hwpwm];",
> >    and factor "tmp =3D NSEC_PER_SEC * (u64)val;" out of the if-statemen=
t.
> >  * Started using DEFINE_RUNTIME_DEV_PM_OPS(), and dropped __maybe_unuse=
d
> >    from the callbacks.
> > v11->v12:
> >  * Added return code for get_state()
> >  * Cache duty cycle/prescale as the driver cannot read the current duty
> >    cycle/prescale from the hardware if the hardware is disabled. Cache
> the
> >    last programmed duty cycle/prescale value to return in that case.
> >  * Updated rzg2l_gpt_enable to enable the clocks.
> >  * Updated rzg2l_gpt_disable to disable the clocks.
> >  * Updated rzg2l_gpt_config() to cache duty cucle/prescale value
> >  * Updated rzg2l_gpt_get_state to use cached value of duty
> > cycle/prescale,If the PWM
> >    is disabled.
> >  * Simplified rzg2l_gpt_apply()
> >  * Added comments in rzg2l_gpt_reset_assert_pm_disable()
> > v10->v11:
> >  * Used bitmap_zero for initializing bitmap varable.
> >  * Fixed clock imbalance during remove for the case bootloader turning
> >    on PWM and module unload is called just after the boot.
> >  * Fixed over flow condition in get_state() for a prescale value of 2
> > & more.
> >  * Improved rzg2l_gpt_cntr_need_stop() based on prescale as it is the
> >    only runtime variable.
> >  * Added array for Cache variables state_period and prescale
> >  * Probe caches the prescale value set by the bootloader.
> >  * Updated rzg2l_gpt_config() to make use of array variables.
> > v9->v10:
> >  * Updated the example gpt4: pwm@10048400-> gpt: pwm@10048000
> >  * Keep Rb tag from Rob as the above change is trivial one.
> >  * Updated the error handling in probe(), clk_disable_unprepare called
> >    on the error path.
> >  * Removed ch_en array and started using bitmask instead.
> > v8->v9:
> >  * Added Rb tag from Rob.
> >  * deassert after devm_clk_get() to avoid reset stays deasserted,in cas=
e
> >    clk_get() fails.
> >  * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
> >  * Updated error handling in probe()
> > v7->v8:
> >  * Removed Rb tags from Rob and Geert as it modelled as single GPT
> >    device handling multiple channels.
> >  * Updated description
> >  * Updated interrupts and interrupt-names properties
> >  * Updated binding example
> >  * Modelled as single PWM device handling multiple channels
> >  * Replaced shared reset->devm_reset_control_get_exclusive()
> >  * Added PM runtime callbacks
> >  * Updated PM handling and removed "pwm_enabled_by_bootloader"
> > variable
> >  * Replaced iowrite32->writel and ioread32->readl
> >  * Updated prescale calculation
> >  * Introduced rzg2l_gpt_is_ch_enabled for checking enable status on bot=
h
> >    IO's
> >  * Moved enable/disable output pins from config->enable/disable.
> >  * Added rzg2l_gpt_cntr_need_stop() for caching prescalar/mode values.
> > v6->v7:
> >  * Added the comment for cacheing rzg2l_gpt->state_period.
> >  * Fixed boundary values for pv and dc.
> >  * Added comment for modifying mode, prescaler, timer counter and
> > buffer enable
> >    registers.
> >  * Fixed buffer overflow in get_state()
> >  * Removed unnecessary assignment of state->period value in get_state()=
.
> >  * Fixed state->duty_cycle value in get_state().
> >  * Added a limitation for disabling the channels, when both channels
> > used
> > v5->v6:
> >  * Updated macros RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH and
> >    RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH with computation
> >    involving FIELD_PREP macro.
> >  * Removed struct rzg2l_gpt_phase and started using RZG2L_GTCCR macro
> >    for duty_offset.
> >  * replaced misnomer real_period->state_period.
> >  * Added handling for values >=3D (1024 << 32) for both period
> >    and duty cycle.
> >  * Added comments for pwm {en,dis}abled by bootloader during probe.
> > v4->v5:
> >  * Added Hardware manual details
> >  * Replaced the comment GTCNT->Counter
> >  * Removed the macros RZG2L_GPT_IO_PER_CHANNEL and chip.npwm directly
> >    used in probe.
> >  * Removed the unsed macro RZG2L_GTPR_MAX_VALUE
> >  * Added driver prefix for the type name and the variable.
> >  * Initialization of per_channel data moved from request->probe.
> >  * Updated clr parameter for rzg2l_gpt_modify for Start count.
> >  * Started using mutex and usage_count for handling shared
> >    period and prescalar for the 2 channels.
> >  * Updated the comment cycle->period.
> >  * Removed clk_disable from rzg2l_gpt_reset_assert_pm_disable()
> >  * Replaced pc->rzg2l_gpt.
> >  * Updated prescale calculation.
> >  * Moved pm_runtime_{get_sync,put} from
> > {request,free}->{enable,disable}
> >  * Removed platform_set_drvdata as it is unused
> >  * Removed the variable pwm_enabled_by_bootloader
> >  * Added dev_err_probe in various probe error path.
> >  * Added an error message, if devm_pwmchip_add fails.
> > v3->v4:
> >  * Changed the local variable type i from u16->u8 and prescaled_period_
> >    cycles from u64->u32 in calculate_prescale().
> >  * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div()
> >  * Dropped the comma after the sentinel.
> >  * Add a variable to track pwm enabled by bootloader and added comments
> >    in probe().
> >  * Removed unnecessary rzg2l_gpt_reset_assert_pm_disable() from probe.
> >  * Replaced devm_clk_get()->devm_clk_get_prepared()
> >  * Removed devm_clk_get_optional_enabled()
> > v2->v3:
> >  * Added Rb tag from Rob for the bindings.
> >  * Updated limitation section
> >  * Added prefix "RZG2L_" for all macros
> >  * Modified prescale calculation
> >  * Removed pwm_set_chip_data
> >  * Updated comment related to modifying Mode and Prescaler
> >  * Updated setting of prescale value in rzg2l_gpt_config()
> >  * Removed else branch from rzg2l_gpt_get_state()
> >  * removed the err label from rzg2l_gpt_apply()
> >  * Added devm_clk_get_optional_enabled() to retain clk on status,
> >    in case bootloader turns on the clk of pwm.
> >  * Replaced devm_reset_control_get_exclusive-
> > >devm_reset_control_get_shared
> >    as single reset shared between 8 channels.
> > v1->v2:
> >  * Added '|' after 'description:' to preserve formatting.
> >  * Removed description for pwm_cells as it is common property.
> >  * Changed the reg size in example from 0xa4->0x100
> >  * Added Rb tag from Geert for bindings.
> >  * Added Limitations section
> >  * dropped "_MASK" from the define names.
> >  * used named initializer for struct phase
> >  * Added gpt_pwm_device into a flexible array member in rzg2l_gpt_chip
> >  * Revised the logic for prescale
> >  * Added .get_state callback
> >  * Improved error handling in rzg2l_gpt_apply
> >  * Removed .remove callback
> >  * Tested the driver with PWM_DEBUG enabled.
> >
> > RFC->v1:
> >  * Added Description in binding patch
> >  * Removed comments from reg and clock
> >  * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
> >  * Added rzg2l_gpt_read() and updated macros
> >  * Removed dtsi patches, will send it separately
> >
> > RFC:
> >  *
> > https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .ker
> > nel.org%2Flinux-renesas-soc%2F20220430075915.5036-1-
> > biju.das.jz%40bp.renesas.com%2FT%2F%23t&data=3D05%7C01%7Cbiju.das.jz%40=
b
> > p.re
> > nesas.com%7C5e49c1dce57a4fb65f8008db89b0f2bc%7C53d82571da1947e49cb4625
> > a166
> > a4a2a%7C0%7C0%7C638255165297945656%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> > wLjA
> > wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sd
> > ata=3D
> > 8Z2uXHblS94d1zundM01wgdT3pmasWhLuMlmPrSZAAQ%3D&reserved=3D0
> >
> > Biju Das (4):
> >   dt-bindings: pwm: Add RZ/G2L GPT binding
> >   dt-bindings: pwm: rzg2l-gpt: Document renesas,poegs property
> >   pwm: Add support for RZ/G2L GPT
> >   pwm: rzg2l-gpt: Add support for gpt linking with poeg
> >
> >  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 401 +++++++++++
> >  drivers/pwm/Kconfig                           |  11 +
> >  drivers/pwm/Makefile                          |   1 +
> >  drivers/pwm/pwm-rzg2l-gpt.c                   | 640 ++++++++++++++++++
> >  4 files changed, 1053 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/renesas,rzg2l-
> > gpt.yaml
> >  create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c
> >
> >
> > base-commit: 92554cdd428fce212d2a71a06939e7cab90f7c77
> > --
> > 2.25.1

