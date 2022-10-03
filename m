Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822515F2CD1
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Oct 2022 11:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiJCJIW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Oct 2022 05:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiJCJHq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 3 Oct 2022 05:07:46 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2120.outbound.protection.outlook.com [40.107.113.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54091657B;
        Mon,  3 Oct 2022 02:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNDKsAORtgRzDelx80G7TyAKzloLgGflr8QDqS8aJZSN3gsh+h8Ad1Cbww4OnPM0X9zZspSVMFIHkf3PLTCT0iaWZI7Jsc33zw4ts191YAoMBITxmk0zuFDFlx+5YemgZecDtKRD566zM7eAjetDi358jv9pxy389zxdfKw0x0eAZ+cF1hIzvQwNMPnG2aNzNocmtV7AvjzHyt1gFPRvlkTUnCNECheWJQGfYcfcMsAEp+qsyQQkhfo/ao41iKjwikEdOnwzGyOkae9XGuRmmK5gVYwPghT0aTbqYsVECZccq6Pu1ScrQQjKaaiXGkZ7f9xRSUgQNb2X9No+R/F+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cxejSIcs1+tI0iKX1wQi98ZbVYR/GgfLWyBpq9sWRM=;
 b=jXem3/9T672WrhKLcqOIdzH989SAox0uIwX9FzbZZ1jno7EsSMBjZWUt2WgbXIElKSoCMDZwpdRdJ0X8//0afRpxN0xg8gaFcps9C0lHM1RI3qhVJSsYFjE/cJoSPlfa+seCDZxHdtRmdYpyQg6KoIJhI2bcYnRAhkZbuJKvKGZ1BSgLxdUBfHNDDhDfPVTEDAdl4QZwGtFjt6yS0iNr6RHGxpDEQOAnK9HdLwLtgGgf9hZd9nUao+qr/QbylYWBG3OWVanA6ftV21CnMFWebA254QBlN0ufb2QLj9sSjs0c7eY0n45rgu2azMeAv2AAI/HN3R+sdBpVQYIA08q5Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cxejSIcs1+tI0iKX1wQi98ZbVYR/GgfLWyBpq9sWRM=;
 b=uVVHKWdN92ZYnvT7l8+XWN25FU/xr+nTAam51iK3ekcKooX77tsyLRh/CmdHj3+A+mTj8nOjomC3+3cUl3BxV8XPHxyYUVlrw52KvHF9nJIgun2DIA9QWZ+vGzzYRQvH+exgwyyJLSU1rBflKPJ92y2ghEqVh8dw/caYoMC4Wdw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB5758.jpnprd01.prod.outlook.com (2603:1096:400:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Mon, 3 Oct
 2022 09:04:36 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.028; Mon, 3 Oct 2022
 09:04:36 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document RZ/G2L MTU3
 PWM
Thread-Topic: [PATCH RFC 3/7] dt-bindings: mfd: rz-mtu3: Document RZ/G2L MTU3
 PWM
Thread-Index: AQHY0+6TADmAt9m0c0u1ieTfUadBoq32sJKAgAABH3CAATHPgIACC6NggAJdkoCAAAsx0IAADI+AgAAATiA=
Date:   Mon, 3 Oct 2022 09:04:36 +0000
Message-ID: <OS0PR01MB59222A065B460F2B72634577865B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
 <20220929103043.1228235-4-biju.das.jz@bp.renesas.com>
 <YzXbU69imBM5aKwn@google.com>
 <OS0PR01MB5922134DC72EE29D5404867B86579@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzbcyxY839GlR71V@google.com>
 <OS0PR01MB592241115B5D0F17B8CAE9D086599@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <YzqQC3gEzGksqYzk@google.com>
 <OS0PR01MB5922630991BABA41FAE06BBE865B9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <Yzqj9/1TVEB1BZcL@google.com>
In-Reply-To: <Yzqj9/1TVEB1BZcL@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB5758:EE_
x-ms-office365-filtering-correlation-id: aebae7d4-3f6f-4ed6-6402-08daa51e4b8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KXpcUf89mkJYaSK9w4O2d/51vzNY3S5rJ1towGjIO8co42GdhwWU9T2zb4WR4GZF0BiOiPycclpQmsxZJ/W8PsPzKwGDNo5PEVSZrIljya6nZON6qnbCd8QPKtE6FCFyByaLj9ljkvmTzl7sD9mgORoi3Xzt9c1YhG/YcUlSDp3S2nkohcJ2UHBXCQ05TrqpeiztWfKz9d45WDh6MS95z1w8EXgNiiStuztlJhvW1vtxZlA9IzAzGPB/LMkQ+uGZ+19c8ZeawxQf166e1/XoKMeUQyFUePj45cOqxZkMNNnQ+txUldo2YVAj2GR4mX4UEh57RLD8tKnL52s776mAW0gEmTSkUoIVosFQC+JvTHJmiCXfMvrdbUQQA+MFtvLlDrgOCsGsjykYg1q2dBlFuljuL6T9lP6qIi6/0o2OykVYQKUrWpD8WlUcnLyt+r5/p6Jh63z032IxJ6pG5VswSF17frv7f7iYiITBmXyl4AnM1mxunmDGyMjyLvuaQXesjbfvOU3EW+5dU3AY6EbtcjOfkYKkituOkj6IkmCj7O5W/AvB0dRxd1U1TszAQ4fgyf4jvEXIySUWOhOIbg8HgMV0tY03gZ45d6WuK8QDrHhTMn+y4xY7O+Yq4UtogdJljtbRfT5HhtyVrOlU4BB/5xBdOnKSKZJTuKiX39KklBTrNqMMsO6ixDTXgsyjpgMEnYhN9MoipCoIi5csJrNr0mYLNuV4EA1vclnTMOzz9cqTC8qKkvrSPA+gi6+ocvk5SDWWozDN1Qb1NzMebGQdBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(451199015)(6506007)(186003)(316002)(33656002)(5660300002)(83380400001)(2906002)(26005)(66446008)(4326008)(66476007)(9686003)(64756008)(66946007)(76116006)(41300700001)(8676002)(66556008)(52536014)(8936002)(38070700005)(38100700002)(71200400001)(7696005)(122000001)(55016003)(54906003)(86362001)(6916009)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R0xob1NyQUFPcHJLQ1ZoNk96VEtuV0hCNXVNZ2V4RTljVlFzVE9pZFpneVJU?=
 =?utf-8?B?R0txYWZsOTRCak1qdS9Ecnl4MjVqV1NVbjRwY2VjT0JLdVNTa1dMWWNsT013?=
 =?utf-8?B?dE5OL0c0bVhSSForSkxGbWVWUWU3YXlieFlMZzVqRHdqS3VYekhrNTUxZ1Zn?=
 =?utf-8?B?UmN6cHpoLzVLVUhOdkZlcWZUWktCbU4zZ0xWcmhDMG9TallCOGhhV0hSR3dH?=
 =?utf-8?B?M0N0T29kTi9pNExVOXMxMnhaNUdTNjNZT0ZTNE9OTlV6eVZPMnFQUFJ1clZo?=
 =?utf-8?B?dTFmSFVJZkxMbC9SbE14clVjdSsvZVRsSjhBYWwrWGxUNnpGV2Q2ZnJOQUQz?=
 =?utf-8?B?VW9UbDJCalh1TUZnanNFWC82MmtYQnptM05LZ3dKSzlmbEg1MWZqNjR1RHEz?=
 =?utf-8?B?eEowZUVUMDljSS9pZVJpNCtqTDQrUzdlelJUclQ3UDFBVlhENW9jU2RjTWhz?=
 =?utf-8?B?MHQ3TXd3VzRKVUlRSjJ1VGxtTzl1b0Z0SGVaRjd1MDNuY0NLOG42RDdsY3lX?=
 =?utf-8?B?MHVqRlJNMGJCcnFCWGZ1VUpPN2VrbjlkUUR4WGFwMTFVaTFKTlBoWGErdDhw?=
 =?utf-8?B?RDRYYXRhTHBlMldCeGZxZ1VrZHY3QW9rcjFiaTFySDV3TFFmSWN3SC8wdVc1?=
 =?utf-8?B?WjZhQmllL21zdHpDaWo5RWltOWJpaTRCVjZ3eHZaQ1hISURtaUlETXA5MWNL?=
 =?utf-8?B?RXU1MlNONEt4Tm9GOGlWaXRjMTlKVEdlYWpFckY4U0U4TFo4OXBMQXQybGVs?=
 =?utf-8?B?V3NBZWpuYTl5TUxjaDlVNDNmZU96VGVJdUdDcXd4YjNneU9BYVljZk5icmlH?=
 =?utf-8?B?dE16cWdBSk1neFE2MDlZU0ZJTDVLMVd1U091MVcvVTh4TE15ZGlWM2pwTnFZ?=
 =?utf-8?B?SFgwQlBac1gwWjE1bE56ZjNTOTBiRWVueEpBaVlVOXIzSUhvWitIVEZ3U3lz?=
 =?utf-8?B?bzZNOTBnVXRMb29LUVkzL2taeVh6NHNnSCtPYTV6ZDVJNmFJQ1RNbjMxZFFh?=
 =?utf-8?B?aDZNUUpzT1g2U1FYZWwzdEk5SkgxcmViVS9UM2hvOHFEbHRQcG4zck4wMzNH?=
 =?utf-8?B?SEc5VXgxaFZQcjBtVHZBM24xV2p0RWZpMGpxTXl0TVh6OHk0aCt6eG1SWTBT?=
 =?utf-8?B?WlpCZExvd2JCL3ZHY1RZMVhZZStTZlBFeU9naE1DbXpERXZNNkR5Ymh6VXZ0?=
 =?utf-8?B?b1IwTU5PMXJlVU5jRHh1blRmdEdBVG1NcXlOdjBKY3JsbEg3bE9jZjgzeUIz?=
 =?utf-8?B?WWdQVERrTzh0R3c2MXMyc0lsZFAxdGJ2WUk1Y1UzV29ueURPL1hPTHlHNGNZ?=
 =?utf-8?B?aXR3SXBieTMxd2JCL0ZWdWVRQWd2L0VPZUtjWXg5ektjdVhzMUZDOGluR2pO?=
 =?utf-8?B?bm5BR281Y2tyMkphcXhCekxBVFlRa1BGRjhic3FzbzZ1V1lDSC9pNDZwdkRp?=
 =?utf-8?B?NHdMZVhQTzA5dVQ3RU9hSVlxL3hjVlRTQkdaVXM0VVpxZ0grWXF0NmVsdjFU?=
 =?utf-8?B?bENmVzRrQldFUnBteHhVdWQzV0gxVVo1dVdXVVZic0tycW93ZUhCYUI0T3FW?=
 =?utf-8?B?d2pFY2U2VUlycHRmTUs3NFdzRUF0UjBVZ2w2d09oWThjc1NwNFl0MVNJRHlE?=
 =?utf-8?B?bElZbEJqLzVNOS8waGM4MVQycGxaYUcwbzFPUU5Ccjg4K3hDb2ZUME0yQlN6?=
 =?utf-8?B?RnAydTM5U3dITktEcjBqUmQxR0lUSitZWVc4MWZJOU51djJtaDZuUHVQY3V3?=
 =?utf-8?B?c1djT0tQUm1lUEtEUVNJc01PSGFUK1FTdGw1WEQzUnlUVFZtUUxEN2ltRm1r?=
 =?utf-8?B?eU5QYzQxcWxpb1U4ZDZzT2tpUExiRnV2Mm0yS1h2RnhEeGZicGhsbXRieUdE?=
 =?utf-8?B?WDBjU0xuMUtuZFVyWjZUT1BiN1h2VUc2b0tib044Y3FQYlprM0xYaVBFUzFy?=
 =?utf-8?B?cFFSYk5sRGIwY3Nmc0RIclBFRTljS1NwOGc1OVp6bWlXaFpMTXF4WU5tQWtP?=
 =?utf-8?B?MUdZWFkzcWZPelNVdWt4MUVPZ1UybHVqMFFuelJNM2NVSXN6ZjFaK015SCtS?=
 =?utf-8?B?SG5LQTJ3VlY3T2hwd21YUUFkWmJiV2JlNU50eTFsNVY1THFnVnZIRHh1SHJp?=
 =?utf-8?Q?WdmSqY6uFeByYPMDqhN/n9vqN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebae7d4-3f6f-4ed6-6402-08daa51e4b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 09:04:36.0814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9o2C2br+LGQpXFwLIPFsXOBUDZSuKVLXyJhbAhfmeOrFN5X12vdtv2KxXyQ9WN6At/kP24UKNWT5SNA3e3bxyzvLd1OeYAKj8y7U6t6caCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5758
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgTGVlLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggUkZDIDMvN10gZHQtYmluZGluZ3M6IG1m
ZDogcnotbXR1MzogRG9jdW1lbnQNCj4gUlovRzJMIE1UVTMgUFdNDQo+IA0KPiBPbiBNb24sIDAz
IE9jdCAyMDIyLCBCaWp1IERhcyB3cm90ZToNCj4gDQo+ID4gSGkgTGVlLA0KPiA+DQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIFJGQyAzLzddIGR0LWJpbmRpbmdzOiBtZmQ6IHJ6LW10dTM6IERv
Y3VtZW50DQo+ID4gPiBSWi9HMkwgTVRVMyBQV00NCj4gPiA+DQo+ID4gPiBPbiBTYXQsIDAxIE9j
dCAyMDIyLCBCaWp1IERhcyB3cm90ZToNCj4gPiA+DQo+ID4gPiA+IEhpIExlZSBKb25lcywNCj4g
PiA+ID4NCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFJGQyAzLzddIGR0LWJpbmRpbmdz
OiBtZmQ6IHJ6LW10dTM6DQo+IERvY3VtZW50DQo+ID4gPiA+ID4gUlovRzJMIE1UVTMgUFdNDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBPbiBUaHUsIDI5IFNlcCAyMDIyLCBCaWp1IERhcyB3cm90ZToN
Cj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gSGkgTGVlIEpvbmVzLA0KPiA+ID4gPiA+ID4NCj4gPiA+
ID4gPiA+IFRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+
ID4gU3ViamVjdDogUmU6IFtQQVRDSCBSRkMgMy83XSBkdC1iaW5kaW5nczogbWZkOiByei1tdHUz
Og0KPiA+ID4gRG9jdW1lbnQNCj4gPiA+ID4gPiA+ID4gUlovRzJMIE1UVTMgUFdNDQo+ID4gPiA+
ID4gPiA+DQo+ID4gPiA+ID4gPiA+IE9uIFRodSwgMjkgU2VwIDIwMjIsIEJpanUgRGFzIHdyb3Rl
Og0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+IERvY3VtZW50IFJaL0cyTCBNVFUzIFBX
TSBzdXBwb3J0LiBJdCBzdXBwb3J0cyBmb2xsb3dpbmcNCj4gPiA+ID4gPiA+ID4gPiBwd20NCj4g
PiA+ID4gPiBtb2Rlcy4NCj4gPiA+ID4gPiA+ID4gPiAJMSkgUFdNIG1vZGUgMQ0KPiA+ID4gPiA+
ID4gPiA+IAkyKSBQV00gbW9kZSAyDQo+ID4gPiA+ID4gPiA+ID4gCTMpIFJlc2V0LXN5bmNocm9u
aXplZCBQV00gbW9kZQ0KPiA+ID4gPiA+ID4gPiA+IAk0KSBDb21wbGVtZW50YXJ5IFBXTSBtb2Rl
IDEgKHRyYW5zZmVyIGF0IGNyZXN0KQ0KPiA+ID4gPiA+ID4gPiA+IAk1KSBDb21wbGVtZW50YXJ5
IFBXTSBtb2RlIDIgKHRyYW5zZmVyIGF0IHRyb3VnaCkNCj4gPiA+ID4gPiA+ID4gPiAJNikgQ29t
cGxlbWVudGFyeSBQV00gbW9kZSAzICh0cmFuc2ZlciBhdCBjcmVzdCBhbmQNCj4gPiA+ID4gPiA+
ID4gPiB0cm91Z2gpDQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+IFNob3VsZG4ndCBhbGwg
dGhpcyBnbyBpbiB0aGUgUFdNIGRyaXZlciBiaW5kaW5nPw0KPiA+ID4gPiA+ID4NCj4gPiA+ID4g
PiA+IExvb2tzIGxpa2UgYXQgdG9wIGxldmVsIE1UVTMgSVAgcHJvdmlkZXMgc2ltaWxhciBIVw0K
PiA+ID4gZnVuY3Rpb25hbGl0eQ0KPiA+ID4gPiA+IGxpa2UNCj4gPiA+ID4gPiA+IGJlbG93IGJp
bmRpbmcgWzFdLCB3aGVyZSB0aGVyZSBpcyBhIGNvcmUgTUZEIGRyaXZlciBhbmQgcHdtLA0KPiA+
ID4gPiA+ID4gY291bnRlciBhbmQgdGltZXIgYXMgY2hpbGQgZGV2aWNlcy4NCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IFByZXZpb3VzIG1pc3Rha2VzIGFyZSBub3QgZ29vZCByZWZlcmVuY2VzIGZvciB3
aGF0IHNob3VsZA0KPiBoYXBwZW4NCj4gPiA+IGluDQo+ID4gPiA+ID4gdGhlIHByZXNlbnQgYW5k
IHRoZSBmdXR1cmUuID07KQ0KPiA+ID4gPg0KPiA+ID4gPiBXaHkgZG8geW91IHRoaW5rIHRoYXQg
cmVmZXJlbmNlIGlzIG5vdCBhIGdvb2Qgb25lPyBJIGJlbGlldmUNCj4gdGhlcmUNCj4gPiA+ID4g
c2hvdWxkIGJlIHNvbWUgcmVhc29uIGZvciBpdC4NCj4gPiA+DQo+ID4gPiBJIGRpZG4ndCBldmVu
IGxvb2sgYXQgaXQuDQo+ID4gPg0KPiA+ID4gV2hhdCBJICJiZWxpZXZlIiBpcyB0aGF0IGRvY3Vt
ZW50YXRpb24gZm9yIGVhY2ggZnVuY3Rpb25hbGl0eQ0KPiA+ID4gYmVsb25naW5nIHRvIGEgcGFy
dGljdWxhciBzdWJzeXN0ZW0gc2hvdWxkIGxpdmUgaW4gc3Vic3lzdGVtJ3MNCj4gPiA+IGFzc29j
aWF0ZWQgZG9jdW1lbnRhdGlvbiBkaXJlY3RvcnkgYW5kIGJlIHJldmlld2VkL21haW50YWluZWQg
YnkNCj4gPiA+IHRoYXQgc3Vic3lzdGVtJ3MgYXNzb2NpYXRlZCBtYWludGFpbmVyLg0KPiA+DQo+
ID4gSWYgSSBhbSBjb3JyZWN0LCBNRkQgaXMgc3Vic3lzdGVtIGZvciBjYWxsaW5nIHNoYXJlZCBy
ZXNvdXJjZXMNCj4gYWNyb3NzDQo+ID4gc3Vic3lzdGVtcy4NCj4gPg0KPiA+IEhlcmUgc2hhcmVk
IHJlc291cmNlcyBhcmUgY2hhbm5lbHMgd2hpY2ggaXMgc2hhcmVkIGJ5IHRpbWVyLCBjb3VudGVy
DQo+ID4gYW5kIHB3bQ0KPiANCj4gV2hpY2ggQVBJIGRvIHRoZSBjb25zdW1lcnMgdXNlIHRvIG9i
dGFpbiB0aGVzZSBzaGFyZWQgcmVzb3VyY2VzPw0KDQpUaGV5IG5lZWQgdG8gdXNlIE1GRCBkcml2
ZXIgQVBJIHRvIGdldCBzaGFyZWQgcmVzb3VyY2VzLg0KDQo+IA0KPiA+IFRoZXkgYXJlIGNoaWxk
IG9iamVjdHMgb2YgTUZEIHN1YnN5c3RlbXMuIFRoYXQgaXMgdGhlIHJlYXNvbiBpdCBpcw0KPiBp
biBNRkRuZGluZ3MuDQo+IA0KPiBJZiB0aGUgcHJvcGVydGllcyBiZWxvbmcgdG8gdGhlIGNoaWxk
LCB0aGV5IHNob3VsZCBiZSBkb2N1bWVudGVkIGluDQo+IHRoZSBjaGlsZCdzIGJpbmRpbmdzLiAg
U2hvdmluZyBhbGwgZnVuY3Rpb25hbGl0eSBhbmQgYnkgZXh0ZW5zaW9uIGFsbA0KPiBkb2N1bWVu
dGF0aW9uIGludG8gdGhlIE1GRCBkcml2ZXIgYW5kL29yIGJpbmRpbmcgaXMgaW5jb3JyZWN0DQo+
IGJlaGF2aW91ci4NCg0KRG8geW91IGhhdmUgYW4gZXhhbXBsZSwgaG93IHdpbGwgaXQgbG9vayBs
aWtlLCBpZiB0aGUgYmVsb3cgYmluZGluZyB0byBiZSBwYXJ0IG9mDQpwd20gYW5kIGxpbmtlZCBh
Z2FpbnN0IHRoZSBwYXJlbnQgTUZEIGRyaXZlcj8NCg0KDQorICAiXnB3bUAoWzAtNF18WzYtN10p
KyQiOg0KKyAgICB0eXBlOiBvYmplY3QNCisNCisgICAgcHJvcGVydGllczoNCisgICAgICBjb21w
YXRpYmxlOg0KKyAgICAgICAgY29uc3Q6IHJlbmVzYXMscnotbXR1My1wd20NCisNCisgICAgICBy
ZWc6DQorICAgICAgICBkZXNjcmlwdGlvbjogSWRlbnRpZnkgcHdtIGNoYW5uZWxzLg0KKyAgICAg
ICAgaXRlbXM6DQorICAgICAgICAgIGVudW06IFsgMCwgMSwgMiwgMywgNCwgNiwgNyBdDQorDQor
ICAgICAgIiNwd20tY2VsbHMiOg0KKyAgICAgICAgY29uc3Q6IDINCisNCisgICAgICByZW5lc2Fz
LHB3bS1tb2RlMToNCisgICAgICAgIHR5cGU6IGJvb2xlYW4NCisgICAgICAgIGRlc2NyaXB0aW9u
OiBFbmFibGUgUFdNIG1vZGUgMS4NCisNCisgICAgICByZW5lc2FzLHB3bS1tb2RlMjoNCisgICAg
ICAgIHR5cGU6IGJvb2xlYW4NCisgICAgICAgIGRlc2NyaXB0aW9uOiBFbmFibGUgUFdNIG1vZGUg
Mi4NCisNCisgICAgICByZW5lc2FzLHJlc2V0LXN5bmNocm9uaXplZC1wd20tbW9kZToNCisgICAg
ICAgIHR5cGU6IGJvb2xlYW4NCisgICAgICAgIGRlc2NyaXB0aW9uOiBFbmFibGUgUmVzZXQtc3lu
Y2hyb25pemVkIFBXTSBtb2RlLg0KKw0KKyAgICAgIHJlbmVzYXMsY29tcGxlbWVudGFyeS1wd20t
bW9kZTE6DQorICAgICAgICB0eXBlOiBib29sZWFuDQorICAgICAgICBkZXNjcmlwdGlvbjogQ29t
cGxlbWVudGFyeSBQV00gbW9kZSAxICh0cmFuc2ZlciBhdCBjcmVzdCkuDQorDQorICAgICAgcmVu
ZXNhcyxjb21wbGVtZW50YXJ5LXB3bS1tb2RlMjoNCisgICAgICAgIHR5cGU6IGJvb2xlYW4NCisg
ICAgICAgIGRlc2NyaXB0aW9uOiBDb21wbGVtZW50YXJ5IFBXTSBtb2RlIDIgKHRyYW5zZmVyIGF0
IHRyb3VnaCkuDQorDQorICAgICAgcmVuZXNhcyxjb21wbGVtZW50YXJ5LXB3bS1tb2RlMzoNCisg
ICAgICAgIHR5cGU6IGJvb2xlYW4NCisgICAgICAgIGRlc2NyaXB0aW9uOiBDb21wbGVtZW50YXJ5
IFBXTSBtb2RlIDMgKHRyYW5zZmVyIGF0IGNyZXN0IGFuZCB0cm91Z2gpLg0KKw0KKyAgICByZXF1
aXJlZDoNCisgICAgICAtIGNvbXBhdGlibGUNCisgICAgICAtIHJlZw0KKyAgICAgIC0gIiNwd20t
Y2VsbHMiDQorDQoNCmV4YW1wbGVzOg0KKyAgICAgIHB3bUAzIHsNCisgICAgICAgIGNvbXBhdGli
bGUgPSAicmVuZXNhcyxyei1tdHUzLXB3bSI7DQorICAgICAgICByZWcgPSA8Mz47DQorICAgICAg
ICAjcHdtLWNlbGxzID0gPDI+Ow0KKyAgICAgICAgcmVuZXNhcyxwd20tbW9kZTE7DQorICAgICAg
fTsNCiAgICAgfTsNCg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gDQo+IExvb2tpbmcgYXQgaXQgZnJv
bSBhbm90aGVyIHBlcnNwZWN0aXZlLCBJIGNhbm5vdC9zaG91bGQgbm90IHJldmlldw0KPiBQV00s
IFJlc2V0LCBDb3VudGVyIG9yIFRpbWVyIGJpbmRpbmdzLCBzaW5jZSBJIGRvIG5vdCBoYXZlIHRo
ZSBsZXZlbA0KPiBvZiBzdWJqZWN0IGFyZWEga25vd2xlZGdlIGFzIHRoZSBhc3NpZ25lZCBtYWlu
dGFpbmVycyBkby4NCj4gDQo+IFBsZWFzZSBwbGFjZSBhbGwgc3ViLXN5c3RlbSBzcGVjaWZpYyBi
aW5kaW5ncyBpbiB0aGVpciBjb3JyZWN0IChsZWFmKQ0KPiBiaW5kaW5ncyBhbmQgbGluayB0byB0
aGVtIGZyb20gdGhpcyBvbmUgKHJ1biB0aGlzKToNCj4gDQo+ICAgZ2l0IGdyZXAgXCRyZWYgLS0g
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC8NCj4gDQo+IC0tDQo+IExlZSBK
b25lcyBb5p2O55C85pavXQ0K
