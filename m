Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B26F52B1F8
	for <lists+linux-pwm@lfdr.de>; Wed, 18 May 2022 07:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiERFqL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 May 2022 01:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiERFqK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 May 2022 01:46:10 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2115.outbound.protection.outlook.com [40.107.113.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C39E7671;
        Tue, 17 May 2022 22:46:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO+qvwRY+xcTvv8Bg809Ey+qt+HkcjhUpfxAR1uzpvNk4SQpBWOv1JoaWHekbL1lTC1mNgQhG9cgdn5alA52yh3QenMoN2fnL0zoYnFIE2NCn845oV6y8RCmFp58FIq4sEapN8N6p2VkqygTzhJprZHkmKqzZdVZI2USbAwYxFYbQyZOS6dkOAGCZpvsh1NEtxH/7Uc8AySQUsS6Bfz3wmlWwPkiLH/zYHXzTPTq92psb8zUNDtrAoRdGaCvPJCUgZ3OqPIM+ZHGrA4IYkfvDI/xG2GSH7BlVieZTvkSFLYgRqv/AN3w1se9mUU1vpcUMn4dvloUHfNQ3d16JCcRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wqj6MxEk5A+A/PH21caynaIqmeDXNfytQ5xS/H15i4w=;
 b=Rhd4oJOYO9OF4ldNn/ulP6PyUVFtbs9XiqcYwydFl4/MtiwH4ViPMK+CbnlWzonAH3UXMhkrWvgN7JBuJMeYS459sO1RVbOX9Qd8ORdnNI+cLG5MO0xbb2nsYXXdtdsl34FNwZLOoSkP4KCPsPWhsfXBwWzeCd9uo/2o1OvhWF8LCrfE9ZfR6m+VQ6c1BwvFD+g0yv7dXJC0zxigXJXkUwW3ygJUOOrAXMvkUhAcToHcT93Vi1uJYZWegQNEFb2GDZWbmpVDx+SuCYAIn6i6xRNXAlsqa0LupKeCtqNtHb7l9J0fMh0Y9/TPqxuUIbjg8Qmw5fwilmPovKIDAwG7/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wqj6MxEk5A+A/PH21caynaIqmeDXNfytQ5xS/H15i4w=;
 b=V1OHs6Fcp8nWa6XDlw/PD792AVCQ7u+36K+ZaEqmEkwm9ebzgbY3c/L2CvG55pTTODpmhPPgDL/fdawQ9AvFyqQuqjnhttAYboiuT79JuyRMNiCu7C9EEk2C8rFZXhROZr3ZzKPUc6DyuaQoH80Vk7a8XRtKSpLnidlhGOTLuyw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB9271.jpnprd01.prod.outlook.com (2603:1096:604:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 18 May
 2022 05:46:05 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::3e:970b:c238:f57%9]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 05:46:05 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Rob Herring <robh@kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: pwm: Add RZ/G2L GPT binding
Thread-Topic: [PATCH 1/2] dt-bindings: pwm: Add RZ/G2L GPT binding
Thread-Index: AQHYZHxHqAip1AUWpkCs1CVKkDSV2a0jmZQAgACSP7A=
Date:   Wed, 18 May 2022 05:46:04 +0000
Message-ID: <OS0PR01MB5922F1D6F3DCB818E978799E86D19@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220510144259.9908-1-biju.das.jz@bp.renesas.com>
 <20220510144259.9908-2-biju.das.jz@bp.renesas.com>
 <20220517210128.GA1630873-robh@kernel.org>
In-Reply-To: <20220517210128.GA1630873-robh@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e63d8f5a-6791-4061-9de1-08da3891b2fb
x-ms-traffictypediagnostic: OS3PR01MB9271:EE_
x-microsoft-antispam-prvs: <OS3PR01MB927153BFE214167353B0EFD386D19@OS3PR01MB9271.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gB5/pvS4HyPrwl828/uYWFM+0LxHv/g67xfadVsDbVgx0oG82GYQfgOhxd0TWNkpjIBd+yp7uHbnyNHaVCjwnvcNQUyVurT210DEebZm1b1pbo1AUiWVvadTM/2PwqKYD+Qf9LbjVgjipBZtHprMOb2IDB34YSE41xNUyPSTG91iu0oBEGaZZ6dDUPYFI9/KYGq/1PFALXRB+/YD/Kv+Ijzxz+QWAJ9Kwn7RBRgpFBCxPcTAsIZia2CWDw+CXpMJnxGl3nI/1Ca+w12DlrvT7z78kp/9SXH0RJGN/+t9tiN4CI6c/ausHHVAsMFbPBvv7sc8fWMaFqbHLOFk44Tovjv4Y/mJXUBaoSMgM1P+iqlVyqA/K4yJ+MYN9OgYY7KicBr5zmKKuEViyRzP0ky2praE0ruJ9N0uoFeTS5K9hhwz/w108CuY6mJGzI8SZVyloRJXN/M+I8DUXE6q5KsUvSmBsfaF8j9vTk3+Cjpom+CuG9JNJZMJzke9kv3x7a/ZzwzfmC+AiOEfjRN2L0VLDGSAMmo1EV+qi6ZIFRiYKAyAxcrrcz69U4k6afdH8upYqmAmeAsj6qACTeJN4cBkbXFBKRhgdkQUcmcrSW1/wuRJ4i7K0O/XN7F/Hl11D+T8cL0vsVraLHuJ8PFwMQKHF3DYuxTmd5X5zVsS7ChcYIDKaXQjfZSP3qoXI6LCVhr8mahdgzh/z7DGQvXa6LDAOZUY8+vlCaP+Fj7yjH3PvneABQRw3jj7Y6iTsSPHZE8Kttpyj4J0PDueRIKpbTFYr6b/vERXI7Qkgpid7pvlI+g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(83380400001)(6506007)(7696005)(52536014)(55016003)(186003)(5660300002)(2906002)(508600001)(6916009)(38070700005)(38100700002)(86362001)(45080400002)(66946007)(8676002)(316002)(33656002)(76116006)(66556008)(4326008)(9686003)(71200400001)(122000001)(66446008)(26005)(66476007)(54906003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cDc/CJkIaXWzKbQMZh7252JCpBNaYloY7ceNMmT14e1/rKKI1CTB5T2r5g?=
 =?iso-8859-1?Q?9xHmmOt3/pJ1eZAHxfIhN1zYYxFUYO8HdPMlkDSc44jkwXWviK7ErEWXek?=
 =?iso-8859-1?Q?rC9s2QiD0JCLTQtAMkHoMH3iClwRkUSF5x+XkBIJvwhJJt/mIYQ65XREQv?=
 =?iso-8859-1?Q?9tyw5Z0SRBmFQscetDOSMCsITQ9vPZFXhA61yDQSuD7EP4lYz6KiQ5XM13?=
 =?iso-8859-1?Q?P34viRMvwmdC8fc3X/SrYozrHpAVNXRZ8PcUIEiyx+2G7L5FaN4hhOgSre?=
 =?iso-8859-1?Q?CmhObTShz0BfbA2lvhuvRxRTi4u5Yz4zSnUMH8YB6+1WFE7RKmFDDm5vkq?=
 =?iso-8859-1?Q?T8OG+8WjnAovDEtFxsoULBG0BgDNwCFf7KEyVJeb9q2vy6k0ArK4Oz+W64?=
 =?iso-8859-1?Q?YgRkqpBrDEyTgkCPqpysHHFCA7oTpfp8tYDi05y0ve8jaUHDYrtNc9dBKX?=
 =?iso-8859-1?Q?OyztrYTJxjKD2qShBthV2/Q0ZbISDiiFyFnVh+XpxbKUBXjXKWA4jdK6vB?=
 =?iso-8859-1?Q?g76I6US1EYhyfBFYU1jgLuAo7ohjd460H5LG6AncrjGgpWIi3YW3m7+0Gb?=
 =?iso-8859-1?Q?2KBDmWLiYKU32LOklgAkhAr/8rxj7E8xta5WeVvhZ8cS3s01DRVxo+MFt7?=
 =?iso-8859-1?Q?0o6mS4iawr2cIAP1mV6FtjZabh5YfGMWMhh/XpUoQwP8EyBt9ixIXXMI54?=
 =?iso-8859-1?Q?sh/kxfjz60divD+7St6PFAOrS0hrGySS1QAS6axhdTVOve3lH3CmTlbvQQ?=
 =?iso-8859-1?Q?p9Mt0dLF6O5hoEe5TVaC7IHYc2pCy0Rg2S6PgtXiHDVdzJ8aKAh+G70ucH?=
 =?iso-8859-1?Q?Gj1fF6iImevxbRtjbQN01/GsuB0cdkQhVIABSh5AmPZ3QdqiMvacfHUFFV?=
 =?iso-8859-1?Q?B1dI7MutoFJJA3dmZL4ihBm66xUkexNNKk49U46RlCnvQchMkgFvLXKTld?=
 =?iso-8859-1?Q?OHKIsRyqSXFAdXhu2CAV0aChNQTwEWqkSZCx6ae352u5yYOnItV2zXD3Nh?=
 =?iso-8859-1?Q?QPgzu9pTHZv+bWMcQ1sleJIevy4knSyylSRNziC02NkoI2BpdwdRe0raWy?=
 =?iso-8859-1?Q?7CXXEGokb4KX5uSkxn8ktx6ZQfp3Dsvgqd1Ooqv1GbDflxick/sljEEboO?=
 =?iso-8859-1?Q?IEKwJvSuz/jNAfrtoI+yvsihMsCanXhBBevTKtx/tM/+beQQcJgnj8sZ1Y?=
 =?iso-8859-1?Q?ADWgNXo7w+A1FQMQupz4SkpI8tr340hj9GGar1HtrJG7fNx37kSRQXOkY/?=
 =?iso-8859-1?Q?S99OjaIl3Sbj1d8jhc2OvwzH/Dt3QNBsDE0tOq7Y6sKW3evLGK7j5igx6E?=
 =?iso-8859-1?Q?cRglFJ8G0OXRaqEkBSxDcNvFlFjq0oDoVT7soTrlTfdcozFsYlMIapMKsV?=
 =?iso-8859-1?Q?R11aFrV8zz3PL8s/1GZ2WgD4TXH4vGXn1pZmyTtqmPdJCsZVVW14AjIIm1?=
 =?iso-8859-1?Q?ZA1+STtTaWS5i4Giyc/du6xyRvw595BAG8Tw7zlh7ckXEI3PslCWfn1ifP?=
 =?iso-8859-1?Q?JL0kFAUe4UPIQdKv6TZ4+85urFU2FoLLVYhCbxq7Yu44jwVYPss16EJ3gg?=
 =?iso-8859-1?Q?I+UuE+IpQY+FDrW3t5kNyI4uFGHOUHvC187QpqFPL5ex4T8D6yzNhrJTc4?=
 =?iso-8859-1?Q?Ouf6QFn2H59f1WFuyfrqbFKGj2Qs55hzoEYz0YRDzsfVZs1Mpt3o486qYq?=
 =?iso-8859-1?Q?mWFv/ikYv9gv5vAyUuDLmtOgr0rolrcH4DAYwnC+1uHETRgMYDo4UU8EEw?=
 =?iso-8859-1?Q?kwlFdZsKdt9+7EYyjhyVeGCnh4k3R9KXHOzTeKGv3mqSykam6eSGFREVg2?=
 =?iso-8859-1?Q?lms6AtYdpHWKMJX88Gmzs4k1s106FvE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e63d8f5a-6791-4061-9de1-08da3891b2fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 05:46:05.0281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wj0X9su9KOm//bzs6PO7ue3cAvu5aXxwXoVPzLJCmjYXwOH580IQ+rdvZ8+920DQ0XcldpEFBpQutlgsoCeRsfgy8kPS9ileTBU2d3FCaGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9271
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Rob,

Thanks for the feedback.

> Subject: Re: [PATCH 1/2] dt-bindings: pwm: Add RZ/G2L GPT binding
>=20
> On Tue, May 10, 2022 at 03:42:58PM +0100, Biju Das wrote:
> > Add device tree bindings for the General PWM Timer (GPT).
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > RFC->v1:
> >  * Added Description
> >  * Removed comments from reg and clock
> > ---
> >  .../bindings/pwm/renesas,rzg2l-gpt.yaml       | 131 ++++++++++++++++++
> >  1 file changed, 131 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > new file mode 100644
> > index 000000000000..b57c1b256a86
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/renesas,rzg2l-gpt.yaml
> > @@ -0,0 +1,131 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fschemas%2Fpwm%2Frenesas%2Crzg2l-gpt.yaml%23&amp;data=3D05=
%
> > +7C01%7Cbiju.das.jz%40bp.renesas.com%7Cbea8316e763b4d47364808da38486b7
> > +4%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637884180935020424%7CU
> > +nknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h
> > +aWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DzSq%2FFy3qEv1j2FLoM9TGJ=
i
> > +xeP1UwBw8X0V7gliyo4pM%3D&amp;reserved=3D0
> > +$schema:
> > +https://jpn01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdev=
i
> > +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=3D05%7C01%7Cbiju.das=
.
> > +jz%40bp.renesas.com%7Cbea8316e763b4d47364808da38486b74%7C53d82571da19
> > +47e49cb4625a166a4a2a%7C0%7C0%7C637884180935020424%7CUnknown%7CTWFpbGZ
> > +sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> > +3D%7C3000%7C%7C%7C&amp;sdata=3DFf2QnfKXxqYB1ebKqWwfwtX0Zw25OPbPHLeuKQY=
s
> > +Mfo%3D&amp;reserved=3D0
> > +
> > +title: Renesas RZ/G2L General PWM Timer (GPT)
> > +
> > +maintainers:
> > +  - Biju Das <biju.das.jz@bp.renesas.com>
> > +
> > +description:
> > +  RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit
> > +timer
> > +  (GPT32E). It supports the following functions
> > +  * 32 bits =D7 8 channels.
>=20
> You need a '|' after 'description:' if you want formatting preserved.
>=20
> > +  * Up-counting or down-counting (saw waves) or up/down-counting
> > +    (triangle waves) for each counter.
> > +  * Clock sources independently selectable for each channel.
> > +  * Two I/O pins per channel.
> > +  * Two output compare/input capture registers per channel.
> > +  * For the two output compare/input capture registers of each channel=
,
> > +    four registers are provided as buffer registers and are capable of
> > +    operating as comparison registers when buffering is not in use.
> > +  * In output compare operation, buffer switching can be at crests or
> > +    troughs, enabling the generation of laterally asymmetric PWM
> waveforms.
> > +  * Registers for setting up frame cycles in each channel (with
> capability
> > +    for generating interrupts at overflow or underflow)
> > +  * Generation of dead times in PWM operation.
> > +  * Synchronous starting, stopping and clearing counters for arbitrary
> > +    channels.
> > +  * Starting, stopping, clearing and up/down counters in response to
> input
> > +    level comparison.
> > +  * Starting, clearing, stopping and up/down counters in response to a
> > +    maximum of four external triggers.
> > +  * Output pin disable function by dead time error and detected
> > +    short-circuits between output pins.
> > +  * A/D converter start triggers can be generated (GPT32E0 to
> > + GPT32E3)
> > +  * Enables the noise filter for input capture and external trigger
> > +    operation.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a07g044-gpt  # RZ/G2{L,LC}
> > +          - renesas,r9a07g054-gpt  # RZ/V2L
> > +      - const: renesas,rzg2l-gpt
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#pwm-cells':
> > +    const: 2
> > +    description: |
> > +      See pwm.yaml in this directory for a description of the cells
> format.
>=20
> Drop. No need to describe common properties.

OK, will drop this in next version.

Cheers,
Biju

>=20
> > +
> > +  interrupts:
> > +    items:
> > +      - description: GTCCRA input capture/compare match
> > +      - description: GTCCRB input capture/compare
> > +      - description: GTCCRC compare match
> > +      - description: GTCCRD compare match
> > +      - description: GTCCRE compare match
> > +      - description: GTCCRF compare match
> > +      - description: GTADTRA compare match
> > +      - description: GTADTRB compare match
> > +      - description: GTCNT overflow/GTPR compare match
> > +      - description: GTCNT underflow
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: ccmpa
> > +      - const: ccmpb
> > +      - const: cmpc
> > +      - const: cmpd
> > +      - const: cmpe
> > +      - const: cmpf
> > +      - const: adtrga
> > +      - const: adtrgb
> > +      - const: ovf
> > +      - const: unf
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  resets:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-names
> > +  - clocks
> > +  - power-domains
> > +  - resets
> > +
> > +allOf:
> > +  - $ref: pwm.yaml#
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/clock/r9a07g044-cpg.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    gpt4: pwm@10048400 {
> > +        compatible =3D "renesas,r9a07g044-gpt", "renesas,rzg2l-gpt";
> > +        reg =3D <0x10048400 0xa4>;
> > +        interrupts =3D <GIC_SPI 270 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 271 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 272 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 273 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 274 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 275 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 276 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 277 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 278 IRQ_TYPE_EDGE_RISING>,
> > +                     <GIC_SPI 279 IRQ_TYPE_EDGE_RISING>;
> > +        interrupt-names =3D "ccmpa", "ccmpb", "cmpc", "cmpd",
> > +                          "cmpe", "cmpf", "adtrga", "adtrgb",
> > +                          "ovf", "unf";
> > +        clocks =3D <&cpg CPG_MOD R9A07G044_GPT_PCLK>;
> > +        power-domains =3D <&cpg>;
> > +        resets =3D <&cpg R9A07G044_GPT_RST_C>;
> > +        #pwm-cells =3D <2>;
> > +    };
> > --
> > 2.25.1
> >
> >
