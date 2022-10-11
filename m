Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E39B5FBB4F
	for <lists+linux-pwm@lfdr.de>; Tue, 11 Oct 2022 21:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJKTYB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 Oct 2022 15:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJKTYA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 Oct 2022 15:24:00 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2091.outbound.protection.outlook.com [40.107.113.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5DB7B2BC;
        Tue, 11 Oct 2022 12:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWVbULdaj8qxiPr01JCBLy648hdzggy+1C+GbuZQvWFm2LmjAlPXfBDICaQY4MyhVMK70buBMlVxVtKKyXO/xOYzM2lgo47COxC4gqd4y5zpx6B4jXrbhmMVfgNQ6mIvL4yAEGJlp94XYK63gPLm474aVG4B5kI3nUboy+bzdmT6JbHbSO22CaevWD3gYDKYqS6SFG4UR9ZtJ1y5msSWFqe+ROKjE0FjdO121H4Bw+qtmYndL50H2ijdiXwe7l4G+jCCvnw947hspo/oHS+fHtHN1R1F8xJpQSjjL4hoyw4HVNz484XPEhxDSGrxmLPFHIiTFgOcc/fo4Cu4RvL0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzHPpo456K2QOGbkSFSMYbNWkn+wYzwQbfC2dMC/ZNg=;
 b=oc8Bi0S4pEHuMG6dlrvCOjUOxf1XVeVeZm0DyzigNx23kNhLn9gDMg4cZIwKrQPhn0IA32gZyfi9W5OBtxMAEFAH/rWP8dg+hIyW9XLGrUIdJ0620FZ549hrjYw3PSFO3UqTxqtF9TbEi6sESLm8AVr5TwyZp2FPtb+1COgq2Qq1wYLhrJHUX2+vP3dHwmADO3EgPrrAzSbfdR2KKk66kki1J2/4mTHUHhwfkQNrEbpKztbRGXzE/EpalIowvfTeaXORBoBe80pUGfYWVbM2gxDPXK45Mdcp8KxyVydzP6dwMN7QHpCmO/4+v02blCQ5MyNwltcE3YdE0oNJQocZ9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzHPpo456K2QOGbkSFSMYbNWkn+wYzwQbfC2dMC/ZNg=;
 b=dP3dZb4YRh04ZJEmNCqSQzgWr1fVEW1+J3znDsEMsfq7Uy7NS0t8yAiNTTSB9Z/trMjmwDQSvj4jerXn5wgxZM9StoMUuol8bW8dYLtDRavabuofL+DIkIPvJludrZExluv2G4LvnXI4C3Q+4XG5pWVI8C5YCAhi73A6IVFlkec=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYWPR01MB10080.jpnprd01.prod.outlook.com (2603:1096:400:1e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 19:23:57 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%8]) with mapi id 15.20.5709.021; Tue, 11 Oct 2022
 19:23:57 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     Lee Jones <lee@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Topic: [PATCH v4 1/4] dt-bindings: mfd: Document RZ/G2L MTU3a bindings
Thread-Index: AQHY3LfvgCpXQRSGOUCqUs4Dd5zxEq4JRt6AgAAA/2CAAESYgIAABVgg
Date:   Tue, 11 Oct 2022 19:23:56 +0000
Message-ID: <OS0PR01MB59228146DE05231586212FE886239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20221010145222.1047748-1-biju.das.jz@bp.renesas.com>
 <20221010145222.1047748-2-biju.das.jz@bp.renesas.com>
 <8d6b8f0e-d9d7-0d77-aa99-379de768fd5d@linaro.org>
 <OS0PR01MB592232C831CCA84FC302212F86239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ad2e4445-052b-d65a-bdba-5759c169aafd@linaro.org>
In-Reply-To: <ad2e4445-052b-d65a-bdba-5759c169aafd@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYWPR01MB10080:EE_
x-ms-office365-filtering-correlation-id: 4178f6be-d7bc-4516-7a53-08daabbe247c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aAfeNGyKKi7KsiHgp6JV15ss04O21QtMRwNOsfLpfdxobmiBy3F8PsoJ9z+ppvAJVHuJxgLuOIsVMAEapMpzGlHy2489jowiPykxpDbl0QC6sxZpVowL/0sk570HM2V01qYvRjkjrpcHgLT0Rr8jWZnVFk+51Fd5EXeu2Z+Ez4MR09cw3Fl+UHzlrEpSMNcXnuKTs6IvOiOXQ7NMOGFWtJ3XhXMmhM1mEZnUngFdOfIf6PFAGHDv4IJu0FSENVbIQbYIyPc9PEumXZGFo1cSLK1zI7jmzNvygaznOi5BnqAssM9AoSHi0zEPZq2JN724k/MQHHKApTfqwtcssBTvmkz0n0LuxGa48Kc8D6bpXPu/M947hYmc0/FmnhKujUOKzefAmF5FRAA9MMVT57YsOFrJffh2zWmWqCNFvokKCyrwizz7Jgm3WbMbBUWQcnDg+5Mk1E0V7eDPiFL/TKIuol/s5JkZ6DbgcyIBu1Ccr3dBs5xlV7x2By9e0hSUDu07PjhqRhRDLmEuUEaXjNkUIl2ZJXhg//aBcJbtv4XhoRGWmTXnPUD92Ye36qTk5iX7tlG2jE0e6PEsMvoAtkLjKzRdz/vXS8w0RJwiDHRPk5D4Cjzh4odrn1iE1LUg5xh2j0ivM2exs1Sf90omqigTFf61z5IYJqhyOxH33y1KN7OkAvAMs5rjIDtUPvgRDoiHmEfnjC2ZEmos0zHpvXvleaAsxCRIVktkb5b/WxtWM0O79RcmLqG84YlEbhNYA9Ow7uUUpIia6Hx5kZXh8Ai2JS2SzE2KwX/v7b/0G2llg3A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199015)(38070700005)(5660300002)(26005)(52536014)(9686003)(38100700002)(7416002)(83380400001)(8936002)(4326008)(66946007)(76116006)(8676002)(2906002)(66446008)(66476007)(66556008)(41300700001)(122000001)(64756008)(33656002)(53546011)(7696005)(6506007)(186003)(71200400001)(55016003)(478600001)(316002)(110136005)(86362001)(54906003)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d21OWkZvUVpnaDEzTDhNeGJxeVl3WFZwVkRBamx3TUxYZEJXTEVnVmY3YUNH?=
 =?utf-8?B?WTJNYm10cWY1Z0tJS3dwWTN1T2pJWjIrcFoxRFl6Y2owY0Z3aG1ZV2x0cG1v?=
 =?utf-8?B?YkhNRE9aVElFRDN5d3p3MDAxcWc2ekJvNDhqc01OQktkYjZ4Vzl0Z09WRHhR?=
 =?utf-8?B?SHdrajNXZXV6dXVqZXZJUWJCV0pTVzJ2VE11bzRWZVU1QkhhamlHcllOUW1Q?=
 =?utf-8?B?My8zT1RqMTRmdEFCS1BsQUdvaVVSeXczVUdrQ1FQVTU4VE9ITW1jSmRPSmsy?=
 =?utf-8?B?eFQ2Ynp5aldmZzdlampFaFBkZzNRemV6cHhnbVl5RlBKOTZueUxzMUZOL1ZI?=
 =?utf-8?B?czhMRnBQSjR2Q1ErTUlOV2FBUTdYeWovYWpzelgvLzNrY3laQ1BxK3dqdDQ5?=
 =?utf-8?B?WmtjTGhKQkdab0l0UVdrb1dMQjBhdDJvVFhveUlsdFlpcDFwM3UyV2tPTGZT?=
 =?utf-8?B?cVdPSGJsUFpHenpFQ2tTcEFuRUtXRVB1UzN4dkFEeVdYYzc0d0V0OXF4WXNl?=
 =?utf-8?B?VEpiQXU5OWFnVUp6b0ZFS2dPczFXNVdCRVJseHVYY0oxK1NQYzB6UWhMd3hS?=
 =?utf-8?B?NWFNZ0ZPT0U4YVZLUVdVa2s1QWl1Y2FLdDJFbjhYN0lEY3JjMy8zR1BJR2RO?=
 =?utf-8?B?eTRhWjhnNG9wMlVKVnVtTkRrNlhOWE14TTM4bHJ3V2U2K3pDMTBvbmdLdzAx?=
 =?utf-8?B?VFdkcUZ1V29HMDVmdDFFcWdrM3lBY3NKUlJqS3NFVDZ2VUc5R3Q5QndBQ0h3?=
 =?utf-8?B?Qk8rai9aN2FPOXowR2x4cHE1RCtqSmY5alhUNHhqQ0w3WnJYSWxTTkNyVU5i?=
 =?utf-8?B?MVpHckxsNWxDY0sxVUlnT21lQVo3MzlPYlJsRlpIcGJGcHd6Yys3Z2tRQWVD?=
 =?utf-8?B?aUtROTJpd0FpS0JySFlEYkRZZDNqOTRZUGdxSUFFektjNGFIV3lFVkVxMFBB?=
 =?utf-8?B?dkM4bi9QV3Z5QXFPY3QrdUVsVnd4ZUN5OE1BVU1naEl0UFgwZGFzWkJERXgw?=
 =?utf-8?B?MFBTUVF2ZnI5TE04N25WSVloMTlmZFBHOWY3TWVNNW44c3dtL2w3MmFTMWE0?=
 =?utf-8?B?ZzdPUHR0cUFIS3p3SVF5cC82OUJzRUwzVWJHZW03ZnNFL1NwU2R0RFMxbUMr?=
 =?utf-8?B?bFlmdkdGcFlTV0lMNlV1T2Z5cFllMVZIVzZmZVRCbWF6NmxpUTBweDJWaENy?=
 =?utf-8?B?UURSTXB6TkF2dytrSU81UTVEOU1qcXQwTlRxMktyRDV0eDNub0VTUWJacTVs?=
 =?utf-8?B?VlkzTGJaSXJOK2dkb3lIbmxVcm9mVlRTSTBXQmRHbjhtNHpYWjlYb1NoS2Ns?=
 =?utf-8?B?elV4Y1BnR2xyek9RL2xoR2ZBVFRKMXVvb2lvK2l2TGxjWWdJbU9tcHY2bzNG?=
 =?utf-8?B?N21DNmhHTngwT3IzUWxlZTR6dmdLN3ZWWW1TRytxNERST1N6akZuR3Q3OVhB?=
 =?utf-8?B?N2VoczlEdXpYY3BhZ3lZZXVwRVlCMFYvd3ZEKzUzRnk0TW51MlF1cEN0ektO?=
 =?utf-8?B?anB6V3JPQkZGZTJLb0M2dmR3Mm9WZyswRGpzYjFrK1o5ZUhSNnhrTFgyKzBR?=
 =?utf-8?B?Q0pEN0gyak4rQThraDNyN0NvQ2t3cEVCODJ1ODF6Z25XVFZ0dDBiMEdRQjhS?=
 =?utf-8?B?dnczZ2xvNlArRzB3bG5mTFMwNGFLc2wxTUlrdS9IcVZpaXhMQmxWZmtESUpD?=
 =?utf-8?B?M3lrTUdnOFpRWjhPZGxiWVM3UWFld2ZKZ1ZXdFIyWFVtdFFwMmM2YStvb1Jy?=
 =?utf-8?B?dlJQTG9sekVUN3FHdmVPOWxRQnhJdlgrNVM3dGRYcG96RXJieElnRFAydHNM?=
 =?utf-8?B?NUZGNlU2MTBqVy9lVjNEcElQcVZCUjNodGxJME9QL0JsOFN3TkpDbG5qM0FZ?=
 =?utf-8?B?cC9vN1pNK3QrTnpTM0plZlAyTGtrMFlRSCtDVzRuS1d5UVpEa2VLRWx3VkYw?=
 =?utf-8?B?SjNobVN5bCtZWnNyUnVLaFBBV00xQW1mOVprOFRQbW1sYWVoeC9mbjNZazZ3?=
 =?utf-8?B?WTIrcUQwcUFyZXc2dldmSmJkVDlEVGdyQlVLTG1PYnZLeEhCQjF3Q2pUbkg0?=
 =?utf-8?B?dWZ3dVNhNlVOVUFIdVRTenRoaEZWNEtLL1FLWkRJYmcyRFM5QVk4TUtzeFJy?=
 =?utf-8?B?MGpXVTdZaUxjQS9adTBVbkZHaVZIeVp1R3RVclg3b1NFK1ZuUklqOUYrL1lE?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4178f6be-d7bc-4516-7a53-08daabbe247c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2022 19:23:57.0150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6WVSt/yZPxEBjMPvUz1xIoC5Gb0Cf/3eMkctvWPI2IoOYBC7E+7RxTkm0M+Od625RQgq2axX7wchJQERHM1oYY/T2vGIN99MaxWIlyH0Hx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDEvNF0gZHQtYmluZGluZ3M6IG1mZDogRG9jdW1lbnQg
UlovRzJMIE1UVTNhDQo+IGJpbmRpbmdzDQo+IA0KPiBPbiAxMS8xMC8yMDIyIDEwOjU1LCBCaWp1
IERhcyB3cm90ZToNCj4gPg0KPiA+Pj4gIC4uLi9iaW5kaW5ncy9tZmQvcmVuZXNhcyxyei1tdHUz
LnlhbWwgICAgICAgICB8IDMwNQ0KPiA+PiArKysrKysrKysrKysrKysrKysNCj4gPj4+ICAxIGZp
bGUgY2hhbmdlZCwgMzA1IGluc2VydGlvbnMoKykNCj4gPj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQN
Cj4gPj4+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvcmVuZXNhcyxyei1t
dHUzLnlhbWwNCj4gPj4NCj4gPj4gVGhpcyBzaG91bGQgbm90IGJlIGluIE1GRC4gSnVzdCBiZWNh
dXNlIHNvbWUgZGV2aWNlIGhhcyBmZXcNCj4gZmVhdHVyZXMsDQo+ID4+IGRvZXMgbm90IG1lYW4g
aXQgc2hvdWxkIGdvIHRvIE1GRC4uLiBDaG9vc2UgZWl0aGVyIHRpbWVyIG9yIHB3bS4NCj4gPg0K
PiA+IE1GRCBpcyBmb3IgbXVsdGlmdW5jdGlvbiBkZXZpY2UuIFRoaXMgSVAgc3VwcG9ydHMgbXVs
dGlwbGUgZnVuY3Rpb25zDQo+ID4gbGlrZSB0aW1lciwgcHdtLCBjbG9jayBzb3VyY2UvZXZlbnRz
LiBUaGF0IGlzIHRoZSByZWFzb24gSSBoYXZlDQo+IGFkZGVkDQo+ID4gaGVyZS4gTUZEIGlzIGNv
cmUgd2hpY2ggcHJvdmlkZXMgcmVnaXN0ZXIgYWNjZXNzIGZvciBjbGllbnQgZGV2aWNlcy4NCj4g
Pg0KPiA+IEZvciBtZSBtb3ZpbmcgaXQgdG8gcHdtIG9yIGNvdW50ZXIgaXMgbm90IGEgYmlnIHBy
b2JsZW0uDQo+ID4gV2h5IGRvIHlvdSB0aGluayBpdCBjYW5ub3QgYmUgTUZEPw0KPiANCj4gDQo+
IEJlY2F1c2UgaXQgbWFrZXMgTUZEIGEgZHVtcCBmb3IgZXZlcnl0aGluZyB3aGVyZSBhdXRob3Ig
ZGlkIG5vdCB3YW50DQo+IHRvIHRoaW5rIGFib3V0IHJlYWwgZGV2aWNlIGFzcGVjdHMsIGJ1dCBp
bnN0ZWFkIHJlcHJlc2VudGVkIGRyaXZlcg0KPiBkZXNpZ24gKE1GRCBkcml2ZXIpLg0KDQpDb3Jl
IGRyaXZlciBpcyBNRkQsIGp1c3QgcHJvdmlkZXMgcmVzb3VyY2VzIHRvIGNoaWxkIGRldmljZXMN
CmFuZCBpcyBub3QgYXdhcmUgb2YgYW55IHJlYWwgZGV2aWNlIGFzcGVjdHMuDQoNCj4gDQo+IE1G
RHMgYXJlIHByZXR0eSBvZnRlbiBjb21iaW5pbmcgdW5yZWxhdGVkIGZlYXR1cmVzLCBlLmcuIFBN
SUNzIHdoaWNoDQo+IGhhdmUgd2FrZXVwIGFuZCBzeXN0ZW0gcG93ZXIgY29udHJvbCwgcmVndWxh
dG9yLCAzMiBrSHogY2xvY2tzLCBSVEMNCj4gYW5kIHNvbWUgVVNCIGNvbm5lY3Rvci4NCg0KSGVy
ZSBhbHNvIHNhbWUgcmlnaHQ/IHB3bSwgY291bnRlciBhbmQgY2xvY2sgYXJlIDMgdW5yZWxhdGVk
IGZlYXR1cmVzLg0KVGhhdCBpcyB0aGUgcmVhc29uIHdlIGhhdmUgc2VwYXJhdGUgc3Vic3lzdGVt
cyBmb3IgdGhlc2UgZmVhdHVyZXMuDQoNCj4gDQo+IEp1c3QgYmVjYXVzZSB5b3Ugd2lsbCBoYXZl
IGNsb2Nrc291cmNlIGRyaXZlciwgUFdNIGRyaXZlciBhbmQgdGltZXINCj4gZHJpdmVyIGRvZXMg
bm90IG1ha2UgaXQgYSBNRkQuDQoNCk1GRCBpcyBtdWx0aSBmdW5jdGlvbiBkZXZpY2UuIFNvIGFy
ZSBhcmUgeW91IGFncmVlaW5nIENsb2NrIHNvdXJjZSwgUFdNIGFuZA0KdGltZXIgYXJlIGRpZmZl
cmVudCBmdW5jdGlvbmFsaXRpZXMgb3Igbm90PyBJZiBub3QsIHdoeSBkbyB3ZSBoYXZlIDMgc3Vi
c3lzdGVtcywNCmlmIGl0IGlzIHNhbWU/DQoNCldoZXJlIGRvIGtlZXAgdGhlc2UgYmluZGluZ3Mg
YXMgdGhlcmUgaXMgb25seSBzaW5nbGUgInJ6X210dSIgYmluZGluZ3MgZm9yIHRoZXNlIDMgZGlm
ZmVyZW50IGZ1bmN0aW9uYWxpdGllcz8NCg0KcHdtIG9yIGNvdW50ZXIgb3IgbWZkPw0KDQpQbGVh
c2UgbGV0IG1lIGtub3cuDQoNCkNoZWVycywNCkJpanUNCg==
